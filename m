Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53557 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968843AbdIZMwp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Sep 2017 08:52:45 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.io,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH 2/2] iio: adc: sun4i-gpadc-iio: do not fail probing when no thermal DT node
Date: Tue, 26 Sep 2017 14:52:19 +0200
Message-Id: <160cf183a167ef841c96c5626f42e23b7195effa.1506430136.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <f7b1b9c493c563a2f5b5f5f44596d45d3d719d26.1506430136.git-series.quentin.schulz@free-electrons.com>
References: <f7b1b9c493c563a2f5b5f5f44596d45d3d719d26.1506430136.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <f7b1b9c493c563a2f5b5f5f44596d45d3d719d26.1506430136.git-series.quentin.schulz@free-electrons.com>
References: <f7b1b9c493c563a2f5b5f5f44596d45d3d719d26.1506430136.git-series.quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Before this patch, forgetting to put a thermal-zones DT node would
result in the driver failing to probe.

It should be perfectly acceptable to have the driver probe even if no
thermal-zones DT is found. However, it shouldn't want to fail if the
thermal registering fail for any other reason (waiting for other drivers
for example) so check on ENODEV only.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 392d47f..46fe0b5 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -652,7 +652,11 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
 		info->tzd = thermal_zone_of_sensor_register(info->sensor_device,
 							    0, info,
 							    &sun4i_ts_tz_ops);
-		if (IS_ERR(info->tzd)) {
+		/*
+		 * Do not fail driver probing when failing to register in
+		 * thermal because no thermal DT node is found.
+		 */
+		if (IS_ERR(info->tzd) && PTR_ERR(info->tzd) != -ENODEV) {
 			dev_err(&pdev->dev,
 				"could not register thermal sensor: %ld\n",
 				PTR_ERR(info->tzd));
-- 
git-series 0.9.1
