Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0453254A8;
	Wed, 24 Jun 2026 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280412; cv=none; b=gloXRD3c7zL/4jNx0+psTMQR/aHXcEDfOthjcJROGuuXVvl5KPhy6Zf6QF75+edq7kz20mNhPHhxV+I2o0jtHZiN0r4XYveJR7NPdT3ITQ51V0jOweaoLLMJ4gDo8PdKQsMfS+YScJ+upxKj8n686jnnxEbv+W0eb2ZoZ+2nLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280412; c=relaxed/simple;
	bh=3r7dyKz0Aao1+l+/GtuvMKVzzk4LiO4Y2X4aYJayh7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcemxOQTjfI8sCGpI/PqeqWhz1yORVof/dxVuOrldBnORwZv3v741ZP5J+7CIqQNrc+aCOPnqZUwlwbt2cwlKU5iYPiF8G6ksx17/84brs/5a8cH3OQPq26QTcVmGgCpoHsJ7CqRMuC7DQBgBwxLTEi/lbFavCkn/QrfahXqfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowACXuN_WcDtqrBetFQ--.13344S2;
	Wed, 24 Jun 2026 13:53:26 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads124s08: Return reset failures
Date: Wed, 24 Jun 2026 13:53:25 +0800
Message-ID: <20260624055325.32388-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXuN_WcDtqrBetFQ--.13344S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4UuF4fGrW5Gr1DJF45Awb_yoW8WFy8pF
	s5XFy3tryvkF10vr4UX3WxuFWrC3Waka1UWF47Xw1Duw45Zw4YkF43KFyYvryrAFy8Zaya
	qrWUKrW5uF10vw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmjgxUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

devm_gpiod_get_optional() returns NULL when the optional GPIO is absent,
but returns an ERR_PTR when the provider lookup fails.  Probe currently
logs the ERR_PTR case and keeps the error pointer in reset_gpio.

Later ads124s_reset() treats any non-NULL reset_gpio as valid and passes
it to gpiod_set_value_cansleep().  Return the lookup error instead of
retaining the ERR_PTR.

Also return ads124s_reset() failures so probe does not register the IIO
device after either the GPIO reset path or the software reset command
failed.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/iio/adc/ti-ads124s08.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 8ea1269f74db..57eed8554bd9 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -321,7 +321,8 @@ static int ads124s_probe(struct spi_device *spi)
 	ads124s_priv->reset_gpio = devm_gpiod_get_optional(&spi->dev,
 						   "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ads124s_priv->reset_gpio))
-		dev_info(&spi->dev, "Reset GPIO not defined\n");
+		return dev_err_probe(&spi->dev, PTR_ERR(ads124s_priv->reset_gpio),
+				     "Failed to get reset GPIO\n");
 
 	ads124s_priv->chip_info = &ads124s_chip_info_tbl[spi_id->driver_data];
 
@@ -342,7 +343,9 @@ static int ads124s_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	ads124s_reset(indio_dev);
+	ret = ads124s_reset(indio_dev);
+	if (ret)
+		return ret;
 
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
-- 
2.50.1 (Apple Git-155)

