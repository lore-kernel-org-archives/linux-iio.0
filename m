Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520736E477;
	Fri, 18 Sep 2026 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717024; cv=none; b=lIByNOAGn4C0lPvxJi2VKILX+BkJr4iIXq3j4arSneJWLOLjAL44DuuqVDrPYVo2w86gBkJcI8cvcprAZPWBN1VCMhz6sMH4TnppYeqz7gkhKREjP5oEpd5kaGrHzCRmGcmIP6fi+m3oyXudAyX/SnquGbUrQNpygN38hjrkksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717024; c=relaxed/simple;
	bh=kaCf1JN87prBH5H46VXgbn71d9g35Qr2/GG6rTHH5Hg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7MgqEFDlUCLos4PhIzM+sGHDKRA4cxMsZ+USB3HIwn102/ds8Zz7ScVw/rEM8aE+QSrJqoGtdiGXSIn5nogJe7VAUzcOzpaEnR7FJwt0/eCXjvTNIDywrbGwgHJDGrFV1Vqh3j+G+sxfgqIun2XX3EdtkIs5/QFUi2Da+VtDgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=urbTGLAe; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="urbTGLAe"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5w5543358511;
	Fri, 18 Sep 2026 03:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8PVm5
	0JCiHuBarNBJapwnIi2qWF2cnI1FvRDzyda90w=; b=urbTGLAeF6xmktJ+LdUho
	LBl738nnikJh9V3pLE7bcVqnEVQwc2hSSfEkTb0jcQuYCMP0qgW9vcKgXYZR7ydR
	76f8KwzXEKn7yULslt4jPWMJcpBZej50rLNcG5ykRxUH5Wye23G3Y2sRQusJAlsb
	M9Tm/fy4/50rR3GgdwyyHMbWvUDBIb3xycpRYZp7C5yhWuLIMOJQ5B9avWPagOIs
	6AP9/eUfrmqODfB5zzg+DMkf5NpF8Nk/5wlRTUMPkcmSYA12jZV1tsdgvKJvajZG
	4Azv/wW+keK58sGcBQJJsmL85VxXE1EtAy/dpLaaszL6Qn3y+vqe97U6/5JU5fJC
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gqj57vhv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 03:36:13 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68I7aCCc011023
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Sep 2026 03:36:12 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 18 Sep 2026 03:36:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 18 Sep 2026 03:36:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 18 Sep 2026 03:36:12 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.219])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68I7ZjpT019677;
	Fri, 18 Sep 2026 03:36:06 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Shuah
 Khan" <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>, Salih Erim
	<salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        "Jakub Szczudlo" <jakubszczudlo40@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 1/6] iio: adc: ade9000: fix ADE9000 full-scale RMS and PCF codes
Date: Fri, 18 Sep 2026 10:35:30 +0300
Message-ID: <20260918073537.1572-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918073537.1572-1-antoniu.miclaus@analog.com>
References: <20260918073537.1572-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfX4e+J16bKfSB8
 cBV+uTYvouvENOE1ShWGyiLfDKV+zHHl2/qpgIURCQBs377BFDXHRL1g31TfPzR3VgwQDfjyFxV
 4WGilC3T+Nsc+Mg9842Jt5WbXVws4m9noLBzsR/S7NPMLM7oPem2
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6aace9ed cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=ViKl6yswhRTQ_48acFcA:9
X-Proofpoint-ORIG-GUID: WP8XjiEnMNoXanGMZEDtcfRNVanox2nx
X-Proofpoint-GUID: WP8XjiEnMNoXanGMZEDtcfRNVanox2nx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfX6E33dBAKGmki
 DBV7JlOBkB0ysH7/+nxXH4GdbUMuAa8sXrNFZMTwMnDj49DvGe4f2SH/BPO+tdGjePq/aSN/eL2
 N3IP3XxEnKLJlNDN+4CpylyxTtlccbJRX/O2RZ8BihpORyuT37epItlaLJ8RDtWhJB/6DomGiMr
 bsMCvbF0+7wAMq9bvZHNuFUbtZPlxhTEDMHWhk12RjBRFFcW4PBxwcpFapXlDXtyDLRWuyZulVk
 174UYATP1y3drqQYJn3Huyk3oq7IbSwLc2op53CtB/rzUtui/ckS7oqXKkKHcvAD3dvoo+oURpv
 Fa+VAAPT0zHsHydFqo5LKZKeOjxPKKzevu/3xbdvD/uYoAs5Woc1i81d2E8ilLUPHa13ZdHx9Xe
 fFJznnNETcS5G2bvvBH6QVW1onbdb4aPZz8t9p+PpzvfX4k8G9u0sbaAPw6fY7u0nN7r3YmI9J3
 LoCzCVRWZ/E98tCsiCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180102

The ADE9000 chip_info uses full-scale codes that do not match the
datasheet. The RMS full-scale code was set to 52866837, which is the
ADE9078 value; per the ADE9000 datasheet the xRMS/xFRMS full-scale
reading is 52702092. The PCF full-scale code was set to 74770000, a
value that appears in no datasheet; the ADE9000 xI_PCF/xV_PCF full-scale
reading is 74532013.

Because the IIO scale of the RMS and PCF channels is reported as
1 / full_scale_codes, these wrong values make the affected current and
voltage channels read about 0.3% low on real hardware. The active power
(WATT) full-scale code was already correct and is left unchanged. These
are the same family-A values already used by the ADE9430.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- no changes.

 drivers/iio/adc/ade9000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index fd1362a98052..0f64bfb221da 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -677,9 +677,9 @@ static const struct ade9000_chip_info ade9000_chip_info = {
 	.name = "ade9000",
 	.channels = ade9000_channels,
 	.num_channels = ARRAY_SIZE(ade9000_channels),
-	.rms_full_scale_codes = 52866837,
+	.rms_full_scale_codes = 52702092,
 	.watt_full_scale_codes = 20694066,
-	.pcf_full_scale_codes = 74770000,
+	.pcf_full_scale_codes = 74532013,
 };
 
 static const struct ade9000_chip_info ade9078_chip_info = {
-- 
2.43.0

