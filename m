Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D6F313524;
	Mon, 16 Feb 2026 14:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771253972; cv=none; b=HsliuH8TSfggQ2NEy1vPxwvXfO/zpiB/h8AUhCqXJo6faahvLT7caKez2dViL4+r6OSFoZwHfzkmOdIwe0hlBl+etHWdKBc/VbAriQanzs5EcZ7MxwIZfF+tF2OzoMrm4eJXhRa3dPDqpoUu/1EyzcXtC3tTwOXUv3qH/E9tIfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771253972; c=relaxed/simple;
	bh=8pmZk3LasiYsyf3pyo5Sj6nHhTHRQkezrWZq11pyiAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OloA5l8iJ09LHKPwbfE+2thGU6h3qiyHt0+nOSg+aDAbsmgmh8poiATJWdpmAKCM02ISktzsSO4cAEStr5QXAPwA7uQw/xUtoYiecG05r83G3fMb6mBlK9HQgpkCgsQqD8MhkxjVoRFzJtvryzV152D4QNarxwk1cWN7nCYZPZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xceJFDu/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xceJFDu/"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GCAw0r3569055;
	Mon, 16 Feb 2026 09:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZUhor
	AwTMxFnJWHkbpOFKwFQjmKrMdGpJPb9np+6uoI=; b=xceJFDu/UtsFLuCOhKoq9
	HeJCkmgF9ZsKK4xKbCiNM9+XbjtyCHY+EQ559gLvJYD5iuGC4E1/HkTAbh9KWll7
	s9t3k8NnV6vm3KWJGKTol9HiyGlFwc7cxmhgqfJo1EiATsmZSaShsuJrsLFIxoNg
	kThtxt+45XTSqO6QoYYnStIh3riHzj0CgaWRxO8LEZkTFiILNyUW5aSf28KDVdot
	udRP0R0wSDW8aX5p1B2N9re86BSyKRhaCDpqbxiBmSILs6JNA6WvEawG/r88NdM8
	f8hGF9+J2Log8gpLGR4Q1/EkVDCSOjtRYyuKofIwAypn6S3PVyemgGEmxEamdgBg
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cb88hmx9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 09:59:27 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61GExQUG019669
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Feb 2026 09:59:26 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 16 Feb 2026 09:59:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 16 Feb 2026 09:59:25 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Feb 2026 09:59:25 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61GExAt7016017;
	Mon, 16 Feb 2026 09:59:13 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>
Subject: [PATCH v9 1/8] dt-bindings: iio: adc: adi,ad4030: Reference spi-peripheral-props
Date: Mon, 16 Feb 2026 11:59:10 -0300
Message-ID: <4cec105bd339aa67b3e1cd1eba71a8dd2f3a389e.1771253601.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1771253601.git.marcelo.schmitt@analog.com>
References: <cover.1771253601.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDEyOCBTYWx0ZWRfX7uHc1HvcuGW1
 9G7Gx+CwJH4QKIxry9zorQGns1B03tpZaZ6CzAegL4MtgZB1PwmauDxub4fWPcxawMhV7h+wIAl
 3InP+kRV9l9cDZpa49woGh/wtOE04Ow7aAxrW1K3G/Dq33LOo16W65IzK8YJ2YbeDIMz8i9N81+
 D5vtx8O/3aYdHHBRzWBuUHcbxGZMcIzwnm3/jyp4L/DGLOUR9+2oXgcuRNsooQVW8iazVVfjTNe
 O/0QuwgGnzXqQpafkM5o5bKiI0Kq/KcjKFHwf3/ELUHPw8FkpabbJ5AY24ziPQ3Ih1JS8Gwi/TT
 Ed+nwbEBSywm8Xy4MYTiLyhKteRgfPzKs2kIUaEtUrXZsLJZ26uBJEAmcJniz5Xm4o9h0XJM/8j
 zpgmE3V4Ufo1bzBqfLcrCXZWnZfEZfa3//IZcEXjKf8tWUGdZlRAVdw5IS3n3jiGVZ290QmxEAY
 fNkp5CGgiQrece3PntA==
X-Proofpoint-GUID: lfYjAtj3MoMsicajv1DAMCCXDOKvs7DN
X-Authority-Analysis: v=2.4 cv=TeubdBQh c=1 sm=1 tr=0 ts=699330cf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8 a=XYAwZIGsAAAA:8
 a=EfQ9L3lKGMo9VN_2EekA:9 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: lfYjAtj3MoMsicajv1DAMCCXDOKvs7DN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160128

AD4030 and similar devices all connect to the system as SPI peripherals.
Reference spi-peripheral-props so common SPI peripheral can be used from
ad4030 dt-binding.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v9.

 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index e22d518135f2..29e266865805 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -20,6 +20,8 @@ description: |
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
   * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
 
+$ref: /schemas/spi/spi-peripheral-props.yaml#
+
 properties:
   compatible:
     enum:
-- 
2.39.2

