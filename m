Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1B35CBD6;
	Mon,  2 Feb 2026 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031834; cv=none; b=KjTXG7VkC5nVtWITDnBRb275gFFcftw7gEuSty4Hk+s8luf5hMvLr0G16qKM2l7r8kZ6Zg9VKv1pFdfXvrp9ATZ7oHFRHNPqI9O1PQQO1GS3niJFlZYK//FDYgzEfVabELGg95CR3YaoE06M7xTL5jDIwaKnFyOfKRpQFPMjnGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031834; c=relaxed/simple;
	bh=vBcafRU0D6rRVpaHgFY/WwSScCAdyhAe6jlAqM+Oi9I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFljKR/1assk9tcBIQ9mSF1VLA52lsaGjCXhZrkVU85LLiK5hFYrScawlv1kiQehJvk10360r8U9FLxR8yXlJemqg7MMAqPPt8Fvi16PGho3USaUNIaeenm1jml29xz6e72v9j7/CSIs0/fCxHJYHG5Cl+Id242rIA9562TfCi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DNEY4k54; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DNEY4k54"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6129K9Yt348395;
	Mon, 2 Feb 2026 06:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=A8KKZ
	ScvIjDJZy7W4HYFQlRFgQ/p613RVmaa7fHhFFo=; b=DNEY4k54PW+LzfTCD+gKd
	3r1TX5c19MCxA545aw4Xpy6YA+m+59Aq+dv+BofwZoPH+vVosb0SfWjGuZ+YAbVO
	o5prPUeROFoF99JvTtiFTFxfgwFP4GwP+fVdRubnQ99kcMOacG3VYg11AIVh1299
	8Jji0EA4ITLeKfAtPEWGy+Bj17tJsqTpmvQUrz4c0kn0Idc7Czwk5pkQ8SFrzUvt
	ysl56jUc5P2YiTPHKOAupesQ6ZBCqiNlHYWqNY/LDwI7KWU9ojDMEQlAJFS3Bza0
	jGmMPXZiyny9sapN/UPAFfBLR3o5hzRoU8OJo5Z0oeydXPR1d626yo/sypqGUPlh
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c2b8wtp8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:30:11 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BUAKP050206
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:30:10 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Feb
 2026 06:30:09 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:30:09 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK4G004681;
	Mon, 2 Feb 2026 06:30:03 -0500
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
        Chen-Yu Tsai <wens@kernel.org>,
        Marcelo
 Schmitt <marcelo.schmitt1@gmail.com>,
        Eugene Zaikonnikov <ez@norphonic.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/13] iio: dac: adi-axi-dac: remove unused int_tone field
Date: Mon, 2 Feb 2026 13:25:58 +0200
Message-ID: <1c68cd01f4862b096b1a638f693b07cf1ee07f93.1770030812.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfX9EnzEUGBu0th
 eqHykbBKgKuHR+QmEML/e/z5QeYLl7NHU5ewmMmhPcpDqJ42fU7HuvWGfCK4ZN1ySQxcVEdIkO4
 5fFpjmDmPPM+RO6ev1Je5jIJyxrKFtHRIDvGDUeIU3DTjUC8375CWqULBpw/UjcyOF8t3FOf56h
 RekbLyRqUwqkvjmcccGh4a5wijsoCAFEb632UFEqza6/CD/uCJejoFForv6N/okrNarAhhzIN0u
 zjI/z5DTGmuoTTVNqllCy+VP0aYjo40uZTE2bCziFDwi5CYtQsLtrp889wrKcyfDhgk065tnHH6
 0t53jkKMYNEW+in3dEqWwL+8XCChqEbl1KUp+pV0YbrWWHltxZMyWFmnivSphovZ0E47fcRomn8
 GdALhkdMx8usKfmily7Ys3mkt/X0Pme1nb96qlz0G5Oi0mtEru+UK9KqkMukXBZ0RCIK0v8Aj2k
 kFN5NpfmJXxrqyeu/xA==
X-Proofpoint-ORIG-GUID: d_LY5RGVjlqAF5xyBI_q_LXEmo1VIghW
X-Authority-Analysis: v=2.4 cv=SK5PlevH c=1 sm=1 tr=0 ts=69808ac3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=LbWV5dLEJMo44prF9IAA:9
X-Proofpoint-GUID: d_LY5RGVjlqAF5xyBI_q_LXEmo1VIghW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020090

Remove unused int_tone field from axi_dac_state struct.
The field is declared but never accessed in the driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/dac/adi-axi-dac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 9cc895bbe51a..1ca725c5dedc 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -114,7 +114,6 @@ struct axi_dac_state {
 	const struct axi_dac_info *info;
 	u64 dac_clk;
 	u32 reg_config;
-	bool int_tone;
 	int dac_clk_rate;
 };
 
-- 
2.43.0

