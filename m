Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C63B47FC;
	Mon, 30 Mar 2026 11:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869656; cv=none; b=ELoQkePbld9sLilXawqZTb7kLmBTDoi71X1tuAcRD7vVWt5OA9ZCinCxjcY8/EAR+XejtAGPNW6SaSA+Lfv71f+DCrM8rHj67/PBOoKMvlG6igq7eVFQ9WOoUZc7v9uIjqgIDWq9b5jy+sXp5jN2jP1+WraIQm4llbH6QI8uBdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869656; c=relaxed/simple;
	bh=ta3USsTzCkdW/hUeHq05JFtmK/O/UClmpoMITevJkmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TcKmmPCJlkWCCcUdm4lHsVvv2y+G3VeqDh9m8Xg//B6qwCKQuFqOUpogucsabOe7kb8F04rB9y5FlcJPxMXN/E3lm8nb2mOAo/fxspy4zZvvotVhh2HoQFrhfeLrtTVbaGkwMoGR7hNsdzmeXihRspt670HBvwijcI6aJOewRfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JTdIJ+Bm; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JTdIJ+Bm"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UB0SFX1037162;
	Mon, 30 Mar 2026 07:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=B0dCj
	1Tm9+7sOxaTFeG/62gnnNl3tVaKWKdbfZ12r8I=; b=JTdIJ+BmE3qM5S+CS3Zcs
	1lzolBqxEksc+VIyRr5dmX5/lefF3TXDo9yUFozJHTTCW4gGaZbbvYr4ANPlU76k
	PahfIPWZFawYp5gGRWNaMpFpGAWfJpS1DaX3KRxFN1JA/FVA8uCplgDXP2lL5WrE
	1SIvpel/ycVOspvlTsO+4YqAykqSu7esFnsCqZQ370iZl+G8JVLCnxhQiVmI1QD7
	mbInusxR0nbud7s/AcLBTJA3+zeRw3sYZXmsBAH+aN14Jfw1rcogdQHRrsO+tksn
	/OjakoH7l+FVe17VKruyMjaPDUnlX2KXeBwEabx6t6lBKa06ctWjEUBX7rbVAQfc
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d740ybbt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:31 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKUEC026867
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:30 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 07:20:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 07:20:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:30 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDgU014225;
	Mon, 30 Mar 2026 07:20:22 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jorge Marques <jorge.marques@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 01/13] iio: adc: ad7949: use dev_err_probe
Date: Mon, 30 Mar 2026 14:18:44 +0300
Message-ID: <20260330111856.121589-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330111856.121589-1-antoniu.miclaus@analog.com>
References: <20260330111856.121589-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ANnNY0ku c=1 sm=1 tr=0 ts=69ca5c7f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=5bXQaU6tI9Ar1A2g10wA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX3hQsbx9z5May
 10l+uvnX970e18V91QuAFL/dWJi+P+FPvGi99+ST2tUR98Wg2c9HGIF6EL/9WTSkLj0PIdvoL+5
 5ENmkGDNG07Z2MmXn+so5xNaMYmRwDMzj/LznHAKdKi3rNm+urpmIZANlWCqXQ3dUzoW8jxjHa+
 1xoi2FGCtKkS/qKo7IO+cYCOcsJr/aLv4B85xKGexB3Yxiy803bkQ21wILwIDOSIdMDUWFDcJh+
 ljCDM8yTu8eWSXn4Vby5YCS6oJ2WzEhcCzfHDkqObFoEoEG8hTlZ772YlY/i1e54eCYGG+Ea3u3
 bPfG0zSq+AY7c3GHXcksO+sXzozYTct+4NUWlztB1OjdnBiltTl4/qQlRqxykE2rHgr4eJFnBte
 VBaoTbyrXA14CWbOyfV2FnMeXgnDgmhKTloVSI8Ir910ECRdi3bRKTS3aqwMvPRnW5ZYrb3RviC
 VhkArvmVQNWGEip7H5w==
X-Proofpoint-ORIG-GUID: 34p50CAAQyJSLmd8sjmYpVpZtzKAcmwV
X-Proofpoint-GUID: 34p50CAAQyJSLmd8sjmYpVpZtzKAcmwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

Use dev_err_probe() instead of dev_err() in the probe path to ensure
proper handling of deferred probing and to simplify error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7949.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
index b35d299a3977..ebc629bcfd4d 100644
--- a/drivers/iio/adc/ad7949.c
+++ b/drivers/iio/adc/ad7949.c
@@ -341,8 +341,8 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	} else if (spi_is_bpw_supported(spi, 8)) {
 		spi->bits_per_word = 8;
 	} else {
-		dev_err(dev, "unable to find common BPW with spi controller\n");
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL,
+				     "unable to find common BPW with spi controller\n");
 	}
 
 	/* Setup internal voltage reference */
@@ -357,8 +357,8 @@ static int ad7949_spi_probe(struct spi_device *spi)
 		ad7949_adc->refsel = AD7949_CFG_VAL_REF_INT_4096;
 		break;
 	default:
-		dev_err(dev, "unsupported internal voltage reference\n");
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL,
+				     "unsupported internal voltage reference\n");
 	}
 
 	/* Setup external voltage reference, buffered? */
@@ -382,10 +382,9 @@ static int ad7949_spi_probe(struct spi_device *spi)
 
 	if (ad7949_adc->refsel & AD7949_CFG_VAL_REF_EXTERNAL) {
 		ret = regulator_enable(ad7949_adc->vref);
-		if (ret < 0) {
-			dev_err(dev, "fail to enable regulator\n");
-			return ret;
-		}
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "fail to enable regulator\n");
 
 		ret = devm_add_action_or_reset(dev, ad7949_disable_reg,
 					       ad7949_adc->vref);
@@ -396,16 +395,10 @@ static int ad7949_spi_probe(struct spi_device *spi)
 	mutex_init(&ad7949_adc->lock);
 
 	ret = ad7949_spi_init(ad7949_adc);
-	if (ret) {
-		dev_err(dev, "fail to init this device: %d\n", ret);
-		return ret;
-	}
-
-	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret)
-		dev_err(dev, "fail to register iio device: %d\n", ret);
+		return dev_err_probe(dev, ret, "fail to init this device\n");
 
-	return ret;
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static const struct of_device_id ad7949_spi_of_id[] = {
-- 
2.43.0

