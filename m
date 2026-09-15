Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F704C1505;
	Tue, 15 Sep 2026 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499551; cv=none; b=SHktFeMApZ4m9WZaLTdM6yNzPQQZxuH8P8+1UR7ss9WHjdASoCz1Z0kJlm2Ht4tAWFrMNzOmwPJV3yoZwN3kj1aNclpdyzcIIg/PayghDefTH9glZMhw/dgpQmIlHMB5utSdACXdq/+r5He80IBvjtsmLCjjNn3p/upp6u7kq+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499551; c=relaxed/simple;
	bh=0QEKyN/9tH/qcjE0AsvdViKlebK70HdYiFfSbOlV5yA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsBnMywEVmOXj5RQw4rCu75Xrxl3BvIhrGQQ64ilHtEH3pJykN6TxxPLAddhLD7y7tP6eO9Zrxg0YISUcySKaEyzLMx0g+1gJq6NdLAXuK4TWswJgkqOTG99LOm5WK7Oor0eIiypa7yCHwK5mqhBMC/1BrZgmZXZA/+M1E5jCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rWYonRfF; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rWYonRfF"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FItjXP685827;
	Tue, 15 Sep 2026 15:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=b0yeL
	g11rqUqacZxXEuFjIBfnImrkWSCLRwgtKnhgsM=; b=rWYonRfFzAiqJAzYcMWz4
	V04BKrv3eripXqIBNeWNMU6Y4Hr+iAaxeYzv1wHje3lU5uBjeCovNV+d6wmDaBvQ
	rbZBNQnK/LGRHrN+aTWSSRX7BzsvGCuZquhaEZTDzY9oZHl1G0zTnLPjXFWBZQnX
	5jjgIyzyigoFw086b9Uj5RNQoYc4iH2GqAK1bqfL0MJV7ubZkCDyidf7uSNfRfP1
	kEdN74wwLpiONyovdytz9iwZCpLy5qeVJvo5YBAFJMZ82CmAzk5MtcdlGlsvB4pv
	hhNvYBKaYK/+aKpe+Si9rlfAAsT2xp/e3HX9b/HU74G/4td2c+0r7SkFp66Zl+bQ
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gq4v9jg7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:12:20 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJCJoG018935
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:12:19 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:12:19 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 15 Sep 2026 15:12:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:12:19 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJC5Zp028108;
	Tue, 15 Sep 2026 15:12:07 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 01/15] iio: adc: ad4134: Sign extend sample data
Date: Tue, 15 Sep 2026 16:11:59 -0300
Message-ID: <7083358e62e3edfeeba0201aefd8d3195ee951d0.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=JekpPkKV c=1 sm=1 tr=0 ts=6aa99894 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=TOduCJ2NwqVHWOW4apYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX1diqo2UsveOF
 kTcn9gAmL2KjPNyNDdMKfLnwlVJljkXIDY3fYYqU2b9INF2ES3DPZMcKyfGQSmkZMFwHQcxTT+U
 sJEpkKBrO9XfAzoFTNYBWKCF53c/dh4ob38IqHQmBma6v/0uPDByA0vIwOk0Hg4HncBgwO2Rxfk
 5NBl4SMxgUN2HDzI0pO0UW0GwOr4c6vbH5RIggQpV5RoYSTnnj+dxlOn07oxJsOT7DJzpAi15kx
 HG1TYLtj2y6NlQrwxs8NTtac0Y5reid2/RoGo6SoFZS3Mjuaa12eTyZnu09s5e68igc+eyFcLrh
 YopZmOnsBtoXxM8sPp8btieIOYjse7IfriyE5YsUiKCm9UdQe0xZgeLUMB9kyhjYwDnYvtKYdwT
 i/5yhHVvOFxRvJeaQJx2jDZczlcrXmkGj60+L7H6KXQhFi6Z9x46eED9ef5xxJQr6DEY/9YGlCv
 YIxRqVt3psFCy5DTMkg==
X-Proofpoint-GUID: BiAI0m3T7Y7GHRzPngG8tZZxOfhKN53x
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX4Bx/HFo1P7FF
 Btxy82nWFmovnF2WgLkW+KW9aLmTs/AI90nr3n5kj+We2Fizw/hplNN9eaDG0ct+IfbHGaQ5UjH
 8PzzmDmZkt5zEPjDUK0g2Cy/zacj3HAwXz9sT0OC5kWo3wIdgaNE
X-Proofpoint-ORIG-GUID: BiAI0m3T7Y7GHRzPngG8tZZxOfhKN53x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150280

Sign extend ADC sample data for correct delivery of negative ADC input
difference.

Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
New patch in v2.

 drivers/iio/adc/ad4134.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 0490218bb0e9..7d40c0521bb3 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -172,6 +172,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 			    unsigned int *val)
 {
 	unsigned int i;
+	u32 sample;
 	int ret;
 
 	/*
@@ -196,8 +197,9 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 		 * Clock out data from all channels to avoid that.
 		 */
 		if (i == AD4134_VREG_CH(reg))
-			*val = get_unaligned_be24(st->rx_buf);
+			sample = get_unaligned_be24(st->rx_buf);
 	}
+	*val = sign_extend32(sample, AD4134_CHAN_PRECISION_BITS - 1);
 
 	return 0;
 }
-- 
2.53.0

