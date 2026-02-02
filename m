Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B98362151;
	Mon,  2 Feb 2026 11:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031825; cv=none; b=vGbtgxareGoEcqHPN3xVKRPtn1/9wQMHe50x/SX2D9FXcF9fXsqPRM1StZvJMPETBQlskjd+/Zw7Wx0fjmPhGN2YtKJMuxAGeTpbgb63CnWeIMTAUXQ4zh3GRJZgMz8tpwT7LXdiUyPCNZEqu5aHrjO4yphyxvHVgmVujNMr2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031825; c=relaxed/simple;
	bh=3N45L+7bviop9K7E7AjN4aYNUtbBwDXjwts2ZXI0crg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sunEfp70IRsXjkNW+kdn6evm87alzmWJE5589sPGZdlBIx4WspIlVXqGw53u5Hvuh4sEjIBA7vf3d3JlVBX1gYSCMinse8JQw5TipJA1v5AyQ8htTQCD5lQtVsT009VDG5Y1v99cFUAM4F3vBCNP4n5DVaorVK8h9MZQj9XjB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bZG2fY6u; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bZG2fY6u"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6129JYdw002750;
	Mon, 2 Feb 2026 06:30:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0de66
	X1k6+6iw8h4HPNZuAwNKEd1c4pFqnD25VXTYGk=; b=bZG2fY6u6w9UJmJFzkqyP
	BMitV/6fAi9hM4mc/XrVlUSuOT+dU113Pd9/FwyERdP08vKz5sznPsufljcjayLm
	M7puLovVmUI+WOOOTeuv3YiWL2eAQV3Vq+lLUVW+qlh9jp/Wr0gq1mApMbodChv+
	2pV22ZY0c8WoTtyAIeYdyyuBPWNjjkp0ohOG7/kmUXxcKtSL4+N2F0FeVjLe/ok/
	dKCxY8bRK/EozNdd1eWl5yOIEuSltXKaVxqL2WygZc6d+btJvoafeklOFUGIaR6n
	wu9oODLfr2uTX8Tc5axLhfHVE42caeAfx3ypF1X2gmJ1X5ck5CQf4HZE89K3sVn2
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c2b8vtrhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:30:02 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BU1Iu050190
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:30:01 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Feb 2026 06:30:01 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Feb 2026 06:30:00 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:30:00 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK4F004681;
	Mon, 2 Feb 2026 06:29:51 -0500
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
        Fabio Estevam <festevam@denx.de>,
        "Matti
 Vaittinen" <mazziesaccount@gmail.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Eugene Zaikonnikov <ez@norphonic.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 07/13] iio: adc: ti-ads1015: remove unused enabled field
Date: Mon, 2 Feb 2026 13:25:57 +0200
Message-ID: <dce36df5a255d3db2408a1e4ce0191b88e354850.1770030812.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfXw32T5AMTEHCX
 M9kQ7xhObp6spi6trjrmqKKFUt+cSK4L0Bmh08VMsG07Hbj0QClbTf70zQXJWoShbOnSKMut92n
 1BiA2CRZTv8XxuuB1HM2lE1A1kro+FamkRmDvVPJQu9QDSrZblsJ4CwPoTJwy/RFzrCLPH3v2Ye
 KHWA/8RCxvLviZArvwfMPvaacSoUybMsWlzM51NiKCDyhfMSupOCuofU5sXYqyHOkq077s+RY9z
 q1Dz0ZUn2kt4p/N8f/e7sD+446qgqw9rU99m5Usu3uvcY8lDxC0/DERixkJ9JL5Xk1cntjJJn1x
 aAo1I8KHNeTBprlF5BPj7nB+ZcvSIhx99/80wuHjIZaNveu98LvwUePO9vHKG0S1trst9CocUHv
 NiO6EDB3nVo3pMMJk3Aj8fYVJV9Mm3oXeIcP5BRhjEHYXsQ+D1whL5ayGA5Oejv8Nls3hkij+xQ
 EIMTxgu+rYbkO+vcnzg==
X-Proofpoint-ORIG-GUID: XEHN8HOblv0fIUdl0SvRRPXlK-05uyDV
X-Authority-Analysis: v=2.4 cv=QptTHFyd c=1 sm=1 tr=0 ts=69808aba cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=iQSssSEnmO4gRBikR1IA:9
X-Proofpoint-GUID: XEHN8HOblv0fIUdl0SvRRPXlK-05uyDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020090

Remove unused enabled field from ads1015_channel_data
struct. The field is declared but never accessed in the
driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ti-ads1015.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index f2a93c63ca14..c7ffe47449e2 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -231,7 +231,6 @@ static const struct iio_event_spec ads1015_events[] = {
 }
 
 struct ads1015_channel_data {
-	bool enabled;
 	unsigned int pga;
 	unsigned int data_rate;
 };
-- 
2.43.0

