Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055986;
	b=3z4UZcZU/o5mcPVuF+vW9LhAjuYFk7bf1QGeyzFxbq/D8oAfbB/0/VG1x+6x7JMO0x3p
	 ooFu8ieczOSv4/FqlNUgdKYcN1L+UfMuziUS7W/3ncY2ri7VQHR5D+kjITho61w8MlAQR
	 P7jEOYnqpj/w9eVTnUmn0SMsAQfGpbCPZovNSGZNglWA713rzoFnEKmLksv3YAnoESPS+
	 PNQSslP2DrFRbuKCONyJj9ixVO0EQhsBIhCd2XnwDkOI0+wB46f9mKon05M+AwwOJcs/Y
	 12Sy2cMykJvJ4N2VJhZ2BO9fs1ruFwfTZDqnMRuWBXHkX086PY3c7yXkYo1EcEACmew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055986;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+9oZemjxAR94cv5ShYYEc2AIbFZjhKtSDTmvJOKukdM=;
	b=PcsLs9phTF306m+K08/C1BwHEq9g4vi14T95GbZQtFLkrMThkYg32vx6re1JhmguG7ZX
	 MbRusrD8Iy8Y3oq0AD0VQjr48XpI6h4iTtFFYdYfdP+F94F0eqRgJrUbZhmYgXZkSmN59
	 VrT91rdmNeYX8772Sjaa02Cw7eJ//XaLeo31foeHEYDMj+/kyKGTVJxqbPdZdgFGbn0P9
	 FkDxCLqZ/fleqQpS3dhWWNSx1QKHFLORXWo+n/b7z2aUO5fIBVbYXyGVp9C9sVDOWdyUs
	 5DRercrBUbZQBJyVyJu0ETfW0dqUmzWYx2hGsCq3O3OuaX4Y8ML4Cdsp/8Iy9C/KI4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tv0eDyZs;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06B606A33F
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C06B606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tv0eDyZs
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMPA3E3507557;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+9oZemjxAR94cv5ShYYEc2AIbFZjhKtSDTmvJOKukdM=; b=Tv0eDyZssl9Z/+n5
	Ka3+5EDO9vLoQD5Zcd70uJ6cYd95Lqy8qmX6Qdb0EkOSRoRTp8xzsGl3CYYThz87
	cwsW74YLDTGn/2hE+cAZO09N7YwKXwQLhefejyt4wI8jt40GcKEoZsg7nFobJlgo
	DZnCs1LkeLEJwURhRSWPUKgTMTC8rzL0mQFo6PHFGNA7JfppX15himfREnCRvMdI
	gurwVo21bQ+K9TJMINSlrEG9o2AqGthlWQrF2L5fflYSW3OxFwV9cRoYch/K0s1u
	rBOjHs4mqOhxG8vkn8HrhpLiy4wrgzkb6UP56mi0xiU/kY0lPs2LO4GHvigWeQzp
	HZh0Ug==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj8smstt0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMwxEF093004;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 69QN61lP104528
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 2243024E36; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jianping Shen <Jianping.Shen@de.bosch.com>,
        Alex Lanzano <lanzano.alex@gmail.com>,
        Justin Weiss <justin@justinweiss.com>
Subject: [PATCH 15/39] iio: imu: bmi270: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:33 -0700
Message-ID: <20261026-iio-v1-15-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: fKaxxImlMQ_f-uv6fe1O2bt1D7W2IlLy
X-Authority-Analysis: v=2.4 cv=Sfti5fRu c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=hVcwujEvAAAA:8 a=pGLkceISAAAA:8 a=RokopYCcAAAA:8 a=JOtKHld6Sx6Ce4fnoysA:9
 a=QEXdDO2ut3YA:10 a=8nkAGJGSpusVpXEkOM0t:22
X-Proofpoint-GUID: fKaxxImlMQ_f-uv6fe1O2bt1D7W2IlLy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX7P3gXHUZeipy
 Bq3vRw/anwhY4Gd9nQTRM0BMRG/0c8k/jy4rrfILqnafRuItImP7ZLp+c4srlZ6fSrFxTVPdjjQ
 M/NTeNmXVZyXXbFsoNIQkURLfuowz70=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXxNYbsAEcSx54
 fhulwt1TjRFHQuipkXOfMyc+t6529plYAaBDj1qBRCOGvLQGWkVEc8E4LejJo+Qel4mQsClJ0ks
 /ZVxB0v/F4FU9XxSuFq//3tXfi2aSf7IxHB/R70nGePxSX8lcY/4yzvW8deVXxpAG1aWPXzNPDQ
 d8Sz1aNQ26YmNenovjcCroWqiNAI3Hmggbcf/8W2gYhBi6x3fshS6wZJ40z9mzhoPs/8Kw5OMcx
 8Uw0LKC0NIrAaXFwS+85+J/Tda+gRfoNgwfQfCXB4Ry+pm27LI13eFqtH2ul9ifOgKBT+uMoq/t
 AMIPv87CX9/SyW20lyl+U0s2jvR2OMw3Qz3XQyAm7/BHLjeVD4h89o26Byz4dsAQ5TAvtKDUD11
 ZZ+n9R1Ezy8+ar5I1ANHzdL4hDJc4lRVKlygH2BoLOdj+ZKk2VO27mfTjUji1IpGX2QPSzK8qZI
 BnflF9NEUcX8LW3Ecmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Jianping Shen <Jianping.Shen@de.bosch.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Justin Weiss <justin@justinweiss.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index fbcf6bb87acc..83a9a96c3ca9 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -851,8 +851,8 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 	if (ret)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
-					   pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
+				    sizeof(data->buffer), pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;

-- 
2.43.0

