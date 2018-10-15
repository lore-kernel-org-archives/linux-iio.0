Return-Path: <SRS0=UtO/=M3=gmail.com=capellaresumo@kernel.org>
Sender: Gabriel Capella <capellaresumo@gmail.com>
Date: Mon, 15 Oct 2018 18:25:21 -0300
From: Gabriel Capella <gabriel@capella.pro>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: adc: Add comments to prevent checks corrections
Message-ID: <20181015212521.GA24512@mantaray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch adds 3 comments in 2 different files.
These comments warn to don't correct the checks of type:
"CHECK: spaces preferred around that '-'"

Signed-off-by: Gabriel Capella <gabriel@capella.pro>
---
 drivers/staging/iio/adc/ad7192.c  | 1 +
 drivers/staging/iio/adc/ad7280a.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index acdbc07fd259..786ace19c240 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -354,6 +354,7 @@ ad7192_show_scale_available(struct device *dev,
 	return len;
 }
 
+/* Do not put spaces around the hyphen. #checkpatch.pl */
 static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
 			     in_voltage-voltage_scale_available,
 			     0444, ad7192_show_scale_available, NULL, 0);
diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58420dcb406d..4927116a046c 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -749,6 +749,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+/* Do not put spaces around the hyphen. #checkpatch.pl */
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
 		in_voltage-voltage_thresh_low_value,
 		0644,
@@ -756,6 +757,7 @@ static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
 		ad7280_write_channel_config,
 		AD7280A_CELL_UNDERVOLTAGE);
 
+/* Do not put spaces around the hyphen. #checkpatch.pl */
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
 		in_voltage-voltage_thresh_high_value,
 		0644,
--

 
