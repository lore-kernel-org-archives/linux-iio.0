Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81724362151;
	Mon,  2 Feb 2026 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031815; cv=none; b=XJA+Pp8ltFkmTcsIW7B9L1wKDzeg7DHBTE7QjS9N+xeQPHO+fL6Prw2upfhLrWcmA8W7Pihnw5COCi5/G8FbHn3YiQnR2rjxws3grN4WLZmwxWyRRMyX8CGGYh9kae1hz+Yh7ZhPpZ0/XdlluhH+Nwmu3X5c7meKvAVcbGGa4JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031815; c=relaxed/simple;
	bh=q2im5Texm2wqBPAgnjfh0xdBey0theibdw7gyPoi9AY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rd0rL2HJ+yMjUr3CCcs7RoDzu+FkVSThj75cDgVxjljRP6kaydE41JJv+zSV3KlVK1tTLv+deiV91KB9SgJUDwHrR1ufM79Y3HNVdBJcb1YQ0REXQ3AeZGJNmZC6y8HPpbNr95aWM3+wZt9WVypOAfDasK8a7Z7sNLNl7IwpVjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RU+6yUDg; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RU+6yUDg"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6126Tpgq3183972;
	Mon, 2 Feb 2026 06:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5Sg20
	o0DUtakFHTvHrjDTFNZG20Ewu5VN+LpV/K2Nbk=; b=RU+6yUDgkV6npuQC0ZelT
	/lwRkAh/IWa4sGVZ3HJhGyvTxNm3Oyk6hvQYYMjYncIGcuhIDAjXXJRDq/XqYckQ
	udUXbS/OjgqdUunf3SukulW98cnS0CSs94CNCZuupu0mgTmzN0D7R0omVs2kqFDA
	54osv+fQ/melPzYnKHKvoUVjtoG8WJl6eP2Sn82Y71KgkU2mCCwb9uRSIdzrGM+U
	aQ8Vi4IHmYAYYi9ZH/WQpGU8jNEIhVV7WYLYBEKs5pvrY2BSB5Qi9YWUpSCXA3Bm
	l1L3G6Zqt4grZrCYk6w6bQlsIVeA6AE1Cfri1K6k5bxxxSuh6fjlfAoQHPd7BIwH
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c1fh4x96q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:29:50 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BTnRu050172
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:29:49 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Feb
 2026 06:29:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:29:49 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK4E004681;
	Mon, 2 Feb 2026 06:29:41 -0500
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
        Linus Walleij
	<linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@kernel.org>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        Eugene Zaikonnikov <ez@norphonic.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/13] iio: adc: nau7802: remove unused min_conversions field
Date: Mon, 2 Feb 2026 13:25:56 +0200
Message-ID: <874d246f7da945c962a0d70444c649a0d7c4a4ac.1770030812.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfX7hbd7JSwBhbe
 7b4rC3QNNdf9Q5+D44K6jJpxS4mEJhzzd0BW2O04O0t/74HTq1K1WlXHKjCKa3K+kIdDAshnc3F
 RafH9kbsI+Lkjzr8IH6LSQdMMddspf/pMkAR2ZZbX0cqGWgAKjrBjbOMZ7pCiJyYPTBGJuJ0ctY
 LgXmiF1fGi0Q0gAJgjytP8BcTuGRVw6kMBleFe9p+3imWNQPm1vXZcFtkK4qrG5kme/yaq9QQTC
 7V3/dlcTyQXgJ9Jwnkch68cPsHm6N8j3FxRxULbeYSYqy+lVyicf0TMAPf4GWeebJUSzEsYzInA
 i8XUFduR+IdeQvxgxY6j0aY2kYWQL3Bdz2Ef7S/wpWoLKtyn1VaFeaGx4fBzOw6FrPZWHmPOcYd
 lguGxcXaB9Fx6Csx7zbBffvmdJdpEU+xZyNmAR/zyfJWtIEkw88F7FSJrBldgZ2fus+rSDP+RCO
 35PnFfcPwPlSt3iQmUg==
X-Authority-Analysis: v=2.4 cv=Vqouwu2n c=1 sm=1 tr=0 ts=69808aaf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=WVJFjqiBz9fkplPIqEAA:9
X-Proofpoint-ORIG-GUID: CF--Y3qHrSqaZBTkeI5_kJ2mTR9p-xR7
X-Proofpoint-GUID: CF--Y3qHrSqaZBTkeI5_kJ2mTR9p-xR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020090

Remove unused min_conversions field from nau7802_state
struct. The field is declared but never accessed in the
driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/nau7802.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index 458544cb8ee4..97e92c0427e9 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -55,7 +55,6 @@ struct nau7802_state {
 	struct mutex		data_lock;
 	u32			vref_mv;
 	u32			conversion_count;
-	u32			min_conversions;
 	u8			sample_rate;
 	u32			scale_avail[8];
 	struct completion	value_ok;
-- 
2.43.0

