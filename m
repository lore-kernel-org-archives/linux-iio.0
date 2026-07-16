Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C2A30DD10
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 00:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784163475; cv=none; b=WuTMmxAxhE9Wxk8d7oDEMNwh+TiH6VetHyn+JPBQslY0RjZ7qH0hGwU4wgo9RTyfcrSeByENbP/AcBp2ahiOz8F50hFTKluqegVcZTaCfWEcGim9dqEsBTNvunCH8tdaqtvOmy1J5kaxc2KdFWjZGigBx4l9iyE5uHSxijjAoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784163475; c=relaxed/simple;
	bh=m2oZgMPKAwNZ+vPo6p3EaB/cTxa+G2UZBFl5hnKmt8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qy1GDvy7OTvYJewGIOfwcs0u24bkCn2nfnROTt5x33pGFs9d0yTyOmH5TDaKnqCY0XdUgvH70q+UT4Ov4H4r9JhEvIVaWX36WpjzBo4Xhz6cSN74sP2faegIkQvPkxluuKNP630CGxrnm2ZihHeJo5GUx0L3aCb3OruUg4gtMmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VkZedKsF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VkZedKsF"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G0XnC61242993;
	Thu, 16 Jul 2026 00:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yXU37ZKsD6b
	6KJ36vgzW7OY9eouFz2SNaOUsHpPBpQs=; b=VkZedKsFWG0OvJ8hV2lt7mrey/H
	1qccBTrFieodad71RuuC/l7q136yuCdtKn23SD0hFj9tWiEUPKemsOqA5lqiT/sx
	RW++Zp/tYLxhHWnA4/Ia8rsCDORgmBs2H2oIvXZ+jxhKz+Adr+w2VsnG0AIKw+Rn
	2O2OycMNVvEW53aYLyHnuKN8ePr0H5S2ti8ORbOfmPtho0PrLeIpoVtCHndUGyKC
	cQE5bm+E5jXl8Kt67fKWfsCynOELkK0AkAWHluwXLquPdW4UjwoUBNqjq2aro0fp
	M2cnAEHo2boYUvPuZ9W7ZW7sSgnv3lvHVJOxqOXef2R9Ua/m5RwOHT4wRZw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7nmkbw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66G0vkZS018864;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 4fdxqmbjgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:46 +0000 (GMT)
Received: from NALASPPMTA04.qualcomm.com (NALASPPMTA04.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66G0vjFU018857;
	Thu, 16 Jul 2026 00:57:46 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-jcameron-lv.qualcomm.com [10.81.84.69])
	by NALASPPMTA04.qualcomm.com (PPS) with ESMTPS id 66G0vjlp018856
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 00:57:45 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4846927)
	id D4059230D9; Wed, 15 Jul 2026 17:57:45 -0700 (PDT)
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 04/22] iio: chemical: scd30: Remove redundant i2c_master_{send,recv}() length checks
Date: Wed, 15 Jul 2026 17:57:19 -0700
Message-ID: <20260716005737.254577-5-jonathan.cameron@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX4UkZ9riS85Nj
 xM9yLoObeDqowDwuENKMdmu1KGi/r+4rgVoU6DQP8HxkouHYDVrZM1Tejc6MUgbJzRqOTFI1Oub
 y9evvkQl5os5H/FGf4oIqVFHBBmmswE=
X-Authority-Analysis: v=2.4 cv=cuGrVV4i c=1 sm=1 tr=0 ts=6a582c8b cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=Bx3w5NfjrIkKNDwUZBcA:9
X-Proofpoint-ORIG-GUID: 0Y6EzpYSIUEAFYR6CF2PbRj9id3RbgWO
X-Proofpoint-GUID: 0Y6EzpYSIUEAFYR6CF2PbRj9id3RbgWO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAwNSBTYWx0ZWRfX8NAkcsbSKx5o
 m8OGfVnE3Ierh//55hHWsIS7DrvctZ/NhyzflN92UlZ+Y5U3FQ6IeDKeECgQHks6rpt6UW0aLgT
 MVC7XDc0bwJnxZKvAaLsLrxipPpHk2J5sdl8oSMPwQ37SbcYHX3kErpV0wffpAp9WHbzLoemie+
 cFpazyOtPmjQNcVCKS0PDpB28kGI9xNeGdx+Qshj6CWD7Y1kpeN/YRQzO9fdQZBrzT7D/IdNiqt
 Hp9Aq4OB4NLylARkXjSHfU+xW7QWjIxghwz7fdazJ1cTVAFlfQdqE5DASI0U3RFORVNO7QNdZ1j
 UgQ65LBuq3zDSsNXrAISK1ejJfQBODiFw+pNKijBb02KYIVZdzFW+iER0bXAfQQva8C/0vLCbNS
 AViHSMqNBiVqoQ95DDSMeMQuvOdgdncaLhNkNWFJwhg00nM9X042wdj9R72LgNifS1pP9qOSiMA
 0Rd+C/n2nT1K9dMMhjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160005

i2c_master_send() and i2c_master_recv() return either a negative errno
or exactly the count passed in, so a length check after the 'ret < 0'
test can never be true. Drop the dead branches.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/iio/chemical/scd30_i2c.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/chemical/scd30_i2c.c b/drivers/iio/chemical/scd30_i2c.c
index bcef1e473e34..78acc965b0f7 100644
--- a/drivers/iio/chemical/scd30_i2c.c
+++ b/drivers/iio/chemical/scd30_i2c.c
@@ -47,8 +47,6 @@ static int scd30_i2c_xfer(struct scd30_state *state, char *txbuf, int txsize,
 	ret = i2c_master_send(client, txbuf, txsize);
 	if (ret < 0)
 		return ret;
-	if (ret != txsize)
-		return -EIO;
 
 	if (!rxbuf)
 		return 0;
@@ -56,8 +54,6 @@ static int scd30_i2c_xfer(struct scd30_state *state, char *txbuf, int txsize,
 	ret = i2c_master_recv(client, rxbuf, rxsize);
 	if (ret < 0)
 		return ret;
-	if (ret != rxsize)
-		return -EIO;
 
 	return 0;
 }
-- 
2.43.0

