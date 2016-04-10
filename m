Return-Path: <ksenija.stanojevic@gmail.com>
From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH 2/2] iio: adc: set INPUT_PROP_DIRECT
Date: Sun, 10 Apr 2016 21:22:32 +0200
Message-Id: <7838d255676f6f778bf9710454f632cd68a35185.1460316098.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1460316098.git.ksenija.stanojevic@gmail.com>
References: <cover.1460316098.git.ksenija.stanojevic@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Set INPUT_PROP_DIRECT to indicate that it is a touchscreen on the
device to help userspace classify it.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
---
 drivers/iio/adc/mxs-lradc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
index 07287af..e4c4c5c 100644
--- a/drivers/iio/adc/mxs-lradc.c
+++ b/drivers/iio/adc/mxs-lradc.c
@@ -1127,6 +1127,7 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
 	__set_bit(EV_ABS, input->evbit);
 	__set_bit(EV_KEY, input->evbit);
 	__set_bit(BTN_TOUCH, input->keybit);
+	__set_bit(INPUT_PROP_DIRECT, input->propbit);
 	input_set_abs_params(input, ABS_X, 0, LRADC_SINGLE_SAMPLE_MASK, 0, 0);
 	input_set_abs_params(input, ABS_Y, 0, LRADC_SINGLE_SAMPLE_MASK, 0, 0);
 	input_set_abs_params(input, ABS_PRESSURE, 0, LRADC_SINGLE_SAMPLE_MASK,
-- 
1.9.1
