Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD95326CE2C;
	Wed, 15 Jul 2026 06:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097467; cv=none; b=XwtJdEIWzva/Jo0F9KSYJ9Whgf/L0kxOAtEGc6ROF3I75HdQ4T/WplWxUhczV6FK4zTzDx3sVy3yjPUqjfBQ8Aii5R9jwHOGYZiXDqck1Jrfkg8eMty0YrDgvSJgToilNIbeMCNAcWGmrvTcSpst9WxZx/awjgaWl35VsEB/pm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097467; c=relaxed/simple;
	bh=b9Vda+Z7LQQ362AAMSMY+Qu/HWQ+WpugFJm1Q7IkhQo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pb9WNpkNP6bBG+n4dRUYviKDsmgK5pfyV6wrYQt4KaMA+VWXrfNTZz9wFT/+68CzCgIg3NEHM1qQWPXBC1nQRpNfQo9kfM+E7yOATNs1Qau0G1H4o65oL18dK2UwMXn9ZguHhkHBKvYTr0Xl7GbTjnMfDPg6IS5KWzmep6F7Tq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RMfrVuge; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RMfrVuge"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3kmQE3801729;
	Wed, 15 Jul 2026 02:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=rDpAjD1cnY2Sm8mOSaoI/EwlKKd
	KDM5M8s6mPnmxOkU=; b=RMfrVugeCw9YvJrqgbo/7mnybtEE1iW35BkS+F4JHvu
	dkRzgV9W8i8oFRfGUsWxiWQq6XhD9mqR+gODAQqHnLKvaJjPp72qdg0aFw/9Tmn4
	DGyXxVkIQS/GrswuSr8cYtIr7UfNeGFWcnZiJrXzqky5DQicVDDU4aCcg9pDNYBa
	sjnKAM9YDiSBBYxWQQnobH221crjeZDSe2YYANsFDSAVg6maDP6SqhrzV9MrVEnV
	tc/uEgS90KZMJ6D76MD0WJrOZZx4yeNw9X8LbqcQuTZgMlqOfUGbEJB1TVK90L7o
	oPysAlNpYRhP88G0bkfOBbbwAKZkCE+jvai1/s52VXg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fe0bx10n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jul 2026 02:37:27 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66F6bQlA032705
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 Jul 2026 02:37:26 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 15 Jul 2026 02:37:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 15 Jul 2026 02:37:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 15 Jul 2026 02:37:26 -0400
Received: from HYB-JRXo5UEs61B.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66F6b9Aa001579;
	Wed, 15 Jul 2026 02:37:12 -0400
From: Stefan Popa <stefan.popa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Siratul
 Islam" <siratul.islam@linux.dev>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Stefan Popa
	<stefan.popa@analog.com>
Subject: [PATCH v3 0/2] iio: adc: add MAX40080 current-sense amplifier driver
Date: Wed, 15 Jul 2026 09:36:15 +0300
Message-ID: <20260715063652.368501-1-stefan.popa@analog.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=JqbBas4C c=1 sm=1 tr=0 ts=6a572aa7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=LTKegqPRdhSjGXiXv1MA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EMPn7fAb7tVG9iGq3ooRIb9H6gKtkvt_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA2MSBTYWx0ZWRfX3lFUZbJ9qIbQ
 XZzdr88eHj7oFEjrVJv9kH+2On2efD1NhvkBDcP5l+ATCosleum6FAoUoFU4lYt1E8vpor4LyYb
 tzDP2opXQeLFcyl19yxUMqTR7/LLBp4DDwEgAY79jpli+0OrbFDR
X-Proofpoint-ORIG-GUID: EMPn7fAb7tVG9iGq3ooRIb9H6gKtkvt_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA2MSBTYWx0ZWRfXyKwUD2XJ7h7r
 SqO8V7OBhcWs7whRB8yzWlIy1glgpSyubKtA13pv16qELKV3yj5QPupHC6Pv4EzIAjbp0l97Vjw
 /Uiy62k9ZZxspy413faNJWpgXatRS9GO9xqHU1Si97xCK4Al7L5m7De4H0FXcy3l8htiz3mMtJx
 RIQAt1tu/K6Z2za3XgQOvO00iaLzW+3cs0Y5y4+FAAD9ZbdcXlTogwIIHmbd/b2CIl3OZpY8gCt
 TjFBVRnp+f5PszlCWQaxVN1qgFjC475NxC81TSFE1Z59uY8PvYaB7+vBbwq7xaKSwIjntD/nRCc
 km6ZaAlecwU4m1oeijRHNf8CMvhZ3Y/p1Xqmbvy6+nKVz1cRGAN/G96KiinlFrZfSD53NJPViu9
 wPq+PLhc2e8lFXXcKVmzUESgIX/FJfpxq98MdzFSIiZe9SbHwZhUElzQlvCsA+IrgPHsVh6v8bR
 fxSMroNLvFvjpN6XoXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150061

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

Regarding Andy's question about *iv being updated even on error in
read_poll_timeout: yes, this is intentional. The poll loop must update
*iv on each iteration to check the valid bit. On timeout (conversion
never completes), *iv contains the last-read value with the valid bit
still clear, but the caller always checks the return value first —
"if (ret) return ret;" prevents any use of the stale data.

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
 drivers/iio/adc/max40080.c                    | 630 ++++++++++++++++++
 5 files changed, 715 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
 create mode 100644 drivers/iio/adc/max40080.c

--
2.53.0

