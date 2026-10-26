Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055975;
	b=hI8BV4rIFYdwVR2thiIgogUvNaYtWs/4+ZHW/2yt1TW7lCOf8VbXXeSZcdQn9O0UXUDy
	 rNyAWMJLieD3o3aDbFKqFYXploaDmHHZyd4eayDEa60Mw0GqURwao6cR0Q7mKxkgrKJn8
	 yuvkavI78liiOVlAWbrmsCL+VxxrJfRSRTvF79VP4yhZmbkt8wUGThyohUx9jg3RoLYnL
	 qzsiJIO1JfbHtl/y5mjfiQwMGv+FjckYYRTPmdjg9j7B/9skG8qBBpUncfieUjgAwfoHr
	 NDQrlszGEY5I3jDecLFe/bKC7KPiyN8UZX/LOv/qF584xskbP3lCRxjk0pFAFAHDhIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CPV+JPZ/v2IL4axfqYBTicqJJquDhxdcOjodLM+0aDU=;
	b=4/frUevuFphdt4P6c1iu6Was5koa/bxrKFaL7T4FQaiRRLX6QhOaswpkQYMlDt3y5t+D
	 Xp743Xq965695/xkuPRP3gzLJNg/bDLf8KU/zfynHzNWWR4xEAITs+88Frxu4NW+foTpk
	 TohfVf1HKrJjn1HNHstFmQPksAAA1wUVw5WE6HLdmbQSU0ULgXBQKOUeAEZen5G7/rDKx
	 uZDno8n69yujTX+k83cSRloB03fLhIw3uctDMPcJvA4PynKUBETiInIDV+kG8Az9pu29j
	 lTcxQp6IXITygqiGYzdKXT1TMuRlHL9aKjaf3QBwGkEnqYNaP46wVBEf0NSdTNqbnnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NL8Fz5EX;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132E606A32D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B132E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NL8Fz5EX
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMOt0o4036389;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CPV+JPZ/v2IL4axfqYBTicqJJquDhxdcOjodLM+0aDU=; b=NL8Fz5EXkaCUEeJr
	EYM9ElyJd8DQUJDGWxE0BQMyTbg2SCEIRv6vEIGpU/LV6Q/91KScmUsF0ffSmWOU
	chq/tvOlvunPOPNAiDPmtSYGXYI+dYFFTymS4McX/glcMl/xo+fMDElIlSexUDnx
	c0SfidPm4tdhBvp8W4bBxb/rPZ8ow3y46a4pHDl5FdxGbkjZKekNvpboHq3vIj8t
	cfkxy4naAMF6Aw6IIzPoquo7C+VX0khnWEDE1rHnZbA9lxnZD3hoUOOC/Vc6Nuwx
	9alyyobEH9ONe1jdu5ISvo8bWwKz9mxnjxPEfFqUE60mtIgUpqdFXNt4WPKMh3ga
	NMG8jA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmm8ysr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61cM186492;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69QN61qA186552
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id AAA5924D74; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Francesco Lavra <flavra@baylibre.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH 38/39] iio: imu: st_lsm6dsx: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:56 -0700
Message-ID: <20261026-iio-v1-38-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX7ZSbQEW8xCV/
 PZaFiy4BQR/ykzn93Zaj1HRjtLvZmIr/RKCKeGBewxCKpSFMrkgvj3ovNfMkvZqdxfLngwzJBAZ
 L5XYGgNzyhO43Z+OkC+gQmpBY1v9Bck=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX6zVHONGI62UK
 qO+7TO0W3icBL2Lmwua5wONP9vMbgk7Jgkcx2+v4VPy1fPzEiSqSNkw7CQmWuyRGv3jLoq+hRO5
 i4ENqRfU11kAJgOncQOwysCw6xbnxjfyuZGnOGeGgcCoIgfG3k35d6sdJDSFUY83GsasAV+hp7y
 65SXJHQmb0qdOaUM2Dh4ETTL3Hq9RLVSiPWKsqG3z5OaZi875wVBkoYwep9dAQBd+E2xUtNMXzJ
 31K4Q32+LxlzzqzT6FUA+uv05HG0Hc9pNDcxd30dxdagVUPqs4z20L+wm7fZMQIEOlTp/IHxR74
 s+FJRJynq1ShkF00vLL4IkupDZQAnpIalfb9lZ76lP6fjbgnS/J2iCHOEJfWunJfeaBhRCgzycP
 6muT8uP6X7sqGQze29GDqPzOt4j/y03f+jJ2BHmYpfr3MmFlN7u4OmjQm0eBFigVQCxCRVvyTAq
 Oe5wiSF46I9irkcXpOw==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=IpJZQVW2AAAA:8 a=VwQbUJbxAAAA:8 a=Rd5JdI-Rlna3aY1cNJoA:9 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: NsvnHelfy48PouUpHX3vF6EmpMoze5_8
X-Proofpoint-GUID: NsvnHelfy48PouUpHX3vF6EmpMoze5_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 17 ++++++++++-------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   |  5 +++--
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 777d479f10c0..c60192775ce8 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -496,9 +496,10 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 				if (gyro_sensor->samples_to_discard > 0)
 					gyro_sensor->samples_to_discard--;
 				else
-					iio_push_to_buffers_with_timestamp(
+					iio_push_to_buffers_with_ts(
 						hw->iio_devs[ST_LSM6DSX_ID_GYRO],
 						&hw->scan[ST_LSM6DSX_ID_GYRO],
+						sizeof(hw->scan[ST_LSM6DSX_ID_GYRO]),
 						gyro_sensor->ts_ref + ts);
 				gyro_sip--;
 			}
@@ -510,16 +511,18 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 				if (acc_sensor->samples_to_discard > 0)
 					acc_sensor->samples_to_discard--;
 				else
-					iio_push_to_buffers_with_timestamp(
+					iio_push_to_buffers_with_ts(
 						hw->iio_devs[ST_LSM6DSX_ID_ACC],
 						&hw->scan[ST_LSM6DSX_ID_ACC],
+						sizeof(hw->scan[ST_LSM6DSX_ID_ACC]),
 						acc_sensor->ts_ref + ts);
 				acc_sip--;
 			}
 			if (ext_sip > 0 && !(sip % ext_sensor->decimator)) {
-				iio_push_to_buffers_with_timestamp(
+				iio_push_to_buffers_with_ts(
 					hw->iio_devs[ST_LSM6DSX_ID_EXT0],
 					&hw->scan[ST_LSM6DSX_ID_EXT0],
+					sizeof(hw->scan[ST_LSM6DSX_ID_EXT0]),
 					ext_sensor->ts_ref + ts);
 				ext_sip--;
 			}
@@ -549,7 +552,7 @@ static bool st_lsm6dsx_check_data(u8 tag, __le16 *data)
 }
 
 static int st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
-				       __le16 *data, s64 ts)
+				       __le16 *data, size_t len, s64 ts)
 {
 	struct st_lsm6dsx_sensor *sensor;
 	struct iio_dev *iio_dev;
@@ -597,8 +600,7 @@ static int st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
 	}
 
 	sensor = iio_priv(iio_dev);
-	iio_push_to_buffers_with_timestamp(iio_dev, data,
-					   ts + sensor->ts_ref);
+	iio_push_to_buffers_with_ts(iio_dev, data, len, ts + sensor->ts_ref);
 
 	return 0;
 }
@@ -617,7 +619,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	u16 fifo_len, fifo_diff_mask;
 	/*
 	 * Alignment needed as this can ultimately be passed to a
-	 * call to iio_push_to_buffers_with_timestamp() which
+	 * call to iio_push_to_buffers_with_ts() which
 	 * must be passed a buffer that is aligned to 8 bytes so
 	 * as to allow insertion of a naturally aligned timestamp.
 	 */
@@ -690,6 +692,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 			} else {
 				st_lsm6dsx_push_tagged_data(hw, tag,
 							    iio_buff.data,
+							    sizeof(iio_buff),
 							    ts);
 			}
 		}
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 360f1365f892..81ff0b32ec40 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2798,8 +2798,9 @@ static irqreturn_t st_lsm6dsx_sw_trigger_handler_thread(int irq,
 				       hw->scan[sensor->id].channels,
 				       sizeof(hw->scan[sensor->id].channels));
 
-	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan[sensor->id],
-					   iio_get_time_ns(iio_dev));
+	iio_push_to_buffers_with_ts(iio_dev, &hw->scan[sensor->id],
+				    sizeof(hw->scan[sensor->id]),
+				    iio_get_time_ns(iio_dev));
 	iio_trigger_notify_done(iio_dev->trig);
 
 	return IRQ_HANDLED;

-- 
2.43.0

