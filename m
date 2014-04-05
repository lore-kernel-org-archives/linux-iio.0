Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41678 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbaDEQoP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Apr 2014 12:44:15 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, sr@denx.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 6/6] staging:iio:adc:spear rename spear_read_raw to spear_adc_read_raw
Date: Sat,  5 Apr 2014 17:45:15 +0100
Message-Id: <1396716315-2465-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1396716315-2465-1-git-send-email-jic23@kernel.org>
References: <1396716315-2465-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This brings it inline with all the other prefix usage in the driver.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/spear_adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/staging/iio/adc/spear_adc.c
index 52c26a6..a6ad9de 100644
--- a/drivers/staging/iio/adc/spear_adc.c
+++ b/drivers/staging/iio/adc/spear_adc.c
@@ -136,11 +136,11 @@ static void spear_adc_set_scanrate(struct spear_adc_state *st, u32 rate)
 	}
 }
 
-static int spear_read_raw(struct iio_dev *indio_dev,
-			  struct iio_chan_spec const *chan,
-			  int *val,
-			  int *val2,
-			  long mask)
+static int spear_adc_read_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val,
+			      int *val2,
+			      long mask)
 {
 	struct spear_adc_state *st = iio_priv(indio_dev);
 	u32 status;
-- 
1.9.0

