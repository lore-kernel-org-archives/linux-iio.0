Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055979;
	b=u5QgwlpREEnqTNMen3ewOHfS99GTzDYTxVKZyWvgW1e8ezN0vKHhL1ABXvBKTj/4Twz3
	 eq2oTxIoPO/uUsRIFUAERiqo+TOIRtNFQcUWCRBUV9wPLT/KssjeBomza1OxmIQ8km60t
	 M/m3Yq7ie/bOZA8OOtqBy+d88yXwSw/y6tcnv7DBCEQoe7ntdu/+Z5FF8F1G+kymbMy9L
	 goTPu1GcfZA3GWBXM2rvMJbFGtdIW6Z9dO5bCoGCb6EA0XundBQXpvBVJGcsT8QGaYutZ
	 5x7vITsqfi9DwSqFnmsoVYuv2JN8HBypJC/szSch4P9YMMNucC0QfK5pG1uv6RV1TkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055979;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2H2kFhSiD6fXwH+sgvr/KsmlIovbU8T1vRGUmEmt20k=;
	b=NsZz0cNFtKhhvHqzh8YeqXRuch9/1yTH7QM55B7fv951xDL9JIyePo1Qs+c9YDxsTx9d
	 br+hzTO75Rbosty5bRHuDTRodtwVLQxvuGeEVi9Uy1DA3X+SQjXaZPMVMmH1Eski8VWXv
	 qUcdSsadc1pBeAWedUCsFKSrDHnTz+8gwQocMWrGqZiqp8SssC3xcu/LVkVOt6TKoE8qQ
	 ZIIqWH3MeG0Ty9UnRbeNQTx61lunZYCuRMYH01rYO1q6yfUVZlkO6yQCDoUJAwUO4JGZV
	 L/Ba6qimvArSlrkecPjhwylwruDqTDWXSzxYbk0SFqM7NDBzF0U3BPLRp+k5Pa/pyAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cpHbQrTk;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54542606A31D
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54542606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cpHbQrTk
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMPEiP869248;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2H2kFhSiD6fXwH+sgvr/KsmlIovbU8T1vRGUmEmt20k=; b=cpHbQrTkCXT1WhZh
	TfVZokspLSAUXALoc/aQT+zfdJvSdz9uEp57hUaFNJm5RL3Upf9uXkOxcmU4xnt6
	jtlUKzmbKeTIZGq3H05HCK92RneAETlAoxQzF7aZQTb49Zp4KHKbKWJB0pna06Wo
	/C8OTZKgYoDD5MIX+leoXY1OR6hbifO+LAcDu4LEgUvubyxOV+Shss2kf4F8GFO9
	5WYm7tVrYMdoyaT8rcJ2kNUosTp2zW/O7ibigp0rDxzfxbQdn+tz4Nvtj6MUzubX
	QNPwhxN7zswgd2VMUHZkGlOxdHlezhh5g+RdNTlK46HMsX7X2ac9NQio9FJObBUS
	55W06g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s92u92-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61HW104513;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 69QN60Tr104472
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id C572124E4E; Mon, 26 Oct 2026 16:06:00 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Gene Chen <gene_chen@richtek.com>
Subject: [PATCH 02/39] iio: adc: mt6360-adc: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:20 -0700
Message-ID: <20261026-iio-v1-2-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX6rurqEPXYHwA
 9W0X6TqONr8I3Fmzz+aCjjzeGVktoUCtedHXLo2KRL2AVDzGWm3wyFU9fB27AOsWxOcZJ+GSG2J
 0eYyJ3FGwWr+61qo74t5WVzu/Kh1aPQyitzm/PbeNNpw3woQL/aa2MxKWhtwF8iJWhlTxgDlyRB
 quAHdnjoXBnUunqNn0orebopuUE8R+jiAtQiU47xGLP+rT1KjOF6FsL2tMGOLIMpP778WKHCaZh
 Yir2iyFJyAbZtpRxgUTOkuyVi3G4RKyiq2nU7c0zxL++QlazO2qKnfaRFSH2+SqD+4l7zqKXyjb
 WYWzwd3lzNQDqA1+1MGsUwJWSv6fetrNUN8HZd7vkEQiS3JTWAoeZu/MztXFWYUm1MtkV7qp4QS
 lCZhQAFKbebzSd800vf8YgPlmpAdmABFBFcIcfKsbcZ0NaVbKe0B5t0JEk7NzCioup6WtPEUd5F
 duN382h0IYEsXmmdWMg==
X-Proofpoint-ORIG-GUID: CuVTF_quUI8BkOnNi5PmZW6GNmQmnAif
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX8VPK7bzKMX+I
 4z6oWa4sfPNxvVc59usLzUJ0iwKFxSwf1E/FxpW8nRQrl+/hTq6yAs5hKrn4BvO641fovQMnAmp
 Ax8gQeYpExT2CA+Ajl1AXUOcbZl5VNg=
X-Proofpoint-GUID: CuVTF_quUI8BkOnNi5PmZW6GNmQmnAif
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=l0hiEBf7AAAA:8 a=4FeToGh02hxsbtXuL2EA:9 a=QEXdDO2ut3YA:10
 a=ynCB8LqupOr-u-Kv-6Up:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
which is on the stack and local to mt6360_adc_trigger_handler().

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Gene Chen <gene_chen@richtek.com>
---
 drivers/iio/adc/mt6360-adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mt6360-adc.c b/drivers/iio/adc/mt6360-adc.c
index e59b13e88aa2..a09e3e38c390 100644
--- a/drivers/iio/adc/mt6360-adc.c
+++ b/drivers/iio/adc/mt6360-adc.c
@@ -275,7 +275,8 @@ static irqreturn_t mt6360_adc_trigger_handler(int irq, void *p)
 
 		data.values[i++] = val;
 	}
-	iio_push_to_buffers_with_timestamp(indio_dev, &data, iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, &data, sizeof(data),
+				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 

-- 
2.43.0

