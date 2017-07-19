Return-Path: <SRS0=DHhl=6W=pengutronix.de=p.zabel@kernel.org>
From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-iio@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 031/102] iio: adc: rockchip_saradc: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:25:35 +0200
Message-Id: <20170719152646.25903-32-p.zabel@pengutronix.de>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-iio@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/iio/adc/rockchip_saradc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index ae6d3324f5183..1d9300ba07c00 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -235,7 +235,8 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	 * The reset should be an optional property, as it should work
 	 * with old devicetrees as well
 	 */
-	info->reset = devm_reset_control_get(&pdev->dev, "saradc-apb");
+	info->reset = devm_reset_control_get_exclusive(&pdev->dev,
+						       "saradc-apb");
 	if (IS_ERR(info->reset)) {
 		ret = PTR_ERR(info->reset);
 		if (ret != -ENOENT)
-- 
2.11.0
