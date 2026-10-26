Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055975;
	b=aJ4nLDaOazEld+rlw4jufpiIa7+2/S9lcrMk3A4zofviEn2lnMDfHBuGuOY48WJFSZOv
	 +fcbgvdHATxXfnizIk/Orf7S5XA05xO6brGtFZPgJe3KlPkwCGqphmMCRZEqGfS7nYESy
	 oMSWEs9g1NhDLLciX/+X8ehLTXeIT8wHjFOlHE/tQrLLG9EOz/dDBd7ppkSfWi2XtMQ/H
	 4Cr2AbfBpUrzMQKa65A1bRMmcP9WJ4BQC/dXPuuF43cheXs9Uza1An70rPN5jD8ClxZzY
	 WCD6ak96UqrpyLJV+eIvVPGYn5XW0ZTYVxa4i8i3qnWCqLpBIaE4piFPq2mZH8JgDaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055975;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Type:X-Mailer:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FZOkJQvvEKVrX77mpFN1fm76JqPEDaZB+n+7a6xgBcc=;
	b=EmJXRoHB+dNjmpEC1gi98Rht6dw4H/9xpnSP3fM07Ueg91cPcJE1AL59Av5BqwepJzXc
	 1HYiA/VQAF2zv3DkcWFmqUsLfVvV8TvN+8BmsaYYeVtBpscOccx4lwGHBZRuUpHWepEJR
	 RlubPqOohre0y0r+2H7T6heX97L1T5LLSxUXVFMyYjWXHcS1mdsKn/7ozC5rxMZe3ICRn
	 3cgpyNHQtAVLZQOpLU63nOxFWZDHpMsQlvO6goB26SkOSXWUde5QDtGLnfCcySLktMLjV
	 3bBb6g3MSgGRhkIfISU2hhg0EM+5grE4KzP2CwhO53WNcHR1GCy+zaLlmHh4/hAJ3mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qylp4K3q;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BF1606A335
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 23:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1BF1606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qylp4K3q
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QMP0KU1439860;
	Mon, 26 Oct 2026 23:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FZOkJQvvEKVrX77mpFN1fm76JqPEDaZB+n+7a6xgBcc=; b=Qylp4K3qYUT9HP0k
	mK3BimC0kDddpNJOzVPd2t9/bfQgx58nS2cFMiEtVNfCXAF4Ii6cKg/Qdk96M5Np
	qmH0MVCEmXzsW5mQI91Z+kfqfw5Hf0Csz+qlhQ62ngXmfPSTS8Bhe9kaZFbqpjoe
	TPZLDVfucNYBNXD4T7MJkQLA8UNzALyRCxrUT24DT0mmVrdJwZk1kEOcalhzpD/g
	RwCh/L9aZ8NiF346eO7xvrBm5c2GBVpYvsH3QCN6ggUo/EuKru5KV9PT3922THbH
	ZSzw3rLR2mNZIT5PuoiNwXy/FLWREiSEysjAT/fdJTj8vlYLnuA9jzRDE0f/VlvT
	HNek7w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj53q2qnu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:02 +0000 (GMT)
Received: from pps.filterd (nalasppmta05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QN61Uf168805;
	Mon, 26 Oct 2026 23:06:01 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 69QN61qd168754
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 23:06:01 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 8C60125612; Mon, 26 Oct 2026 16:06:01 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
        David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Adi Nata <adinata.softwareengineer@gmail.com>
Subject: [PATCH 33/39] iio: humidity: hts221: align scan buffer for DMA safety
Date: Mon, 26 Oct 2026 16:05:51 -0700
Message-ID: <20261026-iio-v1-33-8b136778eedf@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX8Qz2NBD0KJkY
 T3cxib0FGv2BCekFheaI4PEsSgGlj3q/xsQrzZ6v0ft0hWmAwEVfGWzwLBEOS5DB+5/AGahpPPM
 /m5LRu8mwZuZriO4c2K6Cmaycxr/A00=
X-Proofpoint-ORIG-GUID: yLt4o8-KuOSbfi9_veDTExLz2Xz3OBX7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA5MiBTYWx0ZWRfX+VSr2BQAAMk7
 8Hmb2wIoGYjeDFQPO8SeMUkA+EvKtqqYCcUbfDx50pAyC8yR3aY2HL0rhslEI6BtBKdpB7Rg5mn
 NoBZ0NnkwS8Vj8qVU3SvRD0jfaSqUi9IDE1Ev7On/xIwv/aazfFuw0j5+21Ebk+asYfOQp8HSzQ
 ysKkd5yNLnWFbQXiugXUqlFUCBMGPyQ2Mje88/kiZZHztz5Jc7Bv/1V7yh4F3nWx6cfCVVNgDH1
 GyZvD8hTJ7eV2l+6GuF73NdICwCp7NnS85+Pfv5oDXxpBzKMxK3wlvFb6q5YZDlDNRnAMVb25KK
 g7+KG5zmY/dqZNf4+cLgq+4SlmN8BYUfbbWbGnmcOrdyaymEZgjwTfvdlHdAIgPOz8Uta2EVPtm
 +rdagqO2iVfe1jhBhRM3MrpSMgerM9QgRiWDiR3d9E6rzkyWFlU24HKKs8Y/fs+oQvGO6vv7LBb
 gFj4v8qPVwon47Md0yg==
X-Authority-Analysis: v=2.4 cv=D93SufRj c=1 sm=1 tr=0 ts=6adfdcda cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=T3NL5JDiHGwhr4KDO-oA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-GUID: yLt4o8-KuOSbfi9_veDTExLz2Xz3OBX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260092

hw->scan is used as the SPI transfer buffer in
hts221_buffer_handler_thread() via regmap_bulk_read(), so it needs to
be DMA safe. Add __aligned(IIO_DMA_MINALIGN).

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Cc: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/hts221.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hts221.h b/drivers/iio/humidity/hts221.h
index 0215f11fc35e..59ed07c308d0 100644
--- a/drivers/iio/humidity/hts221.h
+++ b/drivers/iio/humidity/hts221.h
@@ -41,7 +41,7 @@ struct hts221_hw {
 	struct {
 		__le16 channels[2];
 		aligned_s64 ts;
-	} scan;
+	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
 extern const struct dev_pm_ops hts221_pm_ops;

-- 
2.43.0

