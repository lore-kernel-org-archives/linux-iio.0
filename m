Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/6 v3] iio: magn: ak8975: make sure to power down at remove()
Date: Wed, 29 Jun 2016 14:08:37 +0200
Message-Id: <1467202118-10386-6-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1467202118-10386-1-git-send-email-linus.walleij@linaro.org>
References: <1467202118-10386-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The code was not powering the magnetometer down properly at
remove(): just cutting the regulators without first setting the
device in power off mode. Fix this.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebase
ChangeLog v1->v2:
- New patch in the series after Ulf's review comment that this
  should be separate.
---
 drivers/iio/magnetometer/ak8975.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index c67cf3a6128d..43dc1c74be9e 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -990,6 +990,7 @@ static int ak8975_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
+	ak8975_set_mode(data, POWER_DOWN);
 	ak8975_power_off(data);
 
 	return 0;
-- 
2.4.11
