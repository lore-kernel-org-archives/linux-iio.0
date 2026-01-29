Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3D93043D2;
	Thu, 29 Jan 2026 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695986; cv=none; b=V+BJyZqHrH/+99d3SHHtNEkhoFD9kd1FpZ6IGMF9M6uy9vOOzpDoXlwiPZ3nujmeEUJN4nFFSL/HWKbTfr82hOZ8g6JwItb8kHQKGZmtIIJgEcPXYd74091XD1iU3kALgFmFwm/qyL5ahrKBVuYjuJ40oChkEbjr9PTKk77YhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695986; c=relaxed/simple;
	bh=j74Zkv+15FakVlrXbs9Oq8UrWdPRoQxADhXfyx8ux50=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YPV7qJwokIo1wNrpoWY9DzgfBXD8gWBipkpEfMHwd6qxby9XOOS1fMYvSqV2pVFV4JCs2AJ0mfNsk0vNr8WsSQDFfMVwEEIYrlUFkGFuM1gWDIizbj096Ui9bTcFvbqxhCOAVOcfBFUPT6qiZ3dyB7LXNAg/6hd4jxCV2PLEab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kRMcOUzR; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kRMcOUzR"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60T8e7Xv2649004;
	Thu, 29 Jan 2026 09:12:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=q2uUl4LEr8V4Tv5zdtmHZ0KpMPO
	ishy8lfmy53y+2fU=; b=kRMcOUzR2zYZFD2ORWHJgb1Sp1KFRIxxAs4muy6gZTK
	AZZxa2D6JG1vOcIa1NSCUTDlJpnrT1WF8CEXYfwE/hYWc/cGdodCOGmQJvGW5G7E
	4usMExm7ZamG3Eeh9Sd6L4QA858uE4Dhr7UJHVQXl9pNpGOh2x2+9K3YSfjWWRRW
	RKe21WpCE+Dhzer/DZtk/2Su+hEewQOlEAm6QOExCJakVHSIo9HkGW2HtEIcsLof
	WalSQL8BSe7E+AtF+DJNUXJ/Mm/d/seQcE4r4rPmwowCVZ031Znfbpbe0k4oLV4A
	ydv6xTOrJq3ZbQ1dcs/lkgMaILgYMUpi6zOk8o2pCiA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c048912xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 09:12:39 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60TECc76033298
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 09:12:38 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 09:12:38 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 09:12:38 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60TECNWI031872;
	Thu, 29 Jan 2026 09:12:25 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Ramona Gradinariu
	<ramona.gradinariu@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Gustavo Bastos <gustavobastos@usp.br>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] iio: accel: adxl372: remove unused int2_bitmask field
Date: Thu, 29 Jan 2026 16:11:57 +0200
Message-ID: <20260129141205.106285-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDA5NiBTYWx0ZWRfX1u7idEMH4Hsb
 FOn+EEnR4T2Ro4kv0mt3FCwj6QiefwtGrwKrc8YTYZqHdEt6lE6gHLvqYXTvrsXVEiSxvNIc3YZ
 nzxD2JsOQSfUiP11zRsGib05d1qrQLDxmvQ30BoL7eOr8tbONgbMU/7Xd3sJx9BM+1DJNBfQen5
 qig5mVzfzz3A/m6QEcPKN2JmTt3UPzbFfj3ibd4qOH0noaao5Z3/D12O3eghD1dJeVwaOeHJEcj
 Kl5uTlQGLlBh7KzTFEAHgtqSp4XjojBntVJWDuBesJJ9lfCxllHptAEORZ6Ax6F8C+h+f9gSJvX
 qTu46dwcKNHnHGiF10asoRPf0BptuhuGWc43Im0wliSdXuLkCBshk4EH8zo8O8bUGguKj/ug25r
 DwneEqwc6CQhl5HutDhEB/7UIiQA/r+QUc+cJIpZCK7PAWpcxG5oW3w6qviCpNjDUW1NEZsukkL
 G2TysDCNNp893FVk6Fw==
X-Proofpoint-GUID: ObkwWiZVGa58Dw5cQcewx7ESb-PdBekQ
X-Proofpoint-ORIG-GUID: ObkwWiZVGa58Dw5cQcewx7ESb-PdBekQ
X-Authority-Analysis: v=2.4 cv=dq/Wylg4 c=1 sm=1 tr=0 ts=697b6ad7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=LbWV5dLEJMo44prF9IAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290096

Remove unused int2_bitmask field from adxl372_state struct.
The field is declared but never accessed in the driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/accel/adxl372.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 46d518a2a029..9e4e8c8d9e9c 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -295,7 +295,6 @@ struct adxl372_state {
 	u32				inact_time_ms;
 	u8				fifo_set_size;
 	unsigned long			int1_bitmask;
-	unsigned long			int2_bitmask;
 	u16				watermark;
 	__be16				fifo_buf[ADXL372_FIFO_SIZE];
 	bool				peak_fifo_mode_en;
-- 
2.43.0

