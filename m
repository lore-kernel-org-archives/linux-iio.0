Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA6136214D;
	Mon,  2 Feb 2026 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031765; cv=none; b=bKqYNkg3wfoHSimbQAcCPL5ckW29ckuMvpUaWDVzvpIMTP+G98EkxnqcoERoAayFD17TY6OIHz4N2hO+Xx45g2e8kD2hjglKvPqgqGFrPX0ptnEJXumLoKJickIrGjrG0lPnq6DWVWqXfP0Isy9/APbSCctz48Xf+43r6ReHoQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031765; c=relaxed/simple;
	bh=pD0/Xriv8nWEYKRu0MSEifH+HR/w6bBWRJJiKS7lHLE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlojQY2QdBKl1uWSnakMr43Y9pnHbKGUdwA0XAE/2TjnS8w02YXkI01JdBSQIonvO0t4K4aBt99w02T9HuldmC2tL5F709n+jBnYcXR0lVFcF5ILQDW2t/OPxx1CgXvFpIawtqniVc4o+BXEwFr6O7+H8qDEMzd3+qTzfQJngzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TMzg9ZFl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TMzg9ZFl"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612B1Naq2221475;
	Mon, 2 Feb 2026 06:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tazCj
	12N4QEwLEt+pRJJGNmeoWhKfMi+B1lSEmGtOks=; b=TMzg9ZFlsRJHOM7SuJYX8
	Mm5F3pKuiXQCW55plmNILQ22DNysl0vrLzXSq9d6Rd8Y6+fLctnyQnCekWUkzfqj
	kTDQzK/LlCInvaEeTRCDe+HxqcLg912Del3JGIbe+alWF4viwbdpqfJbNv4nNkIM
	wrWqJq5+AvaLk4Q2SXxZmoKtAj8XYPiA8/jb3DgnSIS2+SNrAuKM/RILQhqPEJOS
	erb47wEcjmnRcCLzs7Oqa7+xCJ0gwIa6mHJwPu1Qvc7aKz5WYVm1yTYsAgsfFhGN
	sdnZpMFjQQF7k2H1lGmttWbSZTPK7Q1LYo8FilLaTt48In492crQYs8a15cifNhd
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c23xgknt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:28:53 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BSqC2050077
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:28:52 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Feb
 2026 06:28:52 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:28:52 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK49004681;
	Mon, 2 Feb 2026 06:28:43 -0500
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
        Eugene Zaikonnikov
	<ez@norphonic.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/13] iio: adc: ad4080: remove unused dec_rate field
Date: Mon, 2 Feb 2026 13:25:51 +0200
Message-ID: <58e212df2852368c7d6e45e4ba39ad91c66c260c.1770030812.git.antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69808a75 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=CHte9qzI6byktjQdVlQA:9
X-Proofpoint-GUID: JLF56EnaQOKZJZ2wUS2WOqTyU_gdz1xZ
X-Proofpoint-ORIG-GUID: JLF56EnaQOKZJZ2wUS2WOqTyU_gdz1xZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfXwtq+wK9p+vbS
 72/SIllYBbPQlcy8eEx+19J9i3kwFowndRn7U5gaxAVRkkMN7YDvrvtA1BEpmWh1Hx6QkHg0v7a
 ap2f9YCfXXZ4bo/7aA4ggoeL5e/6er47YskfAfETk9kjVOODr582lF3gLbG2GCrsPUlTpK7dUEF
 ehOXf2oPrumcI7G8Qa9T1B4fbIOXORk1dQbUwkZvws2keE4QGouJDEk8v2yxhcl6u4aiRctRMGv
 /j14bfHr4rNApUsTgNjivUXT83xXYxAaBUV6BtPzJ4rRncTTNqO6c8Od7PVPqkJ+Mo8PYTyaVyV
 4vqdtarSs6oQSzmtnfpCnbTE024fuonRjwBc0om6vLogsz1sEG2URnGxJ2896MD8Yg961cki3Fu
 0/1zagpTO4O7cUlqrGLzfBVVIsRmx9kUnTtCs1vu7Laypbc0Jnk5blQkTg+bdFbn+DXzIsDIZ+6
 eOFFKb36bDzZtjmOuDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020090

Remove unused dec_rate field from ad4080_state struct.
The driver reads/writes decimation rate directly from
hardware registers via ad4080_get_dec_rate() and
ad4080_set_dec_rate() functions.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 7cf3b6ed7940..8bc092969c18 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -185,7 +185,6 @@ struct ad4080_state {
 	 */
 	struct mutex			lock;
 	unsigned int			num_lanes;
-	unsigned int			dec_rate;
 	unsigned long			clk_rate;
 	enum ad4080_filter_type		filter_type;
 	bool				lvds_cnv_en;
-- 
2.43.0

