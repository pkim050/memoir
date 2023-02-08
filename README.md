# README

Hello Anika and Uche. I basically created a Rails app and installed devise to imitate of what I saw from the interview yesterday. I wanted to go back to the issue and try and resolve it.

I obviously did not perform anywhere near to anyone's standards and somehow lost track of time. I want to go ahead and showcase that I can do what was asked for. Just for simplicity, I went ahead and created posts instead of journal entries and we are going to assume posts are the journal entries.

Issue #1
After creating a post, all other users that are not associated with this specific post can still see them, through index and show page. How do we make it so that they are able to see only their own private posts?
We ran into a problem where in the index html file, @posts was nil after the change of having:
def show
    @post = Post.find(params[:id])
    if current_user && curent_user.id == @post.user.id
      @post
    else
      render :index
    end
end

It was not exactly what I did yesterday but this is basically the correct way of making sure that the current user is logged in and if the post that belongs to a user is the same user by checking it's key.
I believe I was and am getting this error due to the index render. It is calling the index.html.erb, therefore there is no such thing as @posts.
So I added @posts = current_user.posts just above render :index including alerts to output that the post of id was not found and it would redirect correctly to the index page.

Another issue, what if the non owners tries to forcefully edit someone else post? We have to fix that issue too. Same code can be ran from show method.

There were a bunch of changes I made in the routing section, which also involved more changes in partial form and all the URL routings. I'm not sure if the other problems (B, C, and D) were going to go through these.
I also made sure in the index page, that only the posts under the user is shown and no one elses.

Please note that I created a separate branch off of master, this way, you can see the changes in the logs and see the differences of what I did by going to the branch locally. There should only be 1 PR.
Master should have a functioning app that allows all users to see all posts while the other branch fixes them where posts become private to their respective owner.

If there is still a chance for me to be your teammate for this position, please let me know what else I can do to help alleviate the shipwreck I have caused yesterday. Perhaps linking me to your private repository and asking me to finish the rest of the issues?

Either way, no matter how badly the performance was, I appreciate all your time and getting to a little about me and it was nice to see you both. I got nothing but great vibes from the both of you.
I loved how you spoke about how your product works Anika, it seemed like you really care and believe in the product that you work on. That is something I admire and would love to have teammates who view the same way as I do.

Thank you,
Patrick Kim
