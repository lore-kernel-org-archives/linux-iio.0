Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792742824;
	b=vgD0rOeZR2AwfCMwYeEZlobJ91TSA/XSx3xrB9HOFpFSw76C8pFempB++A69swL32EuC
	 zkZfedozf2KrwyjYt4Foov30VKeyIApMsWnInd7OjBfIwB6FwUs90krfpsyCbizWLLrbl
	 zQASy4J+s5ieDgwqRl8MPhlJBPIaCDa3BosdGIV0K25aNc0rT9YFTg4qgi4SXzfor6LLJ
	 10L7l3+8EDGK3MFL3V6KUisPZU9cf9sRtOYo5lMQ/qAOmsXiQPNwbOLO0VqvB7kzo4TZY
	 Phuoyec7raP4rDyE/o7LP+vy90L9m23m0Xwl+/ExAs5kfk5LSyIjwe/OLNcpFdjd4Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742824;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-ADIRuleOP-NewSCL:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=mUJBUMs5Y1jpw4dpu/EsJ5tW1SGbnPuvaOJEUfes3hE=;
	b=mGiSeT4Q5mdfmT3sBo0MJP/GYs8F30fmwuzRBLTbzOVd2kT0LAOSEFmMpmAaQLMd/lik
	 nTEcl5mWqEqGYfShgaLPcqZttM0Uaj3DOgPxOjz5SXebkE5hxj2GSp7TGVP6fnjQWRd+C
	 nGmrE5KKX7Ul1YRg073z8WcR7cbqJW2raujj/vbmtDIe8FxbXCm65VEAhf00BuQHtk6rO
	 rxHWuAfUoFbQYN7t4+1ckLOz2RIx0bzanx+RTpOElN5lAnVWJ3BPzcgarfyYXsGxCqOZk
	 /xVS7W1q4Aeg7qMsFrkCliXlIbtx52fOh1IBXmc6v6ceD5BieVyUtDf6QyBHSbYC8UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=jEPPfroX;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=UHxLk6rB;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31AE606A325;
	Fri, 23 Oct 2026 08:07:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B31AE606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=jEPPfroX;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=UHxLk6rB
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7Gl5D820729;
	Fri, 23 Oct 2026 04:06:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=mUJBUMs5Y1jpw4dp
	u/EsJ5tW1SGbnPuvaOJEUfes3hE=; b=jEPPfroXDT6r77g/dnkEJd+JTUecd8et
	2JvQGBXEvyaYkSB98hKg+58ZujR3fPJWqTGCY8DWaNhIX5JQnzfapX9e5sFj8vxU
	XR4W95+z4Ms3dLyt+SugdnVfR20RBvyPvsWJrIYWOGnvUYn5Ti66Jnf6TQSo42mB
	rrWr7BEGnnYLtytmu2tz5JSRgsGeVOXLIfrjX627Q+A+tfXbHvy/+/DIOb8jC9PR
	Y3br3sn2MLibU2kYyenJVGyQf2bev01B3zHQBOP1sf1HHMIYAcn2SDvKMcnkZV8j
	oxoM/q4GOUVtxJsm9fIsP25jyxA3DiGXiYw8RbtzekmkV/OBtstSEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=mUJBUMs5Y1jpw4dpu/EsJ5tW1SG
	bnPuvaOJEUfes3hE=; b=UHxLk6rBkqp/2jRis07HbZ8OR7+mjKGoo+p7s23GVGQ
	mWOTtnRqEIDHBDocoJ8YPVk8vYLn2/jlE9qPCtCiHJ9FBMuUlJViOYsAUYTgLrR/
	jj3KSTC0X0lH0MV4KabyT+X13tjwMOKqNHK890CVaZv2jQsAT3NnNU3sg0/cHyO0
	B+7OveFo9lo6IxZYaQc85eK0JQQGUsmtfXuIbidr67GpA1J57eWaR0HAn0FCLCBF
	qCUmNxv6BpI++1cIksyRBu+HsD9tF+meAcSerB8U8l7UzmNTH+g/TtGlHUzQujCg
	SNV5Cy1uR5HsamAFFJkX1MjQ0gbm3WUaQNOo3wxRnXQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hfy3wseed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Oct 2026 04:06:48 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 69N86lT0045303
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Oct 2026 04:06:47 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 04:06:47 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 23 Oct 2026 04:06:47 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 23 Oct 2026 04:06:47 -0400
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69N86VIN020871;
	Fri, 23 Oct 2026 04:06:34 -0400
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <joshua.crofts1@gmail.com>, "Guenter Roeck" <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>
Subject: [PATCH v5 0/2] Add support for Analog Devices MAX30210
Date: Fri, 23 Oct 2026 16:06:21 +0800
Message-ID: <20261023080623.1830-1-johnerasmusmari.geronimo@analog.com>
X-Mailer: git-send-email 2.44.0.windows.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX5r+8wQzdg5Y3
 AimHfsMtAJH4Aimm9HG92SsLSLg7ZhltZdgTxwpeqFA7bqeMuK18MsdPgi1HhA1YCTP9dCkb10E
 BdttKGXqNqJdkvhBiQy3ZX+rl+vOs14ZjXjPBRtP5o2Vf7HB+wmh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMiBTYWx0ZWRfX0tZz0Kq9LObs
 XN+4DsbWNDn9j4hoXUpYF8PROOnbikcVJNuJSx2lh8ZJtodnH6qYHcN9sPcNv1pu/XDeMGF9FNZ
 kUapf7LuOoAiYTt9o+AEw20fGD9cpc+Uz/i/0UwhUp3tDEGZKe8vG2wDmvZ0t3yqcb6jSJaEg/r
 3Vegga84+y17ULXEz3zDNDhxqcpZl5Q/71bVU5vVVqbGIqNHirbs2DOq9Ew7xnFF1l0hqfkokDZ
 PD4VxZpNbqXIYbeLofAM6R7fb4AVE4aap2VQjL07lVYAdH1dBCPtru6vWMBfjxe3FJKfiLy2RO0
 z8+Vl+XJWOnQeEFXXzpNvPJTQ5TgprGGvGTJ6jeflZLnGtLYQUWWDIwi+bUCW+w1TY0crZwL6Ii
 MQrtJROKGsSxvrWnHnFzSLPT9YxE2G5sF/FEpX1EI9C3lt+sle5lPHsuUjbQy5t8zRRnFeWOYhw
 +zbfslA8SY1FeuKQWwQ==
X-Authority-Analysis: v=2.4 cv=fJ+sTpae c=1 sm=1 tr=0 ts=6adb1598 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=EyQB7bUjZIRY7IU1YG0A:9
X-Proofpoint-ORIG-GUID: CLgYV4b9-7C4V61680_1btbl5oszQlR8
X-Proofpoint-GUID: CLgYV4b9-7C4V61680_1btbl5oszQlR8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230032

This series adds support for the Analog Devices MAX30210 I2C
temperature sensor.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max30210.pdf

The device provides a 16-bit temperature output and includes
features such as a hardware FIFO, programmable sampling rate,
threshold alarms, and interrupt support. These capabilities map
naturally to the IIO subsystem, particularly the buffered interface
and event framework -- hwmon has no equivalent buffered-capture
framework, and its alarm attributes are polled rather than
interrupt-driven, so there is no path to supporting the FIFO or the
autonomous threshold comparators there.

Although the MAX30210 belongs to the same device family as the
MAX30208, it is implemented as a separate driver. The MAX30210 has
a significantly different feature set, including a 64-sample hardware
FIFO with configurable watermark interrupts, programmable sampling
rates, and event support. These features require buffered operation
and IRQ-driven data handling which are not present in the MAX30208
driver (which talks to the device directly via i2c_smbus_*() calls
with no regmap, and has no IIO buffer or event interface at all).

In addition, the MAX30210 uses a different register map and a more
flexible I2C address selection scheme. Supporting both devices in a
single driver would introduce substantial conditional logic, so a
separate driver keeps the implementation simpler and easier to
maintain.

Patch 1 adds the devicetree binding.
Patch 2 adds the IIO driver implementation.

Changes since v4:
https://lore.kernel.org/all/20261015012159.44-1-johnerasmusmari.geronimo@analog.com/
- Patch 1: restore Krzysztof's Reviewed-by, which was accidentally
  left out of v4.
- Add Datasheet: tags and a datasheet link in the driver header.
- Disable interrupt sources and autonomous conversion on removal,
  independently of whether a powerdown GPIO is present.
- Only take/release an autonomous-conversion reference when an
  interrupt enable bit really changes; repeated writes of the same
  value no longer leak a reference.
- buffer_preenable() now unwinds the A_FULL interrupt enable on
  failure and buffer_postdisable() always clears it.
- Return IRQ_NONE from the interrupt handler when none of the
  handled status bits is set.
- Wait tPU before the software reset when no powerdown GPIO is used.
- Minor review cleanups: error paths out of line in
  max30210_autoconv_get(), min() for the period clamp,
  devm_mutex_init(), designated initializer for i2c_device_id,
  header grouping, one-line val/val2/mask argument lists.
- I kept requesting the interrupt after devm_iio_device_register() so
  it is freed before the event interface on removal. I could not
  test the proposed core change because my test platform runs a
  6.12-based kernel.

Tested on real MAX30210 hardware (Raspberry Pi 4) with a 6.12-based
vendor kernel: no-IRQ fallback, buffer and event refcounting
(independently and concurrently), repeated rmmod/insmod under live
interrupts, powerdown GPIO release on removal and FIFO flush
correctness. That kernel has no KASAN or lockdep, and this version
is only build-tested against mainline.

Changes since v3:
https://lore.kernel.org/all/cover.1789032019.git.johnerasmusmari.geronimo@analog.com/
- regmap_noinc_read() for FIFO reads instead of regmap_bulk_read(),
  which (combined with regmap caching) could silently return stale
  cached values of unrelated registers instead of real FIFO data.
- Mark both bytes of TEMP_DATA_REG volatile for the same reason.
- Decouple threshold events from the buffer via a refcounted
  autoconv_get()/autoconv_put() pair, so either can be used
  independently or concurrently.
- Don't let a single-shot direct-mode read race with/clobber
  autonomous conversion mode if a threshold event or the buffer is
  already using it -- return -EBUSY instead.
- Don't hard-fail probe when there is no interrupt; fall back to
  direct-mode-only operation.
- Fix devm teardown ordering so an in-flight interrupt can't use a
  freed event interface on removal.
- Re-assert the powerdown GPIO on removal so the device reaches
  standby instead of staying powered indefinitely.
- Style/API fixes from review (register/field grouping, _MASK
  naming, FIELD_PREP/regmap_assign_bits usage, C99 initializers,
  dropped redundant i2c_check_functionality() check, comment
  cleanup).

Changes since v2:
https://lore.kernel.org/all/20260304122509.67931-1-johnerasmusmari.geronimo@analog.com/
- Fix FIFO byte-count handling and sample decoding.
- Fix IIO debug register read/write access.
- Validate event threshold values and sampling-frequency register values.
- Return the correct sampling-frequency format and reject direct reads
  while buffered capture is enabled.
- Clean up the Kconfig entry and device-tree supply declaration.

John Erasmus Mari Geronimo (2):
  dt-bindings: iio: temperature: add ADI MAX30210
  iio: temperature: add support for Analog Devices MAX30210

 .../iio/temperature/adi,max30210.yaml         |  61 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/temperature/Kconfig               |  13 +
 drivers/iio/temperature/Makefile              |   1 +
 drivers/iio/temperature/max30210.c            | 844 ++++++++++++++++++
 5 files changed, 927 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
 create mode 100644 drivers/iio/temperature/max30210.c

-- 
2.34.1

