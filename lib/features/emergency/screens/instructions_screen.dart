import 'package:earthquake/constants/sizes.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class InstructionsScreen extends StatelessWidget {
  const InstructionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: const Text('كيف تحمي نفسك عند حصول زلزال؟')),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildQuestion(title: 'إذا كنت في المنزل', body: '''
• اتبع قاعدة الاحتماء والتغطية والثبات
• ابتعد عن الزجاج والنوافذ والجدران، وأي شيء قد يسقط مثل أدوات الإضاءة والأثاث.
• إذا كنت في السرير، فابقَ في مكانك واحمِ رأسك بوسادة
• لا تقف عند المداخل إلا إذا كنت متأكداً من أنها قوية وتستطيع التحمل.
• لا تستخدم المصاعد.
• كن على علم أن الإضاءة قد تنقطع، وقد تعمل أجهزة إطفاء الحريق فجأة.
'''),
              SizedBox(
                height: sh * 0.05,
              ),
              buildQuestion(title: 'إذا كنت في الخارج', body: '''
• تحرك بعيدًا عن المباني وأعمدة الإضاءة، والأسلاك الكهربائية، والحفر، وخطوط الوقود، والغاز.
• ابق في الخارج حتى تتوقف الهزة. وتتمثل أخطر الأماكن بمخارج المباني مباشرة وعند الجدران الخارجية.
'''),
              SizedBox(
                height: sh * 0.05,
              ),
              buildQuestion(title: 'إذا كنت في السيارة', body: '''
• توقف بأسرع ما تسمح به معايير السلامة وابق في السيارة. وتجنب التوقف بالقرب من أو أسفل المباني والأشجار والجسور وأسلاك الكهرباء.
• سر بالسيارة بهدوء بعد توقف الزلزال، وتجنب الطرق أو الجسور أو المنحدرات التي قد تكون قد تضررت جراء الزلزال.
• شغل الراديو للحصول على آخر المعلومات والأخبار، ولتلقي التعليمات والتوجيهات التي قد تصدرها السلطات.
'''),
              SizedBox(
                height: sh * 0.05,
              ),
              buildQuestion(title: 'إذا كنت عالقًا تحت حطام', body: '''
• قم بتغطية فمك بمنديل أو قطعة ملابس.
• اطرق على أنبوب معدني أو حائط حتى يستطيع رجال الإنقاذ تحديد مكانك، أو استخدم صفارة إذا كانت متاحة لك. قم بالصياح كحل أخير علماً بأن ذلك قد يؤدي إلى استنشاق كميات خطيرة من الغبار.
• وفيما يلي كيفية الاستعداد قبل وقوع الزلزال، وفقًا لما ذكرته المديرية العامة للدفاع المدني اللبناني:
  - مراقبة الأغراض في البيت أو في المكتب.
  - تثبيت كل ما يمكن أن يقع مثل خزانة، وثريات، ورفوف، وغيرها.
  - تصليح التشققات في المبنى والأسلاك الكهربائية.
  - تحديد أماكن آمنة في الداخل: تحت الطاولات القوية الصنع، أو بجانب حائط داخلي بعيداً عن الزجاج، والمرايا، وكل ما يمكن أن يتكّسر.
  - تحديد أماكن آمنة في الخارج بعيداً عن الأبنية، والأشجار، وأعمدة الهاتف، والكهرباء.
  - تحضير حقيبة طوارئ وحقيبة إسعافات أولية مع الأدوية اللازمة إذا وجدت.
'''),
            ],
          ),
        )));
  }

  Container buildQuestion({title, body, controller}) {
    return Container(
      padding: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: Colors.grey.withOpacity(.2),
              blurRadius: 12)
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpandableNotifier(
        controller: controller,
        child: ScrollOnExpand(
          child: ExpandablePanel(
            controller: controller,
            header: Text(
              title,
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[900]),
            ),
            collapsed: Text(
              body,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 17),
            ),
            expanded: Text(
              body,
              softWrap: true,
              style: const TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
