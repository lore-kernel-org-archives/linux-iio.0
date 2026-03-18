Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDF221FC6;
	Wed, 18 Mar 2026 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773811411; cv=none; b=dLf4P9ElFSrJZEsZhkFHSNDVbDGNIhvRDTy6Ri1AWEXBVZhTiHkMfG8ScKBj3tPbmXTxgyZtEhEZg7P/l7tupL9ndYOaxFrDpwD7eAkGHbsc9J3OVSwSpC5T20Txq50ifq4RdHlawYLJPOOYCsRxBbuW9ALypXPt67jCzEQP02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773811411; c=relaxed/simple;
	bh=SsU8FAaDMLdk6to4lvJJBdaS63sUsKihBtClFLej77k=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=SSgyonA75gJj/n/LIvdenAR/ZmTzPH90E9CdFM7IPOycncOXHx574obIT1W56BjKvahhCyfuQi/qBcLbi1aq+mL6MBK5URZsU2BU+st8+rTv3/oFhPHJh4Jmi2dYRpYjl7gZY/gs6MCrDRjhR5Lk4vsjM/nN4+3WIRwCh+KuSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=v45LmW+u; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="v45LmW+u"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62I1QetG3759893;
	Wed, 18 Mar 2026 01:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=/yHQ5UeDT2AUyL94xR1A36cBwhv
	cVIGJnKEyduWKGAI=; b=v45LmW+unysjqHXH5hVR28ISSlVR3b08/OujGs1xxyd
	I0XPdPXh0O8hweWTBujWTOr2pX1lgWFtcXclXB61Fe5gdoUR3K4vkztDyD683TG3
	TS0Fr7IqBgq1a0FZb5j7Vpuf/T7tybSdksVVvLBhYCGN4gdF/abS1naVxcu3TFGR
	CO+qRqYwrT/e805mjXjp3A15qj/Pu1hSaJRyPHeZgp2Ehqpi8b87Mlw/iDHdC4R1
	WmKqa3KeF0haFTn0tEM7031hvmKoWktnMXan2WzH1ZuMPZ74jwsz7wvM6bAJHGsX
	qcSobxUuOw2Be7pvbm/EvCFN8RTqvAwH9okGlnG59eA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cws0fvqrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Mar 2026 01:23:05 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62I5N4ZA064809
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 18 Mar 2026 01:23:04 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 18 Mar 2026 01:23:04 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 18 Mar 2026 01:23:03 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 18 Mar 2026 01:23:03 -0400
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.118.4.23])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62I5Mpce023858;
	Wed, 18 Mar 2026 01:22:53 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Subject: [PATCH v3 0/2] Add support for AD5706R DAC
Date: Wed, 18 Mar 2026 13:13:34 +0800
Message-ID: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH40umkC/22MywrCMBAAf0VyNpLd2Jcn/0NEku62DWgjiQSl9
 N9Ne5GCxxmYmUTk4DiK024SgZOLzo8Z9H4n2sGMPUtHmQUqLBWiksTpZqioVBkkgioYiLAxVuT
 iGbhz7/V2uWYeXHz58FnnCRb7/5NAKllhoa2l6ljXzdmM5u77Q+sfYhkl/MUaYBtjjjtdZtBkC
 ewmnuf5C88YrHfkAAAA
X-Change-ID: 20260220-dev_ad5706r-2105e1dd29ab
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Alexis Czezar Torreno
	<alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773811371; l=3154;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=SsU8FAaDMLdk6to4lvJJBdaS63sUsKihBtClFLej77k=;
 b=+ImhGQpCWGkIWbub1rjmCi9FvtJ0chvZfbW0+RY4mSC24JJNlAn7ZCqJ+6JcrU5Kf+N0ajplD
 mrp1N4uxMEADwMSCawZW1rY4wmH/oXP+GAv6D27fvL3ES/S7Xz3U3lt
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA0MyBTYWx0ZWRfX5lPTqAiGAIDI
 g/gJQLqEwHqCj3u4eAqGXJ7mY7I20e7umPEe2p2nucnY4GLlfv/JInNKf9kqhGP2Fo47eMjV5Fb
 GbFdYSUD1o7n25J6S4y5nTfIdXcadeEOWnhb307G+ZgRk6SegqPL/E39bq4IyZCYk802n2IhFay
 uPm03HmAS/azZUPrLxAUPgJw9uAxUwm29gSP29eeJSaDnXaMy8Xl79iuZVfCQh54YylLxx8AiVu
 Tei7SIhFIV4WtOuRL3oMYHuTC7KxgsWJX+wNff4HZH8wgtvgYStXsVeM+scJzSOz66VLEQ4HlFL
 ZWuIA31XWT15RcNrjbGF7837C9wsMy1njSEaasj4FkzDa+wU/Xn9GDYaNqa5E2PnIW6elMbRYGl
 2Rcyy2WsCTzkwpq3wUISHUEWuocHivHDKe97eJ/bZ7dKO2Wvu5KIOtkDJT5ptqmjQXaNO4Au99X
 xalMJIHC2Nk75gBYVYA==
X-Proofpoint-ORIG-GUID: DsqFhToAyE5WRFpqP3kCS2weVzhJC5s0
X-Proofpoint-GUID: DsqFhToAyE5WRFpqP3kCS2weVzhJC5s0
X-Authority-Analysis: v=2.4 cv=BbjVE7t2 c=1 sm=1 tr=0 ts=69ba36b9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=5uwdZQKQTY1Nqflp0vAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180043

This series adds support for the Analog Devices AD5706R, a 4-channel
16-bit current output digital-to-analog converter with SPI interface.

The AD5706R features:
  - 4 independent current output DAC channels
  - Configurable output ranges (50mA, 150mA, 200mA, 300mA)
  - Hardware and software LDAC trigger with configurable edge selection
  - Toggle and dither modes per channel
  - Internal or external voltage reference selection
  - PWM-controlled LDAC
  - Dynamic change SPI speed

The driver exposes standard IIO raw/scale/offset channel attributes for
DAC output control, sampling frequency for PWM-based LDAC timing, and
extended attributes for device configuration including output range
selection, trigger mode, and multiplexer output.

This driver is developed and tested on the Cora Z7S platform using
the AXI SPI Engine and AXI CLKGEN IP cores. The 'clocks' property
enables dynamic SPI clock rate management via the CLKGEN.

Datasheet: https://www.analog.com/en/products/ad5706r.html

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
Changes in v3:
- Added MAINTAINERS entry, files added on each patch
- dt-bindings:
  - Added allOf and ref to spi-peripheral-props.yaml
  - Changed additionalProperties to unevaluatedProperties
  - Added avdd-supply property and added it to required
- driver:
  - Removed redundant includes, added respective includes of APIs used
  - Simplified bit manipulation in SPI read/write, used feedback from v2
  - Fixed inconsistent trailing commas in device ID tables
  - Removed zero initialization in spi_device_id
- Link to v2: https://lore.kernel.org/r/20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com

Changes in v2:
- Stripped driver down to basic DAC functionality (read/write raw,
  read-only scale) as suggested.
- Removed PWM (LDAC), GPIO (reset/shutdown), clock generator,
  SPI engine frequency switching, debugfs streaming, and all
  custom ext_info sysfs attributes
- Removed regmap, IIO_BUFFER, and iio/sysfs.h dependencies
- Simplified SPI read/write to use standard spi_sync_transfer
  without clock mode logic
- Scale reports default 50mA range as read-only using
  IIO_VAL_FRACTIONAL_LOG2; writable range selection deferred
  to future follow-up series
- Simplified DT binding to only require compatible, reg, and
  spi-max-frequency
- Link to v1: https://lore.kernel.org/r/20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com

---
Alexis Czezar Torreno (2):
      dt-bindings: iio: dac: Add ADI AD5706R
      iio: dac: ad5706r: Add support for AD5706R DAC

 .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   |  56 ++++++
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5706r.c                          | 222 +++++++++++++++++++++
 5 files changed, 297 insertions(+)
---
base-commit: 3674f3ca92730d9a07b42b311f1337d83c4d5605
change-id: 20260220-dev_ad5706r-2105e1dd29ab

Best regards,
-- 
Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

