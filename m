Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BEA30F95A;
	Tue, 24 Mar 2026 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336490; cv=none; b=dQBtV0JJY4hvFVQwNASF6NYapwwmTll7Er5AdXlFXvQqEtaIUkEOj8+PyCD2EzmrwS+nKgdZC0ryrKwXdGf15qGsu9XSX8sA/CgAUfvvMpc02s8SDO3xlAvbgKNmx118qUdtbUku6laEOB6TzyxFVeKLRbNVramzoxb8KBZMlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336490; c=relaxed/simple;
	bh=pWGK3a47a5IE/6Xf5CqdCM7wCKfJgdgrrA8/V3iAAgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMNyN7VObE9KAJT+NzXtL7OHbCSxJ/BR7eABhlnrDohao5Olt+H+Ih/4XaSAkrwNJ86940JczOXqeBxhlzjIHGb7YgJroihzHBU+NjEveE1mfY2QronornBZnRjBy2oHm+reyAmoA9wkL5cnp29xQxrrTWrIp6pZFRgR2bTASHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=o0kOKiUw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="o0kOKiUw"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O1Uuh34072652;
	Tue, 24 Mar 2026 03:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=VKA1T
	25ql99Aa5rgzcZx9zZz3v36OhoKJMSNYizP1Zc=; b=o0kOKiUwfz6WTe3frOS8A
	C8oHl/qWowLTKMGdvQWFK1yKXQebUGaJ67XsT2xrY2Jw6fv5Z5CqKkJFGV5nLI+/
	kGtbGpzt/70kAjXVo4x+PXKk2ak8FqMIfm/UcZGslq5cBFeB8fhYOrs11KX+2wpV
	h18AkwvT2N24SA+njABEKeIWvLVTEFO9V4Bl0gEZZbCQxSAuY9K7YCIb14D6TbRP
	97/b/DXnOqezKSWnHM7humDTrMGRq78SmL9ZCs/UPwz4qBPdNXOgJsooOYYXKO1c
	rHB/SnHqWQ0VDVHyJael3R+UrWKll2cqAnJE/x38FSNab7/OF95G1a+0KkLwPvZA
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d2pxqerfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 03:14:17 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62O7EG10020257
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Mar 2026 03:14:16 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 24 Mar 2026 03:14:16 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 24 Mar 2026 03:14:16 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 24 Mar 2026 03:14:15 -0400
Received: from CJONES7-T01.ad.analog.com (HYB-jCCu8MOWEgi.ad.analog.com [10.116.223.230] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62O7Dg0e003654;
	Tue, 24 Mar 2026 03:14:08 -0400
From: Carlos Jones Jr <carlosjr.jones@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Liam Beguin
	<liambeguin@gmail.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        "Andy Shevchenko" <andy@kernel.org>,
        Tobias Sperling
	<tobias.sperling@softing.com>,
        Jorge Marques <jorge.marques@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] dt-bindings: iio: adc: ltc2497: Add LTC2305 compatible
Date: Tue, 24 Mar 2026 15:13:30 +0800
Message-ID: <20260324071331.842-4-carlosjr.jones@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324071331.842-1-carlosjr.jones@analog.com>
References: <20260324071331.842-1-carlosjr.jones@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ALPFdfBd c=1 sm=1 tr=0 ts=69c239c9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gEfo2CItAAAA:8
 a=gAnH3GRIAAAA:8 a=pGLkceISAAAA:8 a=TAVYlzFYoiTtzGGjz50A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: oW9W6uqQXOuImUg_wleVtH_7GIj_f5co
X-Proofpoint-GUID: oW9W6uqQXOuImUg_wleVtH_7GIj_f5co
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA1NyBTYWx0ZWRfX010R0u71iIrQ
 cXsxAtmzAAkR5o2wPJi3VYeQNzwvbHneJltj1Q9N1BtLWLFCPw+sBVt+kmLNDvUwq7mIZt6WKLw
 SCPVovMUbgDpPYg2ipHJo7kApYx5sZmmWmS7lhWOVWhNO522ZMleOdSir5A3gdXt6UY/LEMTRX2
 R1dXpHSeCDMRp5t0wrlU3/OSmUrWTUzfkROrfKtsVElhxTt7uGo6loxDzLDgTVAafG7lbeOkLYr
 kl5Vp9A87L+1V05hVd2qX9wU3slnSc7ALY9BHxD/E3NWD3qWuJSpHRNv+I33KOaBPYrz9zLbPrY
 rZej/9lYNqhr1RVNwPdCrT/YNh+jwyJwjXKbE3cDOqhQDCLFtjayB7GcOweyjjanQlfEeRaBG6F
 YgTD8EfSXdiB48mNpWYiuMbTQCEnPx7ibNFZoKmWhIqv8NefQs1ylw+dPNOeUklJGpjxr4LxV/d
 fb7chZzGeeXi9jx2n4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240057

Add device tree binding for the LTC2305, a 2-channel, 12-bit SAR ADC
from Linear Technology (now part of Analog Devices).

The LTC2305 uses the same I2C register interface as the LTC2309 but
differs in:
- Channel count: 2 channels vs 8 channels (LTC2309)
- Conversion timing: Requires 1.6μs settling time vs negligible for
  LTC2309

Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
---
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml        | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index 5cc6a9684077..b246d492950e 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -4,13 +4,19 @@
 $id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Linear Technology / Analog Devices LTC2497 and LTC2309 ADC
+title: Linear Technology / Analog Devices LTC2497 and similar ADCs
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
   - Liam Beguin <liambeguin@gmail.com>
 
 description: |
+  LTC2305:
+    low noise, low power, 2-channel, 12-bit successive approximation ADC with an
+    I2C compatible serial interface.
+
+    https://www.analog.com/media/en/technical-documentation/data-sheets/2305fa.pdf
+
   LTC2309:
     low noise, low power, 8-channel, 12-bit successive approximation ADC with an
     I2C compatible serial interface.
@@ -28,6 +34,7 @@ description: |
 properties:
   compatible:
     enum:
+      - lltc,ltc2305
       - lltc,ltc2309
       - lltc,ltc2497
       - lltc,ltc2499
-- 
2.43.0

