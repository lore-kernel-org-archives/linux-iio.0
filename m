Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850F3AA9F4;
	Thu,  2 Jul 2026 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783028710; cv=none; b=uxzOBXCoEGiWhnJMv3b8gvxsc/imoTtddQKF4omRQzTiUop7Ilx41jzrj5VmAnn5FIdPYvG0NkHIqBZazsQVo6QDqv5NKe/6hHV64htVA1NPEk0eZzwE6U4O1sxIVUq6hCNDrejbzZg9mc0ULVl35HTdb/MvRARayAombitcsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783028710; c=relaxed/simple;
	bh=Mrb5GbMY5Ka5xRiV+ziIFs3WG6Ux4X0VvmytwKnL4Jc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XzdS7DIxWaJZYny/I4MXcH5W8LdGdCSJa197Hot4LrKMxKGRr8tmgVuh5u0BJoHgKAdWMR6sozeCvXnYp51dmXD/bTBJgupRa0NVlesun6nDIwLdj1QgzeNRtxG/vh8nhS0oI9+jYYLKyZjUVr6C+hl8MECOf/uH6tVKBSybXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=e8UgX8xM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="e8UgX8xM"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662IrQji3096189;
	Thu, 2 Jul 2026 17:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=mI7dYz7s1WwM+pF0JFZHe2XPr0b
	gMfh4LWN5M92krsg=; b=e8UgX8xMbZlrJNMxiO61IweYt8XtqpLmWSc3vYSANmq
	ZvSwjFsqVmlghGsRrYE1dKM+p//ZM8Hwa5fOQj4bXN3j0ravE+Xw0jgWyVm10o4I
	cKLmSxa+xU5dlLlMdp7mZpeNdFKSvMpHac9qceVBrX6yaawdZq8vgPfj/C/RwmYr
	E72z8apmHwiOA+zpMrEUFCCNY5NlLCqT7DKVc2gUA3Ay30ILbyB8y+t7lemJGf5v
	wLpzH7IVdE5Lt0i+8/JMt+oSVx6oXnZ98NpzCYp6iTE+dsETxjJqfN/pZP7Z4JDk
	2Yf10DPldogsal6+SX+xqltMNz/WVQxEmIS0BVkZIWg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4f5gd2cev4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 17:45:03 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 662Lj2dm051706
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 2 Jul 2026 17:45:02 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 2 Jul
 2026 17:45:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 2 Jul 2026 17:45:02 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 662LinPa007702;
	Thu, 2 Jul 2026 17:44:52 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 0/4] iio: adc: Add support for LTC2378 and similar ADCs
Date: Thu, 2 Jul 2026 18:44:41 -0300
Message-ID: <cover.1783028033.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: B6tOEC_gN4FcYNlHHE0mgIEwvl7FO4ci
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDIyNyBTYWx0ZWRfX/qUNNH2gRJSx
 HluizPJioFDaNAoxXHOezyIj1JsVYDDJ91UIX+hNszBKE+RXtwVjKt5hTFZ384RtpLZCKZ+vilA
 AyuN4+bVyPqCF+9ySlC7Sw5NFduj+o0RATWTwJVBSnn++uqo11osCItQJXNZ7VqSO7B/FPLFymh
 wkK60r73lzh24ejGo9cGtl/eYxQxgxeUpkUX1+JYUvV4RwluX3GFi+JLMmp36Xo7rMobXAVwfIK
 YhVt838UGvv0b9xH4sagVNJicrs6hoG1yVLrCutj5p5nGu/OWTFssc8Lwn0CLrTyAw385H+yCHz
 as7PCPZJBco9G4dMKTkBtMv/SGkmqueZ6FNGIa4fZmTPev2pwC5B7mDyNRLrWRTQpK1xMRadUQE
 9MmseNpe4l8LwOpZd1mkpzXoWJ8zV/qM3komKJu0VgTVLPxWtPS4oZzKnAyCVTvi2XYbZtVunWs
 ZRS//LZ05KfGSsrDs+A==
X-Authority-Analysis: v=2.4 cv=D7B37PRj c=1 sm=1 tr=0 ts=6a46dbdf cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=lDpQXWjbwPG5MlIezxMA:9
X-Proofpoint-ORIG-GUID: B6tOEC_gN4FcYNlHHE0mgIEwvl7FO4ci
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDIyNyBTYWx0ZWRfX6S7I6HI3sMin
 ypvTUk8fNgGmjT9zDrzrzPW1g+KPwu+dumeP3VZ6EhjaEQiClCPadJeHpC1yuXPFT6GXF40xTso
 G3pN39KWDovHTinWAvBEh0bv6RvgmpdyRBuoXMbzBzA2i3Exjzxs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020227

This patch series adds support for LTC2378 and similar low noise, low power,
high speed, successive approximation register (SAR) ADCs. These ADCs are similar
among each other, varying mainly on the amount of precision bits, maximum sample
rate, and input configuration (either fully differential or pseudo-differential).

Patch 1 adds device tree documentation for LTC2378.

Patch 2 enables single-shot sample read with a GPIO connected to the LTC2378 CNV pin.

Patch 3 enables high-speed data captures with SPI offloading.
The setup is similar to AD4030, with a specialized PWM generator being used both
for SPI offload triggering and conversion start signaling.

Patch 4 enables running buffered data captures without SPI offloading.

Even though these parts are somewhat similar to AD4000, the wiring configuration
for LTC parts is different as well as the available HDL for high speed sample
rate mode. Because of that, I propose creating a new device driver for
supporting LTC2378-like devices.

Specifications can be found at:
https://www.analog.com/media/en/technical-documentation/data-sheets/233818fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236416fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236418f.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236716fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236718f.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236816f.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236818f.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/236918fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237016fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237616fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237618fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237620fb.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237716fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237718fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237720fb.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237816fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237818fa.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237820fb.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/237918fb.pdf
https://www.analog.com/media/en/technical-documentation/data-sheets/238016fb.pdf

Previous submissions:
  v4: https://lore.kernel.org/linux-iio/cover.1782397418.git.marcelo.schmitt@analog.com/
  v3: https://lore.kernel.org/linux-iio/cover.1781661028.git.marcelo.schmitt@analog.com/
  v2: https://lore.kernel.org/linux-iio/cover.1779976379.git.marcelo.schmitt@analog.com/
  v1: https://lore.kernel.org/linux-iio/cover.1779117444.git.marcelo.schmitt1@gmail.com/

Change log v4 -> v5:
[DT]
- LTC2338 is slightly different from LTC2378 and, because of that, software
  can't really handle those the same way. No longer setting fallback for LTC2338.
[IIO]
- Took internal reference buffer amplification into account.
- Added checks for PWM parameters after both CNV and Offload trigger PWMs
  have been configured.
- Return EDOM instead of EIO when failing to achieve a specific PWM configuration.
- Set single-read transfer bits_per_word so the SPI subsystem re-arranges data
  to CPU endianness, enabling us to reuse offload_chan specifications for
  single-shot reads.
- Replaced open-coded check by in_range().
- Used conventional loop count decrement pattern instead of count increment.
- Renamed max_sample_rate_hz -> max_sample_rate_Hz.
- Dropped error message on devm_iio_triggered_buffer_setup() fail.
- A few other minor codestyle improvements.

Hopefully, this new version shall tackle all concerns and issues raised both by
human reviewers and sashiko.


With best regards,
Marcelo


Marcelo Schmitt (4):
  dt-bindings: iio: adc: Add ltc2378
  iio: adc: ltc2378: Add support for LTC2378-20 and similar ADCs
  iio: adc: ltc2378: Enable high-speed data capture
  iio: adc: ltc2378: Enable triggered buffer data capture

 .../bindings/iio/adc/adi,ltc2378.yaml         | 184 ++++
 MAINTAINERS                                   |   8 +
 drivers/iio/adc/Kconfig                       |  19 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ltc2378.c                     | 802 ++++++++++++++++++
 5 files changed, 1014 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
 create mode 100644 drivers/iio/adc/ltc2378.c


base-commit: cc746297b23e89bd5df9f91f3a0ca209e8991763
-- 
2.53.0

