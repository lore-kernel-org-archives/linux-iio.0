Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:45405
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753114AbbC3IfS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2015 04:35:18 -0400
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH v3 5/5] iio: mlx90614: Check for errors in read values
Date: Mon, 30 Mar 2015 10:35:02 +0200
Message-Id: <1427704502-22347-6-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1427704502-22347-1-git-send-email-vianney.leclement@essensium.com>
References: <1427704502-22347-1-git-send-email-vianney.leclement@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The device uses the MSB of the returned temperature value as an error
flag.  Return a read error when this bit is set.

Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>

---

v3: return -EIO instead of -EREMOTEIO
v2: new patch
---
 drivers/iio/temperature/mlx90614.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 73ec767..06b7b96 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -196,6 +196,11 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 
 		if (ret < 0)
 			return ret;
+
+		/* MSB is an error flag */
+		if (ret & 0x8000)
+			return -EIO;
+
 		*val = ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
-- 
2.3.4

