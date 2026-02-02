Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575735F8A5;
	Mon,  2 Feb 2026 11:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031801; cv=none; b=G0ojvUuHy/dfsxXRE0QpUptETZQgkIs+CtHC4hPcvstTF+DoKssnXL+63e1EuG2KH/byUfZL+XkqpX/gInQsVzgihrgJ6bPOUNM+VlDKFNy82vOM346r5h5Y9vBNbqEVWp0xIN3gg0sIn3Gbf4ngcP08agfnq3GXDxfZFeua7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031801; c=relaxed/simple;
	bh=Xd4/Vbvw+DemSs498Rv7TkiehUN2T4vuTZAQkgk8/00=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gi9iBJ4r63U2NBCwrPUysyQNrO+pGK+83kLS9NR3w6VA+g5yhPKq9H6aEwCKyDBysuYCDSti+w/47ZFmpojjxiASu0X08IkpS3cHGxXzi1egGKyrXjeSeiemmkVAEKUWqUf6VdK+nR+p5zPTD6Rp9gJ+00T8CKVfS7pJReGyhl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rRa470Az; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rRa470Az"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6125uWR12221541;
	Mon, 2 Feb 2026 06:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0H2iE
	1hy6X/cSEgcOBely9+xLaipfJoG/oktjmJuHjg=; b=rRa470AzBr3c5WRHixwUI
	s9ef9j2D8EyyDLG5qlmoi4IptvvrM82rF2K5Vh9NUE7C0Pai9V3paITcRsgpy393
	FuMn2JC0rNTLpCkMflfTVmbhCYDmytvYTSMyJidIYDPbZpUpjrZ0JeDhGVLXcboX
	8FraxX+qgzbo6Wpn2H9FYfc1YtuVXYUkQ2lAA/1ahgOFZreKZMZ8q2qCkSYEQXvf
	0MdSeNJ2rwjKdTp3srlqMjxkbsfczKSNn+5Q+2OBUL1hGBpCEY3yQcs5XyyYurRg
	Zj6s5KYPBBj+uNgM6znk/+g6OjZpjyfPSy+p+Xv/dyDoRJaUUbP9STXTW2HS/VGS
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c23xgknus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:29:38 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BTbFt050163
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:29:37 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Feb
 2026 06:29:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:29:37 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK4D004681;
	Mon, 2 Feb 2026 06:29:30 -0500
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
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Eugene Zaikonnikov <ez@norphonic.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 05/13] iio: adc: max1363: remove unused requestedmask field
Date: Mon, 2 Feb 2026 13:25:55 +0200
Message-ID: <eecf76826cd3d1c91047f6ebd26fa495c36c1e62.1770030812.git.antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69808aa2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=t8eYkzJG07i2O4O3lM8A:9
X-Proofpoint-GUID: wIcIMCFAC4Ri18d8ZwEIRjygQ6wgVlpM
X-Proofpoint-ORIG-GUID: wIcIMCFAC4Ri18d8ZwEIRjygQ6wgVlpM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfXykIt1f/7puQc
 vRXPskz1pDsuSifAAlwYtmOQxohfnBCCUd/SUsNYflR5i03Mz9zp4DxjLxrLkDpNMbDwQvbJgTS
 /iTEsUtukyL8B54NtKm1r8vZDig7wV1BZA9vjpXp4UEZwwiq1RWX9lewFz2WRYo97oR/bSUyfd8
 g2nvaqDAttppdXy0lRFF5Whrw4nVkkrG5nqeSesQk56BXxdYADWCxysU/euDLoxo0AMCDlJEVDZ
 1gf3QIudVLbcFilkrXRNI8vJ+65f5ueoCMUi6Ll3EWLRgEB2VFfcgFI5TFLmlvUfZe48A6Q/Yj2
 W32vRwjHdXsWeblsTcTGZmbK1N0+U+cwkUG4fw8xrlcOfUV2ITNgvxiYFWdA0MOcHFtnLOrdQNz
 hptQWAHoXtzeSQgj7J3uwvw2JqzBg2qbQvlazTrh0WPnLSGjiPt4yL090QTV5Xz8I37NBY2BfmZ
 fqRFvX1+OgOGwc3KXeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020090

Remove unused requestedmask field from max1363_state struct.
The field is declared but never accessed in the driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/max1363.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 9dd547e62b6c..5e0666343fcb 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -149,7 +149,6 @@ struct max1363_chip_info {
  * @configbyte:		cache of current device config byte
  * @chip_info:		chip model specific constants, available modes, etc.
  * @current_mode:	the scan mode of this chip
- * @requestedmask:	a valid requested set of channels
  * @lock:		lock to ensure state is consistent
  * @monitor_on:		whether monitor mode is enabled
  * @monitor_speed:	parameter corresponding to device monitor speed setting
@@ -169,7 +168,6 @@ struct max1363_state {
 	u8				configbyte;
 	const struct max1363_chip_info	*chip_info;
 	const struct max1363_mode	*current_mode;
-	u32				requestedmask;
 	struct mutex			lock;
 
 	/* Using monitor modes and buffer at the same time is
-- 
2.43.0

