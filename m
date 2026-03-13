Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243E6390229;
	Fri, 13 Mar 2026 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773403111; cv=none; b=DECPuJu6TK5Y8Wn3eaIVV73cHpbudF4dnjZ/by62739ufWHLzOzSBQGhdWmTwIP9c1V1OFOShN24oJMGdsBlm1i55g9tZY5PeGTvXhz8zUvRy9iBw9sUniu9B2pF5nuvG0+ku+gj1APnucYqZqqXkNUprh5p86ZR3aYeqNkCyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773403111; c=relaxed/simple;
	bh=IZ2wxagAcWSa9Iw81akn3/w+gAZjiyRE1I5tYZZ+N4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMG4ow/Q+JZG0B3sPEyx0J3mJkm5l4j6dgk99BiXE3Y468Iil2/CSYnmykJFdf9Qgbk0yVx6BRoG3zMiQg8W4GCLB91SvxhZxhQGMfVAcDzlI5qlwGy/2ZnVL9Rkx51MObO7b8SQbH6g7Nw8bAVNJ68QKwUll5PrGOUmuUd8rKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gM1x+G2k; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gM1x+G2k"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DAKSo52907096;
	Fri, 13 Mar 2026 07:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=72fHS
	Nspt53onFw34g/FZYy+lUxRj8IDqVGlUFXDD+w=; b=gM1x+G2kcKTpmvtr0lnif
	Kctuge9fmrzpLuSmgI2YUGayn0nZESjcgC3HcbuXmEtBhMWjIJtuzeBinVoFOPdJ
	/AdcaQqr25WBkNnSTk9K03vxnJxrEe0IEWkXxq9OwrMlcYkBm8VZvjCuZ2uZFZT+
	C8MdOoAe13lbsepSEG4AoETUdRDtDECOtPOz5ixEqaN5UQ+l2WsDNXiITzTuSsk8
	HGrxn8IOQ8wgpHnOAIQGNU4v67bFAuBNdeUmEJrpYuqEYpO4AnkE++LttpkuwXwX
	qtdPyrwvge2PsN8g9PXEmta7fEWfflhk58Ed/zcsK6jwLPKV/7I5mMjBWjWAGOBv
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cuh50xyyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 07:58:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62DBw9Fa017524
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Mar 2026 07:58:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 13 Mar
 2026 07:58:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Mar 2026 07:58:09 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62DBvrv1024538;
	Fri, 13 Mar 2026 07:58:01 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v2 1/4] iio: frequency: admv4420: add dev variable
Date: Fri, 13 Mar 2026 13:57:41 +0200
Message-ID: <5983c617d748a6bbee44694b8c6f0e18e8499c71.1773050333.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773050333.git.antoniu.miclaus@analog.com>
References: <cover.1773050333.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69b3fbd2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=lZ2AnQk9egpdupJ9vqsA:9
X-Proofpoint-ORIG-GUID: SV3ZzdiksJpuNymUeflAX1kfGNz1YVJN
X-Proofpoint-GUID: SV3ZzdiksJpuNymUeflAX1kfGNz1YVJN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NSBTYWx0ZWRfX+oJT/cfYjpdm
 Dl6FnIRb4xD/juAzXPuDx/Vb8G0IjhonkIAPtGB4G99abQp1G4DLpCYQcn5fFs7fn3zsepY4A14
 RPNV/wfb/hzy/Wt6vw9IWoPQcpDTo30j6YCwkAh5/QUXwTJ8GcZbCcxkZwYGustAhATYoZKk6vr
 S3v+vFgQM8lAkQmeB5pdOyGQnvrZSYe5TdA6S/H3ZjiBbdY9etixSv+F556s1bwqgC2pWTMG6A1
 GWs7EgZSGMRJ8uKT0nCelrZUFSdBo1pcuxZtZQ62avZyR4kqQI+4z2pIn7QItAMNHojvD9Y5xla
 MsMB7B24xtxFE7BW7LldFYw3rwNPKKw13Zs5vtk4aoYKhd3ZGBBjZOPs163TDfjZcbG5q1qdi/V
 rK0F7dIIxPdfwnc8KIEB+RGAyK0CRS4U3xIqtoY2BGJ0CAu0LCR0O7VLO0Y+zwlp6gKaB1EFL2e
 TABRiZUc93Tow2DTciQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130095

Introduce a local struct device variable in admv4420_probe() to
simplify subsequent conversions and improve code readability.

No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
  - No changes

 drivers/iio/frequency/admv4420.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/frequency/admv4420.c b/drivers/iio/frequency/admv4420.c
index 8748d9747639..6ebfe08fc211 100644
--- a/drivers/iio/frequency/admv4420.c
+++ b/drivers/iio/frequency/admv4420.c
@@ -344,18 +344,19 @@ static int admv4420_setup(struct iio_dev *indio_dev)
 
 static int admv4420_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct admv4420_state *st;
 	struct regmap *regmap;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	regmap = devm_regmap_init_spi(spi, &admv4420_regmap_config);
 	if (IS_ERR(regmap))
-		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to initializing spi regmap\n");
 
 	st = iio_priv(indio_dev);
@@ -373,7 +374,7 @@ static int admv4420_probe(struct spi_device *spi)
 		return ret;
 	}
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct of_device_id admv4420_of_match[] = {
-- 
2.43.0

