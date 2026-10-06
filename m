Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5964A014F;
	Tue,  6 Oct 2026 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310668; cv=none; b=G4D+uYH+TaH9lk4Hk6pyfmuxVPVbFNbDeTqIO4ketdqosJ9OSGV/H+UGK4Q6UcglINrsc9zeKb1rsupGFwfwUl7Ej1EPEwc7o4QdcdzWLsCzjL4kb4ze4v5RjcwHapcmr4uedfVl8+EXLXxdgkNa5MfbMPclbrC5jH9WjIZQEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310668; c=relaxed/simple;
	bh=dJI5P7uySPkZA/aPlLs0KS8R7LbxOV+p2/vCU5XaPYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Npjqo3HVQnipjo3JfyMh9kAIa3ghS24g2ky1HUUdctsIRnsMgI6SUVKWolpC1nmH6Tg1qIsBqzE6le0kEX7h6UfI4vuj5UDvIFUj0ZI7OKsfJwM7sdKIJjka5D6Gm90R1Rf2ndCUYzdRB1sqH7v+6qUQFvocHlfmQwNu8bKk+zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=OC9JMV+E; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Tq3n4zB4; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="OC9JMV+E";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Tq3n4zB4"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696HheRi2853276;
	Tue, 6 Oct 2026 14:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=a2YH/u9G3hDZKCQWNTrvWAri8/hFs29SNiT2V9LpJXE=; b=OC9JMV+
	EdJL3R2f+7RucsSsA/Uz9ZeLVsg86lak9QcLN3LSVd+EoktmtQdS4Gie25knzkuW
	+M4FaBOLHNjJGo7Na+7lreeeN0pThQDRfUbEpCarg3hBazwfBpUpXKK4v3jG/fNo
	KMukMhFxsYFa9sGDPPV6BYLu25PacERPkYVAw4doZP+Llqfk5A/BS0HrsUG0WIlC
	R5vyJiH1FZMrftdUBiuyyY/7aKQ4GMwv6Mk4rWSgkrVMm5EJORbWCxsfFQKjAx18
	92yM9Wk9F4wcwKax5tihdX9mIsLpBQivfBdRLij950GBfxmoozcm9exnHxx7QHis
	gHSpAIzjQvz73QA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=a2YH/
	u9G3hDZKCQWNTrvWAri8/hFs29SNiT2V9LpJXE=; b=Tq3n4zB4/w35+BONzpOBe
	4C2PHj4ra1a3Lk0D638aZlwU0ETCTmwzC/QCYw7CxN3AtZMxbbmDJ/C1WYC9ZtPf
	hptn7rDqA6xO1JPvf8bG3a5dGsDidvD8lNUt4VFUL/yZ8N3PfpkWKdUuq/Tz06WM
	rXA/bznh0boH0mCTAez5DovBeidf6HLiBzPvUSjaOo7Ubv/a9clfQXqZmt07IZ/s
	lDsmOM6spfHIZJPt7WCzvo8HqWeKzNIdFdH8hYL/NfgCVsn9EoF554xFpi/0bNnp
	z8ozQyXWigHlf+XTxVErvYUdjcLTkN35hVk3RE3Pnm0d5Zz17hZf2ECMlSlei6d2
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h4j2extx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:17:23 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 696IHME3010018
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 14:17:22 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 6 Oct
 2026 14:17:22 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 6 Oct 2026 14:17:22 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 696IH6RO000996;
	Tue, 6 Oct 2026 14:17:08 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v4 04/13] iio: adc: ad4134: Serialize single-read operations
Date: Tue, 6 Oct 2026 15:17:01 -0300
Message-ID: <466f824eecdbf969c26c988ed0ebcc6cace21ff3.1791309733.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: u0bjXeU-KKdpTxyOqlbtSBUmPbQg2_uA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfXyu2E2W0C6iKA
 DzzrJfg6mTlXcwYYPa+1xsy8JMnKVkVlZGStVWYbNrvAXQcVhKf/O7lNLXWENlxq+NI2VqxG0nx
 hiTFdKSsvKViT15SKs857Dkb/Iw3MWkW8LzjthlM9WTt1/Vz7LBT2gCNd/n0TPvjKwo124XyY/J
 NHLX2NugByOy736Z1+2lWfhuzAsnoFhxRLt1wpFvJKjTtd8aBeUl29AyRaD3WIWtHbOcQpsXMY5
 8EO5Z/k/GF0nnKbBZuWixAvODBbJgJP1O0S1GVxUR4txWQVaSnL13o02TLUpO4j3NsnMCG1tIop
 fDR6yeXbHyIH7vGWsu1WxEJbXDmRmXVwgF6C4Zx1DStShRjphMCTZ5S9xJJGsNKMmaOVMTUkEel
 wHpn4piHbEg3pmrgk62aEJH7c6TtYVWwUjCkOffhUgfv+pd05fK+GfmSSc69bmLWQh9GXq6oVoL
 BMjxUKUJhOX8wuaTtXA==
X-Authority-Analysis: v=2.4 cv=JvtkP84C c=1 sm=1 tr=0 ts=6ac53b33 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=lQRJhboXyqThIMNCO80A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX6V97WE/PvhOw
 Pw3TQRnq+fJJRIbIzqAgyUAfWKbo05FT+jiCheaoru5/svLWAdzzhXcoumdfOT9CTbTciuVyrPM
 NS1Aeh5mgutMbQdxVeH5PPenVD9q3bc8eGPYwuhbFmPXHVPflwmR
X-Proofpoint-GUID: u0bjXeU-KKdpTxyOqlbtSBUmPbQg2_uA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060072

Protect single-sample read operations from going wrong if two or more of
them run concurrently. Serialize the data read operation so to avoid
single-sample read requests disrupting each other.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4:
- Fixed typo in code comment.

 drivers/iio/adc/ad4134.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 4c8adb8efe4e..a0113fff4b71 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -7,6 +7,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/crc8.h>
 #include <linux/delay.h>
@@ -15,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -98,6 +100,11 @@ struct ad4134_state {
 	struct regmap *regmap;
 	unsigned long sys_clk_hz;
 	struct gpio_desc *odr_gpio;
+	/*
+	 * Synchronize access to device state fields and ensure atomicity of
+	 * consecutive register access operations.
+	 */
+	struct mutex sync_lock;
 	int refin_mv;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -257,7 +264,9 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (info) {
-	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_RAW: {
+		guard(mutex)(&st->sync_lock);
+
 		gpiod_set_value_cansleep(st->odr_gpio, 1);
 		/*
 		 * For slave mode gated DCLK (data sheet page 11), the minimum
@@ -276,6 +285,7 @@ static int ad4134_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = st->refin_mv;
 		*val2 = AD4134_CHAN_PRECISION_BITS - 1;
@@ -444,6 +454,10 @@ static int ad4134_probe(struct spi_device *spi)
 
 	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
 
+	ret = devm_mutex_init(dev, &st->sync_lock);
+	if (ret)
+		return ret;
+
 	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
-- 
2.53.0

