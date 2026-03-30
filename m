Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569873C9EFD;
	Mon, 30 Mar 2026 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869675; cv=none; b=RMMwP5q3xhJZE/98PpnlM+potaxDVo5/9s39/Xi7vP3234ID+YFK9L6o7j/VRp+ilHmgZCD9v3FfsGV+UbRiAr8YiSDQbTv9djZNFyLv+XLYhcAXpYwMpwS9O3Be3TPfa5BAn5ITi62IIEVRecQfoj4GQFF92AdQK1y2nQ3EPWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869675; c=relaxed/simple;
	bh=yEm2kQ1Bm9gHwaiHulG0ZYvvXxm+s1dwkuBK2lU9eTw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSTEGt68pho/csG3eym0kSn8I4HlDTE1p8RVohFqMneFpUkSWpYs+tzwE4O5V0gv3bGDgrqAfJCt8VpU+rooQ4dC9dH+44uUC9bt7AJuRpSV6vWB8AvQhQKVAhniSCyhZgfm8TC+TPCuPXxaJ2k32r9sekBBbZz4FkVmUdqgNs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SCRFUWve; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SCRFUWve"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAwCJL217176;
	Mon, 30 Mar 2026 07:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zDZaA
	W93oGLSeJ7siRA7oSWtnbC4931eEMdEp8pbWvo=; b=SCRFUWveCECadkCjd+rfu
	OftixpqTFhxUcseOJsJ2JKNlv8c6cU7SXSKaqVik292IrRyGnWFbJczdUH++mQfX
	7yn6u/j+D2k98E4uYyy1JAvu3Oy1VC5Ck/Ubmj5tkADOq0or2z9rOdv1kPTdkd7Q
	gGYw36CaBGJm76HmZ6H+mm80oFofChzvVGMe1Q7tOU7WehZHz63SJbAMpP+lTUPt
	YnF4RwQeI4lY5/CGn7okusRmJxw7MkyUZbG6Lq1yi2lx+ghSiIDGssp4fCeW0X00
	J+FvDXunOxRU7c1mf1OwLibYydNimlC23bs6f5zWECEBTGo+Q9tWhQ2nmaD7ARWG
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d6wab478n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 07:20:53 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62UBKq5n026962
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 30 Mar 2026 07:20:52 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 07:20:51 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 30 Mar 2026 07:20:51 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 30 Mar 2026 07:20:51 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62UBKDgg014225;
	Mon, 30 Mar 2026 07:20:43 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jorge Marques <jorge.marques@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 13/13] iio: adc: ad4062: use dev_err_probe
Date: Mon, 30 Mar 2026 14:18:56 +0300
Message-ID: <20260330111856.121589-14-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330111856.121589-1-antoniu.miclaus@analog.com>
References: <20260330111856.121589-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 7Bgqrcvcms6W1iBk_GMsKIVigR3WORYb
X-Authority-Analysis: v=2.4 cv=YJmSCBGx c=1 sm=1 tr=0 ts=69ca5c95 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=wKzcWFdhvmuAoNSPTJgA:9
X-Proofpoint-GUID: 7Bgqrcvcms6W1iBk_GMsKIVigR3WORYb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA4OSBTYWx0ZWRfXw6+rYu/WDhvp
 m5ozaE5VB2eqSYT2cQP/EW0EcRFpavOlVB48PqsSBlDl98TbqXcjfQgqyupIc5INVLfyaaWGXei
 GvA/aXEP+7Jbl4gcoLCULbxj5Fd0706W8B6AZN7IETmPdwknj8uQHA7tn2Y/1Z6gxIKkzw3T/jt
 P+V0RNa9EOUHOJR2sRHN5Cicax8KPO1wlWoMP/K5ReVnc+TqGA+qhvQEmQNh/2ohHwxxjaBKzmO
 IDnPVu/PO6ytGan8bzAsoDmSpmV9g98WE29wB0hvwvchG9tXvK7Ha30CPlpRKu6Iy1XXiOhTfWL
 PgTWK6Xmy3GrhFNXETVaOSN2Q9+OhK7eTGfpoHYGeAJEXDEi3li8OXdtb5cK2+oJkhM2cKtrgNP
 cNitE7dhnSB/M9W6WarK+PgrtRp6G0kPQVlafwkitzY8KancYHXGKUkRFW9ksmylf3PYPrLSdee
 M4qxSGhMVqBHN0egx7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300089

Use dev_err_probe() instead of dev_err() in the probe path to ensure
proper handling of deferred probing and to simplify error handling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4062.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index c864de3b46ba..8942c79e8d83 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -436,10 +436,9 @@ static int ad4062_check_ids(struct ad4062_state *st)
 		return ret;
 
 	val = be16_to_cpu(st->buf.be16);
-	if (val != AD4062_I3C_VENDOR) {
-		dev_err(dev, "Vendor ID x%x does not match expected value\n", val);
-		return -ENODEV;
-	}
+	if (val != AD4062_I3C_VENDOR)
+		return dev_err_probe(dev, -ENODEV,
+				     "Vendor ID x%x does not match expected value\n", val);
 
 	return 0;
 }
-- 
2.43.0

