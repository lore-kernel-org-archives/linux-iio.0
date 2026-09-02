Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468E4ACC74;
	Wed,  2 Sep 2026 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369723; cv=none; b=jFTK0CeYNH5EH09hOeolzfbYPL69k6ezACvZtYMSdkZf+NA09uLY68ILa0mIelMmUotdEuOqWbNEBBgNAW+CjyduRUMOz4H6xiRmhfeR+VQ/TJOwNSw1AEIupH2jglXeZgVph9ZxFpq8JkUOlqCC/2nEbUi5Zgt5nBSNEC7Adk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369723; c=relaxed/simple;
	bh=IlHQzvdwE5BO6+PRmWGvHll3CyLJd+6tneMdKwVR8bY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAeoKLbZlS6lSjMay6W5Kkp+TMI48nUouK01Vm5aKSUNBa/ErMX9LqZMbgj8jKe2T5K/m8wFc9L7ZWdQ5MtquLMDV82MfyLDtmhGqk4Fr0Dd6z1lszMQoHABz8FG63eeYz9Wc+4aCJVIbCNU4HUkmR7Kvf7GSfvHSmllxnT/020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bByMWwO2; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bByMWwO2"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HDPT83088232;
	Wed, 2 Sep 2026 13:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=97bMj
	Fl3dm3V46Uq3w77DCUKs3hY0UOhOrnT3AChsoE=; b=bByMWwO2KjSckbFgqQ1zn
	Vek9qxuY73dgt9+9LtebVdkRao4rt/pCVUR15NuxKGsCZECDoPdz6L7pJOrPBmhZ
	r/DwL9l12HdUDQuBHcH8oHpPB0VDPCdRZLtFNLfM0D0QjaQGPZpHqHi655QRu1Eq
	J9qo2hAiYeNupz02EeVtIeLWTI+rOENMj5PTc8epAHwBf0jqzplk4eHPK2l//oLw
	R38A5jgYHBW9ejxNhfSHZr5sHS5ZWWELb48Xz2VDyRs+YprRCQ+kWMuiINdJ3hyZ
	cMrmVJkE9XxX3BrusQdY2pofsP3jWVjA4gc9Sx2CyIgxli3cvVkEZSIBSxCg3eZy
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gea7ubsu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:21:55 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HLsqQ041123
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:21:54 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 13:21:54 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:21:54 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HLebM004200;
	Wed, 2 Sep 2026 13:21:42 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 01/13] iio: Fix typo in vendor name
Date: Wed, 2 Sep 2026 14:21:34 -0300
Message-ID: <e508718734a06f005704051b8bc3d3d7a1a3b48d.1788368334.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1788368334.git.marcelo.schmitt@analog.com>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX8l/lj+pbNylf
 ELm4ny3TfSk29q8JUJWhgv1n/BX4MJaSTyVnSXWcXRV57XwRtUEJ73qsCftSOrvY1eXCWplW7tt
 JRCMKsAP6TaA74t4C6qN7feg5yMOlL+vx8E42ztMKCSaYgDaQ7o9aQqH0ykcC/y8+N2jk8Cl99W
 Kdl0eNsBa5HPk2VwsGaIna4iJgQyT9lnuiv7iqKtCi01lamWt4WVLOY3NjQLfxHhbp77CXDKTEZ
 YZ7Otup1E6eJHiabi9rMIElcoRGH08PuXh2rM3xdoAqWtaAHi1t1U5zGjBm0dyTldozYOjO6/Ph
 L9SpWH13fOss8mWbvsgZuckJrmCdvEuK9BqYNcviPErB9yfdxubD+4An9l/vguWRv/om5jTVRQX
 +VLSJYslZdjYxnP/o7jvX1rlyeNaPNaY26JgsbbClc17Bm/+GUjRONY4NgtvOrosZQ1QAlXLZvi
 UdIp80Yj0bOBubF/JGQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX3MTkY3O8tIqM
 8GrntkZJ2HwUO+qJ4BBT28IfIBBvyq1A+oo5Hx6a/8xhxkw0Ll9mmvfkRG6J7vx+Y+PozPb9xX7
 HfGEy1yWm1UBCQD8w8ccC0Fr1IaBFnDKQoFHnLfWjDaiDBkGwiZC
X-Proofpoint-GUID: 9e7RbUcYxwbWq4OavW_M3AipTqqRj-55
X-Authority-Analysis: v=2.4 cv=a6EAM0SF c=1 sm=1 tr=0 ts=6a985b33 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=A5pyyFiLPXLXFdNQ0CkA:9
X-Proofpoint-ORIG-GUID: 9e7RbUcYxwbWq4OavW_M3AipTqqRj-55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020153

Correct a typo in vendor company name: "Analog Device" -> "Analog Devices".

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Now
find drivers/iio/ -type f | xargs grep -i "Analog Device "
finds no leftover occurrence of such typo.

Also,
grep -nrIi drivers/iio/ -e "Analog Device" | wc -l
and
grep -nrIi drivers/iio/ -e "Analog Devices" | wc -l
both count the same number of lines.

 drivers/iio/adc/Kconfig   | 12 ++++++------
 drivers/iio/dac/ad3552r.c |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 38e212a6f789..02f189e90c30 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -105,7 +105,7 @@ config AD4080
 	  called ad4080.
 
 config AD4130
-	tristate "Analog Device AD4130 ADC Driver"
+	tristate "Analog Devices AD4130 ADC Driver"
 	depends on SPI
 	depends on GPIOLIB
 	select IIO_BUFFER
@@ -121,7 +121,7 @@ config AD4130
 	  called ad4130.
 
 config AD4134
-	tristate "Analog Device AD4134 ADC Driver"
+	tristate "Analog Devices AD4134 ADC Driver"
 	depends on SPI
 	select REGMAP_SPI
 	select CRC8
@@ -133,7 +133,7 @@ config AD4134
 	  called ad4134_spi.
 
 config AD4170_4
-	tristate "Analog Device AD4170-4 ADC Driver"
+	tristate "Analog Devices AD4170-4 ADC Driver"
 	depends on SPI
 	select REGMAP_SPI
 	select IIO_BUFFER
@@ -164,7 +164,7 @@ config AD4691
 	  called ad4691.
 
 config AD4695
-	tristate "Analog Device AD4695 ADC Driver"
+	tristate "Analog Devices AD4695 ADC Driver"
 	depends on SPI
 	select IIO_BUFFER
 	select IIO_BUFFER_DMAENGINE
@@ -179,7 +179,7 @@ config AD4695
 	  called ad4695.
 
 config AD4851
-	tristate "Analog Device AD4851 DAS Driver"
+	tristate "Analog Devices AD4851 DAS Driver"
 	depends on SPI
 	depends on PWM
 	select REGMAP_SPI
@@ -347,7 +347,7 @@ config AD7380
 	  called ad7380.
 
 config AD7405
-	tristate "Analog Device AD7405 ADC Driver"
+	tristate "Analog Devices AD7405 ADC Driver"
 	depends on IIO_BACKEND
 	help
 	  Say yes here to build support for Analog Devices AD7405, ADUM7701,
diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index 16db94fef9d4..039af514adde 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -696,6 +696,6 @@ static struct spi_driver ad3552r_driver = {
 module_spi_driver(ad3552r_driver);
 
 MODULE_AUTHOR("Mihail Chindris <mihail.chindris@analog.com>");
-MODULE_DESCRIPTION("Analog Device AD3552R DAC");
+MODULE_DESCRIPTION("Analog Devices AD3552R DAC");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("IIO_AD3552R");
-- 
2.53.0

