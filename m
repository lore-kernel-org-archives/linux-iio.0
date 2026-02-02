Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42D36213F;
	Mon,  2 Feb 2026 11:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031765; cv=none; b=fFX1mMwtcFrQq7YZ6zvnTGI7RxzNc6AwYJUpiL6zOGMWo1PlOsuqorf4TMzbGEcxQSLNI1FtkjdFgWZXJ36QQlj46br0jqyWafL/IHqWAROCZnCMOWg/NMsEsuaKu3DxB7yrpf+RwlyZmmlxDso6f5h+FN24R5jxaadCAhspm8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031765; c=relaxed/simple;
	bh=qpXtUrvtDuj7XbSPJ3HyZkCY7zIiF9VCp3Q/cYkAMLI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CKoNFTaV6mh7w6wDojkmY/BDL+KXK6n50ASNU1bD054kazsdG7T7dN/19BhyB5X7pJrT/hskoUQvkGmGczNhyOESoDXNYS2DZo/DJTpfDrMES9kBqJMSkkMnOVAzMdcIMxFNqcL6p8mLpo+v12IZfBhGF3mSFezUr6iRyt7ypY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vGsnZ59l; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vGsnZ59l"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6126Tpgi3183972;
	Mon, 2 Feb 2026 06:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=jgLb5/HC5WUYVVtRG/gYhi773Mw
	AhwmrLhNlJyWURG8=; b=vGsnZ59lircNFdWhXbPed7AfszPWFa/pOx4d46j/ShU
	PIQHBBbyMcR8BWURNip1FujeZo4A+vnp8utYiyvaGCZ87YNWevgshNVnIDsAFOiG
	psH9FnsHBR21Gdk0jlA6iTBdxPaZFe5Q4pkF3tiQWEGduonfmTHsijjm7SxDxDXh
	tWRlkSuvPdPWc/ZvHf+OQxEq7uVKMiG1VjTj/KLb7sRWWmz3snO5a1evC/T2MlXK
	2PX3X3gXc7gHPFGxoTjsjQKsO2zwqzukRBTWx0crL799jqXwRl9BrD7JAIsoyTvx
	UYJFkKlcwP3X69Khi3VZvM4X/2OMzkh7nC96oPPqDWg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4c1fh4x949-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 06:28:41 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 612BSe3T050060
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Feb 2026 06:28:40 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 2 Feb
 2026 06:28:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Feb 2026 06:28:40 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 612BSK48004681;
	Mon, 2 Feb 2026 06:28:22 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Subhajit Ghosh
	<subhajit.ghosh@tweaklogic.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Fabio Estevam <festevam@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>,
        Eugene Zaikonnikov <ez@norphonic.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 00/13] iio: remove unused struct fields across drivers
Date: Mon, 2 Feb 2026 13:25:50 +0200
Message-ID: <cover.1770030812.git.antoniu.miclaus@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDA5MCBTYWx0ZWRfXxLOfpxLbW/6Q
 5Qs9CpkgiLa8D8Rhi8HXw5WEjxYKvRz/5W94qD1fopUjQbPIUucIYgZC4leBhkXMSHILyXMVLzZ
 UQYQgE/FMEushJpOxgGTmrrdVEFqAQsB3QPdSJ/IKodm0H+idlSXTcfdNH5czFQi7ylfYA9Sko9
 DfK+Js6X9ScocHIiU1sa8LZZNjERnrPbzUADBjyEmdY2VA1lKlPQU70M6+0/rmraktJI8DL03BU
 7tLOc8kNyOXYLjduWkEvmAX7BWclPhri0oTa/y0fyG6CtuV2GiaN+b+jbSbwGG9S8+wDf7A6SqA
 kNgxinU6Hwnuk78AtvNF9f5RYxOwtnY0TzcIt0vDl85xpj3gxjGwvEn1IrXJKbbUbrdPLKdxJ16
 D1UC2L+k62NQ7OVLbgRF8wDvtLcsM2Tl2WDEkd4aNKqU2GoF7R2J6l1vVDJyyUaN1CZe/08QiQt
 pf9pJf43Ih4LtTQtOJg==
X-Authority-Analysis: v=2.4 cv=Vqouwu2n c=1 sm=1 tr=0 ts=69808a69 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=FVXSjC-vzaeynCSspNEA:9
X-Proofpoint-ORIG-GUID: 48FAg4BlJfLCvMXGPEJ7Bf5YL9PSjvYd
X-Proofpoint-GUID: 48FAg4BlJfLCvMXGPEJ7Bf5YL9PSjvYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020090

This series removes unused struct fields found across various IIO
drivers. These fields were either left over from previous refactoring,
or were added during development but never actually used.

Removing them reduces memory footprint slightly and improves code
clarity by eliminating dead struct members that could confuse future
readers.

Each patch is independent and can be merged separately as they touch
different drivers with no dependencies between them.

Changes since v1:
- Reformatted as proper series with cover letter and numbering

Antoniu Miclaus (13):
  iio: adc: ad4080: remove unused dec_rate field
  iio: adc: ad7768-1: remove unused mclk_div field
  iio: adc: ad7793: remove unused int_vref_mv field
  iio: adc: ad9467: remove unused output_mode field
  iio: adc: max1363: remove unused requestedmask field
  iio: adc: nau7802: remove unused min_conversions field
  iio: adc: ti-ads1015: remove unused enabled field
  iio: dac: adi-axi-dac: remove unused int_tone field
  iio: dac: ti-dac5571: remove unused id field
  iio: humidity: hdc2010: remove unused interrupt_config
  iio: imu: bmi323: remove unused drdy_trigger_enabled
  iio: light: apds9306: remove unused nlux_per_count
  iio: light: gp2ap020a00f: remove unused debug_reg_addr

 drivers/iio/adc/ad4080.c             | 1 -
 drivers/iio/adc/ad7768-1.c           | 1 -
 drivers/iio/adc/ad7793.c             | 1 -
 drivers/iio/adc/ad9467.c             | 1 -
 drivers/iio/adc/max1363.c            | 2 --
 drivers/iio/adc/nau7802.c            | 1 -
 drivers/iio/adc/ti-ads1015.c         | 1 -
 drivers/iio/dac/adi-axi-dac.c        | 1 -
 drivers/iio/dac/ti-dac5571.c         | 1 -
 drivers/iio/humidity/hdc2010.c       | 1 -
 drivers/iio/imu/bmi323/bmi323_core.c | 1 -
 drivers/iio/light/apds9306.c         | 2 --
 drivers/iio/light/gp2ap020a00f.c     | 1 -
 13 files changed, 15 deletions(-)

-- 
2.43.0

