Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663DA347BD1;
	Fri, 20 Feb 2026 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593211; cv=none; b=Exyf/ZyThjO/ShLk73C37mFtuoalaCFnlvXzGd+K73UseCZmcNR/zoQA0cg84NeP81nxsGIqWVnt4Irn7hsCSEh8vKLi/loz0wq0MHEHph864BIfdMeiVcj4q6HqXO4v4DWncktXa/Ruh+8MAwE5OEhYfRACt63zWA/aP+JIAC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593211; c=relaxed/simple;
	bh=VJqEdk4RNwf6HD2vCqOoPdgHs+BN3YS6SpqBJjU9q+s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmfMIW7WIi00jtKKiNqEgrtvNrjdOO1ZmmbvsKB3wJsohvQc6M0fAn1fwLZKxrKvBhjv8MueNV/hq9TKdrmNiCH1irpIwc4fcuKQIPBFI7B6axYXV4FVMYGnCMO0ZM/5FnI2DP4coOfSNWMROUy9jB4bt78lS48nlKxRrGH3D/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=q1ZGt8Mx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="q1ZGt8Mx"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87W7e2962780;
	Fri, 20 Feb 2026 08:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cJ9v6
	xlXujLoH2/eMWvOisOyZdtpd+d27fWyHWKDWOw=; b=q1ZGt8MxDm4dg2DaEamlb
	Iw4ZstFFexTPuMM+tEkZ4equU19QYT3TFKqg9CmPmGgeVzS0gOi4GlEgKVVPLgEK
	1qPvYuNrR1mBjznHH/pQsERkPsvwxHxcLOA1R+RtyVh0er8E5w4vaSV6Ss8WoA5N
	M8Iq8rMmcGt8k3fSVeWGLAj5i4nBVvPVTQwkUFDYZ/miqsmVJgbGcWUsc0XyAV25
	9duJ9G1anElztkktqGae4a3c5w2yTyX9rLul29OcMk7Y3ykibZboeqim2H/k6OyX
	5DINqVmSuzHsJzA/rg9YZX3d8QjNqIWyizyG/k06uMIAbf3OJ+XM0UXqSMIbib9X
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cdanw9wtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:13:16 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDDFYp064752
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:13:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 08:13:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:13:15 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDCsHV009613;
	Fri, 20 Feb 2026 08:13:09 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] iio: frequency: adf4377: use dev_err_probe in probe path
Date: Fri, 20 Feb 2026 15:11:42 +0200
Message-ID: <20260220131151.74329-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220131151.74329-1-antoniu.miclaus@analog.com>
References: <20260220131151.74329-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExNSBTYWx0ZWRfX21AyfLat4+8C
 TZJj3vqGFAjimk+UYJyOFBLFoaJFHgFCUS5YLVpAdHonopiG3VK9RzNiHnNhRPci2006KLIFbHw
 0HmW2a+Yso3BWL7tEEFAeU8DrUN7K+B0ASaZlM+225K2W2juj/dwhZbLLZboweVaIS6xXn0OlyF
 sB3OyVpYekaxtAZlfcpx16IYzyINf7uG5/TNTXzttOhoGOs8EdReCCVY6jQQYRP0Y6JVd1ScDPj
 162MjYjsURfYXegkSxqi4Wmcecfy0/A5mzcr/9rTbQyzlkaEVlEe5j9oGWPe1ZNXc1p62SOjH1j
 GWCYoq/IFnXjVit2Kgwk0tIlZdTB4VDwNcWuvj3fO4ars8tECmr5aJLRHsZVfktRmH2TWT7SOJQ
 zYAR11Dv87s78WOTV2kumVcOkJz7HFSkmCpoddAWIOsM7uqO4/+uq9rsJmhBrDvEQ13r0as+zfF
 /BlFqaLlSVSkvCKYJeg==
X-Authority-Analysis: v=2.4 cv=TtvrRTXh c=1 sm=1 tr=0 ts=69985dec cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=B8pQ3PUFIzGLwB8xx_sA:9
X-Proofpoint-GUID: chntGoqEzKw7qS6BnezA7R8MNhvhGFvR
X-Proofpoint-ORIG-GUID: chntGoqEzKw7qS6BnezA7R8MNhvhGFvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200115

Replace dev_err() + return with dev_err_probe() in adf4377_init(),
which is called during probe. This simplifies error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adf4377.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index fa686f785fa4..7420eb98822a 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -712,17 +712,15 @@ static int adf4377_init(struct adf4377_state *st)
 	adf4377_gpio_init(st);
 
 	ret = adf4377_soft_reset(st);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to soft reset.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to soft reset.\n");
 
 	ret = regmap_multi_reg_write(st->regmap, adf4377_reg_defaults,
 				     ARRAY_SIZE(adf4377_reg_defaults));
-	if (ret) {
-		dev_err(&spi->dev, "Failed to set default registers.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to set default registers.\n");
 
 	ret = regmap_update_bits(st->regmap, 0x00,
 				 ADF4377_0000_SDO_ACTIVE_MSK | ADF4377_0000_SDO_ACTIVE_R_MSK,
@@ -730,10 +728,9 @@ static int adf4377_init(struct adf4377_state *st)
 					    ADF4377_0000_SDO_ACTIVE_SPI_4W) |
 				 FIELD_PREP(ADF4377_0000_SDO_ACTIVE_R_MSK,
 					    ADF4377_0000_SDO_ACTIVE_SPI_4W));
-	if (ret) {
-		dev_err(&spi->dev, "Failed to set 4-Wire Operation.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to set 4-Wire Operation.\n");
 
 	st->clkin_freq = clk_get_rate(st->clkin);
 
@@ -747,10 +744,9 @@ static int adf4377_init(struct adf4377_state *st)
 			   FIELD_PREP(ADF4377_001A_PD_PFDCP_MSK, 0) |
 			   FIELD_PREP(ADF4377_001A_PD_CLKOUT1_MSK, 0) |
 			   FIELD_PREP(ADF4377_001A_PD_CLKOUT2_MSK, 0));
-	if (ret) {
-		dev_err(&spi->dev, "Failed to set power down registers.\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "Failed to set power down registers.\n");
 
 	/* Set Mux Output */
 	ret = regmap_update_bits(st->regmap, 0x1D,
-- 
2.43.0

