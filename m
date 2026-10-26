Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055989;
	b=NLohcBiBgsyJ0tic/NcFmN8FcjwtVKQM0lkdTPwFMPab4QkK4QM/jCSYTmwIuPOZ2zVA
	 ItwVNdb0GqLpbo3me7V5ttjDmxET1W6shz41w4mMQ1u6kqymgP014wwGaNnBCqWcZ1dmh
	 PaGLz+7m1gNlktbj2FA0nUQB0TjqTBnQZlKmnMQdHOT5H7a2QfhQzXz1enUNozBgH9SWD
	 Vy8N6nt0+l3Ks5a0FOgd9bGR3aBG27FI0qEg8BaHAc4x0ENrTK93UgRe255rxogJkJ81b
	 U+JLFC5JA8V22fe+RN5guvyKTkl4BomL5+JCtu0FzVEvOL5XYXm9BLrPoMflH5SKECg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055989;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dygM9PUD0zxDAniBDNfPbDEISwD2rM3fhl4FA6hdWpU=;
	b=xg7Pk1+6tuqk6/Pb6h9/n5/4Js5oJzim5FWSOIBsuEZRAjIMBYHt05wREE3xLf1+ENo/
	 TMSOXzpamG4TDPU6MSPJMobt5EcgjUAIWKWeO90OP7EF2icI7T8wU+7S4rPJkXt5jRdlJ
	 VQrZZlnlLDb6fgUxdqJ6/dPfSmvRlxKAv1sPUGY9dKuQ7cNioyaNH4WfIw0o0OCpqsKrG
	 4NV7AevEDLY95UdalbLy51gKQQ4xB9ey8hea9ohgDN0EcgWAUTyZGi592nAC3uhnSqsig
	 yp1VRbPdDdwdGjbBU83jb8SVkk/8ypqyOpc2qBxs05onugGLWkdQqDtb+x8l3HcxLmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="h/LnHIaJ";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07514606A31D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07514606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h/LnHIaJ
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP0IZ3041076;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dygM9PUD0zxDAniBDNfPbDEISwD2rM3fhl4FA6hdWpU=; b=h/LnHIaJBeJxMY3l
	1PtBt/ymL7E0/zSqfVk/sgKvlwIP/ZF3P8WHCNwvsT/iHvcjTGZxu7OcIpMpBGAY
	SbT1dzhpxFFpC3CwYlhziUuUhft6/MqSkOi0qWi3euB0EGBok4vmatljE9g+u/yV
	+HJv4N+FX3fWwk7DfEJ+FpFSddVGx9LqZ9K00bCnolmnV9cK3Pa3izFybCiS6mTp
	m7f+FgIGL8NV6X+PVv0WMRZCMUUgEurUMvKMgZm7OPunSO2pLHk0BQnznrv+oAVi
	ohfRNkrYs+CcDeyScCV7ZrHAuasp7xka2iM9xb1t4j9EQa+PmfHMWse2i3Q6dc6U
	N8VP3w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54h4hs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMwxMJ248305;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 69QN61Yt259922
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 465F924E4E; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 21/39] iio: adc: ad7766: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:39 -0700
Message-ID: <20261026-iio-v1-21-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX22Rb6PFDBYMr
 uaphdVL0EqhREmHmn2TbLGP3Z1CBG5Gj7Q+nqL2mWeJCx6URFSJAvxbx01nIm3AOcgYzhTzhL9i
 M5cOJ8sLuFb6r7Jlw6HQJM1rpgKdlKo=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=AzrxAvWi7S2D0iaz0PYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HJX-sidMVq7oG_kpgZ2cUzOPc7-3i_fy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXwSnG7fKf9g58
 OZnA4TPoRTuDHoC+/fADU36FEnoGnA/dVMI8DGfiCgzbLiDNgmjgF2D22jE6U3x6R+8aQpZ688v
 5nJrQ8a77HQxCiJjZ8X+Sye++5UwowtNkumHaDJtqgOhOBP5f5G4RkBt9Mps7ppaMgFMuRYQ6pd
 tmPrnWtH4hpJC/6FbNaWyAsPiSSbPNDK6r8PPbKwDbnfHwOSbm4KOn9bxv0293Vx/fdMehUagy4
 eg08AUuCyz81tS91R4QAc50unkY0ogLVHATp9fmOynlIbEypJKqE17DTpzn83UfaJdoV2MWEYSQ
 W0ToxfNCOmSsj+EVZfTPoCES/TxEI5ZFoJ2hQcg+sZbWacds0VMJ06CoCOjyxHEI5zUFoA6KYBW
 4/2302OmaI3JiWa4AJ910V7odt6k5qezS79S4VX4MK9yV8DiqOhp2Po+qNSqZWbCcRU19aJXvxy
 CdCd63bmGeSJFb2hD4A==
X-Proofpoint-GUID: HJX-sidMVq7oG_kpgZ2cUzOPc7-3i_fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts().

Replace the data buffer with one declared via
IIO_DECLARE_DMA_BUFFER_WITH_TS().

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ad7766.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 92957196de59..2afb466cf911 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -44,13 +44,7 @@ struct ad7766 {
 	struct spi_transfer xfer;
 	struct spi_message msg;
 
-	/*
-	 * DMA (thus cache coherency maintenance) may require the
-	 * transfer buffers to live in their own cache lines.
-	 * Make the buffer large enough for one 24 bit sample and one 64 bit
-	 * aligned 64 bit timestamp.
-	 */
-	unsigned char data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_DMA_MINALIGN);
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(s32, data, 1);
 };
 
 /*
@@ -74,8 +68,8 @@ static irqreturn_t ad7766_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, ad7766->data,
-		pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, ad7766->data,
+				    sizeof(ad7766->data), pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
@@ -269,7 +263,7 @@ static int ad7766_probe(struct spi_device *spi)
 	ad7766->spi = spi;
 
 	/* First byte always 0 */
-	ad7766->xfer.rx_buf = &ad7766->data[1];
+	ad7766->xfer.rx_buf = (u8 *)ad7766->data + 1;
 	ad7766->xfer.len = 3;
 
 	spi_message_init(&ad7766->msg);

-- 
2.43.0

