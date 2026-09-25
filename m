Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95C47F77E;
	Fri, 25 Sep 2026 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342322; cv=none; b=C0G0BqIWlyZ6Yc+0I8pa2yLLpz1fccp+U5wDhyy7h97irrya1IZR2qaRzgA3JZGT1kGLV+f/3b3ex0nZUNGSqA5J6tbOcdX4k/sJfr1otPih47MQskBBrX/Gcg5G8MHbFzl4qSRZicIGsuMyailrAAhtZKUR24flg/R/A68s6lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342322; c=relaxed/simple;
	bh=N3CU8preQrQRit/qJlUjA+DUYVo4Tf/Ok+l88jhJ7xE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KOI4V8unqsmOVA4C2RAGHqhTAnwIy9yQq2ZZ7d1ukEBfhnD2oiiilAF38FDyZrAA32j+f5itlTsgaKGk2nIqW0oWUtTMvaoifUPWhuuYzXAXjQNrtX1M0z1A//kI2K1NdetHHGzzKtWh3FI3CJmtf+7iLGNNRLiQUzs/GhPlRsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jYj4eaSJ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jYj4eaSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sJ
	PxPgjCOMEYgiOOe97YEHaD+ST1I3sxuzPwHX/OcbA=; b=jYj4eaSJ2HGmOpuyJd
	KuIMor7auEPvVD/ms+jegFz6fKuEozux2YsC/oiC2Y0xPxNZ3Isg5BZRFOc0g6X6
	YhlqtEhfCcB1t2ezPt0Kg2AMupCV8f1DbkUj0WfbKIyxCLE2BppTNByMzl9+NCiE
	YQc9dxvVmMN7FlV+bxkbyb9r8=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3fy9zdLZq8jiZBA--.52716S5;
	Fri, 25 Sep 2026 21:17:44 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Anshul Dalal <anshulusr@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 3/7] iio: dac: mcp4821: reject devices without match data
Date: Fri, 25 Sep 2026 21:17:32 +0800
Message-Id: <20260925131738.2200612-4-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925131738.2200612-1-yaojiale02@163.com>
References: <20260925131738.2200612-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgC3fy9zdLZq8jiZBA--.52716S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFW8Ww45CryrAr43WF1rJFb_yoW8GFyxpa
	n2kF95AryUWF47Kw48WF1Duayaka1rGw4rtFZ7uw13W34Y9Fy0vFy0kFW3ZF4rJFWxCw1x
	tr929345uF12vF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRQyCJUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BiDvWq2dHiDJAAA3h

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL,
but mcp4821_probe() dereferences the result while configuring the IIO
device.

Reject devices without match data before using the chip information.

Fixes: cdf3ecb0d8d0 ("iio: dac: driver for MCP4821")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/dac/mcp4821.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 8d8c00cd60e9..59defb1b5e62 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -255,9 +255,13 @@ static const struct iio_info mcp4821_info = {
 
 static int mcp4821_probe(struct spi_device *spi)
 {
+	const struct mcp4821_chip_info *info;
 	struct iio_dev *indio_dev;
 	struct mcp4821_state *state;
-	const struct mcp4821_chip_info *info;
+
+	info = spi_get_device_match_data(spi);
+	if (!info)
+		return -ENODATA;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
 	if (indio_dev == NULL)
@@ -268,7 +272,6 @@ static int mcp4821_probe(struct spi_device *spi)
 
 	/* default gain is 2x */
 	state->gain = 2;
-	info = spi_get_device_match_data(spi);
 	indio_dev->name = info->name;
 	indio_dev->info = &mcp4821_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.34.1

