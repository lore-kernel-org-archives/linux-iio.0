Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055980;
	b=Bwu9J/fFcz1hhiCVDa26kxhrn1EctpOwx5JfpJEVwF5jzmw4N8ucg4jM2vGkGn4Sbwuc
	 HKOlN4lv4xI6JxKbjkeJ/Mks8xzcbpn3//Gs4pcUNS18hcHBvAKWMAJfudZb9CTYLmqBn
	 PtstcwaMseKxfWV89SDs+qaED0zLUiH4TeNF6QTCzpcYJiKhWBZBnwYpu7dGYSlgeMMgO
	 1Fla1Kt5KCHlBKBkJk5+ASfsL5Y0Q3gruQ6cH3fq+5vNuBiqHyECwkT+d27OQWHsGcJBQ
	 Erd+4QNzpwEAloxvaEUcrFNvEorNPXndeyzrQNaVoDGExsJu0KjMzQIGA/ieDM3a54Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055980;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=pPBVM+qlDuzY590juk/4pm7Y2O6HxUMCcOGvlE7Q3PQ=;
	b=MOPVIXf/qZp6vuUREinRuTIQOE2yCpxyYKiiUkLKodu4Ares/W3W5ylDHkev1UFOgHbU
	 8yaAZNvQTJMFPZ/XZTG/+twayh/G7SvtG9Etcqczy3XoLSSsGhskaUUJXvS+BnUzM1bOq
	 H07MBDLZS3V0pOa1GmLVfCGOv1pBPTmFHwrPdnA2bDyVRDRj+ExXqrfAIkkmOeql5dZPq
	 nDd2JSFznwOrwLBu0ix0ZXST2qoJV6umlGQPuHhKcL7XYaEp7B7TV5ZaMm0gLeiHayhO8
	 0RIgwDduNuSXDBN+6wMncjrkUlFiJfEKq5g0RUYtgxMhh/ULxuFU3TZlzqhtMIcfD1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LLzuxUXF;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C6606A330
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 794C6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LLzuxUXF
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMPGOj3507769;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pPBVM+qlDuzY590juk/4pm7Y2O6HxUMCcOGvlE7Q3PQ=; b=LLzuxUXFEIv8IKd5
	Ff6J+6D6DM72aG3yOFEbpgC4ZOF6FaYX+3oneRTvc4fXi8fHlxn5S9GTso0JH+LD
	uBPfU5lMHwABVqMxp3PZ6cSIEQLA0bYcYJJbfDLBlkSJDoRXBaVxXtwdidhhC/fy
	9CO2kcPsvwvmAXQGLQNI/AGKQAID+0cUN6ypDtKahbuD/amXYDj79qk1WCaSs2PG
	95lTEDbfy1c3VsmDHSO5cthHJVovLQUQdmO7ArclTLgb/79TnAfavkfHE/Ue7HXu
	KDaTB/5nEaVy6cAGnVhdKXTwLaE5GZXvQJ0pI0MQ9p9JHSKN7+n3cXbbQp0yCx4j
	yEDeGw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj8smstst-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61Le186496;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69QN60Gb186468
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:00 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id D0F7E255CD; Mon, 26 Oct 2026 16:06:00 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 04/39] iio: addac: ad74413r: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:22 -0700
Message-ID: <20261026-iio-v1-4-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: QmgIwWU1zOODA913ZBm1icJ-ubbvHbuq
X-Authority-Analysis: v=2.4 cv=Sfti5fRu c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=gAnH3GRIAAAA:8 a=1kyuwALfRLqFmt-N2EcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QmgIwWU1zOODA913ZBm1icJ-ubbvHbuq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX9aJPnhb8gGbQ
 l5KhX5b3aG/MHmDKVZ12aqRhglgWA2T3n78954CIhxDJfHBJtfSFNWCqQlXOS3PBGgbolre6wxm
 vVppdEtWzZlZg1M3NEA0OkbB2MltymU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX9+I1PzLwBMYz
 WuOz7i5B5imNKYbVqwK/p5XQT+NViVCurls+DS8ANPuDFM855uKStwvxKZH5Kjp5ClLaC41J2Id
 itbQpJIS8Iq9zZHtyYPDNYA8DtrNsAHRk07eItVzUnl252FcEhq3zqmHuGfCsPE9/OLs0BoY7hp
 7MuUjFq+KtRgak3V/rA49fvRLEATusshfgGm8JgbS2HdjLrKYJ4yuN/baCBhaf7O9lUTD44GlHB
 NvcHgTAmBEkAA37DGlmzLBwky3V6429k2W8fcsdQGHCGEyjKHWE1Kc05kYvZXOcPXGAKnc8u0Km
 f30baldZpaZySCMfXuVCWKhplD4zsMYIr4dN2qZOSaRc4bROcuYhKDYWZfSkQkINIqdSK0KTqFJ
 7E873Zc2XZkd0OndacvbSoH9GgjAkaGuhEcGcJ5t1dR+Smg9JZ/s+MxvvkGByDW67ngjCl8jaXF
 58nWtK8QhjG5WkpbsZg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/addac/ad74413r.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
index 2e5a58e48a89..8d9d3d5f09c6 100644
--- a/drivers/iio/addac/ad74413r.c
+++ b/drivers/iio/addac/ad74413r.c
@@ -798,8 +798,9 @@ static irqreturn_t ad74413r_trigger_handler(int irq, void *p)
 	for (i = 0; i < st->adc_active_channels; i++)
 		ad74413r_crc_check(st, &rx_buf[i * AD74413R_FRAME_SIZE]);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &st->adc_samples_buf,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &st->adc_samples_buf,
+				    sizeof(st->adc_samples_buf),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0

