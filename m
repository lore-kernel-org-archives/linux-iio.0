Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED530D411
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163477; cv=none; b=kUbVBNVhWfcQi4YIQFzAzVHw3+FYF8ITsOF7T2jPqNT9fz7FzSL2LkNEgBDfe3gk/meicOtvwDtmvSMOHZYXQUaJY+L0idt6acQSk/7TTp6RGcJApWqkC7DtFwATAFrrSbZGMq+wfI93qznLR233pjx32r935X3yf6ysdrgYjwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163477; c=relaxed/simple;
	bh=sTS2wqqSe1WSWTP+pNMOZEKlf9OLCUsRejXHsJN0fTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOS7s0YYDTrlyczlq11aHeWp+afU2hR4DoATpaeGf7uyDCIjhPtUIQA3yNyD9H/2EST0W36RuQ2cWnCfHk8fkuAaPT97g1HxH/LW3q3cCBSdihBUm0j1dQ4lWHyTgEXWLm5XXEgSQktNP86Ta2137WOWIrsW049SSOOG0ZQQJWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mxv/H7GH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mxv/H7GH"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0XgYK1005176;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=lor/eC6zPNs
	ZvUEZ5o1WDe1VAtuZTSOB/0AaGveHQuA=; b=Mxv/H7GHEL0uVTJFgvcIVQsmrOg
	eJw8CO9u3BaizKCTKNKKgjjmTHOifB1MK1xirqVxboyu8H71esPcyJoDQJ37Bnr/
	eh3S7lF60QS5Knwm0UQH4/8PBK0p1VkNScfJdO6XgvQU/gNu9gp54IefEsylL2UA
	yEddfuxqRfPUBIeRpD9Wtnu4gcZvdhy0nNutO6E2I6CsoraFOI2ZYnMnJ1CirNik
	M6q7uC7qjD8qHXIaUosnm5ULbVM1JpL6S4aBVmdnTDuB+1Q/hGomfwVorrxK9kXF
	CpaqZgVKfguzB2LO7niMDZNTFnZokFwKe8562tyAHSqquvUcPDr6Jv7KH7g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fecny9ybe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkmI022741;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 4fdvwh4exd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA01.qualcomm.com (NALASPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkdh022738;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA01.qualcomm.com (PPS) with ESMTPS id 66G0vkY6022729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 32122230DE; Wed, 15 Jul 2026 17:57:46 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 21/22] iio: pressure: mprls0025pa: Remove redundant i2c_master_{send,recv}() length checks
Date: Wed, 15 Jul 2026 17:57:36 -0700
Message-ID: <20260716005737.254577-22-jonathan.cameron@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
References: <20260716005737.254577-1-jonathan.cameron@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX3WZ/l3Mrpe1b
 stACujS5rxn4gfhRYY2XATnbUjc3U4R85lG2FHmJhvo1CUZL+aMDwnD9dPrOYr7Pb81BxEOsiRo
 DttnEGlGH2umGsUJ0W/7Aitx1V/vzCg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX5SEZu4+ev0/L
 Ktik9LyPCYwLJRtUq+/IartHaQYiMpST19TK0A9/9aeuOWFRgmRRJSVBPoggck32xxgerGX3WAi
 +gHbZ01ZrS+VaHmRKN/4Yh2LSBMhNz4Wu29squJ7c8zQOsSdo3mMp3a/YQ2oGrzWOr0IHQGIfy8
 o6iYBVmd8piZOSzjDhYGYyLoW1rOb5x2N5vhoSOAlKXXI6fMLa766G1bvPxwBmaIHqJgY0hBf/i
 OhpOYmuc62oDlZMEMJn8W0svbvi4toYq8DRHvix5DSJp2DzYp70+p8kYLNTbQZCWTxnhcJVp520
 yBFiXBKuJaqtwcQaq5NfOOeIK6WCEge+v/dsYsGQ0ad9rfJstEfLa3Zg/fnhxj9VloFtCqkC81J
 qXnKYqOYFbLoKRlHCALbODBDP1fycUwvinLT/CkKgrxoKD2jaLMM8qsCr4dkIOvdjlDyZoJjHP0
 Y0uAMfMk5C6OQDaKM6g==
X-Proofpoint-ORIG-GUID: WMuLbLuZGoCzA3lrzef6VEagPT9b45mW
X-Authority-Analysis: v=2.4 cv=Lt2iDHdc c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=Bx3w5NfjrIkKNDwUZBcA:9
X-Proofpoint-GUID: WMuLbLuZGoCzA3lrzef6VEagPT9b45mW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160005

i2c_master_send() and i2c_master_recv() return either a negative errno
or exactly the count passed in, so a length check after the 'ret < 0'
test can never be true. Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/pressure/mprls0025pa_i2c.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
index 06907b64a596..061d9156b3db 100644
--- a/drivers/iio/pressure/mprls0025pa_i2c.c
+++ b/drivers/iio/pressure/mprls0025pa_i2c.c
@@ -27,8 +27,6 @@ static int mpr_i2c_read(struct mpr_data *data, const u8 unused, const u8 cnt)
 	ret = i2c_master_recv(client, data->rx_buf, cnt);
 	if (ret < 0)
 		return ret;
-	else if (ret != cnt)
-		return -EIO;
 
 	return 0;
 }
@@ -42,8 +40,6 @@ static int mpr_i2c_write(struct mpr_data *data, const u8 cmd, const u8 unused)
 	ret = i2c_master_send(client, data->tx_buf, MPR_PKT_SYNC_LEN);
 	if (ret < 0)
 		return ret;
-	else if (ret != MPR_PKT_SYNC_LEN)
-		return -EIO;
 
 	return 0;
 }
-- 
2.43.0

