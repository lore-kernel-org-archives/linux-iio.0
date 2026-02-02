Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3024F35E548;
	Mon,  2 Feb 2026 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031848; cv=none; b=Mz6JRDclkt7Zzc9tFfBfPU8n1kOQC94IWZl4pz0zJCBIP/JShTxhC4kCKzRno7Fh0mx48OoXNCRifg16PJlibzqBu7Y6biB6w2OBMXdvStTAJ3yKuGja4lrg/EYjUa7ghhXgLBgRvLBvQ6VDCTLWOJAAlr/1kmDOZQQwSwx2nmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031848; c=relaxed/simple;
	bh=IkMbTWNxe03tOoMnPt5EiHgSOChjZNAkK6NBvanjgbk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LJTroM9OyT/uSoR/EunQC2chKXZHYdypFaHy7J/xIB6cttCR6LbfOp8vm1diXqzL0uQxHFSa9+lvIkIZsf75M5RItEdsCNBP4ag5mqHoge0zGNir1HVUXjEAm6wN2bJf0nrYt38x9WlktaQ9/kKlZBnVk2ONmTV3sthJ95c/m5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=civdwio/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="civdwio/"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6125ij1g2221377;
	Mon, 2 Feb 2026 06:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xnYpa
	tKOarF1sN/h0GAdyVnLANogtAcfEcm0LfFdftw=; b=civdwio/r+tXYz9Fp9OWN
	kxeZFADIiqXH0kXD3wXSdWd7SG0GVkwsFqPEiU0i8m5EnB6rhKmmyYeXf7VVVnvq
	H9Sg5eLv9YAU3w5yO7DLN8L93kogYMYi2dJJqIx20QEVYbfLemvqoJpOKr6i+w5B
	xxfzryI+f3tHu8rpgcfUs+e/RWAePLK7ao5/DnL9gfw+q1KB6U5vop2726TtUQWv
	SA7edE+3TkYu0UXDT1TviA/eTdAOzy4ErD9BDhH0uYfed5agXAYzRzEvHKC2DKnI
	9QYdx1Bkv0qaen7jRqM4t88c8h75K8X6IaWRxsBEBCNR0BllEHDbMnJRBf1sfKwf
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c23xgknx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:30:25 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BUNSY050230
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:30:23 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Feb
 2026 06:30:23 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:30:23 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK4H004681;
	Mon, 2 Feb 2026 06:30:14 -0500
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
Subject: [PATCH v2 09/13] iio: dac: ti-dac5571: remove unused id field
Date: Mon, 2 Feb 2026 13:25:59 +0200
Message-ID: <faf415641152977fa19a1c54da6cee42e39496a5.1770030812.git.antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69808ad1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=a8JB4DYtp2rSZWCOx_wA:9
X-Proofpoint-GUID: WwwEuC_eZVOqv6DrWsPePA-Ia_RvO5BN
X-Proofpoint-ORIG-GUID: WwwEuC_eZVOqv6DrWsPePA-Ia_RvO5BN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfX6Fj1TCU4261l
 t5y17L2Aa832+0zzJFqhsEKxPICONY4dFHQOodt3uXd/pHoNWiTrjjkSOFe0G0FVt1Z0R3+TLrQ
 DA3a651552Pb+1K8rQA3P4dUWg7dfys2kAeDoU51z7mLOLGyVd4lnFNc6766TGvZN4fP5KH5ACq
 6D4Xm8oHwEbsKQyy7LIZ03suT8uFqKT9TXpG69/UU5x4XciQynamPn6bZWkmSyxYWHaXVomBmxe
 7XndPl1KqfJ/N64VYEArPfQX013Cwia+b07NkTWxh/DQiAbpD/4N5tR4Qr8EJvBFl9D8L0SNMpz
 Et/QWazEXWbbM6XTf6hABcEwQXxzndT1tFgXamO2M47q0L/NIrjkYKW1NJ6Z505g7V9aiublBb2
 TjJ3x9QIOi280uo7apoBCAvigTYsO3c4uoug8joEx+RWGG2/+3fVCCsPof7PxrR3et1wqPyYDuj
 K3lT5+F86Rly8YzHVeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020090

Remove unused id field from dac5571_data struct.
The field is declared but never accessed in the driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/dac/ti-dac5571.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
index bdc3f94aef98..455d61fc3f13 100644
--- a/drivers/iio/dac/ti-dac5571.c
+++ b/drivers/iio/dac/ti-dac5571.c
@@ -45,7 +45,6 @@ static const struct dac5571_spec dac5571_spec[] = {
 
 struct dac5571_data {
 	struct i2c_client *client;
-	int id;
 	struct mutex lock;
 	struct regulator *vref;
 	u16 val[4];
-- 
2.43.0

