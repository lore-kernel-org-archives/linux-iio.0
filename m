Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A7E35E548;
	Mon,  2 Feb 2026 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031871; cv=none; b=RNLDVlANbFsVjRumPrMdp1r7GZ8PvfUDD3Fx4pnAdta897j7ydi8WD23J8KKKzOoLAJoaJi5qdJ4PHU57Yx1CNI62Ek618vgbMODcFdo9XT2pEcB9K81nwyKEJFIdfti7jxLk+yOEoeqGfvo1Kl/AaVmRnHXqjOeePIoPcd/UYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031871; c=relaxed/simple;
	bh=WrDvInolzOTITOVpVJtdS9rlV4+LV8ABv+WshqTpKtY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIbcX4RyXXaW79OJduLDWAcuRMM/6xuaNCIc9Gegnxnwtx4kCf7miZRIrugrUBOc6uUZHPnVLsuPSTSSQUhy2F3+48kYYn4nI0+phdol3vI53TBx+ZyOdQdY2SzYZDh/9krZMAlZcR71TumqstDd+btnvsOB35hnt8CluQm8x28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=B46fNv4S; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="B46fNv4S"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61262jcj2221429;
	Mon, 2 Feb 2026 06:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wfIpb
	IXpBchFjFOyNEK/LPnc4nnS1/WAaLzojJ5h6Zo=; b=B46fNv4SaIQ5J5OgtK4LI
	MgPRwn+gtRD0vL+01PpejFFgdMmBPPXFatrHznYyC0tkEHF2sZru5Oqi8BJOxRJF
	GUgVEnRAUB+DwZesRjoMBgOdfzYg78LPqCbDiXb76Vd0jGeNs3j1hNIfC5+4hgRm
	aZ9sXgfa9nSYejTwqUaEF7aD5eaNMCTHBMpvvaBbmVzKNGViVHG2maABZT84PoAC
	/0ZnLh8H0S0/meNXT7f2VO2q2jOwUyPnwwU6apwzH2eqoTTH7T0EhoiZXHDDBugN
	fsNzQVgYAz/p7kEiLZI7AeQKAmYe72Om+cdpk21WmMAyJApb67ox5DhuIOM62uE4
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c23xgkny8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:30:47 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BUkJ6050275
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:30:46 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Feb 2026 06:30:45 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Feb 2026 06:30:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:30:45 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK4J004681;
	Mon, 2 Feb 2026 06:30:38 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Subhajit Ghosh
	<subhajit.ghosh@tweaklogic.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Eugene Zaikonnikov <ez@norphonic.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/13] iio: imu: bmi323: remove unused drdy_trigger_enabled
Date: Mon, 2 Feb 2026 13:26:01 +0200
Message-ID: <682cb9e687d1fcf76eb689d7292483c91e3b5b25.1770030812.git.antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770030812.git.antoniu.miclaus@analog.com>
References: <cover.1770030812.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69808ae7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=PuyMK2twWGwiWQxPHbwA:9
X-Proofpoint-GUID: XH8RxgbQ0cW05My9BpXNQajB3O1hbJIX
X-Proofpoint-ORIG-GUID: XH8RxgbQ0cW05My9BpXNQajB3O1hbJIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfX0EmIv2ANTloU
 KDiafeWPOQv+Lb8PR2x9ZpEz1pER6LavbmP/BVY2atjTf8prCNp/yl0RWZMVO7Gd439lGixZTQH
 QB41ap6iasTNbwxITX8MB/mAGiiAml8x3zn4MEc+spGl4SkOrt5l+Tb3pEVB9jbScNhXMKnbR+l
 9/BCwWjkhDdnAP6y/hMQrMqW8YqmBR76x3pSo5DYcqzlZNNMwg1eJwgYoF85fPk0Ho/ab+sp2jx
 kK6ZsUYnYULMHB+IA2Cw7O5GV5Hg5RvbyYkOUrFOCbdklHNvYZBHeSAMZXlwhhVmlSVRvxJUkys
 VDCFB1hkM9ngHiupQxzbEzqinodR9bNZI4qUf3aPmMSAmO1b63aLOETc6/b9EpWSSiLv5WiS5MX
 PMXzdbvCY5TyWjqEYUPosblrIzfQoxdQEnYrEkPLcs+WPKQ2X6DKhYWXQN0yx3SDY+hqrH5Yzwt
 wKbIvPuIO5dk9wvGssg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020090

Remove unused drdy_trigger_enabled field from bmi323_data
struct. The field is declared but never accessed in the
driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/imu/bmi323/bmi323_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
index 6bcb9a436581..f3d499423399 100644
--- a/drivers/iio/imu/bmi323/bmi323_core.c
+++ b/drivers/iio/imu/bmi323/bmi323_core.c
@@ -156,7 +156,6 @@ struct bmi323_data {
 	struct iio_mount_matrix orientation;
 	enum bmi323_irq_pin irq_pin;
 	struct iio_trigger *trig;
-	bool drdy_trigger_enabled;
 	enum bmi323_state state;
 	s64 fifo_tstamp, old_fifo_tstamp;
 	u32 odrns[BMI323_SENSORS_CNT];
-- 
2.43.0

