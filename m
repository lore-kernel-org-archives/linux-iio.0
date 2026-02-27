Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616024279FC;
	Fri, 27 Feb 2026 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200964; cv=none; b=XzvCMRmEO3eoF4XHK/ROeE9ozhFBLTBdXZDGTQbVvAxlKRxbI0Apu0zh/bQBcPfGBM5yX187sOLIb6mw2FUshYcSZetEOkrX4uDL0+oQOXocFfogQ+g1HVAw1JnVAzGRDP79kS13yUeEKkLmzRBZsARtsoaGTOtyJTm7xqLMpbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200964; c=relaxed/simple;
	bh=Lz8inzcLH6RaPE/NrJV18w59d0D95PaXBZB3NnkyL+M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHCMZzBbRnQQ73DhImEn6sJwDFcQ5f4P/xd/4focwsB8KQKpb7ptGzcf+WiA3P3Bu5bWVtZuQnWfS9aDWsa9QZ7O1skqgEWGWjJ3e4KWASHyy4PERI8vDuEyDTGgRhDAIPni32eL43xO4vyFcCqxj8eClhBu5FBfkCFZWVH1gZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Y1nNgRrB; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Y1nNgRrB"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RAUHYf3025200;
	Fri, 27 Feb 2026 09:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=rhiVX
	9WkkVOkqjtf6FmEWAPtcvi7hDIoIeJvyd3sXf0=; b=Y1nNgRrBZUvvIcBqsx/p/
	flpmyzv+D9Ro3+U5Uw0A+0rg9akz7DZvitkWl+zF/bDogs8suGLHC4MIa5mPFMMf
	CgWxU4ZXqDMNEe0tMvst0E4PqBgm5FxBDhnInnV24naeqJMXQ5wPeNBnA6k4/mwB
	+o6Iw4KmLGTm058i90QYnLVAurKUyl/zB1z6NABUu6YX1APVFBQaL8pNQaXzXg6R
	MKfVXZ0IaGvhHCLi+CnmkgW2x0yfqYort63KYWjn6b6+0sEXR90qviL88KvOqqkR
	qXnXuoe/zDV+8+j+l3sl0sUGTF8HTrl5WpjSn/tYYgeEChkQrPVHEl/AxLbcRC51
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cj8tdgc01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 09:02:27 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RE2QlU064838
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 09:02:26 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 27 Feb
 2026 09:02:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 09:02:26 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RE1t3u001982;
	Fri, 27 Feb 2026 09:02:20 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 08/12] iio: frequency: adf4377: use dev_err_probe
Date: Fri, 27 Feb 2026 16:01:37 +0200
Message-ID: <20260227140152.77529-9-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227140152.77529-1-antoniu.miclaus@analog.com>
References: <20260227140152.77529-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=NubcssdJ c=1 sm=1 tr=0 ts=69a1a3f3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=SF_i7ZEFwfkAXJdm2GcA:9
X-Proofpoint-GUID: T_iq4dosV96wLe5co8as9lmJ3Z9zc0SS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDEyNCBTYWx0ZWRfXwpUiAZHKc4Wr
 DxpN52xHt4V1KeyvRBgtWSqHmNUHjOJWJl83+I2lPHdnizLUBngGRh+HVWZnz76mzV5MUdhGuLw
 2oMCH1o0BFmGvyTblfa1w7EuGFNWUX44eyMllCKYps+9B0FEv+cu1B78AhcgNL1w6xujUnbu6dN
 cixatPkjW7JAOvAO1xbJjMGrcvIPWIMKuh9uSRViocbF6jl5mUcZUwESR8Ng9nFx4ZZ1okhPwZv
 jc8Wntjvk8MYtaJt4kXJYwkpEEyw0ZgRzPyEWC7X0NxJGsz4H7f7fdScoIodhT/PHya6IKQ50Pw
 J6bamyRbR/2uM0mTAONFYbOX4f9HW9+UcvnCf/ES6FYpfVl4p4vZE61lM2WK3EwMFLX2R86ZIZ3
 948pNUfmQkH9bp7lb3+4mkix6dCVEDoAfVTJ86g6lUzz0WA8BaXwSQPRUjVhZw78RitTC1b4L2x
 L86hbeGEnKuIHrsJLpw==
X-Proofpoint-ORIG-GUID: T_iq4dosV96wLe5co8as9lmJ3Z9zc0SS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270124

Use dev_err_probe() consistently in the probe path to simplify error
handling and ensure deferred probes are logged correctly.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adf4377.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index c2ae6f2012ce..ce3a396624c3 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -706,23 +706,20 @@ static void adf4377_gpio_init(struct adf4377_state *st)
 
 static int adf4377_init(struct adf4377_state *st)
 {
-	struct spi_device *spi = st->spi;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	adf4377_gpio_init(st);
 
 	ret = adf4377_soft_reset(st);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to soft reset.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to soft reset.\n");
 
 	ret = regmap_multi_reg_write(st->regmap, adf4377_reg_defaults,
 				     ARRAY_SIZE(adf4377_reg_defaults));
-	if (ret) {
-		dev_err(&spi->dev, "Failed to set default registers.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set default registers.\n");
 
 	ret = regmap_update_bits(st->regmap, 0x00,
 				 ADF4377_0000_SDO_ACTIVE_MSK | ADF4377_0000_SDO_ACTIVE_R_MSK,
@@ -730,10 +727,9 @@ static int adf4377_init(struct adf4377_state *st)
 					    ADF4377_0000_SDO_ACTIVE_SPI_4W) |
 				 FIELD_PREP(ADF4377_0000_SDO_ACTIVE_R_MSK,
 					    ADF4377_0000_SDO_ACTIVE_SPI_4W));
-	if (ret) {
-		dev_err(&spi->dev, "Failed to set 4-Wire Operation.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set 4-Wire Operation.\n");
 
 	st->clkin_freq = clk_get_rate(st->clkin);
 
@@ -747,10 +743,9 @@ static int adf4377_init(struct adf4377_state *st)
 			   FIELD_PREP(ADF4377_001A_PD_PFDCP_MSK, 0) |
 			   FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 0) |
 			   FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK, 0));
-	if (ret) {
-		dev_err(&spi->dev, "Failed to set power down registers.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to set power down registers.\n");
 
 	/* Set Mux Output */
 	ret = regmap_update_bits(st->regmap, 0x1D,
-- 
2.43.0

