Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055974;
	b=y9gC/Lzb+PAx/e48M71gl+vJgF5ob2+3h3CDCVFju4PAmG9ZuAVF+UK49YFHWPdnNGqd
	 1MJ7DfUK+0pwKbXDUekLKPFgM37CTFNciv1edGtLAITJDnXqyvDOKyaggZccxTp9OxO+u
	 88AEH6lCaHNZjj0+jtsP0x3QvmzqtEziSzAZ5IIMSUp6Tv6c7UR+nSBBkAPuH3wIIAxB1
	 Yifd6VEk9GiqcPJiZhgJWlKl82yECk/YhyvXFoMgiA4eMnCAx/V7iDzEddUNaLPGZd1t+
	 KHQb7Ju8lcq+A+/vc98LGZWSBHL5hJdp+kV4aW432ZnsESVOd0MwhGMNGczxiLTeU4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Pt/SgU8BKeMn+gSCaCMuGy8rvBPgLfu0s9G68Lb3UJA=;
	b=StHDVCgW0NXiUV8W2yRrFg/co/oX9grmZ6ZaIf7iNAv8R33V46SI/rGZBwPEPJile3p1
	 QjjxVtWc4c7Xu4k63Tqw6jVtf86aoN3mPBmISU4+MHc7RIGEwrCCwmiYBDR5MZtUKo66O
	 Igggsxwnl5XVWKMGQNel/M5z/GGicy/2FCp5wknj3yY6/ixIMy40HwYAzVuH7xhrYw6mi
	 6Iu9ch9CYo7WaF4FREBOW8yLyFThUy83gIB27/sBjRoBppE+UM00Ufj2n4WKB2RaT9gt3
	 6LZdJBQ4cd/WusFzz5+S6ySPbKLWuwx9LgFyq1BLR7JVq7d78rNOPq+nRjpvOLzip/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mp+7CQFc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3818606A31B
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3818606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Mp+7CQFc
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMOpkq1430434;
	Mon, 26 Oct 2026 23:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Pt/SgU8BKeMn+gSCaCMuGy8rvBPgLfu0s9G68Lb3UJA=; b=Mp+7CQFcBdUW5Hhu
	yh1zQ1RPOrvqRTfHv59ZPujcphoVKTzpAics+Ind6bkQPRY8oSBKq30VfnEFUGzl
	LoKtj2uyR+K6zWyx9hOtEHpsQgXA1V2LD/HTnvwnx/eGcBo2pxdtokpehU3nQJ+l
	XFI5+8dfGKx+M8vSF02C+F2h6AZcLdhUcki14d2bdiEKXpzodl9/9ajohp0gDhgK
	gzjpQ7dGJXMYPBUtehNs48jGA9HVGzDtgeYq0/XHws4mVyUB/D+1bUWY91lx38yv
	ZygIHYCKOCKEycdaVSFIK2IKs+vUGGGFmCtkbMGfe6mGsNw0K2tnu0J+Cs4asiax
	dph0pA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hje3d8d1w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN2q5x100176;
	Mon, 26 Oct 2026 23:06:02 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 69QN61R4104541
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 5892225623; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Piyush Patle <piyushpatle228@gmail.com>
Subject: [PATCH 24/39] iio: adc: hx711: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:42 -0700
Message-ID: <20261026-iio-v1-24-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX6SaV+IQf1Abh
 h9p2fJc86hwQG7SGiW3RMqZqiSeXY82xW7N0QD+oRbAYpKnktGGcyYBqhJBu2P339sJ7qQgC1t4
 y+bpLhmpY0VqsNzL8A4aPVg9MJLA1DQ=
X-Proofpoint-GUID: ua5Ifmn01QWlRiXrnA47K0nWthUitCIX
X-Proofpoint-ORIG-GUID: ua5Ifmn01QWlRiXrnA47K0nWthUitCIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX0UmDGQBE3x1M
 Svz+nMySdWoXoFmedplTIrZYqY+g1rc6XULOLXbgTnwq7TNZW8NiL5ZTZiASakxXHzPGQI98OKo
 kPk0qaPTRL/WoJ3cPvJyM7HwKHIGipwlAQ6hMgyrmT1Uw+eYbHpK8rHNGFKR4B0ggAw6mt+VxuK
 iE429YL3b6P/eifgppyWYLZO9iOvq7BwOEHA5ztS0K5RTqInnqb5vVUTcJT0rr59WSY1nEWNp+m
 IB2zUjazbXGcbkzWEKvyXQv3QtNGeCGGcWd0ZPOhYPP/lY84B5jgSmHAEw5gt8+ZB+Mw/E+zVX0
 lAzEF5gbRUD7XrSkDezEnYwAyKHqu2dTQYyrm/yDcUVgqBHzQMH8TvsSew3DtZUfI5qT/bdyph1
 7XXhJ2gzp+6tbld0JhBwzyI5eqJFqkLKvPin1o9qhuemIzsiwGU1AfLgWDxByawWPBANz2xGf1H
 tEQC5E5y6Lhz71e/h7A==
X-Authority-Analysis: v=2.4 cv=SN/Xx+vH c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=it50yF1urR0yekPjVx8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Move the buffer onto the stack, local to hx711_trigger().

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc:  Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/iio/adc/hx711.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 00adafa7cbd7..7eb089215f1e 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -100,14 +100,6 @@ struct hx711_data {
 	int			gain_scale[HX711_GAIN_MAX];
 	const struct hx711_chip_info	*chip_info;
 	struct mutex		lock;
-	/*
-	 * triggered buffer
-	 * 2x32-bit channel + 64-bit naturally aligned timestamp
-	 */
-	struct {
-		u32 channel[2];
-		aligned_s64 timestamp;
-	} buffer;
 	/*
 	 * delay after a rising edge on SCK until the data is ready DOUT
 	 * this is dependent on the hx711 where the datasheet tells a
@@ -397,20 +389,21 @@ static irqreturn_t hx711_trigger(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct hx711_data *hx711_data = iio_priv(indio_dev);
+	struct {
+		u32 channel[2];
+		aligned_s64 timestamp;
+	} scan = { };
 	int i, j = 0;
 
 	mutex_lock(&hx711_data->lock);
 
-	memset(&hx711_data->buffer, 0, sizeof(hx711_data->buffer));
-
 	iio_for_each_active_channel(indio_dev, i) {
-		hx711_data->buffer.channel[j] =
-			hx711_reset_read(hx711_data, &indio_dev->channels[i]);
+		scan.channel[j] = hx711_reset_read(hx711_data, &indio_dev->channels[i]);
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &hx711_data->buffer,
-							pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+				    pf->timestamp);
 
 	mutex_unlock(&hx711_data->lock);
 

-- 
2.43.0

