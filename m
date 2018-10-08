Return-Path: <SRS0=3ivt=MU=usp.br=matheus.bernardino@kernel.org>
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	kernel-usp@googlegroups.com
Subject: [PATCH v2] staging: iio: ad2s1210: fix 'assignment operator' style checks
Date: Mon,  8 Oct 2018 00:29:38 -0300
Message-Id: <20181008032938.18801-1-matheus.bernardino@usp.br>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes all "Assignment operator '=' should be on the previous
line" checks found in ad2s1210.c with checkpatch.pl.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v2: In v1, tabs were accidentally converted to whitespaces.
Now, tabs were preserved.

 drivers/staging/iio/resolver/ad2s1210.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index ac13b99bd9cb..d4b1c2c010f2 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -301,8 +301,8 @@ static ssize_t ad2s1210_store_control(struct device *dev,
 			"ad2s1210: write control register fail\n");
 		goto error_ret;
 	}
-	st->resolution
-		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
+	st->resolution =
+		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
 	if (st->pdata->gpioin) {
 		data = ad2s1210_read_resolution_pin(st);
 		if (data != st->resolution)
@@ -363,8 +363,8 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
 		dev_err(dev, "ad2s1210: setting resolution fail\n");
 		goto error_ret;
 	}
-	st->resolution
-		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
+	st->resolution =
+		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
 	if (st->pdata->gpioin) {
 		data = ad2s1210_read_resolution_pin(st);
 		if (data != st->resolution)
-- 
2.18.0
