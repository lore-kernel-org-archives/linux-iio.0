Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606A366048;
	Mon, 23 Feb 2026 13:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852502; cv=none; b=ayG8jbiNXL+vxa6r96I1f0FRnTh61nS3is6aqlewk2NwTLRg1D4QOZzxKdpPax/WYyLQlDIPq8ls2G1WOsI8AoqeXr7p7TOjK5KFUJcg1sQQf7013dKBrRWiM8svMENZmpGSKn82/JEZ11bkP7PcvxtaUKMiw7WkSpaBlbJSiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852502; c=relaxed/simple;
	bh=ZbarGkOZnbAkx72n8CmJ0NvZPXlg+jSYO7+jtsQZlR4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f9PS1IPSZD/JRuZ2u7a11ZfLWdU6CMteScI1Ynglr0pMawRMR2mA8kN6WjTjfBoUhTm4wBUxtS5E2lB02EetlnaJNGsP94Ih+cnJNeSfye3pTubZlR1EAOJFS9WGE9a1Y7aUwg3rRBcEEcu0IRzBq+8h9/RWboQ5cqkEYhu3moY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=pCEBA8lK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="pCEBA8lK"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NBpIHM3320843;
	Mon, 23 Feb 2026 08:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LNfha
	hLNGyyCYlw8KIVPm65z5yfbsUpC8+OWEdDtPDs=; b=pCEBA8lKP6Hnh50jPVId6
	n6giHKYrfWn/dGB2vVVBrn2Xyv6qGwZFMiW4i0p1EyfAgr/7YmrN14ZgHY2C6gCd
	yx2V8pSzeV2ySc+QSRn8QRJgkz7DT4309giZEfXBMv/GRfXV62ro0t6ZSTaE0Us+
	b0CiwKAtNwpmn/NqxG1osHnhXfiOgWx6Bu8YGhZFAZ7BTQWJQtbwAGGfEElAgMv9
	oSoW//qb9Qplxq8soL8kVnNS7cuuKHjNPHk55Fapj8zPMH4yR12O5o1x1C72/2C9
	HKNyEekyYDB7bamaAPiYtLcymjNQNhd6/FOE357cOc5oW4MCslma8seHW4UVG884
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cf7e1y92y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Feb 2026 08:14:45 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61NDEiTh009744
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Feb 2026 08:14:44 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 08:14:44 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 23 Feb 2026 08:14:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 23 Feb 2026 08:14:44 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61NDEMXa006594;
	Mon, 23 Feb 2026 08:14:38 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 04/12] iio: frequency: admv1014: use dev_err_probe in probe path
Date: Mon, 23 Feb 2026 15:13:55 +0200
Message-ID: <20260223131418.55414-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223131418.55414-1-antoniu.miclaus@analog.com>
References: <20260223131418.55414-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=WsUm8Nfv c=1 sm=1 tr=0 ts=699c52c5 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=S22sRNvq--lf_LWfmLgA:9
X-Proofpoint-GUID: RnSCddPr0x4BIDKrOvtYE5dyTofv0Awt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExMyBTYWx0ZWRfX1NaIHvjtsUM/
 TknHOSLTe1iR1reN4Z76Oic0vqRMW1Oqs8eV2gJ0EYn8Cx3Lxk9X5anDOOLP+z209lwucWzBiiV
 JVgxlf5rwIBeAwyAbiQpC/3jw59/wLPQjMAFUFsTRbcae8mmxxQ9DpQf3pG61RbxchJtld80G2A
 vDsEWqapEbAI5l/K3+xswds7eCFZVSzIOvZCviz8bO6Jq/g5MqCTJqDJ4gPxp7TfCQJGnFFHo3i
 xklemHrH4jh4oZ4mRrtu5/8Otjl69nKwXdyQ8bOc0XAMbDPnwOv7uwcprfSqTrPBjb4L7555vvE
 a93eD3bEQjtYMIm5fu09No13Rx9DiNdTXxJWrNbRvMPjtzW2GY28+jkrLvBVR0oyVEJZMcXb7Yu
 kgW/wWqqPMAUAY8Ki1/Ot44s/kSnvcgIkaHEcVcadumGLXiLVwSCLhXKDGttgrA7bUwx+I/2tgR
 eEcBnCsYxI8YnD37DGg==
X-Proofpoint-ORIG-GUID: RnSCddPr0x4BIDKrOvtYE5dyTofv0Awt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230113

Replace dev_err() + return with dev_err_probe() in the probe path
to simplify error handling and to ensure the error code is logged.

Drop 'SPI' from error messages since the bus type is evident.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/admv1014.c | 63 ++++++++++++++------------------
 1 file changed, 27 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
index ce1b40336e15..eeb01cfb799f 100644
--- a/drivers/iio/frequency/admv1014.c
+++ b/drivers/iio/frequency/admv1014.c
@@ -613,10 +613,9 @@ static int admv1014_init(struct admv1014_state *st)
 	int ret;
 
 	ret = regulator_bulk_enable(ADMV1014_NUM_REGULATORS, st->regulators);
-	if (ret) {
-		dev_err(dev, "Failed to enable regulators");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable regulators");
 
 	ret = devm_add_action_or_reset(dev, admv1014_reg_disable, st->regulators);
 	if (ret)
@@ -643,55 +642,48 @@ static int admv1014_init(struct admv1014_state *st)
 	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
 					 ADMV1014_SPI_SOFT_RESET_MSK,
 					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 1));
-	if (ret) {
-		dev_err(dev, "ADMV1014 SPI software reset failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV1014 software reset failed.\n");
 
 	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
 					 ADMV1014_SPI_SOFT_RESET_MSK,
 					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 0));
-	if (ret) {
-		dev_err(dev, "ADMV1014 SPI software reset disable failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "ADMV1014 software reset disable failed.\n");
 
 	ret = __admv1014_spi_write(st, ADMV1014_REG_VVA_TEMP_COMP, 0x727C);
-	if (ret) {
-		dev_err(dev, "Writing default Temperature Compensation value failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Writing default Temperature Compensation value failed.\n");
 
 	ret = __admv1014_spi_read(st, ADMV1014_REG_SPI_CONTROL, &chip_id);
 	if (ret)
 		return ret;
 
 	chip_id = FIELD_GET(ADMV1014_CHIP_ID_MSK, chip_id);
-	if (chip_id != ADMV1014_CHIP_ID) {
-		dev_err(dev, "Invalid Chip ID.\n");
-		return -EINVAL;
-	}
+	if (chip_id != ADMV1014_CHIP_ID)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid Chip ID.\n");
 
 	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_QUAD,
 					 ADMV1014_QUAD_SE_MODE_MSK,
 					 FIELD_PREP(ADMV1014_QUAD_SE_MODE_MSK,
 						    st->quad_se_mode));
-	if (ret) {
-		dev_err(dev, "Writing Quad SE Mode failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Writing Quad SE Mode failed.\n");
 
 	ret = admv1014_update_quad_filters(st);
-	if (ret) {
-		dev_err(dev, "Update Quad Filters failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Update Quad Filters failed.\n");
 
 	ret = admv1014_update_vcm_settings(st);
-	if (ret) {
-		dev_err(dev, "Update VCM Settings failed.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Update VCM Settings failed.\n");
 
 	enable_reg_msk = ADMV1014_P1DB_COMPENSATION_MSK |
 			 ADMV1014_IF_AMP_PD_MSK |
@@ -739,10 +731,9 @@ static int admv1014_properties_parse(struct admv1014_state *st)
 
 	ret = devm_regulator_bulk_get(dev, ADMV1014_NUM_REGULATORS,
 				      st->regulators);
-	if (ret) {
-		dev_err(dev, "Failed to request regulators");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to request regulators");
 
 	st->clkin = devm_clk_get(dev, "lo_in");
 	if (IS_ERR(st->clkin))
-- 
2.43.0

