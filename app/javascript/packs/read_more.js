function readMore(blog_post) {

  if(blog_post.length > 100) {

    return blog_post.substr(0,99) + " ...";
  } else {

    return blog_post;
  }
}

window.readMore = readMore;