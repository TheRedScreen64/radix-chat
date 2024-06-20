let question_inp, description_inp, resource_inp;
let confirmation_backdrop, confirmation_container;
let topics, topic_list;
let currentTopicId;

async function setupTopics() {
    question_inp = document.getElementById("question");
    description_inp = document.getElementById("desc");
   //  resource_inp = document.getElementById("rescource");

    confirmation_backdrop = document.querySelector(".proposal-confirmation-backdrop");
    confirmation_container = document.querySelector(".proposal-confirmation-wrap");

    /* list existing topics */
    topics = await api_getTopics();
    topic_list = document.querySelector(".topic-list");
    topic_list.innerHTML = ""
    topics.forEach(topic => {
        let li = document.createElement("li")
        let container = document.createElement("div")
        container.className = "top"
        let span = document.createElement("span")
        span.innerText = topic.title
        let md_converter = new showdown.Converter();
        let content = md_converter.makeHtml(topic.description);
        let desc = document.createElement("div")
        desc.className = "desc"
        desc.innerHTML = content
        let button = document.createElement("button")
        button.addEventListener("click", () => { voteTopic(topic.id) })
        button.innerText = `Vote (${topic.votes})`
        container.appendChild(span)
        container.appendChild(button)
        let hr = document.createElement("hr")
        li.appendChild(container)
        li.appendChild(desc)
        topic_list.appendChild(li)
        if (topics.indexOf(topic) < (topics.length - 1)) {
         topic_list.appendChild(hr)
        }
    });

    /* display today's topic */
    let todays_topic = await api_getTopic();
    console.log(todays_topic)
    let title = todays_topic["title"];
    if (title != undefined) {
        document.getElementById("topic-title").innerHTML = todays_topic["title"];
        let truncatedText = todays_topic["description"].substring(0, 100) + "..."
        const textElement = document.getElementById("topic-desc")
        let readMore = document.createElement("a")
        if (todays_topic["description"].length > 100) {
          textElement.innerHTML = truncatedText;
          textElement.classList.add('shortened');
        } else {
          textElement.innerHTML = todays_topic["description"];
          readMore.style.display = 'none';
        }
     
        readMore.addEventListener("click", () => {
         if (textElement.innerText === truncatedText) {
            textElement.innerText = todays_topic["description"];
            textElement.classList.remove('shortened');
            readMore.innerText = 'Read Less';
          } else {
            textElement.innerText = truncatedText;
            textElement.classList.add('shortened');
            readMore.innerText = 'Read More';
          }
        })
        readMore.innerText = "Read More"
        document.getElementById("chat-header").appendChild(readMore)
    } else {
      document.getElementById("topic-title").innerHTML = "Fun Chat";
      document.getElementById("topic-desc").innerHTML = "Talk about things which are currently occupying you.";
    }
    
}

// function displayRandomTopic() {
//     let topic = topics[Math.floor(Math.random()*topics.length)];
//     currentTopicId = topic["id"];

//     topic_list.innerHTML = `<div class="topic"><p><strong>${topic["title"]}</strong> (Votes: <strong>${topic["votes"]}</strong>)<br>
//         ${topic["description"]}</p></div>`;
//     console.log("topics:" + JSON.stringify(topics));
// }

function submitTopic() {
    if (question_inp.value.length < 5) {
        sendMsgSteve("Ask a question.");
        return;
    }
    else if (description_inp.value.length < 10) {
        sendMsgSteve("Give a description.");
        return;
    }
   //  else if (resource_inp.value == "") {
   //      sendMsgSteve("Please add an resource you refer to.");
   //      return;
   //  }

    if (question_inp.value.length > 53) {
        sendMsgSteve("Please ensure that your question contains less than 50 characters.");
        return;
    }
    else if (description_inp.value.length > 205) {
        sendMsgSteve("Please ensure that your question contains less than 200 characters.");
        return;
    }
   //  else if (!/^(https?:\/\/)?([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}(:\d+)?(\/[^\s]*)?$/.test(resource_inp.value)) {
   //      sendMsgSteve("Please use an valid resource url.");
   //      return;
   //  }

    /* ask for confirmation */
    confirmation_backdrop.style.display = "flex";
    confirmation_backdrop.style.backdropFilter = "blur(8px)";

    confirmation_container.style.opacity = "1";
    confirmation_container.style.display = "block";
    confirmation_container.style.zIndex = "3";

    document.getElementById("proposal-recap").innerHTML = `<strong>${question_inp.value}</strong><br>${description_inp.value})`
}

function cancelProposal() {
    confirmation_backdrop.style.display = "none";
    confirmation_backdrop.style.backdropFilter = "none";

    confirmation_container.style.opacity = "0";
    confirmation_container.style.display = "none";
    confirmation_container.style.zIndex = "-1";
}

async function makeProposal() {
    /* hide window */
    confirmation_backdrop.style.display = "none";
    confirmation_backdrop.style.backdropFilter = "none";

    confirmation_container.style.opacity = "0";
    confirmation_container.style.display = "none";
    confirmation_container.style.zIndex = "-1";

    let status = await api_suggest_topic(question_inp.value, `${description_inp.value}`);
    if (status) {
        sendMsgSteve(`Successfully proposed your topic`);
    }
    else {
        sendMsgSteve(`You have already suggested a topic today`);
    }

    setupTopics()
}

async function voteTopic(topicId) {
   let status = await api_voteTopic(topicId);
   if (status) {
      sendMsgSteve(`Successfully voted for topic`);
  }
  else {
      sendMsgSteve(`You have already voted for this topic`);
  }

  setupTopics()
}