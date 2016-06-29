# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TypeLetter.create(direction: "1", service_number: "1", name: "Обычное письмо" );
TypeLetter.create(direction: "1", service_number: "2", name: "Запрос" );
TypeLetter.create(direction: "1", service_number: "8", name: "Письмо об обновлении ИТ продуктов" );
TypeLetter.create(direction: "1", service_number: "9", name: "Копии приказов" );
TypeLetter.create(direction: "2", service_number: "51", name: "Письмо в ЦБ" );
TypeLetter.create(direction: "2", service_number: "52", name: "Ответ на письмо ЦБ" );
TypeLetter.create(direction: "2", service_number: "58", name: "Курсы" );

CbMail.create(email: "35svc_svkkey@ext-gate.svk.krym.cbr.ru", path_to_out: "/home/alkp/post/35svc_svkkey");
CbMail.create(email: "35svc_svkobn@ext-gate.svk.krym.cbr.ru", path_to_out: "/home/alkp/post/35svc_svkobn");
CbMail.create(email: "35svc_svkopsr@ext-gate.svk.krym.cbr.ru", path_to_out: "/home/alkp/post/35svc_svkopsr");
CbMail.create(email: "35svc_svksimferopol@ext-gate.svk.krym.cbr.ru", path_to_out: "/home/alkp/post/35svc_svksimferopol");
CbMail.create(email: "35svc_svkspo@ext-gate.svk.krym.cbr.ru", path_to_out: "/home/alkp/post/35svc_svkspo");
CbMail.create(email: "35svc_svkval@ext-gate.svk.krym.cbr.ru", path_to_out: "/home/alkp/post/35svc_svkval");