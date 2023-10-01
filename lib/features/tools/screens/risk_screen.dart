import 'package:earthquake/constants/colors.dart';
import 'package:earthquake/constants/sizes.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class RiskScreen extends StatelessWidget {
  const RiskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: primary,
          title: const Text('مستوى متوسط من الخطورة')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildQuestion(
                title: 'انخفاض ضغط الدم',
                body:
                    'إذا كان الشخص يعاني من انخفاض ضغط الدم تحت الأنقاض، فيمكن اتخاذ الإجراءات التالية\n'
                    '• التأكد من سلامة الشخص: تحقق من وضعية الشخص وتحقق من وجود أي إصابات قوية. إذا كان هناك أي إصابات خطيرة أو تهديد للحياة، فقد يكون الأولوية في تقديم العناية الطبية الفورية.\n'
                    '• الاستلقاء بشكل مناسب: قم بمساعدة الشخص على الاستلقاء ببطء وبشكل مريح على سطح مستوٍ وثابت. قم برفع ساقيه قليلاً لتعزيز تدفق الدم إلى الدماغ.\n'
                    '• توفير الهواء النقي: تأكد من توفير هواء نقي ومنع احتجازه تحت الأنقاض. فتح الفتحات الممكنة لتهوية المكان وتوفير الهواء الطازج.\n'
                    '• تجنب التحركات السريعة: حث الشخص على عدم التحرك بشكل مفاجئ أو سريع تحت الأنقاض. قد يؤدي التحرك السريع إلى انخفاض ضغط الدم بشكل أكبر.\n'
                    '• البقاء بجوار الشخص ومراقبته: حافظ على وجودك بجوار الشخص المصاب ومراقبته باستمرار. قم بالتحدث إليه بصوت هادئ ومهدئ للمساعدة في الحفاظ على الهدوء.\n'
                    '• الاتصال بفرق الإنقاذ: قم بالاتصال بفرق الإنقاذ أو الطوارئ لإبلاغهم بالحالة والحصول على المساعدة اللازمة.\n'
                    'مهم جدًا أن تتواصل مع الفرق المؤهلة للإنقاذ وتسمح لهم بالتعامل مع الحالة بشكل صحيح وآمن. يمكن أن يقدموا المساعدة الطبية اللازمة واتخاذ الإجراءات المناسبة للتعامل مع انخفاض ضغط الدم تحت الأنقاض.',
              ),
              SizedBox(
                height: sh * 0.05,
              ),
              buildQuestion(
                title: 'ارتفاع ضغط الدم وتسارع دقات القلب',
                body:
                    'في حالة وجود شخص تحت الأنقاض ويعاني من حالة ارتفاع ضغط الدم وتسارع دقات القلب، يجب اتخاذ الإجراءات التالية:\n\n'
                    'استدعاء الإسعاف الطبي: قم بالاتصال بفرق الإنقاذ أو الإسعاف الطبي على الفور لتقديم المساعدة المهنية الفورية.\n\n'
                    'عدم تحريك الشخص بنفسك: يجب عليك عدم محاولة نقل الشخص بنفسك، خاصة إذا كانت هناك مواد أخرى تحت الأنقاض أو إذا كانت حالة الشخص حرجة. انتظر وصول فرق الإنقاذ المدربة لتقديم المساعدة اللازمة.\n\n'
                    'توفير التهوية والهواء النقي: في حالة وجود فراغ محدود في المنطقة المحيطة بالشخص، قم بتوفير التهوية وفتح المساحات الضيقة لتمرير الهواء. ذلك يساعد في تحسين جودة الهواء وتوفير الأكسجين للشخص المحاصر.\n\n'
                    'المحافظة على الاتصال وتوجيه الشخص: حاول المحافظة على التواصل مع الشخص المحاصر تحت الأنقاض وتوجيهه للبقاء هادئًا والتأكد من أنه يسمع صوتك. قدم له الدعم النفسي وأخبره أن الإسعاف الطبي في طريقه.\n\n'
                    'توفير المساحة والوقت: حاول توفير المساحة لفرق الإنقاذ للوصول إلى المصاب. قم بالابتعاد عن المنطقة واتباع توجيهات فرق الإنقاذ. قد يستغرق الأمر بعض الوقت للوصول إلى المصاب وإخراجه بأمان.\n\n'
                    'والتنفس ببطء وعمق.\n\n'
                    'يجب عليك أن تدرك أن هذه الإرشادات هي للإسعافات الأولية وتهدف إلى توفير المساعدة المؤقتة والحفاظ على سلامة الشخص المحاصر. من الأهمية بمكان أن ننتظر وصول فرق الإنقاذ المدربة للتعامل مع الموقف بشكل صحيح وآمن.',
              ),
            ],
          ),
        ),
      ),
    );
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
