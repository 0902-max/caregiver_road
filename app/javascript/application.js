// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import { Calendar } from 'fullcalendar';  // もしくは 'fullcalendar/main'
import 'fullcalendar/main.css';

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  var calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
    // 他のオプションを追加できます
  });
  calendar.render();
});

//= require jquery
//= require moment
//= require fullcalendar
//= require_tree