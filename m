Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F0F3B27F7;
	Tue,  5 May 2026 04:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955732; cv=none; b=ghoe9d2LBxZBrWzBncJaPN2n72y1RZTVg5ZCRwmGbJbO03jxcVaw0MEwn51fRdAibE2NOE3TAzaFbLs6G9zJOyU2PXWsf0bW387k6Op7o8Ys5hu3AliveWBuisJgKmg+b1FsgBKkxWVyekBT6XVQwlREcRgbx3Qm6Asn3C8R0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955732; c=relaxed/simple;
	bh=miJKNuVmJB9KkketXlddgcFvvCHAjnbg53el/b7pntk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=D8OUxDnlXlTZHA9jNEo0UqkRKT47RGkabwo+Wsi53SiBAxX+NqSBkaJE9JfiDPNEeq9YK9iyIxF8CCBPSRbUXsQ5a5NKxHMDxNdBO5sK3oayQkwrDXPcl5JPLkE18nMUzSctUrlUo9wqswaZZrMKgwRmhHW+mA5NrYG4pTzDQ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ykLK4Coz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ykLK4Coz"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64523xlw3424217;
	Tue, 5 May 2026 00:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cNSaL
	tK/e766HoBdmPTlMiXs767NJeXxLR5SH6bM5dY=; b=ykLK4Coz2SvmiPrHgKOvy
	iWodVDscHLPYItWg7x9263r7j7KwnSosy1acvbZnQOvkvIDcbcOC1p45s5N2iJrp
	/stjL0wRHw2TojD4qjmNjEd9mVHB1zRctt5CHnF+T3RMOOauymBpDlb+W2SB818W
	/KRRjfCjyV36eByvT7M6DWr9hmfHE+FvGyYgNMHvk/2+LlQzA+xO9VNvXCJpBF6r
	QEpQ5sP401EQTZIV403EzX9piy35y2ymEMB1QaEvLKbgzarHsU0sOEMtsX8/DUkz
	zYrvdI1ick1CDPvMeNm6XBytDmY0q7lybre4jQfbSqfljDwDYNaCgzlw2957LvVJ
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dx2kfqd46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 00:35:09 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6454Z8gq053902
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 5 May 2026 00:35:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 5 May
 2026 00:35:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 5 May 2026 00:35:08 -0400
Received: from 10.32.17.67 ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6454Yn1Q006142;
	Tue, 5 May 2026 00:35:03 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Tue, 5 May 2026 12:34:32 +0800
Subject: [PATCH 2/2] iio: dac: ad3530r: Fix AD3531/AD3531R powerdown mode
 strings
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260505-dev-ad3531r-v1-2-2b4cc55f69e7@analog.com>
References: <20260505-dev-ad3531r-v1-0-2b4cc55f69e7@analog.com>
In-Reply-To: <20260505-dev-ad3531r-v1-0-2b4cc55f69e7@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael
 Hennerich <Michael.Hennerich@analog.com>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kim Seer
 Paller <kimseer.paller@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777955689; l=3619;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=miJKNuVmJB9KkketXlddgcFvvCHAjnbg53el/b7pntk=;
 b=4fIMd/Z4AYJcrEQgmAIWPIPXNQ+k8mTZHMC4RZMITPxCSsFB5XS5Qih56ItrTw8E0AyrmqK1a
 BYQ5ZR6V/jmDkC9bzgL9F7jwEan9ii+pXGOcNbXMNIciFCUgjOK+pEs
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: G64aoeiYGEBScUT8y2ShzmpEZP7-NdzZ
X-Proofpoint-ORIG-GUID: G64aoeiYGEBScUT8y2ShzmpEZP7-NdzZ
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=69f9737d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=kVuKocMHiT1n-ywacioA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAzOSBTYWx0ZWRfX5yR898w61oe+
 6pMlEvaEuFIfHSOp+2KgCISO0AMhUx55pTwr6IEJpAQ66/2OmC1qBCUwdvIneCET4/1O7qrnYG+
 vlRmf2yP6hhiT7L6IPahgGdLQpbLuxOLoDihNPJVzBI1zObkFVu8D9W3l+NJmbyG2D2IjlFgtRF
 PyFb6mD+B4/xbge78Ek6C+4FeF8Hpy7B3jkyannhEFO0LJVcvzE5dmMy5oFYqkoztxrzjQvZd/n
 NoRl8S7EVTgrRqTMb5NfQZlZGE1y/2vcsJpYRQdt9YJyjcXDTM9byhKs9ArBvBAbL/1/YX0M7LN
 96gJq2qL8SOgtGGIOv1cQSLL1HAK3X+CYWMkuCRxXm1/6n0TK3P/XfHsu34fvR/5JXKRB19Fv9E
 D/xuRb2L1Cg7F5X9OywQjl68SMJ4N5VMQp9rFWu0Byc0K7Hh6rdQN2LMu328w4V2jQ2VKUw4cHn
 APcWWLFdeKc2h/1dGoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050039

The AD3531/AD3531R has different output operating modes from the
AD3530/AD3530R. According to the AD3531/AD3531R datasheet, the
powerdown modes are:
  01: 500 Ohm output impedance
  10: 3.85 kOhm output impedance
  11: 16 kOhm output impedance

The driver currently uses the AD3530R modes (1k, 7.7k, 32k) for all
variants, which is incorrect for AD3531/AD3531R.

Add AD3531R-specific powerdown mode strings and assign them to the
AD3531/AD3531R chip variants.

Fixes: 93583174a3df ("iio: dac: ad3530r: Add driver for AD3530R and AD3531R")
Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 drivers/iio/dac/ad3530r.c | 54 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index b97b46090d80..d9db3226ecd6 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -105,6 +105,12 @@ static const char * const ad3530r_powerdown_modes[] = {
 	"32kohm_to_gnd",
 };
 
+static const char * const ad3531r_powerdown_modes[] = {
+	"500ohm_to_gnd",
+	"3.85kohm_to_gnd",
+	"16kohm_to_gnd",
+};
+
 static int ad3530r_get_powerdown_mode(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan)
 {
@@ -133,6 +139,13 @@ static const struct iio_enum ad3530r_powerdown_mode_enum = {
 	.set = ad3530r_set_powerdown_mode,
 };
 
+static const struct iio_enum ad3531r_powerdown_mode_enum = {
+	.items = ad3531r_powerdown_modes,
+	.num_items = ARRAY_SIZE(ad3531r_powerdown_modes),
+	.get = ad3530r_get_powerdown_mode,
+	.set = ad3530r_set_powerdown_mode,
+};
+
 static ssize_t ad3530r_get_dac_powerdown(struct iio_dev *indio_dev,
 					 uintptr_t private,
 					 const struct iio_chan_spec *chan,
@@ -276,7 +289,20 @@ static const struct iio_chan_spec_ext_info ad3530r_ext_info[] = {
 	{ }
 };
 
-#define AD3530R_CHAN(_chan)					\
+static const struct iio_chan_spec_ext_info ad3531r_ext_info[] = {
+	{
+		.name = "powerdown",
+		.shared = IIO_SEPARATE,
+		.read = ad3530r_get_dac_powerdown,
+		.write = ad3530r_set_dac_powerdown,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad3531r_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
+			   &ad3531r_powerdown_mode_enum),
+	{ }
+};
+
+#define AD3530R_CHAN(_chan, _ext_info)				\
 {								\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
@@ -284,25 +310,25 @@ static const struct iio_chan_spec_ext_info ad3530r_ext_info[] = {
 	.output = 1,						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
 			      BIT(IIO_CHAN_INFO_SCALE),		\
-	.ext_info = ad3530r_ext_info,				\
+	.ext_info = _ext_info,					\
 }
 
 static const struct iio_chan_spec ad3530r_channels[] = {
-	AD3530R_CHAN(0),
-	AD3530R_CHAN(1),
-	AD3530R_CHAN(2),
-	AD3530R_CHAN(3),
-	AD3530R_CHAN(4),
-	AD3530R_CHAN(5),
-	AD3530R_CHAN(6),
-	AD3530R_CHAN(7),
+	AD3530R_CHAN(0, ad3530r_ext_info),
+	AD3530R_CHAN(1, ad3530r_ext_info),
+	AD3530R_CHAN(2, ad3530r_ext_info),
+	AD3530R_CHAN(3, ad3530r_ext_info),
+	AD3530R_CHAN(4, ad3530r_ext_info),
+	AD3530R_CHAN(5, ad3530r_ext_info),
+	AD3530R_CHAN(6, ad3530r_ext_info),
+	AD3530R_CHAN(7, ad3530r_ext_info),
 };
 
 static const struct iio_chan_spec ad3531r_channels[] = {
-	AD3530R_CHAN(0),
-	AD3530R_CHAN(1),
-	AD3530R_CHAN(2),
-	AD3530R_CHAN(3),
+	AD3530R_CHAN(0, ad3531r_ext_info),
+	AD3530R_CHAN(1, ad3531r_ext_info),
+	AD3530R_CHAN(2, ad3531r_ext_info),
+	AD3530R_CHAN(3, ad3531r_ext_info),
 };
 
 static const struct ad3530r_chip_info ad3530_chip = {

-- 
2.34.1

