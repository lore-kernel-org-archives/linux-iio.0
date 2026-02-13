Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40505232395;
	Fri, 13 Feb 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770994049; cv=none; b=uP/5NDivBeJy/PFp+vD7qNaTqPj+dJYiPNc9YzEQ2V8FIcQVi3nY4lQeqgd0pTkp0eCBMl7p0bBXpDSJED3pmRkWUx/y3+vQgbFR2eFKGHPBSJM20EsCz6eg0aEmyZs2nlb6HO6TC9TLYK+yvD3OkzaZxRp6T391Wit5tctsJWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770994049; c=relaxed/simple;
	bh=yf9BHPD2BFGydpLq4T8UJEJlhQr5ULesg26zeE1yXvk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cDinOZi7tyFbbUhB3JcJa7LjcafbjKW3UWTCOXFjjXZoFyvfwb3FGhJ0KCScOwtU1PVmItMA8XWth52bgSsuODJktu974Tni5ocHS4yBoESINGdKcmCewbLuZ7uxkDxBqrrt0xBn1O7pOgl/C/fjcd2KHSRt1KhRQYWMoPCcNO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nHfx65rG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nHfx65rG"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61DEUi1Z2059654;
	Fri, 13 Feb 2026 09:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=qMZP0C7FBZ68gOMEZeEhGxwLm/V
	WV08bhpRccaaonrw=; b=nHfx65rG0DURHcM2NyjiSX/y3YAnnBmfeXRqEAty5Ch
	cp+rzZnh2jl4mgraeY6ZP6m6xBGP8+R1WGo6Kj5ieHxSgyLe+IeOHToyZQWSsi3X
	3/qbukT0ekZzSg0Zxs2H6yN64wG/63UDnpqJ3Pa2/U06vl089c5bShciUyrqRqP/
	HT1SZUKEHDa91u7TBPh8W1CwkPNUwGs5UD88+Yx+NwxQWmu7tNSYN+BzNQxkEFIG
	OzXr6HPH5IF5OCU6mv11eU7BvlinTt7dPBq1rPKN4b+DGbhAUt6aCgck+Vc705Dm
	ez6+VOhxTy1Rz3C+ICxW7qAOOy3YyWESUgWOoNkv3PA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c9ss6asse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Feb 2026 09:47:06 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61DEl5CM041240
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Feb 2026 09:47:05 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Feb 2026 09:47:05 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 13 Feb 2026 09:47:05 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 13 Feb 2026 09:47:04 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61DEkrGx018425;
	Fri, 13 Feb 2026 09:46:56 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] iio: adc: ad4080: add support for AD4082, AD4085 and AD4088
Date: Fri, 13 Feb 2026 16:46:21 +0200
Message-ID: <20260213144629.16001-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDExNCBTYWx0ZWRfX8HH3yf6mopNB
 3gMTmH/v0XvCz7XMjJ0ibU4OUSUT9gjiAe2WLrkOmKAHXCCTTK+z3Jep5tbplbdyxMAIML2cRge
 iYfuWfBoMKnjomldQlLENo9HEsbjCHG8j/WPOK1OMvb96p3snWOjSMifb1SNPCmhNZnHYpeKhTG
 ZShHR0k6xi1YPdWnIV3XInUqLJ7GIaig4YLRnJTVoSxykxdNDToyoFgTtoE/Pb/91WlDRAifze9
 E3Mtpxikz4XMkqWeQPJDMTI8yEsq6mRKXHg8JT5mw4BMWkvuUio/+K81hMT579euSObszXT6S3q
 V37v7qXzZ3PqZGw9KpZCcENL95VklZqSDPSwrKhhDsCRacT6x09VJIvzJntLdt59WcJibZ3DpYR
 OG6hqMeGlvqU8SoBsdV1GsvVAnjro65dhONQY3jGn08iwBlS01XS0zDqHi6dffD4fCsgc8WBsoc
 0k7nH+cdQU5q/Gvp+JA==
X-Proofpoint-ORIG-GUID: qvymzkSzeaUU_eiop9_wWyeLllBo9xN2
X-Authority-Analysis: v=2.4 cv=YJmSCBGx c=1 sm=1 tr=0 ts=698f396a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yREZZP1plolENsKRSHsA:9
X-Proofpoint-GUID: qvymzkSzeaUU_eiop9_wWyeLllBo9xN2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_03,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130114

Add support for AD4082, AD4085 and AD4088 SAR ADCs to the existing
ad4080 driver:

- AD4082: 20-bit SAR ADC with LVDS CNV clock count max of 8
- AD4085: 16-bit SAR ADC with LVDS CNV clock count max of 8
- AD4088: 14-bit SAR ADC with LVDS CNV clock count max of 8

These devices share the same register map as AD4080 but differ in
resolution and LVDS CNV clock count maximum values.

Changes in v2:
  - No functional changes.
  - Dropped redundant Changes sections from driver commit messages.
  - Collected Reviewed-by tags.

Antoniu Miclaus (6):
  dt-bindings: iio: adc: adi,ad4080: add support for AD4082
  iio: adc: ad4080: add support for AD4082
  dt-bindings: iio: adc: adi,ad4080: add support for AD4085
  iio: adc: ad4080: add support for AD4085
  dt-bindings: iio: adc: adi,ad4080: add support for AD4088
  iio: adc: ad4080: add support for AD4088

 .../bindings/iio/adc/adi,ad4080.yaml          |  3 ++
 drivers/iio/adc/ad4080.c                      | 45 +++++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
2.43.0

