Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055969;
	b=PG5/xt5nMwyow9g+jjwAfm8PhcBZfww1ND46knUxSh1eJsxSvA3O9GpkHT3ElxSb5o3l
	 LTAOB9dYoXKGFCnjxcNd204j7QNl2CMuLCPdJru7dsPUNy/xwBUKJvvbsZGrHG4FTTgJE
	 R2D6mlm/+m3tQdxcCkbAl/Q43cVVpIJmV36PmUdSbHIzmrij7PGObzkN3Utn38rizNeQD
	 g+7pHTA/EWgDhdBNPEsO+dK1RHNUays9V75qHFhrcZAdOS/u4irpsIUpm5/rUX377mjwW
	 Ngc+vefTJhR4siyZVTD9r8tpEedbb8i9+VgGq04xIuCGXMAW67LavpfIDQy5enLzjKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055969;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dZ1dWJrsqu//OtIsFkGCtLy5C7gn14HlDL3ZHRwXdxk=;
	b=ce+EfvkdWEG8RhtBLN2ArRU32bE1cKJVYy3aL8PpMbAEwxqzUutBo9LDnEaXV10+JFuC
	 e+aUVGhbTW9HcZxSc+OFAFXy89+azxAt6eWFljdPZkCnvhpt0YjmhTeD3jfvB1YT2whyT
	 HBTUHi43bdK5S0U8i6tWez0Ct4tP6mSCm/QhPsTbFK5rA4iOfL2lz03f7j66pamz9p+NB
	 Nf3bRSAdzTQv0+mroXlp6RJyRp09FB7nkFJoFE7XfKZIYUEDExgdmcNYclE6qALS0Qfqd
	 XUtIwDrTTg1imr/aig2xRMLU3cUZq+UyEICqcAvnHnZXJynYSHDZh02OH2JcaG/xfvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tv30Ivcq;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A9606A320
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 176A9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tv30Ivcq
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMPIK5940551;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dZ1dWJrsqu//OtIsFkGCtLy5C7gn14HlDL3ZHRwXdxk=; b=Tv30IvcqbbTIMszI
	SxYmyv+vZVsENF/irnbYmuDaDDe0Ou2TmzErYmchJ/MX/yXDQHFGQkfN7GwBTvgg
	XGpCHCybDNvbUINRpniF2yXxRIBt81joueVaU7Z0uW5CbP4WAozuky66HYWFhn7p
	3dhgqG6Pnhu8+TCNCvVcDGqdeLtX0ytaLDKiiLCLm+YB2hxoWwBxqwX197I57RgT
	g4RAoKI2wd7hGSTEUSS+SW7goHd877c/qteRvCCg4DUr0/BUAXCIJRcMUzsuXJ3a
	gQU48xEpG1VrHFnJdqrpfn/c8Kd9Sgdz0CGFvoaq6dBz8AkzBmIlmAkaFAD4IjNu
	BMbKSg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf2ttu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61Vd120242;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69QN608t120226
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:00 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id C1666219EE; Mon, 26 Oct 2026 16:06:00 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH 01/39] iio: adc: ti-adc161s626: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:19 -0700
Message-ID: <20261026-iio-v1-1-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX1GEbdGGcHyfP
 dH04qJUIZhwzvarYBnvUMqjVytLePcg7ztkLFSJxbwUww4Pfp1tJWsdjWTOtLf6EWGlNFwwnOOr
 S+jXxK84m6Jgkb+iIFgtD844vyAGBrw=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=DKvQkcLmhnz0kzUEbEsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AeABXSFC6kmYEhwby15umPrZQbh5eAqN
X-Proofpoint-ORIG-GUID: AeABXSFC6kmYEhwby15umPrZQbh5eAqN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX/89OgEcn5fOs
 oyRVKOvtGjJKHyDasHu1FGub33BaXtEEfNU/sv3Ar5quFj0yHrg2J6Z0pLTB6iFdNnIeg+kvY+F
 VPXFmjZqqDKDb71crTKBwAxIfmyJYg56/S7Y6c90iMoIwcN/c0hMGOMC9fhR3igSpyKoXIXu2oO
 mimTNUXbIbHgbaqj4J5HfvyHZ72Ql07d3rhO+FDa7xuR3De5dRW02NG1zK/xvDFMELClyxYMmTL
 lmvhS7h4Gev8JxlsPSr5lYGf9cM6JUPPJNtcoddKv14JHJqhrxrp59rA26e9M/N5IcC9O2cp2KN
 1yemB70jfKbo2tYSUgQdsKsagmtRaekDU6S3FJy+8SdvaYboJqpxKgz6YecBH3fyfeSFtZuugJw
 Z6+dK1TDZBIklK5wRdhfDqBAFkgVlrpixye5pVUduDbFi8hLvM2roK2UKLM8F0o2GG/QKZL4BbT
 SMvZdoQHMb9rAkISj3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
which is on the stack and local to ti_adc_trigger_handler().

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc:  Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/adc/ti-adc161s626.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 422df0685580..a0ebe90cff3c 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -118,7 +118,8 @@ static irqreturn_t ti_adc_trigger_handler(int irq, void *private)
 		goto exit_notify_done;
 
 	scan.data = val;
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 
  exit_notify_done:
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0

