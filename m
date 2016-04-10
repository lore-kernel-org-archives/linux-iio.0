Return-Path: <ksenija.stanojevic@gmail.com>
From: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
To: 
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Subject: [PATCH 1/2] iio: adc: Indent if statement
Date: Sun, 10 Apr 2016 21:20:56 +0200
Message-Id: <4e0dac35d2751f51e033b360e65bdd10edf4bb35.1460316026.git.ksenija.stanojevic@gmail.com>
In-Reply-To: <cover.1460316026.git.ksenija.stanojevic@gmail.com>
References: <cover.1460316026.git.ksenija.stanojevic@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Indent lines inside if statement.

Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
---
 drivers/iio/adc/mxs-lradc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
index 33051b8..07287af 100644
--- a/drivers/iio/adc/mxs-lradc.c
+++ b/drivers/iio/adc/mxs-lradc.c
@@ -1500,9 +1500,10 @@ static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
 		mxs_lradc_reg_clear(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
 				    LRADC_CTRL0);
 
-	if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
-		mxs_lradc_reg_set(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
-				  LRADC_CTRL0);
+		if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
+			mxs_lradc_reg_set(lradc,
+					  LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
+					  LRADC_CTRL0);
 	}
 
 	/* Start internal temperature sensing. */
-- 
1.9.1
