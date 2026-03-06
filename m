Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6337D124;
	Fri,  6 Mar 2026 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792759; cv=none; b=NG1BcQYR8/ozkd9kv/SQSrX/BFX5ITVwwuk62iu1WzMOVD70kxyDKL4oRXgKec4JCmtfspFEDZMF8JrpSrEUyRR9Yo9LWlQ87jPvObv0C03w/nc8GerHTJIxam0cqIa48+5HoSUt0CVUM7v1Rer2bmIXu/OqTOn+Gkf9ToWge6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792759; c=relaxed/simple;
	bh=vX1KMbKvYu8KWxG4UfRSHH0cK1PoMh5jMHFxaF1ekI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0Hj1gS5Vc11Vw5nxZrUEokxBORrR7l4J4futwskvDD93WzgSX1SVg3ywqO7xKrQ6neT6ACvl5IT2ckHyKkTNrM2/+u+mNAisswUJf7K+q3nuGZ5EkNHtNA5dOqLwmLf0HrAQTjbLKCFzVdp7coowZI/GUGQEE/pLcbVGIwCATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=csmgdNJF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="csmgdNJF"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6267w4dE2140142;
	Fri, 6 Mar 2026 05:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WIVb9
	lwQahzaODILRrg//qJldxfJKgyPSC2odl7vSnU=; b=csmgdNJFeGrsW83PieRb7
	+2zJTjMm+uOtoFwk85jomWFPJ64BxPbof1utFmlrvGdNjZ+Ye2UABo2BUmTqxw7M
	h71o3AsAvQllLVylWHrZXDGC40nxhfIuBzaFRaVNbPGbvIAvnGEX1eNymTI8w+c5
	SytzoCgHc2sfrcPWT4qmCfg5qnnoAJ1HkmuQ6Sr99T6MPvnOuLLp+KEgQ9Umo98o
	T2GTF7uUuA2LIkXWJcmrk/6ZFYwzXfCJBwP8sEUsP9eLF3AfvzZhxhQsaqRof0AN
	DS6L+3YzoRqW1rWCSmhUf3C0T6WSwrmL0j0T6vn0tJTmuQejBZQBzpiC6+jCfGhN
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cpd6hjyxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 05:25:33 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 626APWjv007759
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Mar 2026 05:25:32 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Mar
 2026 05:25:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Mar 2026 05:25:32 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 626APG2T003684;
	Fri, 6 Mar 2026 05:25:25 -0500
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
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/4] iio: frequency: admv4420: add dev variable
Date: Fri, 6 Mar 2026 12:24:45 +0200
Message-ID: <20260306102504.42395-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306102504.42395-1-antoniu.miclaus@analog.com>
References: <20260306102504.42395-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA5OSBTYWx0ZWRfXz3vsnM840d2y
 +bXEymY9/szrTiVlgv6CUGFL9bJaTCUtmVWbtWJejBmtBL+jo8gbYaCeZ0i7JJ4VROmr/wREa8Q
 kQ9nLuu25Icq8yUfeX+txkC5zCgzbiJRmN4wQxvV8QzVYyKQUblQk+6mTo5XJwb3k6whZjzTbUC
 aNJrHnMrisI3PpTVy4UicvbavxE3GAUb/Q26xmp5Auirp3x/UPg1MoGjIjg21/gudNuxc5WIzoQ
 F9rc4sUJ11phXCrsLiErmwEIJAicfaiHpa3j4Obp9dHZ/KlTEKxZPNBEU8bte2q5mzlJ53NPss0
 ANsZdDbDVkpe14tcS0FwhM42zMc69cSpBlyUKzH8INDeJR0oroty0o/J5jMlcEG78CBWn4fe//2
 6Dmo2KezZ4j/jMFZbXOiSqxkOjFhCYBNgk/I3I0qZhQRN+bIFxyUYdABfWqSdmtNMfgTdWLwf9G
 AEOP6m2f2PQbHxwnLkw==
X-Proofpoint-ORIG-GUID: sUyfRjZAUNSeLsWU7WNgdKZyfxuJLag5
X-Proofpoint-GUID: sUyfRjZAUNSeLsWU7WNgdKZyfxuJLag5
X-Authority-Analysis: v=2.4 cv=Jtz8bc4C c=1 sm=1 tr=0 ts=69aaab9d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=lZ2AnQk9egpdupJ9vqsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060099

Introduce a local struct device variable in admv4420_probe() to
simplify subsequent conversions and improve code readability.

No functional change.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
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

