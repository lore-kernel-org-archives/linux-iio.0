Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950815;
	b=oAmhc7ApLiet6tAhn5Uw3eu8a1c+cuAG7d8iYBP7IThs2Qgy0V5YowZcYsRme69t9Z0T
	 kp6hpdO9xIvdSdy2A1HWyD66YXMYUhBCr/qcuSbufYBoaxwTiLlMXrkyyrBJRAz3G9ciQ
	 UKYo2tWX9xag+OWQsoquCNnCrDScjUArjTejhjSqbxy05qZ03qvQbQKrVviFhG8Yj5Uvx
	 JT/6HaEWioC/NAKktEbcIz1gmRqbcZwpQYbNUl2lS3PryvWHc+Mt3EAioyyAVCwnKewCT
	 3Ey0Wz4WzhOjQ8f9UyKvBIWsLqdZcZR/yNaAeLyYq7Jl7GGmqtyl2PelBgRD55wsWEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950815;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=oTvMFWwhoyx2PgW7whCerPeOhyJWytvFlvp0wlwTWPk=;
	b=SSb4sZQpd0DOKlBkTZsKinJHtK13xatDCC4GcSjB2QFAo+5JaNeVvIXDPYjnrgYC0gm+
	 e+Iymv8cNb7MgWvBKS5AMnLVnaYXkUxRRIGKmPB0J4ByLEzku9WS6hCQLHtlL1F6XnppV
	 2qZ2gGvg1pDa8q6r1DepjTJuXefTbqisr/Vf/jNarSJg4G5kkKISZXXPXpOIDuSxykchT
	 FWgEEq5a5FkQ2aGSKUQ3TE5EH7AmfFaIb5d62x4D2O+Y+ZctZdK8s6a7wJwIDy13jzU1B
	 Nmhso+rFAfzwtasM/2STvmOfquALyXvVm1Fbm1mAK4To+qbXnNWdRLyg2vqUl/2HAZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ou5qesbD;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=e16c5eD8;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D530606A326;
	Fri,  6 Nov 2026 07:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D530606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ou5qesbD;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=e16c5eD8
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67RAqn4082433;
	Fri, 6 Nov 2026 02:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=oTvMFWwhoyx2PgW7whCerPeOhyJWytvFlvp0wlwTWPk=; b=ou5qesb
	Di1rFyZBXEmzMfJL16eXbixiVx/P6O0VBm1/oWzbvtNtKo9n6KIFmHPpFmhhT3un
	pu/nrswVH4Xp1E6LiqKglu05gqp8++XWYgW33BnMACJxN1k7bE9oSqctb+dzhc3n
	M7KUE/sM/8qDmnaca7T+4KnnBbf4q+y0SSyrke4mIzFmRJM+xfYJLgi4ehK7lkl2
	AXBHUY23idicWuqh2v7qfD4JXOqye3cR2j/bFMZBqslM4Wq+ZcDMTGfzLvMtJw7U
	3RO+/eBQJlvvCMUKcSQG3KxcBUlSI+dnMDQs6srAd1Qvc7lN+mqHpQlk3sVjorul
	uY5rqhlHOJhHJcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oTvMF
	Wwhoyx2PgW7whCerPeOhyJWytvFlvp0wlwTWPk=; b=e16c5eD8Qhml+Qpesg66d
	Tb18ByLlR1IjYWJEqart6SwUl2GqwACzNhNfyqJxGT9zFHX1iPrrWmGEtHH5HChG
	fQnAGrpmuOeWXe4a6oOQgfWjKPTh5J1VUoNhPa6Tdve6PeE3r9cDCY1pKSO2c92M
	6BbDMMPgD2ZEAqkp6wwZhYFum3uvMJ1x4m1N2UAIgUd54XKHslilxqvs+xRNwMOB
	84lDSbgZN1EcmbE6WaWRq//44wt/FSTpltl309h81bibj+sLI/SmunQdjSnw5nvo
	EZ3awI5adVvsD8tWIBXO0hXqdoHErhUPyJaU/68aKzcTlq/UInzg+VYj7H9KyblO
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3q02ewf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 02:40:11 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A67eAZi029354
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 02:40:10 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Nov
 2026 02:40:10 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 02:40:10 -0500
Received: from HYB-0FPP35J6CsI ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A67dxXb028691;
	Fri, 6 Nov 2026 02:40:01 -0500
From: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
To: <jic23@kernel.org>
CC: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dragos
 Bogdan <dragos.bogdan@analog.com>,
        Ioan Daniel <pop.ioan-daniel@analog.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: ad7405: Add ADuM7801/7802/7811/7812 support
Date: Fri, 6 Nov 2026 09:39:36 +0200
Message-ID: <20261106073937.13927-2-pop.ioan-daniel@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106073937.13927-1-pop.ioan-daniel@analog.com>
References: <20261106073937.13927-1-pop.ioan-daniel@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: yJnKEryyML1EEYLuOOcjlhjGiVq_B4mx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzMCBTYWx0ZWRfXyMc9IKH+WQZd
 SGy9XsDVcsY1GS3CvbUDeyZY4jvzCtzpPIEtWSNPKEmp3M/kJ+LbCa7oltOXvJutu/TB4aPnFRf
 8vsE/mcgmKCufutcUp1bhFyB6++KnjT5Ikw3lvsdSvuQZtapC1um
X-Authority-Analysis: v=2.4 cv=Lt8HWXdc c=1 sm=1 tr=0 ts=6aed845b cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=MMREOpu7j-QvK7y3GyIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yJnKEryyML1EEYLuOOcjlhjGiVq_B4mx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzMCBTYWx0ZWRfX7MCL55do3t+h
 aaXm3WhtWDMgSIOubvVL5qZIzyrkPqZoYd3DDEtmM4dfJYeOVdxTREeI6pOvD43Su/s2wOP+5EC
 dEMA6K2vq6qUEWSMqkNAoCMbLve5dp4qQI2oc/P0jZOk8CP4fPX8N8ZtGaEtFGZVqQpPSa+HaSb
 Imz/8NF9wnHScM4RlV71aw/UtA/hHlm1WiHgpDKVJAilM1jwNLrWffhaGpgiHMbM1RRdRd0y0O1
 gRnYYgjcOKHRjWc8PWPF/wnV4IDjNFObGDIeZo6NJaCJ4eP2ujA8+vvz/iFwLYQSBrQDXe6mnPJ
 RWSK50/+B5w/PlLH1xV9ayHNZKNfXSAlNCyUkU+ho5iWhb4Y+9pfR2rroCZfSqlMYkFRS9lu/rz
 We5NqHk7WfvGD5tmUR6XggvkwV8HATuHkbW40fBUhlJB5WPIPNUvPnFzVP+laWwOxQq1H3nrqPa
 MTf8doxkeuZNHpIWDFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060030

Add compatible strings for the ADuM7801, ADuM7802, ADuM7811 and
ADuM7812 16-bit isolated sigma-delta modulators.

The ADuM7801 and ADuM7811 have the same ±320 mV full-scale input range
as the ADuM7701, and the ADuM7802 and ADuM7812 have the same ±64 mV
full-scale input range as the ADuM7702. Apart from that, software
handles them the same way. The ADuM780x support a master clock of up
to 25 MHz and the ADuM781x of up to 50 MHz, which needs no special
handling. Use the ADuM7701 and ADuM7702 as fallback compatibles.

Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
---
changes in v3:
 - none

 .../bindings/iio/adc/adi,ad7405.yaml          | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
index 57f0970257050..41eef107e9f0d 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7405.yaml
@@ -20,14 +20,29 @@ description: |
   https://www.analog.com/media/en/technical-documentation/data-sheets/adum7701.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/adum7702.pdf
   https://www.analog.com/media/en/technical-documentation/data-sheets/ADuM7703.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7801.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7802.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7811.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/adum7812.pdf
 
 properties:
   compatible:
-    enum:
-      - adi,ad7405
-      - adi,adum7701
-      - adi,adum7702
-      - adi,adum7703
+    oneOf:
+      - enum:
+          - adi,ad7405
+          - adi,adum7701
+          - adi,adum7702
+          - adi,adum7703
+      - items:
+          - enum:
+              - adi,adum7801
+              - adi,adum7811
+          - const: adi,adum7701
+      - items:
+          - enum:
+              - adi,adum7802
+              - adi,adum7812
+          - const: adi,adum7702
 
   clocks:
     maxItems: 1
-- 
2.34.1

