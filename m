Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D0234B183;
	Thu, 29 Jan 2026 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707511; cv=none; b=PrA+lBJe33jciC0+xti3tuNpcl6fOoUkirF20GZ4OyFijwPq9U31biuEJKgnAix3b4Wu2OWNDXNX8P6x7RpLgtWPK6GQ7pHqld/wVyzu/y/9jLqwUAzvD4Mkk6LvTSrQYJVbkCGEQYRKXNSBhJX+tWLR5A/X4X/YbQFQJB/brVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707511; c=relaxed/simple;
	bh=wSecORGUhn/xjULgLIV21zh3YmjDXv9ae7lGzH5VV2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NyFS++zvXmNTobWhiF3sh8lt6AUVTRzcPqpOpDNDASi4sCRN6jpjB69vIOPANgRgVuksMv0rBlpojiBZdh3IYfLshX4z0sJbTszkGQwQmEnyq/f+ashECdHHupoi6vcocL5EWRhIemq5hXomEP8yF/vpYU+GlzQSnh7yjCg4heg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ItaYCsXK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ItaYCsXK"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TBkqRx3783249;
	Thu, 29 Jan 2026 12:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lrMI0
	9jhY2KceJBAgC8OZm7erv4gZJUpX9Vuk3JwA/8=; b=ItaYCsXKslspib2cWgeja
	ast03GsxS6hgBRqG26doGfEfZSEmbaRdLVXN7f8od1Xapr3KQqSGyJoS59RXZgzN
	vmU9KXxrvwf4bSPDDgc5VEqbkDI0OMbtmxCQRZrWdCSG86WqiWHX4rIcVn4q4Y8v
	axThHSmAnGlpt7AGc3Ji0087AIB1YkDcI8pr00Yye8zes70KEjuSKL+SRNBIJfNC
	D44dwMIVr/NHcoa8JlC0bcKHQDIVJkEqUmkIEwSTlEADwktjiLaE1wNaxLqOS5YC
	alj4Lumeq4eGlN1bd2NSIltWIFrfXJ4lYa85V42OPMYtjDcpNmcfg+ZWs+3X8ylF
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c011bjkhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 12:24:51 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60THOoAU055941
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 12:24:50 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Jan 2026 12:24:49 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Jan 2026 12:24:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 12:24:49 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60THO5ro008516;
	Thu, 29 Jan 2026 12:24:41 -0500
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
        Linus Walleij <linus.walleij@linaro.org>,
        "Chen-Yu Tsai" <wens@kernel.org>,
        Sakari Ailus
	<sakari.ailus@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: adc: ad7793: remove unused int_vref_mv field
Date: Thu, 29 Jan 2026 19:22:00 +0200
Message-ID: <20260129172340.34216-3-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=PvmergM3 c=1 sm=1 tr=0 ts=697b97e3 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=LbWV5dLEJMo44prF9IAA:9
X-Proofpoint-GUID: PKsRYYNYvomx5KIhXZo77d526WfHwUp4
X-Proofpoint-ORIG-GUID: PKsRYYNYvomx5KIhXZo77d526WfHwUp4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEyMiBTYWx0ZWRfX/l6nN0yNtWf9
 RysUm8VXyqfHpw/5/j60nlMULyGqDqiBbj3Jh6di8POgoQuwcseUU/mxccQBBW4nvngwXlQVqrI
 BrY05B1rP3jZHN/asUTHui+2PEpMYGSHezuwGkzq97hWDwqeAJsXG4CS1UEp5q4IBkravbSQjGS
 6+FswaoQ0KeleVCgXr7I0fRI50vWDeOMh5C9QfuUHkglfnECkbRC3lMHlaC1QF6+W16L35eVb91
 sUAPmkLrJL7Q8vYQO7E/cpZBG4e959jhCokI7OA2xVN3IFLoMswj7JJTAQGjRYw2Na8Uryp35e2
 VSuBIH4eoNX9bh2SiCseqSwAzHBG7E2ufcocsWuX+msrvhzeZekuv3QJQkRg1S/1B9t/v3w40fA
 41BxsfA7Y0t2EgTu9LCsJ7H8tAHYKDdJp0Q7tvjCbU6ZV21p8apenXwK8snDXY3LMPL42U4bH16
 O5lsfizpx2eqtJroiUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290122

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

