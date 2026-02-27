Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322E3EBF07;
	Fri, 27 Feb 2026 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772196222; cv=none; b=Aq4dscx0qA/i6xFXUPxi8bO6UgLsctTXKbwwJHNGBAGGV0LtMOQbzZv8lJK34drTnowDfnqTix4u2Q5BmK2jaS6n7wVFUNyCrlFyON5Lk2rgSBRgoK7altkuf0skCDPa/Lo9SfUsO+ePAMdWH/ZO9sHhRnhlXVt7G7gNP5NlNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772196222; c=relaxed/simple;
	bh=WABTaoHr76ZUtVjEBRcsQaRKtYlYkyPcWkYJkIw7PTU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iwv0HnvR1nURSN0dr7HUHaZeNEVAwwRnVHTQ9t6DkQ23dVWAVQQfxbtPfM5cp83d/A8iXjBLskezf3gWTaNUoEQyIvEYkvBWCHRnxFoc8R9xnLCOBmrRg+yvD/8Ecfa3BHwea1gtQrAtb76ApU5vJcf28Ld9wmEFRdjezNuB9LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cSMnNgSq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cSMnNgSq"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RBUoZW1380239;
	Fri, 27 Feb 2026 07:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=O9cNGZlIZWJPjDLsLZm2A9/3oLg
	zLtLHksupm32azDk=; b=cSMnNgSq/o04dBpfxSiYXcWr/CNsrSaNeRPo/y5VY7y
	9ATz3J6uPFcFugXHBXG9rkdr+YlO/zD8h4hhtIxV4s9r870bxzFkn82XbfLjLbeP
	0YHAoBnsXmIRMYH3jRNTC75bsw+MQ6aJBBMXpIC5RRM3WIDDR0J1iTCz/9MXhKM5
	iyYfaanU4LLTv8VXrOAOkxtCz1eepE3Uxl2rCEUDPp3342GDsuKPT/6RfoOhQcMU
	AOPKKnre+n9csYwENIXM8vTuSlSPAzCgzl8TIKXv+E7/bKqp9x0unAJogz87SEVW
	cy+4hFzx+hhjTT0Iv+baJ7JtxvlxviskVgiUEpqEI5A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cja98qtde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 07:43:25 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61RChOxj056010
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 27 Feb 2026 07:43:24 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 07:43:24 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 27 Feb 2026 07:43:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 27 Feb 2026 07:43:24 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61RChDIf013405;
	Fri, 27 Feb 2026 07:43:16 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: accel: adxl380: fix FIFO watermark bit 8 always written as 0
Date: Fri, 27 Feb 2026 14:43:05 +0200
Message-ID: <20260227124305.55271-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDExMiBTYWx0ZWRfX9y4dazT4gmcp
 fVUqfh8SnkSPsiRiLuF2FMaYxbm9xPTamf8i4xaNecfEgbL8R3sMHtdZa+4XFEvnNhFzwTtc00P
 k2N26DF1WDQ3H81zbgI9d336L9GWQ7PAlJgZR/sxnp4nKfvQUqi1kR63hQpfrlcrsJXj/CWz3v8
 g9S+viMyQvB+01K/hyltk2lo9wNYz35M5yEMFBhJCeU/lijZWRTb4IvhhvY2FNob0O5za9ToNWW
 KrRyjUtICKnubq6Mfb3jMwpR524jwjaWaSqEUgerO723+JvIeGrCHinI4rBLXRWpZCcrWH6oMAw
 osnSTgaRH8I5mSmUTygzMjhY0CmVFIEIz/ynM3MkLHyS0wTicJX9A3cYQ/r0fCQnaen1sTAWy9l
 +3w+VR/uBbw1h3DlEAKApWvolKgNsi/R8brNP0QUin2xXCjx0CJi468PeRJQyulqxL9JBrBXWr3
 FSMTperUYzlTxEdlftA==
X-Authority-Analysis: v=2.4 cv=a+A9NESF c=1 sm=1 tr=0 ts=69a1916d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=RBIjZzELQoH7hPQAidgA:9
X-Proofpoint-ORIG-GUID: uydUqJ9xjCc1iZSwlFRLGDuU0xwVg_Vj
X-Proofpoint-GUID: uydUqJ9xjCc1iZSwlFRLGDuU0xwVg_Vj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_02,2026-02-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602270112

FIELD_PREP(BIT(0), fifo_samples & BIT(8)) produces either 0 or 256,
and since FIELD_PREP masks to bit 0, 256 & 1 evaluates to 0. Use !!
to convert the result to a proper 0-or-1 value.

Fixes: df36de13677a ("iio: accel: add ADXL380 driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/accel/adxl380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index 8fab2fdbe147..a51d1d61c412 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -877,7 +877,7 @@ static int adxl380_set_fifo_samples(struct adxl380_state *st)
 	ret = regmap_update_bits(st->regmap, ADXL380_FIFO_CONFIG_0_REG,
 				 ADXL380_FIFO_SAMPLES_8_MSK,
 				 FIELD_PREP(ADXL380_FIFO_SAMPLES_8_MSK,
-					    (fifo_samples & BIT(8))));
+					    !!(fifo_samples & BIT(8))));
 	if (ret)
 		return ret;
 
-- 
2.43.0

