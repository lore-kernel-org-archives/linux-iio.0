Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055974;
	b=LG8uHr3LgqLmFnaDos4QbXQG+32s7a/Ilw+KGzoXxRVB6ekxG8vFvbiqRXGd2LOtdxgN
	 toP1PsAl4vyixUbfZW1lPMfiKI7PHZyE1Y9oan2MWU/iCWASfLWZZh8tfjDJquUyRJJDK
	 7NIdXE0xRaMH0O+jb7XohrvnSD214npYhz05fjocoLZglZ9KkCsjFuJRZRVip41219ELW
	 ISHk5sZVCEAiYg/RgaZbTYtj5hhhUCRrJQqfLLOH7vgGZdNUhQo/tUyd6pnBlqGZHyqP/
	 zr6m88k5gdsGBbbNjqP8ggSTm2FrX1hlKRlF1Mx5RnvQErNyRQUeE7zHqwc/7u2NYOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=SjPGnqOj8Eoh8ilOHIWkWgBwZim7kpATfmg7uV0cBCo=;
	b=llTbh0wA//KI0NH5y/iAdra6D78z/UYY76CAChXuuUIQeuFtTu8MOApLMkUCXNaT1VG2
	 Jdi1FYm6ID692P+2k9jp6KJP9NBUNwdR4fe9rdEVnDcr7TAo0s/NsSNp+GlbDrxzXRMM3
	 27lMzexPcYtqH+yKB7ikyYfEi4jA0eS5kONZ49HqMU1VlAgO25w2SfRkNfWfOppA9xf7R
	 Yqoqim8fcIQmuXlqmd5agM0PVN/JKQmPX8A7Eig3ry4PKEUscfCB3kN3kQ5K5NHUgDdK0
	 dfML0tnd3rvm/HDolNkm6e334kklMN7v6pN0pdjE3dtsMpM2euOti5mdZetMXUuYeww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UT03ziWA;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78071606A32F
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78071606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UT03ziWA
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMPd2u4038564;
	Mon, 26 Oct 2026 23:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SjPGnqOj8Eoh8ilOHIWkWgBwZim7kpATfmg7uV0cBCo=; b=UT03ziWAGbi99xaB
	33HPi3ihzgBLfdU/hLE1PIlfJiAAgcE5S9n6n0qRg9/gh/kmmB8ZRDZPOnbfAWC+
	KKnOIgLpHW0nl/IzTByYxdOt4R/Y42QVTNwMRQMxGitG6cLlMPoHVMwIhjo+oaoU
	4sFpPOhsvHFc+lzlozi+TDny0xhFraen+dn61deI5D/h0g+ggGTTWRlh2NuIltpF
	cms6DtT6Ev5VCxw8GBty+NJnjDTGNZE3P/mqh6p8F4geOZAGAk/gvDH0SOsQJ1X6
	IFxew/VG1WIlAjVkReRdCVErKjwV8LdYOlTiHROskL0G1rmlIKMXfihffMdvYvf7
	Puo6WQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmm8yst-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN5NRi259008;
	Mon, 26 Oct 2026 23:06:02 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 69QN61Fa259959
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id A46EF2504F; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 37/39] iio: common: ssp_sensors: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:55 -0700
Message-ID: <20261026-iio-v1-37-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX5IG2ZIVGxf6Y
 T4Kukg3yzQOYyCJAWBVCW+3oG4U0cJgLozCI6tzxatkt0mW9zaQT+obbrSgfBB1O7y2dZuwbFCt
 28Y5mXBTpsB+lTjzUZLXcsZMTTpMR+M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX9+TrBhfyTddz
 dvF7fEl7l1jivfOsaNgmJvr8oQ5gKQSIxmfOPvfo5O+/4RlLSc+zRfG8ObXXQnZDSxm7bk5c74O
 YIzkzMjSc10LF8ayuPvdcIvOB0V0QEhBNZE7VPMR23OMRIBy1WlOhThKF/n2XfoSvTIENWuEHkx
 RPPqxHySznUS3VKm337lM1vUtY9dh7bDwnN0DDa9ERkAEr5SAd/atNFLDQW/UyPytnUEEH9r9Qs
 IrwbPguJ1i3FK6ME1pGpsKKhIx/6VZtetj/E1XuCep+iDZp20xmn4CQIpEWOvB8Aag6mdYOiHP+
 EhKD7sS1lWZIAv0YkWzinYTU62YqgAkb1/Hj90PYolvXKkKzswr8QVE85wjTXPsApZjZojVNiSZ
 +u0bhRiP5aVcmPykW/aORp5upd7vlYg8c4q0kiQkjrSBay6I6yfQpPJoOOG+bcXjztE2FGZvCr/
 TbI/Wo5HFVJMh7qYzAw==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=6pLk0INOMWp74TS0dBUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ht2q5GjQ-68HeJEiptiNi9V5ZCM9qgYT
X-Proofpoint-GUID: Ht2q5GjQ-68HeJEiptiNi9V5ZCM9qgYT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/common/ssp_sensors/ssp_iio.c | 28 ++++++++--------------------
 include/linux/iio/common/ssp_sensors.h   |  2 --
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
index 78ac689de2fe..a2a5a6292c47 100644
--- a/drivers/iio/common/ssp_sensors/ssp_iio.c
+++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
@@ -7,7 +7,6 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/unaligned.h>
 #include <linux/units.h>
 #include "ssp_iio_sensor.h"
@@ -24,13 +23,6 @@ int ssp_common_buffer_postenable(struct iio_dev *indio_dev)
 	struct ssp_sensor_data *spd = iio_priv(indio_dev);
 	struct ssp_data *data = dev_get_drvdata(indio_dev->dev.parent->parent);
 
-	/* the allocation is made in post because scan size is known in this
-	 * moment
-	 * */
-	spd->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL | GFP_DMA);
-	if (!spd->buffer)
-		return -ENOMEM;
-
 	return ssp_enable_sensor(data, spd->type,
 				 ssp_get_sensor_delay(data, spd->type));
 }
@@ -45,17 +37,10 @@ EXPORT_SYMBOL_NS(ssp_common_buffer_postenable, "IIO_SSP_SENSORS");
  */
 int ssp_common_buffer_postdisable(struct iio_dev *indio_dev)
 {
-	int ret;
 	struct ssp_sensor_data *spd = iio_priv(indio_dev);
 	struct ssp_data *data = dev_get_drvdata(indio_dev->dev.parent->parent);
 
-	ret = ssp_disable_sensor(data, spd->type);
-	if (ret < 0)
-		return ret;
-
-	kfree(spd->buffer);
-
-	return ret;
+	return ssp_disable_sensor(data, spd->type);
 }
 EXPORT_SYMBOL_NS(ssp_common_buffer_postdisable, "IIO_SSP_SENSORS");
 
@@ -72,8 +57,11 @@ EXPORT_SYMBOL_NS(ssp_common_buffer_postdisable, "IIO_SSP_SENSORS");
 int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
 			    unsigned int len, int64_t timestamp)
 {
+	struct {
+		__le16 channels[3];
+		aligned_s64 timestamp;
+	} scan = { };
 	int64_t calculated_time;
-	struct ssp_sensor_data *spd = iio_priv(indio_dev);
 
 	if (indio_dev->scan_bytes == 0)
 		return 0;
@@ -81,13 +69,13 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
 	/*
 	 * it always sends full set of samples, remember about available masks
 	 */
-	memcpy(spd->buffer, buf, len);
+	memcpy(scan.channels, buf, len);
 
 	calculated_time = timestamp +
 		(int64_t)get_unaligned_le32(buf + len) * MEGA;
 
-	return iio_push_to_buffers_with_timestamp(indio_dev, spd->buffer,
-						  calculated_time);
+	return iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+					    calculated_time);
 }
 EXPORT_SYMBOL_NS(ssp_common_process_data, "IIO_SSP_SENSORS");
 
diff --git a/include/linux/iio/common/ssp_sensors.h b/include/linux/iio/common/ssp_sensors.h
index 06c9b4b563b3..bfadf8eae558 100644
--- a/include/linux/iio/common/ssp_sensors.h
+++ b/include/linux/iio/common/ssp_sensors.h
@@ -48,13 +48,11 @@ struct ssp_data;
  * struct ssp_sensor_data - Sensor object
  * @process_data:	Callback to feed sensor data.
  * @type:		Used sensor type.
- * @buffer:		Received data buffer.
  */
 struct ssp_sensor_data {
 	int (*process_data)(struct iio_dev *indio_dev, void *buf,
 			    int64_t timestamp);
 	enum ssp_sensor_type type;
-	u8 *buffer;
 };
 
 void ssp_register_consumer(struct iio_dev *indio_dev,

-- 
2.43.0

