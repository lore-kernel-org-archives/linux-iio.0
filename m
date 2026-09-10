Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583FD525A6C;
	Thu, 10 Sep 2026 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061911; cv=none; b=lbT07FJZCQyNXgSOwjHl3P4Tkx8zyvLu0D/45KU9r9ACQRFkp7f+dgYFAMtJ5PEZVBvLehECrygFBSk4y1kHhuOaeRusUF7DxkjemkE0iPGNkq8ov9INhEJwCAjPzKzXVoB9FPv/rXB5mKc/OECMzR38SJypjdvb5DJV/12YehQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061911; c=relaxed/simple;
	bh=ZbahpWduP8YHLKbdzErxK/72k0S/dRZzxcd0QQoIieo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eJZhE9LXFOFhOfwaFoOBz66iYNbESdlBAoHXjSPXRh6fP4duyuo5i1mi8fgChBiYzc2YypAeaT45pcTJnOD7riH2+P6UgLBMuy2LqsW0gK4ybulpI5bYgZSU2s5A8m5naRo2U44IH+LfRQlyevqkpvncyBNtrOXNp0duDxWHNtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Yhoy2ReB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Yhoy2ReB"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF7Oqb343068;
	Thu, 10 Sep 2026 13:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=K/kyT
	eZY3WfeTT8Uo+RlAB3ohPlOAbMLgtjBlui0QKA=; b=Yhoy2ReBh4gcWDJulZekQ
	8Z8fQlhpp+5nCmueK0+6MQyIQdcmnfE4OhAQUiYNQQrEUQTIxXCtd88SItd0RwIH
	TXXrQH7ktSsroGNAUMvEEhQH8MWyXdk1tUnlJZWYKK1JtcJI/fuGxnuRZUCQziBF
	oZZcP6xqakE5VkzQDS63iCh61afHIzPPhNL3sB0fs4V5/lHDZB8bysDJJKxisHpR
	3nEpqxyED2ZB/mwFHD07WRpMCNPjRN9kC8iXnRm1+mPe7xadP0LswvTldgS/tE1I
	10NwF4W5priPxQBlHDWr81LfuR30BfLJSozWRkmK8OKz1upzoC5XYf6/GtCO8QM5
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcx9522v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:55 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHbsKs038874
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:54 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:54 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:54 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSm018832;
	Thu, 10 Sep 2026 13:37:48 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:34 +0200
Subject: [PATCH v7 16/17] iio: adc: ad7768: Register GPIO auxiliary device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-16-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=2350;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=ZbahpWduP8YHLKbdzErxK/72k0S/dRZzxcd0QQoIieo=;
 b=T6GH9KF6QJhJ/k8j42XnBEtJdRRGRnCkhGvD8g8+7NyGTMdG85SBRBPyvjAMNRPNdrOZcuzYF
 kZ1KiMxtHpCDnWlgzMLYMfW0ZwODMb9H+YjWik9fR5Ma7Ynq0ZW3w15
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX4pInyLisYso6
 tStmaX4cXjm+JhO+25XfLc8eFMZqXwHXoqzEbWmPOAZtKkWZvU48uBefzFWvQ7tivwIva22Rmv/
 /RObHVolPzHvSh6uppFI/mFpYS1c1KZIf0t2gDwMQCLbxnSvA2Th
X-Proofpoint-GUID: -5vwwUgNt0gd0Wi6smcz5BViGZx78E5i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX1F37ljvhX6IA
 yCjSu08e5UF18obLZRM+3PzSqbKYyMtmzc0U55/ENgWLTl+Tl8rFRZSifXQ5qAAl5789nAQ286J
 +57XDvjR0+mV8a6j4HIrTp8LfZBUxiWpMDZVdR6jscsVpflyvnVTc9rx8qU2fqQLlqmadAjCCHu
 bwvbMY3sehCWt5PeCK7eNbzbc9+MO0WgKwyYCXFJkFJiXU8krF0yFTba5xlGrFRdyvVX3xD29i4
 yytDBW11wUj132BOmf/aTOz7whQchewKaFCsWTTdcqK2+Ii3KxpoNMR4WjOOlE1ujkKw9z15Wdf
 8DK7vXVzTXkLuSsDS4qcSOH2h1hlBR+HiNZsBF79DZUmJE4ap8tJPpXTYvhwfCQRFU53YSnbbId
 gzCzyJZR3uCOLiyGgcSDy5zDOZGmsW9FnSA7LTb73THyXM6RdWY55Rb7148b9Z5Xp6YzxtIk30j
 L8Ixpi7bo8LpBbVoBzQ==
X-Authority-Analysis: v=2.4 cv=G8CJgNk5 c=1 sm=1 tr=0 ts=6aa2eaf3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=uS1bAgcam2TDL027Z10A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -5vwwUgNt0gd0Wi6smcz5BViGZx78E5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

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
index b854c10467a2..24a963ad2bf4 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
@@ -1265,6 +1266,30 @@ static const struct iio_info ad7768_info = {
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
@@ -1837,6 +1862,10 @@ static int ad7768_probe(struct spi_device *spi)
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

