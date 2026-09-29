Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0334F6468;
	Tue, 29 Sep 2026 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721746; cv=none; b=pSuSy83IhpKvMF9aEWs4nhK6bTSRU2Qv4deTutztZrn7mTIPfKK/EfHS/j6P/LPzKpbopC/nfkkSjTjAcKWdQjUjPqwotMM2PMF5gObI2KCKV1PYX3nt5ic+7dRDlpQbU52LDkQwXWnOH3825HnqBOKpIJxZPXAm8qHbu7AWMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721746; c=relaxed/simple;
	bh=a0Svcz/LByZ43zqboUS//M8AMlcP/p7A4LF3WOB4ZKg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bhj0VRimw5+X/ixTvJj/Of4anUQVFETbAN/74SRKAt1onOxC1JkAsf1KqKE9EjTn6lr++YuK8Twj9oJhL1u5rIDRgSSONQfkGeP1FPMtuziVPg2c9ypOfDEtOjDw5MyW+cRU1Lo5p02pNfdonYadxEaknWOZUQIed6P13ReDGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lPpdlYwo; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lPpdlYwo"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TJZHkC1297578;
	Tue, 29 Sep 2026 18:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=hawuGYQH9XS7tcHf6DWea8B+7e/
	/LsFnWfGvpX2wOvM=; b=lPpdlYwojguFPI/al2MUww9Bu25hWivQ7suVWY6yNr+
	nzGgAS/MQ+97C/S4chX4oP6itsWZBGk8h85LDBaBKLdXfkHeuni2S5YLaGpnJAFk
	0P0ILxlWoOASjSOS68JNc/ufjMDfRNRtYRGqc2RtbHv1dM0V6XWzm4ddtwcYt6Up
	GyeqFYH5L+2s+MCzP/afBPMawaXt5KA8KGh81+7qserN8ARIt07+mhHzYlV4hD6e
	5Af9evY6ybOUXppQNg50w5yv9SPk260cFUr5/JZDWBedT49iiCgxlayJ65AYeft0
	1obzo2FX438OJG95Xu8UAC+w3eFDTvISLHLtCEocYCQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gyugbrtg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:42:09 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68TMg8a8030095
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:42:08 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:42:08 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:42:08 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 18:42:08 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68TMfsun008154;
	Tue, 29 Sep 2026 18:41:57 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 00/13] iio: adc: ad4134: Enable greater sample rate data capture
Date: Tue, 29 Sep 2026 19:41:48 -0300
Message-ID: <cover.1790719424.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX8ANdfXw1NAwy
 5DkpLE7Ta7oDnF+ox7/EilO3EkJdI00z3TQBgEh8QN0zWVNpOZljDjLhU73LmRElAakKf94L/pl
 TQwHmrwy3VB+bEAEUzx5FivzEkIK6evfpcGbg2ATTbUF3f5MdWGz1aXFi/dFQmwdtsNorJSOaa6
 IYwDPIeoeI5XruBe9g7INXac9yS8gsdf+XWfmumclr4o6R7ZORe+zYB2pJsJ8g51z7KCQBNVVXh
 xtfvM+EFbvgBP+agVYmZmVrbjgtaJZReMeLwE+7HUgA2LjlelQGZnNolUADX0cUWCME9WZzLf45
 roUvunHt3UVayuUhshmLS7a+lnpPwH6zQ0PVSMK7rXN3DawqT+EUv8dFab57qHMQ/6F+cad7oaA
 8xaFPNiNxz1uEBkSdexqd3G02beo+c3CmOJ3RQHReUCDsMG8G3yTkImf7miC7z5Y9N5aW+p/P8h
 6HqBmhqbTTFTHrwcwgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX5/BmJvwTbCGu
 HtnsgC3Ii044Cor5NV1Vf3UJ6aGlXCaxuA/Mbo35jJnYHnxtkm3diJSTZOZXzNarvcN5ZExd00+
 OU6gCuPdQreEbIM63A+PSi5O1AFiN5Bt4xd22SN7Nh/Ftewi/Bh8
X-Proofpoint-GUID: w5OPk4mcA6C82kcp5b4QNNXsxl_NH0p-
X-Proofpoint-ORIG-GUID: w5OPk4mcA6C82kcp5b4QNNXsxl_NH0p-
X-Authority-Analysis: v=2.4 cv=Eexd0/mC c=1 sm=1 tr=0 ts=6abc3ec1 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8
 a=dZoLHV_l88qVGukTFjYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290090

Extend AD4134 support to enable greater sample rate data capture. To achieve
that, provide control of digital filter type selection. The default filter
type on device power up only supports sample rates up to 374 kSPS. In addition
to that, enable interfacing with AD4134 in SPI 4-wire mode that can support
reading ADC sample data through multiple wires. Finally, use SPI offloading
to speed up data transfers at up to 1.49 MSPS.

Features being added:
- Data filter type selection.
- Triggered buffer data read.
- SPI 4-wire mode.
- High speed data capture with SPI offloading.
- Device tree doc updates to reflect previously missing chip characteristics.

Minor improvements (introduced before the new features):
- Adjusted register map range now prevents access to uninitialized local variable. [NEW PATCH]
- Sign extend sample data. 
- Update include list to comply with IWYU principles.
- Serialize single-read operations.
- Run shorter transfers when CRC is disabled.

The updates in v3 are intended to tackle all applicable suggestions from
reviewers and from automated tests/reviews/AI.

Change log v2 -> v3:
[device tree]
- Adjusted spi-rx-bus-width constraints.
- Dropped mux provider from offload example.
- Dropped odr-gpios from offload example.
[IIO]
- Already applied fixes patches have been dropped.
- Fixed off-by-one mistake to avoid access to uninitialized local variable. [NEW PATCH]
- Now using IIO_DECLARE_BUFFER_WITH_TS macro to set properly sized triggered
  buffer storage that includes room for timestamp.
- Now using SPI_MODE_X_MASK to update CPOL/CPHA bits.
- Refactored access mode locking to avoid umpaired calls to
  mux_state_select()/deselect().
- Dropped unreachable code on offload setup.
- Fixed sampling frequency validation check.
- Avoided division by zero when external clock is not provided.
- Follow LIFO teardown order on offload buffer disable.
- Set correct buffer size to read all channels in offload mode.
- Disallowed single-read when setup for SPI offloading.
- Corrected AD4134 IIO Doc to only show the PWM connected to ODR on offload diagrams.

Previous submissions:
  v1: https://lore.kernel.org/linux-iio/cover.1788368334.git.marcelo.schmitt@analog.com/
  v2: https://lore.kernel.org/linux-iio/cover.1789494473.git.marcelo.schmitt@analog.com/

With best regards,
Marcelo

Marcelo Schmitt (13):
  iio: adc: ad4134: Adjust register map range
  iio: adc: ad4134: Sign extend sample data
  iio: adc: ad4134: Update include list to comply with IWYU principles
  iio: adc: ad4134: Serialize single-read operations
  iio: adc: ad4134: Run shorter transfers when CRC is disabled
  iio: adc: ad4134: Add support for digital filter type selection
  iio: adc: ad4134: Support buffered data read
  dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
  dt-bindings: iio: adc: adi,ad4134: Document external multiplexer usage
  iio: adc: ad4134: Support SPI 4-wire mode
  dt-bindings: iio: adc: adi,ad4134: Document PWM usage
  iio: adc: ad4134: Support high-speed data capture
  Docs: iio: Add AD4134

 .../bindings/iio/adc/adi,ad4134.yaml          | 104 ++-
 Documentation/iio/ad4134.rst                  | 128 +++
 Documentation/iio/index.rst                   |   1 +
 MAINTAINERS                                   |   1 +
 drivers/iio/adc/Kconfig                       |   8 +
 drivers/iio/adc/ad4134.c                      | 820 +++++++++++++++++-
 6 files changed, 1027 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/iio/ad4134.rst


base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.53.0

