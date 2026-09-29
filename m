Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA793DB629;
	Tue, 29 Sep 2026 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721776; cv=none; b=DXs0b6jOmgQ5+NlZABlXMOuE7IWHz/WZZYDdK59o8mClRnQBmKSwLcOVApDyiEQAu9yFsRxqI1qUU+tk6FCjzERBkbY44eli9VXmxEbHNSGM4gygqu3Yw5EQMBCNU/ch40bvVvDaHJOkdJGT2AT4bexce1pq8NDe/3hWbNUgSUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721776; c=relaxed/simple;
	bh=cZYy5H2cWcVcFKstV3y6Azq98fb6O17WQ6CFvtNpUOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kCrKgEJWRS0di6JfCkDWwADHOX/+nynewja4KYgXgst57VH900xoLkh163ZZMfFscqjzeY1HzYOzseg864tRWBJ0Jba+PBOD6OzDPWiXViR80w3OtTNEaEJyB9S6FQ73g+DJ2TB0gw6uYMMK/Agc9FMG33D3dYXCiLzk4ddYli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IOqC522I; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IOqC522I"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TJn2xn1957991;
	Tue, 29 Sep 2026 18:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RSM3A
	4VBbYOYoqVXdHQdGLolZaAFP4dcpx55EId2+6M=; b=IOqC522IBc6HtMV8IB2dk
	fTPnOtOrWX0XtrROq7qs6TGNK94F1had8mXiZaY+VIeb9ywxzJpjGhDT9Nd9rwRV
	+CNz592vAcDBf3bpqwMHlM9wWvgPo5aly4rIjB4HWZ8sR8ZLZGAmgCRLAok3rpbB
	WmoKNkder6fV1k30lH7eITbQWN6otrlXXFemOY5mn+B1GgVvwsIKaYYUl6MyqzIU
	t0OmWbRsojIpukjXHFXwGeJShavlUxxzmeIIlu9YSfe1nqy4Ehl5syr3SD7I8rAU
	41gAZQYHNybgYEOWnhxt3Io/raq6srXynou+jLlCdBAk8QxtUCNE5A33el6xAfc8
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gyy3vffx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:42:50 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68TMgn4C030125
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:42:49 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:42:48 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:42:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 18:42:48 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68TMgZPP008173;
	Tue, 29 Sep 2026 18:42:37 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 02/13] iio: adc: ad4134: Sign extend sample data
Date: Tue, 29 Sep 2026 19:42:29 -0300
Message-ID: <a57b3a24401b3101aa10b69173e5edbde326e741.1790719424.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1790719424.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: vRswZjLY1T9TGwzyD6DDoB3r_aNaTKb5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX+mnFqCGk72Sm
 kJ1CEU+oz3a9liLvlPQ0njqAXq9ueDJh/FWxe3JBqToznax0fe+wauncznjIcicf1uL628LMhx8
 a/mvaJklMxjYkwBTRZz4DNsEmF3rtYQMDY+Qm0aMRIARSIuJ/rKvE6UUEuURMVhWD22N7YpvQNR
 8Kpz2n35/oUMhe9k4cJgJOTvNz59WevVUKvoDFVR6nbucHHlpwMrcabhOEjrV4OG2avL1Ma7pVi
 mXGs3c1pGwhcu54E3FSc8N3zwi2GaJU7fhccMVK55wRrJOe2Wib3aPVxv4Op/iotcGuPGTxZNiX
 M76tE8nhhz5+oi7Bhqz6uPuNlL6WwuwQawoSPSArvOwaWr1ZonV7zxL3k9lCVXv44DSV0StEg7t
 BcXyvUeg5o8RwPLAtgJMSDFhVXKoK5AHr/inj80xmlYWLq/s/O0zv1hY1U964qYqyuwF+MHz7VQ
 vLsdGguEyq+WxJZSigQ==
X-Authority-Analysis: v=2.4 cv=Y/ltIReN c=1 sm=1 tr=0 ts=6abc3eea cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=TOduCJ2NwqVHWOW4apYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfXz42yDWY8ZjWA
 KO3GF5YSx8qEJUrDdBnEiEZR7DuPyGRY/i+dtsBm9krrz4vhAptnczGux3sJxJFYAif3jZYcZtR
 ecLLDBDWJY5cYZ5NbD4F4kElQtWv363sHy9e5Og/ZSvIV2Y6h3mu
X-Proofpoint-ORIG-GUID: vRswZjLY1T9TGwzyD6DDoB3r_aNaTKb5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290090

Sign extend ADC sample data for correct delivery of negative ADC input
difference.

Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v3.

 drivers/iio/adc/ad4134.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index e53c10b9a44a..6fdeb27d7a42 100644
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

