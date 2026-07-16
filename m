Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BF830DD10
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163478; cv=none; b=P47nTK05TFbpAVEs1p7kUJKphFKTx/IFc5YBv9WLyT42u1A8ahTJ1xslKOfwPF0IM2lojJ/DD1bP1eX6+npWQBzZCLLCoJVh9r4825X9DSVVMPPfWeFpEFoJNWD0eWoYpm1ySEI53GjXCcuMRtW7IlkLsXXfN1L99HfOp+gxJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163478; c=relaxed/simple;
	bh=9N/XixwoHQoMTJ8Gh9HOHsghRUNNvMuk4rZY3hTduPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANsnyxjqQ+b2XfzsmR5do5Ptdp+6390l1FljtcncQ+bgZwCQRqY8wHLOvwlg8T7H0YwdA/eLR7DljOkHODisWRP0/j0Es7nshSXzpaeuM16n9R7F7+zUUHvYJKG8EIYrf6kI6ZRXqLheMElLxfG7TtYyD7/S4dR+p5WjPTFwMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ISYjUK27; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ISYjUK27"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0Xn7Q1226896;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ks/91Cbnt79
	jDOgQVPdjgjdb0YrkDCMzpXzoBLd6I8U=; b=ISYjUK27Ym3lKz/qfgSbsjnVGKa
	80drOKFX7QxukGZiJodRzTtZxo/KZLpdoGcf9dTi1BM2vJqcn19DnmRBDWfhKALB
	2a4hPFAXutrSmyW91+eQXEPQbXL7WBsoLzwrogX6IZSDGUca+lOmmZvwSV+3D9h7
	sibqxfTBHmpJrcl3wC/yQv9AMz9yvKHnE9WLfP4b/sLvd5Ws7/QR2H5UqIfPRlvq
	YbRB2x9SGS2MyWUxMpIyZW4BKJgK68oM/I0DbfHe0PNFqQ6iDKOB+y6elXJwPnxs
	7LyQ1tU74etz/LAFjLhlKxMUMmon2G2RPQPBOd/r5l+N/1QCZzfdcX74/dw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feeg1hbxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkti024362;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fekujghvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vjsB024311;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 66G0vk9N024354
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 15CF1230D9; Wed, 15 Jul 2026 17:57:46 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 15/22] iio: dac: mcp4728: Remove redundant i2c_master_{send,recv}() length checks
Date: Wed, 15 Jul 2026 17:57:30 -0700
Message-ID: <20260716005737.254577-16-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX4LVkBKhtMoZV
 gpLvDy4YZcOWCulTM8PDmsOqQplAwYkEYM7JVn29LOPr5HQZrf3upb4r4r1ThC9GuPR9Z0/ufkK
 1/8yhwHJLlG+9G3/iQHB6BUMaGlph8/BWjuFVb5blT+WHexTJgAsCrJKtUHYqpJLmXV22oR/iKr
 GK+PMFYLgj/6oag1WkyY5UO5hwIHHFPQf3Pd8WFHNkb5fJ5OJUIFKHGPIjYob0kZYYWpsjp4KZh
 t2afxW0GKBcZCLseQmvldlnIqH5KyaLkEkGwWCuq5L7AgAy7BRS+mLx/pj++sCWmSBGAY+SvXeX
 n4uSbeoXh9GGfdhZz8Rz0VDqlnaqrr8FWBozRUmGV+ZLCKpSkfKbs0A0Ajv/4ukU6o5naB5EE4r
 T0AIn4RM2dAeLsmQptnyJ1Wj2DEg0Ha8/eO99hIuSsdl9J0fzBOL+MVsdOhGi9lLfdS+L4EjL8x
 OQJIrTGiWC4FViLfLmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX0EYkQGQxMznt
 9sDYU6ePvEQ+S0PXnQEsrLjadFfoNLY2V3GDTLAQGSwf/4wiyBgkvbLtV01NGcwW4/+BAibFAVQ
 KtE3Pd/0QXfStNmr8ufvlrGepkUBi9o=
X-Proofpoint-GUID: ggaffjKPX-5Uwh6yQAMjq-CsHazYwwJw
X-Proofpoint-ORIG-GUID: ggaffjKPX-5Uwh6yQAMjq-CsHazYwwJw
X-Authority-Analysis: v=2.4 cv=SsOgLvO0 c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=oOScWGzw-31QUCo9ib0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_send() and i2c_master_recv() return either a negative errno
or exactly the count passed in, so a length check after the 'ret < 0'
test can never be true. Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/dac/mcp4728.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/iio/dac/mcp4728.c b/drivers/iio/dac/mcp4728.c
index 1fe184d49fc5..c238bc572014 100644
--- a/drivers/iio/dac/mcp4728.c
+++ b/drivers/iio/dac/mcp4728.c
@@ -147,8 +147,6 @@ static ssize_t mcp4728_store_eeprom(struct device *dev,
 	ret = i2c_master_send(data->client, outbuf, MCP4728_WRITE_EEPROM_LEN);
 	if (ret < 0)
 		return ret;
-	else if (ret != MCP4728_WRITE_EEPROM_LEN)
-		return -EIO;
 
 	/* wait RDY signal for write complete, takes up to 50ms */
 	while (tries--) {
@@ -156,8 +154,6 @@ static ssize_t mcp4728_store_eeprom(struct device *dev,
 		ret = i2c_master_recv(data->client, inbuf, 3);
 		if (ret < 0)
 			return ret;
-		else if (ret != 3)
-			return -EIO;
 
 		if (FIELD_GET(MCP4728_RDY_MASK, inbuf[0]))
 			break;
@@ -205,8 +201,6 @@ static int mcp4728_program_channel_cfg(int channel, struct iio_dev *indio_dev)
 	ret = i2c_master_send(data->client, outbuf, 3);
 	if (ret < 0)
 		return ret;
-	else if (ret != 3)
-		return -EIO;
 
 	return 0;
 }
@@ -498,14 +492,9 @@ static int mcp4728_init_channels_data(struct mcp4728_data *data)
 	unsigned int i;
 
 	ret = i2c_master_recv(data->client, inbuf, MCP4728_READ_RESPONSE_LEN);
-	if (ret < 0) {
+	if (ret < 0)
 		return dev_err_probe(&data->client->dev, ret,
 				     "failed to read mcp4728 conf.\n");
-	} else if (ret != MCP4728_READ_RESPONSE_LEN) {
-		return dev_err_probe(&data->client->dev, -EIO,
-			"failed to read mcp4728 conf. Wrong Response Len ret=%d\n",
-			ret);
-	}
 
 	for (i = 0; i < MCP4728_N_CHANNELS; i++) {
 		struct mcp4728_channel_data *ch = &data->chdata[i];
-- 
2.43.0

