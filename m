Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5ED3624A3;
	Mon,  2 Feb 2026 11:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031881; cv=none; b=OuQ8PyXjsUpazNgE3mOBVehuLJHH/uvYzXsa1f6eHCRcP1+Cg2rmjaAA6mlCocy1B6wcGuFdMyUjlJWvHmo1q8il2cMxnaYde9m9mL0an9LV4PCddqYHyBE1t9lvLf1GqpzIADfuPq21ZSi1UQkSoDYUqgmfn8tAwbp3pdw7c+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031881; c=relaxed/simple;
	bh=50Yxh077iVWeUVgII6yNkuiSf0TCKnJ58kHCaaMayXQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jab3ZYZzAm99u3P1GEnJm8c7EbFnCj5WCGmk4LE+csOGGD0TeqN0G+2Lw2diy6Yu3Tfsu/LTtmNr2/XdG2l4cW23kVbQfaDzQK25OZKnTLdQVQ+DvLLpk4dqSaw+JZbYTkU5B5qXUzBK+SxIwTwu9GsxWWthQymkYR/G8cRqeLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CQ/AXL8F; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CQ/AXL8F"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612AgavF2221440;
	Mon, 2 Feb 2026 06:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dE/iE
	6AWHD/cjw8yvw9KLNQuvtltsp7htTYUjS2I1s0=; b=CQ/AXL8FvH/gOvaQ5HX94
	MJ2Ang+1swXT39gLOP19DPZhBM74er5KvDVFcfBS1c0qNVwRTjIhcNDivD8n3jEr
	HkEgDQ5m4dzRCWifmfDwogIa3gkXaUivtMw5SeFgVcPWWmdrXiBDCbkUwY1BNPvi
	K/BSEEkzr5/PKJIqlJQvMCMf62CZrOLV03/flmYUDq+C+yfsej8vaTY4BaZbNnFo
	+FORI+DQrn6GNEZXMJCbZVezZwM45yN/SjUsZWRCBHePm6uOggqDkR68XRrrVlL8
	ms6ovxIOBQX3tPOAfQ0u939nxJCjvNQTt7HUUI8GTvmGethLijshdWHcOIf7XHdw
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c23xgknym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:30:57 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BUux9050290
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:30:56 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Feb
 2026 06:30:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:30:56 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK4K004681;
	Mon, 2 Feb 2026 06:30:49 -0500
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
        Matti
 Vaittinen <mazziesaccount@gmail.com>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Eugene Zaikonnikov <ez@norphonic.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/13] iio: light: apds9306: remove unused nlux_per_count
Date: Mon, 2 Feb 2026 13:26:02 +0200
Message-ID: <91f35694110ba0a24124e8deaf37704825a908e8.1770030812.git.antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69808af1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gMGSIIXKAAAA:8 a=gAnH3GRIAAAA:8
 a=U6HZdc0VSqgv0MtM4OEA:9 a=ALZy4FCaHkhl-KKBbpRU:22
X-Proofpoint-GUID: FyXeoaCap-qtvcMjIYUEocRUFqAOUJIN
X-Proofpoint-ORIG-GUID: FyXeoaCap-qtvcMjIYUEocRUFqAOUJIN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfX71iE1A4U97Tn
 xhT16mtvLCdifztquqc8TPrUxHYnvjB8juIuoY6VKVM8WxN/ee/n9cv1XXStanBhnwcqQiRyrrH
 ZGScU/eDQeB5sDC0KA7Qk6kGM5UOSr/A/+fdTgzNtcx+3RBfganijnsq73WgiFdMJk2I28xlDCI
 SxB00j7AUd1Zvhxktg2M3DDQMolYhrOXsOT08TN3qqU8DQvrgxb0+LV3JPrrR3h7Bxt2+qHt/i1
 Hw8Nj369XEEck+7mVKtL3Y0rYLSjxrP4iaCdgBj4yEmshkLb5IRdv0G9OP2Kl2zMQyNCGCxzuI/
 4XDv6MoSGNWTlI1PILi+dlU7l1bwYwbGZSOS77KOzFOOHrn4zFAUsRKY1t5+JyzHiDUmZfpryp7
 lIf0WSWSBind58+zhqNFI2x/nXpYFr7bvQxPhSgAEkpvanLNcqmfeUzyu5KJv3M0RkZDOmJdHh+
 WQkYXs8D5PgyxIUt7Ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020090

Remove unused nlux_per_count field from apds9306_data
struct. The field is declared but never accessed in the
driver.

Acked-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/light/apds9306.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 5d18eabd961e..5ca4c87524fe 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -168,7 +168,6 @@ struct apds9306_regfields {
  *         respectively.
  * @regmap: Regmap structure pointer
  * @rf: Regmap register fields structure
- * @nlux_per_count: Nano lux per ADC count for a particular model
  * @read_data_available: Flag set by IRQ handler for ADC data available
  */
 struct apds9306_data {
@@ -180,7 +179,6 @@ struct apds9306_data {
 	struct regmap *regmap;
 	struct apds9306_regfields rf;
 
-	int nlux_per_count;
 	int read_data_available;
 };
 
-- 
2.43.0

