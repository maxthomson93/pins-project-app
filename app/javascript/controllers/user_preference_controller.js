import { Controller } from "@hotwired/stimulus"
// import '${jQuery}';
import '../3dTagCloud.js';

// Connects to data-controller="user-preference"
export default class extends Controller {
  static values = { tags: Array }
  connect() {
    console.log("UserPreferenceController connected")
    const entries = this.tagsValue.map(tag => ({
      label: tag,
      url: '#',
      target: '_top'}));

    const settings = {
      entries: entries,
      width: 360,
      height: 360,
      radius: '65%',
      radiusMin: 75,
      bgDraw: true,
      bgColor: 'none',
      opacityOver: 1.00,
      opacityOut: 0.05,
      opacitySpeed: 6,
      fov: 800,
      speed: 0.5,
      fontFamily: 'Oswald, Arial, sans-serif',
      fontSize: '15',
      fontColor: '#52946B',
      fontWeight: 'bold',//bold
      fontStyle: 'normal',//italic 
      fontStretch: 'normal',//wider, narrower, ultra-condensed, extra-condensed, condensed, semi-condensed, semi-expanded, expanded, extra-expanded, ultra-expanded
      fontToUpperCase: true,
      tooltipFontFamily: 'Oswald, Arial, sans-serif',
      tooltipFontSize: '11',
      tooltipFontColor: '#fff',
      tooltipFontWeight: 'normal',//bold
      tooltipFontStyle: 'normal',//italic 
      tooltipFontStretch: 'normal',//wider, narrower, ultra-condensed, extra-condensed, condensed, semi-condensed, semi-expanded, expanded, extra-expanded, ultra-expanded
      tooltipFontToUpperCase: false,
      tooltipTextAnchor: 'left',
      tooltipDiffX: 0,
      tooltipDiffY: 10,
      animatingSpeed: 0.1,
      animatingRadiusLimit: 1.3
    };
      
    $('#tag-cloud').svg3DTagCloud(settings);

    $('#tag-cloud').on('click', 'a', (event) => {
      event.preventDefault();
      const tag = event.currentTarget.textContent;
      this.addTag(tag);
      this.updateHiddenField();
    });
  }

  addTag(tag) {
    const badgeContainer = document.querySelector('#selected-tags');
    if ([...badgeContainer.children].some(badge => badge.dataset.value === tag)) return;

      const badge = document.createElement("span");
      badge.className = "badge-bg-primary rounded-pill p-1 me-2 text-center text-white";
      badge.style.fontSize = "1em";
      badge.textContent = tag;
      badge.dataset.value = tag;
      badge.style.backgroundColor = "#52946B";
      badgeContainer.appendChild(badge);

      const deleteBtn = document.createElement("button");
      deleteBtn.type = "button";
      deleteBtn.className = "btn-close btn-close-white ms-2";
      deleteBtn.style.fontSize = "0.7em";
      badge.appendChild(deleteBtn);
      deleteBtn.addEventListener("click", (e) => {
        badge.remove();
        this.updateHiddenField();
      });
    }

    updateHiddenField() {
      const badgeContainer = document.querySelector('#selected-tags');
      const tags = [...badgeContainer.children].map(badge => badge.dataset.value);
      document.getElementById('user_tag_list').value = tags.join(',');
    }
}
