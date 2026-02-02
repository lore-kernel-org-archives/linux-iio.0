Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3263624B5;
	Mon,  2 Feb 2026 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031893; cv=none; b=UdHFjaKTZ08V3psA7dwTjb2cdF5fz04+BNACEnHhu31D+sz6Zyr7gkSFP+rMTr+dRDCo4d3IV6cXZ/9WH5C5zmUp93oCIxKdQGtiNWMR7Hg+dLbUhF5C/8eEsXhAlMsOmvXuqKvnuKyX0Z+FBx4YL8fiOeHDtHQc0KZ8ULWUEQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031893; c=relaxed/simple;
	bh=Qt/okT3pBW5HKxmqHe/n9fcnAGcWs/WRbYX0fr0jyKU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u12WTxuVTaLcFfBxVGMen1d5fVx8o7pZ9/inlQGHQoyucVEHVznFgkrKlC5MJbISPDewPeLVq8MGTUesFg00Pl8uF5/UrH3/8U7chLZPkOSaC0DiNqPW9dK8IF4IucSvr8RB9YOBrunJPLQjl0vnDc4zoNnDQ1TXvAei0LXVThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dV4Vkb3Y; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dV4Vkb3Y"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6129gnXh373029;
	Mon, 2 Feb 2026 06:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VVVAn
	ilNesagY0p6CeeeozX6bNfebk+wyapykPxfP4Q=; b=dV4Vkb3Y8/tgoKZtyVzwo
	znzzH2egvEdX8GaMs1OChF9GMPbuqYjPtArm5VH8XVVAMXVxReQjOc/XcSETcTbL
	SSvQSkJKyDUgeXx97o/Y+NOPgym4+KemOilmS8ync4oviEYKkj+KpEwtQnTfLxRJ
	mRurBhaIm0ypsWJ47D0GfTMMC0XB83Gh/XV8RiWS0y2UeVZ5wzng8hgI1e7K/vXS
	SQA5f6tS/1wRwthy0ET3m1rSb48LfFX8WPNKkRwVWvzgmTlbG77lG3G7C7vERKIY
	MjhxG6YHzDmdRrdy+yW44U2ALt0kb6LNzIUt02rjkuiCIMyP8H3ioBWQaWrbPJCG
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c2b8wtpbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:31:08 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BV76Z050305
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:31:07 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Feb 2026 06:31:07 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Feb 2026 06:31:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:31:07 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK4L004681;
	Mon, 2 Feb 2026 06:31:00 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Subhajit Ghosh
	<subhajit.ghosh@tweaklogic.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Fabio Estevam <festevam@denx.de>, Chen-Yu Tsai <wens@kernel.org>,
        "Sakari
 Ailus" <sakari.ailus@linux.intel.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Eugene Zaikonnikov <ez@norphonic.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 13/13] iio: light: gp2ap020a00f: remove unused debug_reg_addr
Date: Mon, 2 Feb 2026 13:26:03 +0200
Message-ID: <b7a1d6d2386dc7bc899b5cc6dc3cfdceb79ffa2e.1770030812.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfXz727aenyCT+p
 NNdEElP0E0q9oz3i+UpwygfGsHFMEg18qiPfgKJ81Aqo1GBcJBKOEAg9F26F4dNwJycGkygRhS9
 nkMPTA8gsT9GiiHXy4WEe6Z7nQ2S3+1vwIkxZPCVffIVQ8HbTt/bTJosJzKVuKVjHDwkpQYzZNQ
 VlZr0/fOx55C+wPk/tgCAUO1A9vMzS626sEXG4q8L2emtbTbrXP5NkjqFkJXELXsWATBP/iFPqy
 /J9POOWsLdw0XySfKOwcRXTQq8N1YJy8iWeoC1J97tv6uvDmfRdQPgV2AU3a7INIj57t9L0HSW5
 yHCOz54EyaL8vNtfVQZMc0ZgHT7pHby02O8IuAd1r/4H/rmnfGH7lDipkXTH7SsmetnO1qYPPBM
 CxyzBdznoON71Rk3M+okLmWyE+NMM3g6z3r+iZVspsP2RaVrTXUEyXqW1VE8wDXnwp27PpRvFCU
 s30XN8t1UECosdgG1/A==
X-Proofpoint-ORIG-GUID: 2yKkUWeDz6gZ_tfgqYvBtn9mpkwY4k52
X-Authority-Analysis: v=2.4 cv=SK5PlevH c=1 sm=1 tr=0 ts=69808afc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=iQSssSEnmO4gRBikR1IA:9
X-Proofpoint-GUID: 2yKkUWeDz6gZ_tfgqYvBtn9mpkwY4k52
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020090

Remove unused debug_reg_addr field from gp2ap020a00f_data
struct. The field is declared but never accessed in the
driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/light/gp2ap020a00f.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index c7df4b258e2c..7cdd61db7096 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -246,7 +246,6 @@ struct gp2ap020a00f_data {
 	struct iio_trigger *trig;
 	struct regmap *regmap;
 	unsigned int thresh_val[4];
-	u8 debug_reg_addr;
 	struct irq_work work;
 	wait_queue_head_t data_ready_queue;
 };
-- 
2.43.0

