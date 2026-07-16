Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D367C30C360
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163479; cv=none; b=MrZYWQ24R869WzKPGxF0mPX6btMVX7U+kEIMc/Z1FZIq5AO3sKVsXSIhfAmN5427UYsV9yLYSiodMUYTsoqiScDdN0l3KuZtZT9l8a7NOawmBiG60K3I2OfK6RSnz0osdrhxUsjHotkeDhl6ZyN9fjlwtvOy9GPD16jjjJgnnmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163479; c=relaxed/simple;
	bh=H8LeDhi8WPyddVEvptmpKMHfEeo3hOUdgoGAyYWZchQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtIzPcU1VnARj4H1DLlr6k0W+z/1kZGQORGX/3TGbXY8nQMpJVznDSAIkEvH39gDwiDppyTQ7wQmUf7/c7oPR31png5Hg6eClENIjc0m4D3zy9WiD6WCOGY8hIu47+xWU/l7dURTkb3SXX2adekHgR5RUFt43xl6lonLAvCE6wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WwQ44Hix; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WwQ44Hix"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0Xi951125124;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=L5TOPC1mffv
	9frNzaZH1/wRCCtOJjT8MP2qV2O7U8K8=; b=WwQ44HixVSazHWMv32Xp2qts6wZ
	mCXmHdJBixQ2C5APx3HRSzlO8kuJQ3JtbbnlwiGnkGE52eMPho5EUTv6Mq6YyrdV
	uc/vASCs2FwLJVWL5ENCmLLuN8zHqSJjbV7a5vuZJ9Yv3ZR4C1btTRKSX2MXbYie
	6IBDiXmVcl0zBp4SbO7u7bHOCCqLup7ycgp9vr7bpBkpU/1PgIyhUY/TeMRPj+UH
	8YIoln13FiE3mQIZtIVpMlGg/JdNDHxrTyzmDuJlJq7+62O/hVrKb8wgN9Ye8l0z
	pnVdSnX4wM2Id0QB5XU8OeWMSL4bbTP8wi05p4KWCDNoK3TlG2q/wgMU6tg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7q639j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkvB024343;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fekujghv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vjs9024311;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 66G0vjWF024306
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:45 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id CE824230BA; Wed, 15 Jul 2026 17:57:45 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 03/22] iio: adc: versal-sysmon: Remove redundant i2c_master_{send,recv}() length checks
Date: Wed, 15 Jul 2026 17:57:18 -0700
Message-ID: <20260716005737.254577-4-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNiBTYWx0ZWRfX4NOpa12UVtei
 2ePD8bHsaG47mQtA+Z/5Kr7nG7Zobe95lk4H8YFSw2QDjgAvo5r+LAt2lahvRnK/J28Sg23S+uw
 KPbr6LkXLPnXc8C5eq0qOh17imQxb1I=
X-Proofpoint-ORIG-GUID: o3qrBv7hxWXoKgBVzRYxd6IPv2U50Ecc
X-Proofpoint-GUID: o3qrBv7hxWXoKgBVzRYxd6IPv2U50Ecc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNiBTYWx0ZWRfX6VzDm07qTnYG
 WDbkTnWySkx1ohKk9gCi+jC4rgQOo7CJKUJTb3GY3fJZiC+mtM8Y0iLfoJukvDRuN8GdmCNAFhM
 m4r6enWeRGoVLAcO0ape5AiCJ5uHfrWq57VWADS3ZkBQHX7iM6fzz5Kw+yTTIqLWwZ2Wz2DzwWN
 CdA+DZib6xYxOmNaYyfM0dmbEhOYgoqhSbuZzK/PgxvCstOtS3knbQ9C3M4jBNI6iNMZGMRgqj/
 ixhXyfxfpcmxWi2E/q/dQebGpExpOFic6sK157vh+sbd9zMDioRh0Uiq6zGEop8gQj5qeZUbvTe
 LtCD/D0SJqhCuNx7E4umO2bq0B6bLmKn+gPfQD3u9AY0IgBweUmoykZiNjDJR54ZawVHXLMKhRS
 1NR0S7G6aLuSN8qVTFRfj2oGZrL1x2WD83Z5TzsZVcOavVRIZGmsmoW3dNl+pWmv2DNm1G+CMDB
 gXL8HSFWpz8ZaNT2TLw==
X-Authority-Analysis: v=2.4 cv=BajoFLt2 c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=o6EEbIThtCKiaf6DMF8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160006

i2c_master_send() and i2c_master_recv() return either a negative errno
or exactly the count passed in, so a length check after the 'ret < 0'
test can never be true. Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/adc/versal-sysmon-i2c.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/adc/versal-sysmon-i2c.c b/drivers/iio/adc/versal-sysmon-i2c.c
index e9a7629159ab..afdcc4e93771 100644
--- a/drivers/iio/adc/versal-sysmon-i2c.c
+++ b/drivers/iio/adc/versal-sysmon-i2c.c
@@ -44,14 +44,10 @@ static int sysmon_i2c_reg_read(void *context, unsigned int reg,
 	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(write_buf))
-		return -EIO;
 
 	ret = i2c_master_recv(client, read_buf, sizeof(read_buf));
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(read_buf))
-		return -EIO;
 
 	*val = get_unaligned_le32(read_buf);
 
@@ -72,8 +68,6 @@ static int sysmon_i2c_reg_write(void *context, unsigned int reg,
 	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
 	if (ret < 0)
 		return ret;
-	if (ret != sizeof(write_buf))
-		return -EIO;
 
 	return 0;
 }
-- 
2.43.0

