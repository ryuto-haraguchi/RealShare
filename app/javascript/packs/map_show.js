(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})({
  key: process.env.Maps_API_Key,
  v: "weekly",
});

let map;

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const { AdvancedMarkerElement } = await google.maps.importLibrary("marker")

  try{
    const postId = document.getElementById("map-show").dataset.postId;
    const response = await fetch(`/posts/${postId}.json`);
    if (!response.ok) throw new Error('ネットワーク応答が正常ではありません');

    const { item } = await response.json();
    console.log(item);
    const latitude = item.latitude;
    const longitude = item.longitude;
    console.log(latitude, longitude);

    map = new Map(document.getElementById("map-show"), {
      center: { lat: latitude, lng: longitude },
      zoom: 15,
      mapId: "593d758e31ac8c1b",
    });  

    // マーカーを生成
    const marker = new google.maps.marker.AdvancedMarkerElement({
      position: { lat: latitude, lng: longitude },
      map,
    });

  } catch (error) {
      console.error('投稿画像の取得または処理中にエラーが発生しました:', error);
  }
}

initMap();