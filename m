Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055975;
	b=4yuRJS5fyi+S3AJSyIrSZa1iaZAaf2noWfdYFKdMI7B41+xMaAQEvUZJWVg80WZyuqzf
	 aHOGdcK8AeMcPNBz82wWfgwnBl4eFku2q822FoAthI7pB+blR4ZmzXkP5heHbLQjmT5z7
	 Hw+bxumUXKan9wuoZmZoL4dIwy94+Sv02lJa+cTWPD5TyDgVcPbbs9e/tMdXx0HFaoVXM
	 VJlRxRsAAoDGiK6RAXz0kL6WIPMNp5RCc0JiU3bWun426Z1nGk5FEkqTdu2lFDD5yx9Qx
	 9BtpcciQ//rslpFnYNTxTlIJUBiiCXtStDDMmYfPsa9n5ZCpEFcGjDNdRRw6EhT9qXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Zn+6nb7zoO3VoSNI5tzYNbSpNsxKlqTFWjwuKE1x6mQ=;
	b=j9x0/7shhtsSlB3wRypEx7KUhszovin6/Ol4VwjbiX0ToBZriMaTcP5P/pkZejjxmQq6
	 r6E004jwfPBSf+6ntUo8HULMLTk8SQeFg05Lsm53pGbrtqVoKFkcg5+GO9gvvb+yrNbT+
	 p8wVA8+98wB1browjGIdaXWpmJOwRFhNkD/V+/9608PGRenKiRk0LBpuk+QrxGy8cmB4S
	 Cc0AtFEif77SSLmQq9uaNHYa4VJ9Cl7aGV6xDUlPTikOMjV0cfHc9JeZgXEfufkrisixy
	 hhhwsQ8iiXBDTKLpuMf/O/OFenU8yJBzAwdErEJ0LZ9w4ddXOR+0hStd7WrExyevNgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ve3DMf2H;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68912606A32E
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68912606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ve3DMf2H
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMOvvA4036474;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zn+6nb7zoO3VoSNI5tzYNbSpNsxKlqTFWjwuKE1x6mQ=; b=Ve3DMf2HB1Ok3dLx
	08RcTc01oO7dK5MRgcAiiRb9E/mLWpyWehtzxr7TfooiZWR+xVuluUGZ6hVHPNvj
	Kotp8AFYnog2+d1p03Ikw5cGfyN7YLtL2uwrL9BUA0VJSjbAPy2uTnL0XGRrv8T9
	/ora9kp/laTmLsf9suL2IkANHiYmBpR0+BPDDJOlb+BzvdZCeq8IyqjUwkiYxkBB
	ZdKtwGa0Vu0X6ZM2M28ydTRRpeP2JxMdohNE7LOyKVpRdqh401X8cmuI6d6pJQp8
	LIfPijW4l3mdEUfyqXm836m9+6neuABtrZrKPxWIgfXVOmJNwG93yMQb7OjinDVZ
	flxS0A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjbmm8ysj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61K2168765;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69QN61wu168713
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 403DA24D74; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Jyoti Bhayana <jbhayana@google.com>
Subject: [PATCH 20/39] iio: common: scmi_sensors: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:38 -0700
Message-ID: <20261026-iio-v1-20-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX/OLKQEWopzNI
 SvS8GR6+p7+vM93HnGyU5N5ajvxfvrhrmgTxbrRrClWP7vk/3AZdIy+k/S+JxBArzu1PM60pL4E
 A/wtYiVZ0TlhatxIW5voXA/FWNVvuHQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX20YobZ822oNl
 tx/LdSzW3ypeWX+Zxh0T6L+3Gn93AIw2eZUV8w7oouON5iYINNKeVXb+L5KHnOHkdXhfX0B1TNK
 XBa47laNowQYh8CLfPAvmuG2Z2cQN674F9fed2QC8byLpPHi3B9hWl6PHzV25WM2q8XKpo4plPA
 MA4670LUcL2gmuPM79HuYGUhi9UTIvoeF9IDG17Z/Jjk2rmHhJYugI5FjoY4m5Hh9b3M6C5EG7I
 UG5DjUVDFB6eFj8zu3k5jnM7I4IsdNLTPnUEmKzuruSK23DcXO1FKdj8kS+Qvi/tG/M3exLnhtF
 Rx9M4gZS70xvayCi2jK2HbhI6To8rXNod84/ASisDlYIuLchSpi1xASu87A/Ctuf/JmAdNpxpt3
 oFDbUABWhkOjfynAKuWAvhTFzfxPRG7pR46vVAAoPlTw0hSifrUvzGzNJUmt5CFwl71pultDQb/
 LeraDcEpUCXT6EpIhxA==
X-Authority-Analysis: v=2.4 cv=PrkG/AM3 c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=1XWaLZrsAAAA:8 a=dt-KJx4ILlnYdBRRFEYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WHqYpNcxLkaKJQideMzii4qL5LEvXulC
X-Proofpoint-GUID: WHqYpNcxLkaKJQideMzii4qL5LEvXulC
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

Replace the manually sized iio_buf array with
IIO_DECLARE_BUFFER_WITH_TS() so that the timestamp space and
alignment are handled consistently with other drivers.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc:  Jyoti Bhayana <jbhayana@google.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 442b40ef27cf..f488dda0e386 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -30,8 +30,7 @@ struct scmi_iio_priv {
 	struct iio_dev *indio_dev;
 	/* lock to protect against multiple access to the device */
 	struct mutex lock;
-	/* adding one additional channel for timestamp */
-	s64 iio_buf[SCMI_IIO_NUM_OF_AXIS + 1];
+	IIO_DECLARE_BUFFER_WITH_TS(s64, iio_buf, SCMI_IIO_NUM_OF_AXIS);
 	struct notifier_block sensor_update_nb;
 	u32 *freq_avail;
 };
@@ -78,8 +77,8 @@ static int scmi_iio_sensor_update_cb(struct notifier_block *nb,
 	}
 
 	scmi_iio_dev = sensor->indio_dev;
-	iio_push_to_buffers_with_timestamp(scmi_iio_dev, sensor->iio_buf,
-					   time_ns);
+	iio_push_to_buffers_with_ts(scmi_iio_dev, sensor->iio_buf,
+				    sizeof(sensor->iio_buf), time_ns);
 	return NOTIFY_OK;
 }
 

-- 
2.43.0

