const handleImageChange = (offset) => {
    const activeSlide = document.querySelector("[data-active]")
    const slides = [...document.querySelectorAll(".slide")]
    const currentIndex = slides.indexOf(activeSlide)
    let newIndex = currentIndex + offset;

    if (newIndex < 0) newIndex = slides.length - 1
    if (newIndex >= slides.length) newIndex = 0
    console.log(slides)
    slides[newIndex].dataset.active = true;
    delete activeSlide.dataset.active
}

const onNext = () => handleImageChange(1)
const onPrev = () => handleImageChange(-1)

function copyText() {
    var stringToParse = document.getElementById("textToCopy").textContent;

    var matches = stringToParse.match(/Код товара: (\d+)/);
    if (matches && matches.length > 1) {
        var productId = matches[1];

        var url = `localhost:4000/${productId}`;

        navigator.clipboard.writeText(url).then(function () {
            alert(`Ссылка скопирована: ${url}`);
        }, function (err) {
            console.error(`Ошибка при копировании ссылки: ${err}`);
        });
    } else {
        console.error("Не удалось извлечь код товара из строки.");
    }
}
