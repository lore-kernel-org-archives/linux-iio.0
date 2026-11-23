Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795406095;
	b=HjCisO583SkRL20gox6spm2Ropyj52nnJodW0u+UNs+sJ19O9cStzGeDOlkXlRaf7yhu
	 bxI7l8zZki/p8iLvmQT504Av3c81b9HROzMAwRAOoK12Kb9RrtC7cQw6+l/DcZqKdsJ0s
	 cdSnvMk4ndvDQa4eOvoeDvhEzTFqNBQjFTSnzcKSCfX8XQXmCzm4c48qao93KwIpsNcNo
	 ljTlWmPRB+giFLlEOrtMllakF1QbZBd4URMGpbp2nL4/v29n7Fa3ks8u2pydg5/vqbtzr
	 +75qOqEzgfZA1ci5DjMEHkHFWY9J3XCfsh6jwT6Mp84WJ+ztTN1PlWWqZ2gPzlJ3uZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795406095;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=JdlCUYdz6ssS/wsuNR8ZuH4WEG4iO02VeWREs29zpVk=;
	b=qi0KHJCL/mI9+aAtg+OtqRutjy07jOaWDVvzgNY0645lP6/0FOhAiImizZi0xe1nD2cL
	 DuAPWllLz986WDjiwNcHWnOSeoDketRVztiTy5I/xxQQxq5xbtw0hqgyBgYgL8sb5JVUE
	 XgA2bxKbg+kMM5Rp1MCNRcKvn4bIjPkL/dCu7rx0efRoN1dbxaNzYpfN73ZQ/55bMyGbU
	 ybb5hcSXuqkBl0lDi6zefenvXCXPLFuyFq3KR0ziIJrvujmzwqwvrIoIRTvYivKdR/wlI
	 mYp406ewfG2Cbbn45gTfDHzwiyhm4Ex4qnFngpoJf9tQnj4D5plQDflwfUIbEUs93bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IJ8J7OEY;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA26606A332;
	Mon, 23 Nov 2026 03:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FA26606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=IJ8J7OEY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Jd
	lCUYdz6ssS/wsuNR8ZuH4WEG4iO02VeWREs29zpVk=; b=IJ8J7OEYOkftwj920F
	TdOET2MxJzA3dikGqZ8HgRU1UjGBNR7mZSuS5I8TKm1KjLwH1swKAntqfMrGnieP
	rH2VijKGEfcNpDoYqQMejBO/MeZklEhAXQMKr3X7yOnbqG/MqD08y2H96MBBXfrt
	jDIo/pXlbWIumznm42hT77NyY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBX3UDhuANrzxO8Hg--.53023S5;
	Mon, 23 Nov 2026 11:54:18 +0800 (CST)
From: Wanhui Fu <fuwh1120@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Wanhui Fu <fuwh1120@163.com>
Subject: [PATCH v2 3/3] iio: adc: twl6030-gpadc: delete redundant dev_err() messages in probe
Date: Mon, 23 Nov 2026 11:53:31 +0800
Message-Id: <20261123035331.1871875-4-fuwh1120@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261123035331.1871875-1-fuwh1120@163.com>
References: <20261123035331.1871875-1-fuwh1120@163.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgBX3UDhuANrzxO8Hg--.53023S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw13Gw18CF1rXw17GFyxGrg_yoW8GFyUpa
	9xtF1akrWktw4Skr1DJFnxZF98Gryqk3yIqFW7Gw1Sqay5ZrnxWrn8Jr10vF18GF98J3sx
	AwsxZFyqkF4UZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1T5LUUUUU=
X-CM-SenderInfo: xixzxiqrsqqiywtou0bp/xtbC7QoEo2sDuOrJUAAA3j

twl_i2c_write() already logs error messages on I2C transfer
failures, so remove redundant dev_err() to simplify the probe
function.

Signed-off-by: Wanhui Fu <fuwh1120@163.com>
---
 drivers/iio/adc/twl6030-gpadc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 591c7b3322c7..6e20e5a31211 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -935,30 +935,22 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, TWL6030_GPADCS,
 					TWL6030_REG_TOGGLE1);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable GPADC module\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = twl_i2c_write_u8(TWL_MODULE_USB, VBUS_MEAS, USB_VBUS_CTRL_SET);
-	if (ret < 0) {
-		dev_err(dev, "failed to wire up inputs\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = twl_i2c_write_u8(TWL_MODULE_USB, ID_MEAS, USB_ID_CTRL_SET);
-	if (ret < 0) {
-		dev_err(dev, "failed to wire up inputs\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0,
 				VBAT_MEAS | BB_MEAS | VAC_MEAS,
 				TWL6030_MISC1);
-	if (ret < 0) {
-		dev_err(dev, "failed to wire up inputs\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	indio_dev->name = DRIVER_NAME;
 	indio_dev->info = &twl6030_gpadc_iio_info;
-- 
2.25.1

