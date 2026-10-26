Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055968;
	b=VjbmEF8mvGU8dyooxLZ70vtqamj9LZbElYQmupRoWQFfYHrHuPEoolsEkRPwMvHRHY0W
	 NQp10eGEQidVFDE4cG2cR09jO3JrJ0ZRpN38G43/+2RUPo1WEicCgy+jvzWPUbys46H2f
	 EuCSDWwZWx5FhJifHOXkYi27nCazBaTYMOd5WSImAs9dT9LKTET5lsOK6ODZWNRaIvoBd
	 Y33g7OXgGk3m15Nqovs/dZhXmEoqmGxPLhqKX73XbfVgiPavA4PW3DKvrEyABA7VAkSxU
	 ACZydruCBgC91vOM4DRnNEtbRc6BohYpz7pXx+g5aKzEZkuC5OMdi0n2589b17dL2Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055968;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dQWbzz0XNDWNFy3VTUnlxcz+lc0yi6Bd6TwMy2Hawuw=;
	b=O2GriMnrCEy9cO61HWHBxRavg7ED3IkdzeTFosGskOJ/tmRm/wWN/rZC1MlaZIXmmdA7
	 62knet2rz+sGvr0v8wh9Jyz9A95QE9toYgxDxw35bvzKuIPJ4QU46UtrTdOM0G7dhV390
	 1RwywDwOjGdRIM6wZi4xbRfAW18rRi2wLTsBLC90kmxyyDZOuk/wOfo483iVwXAIQqsdy
	 /YNXP7TA9fub5RgtgsYNrAhIBNK62DsvgDAWz+x0+uyS9UE7zPNBoViPT+FNYVLdPt7at
	 /LAHMk7jXUQaSSg8vjtWzcnGibnZ5r4fqARYYec94d4ZUYO5LMSZQaJ6arxCnhSmapw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lIetB7++;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773B606A321
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1773B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lIetB7++
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMPIK6940551;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dQWbzz0XNDWNFy3VTUnlxcz+lc0yi6Bd6TwMy2Hawuw=; b=lIetB7++xQQW5W/v
	4OHKYxQA5EnjXgiOeHFpJNkEVLN+JPkV148pXbWgc4CBxA6JY+QrHSrD0U0H+GN9
	4S0/I9VrJkgkHSR+i9cNom45R0cfoxdl8RjdLIEaDbglpvfv89ZTYLyc01YRI+at
	HjcQPx4L/xBIk4F+wzsy1paHkGz/lhl0xGG7IrzYfhIeWvO8uxC8jUkZOnmCerN6
	DXLVnreYLNSWcqYao8bMy/YGtIARDntkDdI/Yl5tW+07G+rhkwRRz0cJMesg7AhB
	5uhdOe1RqaaFk/KhPFEa4PHnbLG39vhPOYga3Bgzrc5zOBmOuO6KghJKPiGOUObO
	8raw9A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4sf2ttv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN612a168708;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69QN61a7168678
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id E4834255F8; Mon, 26 Oct 2026 16:06:00 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 07/39] iio: imu: bno055: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:25 -0700
Message-ID: <20261026-iio-v1-7-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfXwbBZetqfvXez
 0tCGXbQjD6OD5yfFMpKhrMcoOnVXQBqCRfcjO2IMdHnjfpDGBmGy8GPdr4qs5BQ9S78vF0IW5kL
 gcdpEjdvWvtC9y3xNsLESzw2vWJQtdI=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=Hv9Ci88bD0fPPbYQgNYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SO5DaV9GLnsg57CRoLcTmAdkNLAEwRGP
X-Proofpoint-ORIG-GUID: SO5DaV9GLnsg57CRoLcTmAdkNLAEwRGP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX4Ou/GAcwfpp1
 LO80krgeLQWS8GyW8A9PYMwn5PwsqZWUxL4RBObgByr4zueqXL3qt4PvTOjVPS2kRDDiotqSmQe
 4CAw0agb0RxD1Ug1jvijsj0a7rTQfRwk4zwFLzT48YHDbYwLZU1pUo93UfU5cOU6sw8099PkyU6
 gV0gNMIYNIQMDGOaZOE0NAKsSMV2q2QhimmVJFiEX57cjveDUbSgeZuxD1jUxZqQ/vCtRkp94Ay
 z2abr+bpdK+qlkin1r2KwfC21FFXgWZbn62nwtpCuBz5MVljO/V/VSSOTNVjVtLUMo6BHm+8eSI
 pF7INT42CvdYAK6dmNeNRFuXM29o6hy25JE6YjppE2wcN1g+bzncMHfuJ5+339DTAzTE7TsWjN8
 jCISiXSPQCF+5351YqwBPwac/eJ4ZvVDV3i1cEeGU2cO+teT6es7fHbMNqbSabVIpeCSf8SpRP0
 4arnQnmI04MphdVN88Q==
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

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/imu/bno055/bno055.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index d0101607a9b3..b1c7b4f88bf1 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -1543,8 +1543,8 @@ static irqreturn_t bno055_trigger_handler(int irq, void *p)
 			       mask, priv->buf.chans, &buf_idx);
 
 	if (!ret)
-		iio_push_to_buffers_with_timestamp(iio_dev,
-						   &priv->buf, pf->timestamp);
+		iio_push_to_buffers_with_ts(iio_dev, &priv->buf,
+					    sizeof(priv->buf), pf->timestamp);
 done:
 	mutex_unlock(&priv->lock);
 	iio_trigger_notify_done(iio_dev->trig);

-- 
2.43.0

