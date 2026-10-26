Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055969;
	b=Dk8K7iSfsTtJpNHumPjXGIOjuz4rxZB8IkLNXrKJIzFi1SF61fY5qAPBgFLMtwuiI/bm
	 BoAbzM5pGu646bJCM01X82+E4ohU3FfBpxWhXyNqGuVks8ifhu7EkZn7ei7YI907BXPyX
	 sT1ipsaASwdPubdjYd4ZrDVYClPPxLFYMP0TINM+ZPvIpRVECdl9I5cOxsGTOMy2tC20m
	 zjyc406oHpEwgDkA8WibFMrRrKZ3JR3Vjfp7gIFqW9KRrIJybz6TkkJkVEw4hVWJHQjhM
	 3EW4K687sKwZZVYsKaWuuupNBoDBNlmnw773owx9KINg94qL+tvPsahARCM9WBMMqxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055969;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rMbHO9l8OElTqX/9WA3sXNPmV4c2pHJZo6EsDqqdp2M=;
	b=O++xMhqUERoL6HlHhaW42JcXrg7F9oGv1NgpTqrAv6jq6fOMwi6dB/LndUU1SVjcwm/K
	 WQJQluO5ZHjU+aXzUTT+137P9/DAAziGpGBSJ5AxHbfWkQysQe28rGHyl1kScEDr4fGX6
	 0u0YGucbFvr6+ankV6C77pAI8EMdJADemR+qjCmO+2sd7bbyJ/8Io6F2N/bflRZiKteJC
	 oTiRHZfqPO1BpvSZCgRqiA1toJs5lYYNuwb5nSvmd1D138NWE8UYUG4HVgr4eRsSNoL4B
	 DjJBAr3ikSst3kC6X1eZlIafEaT8oUmr//3FU1KVw0J/1e8FrnMaE9UvCtslUG8gPWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XIXyNdkO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D974606A323
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D974606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XIXyNdkO
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP1Jr3041669;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rMbHO9l8OElTqX/9WA3sXNPmV4c2pHJZo6EsDqqdp2M=; b=XIXyNdkOG4w2ggQo
	wSIA+MFNkJdUALoh3mD0wy9+zc6mnHylbgA6x2X/XtPg9ToCSCXqTHMfX6Cz/dde
	mi6AuiKa8jIW9+iNGeXrcWvL53QD2GM/Se9cdSn2xUsO7kh973IsfgCWTBEtM6ZD
	FLexs6yDP4e4TUgQ82+LUPr5L3OP1cMtHt36jP+J4DH8Zq1f+kFT3UnGyH6hP1wH
	aL7ojTKmN5texoSC1sm90rnRA/bRrxeAhzqOBuqkeXB9xtOeXCBbBFfRBW6F3CZA
	Z5kS1xd84E/OUc1gpqbNEe0PVybe04vzQVBwKSRWnYqbV4OC7/TMREEoOS+CQVi4
	Nb3k1g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54h4hr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61Lf186496;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69QN61bn186544
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 97BD725631; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 35/39] iio: accel: bmc150-accel-core: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:53 -0700
Message-ID: <20261026-iio-v1-35-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX5CoaQ/nhH5Gs
 bXc64vl3GShXrXvWVcidJJbCi38eT5D+OyOuZewdldU2lqI3g0Z7FhgtWEOnQZRghYUJ5gJrEsT
 L0tBQ+hhKn1125qXs9cL35k7n7NOjjw=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=9OSMqBJburOX_2N02iYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 4gHJB43rXkKSDgcYLjzn1D4nDbpAQbz-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXwdSJ5KEY0GMR
 /q6m4lNNoi4KBV0DqGJpGIw+B9+fMpkaWT3YJXVCnSeknwTHRdxDat0dWuLYSdUvwFFCu6DxbUX
 1h9x6SUdz95ZfRaV/9vQ247HXP3LiBYyUFzOkFYeMcz92i3CgWhIlBA7dncauDoTz3KzKAYoNY5
 hRIc2IWY/Mh6JqFkec/aO/ZvjCuZcsWyrWApBhNAwMiPqmlzt9YS8BLx3SH3zjLralwZFuiYfe+
 UAdTz5oTfj9b5u7NF+L0itmoqaKIdDPEPU49HNxY8VZtrNvL6F4s2EzkhBisNJEgdYwqFJy4Oqx
 t1uTbveiaVfYEoFOphRvAW4p0yFebyoqm6+57vMieC1AIOJ0Lw4sh+6dChHussq6uAUwik1wU5g
 7M9jtN5NvCSYaw3q3vwM6o45f2Xr1eX8RPlyDXXYzmVU8ycxCQj8LNc1keaKXNvSAwBGDmqGIG7
 leWTxO6lThE+43uXHUg==
X-Proofpoint-GUID: 4gHJB43rXkKSDgcYLjzn1D4nDbpAQbz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
at both call sites.

The triggered buffer handler read into a separate fixed buffer rather
than the scan buffer used for the FIFO path. Use the scan buffer
directly and drop the now unused buffer field. This also corrects the
type of the read destination to __le16 to match the scan buffer's
channels array. Widen the mutex-held region to cover the use of scan.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 12 ++++++------
 drivers/iio/accel/bmc150-accel.h      |  1 -
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 46bb36d9366e..4aa282183604 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1013,8 +1013,8 @@ static int __bmc150_accel_fifo_flush(struct iio_dev *indio_dev,
 			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
 			       sizeof(data->scan.channels[0]));
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-						   tstamp);
+		iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+					    sizeof(data->scan), tstamp);
 
 		tstamp += sample_period;
 	}
@@ -1193,14 +1193,14 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->mutex);
 	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
-			       data->buffer, AXIS_MAX * 2);
-	mutex_unlock(&data->mutex);
+			       data->scan.channels, AXIS_MAX * 2);
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan,
+				    sizeof(data->scan), pf->timestamp);
 err_read:
+	mutex_unlock(&data->mutex);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index e8f26198359f..853709c0f46b 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -64,7 +64,6 @@ struct bmc150_accel_data {
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
 	struct mutex mutex;
 	u8 fifo_mode, watermark;
-	s16 buffer[8];
 	/*
 	 * Ensure there is sufficient space and correct alignment for
 	 * the timestamp if enabled

-- 
2.43.0

