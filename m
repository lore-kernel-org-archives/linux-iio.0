Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEFC306D3F
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163474; cv=none; b=uulvLg8ERqC3n+o6usGu0P9D1WOuxncMDUFL24kSMXhsj2gqyCP/98DBEwTwHqPeP7fw6N8Gpsq9THu3loPVwmeEBjcUGuvSB4Kws96OMI7j54/TYc48vbqGhN8A70jxCPgG+QhCpxuTorUyAxncpt93AzLNJjt5uKyi2IJCdDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163474; c=relaxed/simple;
	bh=QhuPHh847OzD4jqHWQ0CVPNMCBOKBuByjfxWq7nPBZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vb9hmw0odL83vJ57e0VCuuf3BOvGvG7q8NUqiZLxUuCDcShIOoKsdYgfn93Cedb8NxCkZykH9VTJjQtI7K6d+04I9DWp611xS+UlEWF39Ywq43U/L6GkV2KCP/ahOSN/mRl/kUmNcwq0KO+4HiYrGAQbpolfgjlmHeCAb2+KAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QBdoPBRf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QBdoPBRf"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0XdPf1242832;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=i/bentjlP1H
	ewLFXX10C20q9baQv9ts3WcAEWwwqjDg=; b=QBdoPBRfVdYhaPqnmY3hq8+I4yg
	oN5xXFyKGp2BAarq97HO/HLiEQ3vlprxdbRxrBGwggG8OfOSh3UzCZSEkgQ7iqE1
	1zQ8Gr/uLr0txIgwYfKe13pkKtpts4r+s3HwSSHv9grsAnAaY997vY+7jXYGJOtT
	ESA6476E/UyzFCAw7C0mAX/DdQHJGNWFYzMDPif6zlh1SVzYG64ZRRcER/wh0hWI
	q8m7LFutTf0Khyl8617fKD3gdIQih2EYPlrHwD5b7Q0Pm1X3UyHM7MXnigvf3udY
	TVgpDUHy0Vj8aG7mBikzR9Awkvn+7Z6q9m/KpNAK3/8gVR2ZY8SyYWkOw+g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7nmkbw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:47 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkFa018891;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 4fdxqmbjh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vkUQ018880;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 66G0vk2F018876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id 36DCB230E8; Wed, 15 Jul 2026 17:57:46 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 22/22] iio: pressure: sdp500: Remove redundant i2c_master_recv() length check
Date: Wed, 15 Jul 2026 17:57:37 -0700
Message-ID: <20260716005737.254577-23-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX+fpI9VtP5bJj
 Mm4H/vB9w/LGrftqKs8urOnDqXjvaP2SNG2XGDur91WQdezAZxpjL2jlDSRljIiPb24LadwhtIi
 hHyALheWWKHEg/mxkRBA1R8gvGPbXJU=
X-Authority-Analysis: v=2.4 cv=cuGrVV4i c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=Zi9zM5wXWtQWAm0VzwAA:9
X-Proofpoint-ORIG-GUID: t1uSHIlnI-0hT7Xy9w0OFLHPrOFMKcqO
X-Proofpoint-GUID: t1uSHIlnI-0hT7Xy9w0OFLHPrOFMKcqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX59WMKD4FdW21
 RbkaLQDR2zhFatckdsqVEwzdh8lfuQUH5uI76QK8l0LO7l+gYE7fjV4DoPihI0pZh3ONdu8IqEg
 VVJqa0PmbPkHt0wUMlKFAnNf9Eyp+aRxvYyx+EHI88PFVdxl6ETIwglvjCoGkj6e7fSQtT7wZ7B
 Uj/7eACt32J2itKRzE76OtRMLT26BAN5tgKGuffD2E5jrCwFYqGwHn5rdkf7ala5wgncp1YDy+Q
 xveI1kZdgkI89xd3EDP+H7nM5Mh7zz3TpG7J+vLagfz+aRcryjhaYqkvvrHD+poEZacDzsZFFGb
 /UZLQrb1nHmE+l6tkjxd0e5ubVpbWmD/tKKZV7gfqfoNYWTSD0jo5SkywdQkq0/nayvvHbir0AJ
 yzXQaqaiQeH3PjfprUbyK0xXo5b9Mp8uH28zFqZaKykOTo98lE6D3SJkYn7h6KitxcD3vTzZlgg
 xQNgQwJLuJwpQAQpwvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_recv() returns either a negative errno or exactly the count
passed in, so the length check after the 'ret < 0' test can never be
true. Drop the dead branch.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/pressure/sdp500.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/pressure/sdp500.c b/drivers/iio/pressure/sdp500.c
index 153f335ebf1e..f18b459114dd 100644
--- a/drivers/iio/pressure/sdp500.c
+++ b/drivers/iio/pressure/sdp500.c
@@ -54,10 +54,6 @@ static int sdp500_read_raw(struct iio_dev *indio_dev,
 			dev_err(data->dev, "Failed to receive data");
 			return ret;
 		}
-		if (ret != SDP500_READ_SIZE) {
-			dev_err(data->dev, "Data is received wrongly");
-			return -EIO;
-		}
 
 		received_crc = rxbuf[2];
 		calculated_crc = crc8(sdp500_crc8_table, rxbuf,
-- 
2.43.0

