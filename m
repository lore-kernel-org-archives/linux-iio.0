Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C9346FC3;
	Fri, 20 Feb 2026 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594594; cv=none; b=M7/6SRL0m7w+DhSb75oOUv8RvbbTGEw3APtsydoYPFGsN1WCKuZQTm+YNdGcdTUOzkjrkOn+v7bBxQsoURkk1l3Lw3EuoNlq/+JYlqW5OTlpTArzoZTZ9Gu07L6tDCfmlwBDuc2L8AkYGJ+i20L32GsRdkefm6pJUGD92C4AvDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594594; c=relaxed/simple;
	bh=c9w9ojJY0Zj1bQAyziFS4TbfXjd56mISnuUW1WmSnEw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZWNoVljFv0kgK2cxhG7/XNcu9wsZiuLHYHNpBsSh3aURkOGPHlyJYq5M0JQd16V+UP5/tE/KeY0otYordlynVUFOkCvoZN+TkBMAK+HsshvM/L86aBKNoDwc7UbbYxelfCfs33wTswVXa3XSlJC9x81Y4R9jo2SGJmkeqtGAf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hqzDSoTI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hqzDSoTI"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K87FUt631909;
	Fri, 20 Feb 2026 08:36:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wrJ8m
	zv3aByd/lHOsefY0DYN7+hRqT62/zwjykkUdLg=; b=hqzDSoTIXdChXdsdPNdys
	a2M4GfuWv3FrScW0aU66QvlPUf1Jqo4RIEA3ql8eXw4mnDiL0HLQiL2Ec/sVh+Ws
	foLxkc5ouoOnMpjpYPrQ+VTkVDr/oxs4aP5FU4eS+oSkev1BDF5HYbk4mMKv2Btj
	mGSCwNcBGrSYytb6y5pdFalJNmjWuyBN89FxXU8fY1nTnku6w///ASzfOxP/kgf5
	lQ0jFWrov/O4mzcplwSjIg24oHRrpKMAhoZgdEn1HtoGCLrBfIIca58g1M8b4LZc
	tdqZyY+gyiiGecvncBNGiF0f+sEG94tp9pzXM127G+zbg0xMNdZSs2iVySIyhTBH
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ced6fa9rs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 08:36:19 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61KDaIMY002406
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 08:36:18 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 08:36:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 08:36:18 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61KDa2Q4010396;
	Fri, 20 Feb 2026 08:36:12 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] iio: adc: ad7606: remove redundant else after return
Date: Fri, 20 Feb 2026 15:33:31 +0200
Message-ID: <20260220133337.85216-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260220133337.85216-1-antoniu.miclaus@analog.com>
References: <20260220133337.85216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: yHtVTg6ZBfKmW6ZokRwhgGwsDMBGiXAZ
X-Authority-Analysis: v=2.4 cv=fPg0HJae c=1 sm=1 tr=0 ts=69986353 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=_ryPtA2YRaahFBO9UzEA:9
X-Proofpoint-GUID: yHtVTg6ZBfKmW6ZokRwhgGwsDMBGiXAZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDExOCBTYWx0ZWRfX8oNLgeUpN3mx
 I2YcnjOUYBjAddiyaGZ88eqauLzlZbOJ9C1APNUU7vUXq3WClod5wb9QHwfGoMEXrNNfpSrMoWh
 /OQsY2Sr1vzvyfivwCwMNmUnm48z9KcOpZvtCRmAjfEDCHBpeuj1zJ6AM4Q/OkcrsbtzKuad++v
 m2aHuAD/3vS7mWiRMC5pTzAO1e2Lc3OWuxMvXiN7HlI0U7KX6V1IV/tLOQvYxZ8f49AUroGNyif
 EUJdRDvyIcSWt9Q8OZyv64YJ0LvzCnQ5wjKdUTr2WOL5GjUO1oRnMJNThFZOZLWIyT78PKM0ToG
 uFnNcfQcgQSnQp8RLIozZK/wyrZxdaA9U4Wqzw7d1+4YI9BKKWBAfxUyN0Rdz+XugYYRNOCU4mb
 AVnu3nkrQ1O3G0hb4YqYuLEZpGQCpdhZMJQnISH9Ee2sosZut0Yww4WfYmP5dhG7Cm1lI6xNODl
 hpwmJux76Uw2zNLECXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_01,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200118

The else performing the register write in ad7606_reg_access() is
unnecessary since the if block for the register read already returns.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7606.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index d9271894f091..8ef3f7b8a6a4 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -540,9 +540,9 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
 			return ret;
 		*readval = ret;
 		return 0;
-	} else {
-		return st->bops->reg_write(st, reg, writeval);
 	}
+
+	return st->bops->reg_write(st, reg, writeval);
 }
 
 static int ad7606_pwm_set_high(struct ad7606_state *st)
-- 
2.43.0

