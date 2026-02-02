Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAA7286415;
	Mon,  2 Feb 2026 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031778; cv=none; b=V/JpbIHjdKUH09ZfTHXHC048Eh7xovyPB88rrPk5TZHo6kOIu9Aro2IfYRBnZZNaTq4XERxZjLy2RocYGFmItmiUQ5HNrHrbfqUNLCaOoJaIciIy1BzP7aB7X69Gvk6bOavOTQzC9FMvJ9Box1qQJewq781qRLdFWpM+CYp9Dr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031778; c=relaxed/simple;
	bh=wSecORGUhn/xjULgLIV21zh3YmjDXv9ae7lGzH5VV2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDyM54lLtk2uyur+Wms5Jd6DJNXvd5idzFquW2AapuCmVvrHfLDiXjrgozNG6gcCIS0yhwd+oshPqzqy/BST5PY2W7+lUFAFFOPAKuka8wDQhNddYUk8yilLstVQUXQFlXeDhiSb/PSv1MKG8j3jJTNWbEEnpR+/qFHTPXrRVXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YuR+NvDy; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YuR+NvDy"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612Agaux2221440;
	Mon, 2 Feb 2026 06:29:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lrMI0
	9jhY2KceJBAgC8OZm7erv4gZJUpX9Vuk3JwA/8=; b=YuR+NvDyxuSxVXxCWl02D
	8hvVg6J/r8NEnyrL4/CtTo82DKKIB/lgGll6TLUK5SgeQ3tF3Ysh48/KeN/2+4VR
	NgAcw4APhG6j3ENzN8xlT1HSbXQ3MNeu5BdwMxdHoCSX70i2CoCXvrpdLHGJ+0wS
	S0cRjqUgw4GvMzBb8bXHJiVOgKI/TvqBaimhVzv3RGDB0Gnw5fFG3KMqPHfzvmha
	DHfrwoiDIHQKhokCwD9f+LE+1yXcO6+DuQh/YygdNSIb9jIYYwyuaOjs/btJA5SM
	VuIqgY6Jp4DJmYoXwxf+2eF5bUCb4txJ6Rffysi2emXmlNmmlenvzZDVx0GG73UA
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c23xgknu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:29:14 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BTDL7050104
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:29:13 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Feb
 2026 06:29:13 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:29:13 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK4B004681;
	Mon, 2 Feb 2026 06:29:06 -0500
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
        Jagath Jog J <jagathjog1996@gmail.com>,
        Subhajit Ghosh
	<subhajit.ghosh@tweaklogic.com>,
        Fabio Estevam <festevam@denx.de>,
        Matti
 Vaittinen <mazziesaccount@gmail.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Sakari
 Ailus <sakari.ailus@linux.intel.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Eugene Zaikonnikov <ez@norphonic.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/13] iio: adc: ad7793: remove unused int_vref_mv field
Date: Mon, 2 Feb 2026 13:25:53 +0200
Message-ID: <36028a7bdd916602b9b69873a8562cdb8f6008e2.1770030812.git.antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69808a8a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=LbWV5dLEJMo44prF9IAA:9
X-Proofpoint-GUID: jqy-gPrXWkKncPT4xEo_MAbI6AoymaRx
X-Proofpoint-ORIG-GUID: jqy-gPrXWkKncPT4xEo_MAbI6AoymaRx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfXwZFbmI3mbyiT
 MUtOXxHOlIKTQKmfTK3HmzetaaGtNJN7s6FQZYccSaGLmfC4AHnn9rcvALFZJV1yA4i6OO4ruNt
 5OaBc9A31YJdeKjcmvOJViqavVhB0n+9mIj09hbpIOnE+DcwPplI4yHYDntRpKS+YRpRJX+pJgh
 DwIXX/OOls/3Sr+KYDmeJsP/ysxaED0sD3LoauKoVJILw245IMSUGMh6PWtbFKKGeCIIQfCt0w3
 Ou5sbOjLPVjUy/yPbNWS+Guo0tP7XGrmkydo9iiqwQOzzR9bTuQcsOKYLgGaKjaRenECNZyREaC
 UVt2BsYi/uJ2R0pQvPNJYhX9tSg6lRIdkuB+SlVu+Pitt6WzW6/SlknEZzmvrFsck3/JLz3JN4J
 vw6osMICOoZX7X+N21G+iMpr8LdO8xA5SDlzf9bQhgp1xUhUtmQbBVfPg/asZ0Buxxqpq805ZQk
 lBau3yL9CvS1/cMackw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020090

Remove unused int_vref_mv field from ad7793_state struct.
The field is declared but never accessed in the driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad7793.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index ccf18ce48e34..06317f5cb047 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -152,7 +152,6 @@ struct ad7793_chip_info {
 
 struct ad7793_state {
 	const struct ad7793_chip_info	*chip_info;
-	u16				int_vref_mv;
 	u16				mode;
 	u16				conf;
 	u32				scale_avail[8][2];
-- 
2.43.0

