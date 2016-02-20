# Methods for Like perfume specs

def after_like_css
  'div.perfume__loveit.loved'
end

def like_perfume(id)
  find(:id, "perfume_#{id}").find('div.perfume__loveit').click
end

def like_perfumes(ids)
  ids.each{ |id| like_perfume(id) }
end

def no_likes?
  page.has_no_css?(after_like_css)
end

def count_likes?(x)
  page.has_css?(after_like_css, count: x)
end

def reset_local_storage
  visit root_path
  # For some reason, if I just wipe out localStorage, gone is the JS too
  # This works, however it also exposes implementation
  script = "localStorage.setItem('PERFUMEFOREST:likedPerfumes', '[]')"
  page.execute_script(script)
end
