Return-Path: <SRS0=E05V=UN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6012EC31E4D
	for <linux-iio@archiver.kernel.org>; Fri, 14 Jun 2019 12:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384D521537
	for <linux-iio@archiver.kernel.org>; Fri, 14 Jun 2019 12:26:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="hGR6AaYh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfFNM0V (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:26:21 -0400
Received: from first.geanix.com ([116.203.34.67]:45588 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfFNM0V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Jun 2019 08:26:21 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 698EA15E7;
        Fri, 14 Jun 2019 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1560515024; bh=Q55+y5FCnPGxjbYwSAjj0h4LtPd90K6HM8R/INm0QDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hGR6AaYhfQWMT6xMuvFp8gvv1XXX8Ka7vRsMQKy0+6HK9+HCKqXAKGA+R8ANadmvU
         0DxGxv789ki/Y5zPBgwN6mgYHy2sMtUaxxAC/ru2bD1ti19efy+KDmEiLlk7EW7F1W
         jyP4V8hKwGFz021nRFObZ0xPNfIenrrQFR11YmH2fZW3+83ziA5nBQhn2QGRBamOl6
         429Dek2+peXy7DfHZOWQ+U9ZwYscEp/IKZXe4+ggIU1nkTwmhtdPmQG/Dik3QFAl9s
         WgTKFKppnMCR2IV+L7Hg/MUdEW43yu3k/kKvNwjRks7TorxuNmi6QSBWzSe1KsUQeC
         AIaqA8VxW62iA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>, lorenzo.bianconi83@gmail.com,
        denis.ciocca@st.com, martin@geanix.com
Subject: [RFC PATCH 2/3] iio: imu: st_lsm6dsx: add wake on accelerometer enable hook in sysfs
Date:   Fri, 14 Jun 2019 14:26:03 +0200
Message-Id: <20190614122604.52935-3-sean@geanix.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190614122604.52935-1-sean@geanix.com>
References: <20190614122604.52935-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds a wakeup_enabled hook in sysfs.
If wakeup-source is enabled, wake on accelerometer event is default active.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 092c4d02bd4e..2c8ad7d65d2f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -630,15 +630,46 @@ static ssize_t st_lsm6dsx_sysfs_scale_avail(struct device *dev,
 	return len;
 }
 
+static ssize_t st_lsm6dsx_sysfs_get_wakeup_enabled(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+
+	if (device_may_wakeup(hw->dev))
+		return sprintf(buf, "%d\n", 1);
+	return sprintf(buf, "%d\n", 0);
+}
+
+static ssize_t st_lsm6dsx_sysfs_set_wakeup_enabled(struct device *dev,
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
+{
+	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+
+	if (strncmp(buf, "1", 1) == 0)
+		device_set_wakeup_enable(hw->dev, true);
+	else
+		device_set_wakeup_enable(hw->dev, false);
+
+	return len;
+}
+
 static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sysfs_sampling_frequency_avail);
 static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
 		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
+static IIO_DEVICE_ATTR(wakeup_enabled, 0644,
+		       st_lsm6dsx_sysfs_get_wakeup_enabled,
+		       st_lsm6dsx_sysfs_set_wakeup_enabled, 0);
 static IIO_DEVICE_ATTR(in_anglvel_scale_available, 0444,
 		       st_lsm6dsx_sysfs_scale_avail, NULL, 0);
 
 static struct attribute *st_lsm6dsx_acc_attributes[] = {
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
+	&iio_dev_attr_wakeup_enabled.dev_attr.attr,
 	NULL,
 };
 
-- 
2.22.0

