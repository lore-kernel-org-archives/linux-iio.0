Return-Path: <SRS0=etR0=YZ=lechnology.com=david@kernel.org>
From: David Lechner <david@lechnology.com>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: adc: ti-ads7950: Change regulator matching string to "vref"
Date: Wed, 11 Jan 2017 11:52:51 -0600
Message-Id: <1484157171-15571-4-git-send-email-david@lechnology.com>
In-Reply-To: <1484157171-15571-1-git-send-email-david@lechnology.com>
References: <1484157171-15571-1-git-send-email-david@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>

This changes the reference voltage regulator matching string from "refin"
to "vref". This is to be consistent with other A/DC chips that also use
"vref-supply" in their device tree bindings.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/iio/adc/ti-ads7950.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index b587fa6..16a0663 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -411,15 +411,15 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	spi_message_init_with_transfers(&st->scan_single_msg,
 					st->scan_single_xfer, 3);
 
-	st->reg = devm_regulator_get(&spi->dev, "refin");
+	st->reg = devm_regulator_get(&spi->dev, "vref");
 	if (IS_ERR(st->reg)) {
-		dev_err(&spi->dev, "Failed get get regulator \"refin\"\n");
+		dev_err(&spi->dev, "Failed get get regulator \"vref\"\n");
 		return PTR_ERR(st->reg);
 	}
 
 	ret = regulator_enable(st->reg);
 	if (ret) {
-		dev_err(&spi->dev, "Failed to enable regulator \"refin\"\n");
+		dev_err(&spi->dev, "Failed to enable regulator \"vref\"\n");
 		return ret;
 	}
 
-- 
2.7.4
