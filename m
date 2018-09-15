Return-Path: <SRS0=mS6K=L5=gmail.com=natechancellor@kernel.org>
From: Nathan Chancellor <natechancellor@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] iio: adc: max9611: Avoid implicit enum conversion warning
Date: Fri, 14 Sep 2018 22:25:11 -0700
Message-Id: <20180915052511.2243-1-natechancellor@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Clang warns when an enumerated type is implicitly converted to another.

drivers/iio/adc/max9611.c:292:16: warning: implicit conversion from
enumeration type 'enum max9611_conf_ids' to different enumeration type
'enum max9611_csa_gain' [-Wenum-conversion]
                        *csa_gain = gain_selectors[i];
                                  ~ ^~~~~~~~~~~~~~~~~
1 warning generated.

Change the type of the variable 'gain_selectors' to int so that Clang
understands this is expected behavior.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/iio/adc/max9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
index 0538ff8c4ac1..3c358b16a8fa 100644
--- a/drivers/iio/adc/max9611.c
+++ b/drivers/iio/adc/max9611.c
@@ -275,7 +275,7 @@ static int max9611_read_csa_voltage(struct max9611_dev *max9611,
 				    u16 *adc_raw,
 				    enum max9611_csa_gain *csa_gain)
 {
-	enum max9611_conf_ids gain_selectors[] = {
+	int gain_selectors[] = {
 		CONF_SENSE_1x,
 		CONF_SENSE_4x,
 		CONF_SENSE_8x
-- 
2.18.0
