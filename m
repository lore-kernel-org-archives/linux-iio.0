Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:51797 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbaL3S6a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Dec 2014 13:58:30 -0500
Received: by mail-wg0-f54.google.com with SMTP id z12so3266224wgg.27
        for <linux-iio@vger.kernel.org>; Tue, 30 Dec 2014 10:58:28 -0800 (PST)
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 1/3] iio: accel: kxcjk-1013: Add a blank line after declarations
Date: Tue, 30 Dec 2014 20:57:53 +0200
Message-Id: <1419965875-4298-2-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1419965875-4298-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1419965875-4298-1-git-send-email-roberta.dobrescu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes the following checkpatch.pl warning:
WARNING: Missing a blank line after declarations

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/accel/kxcjk-1013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index da2fe93..b3a2da5 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1134,6 +1134,7 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
 					       enum kx_chipset *chipset)
 {
 	const struct acpi_device_id *id;
+
 	id = acpi_match_device(dev->driver->acpi_match_table, dev);
 	if (!id)
 		return NULL;
-- 
1.9.1

