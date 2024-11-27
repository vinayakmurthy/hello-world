// Function called while clicking add button
function add_item() {

  // Getting box and ul by selecting id;
  let item = document.getElementById(&quot;box&quot;);
  let list_item = document.getElementById(&quot;list_item&quot;);
  if(item.value != &quot;&quot;){

      // Creating element and adding value to it
      let make_li = document.createElement(&quot;LI&quot;);
      make_li.appendChild(document.createTextNode(item.value));

      // Adding li to ul
      list_item.appendChild(make_li);

      // Reset the value of box
      item.value=&quot;&quot;
      
      // Delete a li item on click 
      make_li.onclick = function(){
        this.parentNode.removeChild(this);
      }

  }
  else{

    // Alert msg when value of box is &quot;&quot; empty.
    alert(&quot;plz add a value to item&quot;);
  }

}