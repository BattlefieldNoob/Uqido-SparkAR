import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:uqido_sparkar/db/abstract_db.dart';
import 'package:uqido_sparkar/model/sparkar_user.dart';
import 'package:webcrypto/webcrypto.dart';

class SparkARDB with DBCache implements AbstractDB {
  static const String FAKE_DATA =
      '[{"id":"100028894845840","name":"Uqido pollo XR","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t1.0-1/cp0/p32x32/60090368_201127367527090_394640518782386176_o.jpg?_nc_cat=111&ccb=1-3&_nc_sid=7206a8&_nc_ohc=ucBdlZFtiUkAX-cQlKk&_nc_ht=scontent-iad3-1.xx&tp=27&oh=d614bfb40272de218dbe560cb608d2bd&oe=6069391D","effects":[{"id":"2527888967522144","name":"UQIDO VTO Make Up","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/101027806_1036594540142506_311477938908299264_n.png?_nc_cat=101&ccb=1-3&_nc_sid=df6b83&_nc_ohc=V7obxsxx5CwAX_JecQJ&_nc_ht=scontent-iad3-1.xx&oh=9e37285f06b67166d15bee6ee816caa2&oe=60680CE4","visibilityStatus":"NOT_VISIBLE","submissionStatus":"NOT_APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/2527888967522144/?ch=MjE2MjdjYjcxMmQ2N2U0MDEzNTcwYWM3YjRlYWQ4ZDU%3D","publicLink":"https://www.instagram.com/ar/2527888967522144/"},{"id":"1380362072163096","name":"UQIDO VTO Make Up","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/101384342_911789716004067_1379788750992703488_n.png?_nc_cat=110&ccb=1-3&_nc_sid=df6b83&_nc_ohc=Mv8j-m1wc7UAX-5AW3E&_nc_ht=scontent-iad3-1.xx&oh=7f3b6bb92cb9fbce279314a7138fa656&oe=606B203D","visibilityStatus":"NOT_VISIBLE","submissionStatus":"NOT_APPROVED","isDeprecated":false,"testLink":"https://www.facebook.com/fbcameraeffects/testit/1380362072163096/YjE2ZDE3N2NmMTYyYjM5ODQ0NTVhM2UwZWMxM2ViZjY=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/1380362072163096/"},{"id":"1284804145059231","name":"AR Shoe","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/88142915_645216969612963_52427046579601408_n.png?_nc_cat=109&ccb=1-3&_nc_sid=df6b83&_nc_ohc=IkFJ96kVBhgAX-Yp8HK&_nc_ht=scontent-iad3-1.xx&oh=c800643814b7644cdc4ec826e4f7f113&oe=6067FD60","visibilityStatus":"VISIBLE","submissionStatus":"APPROVED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/1284804145059231/Njc4YWUzYTc0ZmRmNDk2MTg1MDM4ZjY3NjNiMDI5M2Q=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/1284804145059231/"}]},{"id":"161073737264211","name":"Uqido","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t1.0-1/cp0/p32x32/29570300_1695611473810422_2263473690201511650_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=1eb0c7&_nc_ohc=jVfHJGPOKpMAX_9ee-I&_nc_ht=scontent-iad3-1.xx&tp=27&oh=ccfd7bd08ae92a02a38dd248d5d0fa72&oe=606A48CF","effects":[{"id":"281228793332465","name":"Dancer","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/125433526_137563364400879_6419523467572389261_n.png?_nc_cat=103&ccb=1-3&_nc_sid=df6b83&_nc_ohc=GC7cKAKEweMAX9L0sgZ&_nc_ht=scontent-iad3-1.xx&oh=b9c9d6249f723ca20e7273788b2bd1ea&oe=6069B4E4","visibilityStatus":"VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.facebook.com/fbcameraeffects/testit/281228793332465/NTM1M2RkM2Y0MjkzZWZmZTViMmRkZTU1NTMzZTdlZjk=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/281228793332465/"},{"id":"1891246777657819","name":"ESA","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/45598028_309015373252669_7693093567455035392_n.png?_nc_cat=101&ccb=1-3&_nc_sid=df6b83&_nc_ohc=fTepBQ2d1goAX-MUybJ&_nc_ht=scontent-iad3-1.xx&oh=32ec980d9009a1373c1a336af37e64bc&oe=60677156","visibilityStatus":"VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/1891246777657819/ZjVhOTFkOWExYjc3MTVlZjUxYzI5OWYzNmExNmFlMTA=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/1891246777657819/"},{"id":"2311426908924213","name":"Nine Helmet Ski","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/65637706_378286086374876_8941586748756983808_n.png?_nc_cat=110&ccb=1-3&_nc_sid=df6b83&_nc_ohc=U0HT3FwCabUAX8uFlOh&_nc_ht=scontent-iad3-1.xx&oh=9699c084ed1212e513842b27fb612d12&oe=606A859D","visibilityStatus":"VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/2311426908924213/NjRjM2NlNGRhZGVmNTQ4MDkwNDg4NDE3YWNjZWUwZTY=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/2311426908924213/"},{"id":"2167310253321312","name":"TedX Treviso","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/46294717_1770825393046459_2698498063399387136_n.png?_nc_cat=107&ccb=1-3&_nc_sid=df6b83&_nc_ohc=sLaLieMG3J4AX_NAb21&_nc_ht=scontent-iad3-1.xx&oh=966f7588880db52e4905ff832d563432&oe=6067F654","visibilityStatus":"VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/2167310253321312/OTA3M2RmZjRmNzViZDI1N2U0MjMzNGRlMWIwYmE3Njk=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/2167310253321312/"},{"id":"315820269353062","name":"Hard Hat Helm","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/65877709_441220266699629_8564005582376271872_n.png?_nc_cat=105&ccb=1-3&_nc_sid=df6b83&_nc_ohc=kJZEZds66JgAX--X8rX&_nc_ht=scontent-iad3-1.xx&oh=4af76aa0418f29f952c4706101d84857&oe=606A9782","visibilityStatus":"VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/315820269353062/OTdmMTQyMGUyZTBlOTU2ZDU0ZGZlNWMyNDA5YzIzZmM=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/315820269353062/"},{"id":"684128175755553","name":"Demo Segmentation","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/98164033_639845036599097_309559256758091776_n.png?_nc_cat=110&ccb=1-3&_nc_sid=df6b83&_nc_ohc=orzfkZfQWbcAX-_jPUH&_nc_ht=scontent-iad3-1.xx&oh=46d928f4355055346d8ec709bb20afa4&oe=606A0F8C","visibilityStatus":"NOT_VISIBLE","submissionStatus":"NOT_APPROVED","isDeprecated":false,"testLink":"https://www.facebook.com/fbcameraeffects/testit/684128175755553/MzVlMDMzMTU3YTA2ZjQ1MWJlN2Y5M2U1MmZhY2Q5NTQ=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/684128175755553/"},{"id":"303611670250816","name":"WineAR","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/46775429_1964985260228386_5720094000942153728_n.png?_nc_cat=100&ccb=1-3&_nc_sid=df6b83&_nc_ohc=Q4Ir6DQ-YioAX8mbNKb&_nc_ht=scontent-iad3-1.xx&oh=d3c0441ed67962ea185cfbc5645e9dfe&oe=60688A9E","visibilityStatus":"VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/303611670250816/M2RlZTk5NTNiZWRjNmIwZTFkNjg0ZGY5OGM4Y2UzZmY=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/303611670250816/"},{"id":"266998703934915","name":"Venezia 1920","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/42500505_280460599456106_3829742163688685568_n.png?_nc_cat=104&ccb=1-3&_nc_sid=df6b83&_nc_ohc=teR-Tay25CsAX_42IsO&_nc_ht=scontent-iad3-1.xx&oh=a0a337cd8ae0750b400bafebcfb5fd69&oe=6067D895","visibilityStatus":"VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/266998703934915/ODk4OTAzOTFmMTQzZTVjODZiMDJkNGM5YzJiNWYwZDE=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/266998703934915/"},{"id":"414121925842221","name":"MAO Marco Polo","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/64450614_404030587119765_4686407540160856064_n.png?_nc_cat=103&ccb=1-3&_nc_sid=df6b83&_nc_ohc=BDGjorvygr8AX8Mj6VB&_nc_ht=scontent-iad3-1.xx&oh=51562085e2b2a616c8c849bbf4f3b67f&oe=6068754C","visibilityStatus":"NOT_VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/414121925842221/NDQ5M2VmODFhYTM1NGFiOWRlNmE0OTVjZGUyOGJmNmU=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/414121925842221/"},{"id":"451328412310221","name":"AGV Planet","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/65573094_375502473094318_7922360244565442560_n.png?_nc_cat=106&ccb=1-3&_nc_sid=df6b83&_nc_ohc=sogCCYHCSGkAX-I2cKs&_nc_ht=scontent-iad3-1.xx&oh=aed65ef5dc60a513ff981d259f0bfbde&oe=6069BE70","visibilityStatus":"VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/451328412310221/OTdlNzVlYWRmNzgzMzI5ZmQ1YzQyOTc1OTZmODM2NWQ=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/451328412310221/"},{"id":"1924394917647080","name":"Stefano Ricci Demo","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/41996848_254499675405444_2880303711211487232_n.png?_nc_cat=102&ccb=1-3&_nc_sid=df6b83&_nc_ohc=XokWNGa-H6IAX_NNl9K&_nc_ht=scontent-iad3-1.xx&oh=4089aaf80732e5b2a2c93709ba382a6a&oe=606B2FCC","visibilityStatus":"NOT_VISIBLE","submissionStatus":"NOT_APPROVED","isDeprecated":false,"testLink":"https://www.facebook.com/fbcameraeffects/testit/1924394917647080/NWZjM2EzN2U1MDE1MDk4NGNhNGMyMjNkMjVlODU2YmY=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/1924394917647080/"},{"id":"609533056208082","name":"Salomon Winter Sports","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/65583768_2492984744256125_7461290579012354048_n.png?_nc_cat=107&ccb=1-3&_nc_sid=df6b83&_nc_ohc=Uykfv3ycCOYAX8PEL0L&_nc_ht=scontent-iad3-1.xx&oh=309495d840044b1eecde900847c183be&oe=606AE168","visibilityStatus":"VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/609533056208082/MDUxMTFlOWVkZGJhMzg5MmYxYjQ0YmI1YzNlODkxMmM=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/609533056208082/"},{"id":"397126360865303","name":"PlanetIdea","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/55109433_2230998350498639_3820184869317640192_n.png?_nc_cat=111&ccb=1-3&_nc_sid=df6b83&_nc_ohc=giZbFPWFmVsAX_xJHdh&_nc_ht=scontent-iad3-1.xx&oh=1a59c6ee6219075af14b0cb24eafa340&oe=6067882F","visibilityStatus":"NOT_VISIBLE","submissionStatus":"NOT_APPROVED","isDeprecated":false,"testLink":"https://www.facebook.com/fbcameraeffects/testit/397126360865303/N2UzN2QyNTRiYmMyMTM4MGE5MTc4ZGRhMGIwNzAzYTA=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/397126360865303/"},{"id":"542684949588019","name":"RiedlAR","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/56712968_2113896195313927_1282426893273923584_n.png?_nc_cat=106&ccb=1-3&_nc_sid=df6b83&_nc_ohc=aPvQmXyPks8AX_Qb4fX&_nc_ht=scontent-iad3-1.xx&oh=1f75c41638e9e4d85588b031ec452fb1&oe=606AE6CB","visibilityStatus":"VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/542684949588019/MDlkNGE4ZmQxYWJjOGM0MTE0NmQ3OGQyMzVkYzhhODI=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/542684949588019/"},{"id":"532442770496126","name":"GlassesAR","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/53580255_1284113731742105_6593570154288775168_n.png?_nc_cat=103&ccb=1-3&_nc_sid=df6b83&_nc_ohc=O3RN5YHrvdIAX8I-8wx&_nc_ht=scontent-iad3-1.xx&oh=a6afcf6ce59a4cf15a9be43c4dc567b2&oe=6067950A","visibilityStatus":"VISIBLE","submissionStatus":"APPROVED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/532442770496126/ODY4MTIzNGI0ZjY5Y2E3MjdjYTM5ZGU1NzVlOTJmYWE=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/532442770496126/"},{"id":"667586447001662","name":"Kask Protone","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/65593040_443080409849709_7234452950720970752_n.png?_nc_cat=100&ccb=1-3&_nc_sid=df6b83&_nc_ohc=ZpKgLAlY6wkAX_HSnTg&_nc_oc=AQlyysdn5BJwLLrB21zpWl6q7t6wcRso0Yo8mF2_xEoC8CFUpRuBwlWKljTRyizM2WQ&_nc_ht=scontent-iad3-1.xx&oh=bed5a5cb588d1ffc62a15666cadce92c&oe=606A4D38","visibilityStatus":"VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/667586447001662/MGY0MWE1YzczM2NkOTQ3N2JhNjljZDhjMzNjZjRjNTQ=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/667586447001662/"},{"id":"2322858771314072","name":"Bicycle Helmet","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/65702725_409388089664909_3301142272074055680_n.png?_nc_cat=106&ccb=1-3&_nc_sid=df6b83&_nc_ohc=JD-6ALLoqUsAX8oPIFY&_nc_ht=scontent-iad3-1.xx&oh=170ac0b620dc8482be63500f6346df6a&oe=6069AA2F","visibilityStatus":"VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/2322858771314072/ODhkZmU0ODNjMzFhY2NiZWRjODhlOTAwNmNhODljNDI=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/2322858771314072/"},{"id":"2259318010950048","name":"SoccerballAR","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/56965117_409274586532936_5707238953371828224_n.png?_nc_cat=111&ccb=1-3&_nc_sid=df6b83&_nc_ohc=q9UFt9FMkr4AX_dRwZa&_nc_ht=scontent-iad3-1.xx&oh=25218451be95373e2de1d6ff2ac4a84b&oe=60686FA9","visibilityStatus":"VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/2259318010950048/MzBhOWY5YzYxNzBlMzBjN2E2NTJiYmFmNWVjOWRiMjI=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/2259318010950048/"},{"id":"485761188775342","name":"Flower Burger AR","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/84504110_808123243035054_8038179217432641536_n.png?_nc_cat=104&ccb=1-3&_nc_sid=df6b83&_nc_ohc=e8w8OxnKRGUAX9F_xGG&_nc_oc=AQm_D1ekTv-gRBxBkEmAHvq1mPg_PX_ymCi_BAYlzO3DsOwuuF1WnGEmHddGUKwDkJ8&_nc_ht=scontent-iad3-1.xx&oh=1faf8578b102e1aa3502172fe1c8e7db&oe=606A1233","visibilityStatus":"NOT_VISIBLE","submissionStatus":"NOT_REVIEWED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/485761188775342/?ch=YTMwZDlkOWQwMDE3YjMzY2Y4ZmY2NTE2OWU5ODFmMDQ%3D","publicLink":"https://www.instagram.com/ar/485761188775342/"},{"id":"1055567861481088","name":"Spicy Cecio AR","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/84394064_392500014943054_1142115126371942400_n.png?_nc_cat=102&ccb=1-3&_nc_sid=df6b83&_nc_ohc=pByVmIXxIIQAX8EHaru&_nc_ht=scontent-iad3-1.xx&oh=603f9e519e6bfb2ee33166903bb8621c&oe=606A50B3","visibilityStatus":"NOT_VISIBLE","submissionStatus":"NOT_REVIEWED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/1055567861481088/?ch=MGVmZDYxMzBkODc5Zjc4MDQ2ZDkwMTgyOTUxNzAwZjM%3D","publicLink":"https://www.instagram.com/ar/1055567861481088/"},{"id":"2253540908283113","name":"Cherry Bomb AR","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/84417236_130896751441730_5929184807186595840_n.png?_nc_cat=102&ccb=1-3&_nc_sid=df6b83&_nc_ohc=3eMAtiGSaG0AX-I669F&_nc_ht=scontent-iad3-1.xx&oh=d59fc73f55a63f909f9d203bf51e8107&oe=6069E558","visibilityStatus":"NOT_VISIBLE","submissionStatus":"NOT_REVIEWED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/2253540908283113/?ch=MGJiOTIwNzcyYjJjNzYwZTI0Y2ZlMzJjMWI4NGM4ZmI%3D","publicLink":"https://www.instagram.com/ar/2253540908283113/"}]},{"id":"685778868247271","name":"3Bee","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t1.0-1/cp0/p32x32/118094102_1713939292097885_8774171371030656197_n.png?_nc_cat=100&ccb=1-3&_nc_sid=1eb0c7&_nc_ohc=862WYKc8320AX_qvnSR&_nc_ht=scontent-iad3-1.xx&_nc_tp=30&oh=793fcb477fb0125e2bfa6d0f15d03744&oe=606A7859","effects":[{"id":"998639237286063","name":"3Bee Ape Acacia","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/125867610_311425949856113_892714577471961545_n.png?_nc_cat=109&ccb=1-3&_nc_sid=df6b83&_nc_ohc=SowuBoA_RsoAX9Wu8MV&_nc_ht=scontent-iad3-1.xx&oh=163002ac7cb179aaeadfbfa7346d8a42&oe=606A4C7C","visibilityStatus":"VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/998639237286063/?ch=M2M2ZDEwMWU5OWYyYjZiMGE4OGRlZWEzODY2ZGFiYzI%3D","publicLink":"https://www.instagram.com/ar/998639237286063/"}]},{"id":"670235443076053","name":"Campus Party","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t1.0-1/cp0/p32x32/89454076_2354615067971407_6843505004301516800_n.png?_nc_cat=107&ccb=1-3&_nc_sid=1eb0c7&_nc_ohc=aZzCYftaStMAX8CySlm&_nc_ht=scontent-iad3-1.xx&_nc_tp=30&oh=876b0d1210f40fc9a5285309a9394998&oe=606AA402","effects":[{"id":"1695944890550309","name":"Campus Party AR","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/67551527_467621017384988_1980369833472032768_n.png?_nc_cat=102&ccb=1-3&_nc_sid=df6b83&_nc_ohc=N2ZWr4gAVZ0AX-mFB6h&_nc_ht=scontent-iad3-1.xx&oh=09503a41832c0abf353c3087ea6f2a79&oe=6069D384","visibilityStatus":"VISIBLE","submissionStatus":"APPROVED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/1695944890550309/MzJmNjQ0ODVkZGE2NmIxYzE0OTY3MzVkYTUzM2ZhZGE=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/1695944890550309/"}]},{"id":"371251082931417","name":"DEMACLENKO - the future of snow","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t1.0-1/cp0/p32x32/81827871_2754214691301699_3547633116661153792_o.jpg?_nc_cat=104&ccb=1-3&_nc_sid=1eb0c7&_nc_ohc=9baxJVm4wSAAX8wxL35&_nc_ht=scontent-iad3-1.xx&tp=27&oh=380318bfb10914e348f8c69d2392af09&oe=606B4034","effects":[{"id":"3674481059240722","name":"Ventus X-Ray","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/122486052_2792619320970651_7168430211897627916_n.png?_nc_cat=106&ccb=1-3&_nc_sid=df6b83&_nc_ohc=xLhm66fDWuMAX-Zksi9&_nc_ht=scontent-iad3-1.xx&oh=1f3ec35d9aa2a1614e54ba161efa795c&oe=60677F04","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/3674481059240722/?ch=YTIyZjU4YjIzNDdmNjJhMTRmNGUyYmM0Nzg1MjQzZTU%3D","publicLink":"https://www.instagram.com/ar/3674481059240722/"},{"id":"805162856965467","name":"Generatore Neve","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/123008191_735527357035664_1181062309263618291_n.png?_nc_cat=111&ccb=1-3&_nc_sid=df6b83&_nc_ohc=-Uhiae4kJdUAX9nYzh4&_nc_ht=scontent-iad3-1.xx&oh=2a45a0f3866156d79f720d9f55986fe4&oe=606A621A","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/805162856965467/?ch=ODhjM2ViOTYzNjNhOWFmZGY5NmM0MWE0NTM4MjEyNTE%3D","publicLink":"https://www.instagram.com/ar/805162856965467/"}]},{"id":"183934957303","name":"Dolomiti Superski","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t1.0-1/cp0/p32x32/121833613_10157619571337304_521099372530565028_n.png?_nc_cat=110&ccb=1-3&_nc_sid=1eb0c7&_nc_ohc=Qa0J2g54FOkAX_7yOeZ&_nc_ht=scontent-iad3-1.xx&_nc_tp=30&oh=6e1fe6a37a37d62ec2091effacb880c4&oe=6067765C","effects":[{"id":"392911031705499","name":"Occhiale Sci","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/121658458_1056140234825276_4554739736141932443_n.png?_nc_cat=107&ccb=1-3&_nc_sid=df6b83&_nc_ohc=IL1xOUvGihgAX8nCnQK&_nc_ht=scontent-iad3-1.xx&oh=bcef25f7005aa41b0a4890d7b5a88125&oe=606A212A","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/392911031705499/?ch=NmVlZjk3ZDFmNDc1NDA2ZWE3YWM4NmU0ZDZlMzJjOTY%3D","publicLink":"https://www.instagram.com/ar/392911031705499/"},{"id":"2829178447311276","name":"Mountain Bike Ride","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/121605164_673911779913016_745895381944918605_n.png?_nc_cat=104&ccb=1-3&_nc_sid=df6b83&_nc_ohc=HIqDfB5v9NsAX9cpuZU&_nc_ht=scontent-iad3-1.xx&oh=002f3baf7608303710c7bbc4cea50d86&oe=606AE6BC","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/2829178447311276/?ch=NGVkYTVjYjJkNzg1NWY5YjEyMmM1MDg5Mzc3NWZmODk%3D","publicLink":"https://www.instagram.com/ar/2829178447311276/"},{"id":"370935607365326","name":"Mappa Dolomiti","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/121828973_754873008410550_9019693798562076973_n.png?_nc_cat=108&ccb=1-3&_nc_sid=df6b83&_nc_ohc=R5VYFpzGpjQAX-tqL4l&_nc_ht=scontent-iad3-1.xx&oh=e543e6798a0ee3cacc4512f2f3375131&oe=606781F0","visibilityStatus":"NOT_VISIBLE","submissionStatus":"UPDATE_REJECTED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/370935607365326/?ch=OWRiYTM4ZDIxNWU5OWRkYTE4NjljZTIyYjRmOTEzOTg%3D","publicLink":"https://www.instagram.com/ar/370935607365326/"},{"id":"570387950367273","name":"Cabina CWA Carezza","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/121960002_1703857446458848_7482110182338246356_n.png?_nc_cat=106&ccb=1-3&_nc_sid=df6b83&_nc_ohc=xFsH6FLC-JQAX98NrbT&_nc_ht=scontent-iad3-1.xx&oh=e9864ecd851952b5c0f641bded2323f9&oe=606AF785","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/570387950367273/?ch=NTg4ZTZjMGI3NTE1OGNmYjM5N2UyMmU1NDk4NjczOTA%3D","publicLink":"https://www.instagram.com/ar/570387950367273/"},{"id":"265821481537189","name":"Sciata","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/122584067_862768127795120_4489305814544162649_n.png?_nc_cat=110&ccb=1-3&_nc_sid=df6b83&_nc_ohc=sTaZwbZh3wIAX9-A-3j&_nc_ht=scontent-iad3-1.xx&oh=1961d7c066e675bcbd27efc119e7332e&oe=6068AED5","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/265821481537189/?ch=MjJjZGJhNjQ4NGJiY2E2YmFiMzE2M2Y4ZDI1MDY0YTQ%3D","publicLink":"https://www.instagram.com/ar/265821481537189/"},{"id":"1090446471357549","name":"Poster Inverno","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/121626669_891992377997568_1030409748956618487_n.png?_nc_cat=101&ccb=1-3&_nc_sid=df6b83&_nc_ohc=3-65Ukirtq8AX9IVIrJ&_nc_ht=scontent-iad3-1.xx&oh=f702e5742a0ca31a0c4096fc391d89e5&oe=6067D487","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/1090446471357549/?ch=Y2YyNTM0Y2NjNDc1MTNiOWU2YjRiNDQ5MWU2ZGViYzU%3D","publicLink":"https://www.instagram.com/ar/1090446471357549/"},{"id":"788091585357473","name":"Poster Estate","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/121605446_3933607956668585_2780411686082701326_n.png?_nc_cat=103&ccb=1-3&_nc_sid=df6b83&_nc_ohc=pNCA14tcs18AX9O9Rv4&_nc_ht=scontent-iad3-1.xx&oh=ca374cd99cf45f242f3b2beba7d67c9b&oe=6069DAF3","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/788091585357473/?ch=OWY1NTYzMGI3M2EzOGRlOWUzZjdjYWE1MTk2N2Q3Yjg%3D","publicLink":"https://www.instagram.com/ar/788091585357473/"},{"id":"810297906448696","name":"Natura Dolomitica","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/121624350_778143212963741_755779653685629742_n.png?_nc_cat=103&ccb=1-3&_nc_sid=df6b83&_nc_ohc=Zx9YJvQ_YooAX9nnvXN&_nc_oc=AQmGLaO-UKRgRaN5tKIVQuVFYkzZoQdxw7O1SOUagvtQ-HSMQEbdvOQfP8XbzaHF5hw&_nc_ht=scontent-iad3-1.xx&oh=8f7eba9b2a2ae9e6858206a07e5dbfcb&oe=606B283F","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/810297906448696/?ch=ZjhiMmJiNDdiMTM2MTEyZjk2NWVhYmMxYWZlZjlmODc%3D","publicLink":"https://www.instagram.com/ar/810297906448696/"},{"id":"779113592666624","name":"Berretto","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/121669776_430148441300348_1172471562136642610_n.png?_nc_cat=102&ccb=1-3&_nc_sid=df6b83&_nc_ohc=CbchrGr40tUAX_k6I0u&_nc_ht=scontent-iad3-1.xx&oh=f5a9daadc4ee2f2d332892df9862108b&oe=60679462","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/779113592666624/?ch=N2IwMjdkYmI0NjgxY2UwNjAwYTM0ZjhkNmQ2NDliMDM%3D","publicLink":"https://www.instagram.com/ar/779113592666624/"},{"id":"336525940916129","name":"Selfie Roccia e Neve","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/121602218_672468613453331_5598451431964892146_n.png?_nc_cat=105&ccb=1-3&_nc_sid=df6b83&_nc_ohc=txI0WIKei5QAX__LOiw&_nc_oc=AQkSyhcyCcvEBZN9zzHkgCEga_KilF4u62e8m_j43tbpMJkv7UmxCNsmKYYNA7cgztQ&_nc_ht=scontent-iad3-1.xx&oh=004b96305999f21ae1212ffe06e80ddb&oe=6069FCA8","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/336525940916129/?ch=YWZkOWFlMTI0YTRhN2JiNzQ5Y2IyNTE1ZWZiYmIwZTc%3D","publicLink":"https://www.instagram.com/ar/336525940916129/"}]},{"id":"371802782891999","name":"LEITNER","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t1.0-1/cp0/p32x32/120490889_4482015128537390_2736750995491220436_o.jpg?_nc_cat=101&ccb=1-3&_nc_sid=1eb0c7&_nc_ohc=Bn1b-wDgM6AAX-BxFn1&_nc_oc=AQncfdXu0eL_YZ4NGIHpL11Pk92Q1DyRXYmSVaLWeEbChbLpKImhV5biCTRAvhp1UYQ&_nc_ht=scontent-iad3-1.xx&tp=27&oh=bfb7fc929b2115ed1d74226a7d855841&oe=606AE08D","effects":[{"id":"390912208746465","name":"Motore Direct Drive","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/122717321_1490296324495408_4638032464173508712_n.png?_nc_cat=105&ccb=1-3&_nc_sid=df6b83&_nc_ohc=QHJiSsGZwnMAX_-TjCr&_nc_oc=AQl08s0xVvpOoK7SB2IfFAwsNJXhySglxEd4LpA2lvWp-V7rvzQUnFyEqklrxt28gpI&_nc_ht=scontent-iad3-1.xx&oh=f15ed42f465c92995428df1575c527fd&oe=6067B76B","visibilityStatus":"VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/390912208746465/?ch=MmMyYmFhZWNlMjc3NTY2YjdkOTk5MTY5MTdhODllZDM%3D","publicLink":"https://www.instagram.com/ar/390912208746465/"}]},{"id":"1293280007401438","name":"Science Gallery Venice","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t1.0-1/cp0/p32x32/67702752_2438984342830993_4994792063233949696_o.png?_nc_cat=110&ccb=1-3&_nc_sid=1eb0c7&_nc_ohc=ijdSBpLPGn4AX9ig9o4&_nc_ht=scontent-iad3-1.xx&_nc_tp=30&oh=f68b6f8cbfde72c7a79d338aa4c0d544&oe=6067BCD0","effects":[{"id":"710825822911350","name":"Palladio\'s Refectory","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/149308988_1567515810304185_2168449186327199602_n.png?_nc_cat=110&ccb=1-3&_nc_sid=df6b83&_nc_ohc=rCkEMhckvMAAX8neu49&_nc_ht=scontent-iad3-1.xx&oh=9e7872ed28333babebfabdc4f9d86091&oe=60697779","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/710825822911350/?ch=ZmFjODcxOTU1NDI1OTI1MTU2N2JmM2QwYjUyNDg0ZjI%3D","publicLink":"https://www.instagram.com/ar/710825822911350/"},{"id":"427067188406108","name":"Portrait of a Lady","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/149319274_329563928437776_3687631119996237843_n.png?_nc_cat=103&ccb=1-3&_nc_sid=df6b83&_nc_ohc=3FcFBaEii7QAX_50ulj&_nc_ht=scontent-iad3-1.xx&oh=eacbb66af8773a0374b5c275cae101e9&oe=60695B0D","visibilityStatus":"NOT_VISIBLE","submissionStatus":"APPROVED","isDeprecated":false,"testLink":"https://www.instagram.com/ar/427067188406108/?ch=MzQyNTVkNGQyNzY4ZWQxYjI5OWU1ZGU2MDIyYzg5ZjE%3D","publicLink":"https://www.instagram.com/ar/427067188406108/"}]},{"id":"161620450521406","name":"Scrinium","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t1.0-1/cp0/p32x32/33863381_2363665746983521_1849873162058072064_o.jpg?_nc_cat=100&ccb=1-3&_nc_sid=1eb0c7&_nc_ohc=PqdjSrb4XDoAX-xsCW6&_nc_ht=scontent-iad3-1.xx&tp=27&oh=02b2ce356ee0e12287f922583b0e7282&oe=60683CAE","effects":[{"id":"848588905523438","name":"MAO Marco Polo","iconUrl":"https://scontent-iad3-1.xx.fbcdn.net/v/t39.10260-6/65151653_403873217140955_6134078571389386752_n.png?_nc_cat=107&ccb=1-3&_nc_sid=df6b83&_nc_ohc=vhCqMlDKQ0wAX-psK5b&_nc_ht=scontent-iad3-1.xx&oh=0a9802c7ed6281a8b3a4553a7564c25b&oe=606A96D9","visibilityStatus":"VISIBLE","submissionStatus":"APPROVED","isDeprecated":true,"testLink":"https://www.facebook.com/fbcameraeffects/testit/848588905523438/M2I4YmI3YzliMjBiNTY4MWEwNzdmNTQ3MmQyODY4NGQ=/","publicLink":"https://www.facebook.com/fbcameraeffects/tryit/848588905523438/"}]}]';

  static final SparkARDB _instance = SparkARDB._internal();

  SparkARDB._internal();

  factory SparkARDB.getInstance() {
    return _instance;
  }

  @override
  Future<List<SparkARUser>?> getAllUsers(String email, String password) async {
    //get actual facebook public keys from netlify function

    // var encryptdata = await Dio().get(
    //     'https://sparkar-token-crawler.netlify.app/.netlify/functions/facebook_public_keys');
//
    // print(encryptdata);
//
    // var data = encryptdata.data;
//
    // var encpasss = await passwordEncrypt(password, data);
//
    // print(encpasss);
//
    // var tokenCookie = await Dio().get(
    //     'https://sparkar-token-crawler.netlify.app/.netlify/functions/facebook_get_token_cookie',
    //     queryParameters: {
    //       'encpass': encpasss,
    //       'lsd': data['lsd'],
    //       'email': email
    //     });

    var tokenCookie = {
      "cookie":
          "datr=_HWxX_o48u5pA2omjmV3mWo3; expires=Tue, 04-Apr-2023 10:22:47 GMT; Max-Age=63072000; path=/; domain=.facebook.com; secure; httponly; SameSite=None;_js_datr=deleted; expires=Thu, 01-Jan-1970 00:00:01 GMT; Max-Age=-1617531766; path=/; domain=.facebook.com; httponly;c_user=1614964298; expires=Mon, 04-Apr-2022 10:22:45 GMT; Max-Age=31535998; path=/; domain=.facebook.com; secure; SameSite=None;xs=20%3Au2ElQRXzzw7vcA%3A2%3A1617531768%3A11787%3A10452; expires=Mon, 04-Apr-2022 10:22:45 GMT; Max-Age=31535998; path=/; domain=.facebook.com; secure; httponly; SameSite=None;sb=C3axXzaMOhkuTPSbY1oeo3U-; expires=Tue, 04-Apr-2023 10:22:47 GMT; Max-Age=63072000; path=/; domain=.facebook.com; secure; httponly; SameSite=None;fr=18wHiBPYRoq40KoEB.AWUxYYbMppSuYiSoP3X-AJulnB0.BfsXYL.K8.AAA.0.0.BgaZN3.AWV06MAdOc4; expires=Sat, 03-Jul-2021 10:22:43 GMT; Max-Age=7775996; path=/; domain=.facebook.com; secure; httponly; SameSite=None;",
      "token": "AQG_F-ca6WrA:AQEK8rfR7pEg"
    };

    print(tokenCookie);

    getUsers(tokenCookie);

//
    // try {
    //   var data = await checkCache('spark-ar-users-netlify',
    //       () async => await getDataFromSparkAR(email, password));
//
    //   return List.unmodifiable(data.map((e) => SparkARUser.fromJson(e)));
    // } catch (e) {
    //   print(e);
    //   return null;
    // }
  }

  Future<List<Map<String, dynamic>>> getDataFromSparkAR(
      String encryptedEmail, String encryptedPassword) async {
    //if (kReleaseMode) {
    final response = await http.get(Uri.https(
        'sparkar-token-crawler.netlify.app',
        '.netlify/functions/sparkar_fetch',
        {"encemail": encryptedEmail, "encpass": encryptedPassword}));

    final data = jsonDecode(response.body) as List<dynamic>;
    return data.map((e) => e as Map<String, dynamic>).toList();
    /*} else {
      final body = FAKE_DATA;
      final data = jsonDecode(body) as List<dynamic>;
      return data.map((e) => e as Map<String, dynamic>).toList();
    }*/
  }

  Future<String> passwordEncrypt(String password, dynamic encryption) async {
    var testEncryption = {
      'lsd': "AVrCPyA5Wew",
      'encryption': {
        'publickey':
            "c2cf669b2d23f011efb4f344a36827ae6127ec81b720e6804a26eec0e027565e",
        'keyId': "228"
      },
      'generatedKey': {
        'algorithm': {'name': "AES-GCM", 'length': 256},
        'type': "secret",
        'extractable': true,
        'usages': ["encrypt", "decrypt"]
      },
      'raw': [
        147,
        163,
        47,
        52,
        66,
        203,
        124,
        36,
        126,
        62,
        22,
        133,
        130,
        233,
        232,
        2,
        15,
        79,
        255,
        26,
        214,
        97,
        34,
        191,
        2,
        12,
        59,
        118,
        50,
        166,
        175,
        128
      ],
      'seal': [
        53,
        7,
        127,
        150,
        15,
        189,
        110,
        121,
        70,
        180,
        167,
        1,
        177,
        10,
        14,
        168,
        218,
        150,
        19,
        145,
        154,
        103,
        244,
        119,
        73,
        194,
        112,
        131,
        111,
        237,
        20,
        94,
        81,
        121,
        177,
        222,
        212,
        61,
        147,
        251,
        58,
        113,
        102,
        170,
        142,
        106,
        168,
        163,
        93,
        144,
        132,
        191,
        113,
        238,
        187,
        226,
        245,
        55,
        5,
        152,
        125,
        245,
        48,
        237,
        43,
        46,
        105,
        120,
        8,
        52,
        87,
        217,
        14,
        154,
        172,
        243,
        75,
        142,
        93,
        142
      ]
    };

    testEncryption = encryption;
    final publicKey = (testEncryption['encryption'] as dynamic)!['publickey'];
    final keyId = int.parse(
        (testEncryption['encryption'] as dynamic)!['keyId'] as String);
    final seal = (testEncryption['seal'] as Map<dynamic, dynamic>)
        .values
        .cast<int>()
        .toList();
    final key = testEncryption['generatedKey'];
    final raw = (testEncryption['raw'] as Map<dynamic, dynamic>)
        .values
        .cast<int>()
        .toList();
    var date = (DateTime.now().millisecondsSinceEpoch / 1e3).floor().toString();
    return await encryptPassword(
        keyId, publicKey, password, date, seal, key, raw);
  }

  Future<String> encryptPassword(a, publicKey, String password, String date,
      List<int> seal, keyy, List<int> raw) async {
    var f, g, passwordBytes, dateBytes;
    f = "#PWD_BROWSER";
    g = 5;
    passwordBytes = password.codeUnits;
    dateBytes = date.codeUnits;
    var key =
        await encrypt(a, publicKey, passwordBytes, dateBytes, seal, keyy, raw);
    return [f, g, date, base64Encode(key)].join(":");
  }

  Future<Uint8List> encrypt(a, publicKey, passwordBytes, dateBytes,
      List<int> seal, key, List<int> raw) async {
    var f, s, u, v, w, x;
    var h = 64,
        i = 1,
        j = 1,
        k = 1,
        l = 48,
        m = 2,
        n = 32,
        o = 16,
        p = j + k + m + n + l + o;
    f = p + passwordBytes.length;
    var t = Uint8List(f);
    u = 0;
    t[u] = i;
    u += j;
    t[u] = a;
    u += k;

    var secretKey = await AesGcmSecretKey.importRawKey(raw);
    print(secretKey);
    print("MOMOMOMOMO" + passwordBytes.length.toString());
    var enc = await secretKey.encryptBytes(passwordBytes, Uint8List(12),
        additionalData: dateBytes);
    o = 16;
    var b = seal;
    print(b.length);
    print(u);
    print(b);
    print(a);
    print("VEEEEEEEEEEEEEEEEEEEEEEEEE");

    t[u] = b.length & 255;
    t[u + 1] = b.length >> 8 & 255;
    u += m;
    //t.set(b, u);
    print("Before set ALL");
    t.setAll(u, b);
    print(t);
    u += n;
    u += l;
    if (b.length != n + l) throw new Error();
    print("VAVAVAAVVAVV");
    print(enc.length);
    b = enc;
    print(b);
    print(b.length);
    var end = b.length - o;
    if (end < 0) {
      end = b.length - o;
    }
    a = b.sublist(b.length - o);
    print(a);
    b = b.sublist(0, b.length - o);
    print(b);
    //t.set(a, u);
    t.setAll(u, a);
    u += o;
    //t.set(b, u);
    t.setAll(u, b);
    return t;
  }

  Future<dynamic> getUsers(cookieAndToken) async {
    var options = {'form': {}, 'headers': {}};
    options['form']!['doc_id'] = '2737348616365573';
    options['form']!['variables'] = '{}';
    options['headers']!['cookie'] = cookieAndToken['cookie'];
    options['form']!['fb_dtsg'] = cookieAndToken['token'];
    const url = 'https://www.facebook.com/api/graphql/';

    final effectQuery = await Dio().post(url, data: options);

    print(effectQuery);

    return effectQuery.data['ar_hub_settings']!['owners'].map((item) {
      return {
        'id': item.owner.id,
        'name': item.owner.name,
        'iconUrl': item.owner.profile_picture.uri
      };
    });
  }

  //Future<List<SparkARUser>> getEffectsForUsers(usersList,
  //    cookieAndToken) async {
  //  const usersAndEffects = [];
  //  options.headers.cookie = cookieAndToken.cookie;
  //  options.form.fb_dtsg = cookieAndToken.token;
  //  for (const user of usersList) {
  //    const variables = `
  //    {
  //      "selectedOwnerID"
  //  :"${user.id}","filters":{"effect_name_contains_ci":"","visibility_statuses":[],"review_statuses":[],"surfaces":[],"exclude_surfaces":["AR_ADS"]},"orderby":["LAST_MODIFIED_TIME_DESC"]}`;
  //  options.form.doc_id = '3625110550842914';
  //  options.form.variables = variables;
  //  const url = 'https://www.facebook.com/api/graphql/';
  //  const effectQuery = await got_1.default.post(url, options).json();
  //  const effectsForUser = effectQuery.owner.effects.edges.map((effect) => {
  //  const studioEffect = effect.node.ar_studio_effect;
  //  let isDeprecated = false;
  //  if (studioEffect.submission_status !== 'NOT_REVIEWED' && studioEffect.submission_status !== 'NOT_APPROVED') {
  //  isDeprecated = studioEffect.latest_active_arexport_file.is_deprecated;
  //  }
  //  return {
  //  id: effect.node.id,
  //  name: studioEffect.name,
  //  iconUrl: studioEffect.thumbnail_uri,
  //  visibilityStatus: studioEffect.visibility_status,
  //  submissionStatus: studioEffect.submission_status,
  //  isDeprecated: isDeprecated,
  //  testLink: studioEffect.test_link,
  //  publicLink: studioEffect.share_link
  //  };
  //  });
  //  if (effectsForUser.length !== 0) {
  //  user.effects = effectsForUser;
  //  usersAndEffects.push(user);
  //  }
  //}
  //  return
  //  usersAndEffects;
  //}
}
