Return-Path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-iio@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caesar Wang <wxt@rock-chips.com>,
	dianders@chromium.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] iio: adc: rockchip_saradc: Explicitly disable ADC on probe
Date: Mon, 25 Jul 2016 12:39:00 -0700
Message-Id: <1469475540-26855-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-iio@vger.kernel.org>

If the ADC is read for the first time, the caller gets a timeout error,
and the kernel log shows

read channel() error: -110

The ADC may be enabled on boot, and needs to be explicitly disabled
for a read sequence to work (otherwise there is no completion interrupt).
Disaple it explicitly in the probe function.

Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/iio/adc/rockchip_saradc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index f9ad6c2d6821..6aa3271d86b5 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -280,6 +280,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 		goto err_pclk;
 	}
 
+	/* Make sure ADC is disabled */
+	writel_relaxed(0, info->regs + SARADC_CTRL);
+
 	platform_set_drvdata(pdev, indio_dev);
 
 	indio_dev->name = dev_name(&pdev->dev);
-- 
2.5.0
