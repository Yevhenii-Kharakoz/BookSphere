document.addEventListener("DOMContentLoaded", function() {
    const maxTitleChars = 100; // Максимальное количество символов для названия
    const maxDescrChars = 500; // Максимальное количество символов для описания

    const titleInput = document.getElementById("book_title");
    const titleCharCount = document.getElementById("title_char_count");

    const descrInput = document.getElementById("book_descr");
    const descrCharCount = document.getElementById("descr_char_count");

    function updateCharCount(input, charCount, maxChars) {
        const chars = input.value.length;
        charCount.textContent = `${chars}/${maxChars} символів`;
        if (chars > maxChars) {
            input.value = input.value.slice(0, maxChars);
        }
    }

    titleInput.addEventListener("input", () => updateCharCount(titleInput, titleCharCount, maxTitleChars));
    descrInput.addEventListener("input", () => updateCharCount(descrInput, descrCharCount, maxDescrChars));

    // Инициализация счетчиков символов при загрузке страницы
    updateCharCount(titleInput, titleCharCount, maxTitleChars);
    updateCharCount(descrInput, descrCharCount, maxDescrChars);
});
