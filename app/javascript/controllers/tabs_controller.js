import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "tab"];

  connect() {
    this.showContent(this.tabTargets.find(tab => tab.classList.contains('active')));
  }

  switch(event) {
    event.preventDefault();

    this.tabTargets.forEach(tab => tab.classList.remove("active"));
    event.currentTarget.classList.add("active");

    this.showContent(event.currentTarget);
  }

  showContent(activeTab) {
    const targetId = activeTab.getAttribute("data-target-id");
    console.log(activeTab);
    this.contentTargets.forEach(content => {
      if (content.id === targetId) {
        content.style.display = "block";
      } else {
        content.style.display = "none";
      }
    });
  }
}
