Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53150 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670AbcFTMz1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2016 08:55:27 -0400
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, Mark Brown <broonie@kernel.org>
Date: Mon, 20 Jun 2016 13:53:34 +0100
Message-Id: <1466427214-13372-3-git-send-email-broonie@kernel.org>
In-Reply-To: <1466427214-13372-1-git-send-email-broonie@kernel.org>
References: <1466427214-13372-1-git-send-email-broonie@kernel.org>
Subject: [PATCH 3/3] iio:ad7266: Fix probe deferral for vref
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently the ad7266 driver treats any failure to get vref as though the
regulator were not present but this means that if probe deferral is
triggered the driver will act as though the regulator were not present.
Instead only use the internal reference if we explicitly got -ENODEV which
is what is returned for absent regulators.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/adc/ad7266.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 655b36b4e9cb..2123f0ac2e2a 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -408,6 +408,9 @@ static int ad7266_probe(struct spi_device *spi)
 
 		st->vref_mv = ret / 1000;
 	} else {
+		/* Any other error indicates that the regulator does exist */
+		if (PTR_ERR(st->reg) != -ENODEV)
+			return PTR_ERR(st->reg);
 		/* Use internal reference */
 		st->vref_mv = 2500;
 	}
-- 
2.8.1

