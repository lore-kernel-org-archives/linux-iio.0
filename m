Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE78314A9F;
	Fri,  6 Feb 2026 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404463; cv=none; b=Jzb1uIZ3VrvIMWcMX2hEynWIdKVhLJP6uJXXh9+JG25BJGYpzFLYW8wbQAljpag3ALH15ebX7x+98faIgkfC/P7JjNUGyD6Etj+UMuHJXoOYoHkxaHngdlLPPZY6Q2jLi63aaM0kvtQIlVhg1rDKadiGuFkcgJIfia/EED78aNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404463; c=relaxed/simple;
	bh=vreuyB1oJMX28dl3w587JJSbrdpOaZ848torossb2pI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miiuFUjeKFbaLZCIzC4zALiSrUhA1FGwyNHH70mz29tQZM6a8zZfPvXx5JCV12AD+20WL3881F2JfjbwPxaGGiIz6x8ximCrDltfufb6iZ5gmHdnBgjRQoScEtVMNikm0Nrox7VklJQaHwUDqk2bPOTihPAcd35Vaa4XPOLpGkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wWqHuYtv; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wWqHuYtv"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616GLQHw3814513;
	Fri, 6 Feb 2026 14:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/m5lg
	W9LZdYxB6YJs1TYPvAh9FlaVDaMUHUk0YNse/U=; b=wWqHuYtv6eDGWue/vtxqO
	REUAeU4sKyDxssGU5IYhO/iLwwkec8C3mzWMP87+dwKb3p9bM0/mktcCHTbb30vr
	GJ4GHxyYdexxkn/xv/QHXq8O+ax41HOEjAkTcXM2KZI50llVWBRojhSAfmx2ku71
	ogXPpNNkwUYNybFJBDXNQG4pxP9gUGphv0Htz/Bv4YqHCK/fptACObmh5/raAC8r
	t93lrglmhhFxOdxeAMxIJQJP9Fm+ItPZQQ+Fu+60DrudI/cAZvKopomsMeAps8Yb
	rGqQOwE2IDrLfRrhJdSMBbSf4spuc67Awbx7KfVokEFxyvD1mPl7C0dMXwEI28Th
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c58722yek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 14:00:56 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 616J0t4m012658
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Feb 2026 14:00:55 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 14:00:55 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Feb 2026 14:00:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Feb 2026 14:00:54 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 616J0fQL008970;
	Fri, 6 Feb 2026 14:00:43 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v8 2/8] Docs: iio: ad4030: Add double PWM SPI offload doc
Date: Fri, 6 Feb 2026 16:00:40 -0300
Message-ID: <0dfcdf2c2018b1174f2057f0c66e336b0b550bab.1770403407.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1770403407.git.marcelo.schmitt@analog.com>
References: <cover.1770403407.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 83HkkueDhrqSw8jeIoCEjm3emVODsmGW
X-Proofpoint-GUID: 83HkkueDhrqSw8jeIoCEjm3emVODsmGW
X-Authority-Analysis: v=2.4 cv=eqzSD4pX c=1 sm=1 tr=0 ts=69863a68 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=wI1k2SEZAAAA:8 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8
 a=Z7BqY8bEq__jAXHbdh4A:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19
 a=6HWbV-4b7c7AdzY24d_u:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDE0MCBTYWx0ZWRfX+VVpo2ADRAP0
 tAKvPFG1KKoMspTgb5YqjRnTyhAKkfXZgyaCzxj/GE+GjP8C2jIx9KGMQg6E4oveXDpj6egguTj
 ZWDrCrIqiEEq87ETyovzfmBBLwu8PuH7WAZOCDaE5tkCPtpyO16TQpac861MvApzLt5NUARYqVI
 135/BayLzbLhiVDMR3A62bOkIobLY7i6110qUxrA7R3flarFwzVGqGQGJxuFnQengQ4Uqtqme2t
 K7zhDpmtvaxHuwswyedq/eXsz18uOVKeCDzky8H8iTxjU8TDXznRRDW+YvvDZuaUZ/RNU+jYupp
 579zInGZWzTim38ILCyR3hpNTBKtAeawbWl7nyyqSwGkvtWQ+uofeAGe64obn6t/+TowJ9UkJmc
 +cEmFQPSd28LlX+p0agRRKhEYxJu7sQnQJTFmlzO+fJ1nLur0AWAKKQnun1dnuICVi/ykm2Igts
 wd3lPMh5R+W5yPLWmpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602060140

Document double PWM setup SPI offload wiring schema.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/iio/ad4030.rst | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/iio/ad4030.rst b/Documentation/iio/ad4030.rst
index b57424b650a8..9caafa4148b0 100644
--- a/Documentation/iio/ad4030.rst
+++ b/Documentation/iio/ad4030.rst
@@ -92,6 +92,45 @@ Interleaved mode
 In this mode, both channels conversion results are bit interleaved one SDO line.
 As such the wiring is the same as `One lane mode`_.
 
+SPI offload wiring
+^^^^^^^^^^^^^^^^^^
+
+.. code-block::
+
+    +-------------+         +-------------+
+    |         CNV |<-----+--| GPIO        |
+    |             |      +--| PWM0        |
+    |             |         |             |
+    |             |      +--| PWM1        |
+    |             |      |  +-------------+
+    |             |      +->| TRIGGER     |
+    |          CS |<--------| CS          |
+    |             |         |             |
+    |     ADC     |         |     SPI     |
+    |             |         |             |
+    |         SDI |<--------| SDO         |
+    |         SDO |-------->| SDI         |
+    |        SCLK |<--------| SCLK        |
+    +-------------+         +-------------+
+
+In this mode, both the ``cnv-gpios`` and a ``pwms`` properties are required.
+The ``pwms`` property specifies the PWM that is connected to the ADC CNV pin.
+The SPI offload will have a ``trigger-sources`` property to indicate the SPI
+offload (PWM) trigger source. For AD4030 and similar ADCs, there are two
+possible data transfer zones for sample N. One of them (zone 1) starts after the
+data conversion for sample N is complete while the other one (zone 2) starts 9.8
+nanoseconds after the rising edge of CNV for sample N + 1.
+
+The configuration depicted in the above diagram is intended to perform data
+transfer in zone 2. To achieve high sample rates while meeting ADC timing
+requirements, an offset is added between the rising edges of PWM0 and PWM1 to
+delay the SPI transfer until 9.8 nanoseconds after CNV rising edge. This
+requires a specialized PWM controller that can provide such an offset.
+The `AD4630-FMC HDL project`_, for example, can be configured to sample AD4030
+data during zone 2 data read window.
+
+.. _AD4630-FMC HDL project: https://analogdevicesinc.github.io/hdl/projects/ad4630_fmc/index.html
+
 SPI Clock mode
 --------------
 
-- 
2.39.2

