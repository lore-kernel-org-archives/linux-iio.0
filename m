Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC83AFB0E;
	Mon, 12 Oct 2026 11:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803731; cv=none; b=ILGLK2IDlIhPlw81dTbcxeH0BOefyS49h/pAJUlCvL9W+MKYU8G+BShskew8ZATRXs6esBwOa7etAhufDxfdgqomXgzUh4wEibwf95VoQJrnHlvhg4R2iuaHguH6Wv22Nxfh/tgJXy+B1+zBBrOP3+p+ruCMEsvfMlpNwcuVrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803731; c=relaxed/simple;
	bh=AetfAzfMW9eI8ej4UQSf2QxQz3gjKiAjMz7wQr33ogQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dy4JRnWmzG5Fuh5mqSo1OdTwX51SaDxMm7lJisijoAWh/w8ub8/aQQKdkAJCeTxNozQ5va+gxEKl4hw3wmL7HN2RAyMTapOGiSgt3X/fWjE7BFLnNu4e1T0HyDbadrtCOIfqyNGJZWxW7JyIOoF6EathoDaqR2zyLFCdRAPCJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=NsOp79rC; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XV+CUnrc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="NsOp79rC";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XV+CUnrc"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8O4Hs1120779;
	Mon, 12 Oct 2026 07:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XQLeI
	BhguiENulMSRzhvETb2zDly9dyeohigubSFX/A=; b=NsOp79rCVnoLk4mT9vUmn
	zTZsYxgfrtuuc+JoLX7DORTsqnnzVwt5V0HBAvCJurttBqpXAqhyfWmRbxEunFYG
	xEGrEpJ7iyNy9tMyhicm4bFoNYnEhuJVU8JRn5VzkSHa6OZY2eE9H8k4ABniK4U+
	bmZ4zI/Huda6+RAWKvPVVsLJcjs5rTW5sR/wpD7KJRSKf5qRXwop4rfcfTdwZUrT
	RDFsPiePuyhZol5DUrf1UzygvlNDsPKm2M0KWpMsrYvkG4A4Al00lEf9kurmh27g
	rmQZ4TGGaEeWaPY3d7X6jJwoQpnH4JxoO0vuG2TX+She6Fi0iaOoexCZ9DUsoHOF
	w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XQLeI
	BhguiENulMSRzhvETb2zDly9dyeohigubSFX/A=; b=XV+CUnrcBrNPfO3fkS/cm
	E5AJTWbffAKv+w4MtUvKKxaxE/nAEj8ZcmbruBsSKcy3GxdKlGj2r2M0MruJjYpX
	jkAI58N4Cw6K78zsp6DtnL+5Wp16uLZHCgJ7cZA/mQ0XE23C09D0TEcrRzCFOWcE
	p3Gf1FTOOhoUdi4qq1rA5yRf8tyR8ZubwG5VaxIYcSU8NVzkhJpEbyCm2ucyZ9BI
	QbT0ikOmWNHYOQ637OsLwFNc5aLSWBXeuFwda93H6FDinN8m1vnKxTTo1eOWj1mJ
	Gtdia8hKmmGN4rHzm3Hhald49fiyN8rs0aEe9c9qUKY0TrIXUIDsNGch+zdVjfMO
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4h83pe74g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 07:15:16 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69CBFEfg046510
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Oct 2026 07:15:15 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 12 Oct 2026 07:15:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 12 Oct 2026 07:15:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 12 Oct 2026 07:15:14 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.223.86])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69CBE1X2024898;
	Mon, 12 Oct 2026 07:15:01 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Shuah
 Khan" <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Joshua Crofts
	<joshua.crofts1@gmail.com>,
        Radu Sabau <radu.sabau@analog.com>,
        Janani Sunil
	<janani.sunil@analog.com>,
        Salih Erim <salih.erim@amd.com>,
        Jishnu Prakash
	<jishnu.prakash@oss.qualcomm.com>,
        Jakub Szczudlo
	<jakubszczudlo40@gmail.com>, <linux@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH 4/4] docs: iio: ade9000: document ADE9039 support
Date: Mon, 12 Oct 2026 14:13:40 +0300
Message-ID: <20261012111342.48040-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012111342.48040-1-antoniu.miclaus@analog.com>
References: <20261012111342.48040-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX4tkWTpklXP45
 wK1UvV2GqM9ie3Q66Z1cmTZiYWbWJCQOKx8bvfMLxkPUIkda8yz89yjwfg35lHeYZ4JvGv+wicA
 uuDny2qASifjscSLwo8/pG9nGQhmLSVRRFkOyMWBtKqZsbvRXQZaXoV5WrcDhNEcZipl9+375dA
 OGGhvSl1yB21eLilLXvzbv4zqfYeESNR81XFSX+C7+hhH5d5N1Dzu3uwDXqtdGHmCOZ9u5w1P4v
 +JfqCrnU9XxHzzBoePVaNecEIqki6xFUBFM6NBJ0033vbi4v9ufFcwkGAgAHlHmXoLDJvpEhBXh
 2c/70RsR9D9m1CtYMGmt57oP5QP6M37PWeMvtj6q2vZ5acJV/SDkY6b2Zcei265xfXIBykb7B5H
 4WkarXrgCCYZeJIwSAMFvQZsUsxxqZJPjPd5Dgkq4rwO3dvNaNlSVAiK1YETRAZ5XfB5S2ruL1O
 ZcKXIddjPzccnnkRLdA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX4eFR2rokqV7N
 MS7z5+y5wwVYcTaJVSevAxEYZQluEPat7KvtkvJtIaUrVhiY0jceg0UbJ6ctJamixI/FAhyOUeV
 /TP0Scmo88NrjmiInR/v5sIEPZazlj5H544m+SME7UHeBeIOM08w
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6accc144 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=5qFyOXjBKZGy-C4q3JkA:9
X-Proofpoint-ORIG-GUID: 3PVqU4A2nRwxOWM7O4TrIowrsGeUNy5Y
X-Proofpoint-GUID: 3PVqU4A2nRwxOWM7O4TrIowrsGeUNy5Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120044

Add the ADE9039 to the list of supported devices and note that, unlike the
ADE9078 and ADE9430, it does provide the on-chip dip/swell events. Also
document that it exposes no total reactive power attributes, since the part
computes only fundamental reactive power.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/iio/ade9000.rst | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
index 0c0a8ea8213b..13b7ecf83cb8 100644
--- a/Documentation/iio/ade9000.rst
+++ b/Documentation/iio/ade9000.rst
@@ -1,12 +1,11 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-==============================
-ADE9000/ADE9078/ADE9430 driver
-==============================
+======================================
+ADE9000/ADE9078/ADE9430/ADE9039 driver
+======================================
 
-+This driver supports Analog Devices' ADE9000, ADE9078 and ADE9430 energy
-+measurement ICs on SPI bus.
-ICs on SPI bus.
+This driver supports Analog Devices' ADE9000, ADE9078, ADE9430 and ADE9039
+energy measurement ICs on SPI bus.
 
 1. Supported devices
 ====================
@@ -14,6 +13,7 @@ ICs on SPI bus.
 * `ADE9000 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf>`_
 * `ADE9078 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf>`_
 * `ADE9430 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9430.pdf>`_
+* `ADE9039 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9039.pdf>`_
 
 The supported parts are highly accurate, fully integrated,
 multiphase energy and power quality monitoring devices. Superior analog
@@ -24,9 +24,15 @@ for the entire channel including a programmable gain amplifier (PGA) and an
 analog-to-digital converter (ADC).
 
 The ADE9078 and ADE9430 do not provide the on-chip dip/swell (sag) detection
-available on the ADE9000, so the RMS voltage swell/dip events described below are
-only available on the ADE9000. The ADE9430 additionally has no on-chip digital
-integrator and instead uses an external analog integrator for Rogowski coils.
+available on the ADE9000 and the ADE9039, so the RMS voltage swell/dip events
+described below are only available on those two parts. The ADE9430 additionally
+has no on-chip digital integrator and instead uses an external analog integrator
+for Rogowski coils.
+
+The ADE9039 computes only fundamental reactive power and has no total reactive
+power register, so the ``in_power[0-2]_reactive_*`` files described below are
+not present on that part. The reactive energy files are unaffected, as every
+supported part accumulates fundamental reactive energy.
 
 2. Device attributes
 ====================
-- 
2.43.0

