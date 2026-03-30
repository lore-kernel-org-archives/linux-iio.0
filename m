Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9980F3C6619;
	Mon, 30 Mar 2026 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869668; cv=none; b=LTGviVozJcpLRaRG/TVmSaJAou5AWrQhwNV+kAKAPVVt3jT2LgnraICzW84YYGPsH9vU1+6eAMob/sv0lQwYUc3LEHkGMetEUhQodIiSQP+g23rWzgYlgPyC+X/iMS3B6r2sLdFAY4mT3Z7yPnG/7gxfsAISTzhFLJjGsBRHeqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869668; c=relaxed/simple;
	bh=bkto8uHvJrKzfl1e/kYuUEj35h/fcuZeOlw/ZZ7/9T4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYY4XFLGga0flW6XTjsunhfgrJhiC4glr3mE0piyVQb677nYY0ZHzjJdJ2k7MXBWtu9uoNi3GmovWdvuSH3+v6VlOckq/zks3US1hTcLpwwWpnBZ03O+psCZ6BFmJD0jmm1jAA5wQrPFvdrc8uGLggLcqrsewtMNJzF5G1XyOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iJ47EbOF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iJ47EbOF"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAwFxE217508;
	Mon, 30 Mar 2026 07:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=V41Ni
	eJEo/xS5gJz+bLXGJzpAjFEx1WqetW7gu/sYh8=; b=iJ47EbOFWTjGnoXabUK59
	B8XK0VksDRTo3SZloouRbI0Y599t953wgwaK3acU/kXLg13X5wCK9tQeAN1EGFMk
	K/Xd0Zni2y1uyg9zkXekf+N/dVquBO2G1J3ozKK/3278Vre4kKEXTcPuMVuwy/sI
	ieRu7dybLC5WNMbNd+rls87WzTAYoZSK0dhBlPSFIozpQXwJmo9A655NQDCIUxx6
	qIeRM+IdgbLDJjUJffUJX94b7OhtHyQSc96OPHkfNtbwBFZRhGnH9slkowzI9PRR
	WP/AHGq+QY8+/XlnjOo+PrwYmaZ8flRjL0GChLkNNkBR3HJxQWrz/uMNGUgjl+Fd
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d6wab4782-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:41 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKehq026915
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:40 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 07:20:40 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 07:20:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:40 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDga014225;
	Mon, 30 Mar 2026 07:20:32 -0400
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
Subject: [PATCH 07/13] iio: adc: ad7292: use dev_err_probe
Date: Mon, 30 Mar 2026 14:18:50 +0300
Message-ID: <20260330111856.121589-8-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: DLhorja5KVU-fR_QQpI_WCg4xVwUjbs9
X-Authority-Analysis: v=2.4 cv=YJmSCBGx c=1 sm=1 tr=0 ts=69ca5c89 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=K8fRmz8qadsuYCWvO-IA:9
X-Proofpoint-GUID: DLhorja5KVU-fR_QQpI_WCg4xVwUjbs9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX4PTKm9gOSp0L
 TvnvZVVYY/qZvVuPwOvZj4/j8NgD8p1A2z800x1OXCBNPOq8SXWNUOY3jv2+Q7ecHA8PBWvUxQI
 DjIqp9kTv1/sd7KadRxDgu+jJUW4JKCjQzMpH45oRLJB5QEuram0aNQGWySxeo0kcOJ1cPJJDRg
 p4stELQN5bySVq+hRbfgWjF3F0opRstnqvY7YUW2+/VPBOWtxPGnh7qhxejux+DUdo2tGNCFiwp
 cJtepBPNIlpTB5+BFr74nkicCduMP8ejhGX+bJVxA3dvGLnlSYfQF6hTbrNShljYKSu+JhSj3zT
 z5fkXU4i/8hjZVjyUIL8Oc2ColqrHope0BH7+Uz75U1BQCRjCpgA8rk+TJSWcUg+Hq3T5qIO6Tr
 1krtRad+Sd7NRN837TxSNIbY/T7iHHhtWN75LP/mTnbpKL45Ev7WVsfFxsFKcOoI752jIy6OOoT
 TNll3AEdTMxuFWhjOmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

Use dev_err_probe() instead of dev_err() in the probe path to ensure
proper handling of deferred probing and to simplify error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7292.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7292.c b/drivers/iio/adc/ad7292.c
index 64d40b053582..e5ad83d2240a 100644
--- a/drivers/iio/adc/ad7292.c
+++ b/drivers/iio/adc/ad7292.c
@@ -267,10 +267,9 @@ static int ad7292_probe(struct spi_device *spi)
 	st->spi = spi;
 
 	ret = ad7292_spi_reg_read(st, AD7292_REG_VENDOR_ID);
-	if (ret != ADI_VENDOR_ID) {
-		dev_err(&spi->dev, "Wrong vendor id 0x%x\n", ret);
-		return -EINVAL;
-	}
+	if (ret != ADI_VENDOR_ID)
+		return dev_err_probe(dev, -EINVAL,
+				     "Wrong vendor id 0x%x\n", ret);
 
 	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
 	if (ret < 0 && ret != -ENODEV)
-- 
2.43.0

