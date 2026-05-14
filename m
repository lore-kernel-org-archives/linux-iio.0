Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0E423165;
	Thu, 14 May 2026 14:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778770174; cv=none; b=EluK9c1T6DhbaJMMbUQg5p6CZY8tDc+34kVyy9JQTmqxam63HRFqEktoVlaPLuqxcitwq4RoCTYqp852jrRt0n2ftFzRwSn0/28BDfsgPEv4iFN1aylSkiLncGy+aFnH53r5nsuQSYcKj79Tf7UCuZlbCN/XBEr1v5x/m2wqHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778770174; c=relaxed/simple;
	bh=CmySF8OIktTFikW7ESRHWnlGhBvyzZUhf3Nml0FqDaE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fic5Vr4ckY+BXOm17/9wi2BUHSn5hv7TpCUvmlyAuI0Futt29W3bCacuR+Pk9jy8YZvpx49I16evoEzNo/dvbjzJU7nl8Pdk7Zf4++XK5XhNhOWT58D68mROCFg3nlBQywFrsbz56mdwZg1rMKe6120svXNjc2dIN2Ol6FtlMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LKywOuQ5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LKywOuQ5"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ED0aeZ1714990;
	Thu, 14 May 2026 10:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uL2Xs
	S9P02fsmG4qiSfp1w8XJbwFYe73+oRLPk88/pU=; b=LKywOuQ5hJvEG4h2KiNTl
	eEQxmgt0gjKAyeiMuMdKhwAgfVFFgnSbJSdOvT8vcGAoH79PuM0szXlkt1R+mGWa
	AyzCoYZhWouoyFrGINRTk+G8866+j6RD0cUqoY9xyTw5uywYO3A0XQVeT3yV/HIy
	OG2fzLN8CN0rumcgKT+961qMiGjS5dhgpKbDfujgoloOcUWP0w3VlDFYX5MY+VNw
	mO9J+dDUblZOuRO5yKYFuUgOoSDbH4SAmMxE+xxFzTvNGSMGpuM8roELDzODOZEM
	4pZ25/AC1H9lJoKmCF9QrxHEqscgRUygczxOdsI5VvAqKQSmgWmPkzOD1O7kzV6Z
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e54xgtj3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 10:49:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 64EEnSwc041737
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 14 May 2026 10:49:28 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 14 May 2026 10:49:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 14 May 2026 10:49:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 14 May 2026 10:49:28 -0400
Received: from HYB-MkYHBcJRSnh.ad.analog.com (HYB-MkYHBcJRSnh.ad.analog.com [10.48.65.202])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 64EEmjAb014051;
	Thu, 14 May 2026 10:49:21 -0400
From: Liviu Stan <liviu.stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Antoniu
 Miclaus" <antoniu.miclaus@analog.com>,
        Liviu Stan <liviu.stan@analog.com>,
        Francesco Lavra <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 4/7] iio: temperature: ltc2983: Use fwnode_property_present() for optional properties
Date: Thu, 14 May 2026 17:46:51 +0300
Message-ID: <20260514144712.64374-5-liviu.stan@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514144712.64374-1-liviu.stan@analog.com>
References: <20260514144712.64374-1-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE1MCBTYWx0ZWRfX3jVY58Rv7lUP
 d4MaglooeIilaZNigsgSUjiS09nNXX8aWEprgYoFeTJaxpDz2hMAYpIAb8kF9ySm0N91xt3P6Rz
 LfdjAVVGYr/SHHOpNjbIzb97JMr9qUTv9YAWWvna38qPqUD9yTWuYmGZ9BBcntquu7V2vv4YMMB
 Djr82g+sPZ4jEGuztvElv8ZXVVaLMaxoI8iF44rMZS7F6N+91w4AOQVWefDMki09ruLACrPsWUb
 z0Mna5cv7Sx4o4VOnPQgkmB93kNeuIG4gViAT6CO0huDpqodvEv6cWkbuAmPkAUO9Yns8qy3th+
 KHETC0DpesxzjttbtZF5I8XS2ZuoaPb4w1kKjsrA3i734xsqrXJiuvFfS1abPCK/pI1pLd2YQsH
 HTcCa/k4KyeplVcBh3KJlXH5Fu5QYxMDJQF2jU4m16scfJL2jzvqLuLNQB9b0MIRiCIWexqYXVt
 0DY6S+HyY9oneuGbbWA==
X-Proofpoint-GUID: DKhB2dHvskD5AA1gNShxDjxRjOTx3o-S
X-Proofpoint-ORIG-GUID: DKhB2dHvskD5AA1gNShxDjxRjOTx3o-S
X-Authority-Analysis: v=2.4 cv=MMFQXsZl c=1 sm=1 tr=0 ts=6a05e0f9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=anXMOi7fFe8hw7OE3YUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140150

Checking fwnode_property_read_u32() return value with if (!ret)
silently swallows meaningful error codes when a property is present
but malformed. Use fwnode_property_present() first so that absence
uses the default while a present but unreadable property returns
a proper error.

Fixes: f110f3188e5639c81c457b2b831d40dfe3891bdb ("iio: temperature: Add support for LTC2983")
Signed-off-by: Liviu Stan <liviu.stan@analog.com>
---
Changes in v2:
- New patch.

 drivers/iio/temperature/ltc2983.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index f42777c1f3c2..bf435e965c6d 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -669,8 +669,14 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		thermo->sensor_config = LTC2983_THERMOCOUPLE_SGL(1);
 
-	ret = fwnode_property_read_u32(child, "adi,sensor-oc-current-microamp", &oc_current);
-	if (!ret) {
+	if (fwnode_property_present(child, "adi,sensor-oc-current-microamp")) {
+		ret = fwnode_property_read_u32(child,
+					       "adi,sensor-oc-current-microamp",
+					       &oc_current);
+		if (ret)
+			return dev_err_ptr_probe(dev, ret,
+						 "Failed to read adi,sensor-oc-current-microamp\n");
+
 		switch (oc_current) {
 		case 10:
 			thermo->sensor_config |=
@@ -760,8 +766,12 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 		return dev_err_ptr_probe(dev, ret,
 					 "Property reg must be given\n");
 
-	ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
-	if (!ret) {
+	if (fwnode_property_present(child, "adi,number-of-wires")) {
+		ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
+		if (ret)
+			return dev_err_ptr_probe(dev, ret,
+						 "Failed to read adi,number-of-wires\n");
+
 		switch (n_wires) {
 		case 2:
 			rtd->sensor_config = LTC2983_RTD_N_WIRES(0);
-- 
2.43.0

