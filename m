Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055974;
	b=D21D9ybKGyPvkeOPkqAsJR1aC1faTtNTCg84hey6qz8CcC1YHMvwMVoB2w/BMuwSj4ot
	 ev7B1kg8jEw8s3IB20QawzjGG+wM+z//n/ez68/IHyHZDaWbGvpuugyhotIFTSKM7jKZL
	 8IgryguMljcPWSQDKZyL4lshKgUubW8yBWtdCsXsN2TRtuEhrM7OZrxRb7mits2ONBWzm
	 csDSPGP74o5FVewvIMUn2vNd8ETszg8eD7gLQgWIZPDD36MQ6S/Pprpp0jgUE1fbGZw6T
	 WGccagKH2JlNaUloDuixUcsFd6VYnZ0x3Yc3XynqFNLCKpqluNMAhYlfZ9THB+tvrMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055974;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CzJ07WJcbd89JBk8hmzlmczc/RO6zFp3Ce3wue1CrcY=;
	b=C3tGBk+A0Gvsg5mVl2O4/Zb457aq01/6SsMOHc9eoM7uoI4FYPoO3YpE/7k4fhl+eRny
	 b/6dH3kIxJwj9w6aai0bpbDBMzIBqpxOf9VszTFX5Br8+pxF8Tvj/PCDVDGrOuJRLwoS6
	 RgFS5pGs8kTtCqe4KFl2HqCZzOwUshFA3Q57Gs+xlLFHiKXWDirBLdfcXBlKPXALsgyas
	 j1GaVHPv+DD+GeIVKk9KIXsAUT817Ami12gUOJzsCnzCEKPBMUDuiruy5pIGk0jBEEQAD
	 hQTNUDyLomnfy3aWtTIYDmbNauOXhBW3lAROKrDsElb1iPHyFZNAxJc1gAbi6+eP47A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kjyWMCai;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E4B606A326
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3E4B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kjyWMCai
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP6LG869031;
	Mon, 26 Oct 2026 23:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CzJ07WJcbd89JBk8hmzlmczc/RO6zFp3Ce3wue1CrcY=; b=kjyWMCaisT3w9Jzb
	7wjIVyyMvOs8QvhnZStGTSEw6Ls4cyfoc8JSUuLoLlcBgzxKU5iXZl9QZr0+fgdG
	gvgk+ARf0ZDuJu8Hr85z0987ClauMrbxnMNVUodlheAgwu4yDRKi3q+EIEbGkOOV
	VR/UKC5wBmDmB3AoO7ka/86pIZr0iNP19IuGI9u8j+eMud1EgDWPy2oztxSJZ8zp
	BZoyDppK4uEjmnf9rbImo4hbaTfGuqsO9KkF2AR8hZ/mbxteX03DQ4rNbnT0xzXw
	ZJOFpGkbxsIOWvlAi7ZXmBiJpg8ItQ04egAEL/Ah6TZCRPUT8zmMDSbrrHpt2hs2
	m58noQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s92u96-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN06Ea249971;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 69QN61Nr259919
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 38F0D255CD; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Archit Anant <architanant5@gmail.com>,
        Stefano Manni <stefano.manni@gmail.com>
Subject: [PATCH 19/39] iio: adc: ad799x: use iio_push_to_buffers_with_ts()
Date: Mon, 26 Oct 2026 16:05:37 -0700
Message-ID: <20261026-iio-v1-19-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX6+HGKUAyn+qD
 MTieTvSPNvkk5sTwocMyTLOv4KspNB3YVZuPgkC8dz1X8UKHWQrS60fcgQ9himyT8krcdHRrUIn
 g2riL7nv3FTN90q3kHIHtfWd/xpTtOmVpgSENYi1eG9pbr+s1mV0uu6fctcCJMpp+2E3UOUuQ2Y
 zxc0U0ml6gRspV/EdlMzCaRCHDv7qloYmpsHwoWS249Z3V0FB+uk1b3idSe1gn+JvDYvFKYEWGa
 LW6NRiXjq2MbBm6FbIXeKtvyM7qqVIjOV9sdSdN2HDtZFDrvs1+fRwB4AQfyTjpAIDwVDpU2xbD
 BLSyajGebjRIxsmc0/TK/4mdWIN8hw+TpbeoJGd3u9cugQgAuI8aSCUMTePdPuXRYUjyqAkvBGU
 kEg9sTglyIWEaVSzI1lIq/BKsZD9Zkt1MIIXdYkBnui0n0uGItx/cCEqJS5KQjeYo7zfCteT54u
 9AJxlfGUXOC25lGoq5Q==
X-Proofpoint-ORIG-GUID: LUdiHPSr0sq6NZ-xLeGg8RbEjC4ZErbJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX9U+suK11DG9m
 rOlze/EptLunkGRt3FvBblJViytRo2D2JEaRXlX/XexMDsy3hup+j0SnUwQ415TV479DLL/W/Qc
 UoHQ97TIdUp7OPeaQTqoDhNgBwu5fvA=
X-Proofpoint-GUID: LUdiHPSr0sq6NZ-xLeGg8RbEjC4ZErbJ
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=nLSengjzdjwTzdvxm3gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.

Move the buffer onto the stack, local to ad799x_trigger_handler(), and
declare it via IIO_DECLARE_BUFFER_WITH_TS().

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Archit Anant <architanant5@gmail.com>
Cc: Stefano Manni <stefano.manni@gmail.com>
---
 drivers/iio/adc/ad799x.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index bb076d8f5dd5..2282535e21ea 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -138,8 +138,6 @@ struct ad799x_state {
 	unsigned int			transfer_size;
 
 	int				vref_uV;
-
-	IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
 };
 
 static int ad799x_write_config(struct ad799x_state *st, u16 val)
@@ -197,6 +195,7 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad799x_state *st = iio_priv(indio_dev);
+	IIO_DECLARE_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS) = { };
 	int b_sent;
 	u8 cmd;
 
@@ -223,12 +222,12 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 
 	b_sent = i2c_smbus_read_i2c_block_data(st->client,
 						cmd, st->transfer_size,
-						(u8 *)st->rx_buf);
+						(u8 *)rx_buf);
 	if (b_sent < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
-			iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_ts(indio_dev, rx_buf, sizeof(rx_buf),
+				    iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 

-- 
2.43.0

