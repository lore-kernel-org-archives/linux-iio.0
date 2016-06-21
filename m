Return-Path: <florian.vaussard@gmail.com>
From: Florian Vaussard <florian.vaussard@gmail.com>
To: devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: [PATCH 1/3] iio: adc: max1363: Fix missing i2c_device_id for MAX1164x parts
Date: Tue, 21 Jun 2016 09:09:27 +0200
Message-Id: <1466492969-2185-2-git-send-email-florian.vaussard@heig-vd.ch>
In-Reply-To: <1466492969-2185-1-git-send-email-florian.vaussard@heig-vd.ch>
References: <1466492969-2185-1-git-send-email-florian.vaussard@heig-vd.ch>
List-ID: <linux-iio@vger.kernel.org>

The driver supports MAX11644, MAX11645, MAX11646 and MAX11647 parts. But
the corresponding i2c_device_id are missing. Add them!

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
---
 drivers/iio/adc/max1363.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 929508e..b5d28c0 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -1680,6 +1680,10 @@ static const struct i2c_device_id max1363_id[] = {
 	{ "max11615", max11615 },
 	{ "max11616", max11616 },
 	{ "max11617", max11617 },
+	{ "max11644", max11644 },
+	{ "max11645", max11645 },
+	{ "max11646", max11646 },
+	{ "max11647", max11647 },
 	{}
 };
 
-- 
2.5.0
