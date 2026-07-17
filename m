Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C911E9B3D;
	Fri, 17 Jul 2026 12:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291976; cv=none; b=mRRiEApF7BSuxohFfdq75yczQtWE4iMiYdEBYeei7Cu/+18xAlrkmmKUffjPdFlzXIMyDd4z5LAhMO1wQxbxAxkonziXbm9ARRWiyw1wiFJplPhHZOBAID29DeA6PaseBpGKhs2PZOrqrX6sQzaCyZFNkGTZUren8Ugy8Rfz7Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291976; c=relaxed/simple;
	bh=ZNkZgFdUqasQFA5EClkKxZAdZhILG84xfprJkI45vOM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=geFDSOR5WDQU8mevTahPLHLvCtoYanB2gCsbjRXEJ2I7TZTnBKdMD6xeMp6u8ncNR+vE+0NRDZ+aEVMw3DlLou0+z65V4J//eqB9EccVqMgjFQAL7Wu4Vr/7T9O4wsGhjDrxNZvWHtGa+Zexqetq1WQkNCKc8dDoxCYAcE/MQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Wed+LQ+S; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Wed+LQ+S"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HCOKFc2294002;
	Fri, 17 Jul 2026 08:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=3yH1Hicn5e8f9VnF0tum/3q6Fa1
	MPv7+CqknBB8yV3w=; b=Wed+LQ+Snjel+UZnie1wIwr+rZidpNbs+9HVw5M38ex
	UOFqYtzqDaGBmRr3OuZKJ7sQzDstpkM2D/B7NS64FGpE3Se9XrT6+x34SVW2/aX9
	1GsEfjwEO6Ayq3uUIuLMxSDe4+v6lKH55W1ns3ovUlgVweA6WdtWcVhgLZWXxotD
	SrPoJztipiVSm5IskgTEAhJeHbmrhyOdw6iAKxSKanYYpxhzeDeZpymC6Zw1fWbS
	xtOot3PkACmm//rLEfnJNu7iMuOZjVMYBYFscEMC0Vbo2dawBpANQLhYdML8/wcu
	Pt1fKvaHzqiDgNEnXarSndcbmLdauyLbO68V3M15iGQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fe85x23av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jul 2026 08:39:21 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66HCdKcU041793
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jul 2026 08:39:20 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 17 Jul 2026 08:39:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 17 Jul 2026 08:39:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 17 Jul 2026 08:39:19 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66HCd3w9014702;
	Fri, 17 Jul 2026 08:39:10 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <jic23@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <nuno.sa@analog.com>, <devicetree@vger.kernel.org>,
        Stefan Popa
	<stefan.popa@analog.com>
Subject: [PATCH v4 0/2] iio: adc: add MAX40080 current-sense amplifier driver
Date: Fri, 17 Jul 2026 15:38:47 +0300
Message-ID: <20260717123852.1140893-1-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=aLnAb79m c=1 sm=1 tr=0 ts=6a5a2279 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=J2VQ2ZjlLbM5hFLylHkA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyOCBTYWx0ZWRfX7wwQ0az/ksTT
 o7b4N0mJ6oi3KDR2DQ2XOIlTg9J15HIP5zDAPqyQBp6rFPntz+kBC04SdkOIYjMCPkGmVvwKVxu
 0AmTTMO8Z4NaO0//3S6aA/8zbsmkAli85INFCsU7//QO3cdzLOcvbgcZeMYxD7dprjURPpTXeV3
 v3ziz/6ueUYVaPODLGdNQKm6gCxqGA7khwyTQBeBXZkPVfiEHR6slUgftcEzCLYfPOh0SSx7scu
 8jZV/LLAd24f79lk4oaxNRVIbfBzyqL2hT6vtyy/QpHhrygWFDCFP9eAyafR2blzgf2J9yMDdGt
 fVUns1jKxmRgQi3MVwSq9SyzIgtEGAqMkE85nMzRB2vROMjAm08lGv4i/7Zhc2a8LJDi20cGW+C
 VmoiaPy/j6mQ/Ahj9GsmG9j8x1NROUHEkvIsRBELIbWrZ/L8mehLEy0+7Bj5onujTLBTmtQevTO
 zgzMvYiB5/tXNV+WASA==
X-Proofpoint-GUID: ZNxtPORKXYbiuE-1SoA1U0KignbrwXwi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyOCBTYWx0ZWRfXzZLqZBorp9I6
 ZKiha7uNvPeKLc+V2SGL50hHLvvtEoAUhPTJ/ndhULIxuKNQ1zCo5zpB4uD2Qg335lZvjQXFH7T
 mgfgS90gEtjqeyNN6bCo0e5FCdSG496c/aU6c7yAPI7CBnYlfyqg
X-Proofpoint-ORIG-GUID: ZNxtPORKXYbiuE-1SoA1U0KignbrwXwi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170128

This series adds support for the Maxim MAX40080, a bidirectional
current-sense amplifier with an integrated 12-bit ADC and an I2C/SMBus
interface. It measures the voltage across an external shunt resistor and
the input bus voltage.

The driver operates in direct (INDIO_DIRECT_MODE) mode. Each raw read
triggers a single on-demand conversion (SMBus Quick Command) and reads
back the matched current/voltage pair, so results are always fresh. It
exposes the current and voltage channels with raw and scale attributes,
a configurable oversampling (digital averaging) ratio, and PEC-protected
register access. The two selectable current-sense ranges are exposed
through scale/scale_available; the current scale is derived from the
shunt-resistor-micro-ohms device-tree property.

Tested on hardware with four MAX40080 devices on an I2C bus.

Regarding regmap: it does not support SMBus PEC or Quick Command, both of
which are required by this device. The mlx90614 driver uses the same raw
i2c_smbus approach for similar reasons.

Changes in v4:
  - Split MAINTAINERS between patches: binding file in patch 1, driver
    file in patch 2 (Andy, Nuno, checkpatch)
  - Use Datasheet: tag instead of Link: for datasheet URL (Andy)
  - Remove blank line before Co-developed-by tag (Andy)
  - Consistent comment style: capital first letter + period (Andy)
  - Rename shunt_resistor_uohm to shunt_resistor_uOhm for SI convention (Andy)
  - Inline trigger_measurement() into read_iv(), removing the helper (Nuno)
  - Add DMA-safe buffer to struct with ____cacheline_aligned (Nuno)
  - Rework read_iv: use local tmp variable, add comment explaining why
    *iv is updated even on timeout (Andy)
  - Refactor calc_current_scale: C99 loop variable, named numerator/denominator
    variables with 1ULL * promotion trick (Andy)
  - Use unsigned int for loop variable in oversampling_to_filter (Andy)
  - Add propname variable to deduplicate "shunt-resistor-micro-ohms" string (Andy)
  - Fix locking: rename to __max40080_update_bits (unlocked helper), hold
    lock through cache update in set_range/set_oversampling_ratio (Nuno, Sashiko)
  - Fix torn-read in read_raw: use local copy of st->range (Nuno)
  - Return inline instead of breaks in read_raw switch cases (Nuno)
  - Remove lock from resume function (Nuno)

Changes in v3:
  - Remove mod_devicetable.h include (Andy, Uwe's rework)
  - Use lowercase _mV suffix for unit defines: MAX40080_INTER_VREF_mV,
    MAX40080_CSA_50mV_GAIN, MAX40080_CSA_10mV_GAIN (Andy)
  - Remove MAX40080_NUM_RANGES macro, use ARRAY_SIZE() directly (Andy)
  - Fix reversed xmas tree ordering in get_oversampling_ratio() (Andy)
  - Split semantically different variable declarations in
    set_oversampling_ratio() and max40080_init() (Andy)
  - Join *val, *val2, long mask on same line in read_raw signature (Andy)
  - Use const int * cast in read_avail (Andy)
  - Join FIFO_CFG write onto single line in max40080_init() (Andy)
  - Return i2c_smbus_write_word_data() directly at end of
    max40080_init() (Andy)
  - Use device_property_present() pattern for optional shunt-resistor
    property (Andy)
  - Make vdd-supply required in DT bindings (Conor)
  - Restore i2c_set_clientdata() needed for PM resume (Sashiko)
  - Add bounds check in get_oversampling_ratio() for hardware register
    values outside expected range (Sashiko)

Changes in v2:
  - Add vdd-supply and interrupts properties to the binding (David)
  - Add types.h and time.h includes (Andy)
  - Use USEC_PER_MSEC for poll timeout readability (Andy)
  - Use 1 * MICRO for default shunt resistor (Andy)
  - Rename field macros to include register name, e.g. MAX40080_CFG_MODE_MSK
    (Jonathan, David)
  - Add indexed defines for RANGE field values and use in gain array
    (Jonathan)
  - Use array lookup in get_oversampling_ratio instead of formula (Andy)
  - Use switch statement for chan->type in read_raw (David)
  - Simplify update_bits: one-liner RMW, return write directly (Andy)
  - Add local client variable in trigger_measurement (Andy)
  - Add braces to for loops and use C99 loop variables (Siratul, Andy)
  - Flip if/else in reg_access, separate declaration from assignment (Andy)
  - Add .name= in i2c_device_id (David, Siratul)
  - Reorder declarations to reverse christmas tree (Siratul)
  - Return directly from oversampling case in write_raw (Andy)
  - Add blank lines before return in read_avail (Siratul)
  - Add Co-developed-by tag for Ciprian (Andy)
  - Use Link: tag for datasheet URL in commit message

Stefan Popa (2):
  dt-bindings: iio: adc: add maxim,max40080
  iio: adc: add MAX40080 current-sense amplifier driver

 .../bindings/iio/adc/maxim,max40080.yaml      |  64 ++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max40080.c                    | 636 ++++++++++++++++++
 5 files changed, 721 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
 create mode 100644 drivers/iio/adc/max40080.c

--
2.53.0

