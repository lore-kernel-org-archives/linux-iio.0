Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB393C872B;
	Mon, 30 Mar 2026 11:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869672; cv=none; b=abXOW+WzLPz9j+e0uDCK4YDoUUXSshLa9wU0qFLTdgf/Pzo+9zhmIHl1mLqJpdygusQdtzYu2FnEDPEWJre4kAeo4/gPYoBNTvl/uVc4LKcQjwXg6fxByQEYEGX0fojOBAgtzWUiFHnrH+YPnZ+UVRMBYbi4oeK5ZlA900W6kaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869672; c=relaxed/simple;
	bh=nxCDkOxjPenGRRkIYldU4/VGgS9GlgaITD5iYtxqy+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIYc0C20lXvfJEckwejlJkAtG3ZJqE6fvmkTFslK4a/Z1ucY6PB1RW2LWKNcZ/xvU270CwGbZRWpwfv0KpWjE+2R92Y/b0lOIYtre8blCscb70HS4W8BrOYnH7+RNwTUuMfPKGZZLGs+iEqXaWZ4ax2trCuSRMxduT300+EghSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=JjU20Y0b; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="JjU20Y0b"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAxEr42846686;
	Mon, 30 Mar 2026 07:20:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sGUlD
	nO4SQy7Y1+0XtpjYg6RgHnhyUMJvGwb/1VZrNY=; b=JjU20Y0bN7UmDqZ2ME/6A
	ibQ489JHAonHZ7UylLScHrqNB9z2UVuWqtqO3n4tOF9ENTaXIDqbA28Gi8JcrpKs
	hqUPIKWyXp3qQAC0GC9m9FAIjFYZe1yrBKmZhnxw8E35N0m3CTLlI9dS0LI326xN
	wVH6wDoX18QAzXgZrN+HK/FhWq2TpX0BNpopdtOaJcWwHL2BJYuFLXJu0gfYh4sd
	E5hOpBjGDKcc20xg46/VPSpCkmJSCCmA3zhqB8eG6YnwdQJl4YWlvcaJI3AbC1At
	B/uL25+gQvntCABnnh28wjUW4lSrBgyaO27MajuVZ3fxSd2/fyRQ93D3MRqpTqrA
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d6bw0xs1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:49 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKm5j026951
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:48 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 30 Mar
 2026 07:20:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:48 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDgf014225;
	Mon, 30 Mar 2026 07:20:41 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jorge Marques <jorge.marques@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 12/13] iio: adc: ad9467: use dev_err_probe
Date: Mon, 30 Mar 2026 14:18:55 +0300
Message-ID: <20260330111856.121589-13-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: 6sfala40uqlH9pfkRt2RSzXNpH16aHcH
X-Authority-Analysis: v=2.4 cv=BqyQAIX5 c=1 sm=1 tr=0 ts=69ca5c91 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=noCrUjetKPCLGXENsFEA:9
X-Proofpoint-ORIG-GUID: 6sfala40uqlH9pfkRt2RSzXNpH16aHcH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfX8JehyhGes7EJ
 mAAyiUGkz44wUiewmw59MQoAQRalLadiXNawkl78MuxQSuFqbhjxdIHPW1A9sRZkW3Kuk+julib
 9IWurAwPlyR2pyfaIk2mX+e5ys8mK6NOwDSmBUAKZj6Srz7tWBiWYMBr3+3VigizxP0MHspxR4J
 gRSnv2v5+1ztOjuRpW9kuIwe4P1afbyFhFLJgeq/Ca3sQU/x4DzfI/GgmQ/lS3ZWrvs6m9Da0o2
 LlgWUESMxFDVvx43Hc13+/++d8S8wsQgBexuU1jfJLqdeYSNjg0xTxxhpM8CW4VUflHCyjdnATx
 5p6Kct1RjHiZBqR00EFgxSJSEMcRJwLswTK1v6gXoeaBUGeYQwr6Sdq7YuYUnQatmiTa02q+yD6
 ylhCNTb7ZURr17UTFM8v1a5+dUr5JEwCrUjYu4PV4rOleLgZS0Y64rvJrhKRtlOTgT7xH43ZoEU
 foL1YXeUOhVvBOZeMLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

Use dev_err_probe() instead of dev_err() in the probe path to ensure
proper handling of deferred probing and to simplify error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad9467.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
index 0bf67437508f..0c377f9a7f25 100644
--- a/drivers/iio/adc/ad9467.c
+++ b/drivers/iio/adc/ad9467.c
@@ -1349,11 +1349,10 @@ static int ad9467_probe(struct spi_device *spi)
 		return ret;
 
 	id = ad9467_spi_read(st, AN877_ADC_REG_CHIP_ID);
-	if (id != st->info->id) {
-		dev_err(dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
-			id, st->info->id);
-		return -ENODEV;
-	}
+	if (id != st->info->id)
+		return dev_err_probe(dev, -ENODEV,
+				     "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
+				     id, st->info->id);
 
 	if (st->info->num_scales > 1)
 		indio_dev->info = &ad9467_info;
-- 
2.43.0

