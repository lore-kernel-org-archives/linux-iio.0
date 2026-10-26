Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055968;
	b=TZuOKb6JxYMs9DTk3nenhTMVvRfeN3Rx8Vr5e/UPta15BUPTCg3MNhtrPH0gjIJqpq1d
	 nD+3+11DpbrVtw6M08lAvZNsFhx8gb37QldGoEUHWX9RWC0uiDQOJTjivptmsilo+pbQc
	 7GxFIV5o6kjpr92nhe6iaojvZuuv0ew/fOGjz2bd7FTh42SB13vQC0G5o3UNSL9P7nK37
	 cXBvOvL0ONyR5Bu62iu259rIP8aUsxkAiQaWgXbjlhRvfbJ6C3YdCaa0gdzTqN84S0geb
	 yU2ljfbekQ17E/zOTco/Pp9mS0TRUYLxBovi8y6fxUqWif+72NJhdkt6x2i5ea5OmSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055968;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=dXiVAIx8d3zMSCiwokClFLGNyd1srloBWKwQzw2HFaU=;
	b=p5AKmZ+9lbLvP/cTUDZffLfO7jIMbmvF2rg8jQsU2QY4jZasbPKAC3UOyfqtQblP+soz
	 o0b/aqI0sriD4GOdilRAfFFLMt6tDg5xG1HeXlBMWDJXKKXaY3Z1uws1LSVyk4Ti1x/49
	 shGzft7DXtpcnic5hOm67TVAsMCy9sRXJ6r71m5xDt5e/xDSHXibR/+YKdtYUtSSRkI1W
	 m0oVwc8W4djyE2onqI18T6dp3gCxNTbXqEmvd7WCDUT7Lz9fwvLvdZtQPHVo5eJkntTGz
	 VqumcY2sA39fBVl6Hql9rmzA1RMRIXx/2PmLdP9yI9djv8hngOCTcTxi6YO1wyH9PBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NEDJQWTB;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D8606A31E
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 741D8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NEDJQWTB
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMOrom3670941;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dXiVAIx8d3zMSCiwokClFLGNyd1srloBWKwQzw2HFaU=; b=NEDJQWTBkHZ8v7kX
	rwPSnVC1ebbMqIK7eXW2veLQWLRxe2jF86Pq7ofQRIpaFbaH1OeIF2sEUpYrp1/o
	XS5mQl/9tTf6FfKIOZxmOJ1KXAwigrcq4nAZDq7gOMjzAgipymikAPvKvstKPDzc
	NHt4NAlC2/nO7FgdPQ9HiVzLvRaTGPL81SZGcyu2OpcLHe5DHkHuPPXHY2/x21c3
	bz1M9/yDBYOU1StP8zjZsCuYtxYvPcP0QnN7iEfhpg/lWW5rZ4sOICSND9/KMpTg
	K1AZ6MJDmsYxX6c+bgvLMvGR7R93IdqWsFFppsaYHCnAG5W7dkxdEcOxqbQY7KhL
	WiSPxg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u632e5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61AZ120350;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69QN61FX120295
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 7020F255F8; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 28/39] iio: imu: bmi323: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:46 -0700
Message-ID: <20261026-iio-v1-28-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-GUID: WOZJ_ZyZ8gvDM1EoiHMoDfblr7PU5vle
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX+xoA9LF6jY/O
 2MqEPhH4w/6kKErihWK2A/PxgBXTKF17rkhsNXRSZhUA183eCJgKnAYUHGCEv3l0XeNLHa+zeV/
 09I56clWgszWbfqDAOLkCWfE/EfO4iXR5gWos91KHgLCtW4XSqkgEs1mxl6dgNz+m9wuDuT/dZ1
 +KscGPwKFapCB3Z+qE0D9qJJ3+QK4tPGvTmFqnJf060Dor14iWO70yVp21cHXIlRV1ipWfljiRI
 1Guzl13ZOZCf4PPKe8CoRM8bDpbmhbFOfg7gwb23g/CgcT5RXdWgZ5EUKKeRbBjN4VsNTzhpkDb
 vBq3I/IF8n6A78aUAR/fckjYt59llZnKrXu+/rvpFZoocslXqc4RkJlAuRJWox7Vq8/Am1ZA8/A
 KmMUkMaTReZQAkJasbSbeU5nWx/Hgd93uFEsv2aMM2Y8QdOF1dbmtbV2LZV9otI54Fn2LVrs0RQ
 5i2+XQay5cwpkkfCnZA==
X-Proofpoint-ORIG-GUID: WOZJ_ZyZ8gvDM1EoiHMoDfblr7PU5vle
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=p5xFLQ10mAflgHaEcH4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXwq9KYzp/dRM/
 GQ9nAQDnev+dCCCpPvvERvbvMQGZfMGR8kieLY10r5zr9t7YshqcsSIwXbBi71oS0ua8BMOKGgr
 HPgUYL3p3sahqxw9vGhP9Y5JZMHcwuo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Also replace the two for_each_set_bit() loops over
indio_dev->active_scan_mask with the equivalent
iio_for_each_active_channel() helper and remove local variable
that did not help readability.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index ebeb1b10c38c..f1baf7304533 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -1069,7 +1069,7 @@ static int __bmi323_fifo_flush(struct iio_dev *indio_dev)
 {
 	struct bmi323_data *data = iio_priv(indio_dev);
 	int i, ret, fifo_lvl, frame_count, bit, index;
-	__le16 *frame, *pchannels;
+	__le16 *frame;
 	u64 sample_period;
 	s64 tstamp;
 
@@ -1108,15 +1108,13 @@ static int __bmi323_fifo_flush(struct iio_dev *indio_dev)
 
 	for (i = 0; i < frame_count; i++) {
 		frame = &data->fifo_buff[i * BMI323_FIFO_FRAME_LENGTH];
-		pchannels = &data->buffer.channels[0];
 
 		index = 0;
-		for_each_set_bit(bit, indio_dev->active_scan_mask,
-				 BMI323_CHAN_MAX)
-			pchannels[index++] = frame[bit];
+		iio_for_each_active_channel(indio_dev, bit)
+			data->buffer.channels[index++] = frame[bit];
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-						   tstamp);
+		iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
+					    sizeof(data->buffer), tstamp);
 
 		tstamp += sample_period;
 	}
@@ -1425,8 +1423,7 @@ static irqreturn_t bmi323_trigger_handler(int irq, void *p)
 		if (ret)
 			goto out;
 	} else {
-		for_each_set_bit(bit, indio_dev->active_scan_mask,
-				 BMI323_CHAN_MAX) {
+		iio_for_each_active_channel(indio_dev, bit) {
 			ret = regmap_raw_read(data->regmap,
 					      BMI323_ACCEL_X_REG + bit,
 					      &data->buffer.channels[index++],
@@ -1436,8 +1433,9 @@ static irqreturn_t bmi323_trigger_handler(int irq, void *p)
 		}
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
+				    sizeof(data->buffer),
+				    iio_get_time_ns(indio_dev));
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0

