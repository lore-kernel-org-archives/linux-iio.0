Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4083446C8;
	Thu, 29 Jan 2026 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707492; cv=none; b=IY6AfP/j4QjGCe/UTmWPxosICbjzL/UFcOBvuMbmlBVdjWMoWVMLjxuj1WkS0de3JfGcxp8erDMY7MI5RcqR1i0N3NTd8CoNiZ+weumCHHVcr4uwpk3d/T8F5nfaBkOohFppF91gxIQf8bqH26UriCaTr5NlmyficPzmHDyGb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707492; c=relaxed/simple;
	bh=pD0/Xriv8nWEYKRu0MSEifH+HR/w6bBWRJJiKS7lHLE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ThcdDTzaS/8aHAJxWThAhZVYr+BvNQwt6u46CFPz+Ru5ljYByCF8FNffKX/WkpXmH62SuFPLDBT8E+5aDGQwUnkolXeIrNRmI833Rv3aKyCtGlVeg8XnwyQZhkBEKOpf3onyGXH7so7fXWC4gb1G2UA2DBb4UvyeNCKaPgtyge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vdv0zcO+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vdv0zcO+"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TGXVnu3441980;
	Thu, 29 Jan 2026 12:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=tazCj12N4QEwLEt+pRJJGNmeoWh
	KfMi+B1lSEmGtOks=; b=vdv0zcO+pA2CssaIyHXeOawf6oZ3NgN+xuKO4eVIyr2
	dHjSDCKp9BqinQdhBpcvs2yC/yYjvNREccJKNM1LW1KgnshwaemLQnWxlNJpz8BC
	JS4Tx3uqWI+9NJNPoGhNCqfHjZKPGfakVrMOf0JCeZSKEedF99u0zEAnu/C6g4BC
	OVbrGA987jQHR3Lva81dmo9fot2cnuiLP//cKyl9/TlhkkVc3Vzr/88aW9seQscV
	N2ipzG7rO/s0T70qxIi+z3gujys98QLgTlSbC5351KC1SlVH6+ThpY4vkRSCneWV
	cMlrr5MDz1BeVbf2i46ZTUqSYMdW942ypx82ImTx5nQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4byfcdpnjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:24:27 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THOQwa055923
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:24:26 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 12:24:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:24:26 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THO5rm008516;
	Thu, 29 Jan 2026 12:24:07 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Fabio Estevam
	<festevam@denx.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Chen-Yu Tsai
	<wens@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: ad4080: remove unused dec_rate field
Date: Thu, 29 Jan 2026 19:21:58 +0200
Message-ID: <20260129172340.34216-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyMiBTYWx0ZWRfXwTm5nV2rZQJv
 PAoGXC9BRgswudlr0HdjRH7os7+w+SDj4gA4ITMqk54a89Xbiqw7H5nh4Cfbabr3NLV08vz7SE1
 uVptl9VghSU8O16BPxgtnNpNkIT30zze2kIV6fnKzI8DYmtbxFBOSGXP0mcJywEc9tifn11XZ7N
 l4vWnmrAzu2/Qioc30ekXRJn0IQoYLnvAaIoqropML/ZQg18oRPcJUX3glUgBnMhJMQLtSEXpuv
 RtyP3akRl4C6BTIUwumQr77762fptJk8RQglFC+aNeHlssF8Q2wlNAzmpQ/ZxNQfq0JG7XR+ZTd
 RyHMd0S6saV5OpYVgXlcqVu/JC6U2t0zQ88pGxPWo5cozXMUz5PhsyiF9LzLSCefZa+J0SX0wMn
 yRjUkxy9b90YQ9o6vsH99/npU4wQtQTepBS16sE7tA16AjmzF7+yMAGnGHDXUtta/WxgtLtVWzl
 EhodNMZtyfdlbGI50sA==
X-Authority-Analysis: v=2.4 cv=TqDrRTXh c=1 sm=1 tr=0 ts=697b97cb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=CHte9qzI6byktjQdVlQA:9
X-Proofpoint-ORIG-GUID: ersBYd7KxHTrGUSvdyJ_u10u90E2sRoo
X-Proofpoint-GUID: ersBYd7KxHTrGUSvdyJ_u10u90E2sRoo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1011 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290122

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

