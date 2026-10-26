Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055971;
	b=nSRHGWr7GqpClqXhe/ac6ero/fH/lQteoCsyVP4O40G+fGux2qQbUFEJkdRs9ns5Rns3
	 zY87pfyc5WNQxaJkM6j0XjVFhG2j89s+6nBPMuv9ZllJogtMG1pp66Guc8TOykpqDCELN
	 ir65IQdMc3/3JESBmTelKfwnApiunWJxT8+vzJ9I07XFeIu+RErd55FNmi0j0ahmIVxyM
	 hDudz5oeA7jTgnhtJQ+ZxmpzlrZQYCGKtYbTU4E/GjHl+DKydKxn97W/y0/UpVAu4yhxg
	 gOyoV1aSi6YS2jBisCYX23Qa47y+vatjC2eLYBTYcK8Qjvg4osijzlaEw5rjavxI5Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055971;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CMQCMFFC6cIaxxWTDpALBLKtxIyApvyPpQ7Ku/FtKk0=;
	b=azUDB8KFn/WaLm6+tF69JsAubxwRZD85csZV7dcDrgBcQ2fq+MGkxQRt7Y/dPQwgVpeK
	 IkpBQDzoEql5niBpKWn2gKPwbLX9xZg+E2gqBHWL4kFf8HGMsbokmRPZp/1ozVjvvZTI5
	 cUkBqbo6bXPu0etDdTWXjWTXGx7IKW+dqQEFmkXhi/KOAdo5Ubpiu7xTh/ObSUga3VYQ5
	 1j1f9V+u+Gr3DNJQ1nTvqbOL78P0xRsIWk1rbNIejcGeW07yl3AhVHR9UA2lUq1mRNh69
	 J1JARrNsDIgt5PDDWgSUsiFdyhETTxqXpx5/fMPWiW0JqRIhbZn7CZeDzcAKN9/iRjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nei8qMNb;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535A606A32D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C535A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nei8qMNb
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP7W8034156;
	Mon, 26 Oct 2026 23:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CMQCMFFC6cIaxxWTDpALBLKtxIyApvyPpQ7Ku/FtKk0=; b=nei8qMNbxi2wan0u
	QJ6SZk+NqwHb+A/58k9Z6buPjnvjTC2vjOTPCQ1ZKDK3SESgkmpmTcZvlcGu8Ns9
	yJpw5kveiuzqdcKW6KStaRA0eZe0ZI/z0x+eDs5aFcg1tNAEqLAGI0TnHhVyBkgh
	hDVTZ7Uch7eI7CMOf0Yrzsr7wUFXOWHuiFYQ0KIHep7D21pk9yIvayFs9pLuRQYt
	bNdELChQUzj4QuoY9UxeOdzrJXEaT4Wkv6+1ONSzYUhTdQgj7feF0v0MM4cWWbdG
	P1VPXj0T1BIGqqcQUsSCQTmbc01E8FdFF4yb1RHgYMKQXoha4Iv0Gu262t8HAKtA
	EjkjYQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cpawua-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN618m168728;
	Mon, 26 Oct 2026 23:06:02 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69QN618t168756
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 9E97A24E36; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 36/39] iio: common: cros_ec_sensors: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:54 -0700
Message-ID: <20261026-iio-v1-36-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX+Y3TO/exzsN6
 yr+ATQE8gOAAvwCfohBlIHy2thW64UFjEcyn1s0lHO9xmFSRNkbGUwYITPt67mWQ9eylmKR3ZGv
 7EejZI6xCpqBp959ENPxXCyepRzDyEdl9OW88YJgjdd1t7/wpr2cwzHhpmdt22lCOsjF/p5ony0
 oQtWLVelNODHkvAAKHe2dnY/sZFvjHvHYM+CsToxKbVEiTypAKiTfZliM8Y0znqcbqMVzNzFqR5
 DMsqW/f3QEONIygPpX50RNo87PHI6mpxeoVfnivkeJ8O0ELl0+XHTxd3TdX/SP+XTjDddtRCr2t
 L6A63XKejP9RU8YCk16kzyq2GOBC7T5ETQLahP8sb5MhNdU/M+GWsS/+t4PTbKCXGl6dzFAmaxt
 HKgsEPFQgoiJZw/JdKIo5KEIfd+sQE77GIxHSzdOftyxpt5ZBYzieMcvHNE/rKiL8bdDA9g/AYX
 hbr6zq5UgKHvs/JbDMQ==
X-Proofpoint-GUID: UTilHXe7vIl79XsXV8kwuvNw47aczHA8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX6XImcBB8U1WA
 KO9qqfdA6sjd3FwLvML1WqlSSOAWHmBzaIozD65LHdOAMiRokA8mr0wXrpaJYgrQHMYD1rTW/Cs
 a2Yzk+5OAPjoYlZZleRI4wPM2k/03Mw=
X-Proofpoint-ORIG-GUID: UTilHXe7vIl79XsXV8kwuvNw47aczHA8
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=ITWw-uuFyFvfxC5rs8QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
at both call sites.

Replace the raw samples byte array with a scan struct containing the
channel data and an aligned timestamp, matching the layout it was
already manually maintaining and removing the need for the
CROS_EC_SAMPLE_SIZE size calculation and the casts used to access it
as an array of s16.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>
---
 .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 24 ++++++++++------------
 include/linux/iio/common/cros_ec_sensors_core.h    | 18 +++++++---------
 2 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index d03e40c91582..721e79f67f7f 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -181,9 +181,8 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 			      s64 timestamp)
 {
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
-	s16 *out;
+	unsigned int i, j;
 	s64 delta;
-	unsigned int i;
 
 	/*
 	 * Ignore samples if the buffer is not set: it is needed if the ODR is
@@ -192,19 +191,17 @@ int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
 	if (!iio_device_try_claim_buffer_mode(indio_dev))
 		return 0;
 
-	out = (s16 *)st->samples;
-	iio_for_each_active_channel(indio_dev, i) {
-		*out = data[i];
-		out++;
-	}
+	j = 0;
+	iio_for_each_active_channel(indio_dev, i)
+		st->scan.channels[j++] = data[i];
 
 	if (iio_device_get_clock(indio_dev) != CLOCK_BOOTTIME)
 		delta = iio_get_time_ns(indio_dev) - cros_ec_get_time_ns();
 	else
 		delta = 0;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
-					   timestamp + delta);
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    timestamp + delta);
 
 	iio_device_release_buffer_mode(indio_dev);
 	return 0;
@@ -718,17 +715,18 @@ irqreturn_t cros_ec_sensors_capture(int irq, void *p)
 	mutex_lock(&st->cmd_lock);
 
 	/* Clear capture data. */
-	memset(st->samples, 0, indio_dev->scan_bytes);
+	memset(&st->scan, 0, sizeof(st->scan));
 
 	/* Read data based on which channels are enabled in scan mask. */
 	ret = st->read_ec_sensors_data(indio_dev,
 				       *(indio_dev->active_scan_mask),
-				       (s16 *)st->samples);
+				       st->scan.channels);
 	if (ret < 0)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->samples,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan,
+				    sizeof(st->scan),
+				    iio_get_time_ns(indio_dev));
 
 done:
 	/*
diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
index bb966abcde53..25af3bfbef42 100644
--- a/include/linux/iio/common/cros_ec_sensors_core.h
+++ b/include/linux/iio/common/cros_ec_sensors_core.h
@@ -24,12 +24,6 @@ enum {
 /* EC returns sensor values using signed 16 bit registers */
 #define CROS_EC_SENSOR_BITS 16
 
-/*
- * 4 16 bit channels are allowed.
- * Good enough for current sensors, they use up to 3 16 bit vectors.
- */
-#define CROS_EC_SAMPLE_SIZE  (sizeof(s64) * 2)
-
 typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
 
 /**
@@ -48,10 +42,9 @@ typedef irqreturn_t (*cros_ec_sensors_capture_t)(int irq, void *p);
  * @calib:			calibration parameters. Note that trigger
  *				captured data will always provide the calibrated
  *				data
- * @samples:			static array to hold data from a single capture.
- *				For each channel we need 2 bytes, except for
- *				the timestamp. The timestamp is always last and
- *				is always 8-byte aligned.
+ * @scan:			structure to hold data from a single capture.
+ *				Up to 4 16 bit channels, followed by an 8-byte
+ *				aligned timestamp.
  * @read_ec_sensors_data:	function used for accessing sensors values
  * @fifo_max_event_count:	Size of the EC sensor FIFO
  * @frequencies:		Table of known available frequencies:
@@ -75,7 +68,10 @@ struct cros_ec_sensors_core_state {
 		u16 scale;
 	} calib[CROS_EC_SENSOR_MAX_AXIS];
 	s8 sign[CROS_EC_SENSOR_MAX_AXIS];
-	u8 samples[CROS_EC_SAMPLE_SIZE] __aligned(8);
+	struct {
+		s16 channels[4];
+		aligned_s64 timestamp;
+	} scan;
 
 	int (*read_ec_sensors_data)(struct iio_dev *indio_dev,
 				    unsigned long scan_mask, s16 *data);

-- 
2.43.0

