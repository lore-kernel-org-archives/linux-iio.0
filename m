Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055974;
	b=4RSX9EuemHsZLCnTGqbhiJZOEK4D9iHePX5ZNBmlB6SXIv/R/EwRjKI3RHR3mRZpmY7T
	 ZdR4Swh1SU+trtrT/UY3SWw80j6NC6WqgKduPP3g6ancSWE1zzc0uErCDEcB1Xgs9hz2A
	 y0DIsy9/EwfGxvOUtvyewvZlE1ItCZD3sGjJUHUKKephUQWx9Pg1ROFH2Xte8/jRmMmow
	 ZKAr66fTXSBPEMfSMh12y5a67L+x/YY35caq26Virn6doi1WIzSQKImxEyMZCcYaM8b0R
	 /mYd+MrOuoZfhqAH8dMGMlOfJdwI79av/l1sQqkhDaWs9gm/tDQnMjAAItmTar3Yvrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Ah5bx0Ss1TUfmguCwMpSeGkahLGj3kCHMWvWbFupZfk=;
	b=HhBHJpeCjveJss15AU5EDcL2fVtzR4ua1d21F1QqWc0tU1nQXt75Cci25xVJ6p8o1gu4
	 r4+oN1qijSJGCgK4bLOjBg11SFS41ldVxaxMEMWlyLBopcRbA53trlqwDSRJSqQIY2cCc
	 C1L6apKTmftQ3g05aewpnTqOR5kke2fGGgSoeYyIUP0F4dJ6LUooPDtUyDsPyN7aqaJfP
	 fcMbHsGcHO5CuiN6Y4vdq862IlEdV7h1MdmHQvdVvoblgLMPEFuEn1sFET3m9ZryYCnoF
	 SCPA9aQTKcj9UPwsfB7PteIz+FOq6lAVe7SAYSSbP7zv5FbFFGF2nCaTGQ6nRr0ePCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z7tTIXB8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A868E606A31D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A868E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Z7tTIXB8
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP0D43041066;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ah5bx0Ss1TUfmguCwMpSeGkahLGj3kCHMWvWbFupZfk=; b=Z7tTIXB824phMBKD
	vbhsFNqtQbfNvA615jYgbgrWGAeV+OtiEGUDNfzNHw1vctJWH3IuZUq+u+WCfB2Z
	pvLt3C1SQkc+BayFQAbje+vNBNv8tgu2sTipYcDdbQsR6FRrxyTPJXlhvwT+LCxm
	52/XBvIOZqq4LUPcxT6kh+0WKggBVIXPPxiRp1IhNKsvJGuj5coV/2uv04JqjYLo
	rx2DhXvs9al4WeCbijpcCRohEwFnUp6oIjQ7EBf8vfe+/MBMe693+yqDL54nY64T
	sZtuzguGcsJYoaY4SmXXePFhElMLgDGyjhtloD+3jM5CW1Ew1HL/xVamBhYpMSVY
	VVQwMQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54h4hm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61bJ120329;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 69QN61Hn120278
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 27D112561B; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Subject: [PATCH 16/39] iio: imu: inv_icm42600: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:34 -0700
Message-ID: <20261026-iio-v1-16-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX97csQaxj5Em5
 QRv7uPqZKflNDNeqKfGjLDoKRkFNDDjZdajAUyjxEyZDHZpnoZoehLGfQGyqlESOJ48W8N71p9I
 WsCxPXsG3Ha4XinQsJr0u1qkEXj/R7E=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=In8RU02eAAAA:8 a=gWbUWn3fsZ_8QVAnFL0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: tDa2bP8um-4fPGrPMKxUbyFo2cN6SSA2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX0cJzgi8I6bmS
 ky9InGnHt9JSp+tJUafgtz/SH9a6C8SYv5mCH5TdQtlPvGDrSFA5fJswmdFxBFjXdw7mwXys0HN
 3DzFhn/vWw2rnAVj1F3tqyOjSLQr65/zN7mgQIhELD/U0ieM5vZWxxU/AGLhwySphmXVab7Npnh
 Te+45njkEftVd110zaXBhEEDmUzUv3MYn/XgmSA1iFtNFt8ZG+Ej7aHNjk1P0W+vVQApucLALcK
 Fso3omW8MMj5EZCVR1gzxqPUE423maAg3O8d+XsThFycasasagi0345PnrbSGhSKkK925ENQAp0
 Pqk2SYEkpN/Lzd6yIkgrgWILp6UvEgz15u5MI8K3kR0XLWceO+w3wBmIyrHiwgzb1LZEITOdURA
 aRL+HKBgoKkHCrlyG9QjiWgnuqaczJeegEfhAIatvpKExrufbN1ngz3uXCLiBSihgzFPvKUJ0Pa
 CnThT9wyKYqxlsDvvtQ==
X-Proofpoint-GUID: tDa2bP8um-4fPGrPMKxUbyFo2cN6SSA2
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
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c | 3 ++-
 drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index cc8c074777c9..d40300af9b3c 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -1250,7 +1250,8 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
 		ts_val = inv_sensors_timestamp_pop(ts);
-		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
+		iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
+					    ts_val);
 	}
 
 	if (st->timestamp.accel_force_odr) {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index 4e20d61d897b..f895226f4a39 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -829,7 +829,8 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
 		ts_val = inv_sensors_timestamp_pop(ts);
-		iio_push_to_buffers_with_timestamp(indio_dev, &buffer, ts_val);
+		iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
+					    ts_val);
 	}
 
 	return 0;

-- 
2.43.0

