Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794842;
	b=bz5T20dXHVNtN99wUC8FyyYIlsaBQl7bUa+zruMLKyi7NdKL7d2d88zJi5oeCMiQS0WJ
	 lO2pvuOoBp8n4QzitwNqB/5clBdEo+0vddVCOWVRuEmbdVulrOByz5pr1XCFot+Y3wqOj
	 gVAv4spLSbRC81067z6+CV78YUNll4pYa+R59Si8zkg6qI6N6HC48vfhdGavTqJtS47uj
	 QZrvpR+Sb9YZNK9Llnu4G862lP9dkUY3/GBcOhgCedzjxSD4ann0FDcg/AZoNXtwLaYt+
	 b5EjtEOY6CocEGvEJ/EzNact+2rRJ1DcpFBTMrJKTlmmd+fsXr2RcKHGaA4nm9k3sJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794842;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=J7OlKNkqOcAvJS8cQS5JWoGfuER8n4SSNjI83mFgFfQ=;
	b=XafV6esoFYc4FzWRoSq3VeEuRQD3CswNN4ZlJrDTOiXp85JZ7IlBhuHwjKjodlIg1gP+
	 aiKFLgRVvAisjcOVkv6Oy9ovXnXz82v366M2wObl/zAVmzNZG/+0rjqkoyWs8x2X/s6Ek
	 ortd4JTKpqxuOpo8jRFTTLu+gK41jWzqoeafLQgXp+cMV3DCRJHhgNg7E3A87dQVjhE6e
	 1Z3OsddjW3HAfQ6H12OdEOz89BjM3ie+XlB+AKQJQoj7gp9c6aZCZWPGtVpSDcRqgJJmt
	 dPbATnbwhFlJuEp31CjYi/LlgCQ40uHKqyZdpo1WRsaynVFp4QBGgZaoJuvndApc3Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Bn45KLhZ;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=IGG0oOLr;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ACD606A31A;
	Fri, 23 Oct 2026 22:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5ACD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Bn45KLhZ;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=IGG0oOLr
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NLwQAq3008989;
	Fri, 23 Oct 2026 18:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=J7OlKNkqOcAvJS8cQS5JWoGfuER8n4SSNjI83mFgFfQ=; b=Bn45KLh
	Zhs/67iJH6VrBNEQcjsXq/NrhuhITb/zqDiC/BDVcp+cRmXn3DPxjbRFc5rUpO9z
	8uFmqoaXztS0EV5R93tCKvfLm/SMhf5+xBf4V3ybRBuUHABzzrbQhqglZV1mrUco
	o6RZ3S5T931armfkfJoMz5BYWQzyX5LipYh5fVELGxd/x573mEpYiUPDT/EUekLd
	fjupu1DnK9UD2xUu+gaHqMPOn42u8qv12lG9K2OoCndSLa1il5sdG9sG3lrJXtf1
	47yjuf32dd+yQ5v4Gs/8lhELPj271EZenw5AsDFX6PUYoMzoJ8IRw+sAlAepDdBk
	GmvnATkvsM1IMRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=J7OlK
	NkqOcAvJS8cQS5JWoGfuER8n4SSNjI83mFgFfQ=; b=IGG0oOLrbgVaBs/i2Kjwf
	sdrycWRV4cdhn2qU2iuhYRLszVG6dsrkgMkqEdNIdubv80RLASx0JtSSyote4gCo
	NVO/p2L276ZzoDgP5rdgAuAtOzuUbaVgizCO6rs+W6oa/gVajkec3QR42qKywupf
	8z3Mp83V9UFLxDPacbldV80d1NUhX6YtlfX5ilRjDdTZe+ILXBzdPbpUA5QPchPw
	cZbEYeAjoCSfe10yWL4s9keXZ68BqVTgeV5xmngiNwr0xfOPGQGD86BAvb3ObTOq
	Mk0EbI3e2ekgpKDDKBDg4qGI/glLKGOHJ48jO5HHN1Zu7rbg5p7PEqliO1/ZN0e9
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hg3574bjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 18:33:56 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69NMXtKP017475
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 18:33:55 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:33:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 18:33:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 18:33:55 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69NMXfRE005809;
	Fri, 23 Oct 2026 18:33:43 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>
Subject: [PATCH v6 02/16] iio: adc: ad4134: Sign extend sample data
Date: Fri, 23 Oct 2026 19:33:35 -0300
Message-ID: <7c4f63b3360b9c03ae1a2ffc1fa24744a553f177.1792792325.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792792325.git.marcelo.schmitt@analog.com>
References: <cover.1792792325.git.marcelo.schmitt@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: q8M11lTNDMbzkQsi7qyUOzfyEoNfvO_g
X-Proofpoint-GUID: q8M11lTNDMbzkQsi7qyUOzfyEoNfvO_g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfX42CO1ylCSRIv
 JBm8HabbhsXy5+swP0gh4Pn8MMsB2ghHKB9b04ysJWkpsgn0BkgJq5pIbsLuJiuSdMcYflk6lSC
 qowQZ4rkFPeO+zdHf4vovBnI410Iry/th4I87/MkQKkw1FVjISVfTkUF4p1i7V8lHGHacV1dfxg
 CXudnkgSRdrQVGsM6iVf3Sr9F57WtGo+GA41X5HsZlRtTFD38zaA5khpzaClkBuSK8dDr1J+4Bz
 7SRU+ZLPEVGN0cglCcsRhzS4Siy0atcNce/7pgOjl3saDlBThW9QqDRBuE/qtOOHRGaNm7a+eJT
 nuUU0Ryw0weAV5wVlPO8nO2RqWWt+0gpj5ouy21Av0PMFa9qEcIhaMJOEBh1rYgRcHe5x4EdZJW
 ogPaDGVe2qTgyc+18EPsUDiwWDpt7rnFs5aFQDdIOpC+0xgBQOPVZgdea6tAUnXmMq75s3QGRql
 xs0RVBT3JEJqbUkJYtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA4OCBTYWx0ZWRfX/QTRog0pnROu
 Np5gU25M+QV9FiWh6eCD+J7GRAM4VbXbEitInpCre9AKR16imyaRrxiPz24tKC74AtJAEVQskT0
 H4p0jEVtMkQY4z+8FOBr+dJSmHSSbg6DESowG8a0Jn2P5PB8/zPL
X-Authority-Analysis: v=2.4 cv=V5PoQuni c=1 sm=1 tr=0 ts=6adbe0d4 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=pGLkceISAAAA:8 a=TOduCJ2NwqVHWOW4apYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230088

Sign extend ADC sample data for correct delivery of negative ADC input
difference.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v6.

 drivers/iio/adc/ad4134.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 8400c3934925..40b27b01f126 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -172,6 +172,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
 			    unsigned int *val)
 {
 	unsigned int i;
+	u32 sample = 0;
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

