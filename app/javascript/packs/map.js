(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key,
  v: "weekly",
});

let map;

async function initMap() {
  const myLatLng = { lat: 35.681236, lng: 139.767125 };
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker")

  map = new Map(document.getElementById("map"), {
    center: myLatLng,
    zoom: 15,
    mapId: "593d758e31ac8c1b",
  });

  try{
    const response = await fetch('/maps.json');
    if (!response.ok) throw new Error('ネットワーク応答が正常ではありません');

    const { items } = await response.json();
    if (!Array.isArray(items)) throw new Error('JSONデータが配列ではありません');

    // 投稿を町名（town）ごとにグループ化
    const groupedByTown = items.reduce((acc, item) => {
      const town = item.town; // town が空の場合に "未指定" を設定
      if (!acc[town]) {
        acc[town] = [];
      }
      // townキーに該当する配列に投稿を追加
      acc[town].push(item);
      return acc;
    }, {});

    Object.entries(groupedByTown).forEach(([town, posts]) => {
      if (posts.length === 0) return;
      const { latitude, longitude } = posts[0]; // 最初の投稿の位置をマーカー位置とする

      // マーカーを生成
      const marker = new google.maps.marker.AdvancedMarkerElement({
        position: { lat: latitude, lng: longitude },
        map,
        title: town,
      });

      // 投稿一覧を情報ウィンドウに表示
      const contentString = `
        <div class="container mt-3">
          <div class="row d-flex justify-content-center">
            <h5>${town}の投稿一覧</h5>
          </div>
        </div>
        ${posts
          .map((post) => {
          const postPath = post.postPath;
          const title = post.title;
          const content = post.content;
          const fullAddress = post.fullAddress;
          const createdAt = post.createdAt;
            return `
            <div class="container mt-3">
              <div class="row">
              <div class="col">
                <div class="card mb-4">
                <div class="card-header">
                  <strong class="ml-3"><a href="${postPath}" class="text-dark">${title}</a></strong>
                </div>
                <div class="card-body">
                  <p class="card-text">${content}</p>
                </div>
                <div class="card-footer text-muted d-flex justify-content-between">
                  <span>${createdAt}</span>
                  <span>${fullAddress}</span>
                </div>
                </div>
              </div>
              </div>
            </div>
            `;
        })
        .join("")}
      `;

      const infowindow = new google.maps.InfoWindow({
        content: contentString,
        ariaLabel: town,
      });

      // マーカークリック時に情報ウィンドウを表示
      marker.addListener("click", () => {
        infowindow.open({
          anchor: marker,
          map,
        });
      });
    });

    // items.forEach( item => {
    //   const latitude = item.latitude;
    //   const longitude = item.longitude;
    //   const postPath = item.postPath;
    //   const title = item.title;
    //   const content = item.content;
    //   const category = item.category;
    //   const categoryValue = item.categoryValue;
    //   const price = item.price;
    //   const timing = item.timing;
    //   const fullAddress = item.fullAddress;
    //   const userName = item.user.name;
    //   const userImage = item.user.image;
    //   const createdAt = item.createdAt;
    //   const marker = new google.maps.marker.AdvancedMarkerElement({
    //     position: { lat: latitude, lng: longitude },
    //     map,
    //     title: title,
    //   });

    //   const contentString = `

    //   <div class="container mt-3">
    //     <div class="row">
    //       <div class="col">
    //         <div class="card mb-4">
    //           <div class="card-header">
    //             <span class="category-item d-inline-block text-center" data-category="${categoryValue}">
    //               ${category}
    //             </span>
    //             <strong class="ml-3"><a href="${postPath}" class="text-dark">${title}</a></strong>
    //           </div>
    //           <div class="card-body">
    //             <p class="card-text">${content}</p>
    //           </div>
    //           <div class="card-footer text-muted">
    //             <span class="mr-3">${createdAt}</span>
    //             <span>${fullAddress}</span>
    //           </div>
    //         </div>
    //       </div>
    //     </div>
    //   </div>
      
    //   `;

    //   const infowindow = new google.maps.InfoWindow({
    //     content: contentString,
    //     ariaLabel: title,
    //   });

    //   marker.addListener("click", () => {
    //       infowindow.open({
    //       anchor: marker,
    //       map,
    //     })
    //   });
    // });
  } catch (error) {
      console.error('投稿画像の取得または処理中にエラーが発生しました:', error);
  }
}

initMap();