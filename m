Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB274854EE;
	Thu, 13 Aug 2026 13:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629502; cv=none; b=D28PrpNFO16cVR3XWIWP4vR/FM3P9XU3UlR2OzoqGcbch1B0ykP5gJUUKd03OGiYx5XTupQy+U6HVK7Q50ziDYH7fh86Ilc83Xc3/N61wj4Zi98wicVfufc0P8DRLLiNPOqXDXtIugAJdnv19BB0u9oD7+EzX69EmwCpLFWTvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629502; c=relaxed/simple;
	bh=HUPRSNGBRBkwytYIMHIZFp5Yf5l+/20hpie4kreZN0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PVD9Z6Vklh8IgVmK7fJIqbHKh9/8XymfW4dkaDT309q/09biyEW7Ypy2s/+DPsEKNcKu+aSdOHBBNTTK5KlF3YSM/GhX+UJz3vBMGO+vrNMCwZ0cI3bN3PoiLOc6oyv2yiNjUq+N2jOhN57kDGDJVFVZF1owaxuGae4g+v6aBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xGFm/ns3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xGFm/ns3"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCdBXH1876654;
	Thu, 13 Aug 2026 09:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ECltM
	ExzMgvrvbKms5wAtvDG5I3R3mZp7N+wEcmWj3U=; b=xGFm/ns3zPGqiBOP8B6v+
	3o1PUbJvRdyOCBR+JZOzdwLqw9KMr7h3EXLPJ1xl85t0mGSjNO5fAnRj2u84nAsP
	4I+gcQi/ak7pTc4R1WBJIdYlTqxfAwSdWt4l6q94gUlcto0LJkmNRNiopBbP+g5P
	WstPjLoaqz612Uzqm11QpshK1UqvAar3cAvd0fN3wXNHlnkiv2Mcs+UaZc+KjCUD
	0J2ut8BzdPOTw1NqUIBqe7WLwgLcBmPYIlkujs2OZHpPPZtlpm67Ze8YCVNFAFUQ
	V6TjbE169TAIY8Mt9YzYZzUX54csHxV0wb6lfOpLKj2M4A535Tn3LlpvbzCJtvzX
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e4b0dbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:58:10 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDw9K8024663
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:58:09 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 09:58:09 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 09:58:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:58:09 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwc006802;
	Thu, 13 Aug 2026 09:58:02 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:57:03 +0200
Subject: [PATCH v3 10/14] iio: adc: ad7768: Register GPIO auxiliary device
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-ad7768-driver-v3-10-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
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
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=1874;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=HUPRSNGBRBkwytYIMHIZFp5Yf5l+/20hpie4kreZN0Q=;
 b=q1xPuDKQ54ZC52JJOPLmXwOP8B3HGJKOm8U09bEV+zmRqPe/sNq2JreqQ3lFKslYalUsfXlwR
 lyCYagXUD1aCshmsNZO8pZbdUaRh+23mrvOHBST/ES4a/++V/UrbbGA
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: WP-cc7pLAity1t82eGOPPkyQgXcRRUP_
X-Proofpoint-ORIG-GUID: WP-cc7pLAity1t82eGOPPkyQgXcRRUP_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX1pp4gFuP8q5D
 SwuLG1hbMN9qANymAnUC01Ra2dxMlkYXyAGP+TGmjjs4Qc/krsgVtf/jADsx60VE0f7hJujoNOu
 OpC5Tf1GRfkTr7UHAQy95otmI1cCVTeZ0EqNFlOWAEuCu0jktGuO
X-Authority-Analysis: v=2.4 cv=ZZYt8MVA c=1 sm=1 tr=0 ts=6a7dcd72 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=QNlN7d7LqMGTcrNWFyAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfXzTzyGCMNApiT
 wkc2x7W48UGPckk2ZdwkvPi74jvYVKHEehtm436OgVRNq+XxJ3vW+Vq+yhcidluyaPXiY5tFdzn
 pIe41bL5oDnbKzcraEh3KLo9YvJ8Kw0Hb8kwy1fHDfbsSlL9cpz0epcRSdTpsIKfqug7rOX5cPh
 RwVVYIr6Ho+f/m0Z9tIlXsSRTfZIt4oRxkGYw/QbNYXBRE2l17lCwWyDCcD/eiGnCkHA4rj0mLe
 ts1/vIUQYvU9MjM3MMj+dvdOyFDex5CvdOjJHQTRzFOSmP3U6jWh4R5f4LZl+/x6Njehs1/u7df
 x3n8tsGQQEaa9nRft2WfGfvnMwuwy8D4hz+a5/23Sc47UjKNXgGcAEHRZklZgu7Yb49Ey+/DQkr
 Hg5ZWG4tBAIYN2MPu/G/edNQb3OnoYFagi6/nahm50yL4/AVrt2ZeNMV4QPPN0F9rUj2CXPnxTT
 FcfLVcATZHrCWu/7HPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

Register an auxiliary device when the AD7768 is described as a GPIO
controller. This allows the GPIO driver to share the parent regmap and
runtime power-management state.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index d7151b1fa863..6df219610b65 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
@@ -1209,6 +1210,27 @@ static void ad7768_set_available_sampl_freq(struct ad7768_state *st)
 	}
 }
 
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
+	/* Use the SPI bus number and chip select to derive a stable per-device ID. */
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
 static int ad7768_set_filter_mode(struct iio_dev *indio_dev,
 				  const struct iio_chan_spec *chan,
 				  unsigned int mode)
@@ -1585,6 +1607,10 @@ static int ad7768_probe(struct spi_device *spi)
 
 	indio_dev->setup_ops = &ad7768_buffer_ops;
 
+	ret = ad7768_gpio_adev_init(st);
+	if (ret)
+		return ret;
+
 	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
 		return ret;

-- 
2.43.0

