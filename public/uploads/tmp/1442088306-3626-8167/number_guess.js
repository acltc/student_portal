
<script>
var i = 1;
var guess = "";
var random = Math.floor((Math.random() * 10) + 1);
console.log(random)
do {
var guess = parseInt(prompt("Guess a number"));
console.log(guess)

if (guess === random)
{
console.log("Your guess is correct!");
break;
}
else if (guess > random)
{
  console.log("Your guess is to high.");
  i++;
} 
else (guess < random)
{
  console.log("Your guess is to low.");
  i++;
}
}
while (i < 11);
</script>