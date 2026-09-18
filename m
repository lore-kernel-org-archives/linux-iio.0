Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D576334CFC6;
	Fri, 18 Sep 2026 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717023; cv=none; b=HFYpB9RS2HdgVKqwudh/JJP/1tnNpApPlyKOL3AZ0S703dIUd/9B+JuugO0IGFNO4Z4LAUySf+BMNEA6rBO/Co6cdjATx02/9P6VQskOZjcw6wpfobKoW61WdU3IF7SlYswuO7wwg9sfaQrbGxrZy9JB2Zv+v/1PPixH2/l+Xh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717023; c=relaxed/simple;
	bh=f9WYzTLiWKdzllNBYvR+OUb0QNBzZ3k/xWPwTZimHgM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBFCiaDmMZSgFbs4+FvXGFD82giSDxeaZakLKh/vvs3lzX5pGsrlgtrr/Gd9f0NWrtdhYYwrvwnTUzj8Rd7kvVDVGYBq4p2soFL9kL2EobCfP59IsmcMphGd3I9yyJqlRZDH9XnlVpZCPIaFlWHeroFonX7D4/Cq0UJSuV45YfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nvjBw6gQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nvjBw6gQ"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5wXws255494;
	Fri, 18 Sep 2026 03:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yPGhU
	A26BiVOxfNi60No7o3cxtmkRkHhIdkhUh7dIMk=; b=nvjBw6gQR8BJ9yB67p0M+
	9YY9gjRfhZQ2RkW+KNihcGyQV78wsAcDUlf3jQGuXHgsBBKx0enRx/RMGSpP5kcU
	sxp1dipNTWM3fv6NF3DB5Wp8xQENuy7H34rCQYGX3+Er6m6vXdRzSaGPKn211vqq
	j6D3xCPTjWwC8NVFyj2Nbgj0cOdlGWkgnDNhppsGLRhr20YOb1Z45+mDIHD7QUr1
	U3k0Gq+MusVTobhIa9NCvTjeiybEWbz7anJsehNpCYVfwzoPImQ4K+AE1VfnJp98
	Pqfl/N+sBHu+5U4XPVS7/VHWLpKGQ1R5/K29RjTN2SvJAmUfCTuwwESJuCpCU/kN
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4grm943dbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 03:36:31 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68I7aU52011086
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Sep 2026 03:36:30 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 18 Sep 2026 03:36:30 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 18 Sep 2026 03:36:30 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 18 Sep 2026 03:36:30 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.219])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68I7ZjpY019677;
	Fri, 18 Sep 2026 03:36:22 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
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
        Radu Sabau <radu.sabau@analog.com>, Salih Erim
	<salih.erim@amd.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
        "Jakub Szczudlo" <jakubszczudlo40@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH v2 6/6] docs: iio: ade9000: document ADE9430 support
Date: Fri, 18 Sep 2026 10:35:35 +0300
Message-ID: <20260918073537.1572-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918073537.1572-1-antoniu.miclaus@analog.com>
References: <20260918073537.1572-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=AcckjHXG c=1 sm=1 tr=0 ts=6aace9ff cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=vQEn8HwnhkxuN93CXDYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfX4pLF9LMfYJ1Q
 t+1RUpHUmzt/hjZ6VwZR+HUvw/eNP8KU6MI3iocCzTcPHFAdxIPqlzuGhQgfXnuiuhkgElH9Cz/
 VgX7eTw2551sF5SFLobAUI0z+UsSZc3tprh/Y45akQ/c/wa46Ds8
X-Proofpoint-ORIG-GUID: YTvAoYu1QUyd7ABu7DvuGLCqal5AKYYy
X-Proofpoint-GUID: YTvAoYu1QUyd7ABu7DvuGLCqal5AKYYy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwMiBTYWx0ZWRfX7yv2dstVrW4i
 sHiHkpmm9FLEov23K88DpnGH1v5MnLsv0KTGHaMRh0pqk+dH9JCbZMJ2CZmDN/S/UFDrhshmXYe
 6oC3gsuoN7MaZAK86vHy6aEMd5vPpRQGEeLlBJygf4INJl0gK7uQ1dat7Cz7/SoiXhtEQ57aWcl
 5a9pnPOl1ex1Vpu3Enk30ST5KMpyrIA+h7eYSphz3DsNzDqCQujlGWnZUSA4CdRpzE0kSc8qwb6
 YKJzXD9qdAh/kevX+ZD7GuKkt1DEvJtW6GLhA/Fq8V8N3lkf1pWF5KJ3diQqp0VEHMiSh/0+nzy
 cnisbxitdyK4ZiVxedxc6FDanBNjU4IH+cChcG7LGDnR17A7NLlTYnfk+x6Hlvt2ciq4qFfcuCl
 Lhp7DyqDHGYUvJHGjtpnjF2ntNP3E3PTGCiQH1A8v10K3GuLyFo51C1MD5blCWpzrKZCmmnqCws
 QSnv6FRY4PM9BKtf4Tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180102

Add the ADE9430 to the list of supported devices and note that, like the
ADE9078, it does not provide the on-chip dip/swell voltage events. Also
note that the ADE9430 has no on-chip digital integrator and instead uses
an external analog integrator for Rogowski coils.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v2:
- reword the intro to "The supported parts are..." so it does not need
  updating for each new part.

 Documentation/iio/ade9000.rst | 36 ++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
index 72737b5ec59c..f518bc1cc3cd 100644
--- a/Documentation/iio/ade9000.rst
+++ b/Documentation/iio/ade9000.rst
@@ -1,29 +1,31 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-======================
-ADE9000/ADE9078 driver
-======================
+==============================
+ADE9000/ADE9078/ADE9430 driver
+==============================
 
-This driver supports Analog Device's ADE9000 and ADE9078 energy measurement
-ICs on SPI bus.
+This driver supports Analog Device's ADE9000, ADE9078 and ADE9430 energy
+measurement ICs on SPI bus.
 
 1. Supported devices
 ====================
 
 * `ADE9000 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf>`_
 * `ADE9078 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9078.pdf>`_
-
-The ADE9000 and ADE9078 are highly accurate, fully integrated, multiphase energy
-and power quality monitoring devices. Superior analog performance and a digital
-signal processing (DSP) core enable accurate energy monitoring over a wide
-dynamic range. An integrated high end reference ensures low drift over
-temperature with a combined drift of less than ±25 ppm/°C maximum for the entire
-channel including a programmable gain amplifier (PGA) and an analog-to-digital
-converter (ADC).
-
-The ADE9078 does not provide the on-chip dip/swell (sag) detection available on
-the ADE9000, so the RMS voltage swell/dip events described below are only
-available on the ADE9000.
+* `ADE9430 <https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9430.pdf>`_
+
+The supported parts are highly accurate, fully integrated,
+multiphase energy and power quality monitoring devices. Superior analog
+performance and a digital signal processing (DSP) core enable accurate energy
+monitoring over a wide dynamic range. An integrated high end reference ensures
+low drift over temperature with a combined drift of less than ±25 ppm/°C maximum
+for the entire channel including a programmable gain amplifier (PGA) and an
+analog-to-digital converter (ADC).
+
+The ADE9078 and ADE9430 do not provide the on-chip dip/swell (sag) detection
+available on the ADE9000, so the RMS voltage swell/dip events described below are
+only available on the ADE9000. The ADE9430 additionally has no on-chip digital
+integrator and instead uses an external analog integrator for Rogowski coils.
 
 2. Device attributes
 ====================
-- 
2.43.0

