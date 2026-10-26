Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055975;
	b=DXd1WSvbxxHmqnsRIjtS4vFHCI31Ga0+rqfKUVGNoVJqde6BGqm2ICNILUERJ2AfJyxj
	 YkE4kRU3SeIrSAmD9la201VOSnYOZRoIWk6QDkW6YElxkqP2EniltqDBV3lCXTH06mlRC
	 MAfo4q6I7v/HCVAo5cqMqQ8oauZTp6xY2l87SiffeQ4guT0ff57EU/iEbW+Pr+maqANoM
	 iernf8xad+j5yf1TG8Xdz95mrGHOmRemp4vswFXwtAe3l+ySlSzZvLG8EDe9CACZ4em1X
	 E2phOJ58ivFAyZ8F579JKDB0bxLbaBseZvqA89pcLEPgQ8ZoRHzS3AvGbHCms0zzzDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cjYo6kydi5pKneRIM18Yg0wsanlp8v3vA5gEtJpspYc=;
	b=U7z1f+TTErTTvfBLFw/3WJJOyvry/egY8pHOybGSoxxdvcGKvnb406U/UQ690cybUh5P
	 pm6mVbWymX04Fkc3GjigmRsGfLuJh3PpP9r7OXzDuK7NgQ3IUqyiKA5smPTSYvqJLAEQ8
	 aN2XNhvXY2NvdPP1h/esdqA/Cl4HyAnk1zu8K94y7vDp8tBwLrh9Lvf0Th8O5o1P1K0Dl
	 ufOL1z7tts7fdS6to9ZiuJEm5LajywoHxCJSJ8tvQy8BLWn974SZRIZvGrpV5A/NSrJg6
	 UCj1MhKQp7VBn20k2UXOjcJbUM8jI9vPzQFfNvzcG6pRg1/OfIIH10Gsef77kPeQBrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J0X75juy;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F436606A320
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F436606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J0X75juy
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMOrJx3670905;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cjYo6kydi5pKneRIM18Yg0wsanlp8v3vA5gEtJpspYc=; b=J0X75juye2NHH0yQ
	rzoK891IKbugB9RY/U+7GGArgXIBZw/O94SxTwucUOOsYrUGFejm2CC9WBcgLv5c
	k1yEP6EkJhoBMUey7gKI6n2R64L48l8HouDUiiIXyN4J/SWnRQl0mbHYKDfiWkDf
	Psk9XAdvFkKCW3ZLSrxik2GU4CdUGL4R1A3N6Aqy9bjckw07q3u3uLP9YGLElx8L
	Aq9qp9o+MwgSklFrcsL8AnvfzQhlOjBK6kB2KypJWuTdOe6GD/5NteQ02HO/qInJ
	0b6JYzgHVhAyiPbtJycJ1myZ8gt33myUdyqpYyciaTah2YF4yEod+s/WOLx5/31l
	/JQKnw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj3u632e6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61WG168802;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69QN61pJ168752
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 811A8255F3; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 31/39] iio: adc: ad7887: ensure tx_cmd_buf is DMA safe
Date: Mon, 26 Oct 2026 16:05:49 -0700
Message-ID: <20261026-iio-v1-31-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-GUID: tD1SeAxUGZukOLUxnk5QyNDf6PaBKFNP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX5+GFtg/Qvj2p
 B1oX8OsJfXRm/78E6QBmrqiNpFRzsJoyg9x+UBfCnT78EujnzpRQIPFvY844Z9+cEswATilPfbg
 7LGFsXptMxyxPOf2mze7va+V9OI61TxROBNi+bdvBIhn+FEvfO/yuBJ+tLkRTHPTFX4OkSIeNXt
 6FOtg58ln6v36GDlm1EUAD2/2NO9W2AW2G+vPFv8PD3Q4I/9OKqpX0hUHiA4T2ujKDQPK6M33AR
 OjeX3KMsy+mScttJf9hI3aN8KqtyiEgeItzUDLpCtw4FLH/p0OxGr/qFHaVaMwvZqTrM5oNKzaN
 rV+fln1t9XV8pwxIqYTBjdyjKzM8NiOt5h4nwDg0AJ4sQS766IQDMsZLSFFnMC8sD1o49JILil3
 YIKscXg+ok6i8P2EUlUfvD6XNJtd+R9gcJYfggexKqt+rYe3qZhOemEeGUba5CBFpOCnGXn3Iny
 6lE9r0OY6P6bshxqT/g==
X-Proofpoint-ORIG-GUID: tD1SeAxUGZukOLUxnk5QyNDf6PaBKFNP
X-Authority-Analysis: v=2.4 cv=K823jCWI c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=TQdf06gSO3m8gusetd4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX/9blgnnUPcb8
 lGSlpcWyjksE2+boMuH7pn5P8/UzAc7OsZRTd/DxPiMI02I31MR824L8ORNaGmzEdLJFSR9Uk0n
 BZJUGFYJa2Jps7kwEF9hv0JwNS5euDE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

SPI transfers require DMA safe buffers. Mark tx_cmd_buf with
__aligned(IIO_DMA_MINALIGN) to ensure it does not share a cache line
with other data.

tx_cmd_buf could share a cacheline with data, but the next patch will
obscure that a little so separate marking used for readability
purposes.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ad7887.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
index 62aaedbce748..b1d9da19e7a2 100644
--- a/drivers/iio/adc/ad7887.c
+++ b/drivers/iio/adc/ad7887.c
@@ -63,7 +63,7 @@ struct ad7887_state {
 	struct spi_transfer		xfer[4];
 	struct spi_message		msg[3];
 	struct spi_message		*ring_msg;
-	unsigned char			tx_cmd_buf[4];
+	unsigned char			tx_cmd_buf[4] __aligned(IIO_DMA_MINALIGN);
 
 	/*
 	 * DMA (thus cache coherency maintenance) may require the

-- 
2.43.0

