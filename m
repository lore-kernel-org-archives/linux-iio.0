Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055981;
	b=Qz10TGhVR3a7nTmFmZKiZE5kfzM9UYMnORiMCbC0WndG+Ct2fClmnN5leQqzmZG+D6Pz
	 LCQwFw+qSMcv0QIApH9TU6mVczYw/fJZjFN50AkEb1HiksnfpnoZLvxkgo+TLPGuGyz9B
	 ZzjQzTNjOmDhufbXye1PeKp5QSFukRCygZ6RBWCfzqY/6+tA3uiCZl8BxIYgUaIsWE5rB
	 tnpIqewvqMBnpx44FNllRaYrRv+dNR/V05q7AW8Op1/YKzV/BRn6X6tgjqUM/BDXpGiMM
	 gIjHcw709Pyrqz25kjUxK8WV305j/Gi+774zzhnHNONuq1rOlDBzfFx0H13zBiEFeog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055981;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VY6KzzE6OjMcyrI35J+o3RPnfsmVqnisSTdzPt8kf5k=;
	b=OirLjFIWyr67IohrjRD/QiUWkE3lH6rVh0VxHgEELmgd0vdML3o/hsQh927KLPyZ10J8
	 x2iUGkruqkYVCh5D/olcZQTCajvi5HSbAOCdllN6xvsPoHZsFuSLJae8TyeNMpcxAGs/j
	 4Ct2/vD2mxQglcsG/x1NG25WsFAO6b77BPWJPClrI5lMlfHRoXcWSJ4jowxi1trs1SjH8
	 zL3XLZwcxvdyJqkMnh6JRH54UH9vtZPhtNgW1D4v2OTK3inGgg1CKi4kIFI44swXAqJ4P
	 vanGTOYpO0HBwR19ix+Q3xhU4aM6rd2uS8tdRlcAQkABwZN7+/cc9elZoVJ/NgydRQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ppwVAXSK;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B77606A325
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0B77606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ppwVAXSK
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMOsau1439438;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VY6KzzE6OjMcyrI35J+o3RPnfsmVqnisSTdzPt8kf5k=; b=ppwVAXSKH2ss7+dO
	16KI4jGcyq1mkHvSjy/c9FBJsbxiZszpZTcw8qvus6DJEepxtjVaM9csVTgoiFgc
	Z0sxAfF6V5HJBkeXK7gA1Kv8coid1saGcs4hPOl8izu97dC9VMoXwUCk9yzDxivS
	xjWgiTG0+Yk9VcO+i7nVNmrCIk1ypvHSyFO2OOImLC28vxY0jEkdwGgKFGXujyOl
	IJuQRVy8yL5TwQ4KvxrgyuWXiJNjpO5Gof3Bmd5ZaHIdGkZSXRUVz3yJx5R6lggQ
	zmdEgMsEAjWE8IUr6XDuMuVuh4Y+esy5PMGmN9kFL3PqlQvIxIQdzGCjOPukk0sR
	3nYykA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q2qnv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN4dqm257755;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 69QN61gV259903
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 1074D25610; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 12/39] iio: proximity: isl29501: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:30 -0700
Message-ID: <20261026-iio-v1-12-8b136778eedf@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.17-dev
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX9rt9AaQKc8ov
 gg9q4FCojFl/MwSM9Fq+poHz/tBJVcgrMwr97mDFpfWPzj7z/SG1EAqz0KzM7AALLMZtfgWKJzC
 jZw2LaNYDCVcQqZtxfAmmgRXXjlGoRA=
X-Proofpoint-ORIG-GUID: m7Mneb3W41J-rrECvXJ2Pppszol_pSwS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX9YfS//TDu1Pb
 0Qobm+9RTLga6xyidjQIc5p0NpBeOLU+BAdh3rumH5HTo4Cbu1s5MJWHXz4CDVgHY7hlzkFRGNJ
 sgVZeETw5Q+quc+pwlAuW/cjxtLi8QRAJETOGo8KpPzBEnJ/iEXe60GuQzvdGOZid2m79hO6UDP
 M5DW7NEc42M6uWqO8zWrMjXB1prrEdlG2bW1bMEQFZkYgPhcfSnMTuO9zJ5cc1smVtRc99sU8t2
 aRa8DDmdZwxbgzQtvHKv/Bf+anT2kdlbT9mVzT5ZDPufjNcSqKrpVqJlY/suy9HA3J3irKLJqbw
 X32UY+CbzurXD+OvAoQmTCUiSsFbfkJ8oy7NYYi0iSrcC83LS4KAICGluHE3g+qmCPOto2UmTMk
 u09CzKc56MC3dYhjzsDYMd13H06knb319lIcKopOeF9wol/4hBhstI6PSXx8kq/JF1E+8aP4AnD
 9tEiuMYChuA4WaXQ6pw==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=br7g5hiCn6DhSbfPKA0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: m7Mneb3W41J-rrECvXJ2Pppszol_pSwS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/proximity/isl29501.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index a98a9975323c..149bd57bfdf0 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -948,7 +948,8 @@ static irqreturn_t isl29501_trigger_handler(int irq, void *p)
 		scan.data = value;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

-- 
2.43.0

