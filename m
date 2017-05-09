Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35538 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbdEICAm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 May 2017 22:00:42 -0400
From: Harinath Nampally <harinath922@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: iio: meter: Add the comment for mutex definition
Date: Mon,  8 May 2017 22:00:37 -0400
Message-Id: <3aa61726d979dbaf85a116341d169a933218904b.1494293664.git.harinath922@gmail.com>
In-Reply-To: <cover.1494293664.git.harinath922@gmail.com>
References: <1494216977-26852-1-git-send-email-harinath922@gmail.com>
 <cover.1494293664.git.harinath922@gmail.com>
In-Reply-To: <cover.1494293664.git.harinath922@gmail.com>
References: <cover.1494293664.git.harinath922@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes below checkpatch.pl warning:
CHECK: struct mutex definition without comment

Signed-off-by: Harinath Nampally <harinath922@gmail.com>
---
 drivers/staging/iio/meter/ade7753.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index b71fbd3..cffe6bf 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -78,12 +78,13 @@
 /**
  * struct ade7753_state - device instance specific data
  * @us:         actual spi_device
+ * @buf_lock:       mutex to protect tx and rx
  * @tx:         transmit buffer
  * @rx:         receive buffer
- * @buf_lock:       mutex to protect tx and rx
  **/
 struct ade7753_state {
 	struct spi_device   *us;
+ /* mutex to protect tx and rx */
 	struct mutex        buf_lock;
 	u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
 	u8          rx[ADE7753_MAX_RX];
-- 
2.7.4

