Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59891 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752970AbbFELBb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 5 Jun 2015 07:01:31 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net
Cc: daniel.baluta@intel.com, knaack.h@gmx.de, lars@metafoo.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 2/6] iio: magnetometer: mmc35240: NULL terminate attribute array
Date: Fri,  5 Jun 2015 14:03:11 +0300
Message-Id: <1433502195-30296-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com>
References: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This avoid nasty crashes when registering the IIO device.

Fixes: abeb6b1e7b ("iio: magnetometer: Add support for MEMSIC MMC35240")
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/mmc35240.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 417eca1..9d62c53 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -125,6 +125,7 @@ static const struct iio_chan_spec mmc35240_channels[] = {
 
 static struct attribute *mmc35240_attributes[] = {
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
 };
 
 static const struct attribute_group mmc35240_attribute_group = {
-- 
1.9.1

