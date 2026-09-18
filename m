Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABE349D5A1;
	Fri, 18 Sep 2026 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717013; cv=none; b=OpCPK/qwTuIuIaulsY/7cvG5YZ2Cc9/HPayjI4/pKjiiT+zIrfCESAqzPJ/ruv7MEtU//FF9dmxvgNGt2XxBjoECL+VQBcAtzivUzSUjUCbJN0i7fKn3fQiVrJDnURU+n/RSqKUSiI2KDJcMmgmteNh1oCVS69F0QRcDrSNfWXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717013; c=relaxed/simple;
	bh=VhMAE3ufNZbB0YJLoZN9BJs9K3vI9jhjkDTfXq7XvE8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M436sLvzQHCEKj0MDWamZG6lLOzJ35cXxaK0P/5pDcNQ3Fyf4tA/7koTT8DXn+yXsxoog0j6QNyN2FTajk1C9rDZq/KdLDp0lAunOUQNXLuTWu3cnSWt47Z6lMYh9fLUR3qVpLKy0QVMq4pInyFpCMyIHcnNLCYxmZeCsE5pM2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GzoHavaf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GzoHavaf"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5wceu255622;
	Fri, 18 Sep 2026 03:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=r6JyW
	2APjiiJ2Tv21NG+40B9kelFs3J7hgA1aU4MYww=; b=GzoHavaftT/YKnhw6v2XJ
	4avBPpS9P57035k8JvlN5WalkB+DP55n6sPVf5kAL7E6aYFkYX7qyfPPv8ZtfZ5F
	R0anumZNEaT3SIjAVoe7gLAfaxt2bN5xr0FWLoRZohqfs4Ajr3Ke6ZKunDRsQAD4
	pGd1oyQsvTbq2LPQP9SU9LbLiL/cFprmW6bAFWtY888zj898MMa4hOD/gIKqF4Se
	SMGFzFe8zOij/VCWV9Dk+o09Yq/IXsM1E1jHbgtj2J6agSMfgH4aMyKVC1vclBGg
	N5rCKG+0GtPyEbWNiGzNC+l+1I/rHcX/yeU0UafSAl+j7OEBKJR4MFcDp6s3AqYI
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4grm943db9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 03:36:28 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68I7aRwL011071
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Sep 2026 03:36:27 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 18 Sep
 2026 03:36:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 18 Sep 2026 03:36:27 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.219])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68I7ZjpX019677;
	Fri, 18 Sep 2026 03:36:19 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah
 Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>, Salih Erim
	<salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        Jakub
 Szczudlo <jakubszczudlo40@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 5/6] iio: adc: ade9000: add support for ADE9430
Date: Fri, 18 Sep 2026 10:35:34 +0300
Message-ID: <20260918073537.1572-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918073537.1572-1-antoniu.miclaus@analog.com>
References: <20260918073537.1572-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AcckjHXG c=1 sm=1 tr=0 ts=6aace9fc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=zlWSOBlsY_1KlUt2hasA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfX72zr1mxz+3NQ
 QcP9e0DpyfuM0n3Xwus24acJ8Htr+l4Ih3+poYW7cR7cNs4WmzO1eI9s5YercGJb7DN2/5Vooe6
 ppdCL+7EgmlHiiPQj81V0vchIIbHzwaXDF5OijQnX/0A5t91ix+I
X-Proofpoint-ORIG-GUID: CvdzLwUUP3eKmIKiLRTQAytXEqJ1NX5P
X-Proofpoint-GUID: CvdzLwUUP3eKmIKiLRTQAytXEqJ1NX5P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfXxiYSNhtzbSth
 2ik39xCjDbbo0bXwEj4K9Q136Y+PTMupYjUKrulzF/xZMJBRjQVUljWengiKd0l8eFtu2D6RKlj
 s1ppKYtzyNt0CKY+PH6YR11qIZBRhxn7LvtCadbRuVnLs912d0XeuwFypli5+UNYPqtmbE+aowh
 oetnShlJoZ9bmouRKWoxGCJTOV02fgFso1te7YdXLo+qtu/HbbRzXTpfTdSxSOguOsclWJxpP0f
 XEXz+PawifEk4eW+UeM+gEaaTlGC7E7kshOawrchxw+Fm60sVUNiMS89BS4sax0eASSCzUsGKC/
 kOTZSsWsKj+FYLS6MWEGSZvn5zS4HBu14c8sqVOq14WyTBpIPtBeWGRMrwIEvYU1PJ9iY+dpV8l
 aQ18DPsEsGfsPZbYgFBL2qovbNULRtY05B+vRUaJwXlg/qBXSixTu02EPcVwnM4tj95SI7mJRBT
 97XsZtTtYZ1lflAtQbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180102

The ADE9430 is a polyphase energy metering device that is register
compatible with the ADE9000. The differences relevant to the driver are
the absence of the on-chip dip/swell detection and the absence of an
on-chip digital integrator (the ADE9430 uses an external analog integrator
for Rogowski coils, so the DICOEFF register does not exist). Its full-scale
ADC codes are the same family-A values as the ADE9000.

Add a chip_info for the ADE9430, reusing the dip/swell-less channel table
first added for the ADE9078, and explicitly set has_digital_integrator to
false so the DICOEFF write is skipped. Wire up the SPI and OF device tables
and Kconfig.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- reuse ade9078_channels instead of adding a duplicate channel table.
- move the DICOEFF gating to a separate precursor patch.

 drivers/iio/adc/Kconfig   |  1 +
 drivers/iio/adc/ade9000.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7a60ffd0ddd8..3a3ae09fc10f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -587,6 +587,7 @@ config ADE9000
 	  integrated circuits:
 	    - ADE9000
 	    - ADE9078
+	    - ADE9430
 
 	  The devices feature high-precision analog-to-digital converters
 	  and digital signal processing to compute RMS values, power factor,
diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 0167d5bcdb74..e0113b62a261 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -695,6 +695,16 @@ static const struct ade9000_chip_info ade9078_chip_info = {
 	.has_digital_integrator = true,
 };
 
+static const struct ade9000_chip_info ade9430_chip_info = {
+	.name = "ade9430",
+	.channels = ade9078_channels,
+	.num_channels = ARRAY_SIZE(ade9078_channels),
+	.rms_full_scale_codes = 52702092,
+	.watt_full_scale_codes = 20694066,
+	.pcf_full_scale_codes = 74532013,
+	.has_digital_integrator = false, /* no on-chip digital integrator */
+};
+
 static const struct reg_sequence ade9000_initialization_sequence[] = {
 	{ ADE9000_REG_PGA_GAIN, ADE9000_PGA_GAIN },
 	{ ADE9000_REG_CONFIG0, ADE9000_CONFIG0 },
@@ -1859,6 +1869,7 @@ static int ade9000_probe(struct spi_device *spi)
 static const struct spi_device_id ade9000_id[] = {
 	{ .name = "ade9000", .driver_data = (kernel_ulong_t)&ade9000_chip_info },
 	{ .name = "ade9078", .driver_data = (kernel_ulong_t)&ade9078_chip_info },
+	{ .name = "ade9430", .driver_data = (kernel_ulong_t)&ade9430_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ade9000_id);
@@ -1866,6 +1877,7 @@ MODULE_DEVICE_TABLE(spi, ade9000_id);
 static const struct of_device_id ade9000_of_match[] = {
 	{ .compatible = "adi,ade9000", .data = &ade9000_chip_info },
 	{ .compatible = "adi,ade9078", .data = &ade9078_chip_info },
+	{ .compatible = "adi,ade9430", .data = &ade9430_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ade9000_of_match);
-- 
2.43.0

