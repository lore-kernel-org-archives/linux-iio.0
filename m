Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055972;
	b=tINnGeReYSqQYqJigMTpoISHIpZMXEAaxUXkuSqpjDYKtwveyvdqdxTj7flaYYalwFOT
	 zuaRBunsWCfXMtFrwn6kwlcOh44AcSdljVuXMG8NZ+hqA9yOsjVLGaoQo7BW+KJcnRWvq
	 nAyGnvQP55+0Di1z8iKzk5BVGMWn3imiC/fUn/si4RNzN8ned1IKeZOHUvNvZhObXyodr
	 3FlIlEP0SyPd0f+L3b+Lx1RWYN1AbHu6ismJ8bWwIXTucvwb6OWiJeIIEY8LFppMUJSnV
	 xfraIrfqYFMiWwbqU9YIcmSDZ1mqHhKFkrLMDznESiJuq5A6TeY+EBHyfNBTrtTpxjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055972;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=SYxU+f4YxxW82gDJ+VApZIjGRA62zOrkmoO684nJhu4=;
	b=tCoXAKj/dxKdRkQ8h1+MKHV/LB0TJnrDYWpcP73S+GQaRfuWtbEtaXyy16+6xNvvwSoU
	 tUzeSUIRLuJHnrKR81BIyHeGCfhPAsec6FfbPjPNfGQ8BokE0KV90MPhj/xPsbdKQjGM+
	 /OlRpygHUMUfsThb8RkVHxdMXPsfm1sp8euLLMtgUeMD/y+fI49NLpsXNHm7Xl+qpQJiT
	 xcGlQHl+PxzsCxNNGVgc7bomOMHaeZKm8Wgwxv0M8u3CKZ9npaVNfkUd/xv9FfOG0ejCG
	 4D9tL7VvJfyVYfJftZ1ax/m/JvD97iCn0+JtX4KGEu4iwYEWu1+fj7N4sd6bXHLcSKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G3Dlha1R;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026E3606A31B
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 026E3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G3Dlha1R
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP2434037256;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SYxU+f4YxxW82gDJ+VApZIjGRA62zOrkmoO684nJhu4=; b=G3Dlha1Ri+s9uTEA
	pP8oyzUSjQhYCW9+yc30PatQ48zj4v0SB1cyCQ9Qw/ZzqbEfi45oGvh5rQKV+2hq
	ag87B5c6ygu4Tz21R3MVbzcatPtII5hxnesE897ezP1i9V/pVpXTcjtDWWNayeMX
	ynAeLsU8h8WuT3QT6whG5c1P9FZdcbW6Dsmo+KKbHcSZ1hGgDr5f6omZZJQ5yMIG
	7AEXq/+UX9lD5BuaaXIo2RsdtJIzw+lacr1WLlJ1jjnu3UOEbGruNXWLFYmH3swM
	iWI03C5Ef2bPSjLFn3TpnV5OL26TCjSWwEFzJ5PMdZXXsCg+nYzz4XtJMeapV5k9
	ndnRsQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmm8ysm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN4Fuw183668;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 69QN614E186525
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 4CA542561F; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Shen Jianping <Jianping.Shen@de.bosch.com>
Subject: [PATCH 22/39] iio: imu: smi240: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:40 -0700
Message-ID: <20261026-iio-v1-22-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX2YqY3sJxj2V5
 TIDPMijz2CWO09clmTcOGiFB0L3mwE3ZRmvgpWJHvAHUxgUJWVY5esjWC4WNhBGXa8kM8cfW3Cl
 j1bOZuuI8073ff1tRRvXh7T0r0pIOpM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX1nmtaAuqw9PK
 VQ00cLjXw+BSKDBVaPBu0xeNT6waoxuh1DpvssHiR+IjP5ycdFBi80YAm6FfGjCphAJ335+WtSY
 kQdFvYi2nB/vGre5xgVYSFfKNnNQzD5gyHEyHwsFWEjVvuBrdUkX3REjUUORTzS4hIv7JD63m4e
 ReIv6QZNJbG8OdXekXo9j9tvPwBT1z3rxZa4dFNobbuup3fhK56IJvtB5kjep8A32ZkOHYp1tCD
 eH6iqJDuFNAii78065N3uteUeRHFBQwruK+j+8eQNFoMIrmQOU9kNo4xJJhvOXR/9nRXQcuhM8J
 sJWhzkGHfSRcFE0KzbpkTg9HgnsJv3BuP8kXQj+20AxAzBK/uKVKRyJc1E/UodUvM11w/yBXMVG
 sFOg0m1tCFtONFtBVMJlHOuIloWQjjpdqO65xhtN1yS5h4n9CDSHvVNfJtfWISSot3Ob4iim2tW
 dWiZoAO7v4SBIWj1zDA==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=hVcwujEvAAAA:8 a=9W15RE-gpInvPymUGSoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: NX_ub-OBvDkvDcAsfVHDvOh_elpzvoRi
X-Proofpoint-GUID: NX_ub-OBvDkvDcAsfVHDvOh_elpzvoRi
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

Move the buffer onto the stack, local to smi240_trigger_handler(), and
declare it via IIO_DECLARE_BUFFER_WITH_TS().

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Shen Jianping <Jianping.Shen@de.bosch.com>
---
 drivers/iio/imu/smi240.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/smi240.c b/drivers/iio/imu/smi240.c
index f419296bba88..a9d9600be30c 100644
--- a/drivers/iio/imu/smi240.c
+++ b/drivers/iio/imu/smi240.c
@@ -111,14 +111,6 @@ struct smi240_data {
 	u16 anglvel_filter_freq;
 	u8 built_in_self_test_count;
 	enum capture_mode capture;
-	/*
-	 * Ensure natural alignment for timestamp if present.
-	 * Channel size: 2 bytes.
-	 * Max length needed: 2 * 3 channels + temp channel + 2 bytes padding + 8 byte ts.
-	 * If fewer channels are enabled, less space may be needed, as
-	 * long as the timestamp is still aligned to 8 bytes.
-	 */
-	s16 buf[12] __aligned(8);
 
 	__be32 spi_buf __aligned(IIO_DMA_MINALIGN);
 };
@@ -370,6 +362,7 @@ static irqreturn_t smi240_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct smi240_data *data = iio_priv(indio_dev);
+	IIO_DECLARE_BUFFER_WITH_TS(s16, buf, SMI240_SCAN_GYRO_Z + 1) = { };
 	int base = SMI240_DATA_CAP_FIRST_REG, i = 0;
 	int ret, chan, sample;
 
@@ -380,10 +373,10 @@ static irqreturn_t smi240_trigger_handler(int irq, void *p)
 		data->capture = SMI240_CAPTURE_OFF;
 		if (ret)
 			goto out;
-		data->buf[i++] = sample;
+		buf[i++] = sample;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buf, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, buf, sizeof(buf), pf->timestamp);
 
 out:
 	iio_trigger_notify_done(indio_dev->trig);

-- 
2.43.0

