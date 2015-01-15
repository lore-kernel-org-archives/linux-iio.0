Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:58528 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376AbbAOWZc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jan 2015 17:25:32 -0500
Received: by mail-we0-f180.google.com with SMTP id w62so17283853wes.11
        for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2015 14:25:30 -0800 (PST)
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: octavian.purdila@intel.com, daniel.baluta@intel.com,
	lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH] iio: light: hid-sensor-als: Use IIO_CHAN_INFO_RAW instead of hardcoded 0
Date: Fri, 16 Jan 2015 00:25:20 +0200
Message-Id: <1421360720-1533-1-git-send-email-roberta.dobrescu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/light/hid-sensor-als.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index a5283d7..e97101d 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -85,7 +85,7 @@ static int als_read_raw(struct iio_dev *indio_dev,
 	*val = 0;
 	*val2 = 0;
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		switch (chan->scan_index) {
 		case  CHANNEL_SCAN_INDEX_ILLUM:
 			report_id = als_state->als_illum.report_id;
-- 
1.9.1

