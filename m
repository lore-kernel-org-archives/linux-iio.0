Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055998;
	b=sNlPmo4AispNDLrHWzzzf631t4y8xP3Aonri8Wp67VRqgCMnGPUdAmYmCwilfwYhp8lc
	 gE38dzchMD7BjRrshmsD58xqnbQoknQ+BR7f+FUm06xU34NCUyPEGsg4n7YTn9i69Y+tv
	 mNJXlK4vvLh9ypUtjro4EUZQ6YyeWGmyLm2Wac7AI1fJquEv7T42DwH6LoYtfb0RSptt8
	 Woems1oBiLeGyNEeMI//IrB0i3Q7b0x4atDF6WFCW21yx3syodUasGjeWVY0RtTjPjcwF
	 rAaSv3mmW6obhICICzPz/eFtWi1/byS4dZ+AcPLmuDaZiF13EZMq694FM9KGSVK72xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055998;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=cc8eYrZKPIltwbggArKFfJlHq4j6nfNvKSt51pU3dxE=;
	b=c04ntOgqk7iTFNaOFnIBHwZW/eavsQRIHzmTumfpSfkgtmQ6CCF5mMCVn7lgssqMRjJl
	 wrhuLbc4Ub358ko+hvUQZu2JWzoAezVeTz8X+fRbM0a37enYgNEYybcWb0riWdIj2tojg
	 tWvetfhSPavf1JPW9osyGkUMyO/wpFVHbCI10zWVJoNg/VQw33GDFQi2siFtlY2dfP9a8
	 gfFXWHdwSh32MEi8wxlNuw7k7TOQ04dRsW4IywstuWWrkMeE/Qx/y6YfrzN8ZjUvxlasa
	 cYuEyRRK2SJDhuGWpRXXmHTWYqr0nRLvRnuYHc2KdJkLqtubDnuEI6wQfA5Dzh7RiAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GT8bxW1e;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967BF606A31B
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 967BF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GT8bxW1e
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMPIvK940562;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cc8eYrZKPIltwbggArKFfJlHq4j6nfNvKSt51pU3dxE=; b=GT8bxW1enfhMD9Cg
	RLPXOwSXr5tJHTmDcBvHymubCtDtWihMUz0/0TwSyu0miS8jWZC2vKcGEvPCwchX
	anyQ28MqL19QyzvMzRXDmUhUWnnGqaqTpEHsT/11wsPOAdRpzN7wCyHnSVUT1VH4
	QVmBsVv4wXsIJkwyw1KL8un55SVTuxrlpOICRWGqk1+VJgcDvISyGkS+EfgJad1Y
	045IORl9xqI8v0b3jMmnFIjcdau1kvmxsIjbanwEA14JM5cQLdT9aZlraLxNeuXM
	2+b7TS8IGDwk+3tuxToblup/7VixFBeQLZmKx0waf9dKZ0BCMnkctcq9vbEcZFlw
	axwq6A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf2ttw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61O4259935;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 69QN61IP259895
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id D7E19255CE; Mon, 26 Oct 2026 16:06:00 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Lixu <lixu.zhang@intel.com>
Subject: [PATCH 05/39] iio: hid-sensors: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:23 -0700
Message-ID: <20261026-iio-v1-5-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX0ZZCvL3ie8b/
 7WtqBe5bd9w7lqmx3PAkvePZU8YgYscAypjPa5+SwT87uuk+Cg0xG0h6sC9Ekyi1c9SzFJ6Sprk
 n2uO2uAaQyfUK/Wr2Hyk2QWAxthnRZk=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=0UHDxNN7MSYmY5SeJZkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hfxsosrHvdfoS49TfYuL8H-eHH2CQutN
X-Proofpoint-ORIG-GUID: hfxsosrHvdfoS49TfYuL8H-eHH2CQutN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX7cX6k+oUv+H5
 l5lKpZTtbdrAk06NMbnFgKA2f8A6msipczEbxeK6m1s7NaGtbpa0SH8KZhz9eLoEYTjUVpz16Ow
 1I1UBBsARMBPBmFnHEfT8BypEdk52oqgGCMtpCHdeQVcwyJZhLKKwbnAC4H7zFa9/Stg0tq/fd2
 zwNj9ybmPSqUL8jGpuQzTCAkJZwhrGxkuHoEpG6+0eQR1SNSxcDRooCOpxYXEZrTH7wvImvzFfT
 3o17Wv0YtXP8x6ENzFHrIJZtKws1QP0W77d2OUC57r3gbI42IXES6zPrVlvl4BDG+wV7gNdqXOt
 KzaGJvvcihizBUIJL8z8bRjAHdpocKFX9NYOwLO3ejhhIaVfHGIisoo8V2qEzopTj6XTr/h51lC
 qsGrH9MhSpkwseEwL6Mq3MpFLXNhgQ/2KqXlVcDL6hiKj6dNYbl9/fPGXC14EV/szzHEHFb2o/5
 x4UkXi8DOoBl+e383zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

For hid-sensor-magn-3d, use IIO_DECLARE_BUFFER_WITH_TS() to suize the
buffer for the maximum number of channels supported avoiding need
for separate allocation.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Zhang Lixu <lixu.zhang@intel.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c               |  5 +++--
 drivers/iio/humidity/hid-sensor-humidity.c          |  5 +++--
 drivers/iio/magnetometer/hid-sensor-magn-3d.c       | 21 ++++++---------------
 drivers/iio/orientation/hid-sensor-incl-3d.c        |  7 ++++---
 .../iio/position/hid-sensor-custom-intel-hinge.c    |  4 ++--
 5 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 66778315e86d..083e82cf561c 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -182,8 +182,9 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 		if (!gyro_state->timestamp)
 			gyro_state->timestamp = iio_get_time_ns(indio_dev);
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &gyro_state->scan,
-						   gyro_state->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev, &gyro_state->scan,
+					    sizeof(gyro_state->scan),
+					    gyro_state->timestamp);
 
 		gyro_state->timestamp = 0;
 	}
diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index 12c88efe66be..c09986346c8f 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -132,8 +132,9 @@ static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
 
 	if (atomic_read(&humid_st->common_attributes.data_ready))
-		iio_push_to_buffers_with_timestamp(indio_dev, &humid_st->scan,
-						   iio_get_time_ns(indio_dev));
+		iio_push_to_buffers_with_ts(indio_dev, &humid_st->scan,
+					    sizeof(humid_st->scan),
+					    iio_get_time_ns(indio_dev));
 
 	return 0;
 }
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c8b4fa7785c9..f869560b47fc 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -37,8 +37,8 @@ struct magn_3d_state {
 	struct hid_sensor_common rot_attributes;
 	struct hid_sensor_hub_attribute_info magn[MAGN_3D_CHANNEL_MAX];
 
-	/* dynamically sized array to hold sensor values */
-	u32 *iio_vals;
+	/* array sized to hold maximum set of sensor values */
+	IIO_DECLARE_BUFFER_WITH_TS(u32, iio_vals, MAGN_3D_CHANNEL_MAX);
 	/* array of pointers to sensor value */
 	u32 *magn_val_addr[MAGN_3D_CHANNEL_MAX];
 
@@ -275,9 +275,10 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 		if (!magn_state->timestamp)
 			magn_state->timestamp = iio_get_time_ns(indio_dev);
 
-		iio_push_to_buffers_with_timestamp(indio_dev,
-						   magn_state->iio_vals,
-						   magn_state->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev,
+					    magn_state->iio_vals,
+					    sizeof(magn_state->iio_vals),
+					    magn_state->timestamp);
 		magn_state->timestamp = 0;
 	}
 
@@ -379,16 +380,6 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	/* attr_count include timestamp channel, and the iio_vals should be aligned to 8byte */
-	st->iio_vals = devm_kcalloc(&pdev->dev,
-				    ((attr_count + 1) % 2 + (attr_count + 1) / 2) * 2,
-				    sizeof(u32), GFP_KERNEL);
-	if (!st->iio_vals) {
-		dev_err(&pdev->dev,
-			"failed to allocate space for iio values array\n");
-		return -ENOMEM;
-	}
-
 	for (i = 0, *chan_count = 0;
 	i < MAGN_3D_CHANNEL_MAX && *chan_count < attr_count;
 	i++){
diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index b5f70732d035..3880e479a499 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -194,9 +194,10 @@ static int incl_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 		if (!incl_state->timestamp)
 			incl_state->timestamp = iio_get_time_ns(indio_dev);
 
-		iio_push_to_buffers_with_timestamp(indio_dev,
-						   &incl_state->scan,
-						   incl_state->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev,
+					    &incl_state->scan,
+					    sizeof(incl_state->scan),
+					    incl_state->timestamp);
 
 		incl_state->timestamp = 0;
 	}
diff --git a/drivers/iio/position/hid-sensor-custom-intel-hinge.c b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
index 101d84b533c9..98a5e3e03bba 100644
--- a/drivers/iio/position/hid-sensor-custom-intel-hinge.c
+++ b/drivers/iio/position/hid-sensor-custom-intel-hinge.c
@@ -198,8 +198,8 @@ static int hinge_proc_event(struct hid_sensor_hub_device *hsdev,
 		if (!st->timestamp)
 			st->timestamp = iio_get_time_ns(indio_dev);
 
-		iio_push_to_buffers_with_timestamp(indio_dev, &st->scan,
-						   st->timestamp);
+		iio_push_to_buffers_with_ts(indio_dev, &st->scan,
+					    sizeof(st->scan), st->timestamp);
 
 		st->timestamp = 0;
 	}

-- 
2.43.0

