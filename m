Return-Path: <SRS0=TmfX=7F=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH 3/3] iio: trigger: stm32-timer: add output compare triggers
Date: Thu, 3 Aug 2017 11:14:14 +0200
Message-ID: <1501751654-14153-4-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1501751654-14153-1-git-send-email-fabrice.gasnier@st.com>
References: <1501751654-14153-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add output compare trigger sources available on some instances.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/trigger/stm32-timer-trigger.c     | 31 +++++++++++++++++----------
 include/linux/iio/timer/stm32-timer-trigger.h | 12 +++++++++++
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index 33890f9..a9bc5b6 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -29,12 +29,14 @@
 	{ TIM7_TRGO,},
 	{ TIM8_TRGO, TIM8_TRGO2, TIM8_CH1, TIM8_CH2, TIM8_CH3, TIM8_CH4,},
 	{ TIM9_TRGO, TIM9_CH1, TIM9_CH2,},
-	{ }, /* timer 10 */
-	{ }, /* timer 11 */
+	{ TIM10_OC1,},
+	{ TIM11_OC1,},
 	{ TIM12_TRGO, TIM12_CH1, TIM12_CH2,},
-	{ }, /* timer 13 */
-	{ }, /* timer 14 */
+	{ TIM13_OC1,},
+	{ TIM14_OC1,},
 	{ TIM15_TRGO,},
+	{ TIM16_OC1,},
+	{ TIM17_OC1,},
 };
 
 /* List the triggers accepted by each timer */
@@ -47,10 +49,10 @@
 	{ }, /* timer 6 */
 	{ }, /* timer 7 */
 	{ TIM1_TRGO, TIM2_TRGO, TIM4_TRGO, TIM5_TRGO,},
-	{ TIM2_TRGO, TIM3_TRGO,},
+	{ TIM2_TRGO, TIM3_TRGO, TIM10_OC1, TIM11_OC1,},
 	{ }, /* timer 10 */
 	{ }, /* timer 11 */
-	{ TIM4_TRGO, TIM5_TRGO,},
+	{ TIM4_TRGO, TIM5_TRGO, TIM13_OC1, TIM14_OC1,},
 };
 
 static const void *stm32h7_valids_table[][MAX_VALIDS] = {
@@ -65,10 +67,12 @@
 	{ }, /* timer 9 */
 	{ }, /* timer 10 */
 	{ }, /* timer 11 */
-	{ TIM4_TRGO, TIM5_TRGO,},
+	{ TIM4_TRGO, TIM5_TRGO, TIM13_OC1, TIM14_OC1,},
 	{ }, /* timer 13 */
 	{ }, /* timer 14 */
-	{ TIM1_TRGO, TIM3_TRGO,},
+	{ TIM1_TRGO, TIM3_TRGO, TIM16_OC1, TIM17_OC1,},
+	{ }, /* timer 16 */
+	{ }, /* timer 17 */
 };
 
 struct stm32_timer_trigger {
@@ -91,6 +95,11 @@ static bool stm32_timer_is_trgo2_name(const char *name)
 	return !!strstr(name, "trgo2");
 }
 
+static bool stm32_timer_is_trgo_name(const char *name)
+{
+	return (!!strstr(name, "trgo") && !strstr(name, "trgo2"));
+}
+
 static int stm32_timer_start(struct stm32_timer_trigger *priv,
 			     struct iio_trigger *trig,
 			     unsigned int frequency)
@@ -355,6 +364,7 @@ static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
 
 	while (cur && *cur) {
 		struct iio_trigger *trig;
+		bool cur_is_trgo = stm32_timer_is_trgo_name(*cur);
 		bool cur_is_trgo2 = stm32_timer_is_trgo2_name(*cur);
 
 		if (cur_is_trgo2 && !priv->has_trgo2) {
@@ -371,10 +381,9 @@ static int stm32_setup_iio_triggers(struct stm32_timer_trigger *priv)
 
 		/*
 		 * sampling frequency and master mode attributes
-		 * should only be available on trgo trigger which
-		 * is always the first in the list.
+		 * should only be available on trgo/trgo2 triggers
 		 */
-		if (cur == priv->triggers || cur_is_trgo2)
+		if (cur_is_trgo || cur_is_trgo2)
 			trig->dev.groups = stm32_trigger_attr_groups;
 
 		iio_trigger_set_drvdata(trig, priv);
diff --git a/include/linux/iio/timer/stm32-timer-trigger.h b/include/linux/iio/timer/stm32-timer-trigger.h
index 20f4653..d68add8 100644
--- a/include/linux/iio/timer/stm32-timer-trigger.h
+++ b/include/linux/iio/timer/stm32-timer-trigger.h
@@ -55,12 +55,24 @@
 #define TIM9_CH1	"tim9_ch1"
 #define TIM9_CH2	"tim9_ch2"
 
+#define TIM10_OC1	"tim10_oc1"
+
+#define TIM11_OC1	"tim11_oc1"
+
 #define TIM12_TRGO	"tim12_trgo"
 #define TIM12_CH1	"tim12_ch1"
 #define TIM12_CH2	"tim12_ch2"
 
+#define TIM13_OC1	"tim13_oc1"
+
+#define TIM14_OC1	"tim14_oc1"
+
 #define TIM15_TRGO	"tim15_trgo"
 
+#define TIM16_OC1	"tim16_oc1"
+
+#define TIM17_OC1	"tim17_oc1"
+
 bool is_stm32_timer_trigger(struct iio_trigger *trig);
 
 #endif
-- 
1.9.1
