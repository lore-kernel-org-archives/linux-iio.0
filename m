Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA94D90C5;
	Fri,  4 Sep 2026 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531410; cv=none; b=MG83birIElPmoI6RvrriMfJZizDjOErS6T+phCJHhOjarG/I4UQHhOwZC7GeyIjzYPvYgVBopwIVecc4yNXeRQphpKyfE7gycF2qXBU+KXPtgYa9mXsZLvF9+6cy77581Hw9UGCsKkAebC1zUTqXI0UgA5wm7EUZmdUszktUaig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531410; c=relaxed/simple;
	bh=E9UNKcEjX4DUVKS2p1M8UezZRQMGWnYYqPo8Ji+H19I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=n+csvycUWXqXVhmn/h/pY3rCH22wecv81J1sEqF5ADa1Xa8YFE2lKZiJbXOty46NOMM/aI5fsyTOu0DP7MY9nk2dzBFelp+ibNBhRD4Bhmo+kTVyG7TRE8uZHg2gy8M1O+dYW66WStHMKX9GiCzP8E/RKXhBZbjeUlJYpNGsxTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xgEwSJVn; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xgEwSJVn"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684DgXJq332955;
	Fri, 4 Sep 2026 10:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SYuzW
	h4efkNPHpCNZxKjW76NbnH09MIS0ZZTYMBrZMw=; b=xgEwSJVnf/WHBi9J0ie6S
	babTV5dyTxYS2zp1JDYU6AUk9Aba9i/FHaEjXKbcrCT6u88fvhM9RF8eF+d7OnyQ
	wjY7L1WN0h4Jo3posGfjEs/rn0dO3agGD6Fs6jX30J/6U577IxaV3tqvU7O0ZWik
	r2ewOePENR0GUwdss+1bm2wwnpdD4+gWMg4rrvik3MUvtpVuQbFTYbJ5TFT1d7z5
	gM3eQdi0U5RP4qW8GIy4uYKkkBr+fQjUy6dzxx0N/u2YhQw0L8fJ//g7CKUDDGP+
	LN0KFUu7qRGw8dbseGWgQmABpBW8i4UKY5bKPQOdFSKgTSR8ynwBpeR2IOGL262f
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gffkkmff9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:16:25 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EGOLM036406
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:16:24 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 4 Sep
 2026 10:16:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:16:24 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2dK026210;
	Fri, 4 Sep 2026 10:16:16 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 4 Sep 2026 16:15:08 +0200
Subject: [PATCH v6 16/17] iio: adc: ad7768: Register GPIO auxiliary device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-ad7768-driver-v6-16-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
In-Reply-To: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=2350;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=E9UNKcEjX4DUVKS2p1M8UezZRQMGWnYYqPo8Ji+H19I=;
 b=W/6uMKLGc1hZgvf7LqjjT7rDQTfZjTiWolHPNv72/eYTH6du6RBDF/GA5vIxhP99alapy83Do
 ZqbWzW4eF5VCMBfe5T24nWbA7W/YDVnOeo6gCCB4u4p+KLkxL4rhGHH
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: uS_AToryl6Tc1SN7yHeI5S0mwQLc54fD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX1+yrCDIT0suW
 wLl5PH53LNFPCYWOwQUo1c1zkpaAN6ybuuxZuGDpATGUce+kXIBw6L0yoICWVmp0sbP0hXIziZK
 A8qAwhy9JRyjo2Q6uVHafBbb3J9NQ7RoUTEK6PPUaDSFCNzakwGG3r6A6BAAfXOOh++NMPSt6n3
 2lB5/PdQZMqtnwxnPmxSDKBAbeYbb8oFNjlHf0WIV2d0wk+9NHFzpL2EsqxT/mlZaoHiF5bC7K3
 P2s8HEaSBJKIheA4C+zlw/f8sZaQiVsVuCpJnsQ7g2OTo7LR53uPUmjc6NrdmyrQsjm3oEyr8ts
 3czcak6RqZXu+Tr4qPyVC5uDwtdeXspstX8jexfvBa0KMzucsTCP9WkkCCE3ShJgXowXQBTrdi8
 D2EcYv+r9OqMo0fl8s4zA1oF7vtGRMTWyuHrDUkZnO9VeEe0o7XqBUrbBb/mTAQsBWLmSp8CLAq
 oLn9r39+3A0Jg1yYASA==
X-Proofpoint-ORIG-GUID: uS_AToryl6Tc1SN7yHeI5S0mwQLc54fD
X-Authority-Analysis: v=2.4 cv=F6NnsKhN c=1 sm=1 tr=0 ts=6a9ad2b9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=uS1bAgcam2TDL027Z10A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX/SdGLXxqx3lw
 Ty/ZzYeziHe3cilY/5M17GzsvcgDMXSn+U1/yK1EFs3ao3Ts2RCh5a2qmocQVUfaFIBWZaQS1ly
 DaTinw6XcdKJqh6tMLxquYH/YJHZ8PFsIbnfvlCqQaD75TbXM4Pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040130

Register an auxiliary device when the AD7768 is described as a GPIO
controller. This allows the GPIO driver to share the parent regmap and
runtime power-management state.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/Kconfig  |  1 +
 drivers/iio/adc/ad7768.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index c784bee0fd65..dea25315ed20 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -435,6 +435,7 @@ config AD7768
 	tristate "Analog Devices AD7768/AD7768-4 ADC driver"
 	depends on SPI
 	select REGULATOR
+	select AUXILIARY_BUS
 	select IIO_BUFFER
 	select IIO_BACKEND
 	select REGMAP
diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 4acf89bdad12..ecb7e8554d6d 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
@@ -1245,6 +1246,30 @@ static const struct iio_info ad7768_info = {
 	.update_scan_mode = ad7768_update_scan_mode,
 };
 
+static int ad7768_gpio_adev_init(struct ad7768_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	struct auxiliary_device *adev;
+	int id;
+
+	if (!device_property_read_bool(dev, "gpio-controller"))
+		return 0;
+
+	/*
+	 * Use the SPI bus number and chip select to derive a stable per-device
+	 * ID.
+	 */
+	id = (spi->controller->bus_num << 8) | spi_get_chipselect(spi, 0);
+	adev = __devm_auxiliary_device_create(dev, KBUILD_MODNAME, "gpio",
+					      NULL, id);
+	if (!adev)
+		return dev_err_probe(dev, -ENODEV,
+				     "Failed to create GPIO auxiliary device\n");
+
+	return 0;
+}
+
 static int ad7768_configure_precharge_buffers(struct iio_dev *indio_dev,
 					      struct ad7768_precharge_config *precharge_cfg)
 {
@@ -1794,6 +1819,10 @@ static int ad7768_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret,
 				     "Failed to register VCM regulator\n");
 
+	ret = ad7768_gpio_adev_init(st);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.43.0

