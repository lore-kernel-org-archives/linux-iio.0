Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10081344036;
	Thu, 29 Jan 2026 17:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707580; cv=none; b=M/fy11/HkuLzSASew/Yj/darxH2fi3UU4XpjEuT5eiOLIVxh9aU/hhMw8ve1Ho+1Fdq54ev8elaoL0TxQ7R/e5/rB/2pmQ8Xy9HBIqxhwb15hipAoh8DFQ8G5dt4fDUT8Pxl30BvMdh7o9Jg4Zvs3qrtXTdL5Z5WUmt8EMFBKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707580; c=relaxed/simple;
	bh=IkMbTWNxe03tOoMnPt5EiHgSOChjZNAkK6NBvanjgbk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ad+fYxY+pPgmBnRKMLzpatIrRVedNTMOQP1TsKK2tvnEVZf4Ple5U6ZifhxQzogqYC0hlaFlSznn0KCv6Qi4SlWDYoaEaZX/0xrPrm39l+xYJRnMJs5C2D6RqGattnIqNJ+2Pjp3klvxBmgl6dY4c+izG1pBoHgXDLoo+cpAkiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=irO1KqZk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="irO1KqZk"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TDoq3A009200;
	Thu, 29 Jan 2026 12:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xnYpa
	tKOarF1sN/h0GAdyVnLANogtAcfEcm0LfFdftw=; b=irO1KqZkCZPuGnXpD/q7P
	YaxOQcxOEXJWFKsTgFofkU6Lf7xEtuJS4wE3UZ+MA/+QfANq1MtAGjeQtPB3w/Nk
	/BaP5NOaVkMlWq0tKdxISww9HYIddYCoLhFOC0XINC+h1IbLyGVTZULAZVuo+29E
	jA8bH3eS68rU7vDjiIjgVSPPo7dCrkjcVYQ7E17VM4cMhaGL+B/T61bUfTYTxeKk
	OX6gcty/cIdbB6H/OsvrmJ153kZHSM7AnwsiIIR6EMM4AKlzwsFeTOTPkMaioZ6r
	svagR2kFvczNuAU2+ya15t4jN1bfWQgTPpkRRAGNYV67zUwwLqKoZowh1Phf2+5c
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c08su8w43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:25:57 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THPuPr056088
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:25:56 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 29 Jan
 2026 12:25:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:25:56 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THO5ru008516;
	Thu, 29 Jan 2026 12:25:48 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Fabio Estevam <festevam@denx.de>,
        Matti Vaittinen
	<mazziesaccount@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: dac: ti-dac5571: remove unused id field
Date: Thu, 29 Jan 2026 19:22:06 +0200
Message-ID: <20260129172340.34216-9-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129172340.34216-1-antoniu.miclaus@analog.com>
References: <20260129172340.34216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: GTIxD3lgbSTpuvcHV7T_iaBEGDV-IAuj
X-Proofpoint-GUID: GTIxD3lgbSTpuvcHV7T_iaBEGDV-IAuj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyMyBTYWx0ZWRfX+eWwCjKhjnea
 X8FOzLmYvsZ/0TYOJfRAdlOLRNLlGUuDCQqzE6k8Hu10ZyjozlnmuM8BWKAEqhpFDUCqbdZ9BCy
 G+20EtGAAg/q6mB4tnlGlvJrCHfIzEcVtQPl+gtoYnw+FlOTKu2UsZNzUZgs5DIMCLpb/0CeFIs
 X537ethbmCHnwqqBkvmt9GbCmbsLoTG35GNlk3zY5J8bOsEPmlg2DZZnvhKgQRiHGFdbkCB/B5D
 saRgbdg3eL7CILd1wcQrM8MA6gzfECMLY1kSuajjKhii04y5frWOhrJr0KiloZSFQf5ITolb1/p
 IUDEYVV7mjSMHfJ7Q88bPzPT+5HF8nK9LSqVjG1Myy2roPtTN2fpe8JGT6w/xQhdaDfi+cipmtD
 psSq1gK9ns8viG0+iFTqyS8Yva5mtCrSFRGB0FMx4t527L24xY/Oti4vPj1uhq7bNoLJdzX9txF
 bVxb8tWzte5sCW/HqEA==
X-Authority-Analysis: v=2.4 cv=IsgTsb/g c=1 sm=1 tr=0 ts=697b9826 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=a8JB4DYtp2rSZWCOx_wA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290123

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

