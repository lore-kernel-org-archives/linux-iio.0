Return-Path: <marek.belisko@gmail.com>
Sender: Belisko Marek <marek.belisko@gmail.com>
From: Marek Belisko <marek@goldelico.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hns@goldelico.com,
	Marek Belisko <marek@goldelico.com>
Subject: [PATCH 2/2] iio: adc: twl4030_madc: Fix description of twl4030_madc_set_current_generator()
Date: Thu, 28 May 2015 21:50:19 +0200
Message-Id: <1432842619-7251-2-git-send-email-marek@goldelico.com>
In-Reply-To: <1432842619-7251-1-git-send-email-marek@goldelico.com>
References: <1432842619-7251-1-git-send-email-marek@goldelico.com>
List-ID: <linux-iio@vger.kernel.org>

From: "H. Nikolaus Schaller" <hns@goldelico.com>

The @chan parameter can be 0 or 1 and not a bit mask. Fix wrong description.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/iio/adc/twl4030-madc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 6d2d429..06f4792 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -662,10 +662,8 @@ EXPORT_SYMBOL_GPL(twl4030_get_madc_conversion);
  *
  * @madc:	pointer to twl4030_madc_data struct
  * @chan:	can be one of the two values:
- *		TWL4030_BCI_ITHEN
- *		Enables bias current for main battery type reading
- *		TWL4030_BCI_TYPEN
- *		Enables bias current for main battery temperature sensing
+ *		0 - Enables bias current for main battery type reading
+ *		1 - Enables bias current for main battery temperature sensing
  * @on:		enable or disable chan.
  *
  * Function to enable or disable bias current for
-- 
1.9.1
