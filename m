Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547855;
	b=1A5q3FaZz/vpNdcErQbq36hfaGeXmZfoXKJilU72O4X6lHr3p8G7yuyZdHeoT99eHDWM
	 RuQKev5xw6Pg83iXCitvrPzGLJ45liZEeH4EOiMdutgUidV02/8dRaNiRxrJVqiv5ITh8
	 h8NdB5sh/yMVHdU08uLv67JjFcTW4rjy0jTA/gGTuS/aIpcMPXKvKHMuZAF1e0Id+Ncx5
	 7yzySLm3t+ub+FBUAF0u4obcSSYzzWwMcZdUqIUntTASa7lIXbZNyY3BiIr/887VC3J45
	 KJomCV7xD5dXc/aJU5A+gwEo0q31IqtKHOqpVw0P/SxG11SA2e38f+5PaRGZG0RqI+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547855;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=PaLrY7QK3VT2wfKXD9y8JF873rNMk3RojkW3Oaxbw08=;
	b=D/p4EXfyuwxXS2t35mr7QNExDEZSbpTtzm5m25JWLgCeJj05lKlF6E6FDMGhJhK0cAzw
	 eRYiJ+H/toLOS11SU1IAEWuajdsqBJnX/V1S0rbyHQwENlDoQlp1ZeEwVPWqaOBW+R9l+
	 10ev91OxOhF0Ud6IorOutLxnD5bU67N32/4e1I0Bfj5PBfFuVgRdR/xQsTP19FySwN5WR
	 BWz8t4UVIXNz655FLBZMQw9AlDgE5oelsphTNJWV9msFqFd8qwxGihHZ6jkZJxuEI2UiU
	 gZYsco13v8KneAP2IqAUq7RUFYzLSyaZlmLFb+Ep6Q6wt4Ah1sGkV8/8vHtau3qtvow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RMHWXmNU;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=nwsZLZKX;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2425606A31F;
	Wed, 21 Oct 2026 01:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2425606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=RMHWXmNU;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=nwsZLZKX
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L0uYAC2058054;
	Tue, 20 Oct 2026 21:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=PaLrY7QK3VT2wfKXD9y8JF873rNMk3RojkW3Oaxbw08=; b=RMHWXmN
	U7GKsxaKpTFcm9w2sQ8v9hf8zia4BSWx+pF3R6GLy5S2zPcwKWHQ5HK5i3my9xTa
	5qU4xyJbc+TNdxi6FKuT3DfcRWUAaiDegA/Fg+qkli/Q5I1Vy4zL/n0fWTy0IQU7
	ao/EZ9H5JFff7uXfRdribEKVw6AdsgvkhNR3GH6VQUW0clyaLeEaN6E0gmBuKlQE
	Nv155KRhvHW2FF6ylQf9zKbIOAeJEob55ZoNmqiYCHT/udQmgJWWh//NAMO2HEQh
	Knfph8qJTWxRCzuKAhpsP7K4UCziAqsYhboGUv6IeqKiqemioQKOSyfss4d0l5TX
	LOAGdnop/m/P1aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PaLrY
	7QK3VT2wfKXD9y8JF873rNMk3RojkW3Oaxbw08=; b=nwsZLZKX/emVsKXLsXD3G
	mED3YliSK4WjwxKzx+LxlNNBZ/Qo7o5ZkL6xGTSC9OAONgeAEIp59BJcV3CKWUrc
	5eOdZqgUIRObmiZXN5KASUb6iGQlXCwwiOKCabNq0oPmU61fq8FW/dgpZCHLUa1m
	gSgnvgkTUN67qT8hjlsdRhYSatsMGeayrc2tOdwGNuqlfZdccC43XNsFvQJvXRn6
	Cfz9VGSVxdbp4bgwfYbLdO/DX9pSJ56aOrTK+liPcAeP1GOXEpnov0h6KbjzTSTO
	IOHKVFVRnHy+t1X+95ikBhw/mqGDN3edUy//QT5bIi5cqcF9nN9G8zzSNTilYIQt
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hedgy21c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 21:57:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69L1vUPA006939
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 20 Oct 2026 21:57:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 20 Oct
 2026 21:57:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 20 Oct 2026 21:57:30 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69L1vHHl029062;
	Tue, 20 Oct 2026 21:57:20 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux@analog.com>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <broonie@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>,
        <andriy.shevchenko@intel.com>
Subject: [PATCH v4 3/9] spi: support simultaneous assertion of multiple CS
Date: Tue, 20 Oct 2026 22:57:12 -0300
Message-ID: <372aad8ff5acef8412edef77ab1b7fcce7a902fd.1792435248.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
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
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=EvBHPicA c=1 sm=1 tr=0 ts=6ad81c0b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=k-FQ2K6VbMuEqB_s0bsA:9
X-Proofpoint-GUID: xYv2xklP6Ad1dN-kE_RFHu9hquCmRDkK
X-Proofpoint-ORIG-GUID: xYv2xklP6Ad1dN-kE_RFHu9hquCmRDkK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfXx9jKhT1uM8lo
 wBqQTOIJWVArlqEBlH7GViIhhVmDYQ0fV8RIcHTq/pqEkapOXYUmI33Rpd3vEjWN04hzYskoH2m
 Yi2r0zip7UkG95F74BLo435lAjG6PdDB94LRE/10YhRIF+W5Ut05ibuua+75qw7TaILzAIlrqYr
 IDdLGZ2tJp9FEnpjY4/zxUkW3J7S5a5V3VCP7H5sS9+UePWHRDyNj46KLtbNL/RDeiRWc4Ykftj
 BNiw1FWG/+/6hbkypHKYhTUQl4d8A4+mfQ8mYvH64OMdKX7D35PybnO0yxPk9nQQrNYfZZNjMN/
 pFuUYLUk+8041j2o76VvJ99nwbE2sH/0jM0YHef/SzL6ATeuNBWDAUZ3He1tYPmU4jDR0jDk32p
 JRRkWt7QoSpXNEsoQ27bw5nlTsYGPlMpgQYj6EyudNRm/DcDnmS2CrgkuRBHFgPdR52hvLaveIr
 hkp2xRpbGCFSl6wHScA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNyBTYWx0ZWRfX0hz40WKSfBch
 xmMfk5i0Kle21O91K0Q91DBysd8cTf1Oi0dDG0owbXThZtrwvafQ4QfnGymbwHAOwcOgHDAalM8
 JHj2ylW9HoaAUiHL6tAoeJcoEEHviO0uNcEXSlei0mfgSvGCyzMK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210007

Some SPI controllers allow multiple CS lines to be toggled at the same
time. The existing code always used CS index 0 when tracking the last
active CS in spi_set_cs(), and unconditionally set cs_index_mask to
BIT(0) when parsing DT, both forcing the single CS usage.

Modify spi_set_cs() to iterate last_cs[] using each logical CS index
instead of always reading index 0. Modify of_spi_parse_dt() to build
cs_index_mask from all parsed CS entries when 'spi-cs-composite' is set,
so the controller identifies which CS lines belong to a device when
asserting them simultaneously as a composite device.

Board info, ACPI, and ancillary device paths are not updated here.
Board info would require an API change to accept an array of CS values
and is left for a follow-up when we have a use case for this. Ancillary
devices are by design single-CS, so multi-CS is not a current use case for
them. ACPI represents the CS as a 64-bit integer with no established
convention for encoding multiple CS indices yet, so any extension there
would require a separate specification effort.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v4:
* use spi-cs-composite to determine whether to assert all CS lines
  together, rather than always asserting them together.
* Replaced the for-loop to assign the spi->cs_index_mask with 
  "GENMASK(spi->num_chipselect - 1, 0)".

Changes in v3:
* None.

Changes in v2:
* Include Summary describing why the other SPI paths were not addressed
  here.
---
 drivers/spi/spi.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5b5b3bc5f0d8..7a0406ec200e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1278,7 +1278,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
 	spi->controller->last_cs_index_mask = spi->cs_index_mask;
 	for (idx = 0; idx < SPI_DEVICE_CS_CNT_MAX; idx++) {
 		if (enable && idx < spi->num_chipselect)
-			spi->controller->last_cs[idx] = spi_get_chipselect(spi, 0);
+			spi->controller->last_cs[idx] = spi_get_chipselect(spi, idx);
 		else
 			spi->controller->last_cs[idx] = SPI_INVALID_CS;
 	}
@@ -2794,8 +2794,19 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	/*
 	 * By default spi->chip_select[0] will hold the physical CS number,
 	 * so set bit 0 in spi->cs_index_mask.
+	 *
+	 * If "spi-cs-composite" is present, assert all CS lines at once
+	 * so the device acts as a single composite target.
 	 */
-	spi->cs_index_mask = BIT(0);
+	if (of_property_read_bool(nc, "spi-cs-composite")) {
+		if (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS)) {
+			dev_err(&ctlr->dev, "SPI controller doesn't support multi CS\n");
+			return -EINVAL;
+		}
+		spi->cs_index_mask = GENMASK(spi->num_chipselect - 1, 0);
+	} else {
+		spi->cs_index_mask = BIT(0);
+	}
 
 	/* Device speed */
 	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
-- 
2.34.1

