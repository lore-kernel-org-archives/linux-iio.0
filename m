Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055968;
	b=juJjslK+QQWiyIgEaiestHeFWaMeVz3ceSxCTJrn+tPLLAuNnKJobEfoB7CwsgxVFbHr
	 6WDfUYNyPcowln4My+hQ5rJqYHjIKMloCy8bjA47WYHKFjTMMFE8SPdg6ycCjmEinfzr8
	 /czaG0W8kw7IDPkpvmsg1VdTYmIjFAxV4J9v88TsSOm5B1uNGNyMp8vUYO2YiLXwVPaYv
	 og7qnfoCIIobHkcqrP5z7He3UGhgXXrM4lIwLTfwAf/Cp3Z4r2DXcnvoyzMjPy9XjfIZY
	 xYTdHmimlUPGeiEsYmdR+P+kqm0eoaUR3JrphtTRmIHg88iXf91H0Hui76p86hgBuzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055968;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=AAVCsLw3MmAI7y4i8K/VLBQscm3ZhKviDefLvy0wp+w=;
	b=j4iN2R9ztMbz+E6WmoZ3THstox7HCHc/dxaso4eyMIlo+hMXsP8fTTqy9dbECbiRZuA2
	 UN/Qvc72kh3QPFFuTef74ZJtQSMek3oXWjciqSRPqGDUW0SRW90hg1y/U1xx4LLERNfLw
	 bSWFuuE9dV6d6bcPNoIqU8uMlLjkglkvPSr+8sHAosyc4fEypt+Q+2iGqMWv2AtPgDc5e
	 zUHspZs9Z4sE1Qc9Lk3V8EX/XpdM/mNwoauPrqi1knGKrNZDKOt0CJ4DglJbWWyFU7ejN
	 j6pi6/ox10QAFECN9p37ZDFjmSZ4jraKcgLwU03P8o9BvgEkTOON8Ib+sJGble3JN2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E7PPOl9o;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E86606A31D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02E86606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E7PPOl9o
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP1ZH1430936;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AAVCsLw3MmAI7y4i8K/VLBQscm3ZhKviDefLvy0wp+w=; b=E7PPOl9oU27MVuiN
	ONm//YVOP5XdhuajeCIIKEqD4Hgw9SFA0WPAvgthFCAeTC5k8qrBl6/D+wpYpXLB
	dTMgtxmS9HmF7077iHh2aJeegjfLy1ZQLB6MJA3EHqm8yHsI3kEQLidbUCKzp2yh
	r4t1t+9QwkLR0/p5vUzCUfid7Pg5++0AKlYm72vqoPbW1stkM5A5awTfbFSynBkI
	zYU7SDXHv0NSAuhjGISvaoOtORUrVar3fwX7jq9hcRVZBGkwN5F8aDMoJiiAwZhl
	q7T8s6DJZaRCS+jDR0rW7e0/QY2lYb4hUaV2raxYQEacfc9nonEuEuRgAIFKakLV
	UjnRxQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3d8d1t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61Mj120294;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69QN61eI120307
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 86A482560C; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 32/39] iio: adc: ad7887: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:50 -0700
Message-ID: <20261026-iio-v1-32-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXzRDhOCwwZL3J
 LQRrrnNBKQVbXWkgj0mK9nHvmesOVs5JF3l1f4hgNHrknHEInTQouBRhe98uJrnZiVOKk3wAXuq
 Bedrvx0elDUQ92dx8g976GbqjaS6Kpw=
X-Proofpoint-GUID: mhoiVhmyApdZzUMC58rgFIfMDg8ltk23
X-Proofpoint-ORIG-GUID: mhoiVhmyApdZzUMC58rgFIfMDg8ltk23
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXwCScOimDHPEv
 3+sM6Q4abiCzIA9YP8/702qG9UGpwPJkgQVB7SrE6VmU1tnDZCvLiVbbErDHvUWAnYm+dzucHbi
 Dz3goX4FRTwkGTiHfjrnbjbDpTdDxDWIC7t+y9sGVpiJQNjYQqj44yPXKmXT4pgwamDubWn7EHF
 BdkxEm/X3Sx1Vjo0mdq7UbQZlfMH7pN7RjETj0BqIgwqfw2U7TbaLXBlVwUo02z7pcgRoZ0g4Kb
 Qtb4TW4h0mt2HzlMBJxM+cVvMGtvQ6kki/cz6EqziSWHsMebrsnSFZir+VQiKbJLFvZjHsep7nJ
 eJ+MsBt/Vy/L4peIILxKQ08VftBSGZ3/kk4nf6/sDXSYyNEUcooZ+xILguWq3tUKlxDN6RuW9wg
 RO6q/u/mNcpyWI8Spbb6jKUQKxwJfRwN57lGk21ncJ2ahmglibiJL5sXPvRrW5zkpWTbcSKTU+C
 8zSVIfGjX75fSZy6h4Q==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=mW4h0FjkUepxFMAkcQkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
which is a structure within the iio_priv() data.

Replace the data buffer with one declared via
IIO_DECLARE_DMA_BUFFER_WITH_TS(), for 2 __be16 channels.

Use be16_to_cpu() to replace the opencoded equivalent.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Note that the LLM I ran over this patch is unhappy with the data
placement in the pdata path in here.

I have little idea how this is supposed to work and obviously don't
really care about pdata.  Would be good if someone who has a device
could take a look at this and clean it up in general.

Otherwise I might just rip out the pdata path in the near future.
This patch being an example of how it is causing maintenance burden.
---
 drivers/iio/adc/ad7887.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index b1d9da19e7a2..dd1464add06a 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -65,13 +65,7 @@ struct ad7887_state {
 	struct spi_message		*ring_msg;
 	unsigned char			tx_cmd_buf[4] __aligned(IIO_DMA_MINALIGN);
 
-	/*
-	 * DMA (thus cache coherency maintenance) may require the
-	 * transfer buffers to live in their own cache lines.
-	 * Buffer needs to be large enough to hold two 16 bit samples and a
-	 * 64 bit aligned 64 bit timestamp.
-	 */
-	unsigned char data[ALIGN(4, sizeof(s64)) + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, data, 2);
 };
 
 enum ad7887_supported_device_ids {
@@ -119,8 +113,8 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
 	if (b_sent)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
-		iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, st->data, sizeof(st->data),
+				    iio_get_time_ns(indio_dev));
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 
@@ -138,7 +132,7 @@ static int ad7887_scan_direct(struct ad7887_state *st, unsigned ch)
 	if (ret)
 		return ret;
 
-	return (st->data[(ch * 2)] << 8) | st->data[(ch * 2) + 1];
+	return be16_to_cpu(st->data[ch]);
 }
 
 static int ad7887_read_raw(struct iio_dev *indio_dev,
@@ -296,7 +290,7 @@ static int ad7887_probe(struct spi_device *spi)
 		st->xfer[1].tx_buf = &st->tx_cmd_buf[2];
 		st->xfer[1].len = 2;
 
-		st->xfer[2].rx_buf = &st->data[2];
+		st->xfer[2].rx_buf = &st->data[1];
 		st->xfer[2].tx_buf = &st->tx_cmd_buf[0];
 		st->xfer[2].len = 2;
 
@@ -304,7 +298,7 @@ static int ad7887_probe(struct spi_device *spi)
 		spi_message_add_tail(&st->xfer[1], &st->msg[AD7887_CH0_CH1]);
 		spi_message_add_tail(&st->xfer[2], &st->msg[AD7887_CH0_CH1]);
 
-		st->xfer[3].rx_buf = &st->data[2];
+		st->xfer[3].rx_buf = &st->data[1];
 		st->xfer[3].tx_buf = &st->tx_cmd_buf[2];
 		st->xfer[3].len = 2;
 

-- 
2.43.0

