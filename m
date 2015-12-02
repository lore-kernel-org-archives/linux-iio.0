Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	lars@metafoo.de,
	maxime.ripard@free-electrons.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio:mxs-lradc Fix large integer implicitly truncated to unsigned warning
Date: Wed,  2 Dec 2015 18:24:45 +0000
Message-Id: <1449080685-4662-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

The change to using BIT(20) for one of the bit shifts resulted
in a constant becoming unsigned. When combined with the existing
signed constants in a couple of places, this caused possible trouble,
hence the warnings:

drivers/staging/iio/adc/mxs-lradc.c: In function ‘mxs_lradc_complete_touch_event’:
drivers/staging/iio/adc/mxs-lradc.c:325:5: warning: large integer implicitly truncated to unsigned type [-Woverflow]
     (((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
     ^
drivers/staging/iio/adc/mxs-lradc.c:734:7: note: in expansion of macro ‘LRADC_DELAY_TRIGGER’
       LRADC_DELAY_TRIGGER(1 << TOUCHSCREEN_VCHANNEL1) |
       ^
  LD [M]  drivers/staging/iio/accel/adis16201.o
drivers/staging/iio/adc/mxs-lradc.c: In function ‘mxs_lradc_buffer_preenable’:
drivers/staging/iio/adc/mxs-lradc.c:322:42: warning: large integer implicitly truncated to unsigned type [-Woverflow]
 #define LRADC_DELAY_TRIGGER_LRADCS_MASK  (0xff << 24)
                                          ^
drivers/staging/iio/adc/mxs-lradc.c:1308:29: note: in expansion of macro ‘LRADC_DELAY_TRIGGER_LRADCS_MASK’
  mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |
                             ^
drivers/staging/iio/adc/mxs-lradc.c: In function ‘mxs_lradc_buffer_postdisable’:
drivers/staging/iio/adc/mxs-lradc.c:322:42: warning: large integer implicitly truncated to unsigned type [-Woverflow]
 #define LRADC_DELAY_TRIGGER_LRADCS_MASK  (0xff << 24)
                                          ^
drivers/staging/iio/adc/mxs-lradc.c:1327:29: note: in expansion of macro ‘LRADC_DELAY_TRIGGER_LRADCS_MASK’
  mxs_lradc_reg_clear(lradc, LRADC_DELAY_TRIGGER_LRADCS_MASK |

The simplest fix is to force LRADC_DELAY_TRIGGER_LRADCS_MASK to be
a shift of an unsigned 0xff rather than a signed one.

This is ugly considering it is the only constant in the driver which
is so forced, but it does deal with the issue.

Fixes: e0c961bdaf27 (iio: adc: mxs-lradc: Prefer using the BIT macro)
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
Greg I guess the best bet might be if you pick this one up directly.
If not I can queue it up for a pull request that will probably hit
you on Sunday.  Don't mind either way!

Jonathan

 drivers/staging/iio/adc/mxs-lradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 5f1375c465e6..bb1f15224ac8 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -319,7 +319,7 @@ struct mxs_lradc {
 #define	LRADC_CH_VALUE_OFFSET			0
 
 #define	LRADC_DELAY(n)				(0xd0 + (0x10 * (n)))
-#define	LRADC_DELAY_TRIGGER_LRADCS_MASK		(0xff << 24)
+#define	LRADC_DELAY_TRIGGER_LRADCS_MASK		(0xffUL << 24)
 #define	LRADC_DELAY_TRIGGER_LRADCS_OFFSET	24
 #define	LRADC_DELAY_TRIGGER(x) \
 				(((x) << LRADC_DELAY_TRIGGER_LRADCS_OFFSET) & \
-- 
2.6.2
