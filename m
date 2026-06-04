Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FAC3DE42D;
	Thu,  4 Jun 2026 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557271; cv=none; b=Dsb5h/fCV4ptVnQzpejPArpfvWRKA/OHLHDFXzs1b3A1oDMwrjTd4NDSks9DqkGyvD86PiVc0JaTq47hiYvOQfjg/3zB0zuYY82RfOtHNrGbxh3DiFCbNEqM8maT1qqD6LoYNARAxoFU/FYF0aOSjkBKYNigNDmL1c5fKIucai8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557271; c=relaxed/simple;
	bh=jFuM5C+IjBabb0VfDLYDd6JB/mZ5b5npmqYEpPug8wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TMYA3UlpEykZhNJC3uOIs+GvL6/+mcNpfN28AHy19qa0ln4aSmmCHxDaKVF6mol0MkfFZNceF690e3pPf1T5UPRfzwSalhdoAtFjqv/lKGSx6U3zBxCND5VnujTKSC9Rf7YnHzhf/IyaQk2OLtbGV1gpS3yx0ZXOx97IaSzhMtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1coL638R; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1coL638R"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65421AFe1177908;
	Thu, 4 Jun 2026 03:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mnqma
	exz0zcR9J6xnZf1AOICfDENQ5T/2HlyVWPfFg0=; b=1coL638R2DYPylK5plekm
	nuong+1BN9vtoS89IHZd2ZHFsBCa7a+F3oBOxC4kHsZIDJ7zF62iDjDQIclIIOs6
	r2xVTo2BIupUZc6wdFjSrQgajgBSLJrEMoY9hJpV9sPHqbl8VPULYrzg22qJrDx5
	U2TIZU3Gi6wSZ9EoFtZfxvIac0FxWsWZtY0GnDE1henSIwa6DCCi/02Z7ojZMHi4
	q3FpAFb9vkGyYZmFu2pwIVM+c7WEr9q4DX99wd0MJwnYjoB5ArzINNql97k5XwuQ
	+Vdur1MLcF/SvflZM/zxx+nm5mK9SRYTzHg7uFMo3xC+eRNyDNPJs2cToSZ3Rx2g
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ej7emxmvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 03:14:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6547EKaG042114
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Jun 2026 03:14:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 4 Jun
 2026 03:14:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 4 Jun 2026 03:14:20 -0400
Received: from analog.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6547Dv9M020350;
	Thu, 4 Jun 2026 03:14:09 -0400
From: Kim Seer Paller <kimseer.paller@analog.com>
Date: Thu, 4 Jun 2026 15:13:43 +0800
Subject: [PATCH 1/3] iio: ABI: add DAC 10kohm_to_gnd powerdown mode
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260604-iio-ad3532r-support-v1-1-c3552f9031de@analog.com>
References: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
In-Reply-To: <20260604-iio-ad3532r-support-v1-0-c3552f9031de@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux@analog.com>, <devicetree@vger.kernel.org>,
        Kim Seer Paller
	<kimseer.paller@analog.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780557237; l=932;
 i=kimseer.paller@analog.com; s=20250213; h=from:subject:message-id;
 bh=jFuM5C+IjBabb0VfDLYDd6JB/mZ5b5npmqYEpPug8wE=;
 b=P78y+Rn+t9WXJtmhHtGAi6SMMOhuedB4zFiObiKWOzINtzxKsVtZGZswkI0aV+1YyNpNTqaM6
 Cipbj8NetU7AyC4GUhsy6dwPjsmSaU2DtwXQW7efThaEFE2D246jKNP
X-Developer-Key: i=kimseer.paller@analog.com; a=ed25519;
 pk=SPXIwGLg4GFKUNfuAavY+YhSDsx+Q+NwGLceiKwm8Ac=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: yk030j48PrsG_V07G0gI8CnauVjd00xz
X-Authority-Analysis: v=2.4 cv=LsaiDHdc c=1 sm=1 tr=0 ts=6a2125ce cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=c9qRhK4E6t9TYzrPtjYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yk030j48PrsG_V07G0gI8CnauVjd00xz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA2OSBTYWx0ZWRfX/RQGcKXrxCn8
 9jKsot2jyFxHUwcdb3uKfJ+2BZn69W6Yb8v7jRAeb+RY6sTDvp0QlhqdgbbjGe4q6JDr0boSrdp
 IeuNjyFc8LCiHqwEOiVu9Gu4qvYBULRyxKF1Wv3T1By8t08DuaHyOQHoHmkYKhcrlBcPnxV5376
 TddifBBmIB9ejIbRgZoWAIR32Pk/zGwqOo0gSjXJMd7uXySq8wuNk0O8aD6pyP5v38GWutudvMo
 kgFqtKWOrkRv08iPystjeWr4PkZj1/NWZbtNepR5x7gaq1NYEhl+O6w8N5fEsl1PWm9k+2CgyKB
 wNj0e3cRiZck4pwhS7fukdzv2pJsyPocf5PPtwn2ZHFdKiHf5lV7CSis0YxVeV2f8Znzwfjavvz
 Lu44arbJdLhf/ohG/Hc00BnTgRVZGr16FAPHV+XOhxfOQjceESQDMpitGMwmrsuW2+OIwKGDhFw
 2rx5XAGKnYEHXlQAaPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040069

Add a new powerdown mode for DACs with 10kohm resistor to GND.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index d8d6d85235b0..67446cd37183 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -770,6 +770,7 @@ Description:
 		3.85kohm_to_gnd: connected to ground via a 3.85kOhm resistor,
 		6kohm_to_gnd: connected to ground via a 6kOhm resistor,
 		7.7kohm_to_gnd: connected to ground via a 7.7kOhm resistor,
+		10kohm_to_gnd: connected to ground via a 10kOhm resistor,
 		16kohm_to_gnd: connected to ground via a 16kOhm resistor,
 		20kohm_to_gnd: connected to ground via a 20kOhm resistor,
 		32kohm_to_gnd: connected to ground via a 32kOhm resistor,

-- 
2.34.1

