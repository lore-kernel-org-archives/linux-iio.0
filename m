Return-Path: <lee.jones@linaro.org>
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk
Cc: arnd@arndb.de,
	linus.walleij@linaro.org,
	denis.ciocca@st.com,
	linux-iio@vger.kernel.org,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 37/38] iio: magn-core: st: Give some indication if device probing was successful
Date: Tue, 10 Sep 2013 13:49:38 +0100
Message-Id: <1378817379-8238-38-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

At the moment the driver is silent in some error cases and if successful.
Prior to this patch there was no clear way to know if the driver succeeded
or not without looking deep into sysfs.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/magnetometer/st_magn_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index c252659..12e7e79 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -386,6 +386,9 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
 	if (err && irq > 0)
 		goto st_magn_device_register_error;
 
+	if (!err)
+		dev_info(&indio_dev->dev, "Successfully registered\n");
+
 	return err;
 
 st_magn_device_register_error:
-- 
1.8.1.2
