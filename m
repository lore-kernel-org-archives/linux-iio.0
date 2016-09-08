Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59511 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966123AbcIHO3Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Sep 2016 10:29:24 -0400
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/3] hwmon: iio_hwmon: defer probe when no channel is found
Date: Thu,  8 Sep 2016 16:28:35 +0200
Message-Id: <1473344917-1524-2-git-send-email-quentin.schulz@free-electrons.com>
In-Reply-To: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

iio_channel_get_all returns -ENODEV when it cannot find either phandles and
properties in the Device Tree or channels whose consumer_dev_name matches
iio_hwmon in iio_map_list. The iio_map_list is filled in by iio drivers
which might be probed after iio_hwmon.

It is better to defer the probe of iio_hwmon if such error is returned by
iio_channel_get_all in order to let a chance to iio drivers to expose
channels in iio_map_list.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v5:
 - patch re-inserted,

v3:
 - patch removed,

 drivers/hwmon/iio_hwmon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/iio_hwmon.c b/drivers/hwmon/iio_hwmon.c
index b550ba5..c0da4d9 100644
--- a/drivers/hwmon/iio_hwmon.c
+++ b/drivers/hwmon/iio_hwmon.c
@@ -73,8 +73,11 @@ static int iio_hwmon_probe(struct platform_device *pdev)
 		name = dev->of_node->name;
 
 	channels = iio_channel_get_all(dev);
-	if (IS_ERR(channels))
+	if (IS_ERR(channels)) {
+		if (PTR_ERR(channels) == -ENODEV)
+			return -EPROBE_DEFER;
 		return PTR_ERR(channels);
+	}
 
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (st == NULL) {
-- 
2.5.0

