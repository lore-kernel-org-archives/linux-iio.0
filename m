Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5] iio: magn: ak8975: allow a delay after enabling regulators
Date: Wed, 22 Jun 2016 00:18:17 +0200
Message-Id: <1466547498-15484-5-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466547498-15484-1-git-send-email-linus.walleij@linaro.org>
References: <1466547498-15484-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The datasheet actually specifies that we need to wait atleast
500us after powering on the device before trying to set mode.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/magnetometer/ak8975.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 8844e6f45c8e..1c6e4157a91f 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -399,6 +399,12 @@ static int ak8975_power_on(const struct ak8975_data *data)
 			 "Failed to enable specified Vid supply\n");
 		return ret;
 	}
+	/*
+	 * According to the datasheet the power supply rise time i 200us
+	 * and the minimum wait time before mode setting is 100us, in
+	 * total 300 us. Add some margin and say minimum 500us here.
+	 */
+	usleep_range(500, 1000);
 	return 0;
 }
 
-- 
2.4.11
