Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055970;
	b=aITsMalv7sgVDckK8Lw8s/IfOwcK19HpxQm/I1y9EZhusiY/kjEWRcStwAus4O2un6mj
	 1YbcgcFbvWtXTW7LLz7JU0M9Pbvzein//msyV2fDpNK+/5xeBel36tigCYZChpSmS37r6
	 QRRknUdY5gyhWJhK3v0oBd7ExojmGhq+sL4cQTCIU5a4fCP0EqyOaBBQauXVANxLB7gBn
	 27aHPkXmunodZP8qE9B5jzkEaKDXzgcr4CGN5ezJLFWvwkzAalgWKwZ0ndIHxfVdokrbt
	 oGGO/ZE9FmSk/If6q6BWkuT+5290x9BkRKFlP8I1iGc968e9hd914jJMm+LPqgSyICw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055970;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sPPsoRlOBXc5WIjoiR1Qgqe+CYTLtddzJMcTD0MJbnY=;
	b=oqED2+2Fr0ZPPVfj4CLq6vDOk6xe3vaCo9JDMaWs1hQXGC1voTcRjUWpnaTY9YQvDxYf
	 OzYVrLuyGksDOabCQ5VR/0JA8GYKY6sTDZP7RwhWwvkjebEZxjtbqW+unL3unYnA45ioi
	 wtmax4TIAy18YwBKRMMaBMPQikp+2blB/sono++gSiipebp/5QX3cgXBnQT/GI2MFJxdY
	 2vWNxjm3+Kps5nvkRapY0dFbe9+cnXUkZL9fVR/CG6gdu9DYTFSJ7Y+uIf9wIeQw+Ixou
	 RUaMmE1wKCiy1zFWbfnto5ZyVlvul1ElSFY+O9ijmZ+3WUBNfjKLO2T9C36ou+UlwrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ie4bPf9n;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB56606A333
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAB56606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ie4bPf9n
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP3Pw3507392;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sPPsoRlOBXc5WIjoiR1Qgqe+CYTLtddzJMcTD0MJbnY=; b=ie4bPf9nL01uhot4
	L5cmnUYTW5JeaBYYhs0nkND9qyjamD0tfZwnopRm09ItPu/Dp6cL2IEgRo71iI8q
	eh3L0j6WpMBGFHsMIQD0QRdem6t6uKd+Inm7/M988RiEOxx3GXxwiApU04Q0oTiz
	HBNbenZw3TD8D2f+kna7dYOG/Vx3eJw8zEWAyLk6KejBMSbBNU9LtwlZrgGjr0CW
	ZWkqkuqbObGCHgbuLKMUnnrVKcwMcJeQfVjzqddOQL671XiM5gYu3HlnExsB49ph
	qs81xG8BY+33rkHxpEwBwLKSiVncTixTUcQfgBCj+j3DfAdR7DcmfnlBvuIPSUSq
	bVywKg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj8smstt4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN3qWd182978;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69QN61Xq186529
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 6A429255CE; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 27/39] iio: humidity: hdc100x: use iio_push_to_buffers_with_ts() with a scan struct on stack
Date: Mon, 26 Oct 2026 16:05:45 -0700
Message-ID: <20261026-iio-v1-27-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: jDzqVc2bLM27Oy83oWtSZBDWqmHYMWrn
X-Authority-Analysis: v=2.4 cv=Sfti5fRu c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=M3EtHqHC_n01WGBVGm8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jDzqVc2bLM27Oy83oWtSZBDWqmHYMWrn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX+1SUEaotnBd+
 dulK9UGLUpVxsf1HSw0TxOx/y7aJ7Pt6AAEJZ5C2Liw6NL7UFjjdNmsPHQQWWJYsNb1qvcdsw84
 /WBve+nuRSY13lVaV0e8izM+fWt4ytE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX/cbZ8i3TuWD+
 xGykIrCV7025w0Jn8oh3OfZEqllnFNFKfvWNqxh5NpTI+e/LYf7eBkMGXRqkkzjqKA+Vmdih6SS
 Tpg5++1vr6LvjsI6IjRvI1unJtuH8nR7Q43SnPOgtCqVYv3YuYLUBe8SKgBk4CnwhkKxXz5ayAS
 iDLfm5pOGdDc+tjX0ByXaXztGDo2AJFfFHzdhg5rlU47adVkrtoFD4zM8RUshwq6OrDP1nkuOcc
 2CItv4Kay6Q/fLXaQjWBhFMh0ZUPV3mkfOvqGFgLuEWwPrYztSBF6Ez65ObkxX+2i1ctINQ0hpt
 T8apsiShktAiAI6tyefNm3raJpFJM6EKFS7RkBF77p7YUFPFXjA1/kSL9cmjHomhtoCJBOKQ4uZ
 nqhhgnGp8CtyfxOtVtUGN1YQ2rIWO/wJo1IAhmkZi1EWPdXhgx6H/DsKeIuz0jDggAR0dh3v1Dj
 cP0JkNiquLbsarReAig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Move the scan buffer out of struct hdc100x_data and make it local to
hdc100x_trigger_handler(), as it has no need to persist between calls.
i2c_master_recv() does not require a DMA safe buffer, so this is fine
on the stack.

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/humidity/hdc100x.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 9f07101d37f7..e045d340e18d 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -41,11 +41,6 @@ struct hdc100x_data {
 
 	/* integration time of the sensor */
 	int adc_int_us[2];
-	/* Ensure natural alignment of timestamp */
-	struct {
-		__be16 channels[2];
-		aligned_s64 ts;
-	} scan;
 };
 
 /* integration time in us */
@@ -302,6 +297,10 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
 	struct hdc100x_data *data = iio_priv(indio_dev);
 	struct i2c_client *client = data->client;
 	int delay = data->adc_int_us[0] + data->adc_int_us[1] + 2*USEC_PER_MSEC;
+	struct {
+		__be16 channels[2];
+		aligned_s64 ts;
+	} scan = { };
 	int ret;
 
 	/* dual read starts at temp register */
@@ -313,14 +312,14 @@ static irqreturn_t hdc100x_trigger_handler(int irq, void *p)
 	}
 	usleep_range(delay, delay + 1000);
 
-	ret = i2c_master_recv(client, (u8 *)data->scan.channels, 4);
+	ret = i2c_master_recv(client, (u8 *)scan.channels, 4);
 	if (ret < 0) {
 		dev_err(&client->dev, "cannot read sensor data\n");
 		goto err;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    iio_get_time_ns(indio_dev));
 err:
 	mutex_unlock(&data->lock);
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0

