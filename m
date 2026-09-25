Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269C844AB97;
	Fri, 25 Sep 2026 13:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342307; cv=none; b=IvsLa0m5MP0L9C2WLuOrqriFZykLWurIQz1MOgYird9VJUWMqksScDODZszGZ9shSBW2ZmbILj1gh6RztOWfqawvnQ0Rm7XiQ6DJYLLjGmFxfI2fD7lF/sP+V+3/Zj9i6HakKkNoY3Cycp7qp/fRlGOm6VydaXPONuh0EuHwxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342307; c=relaxed/simple;
	bh=B5HDsDJA6Dzasd5ZNWPJ3oGkSuGmp6dK+9CEVZgY0zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lm97qmWjWIeQZ9zpziGDLqVAM7Cc3eAfdUWfDXjeFFKNJF9nH64IRoPCBXDCQ666is8fynJug0fK8HT7NwfIY6zOn+87BU0asUcMncNquD9NTelcggcS+DcvTTGNh3jr8civfRkTp7fJlLe+9whHO42uOQHef6rBjvFQSgFf+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UqGT8r9O; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UqGT8r9O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=qo
	vAzRDT/grq26oU1C3jLQStdMoNOIu34uwoMgQ+WDc=; b=UqGT8r9Os3Dx1xNHiO
	9y2e3hNZbb5WRVpsotceHqKnjA+eNHOmd/oUMSpTJkED7aUkAKVJXWxmnrN8m7mf
	xK5psMBMvFouFZhENioG3rsYxt+iQlfHLDC7KKkTU45QEgiiL8Wmt6t2AGpYAuIx
	nleAL0+7yZMeFSKuTjrKFgpPI=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgC3fy9zdLZq8jiZBA--.52716S8;
	Fri, 25 Sep 2026 21:17:49 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Herve Codina <herve.codina@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 6/7] iio: potentiometer: x9250: reject devices without match data
Date: Fri, 25 Sep 2026 21:17:35 +0800
Message-Id: <20260925131738.2200612-7-yaojiale02@163.com>
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
X-CM-TRANSID:PCgvCgC3fy9zdLZq8jiZBA--.52716S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFW8Ww45CryrCrWrGw43trb_yoW8Wr45pF
	ZrWa4YyryjkFy7G3yUC39F9a45Kw4S9w45WrWkG34a9r4rZFWUtF10y34ruFyrAFZ5G3W3
	KrWUt3yxuF1IvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zK2NttUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzR2Evmq2dH35IAAA3m

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL,
but x9250_probe() later dereferences the result while naming the IIO
device.

Reject devices without match data before enabling the regulators.

Fixes: 66bfc528a6fd ("iio: potentiometer: Add support for the Renesas X9250 potentiometers")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/iio/potentiometer/x9250.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/potentiometer/x9250.c b/drivers/iio/potentiometer/x9250.c
index 974e4447fc2c..675b78677baa 100644
--- a/drivers/iio/potentiometer/x9250.c
+++ b/drivers/iio/potentiometer/x9250.c
@@ -155,10 +155,15 @@ static const char *const x9250_regulator_names[] = {
 
 static int x9250_probe(struct spi_device *spi)
 {
+	const struct x9250_cfg *cfg;
 	struct iio_dev *indio_dev;
 	struct x9250 *x9250;
 	int ret;
 
+	cfg = spi_get_device_match_data(spi);
+	if (!cfg)
+		return -ENODATA;
+
 	ret = devm_regulator_bulk_get_enable(&spi->dev, ARRAY_SIZE(x9250_regulator_names),
 					     x9250_regulator_names);
 	if (ret)
@@ -176,7 +181,7 @@ static int x9250_probe(struct spi_device *spi)
 
 	x9250 = iio_priv(indio_dev);
 	x9250->spi = spi;
-	x9250->cfg = spi_get_device_match_data(spi);
+	x9250->cfg = cfg;
 	x9250->wp_gpio = devm_gpiod_get_optional(&spi->dev, "wp", GPIOD_OUT_LOW);
 	if (IS_ERR(x9250->wp_gpio))
 		return dev_err_probe(&spi->dev, PTR_ERR(x9250->wp_gpio),
-- 
2.34.1

