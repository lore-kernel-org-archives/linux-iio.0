Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794276935;
	b=q8yxNCsUe5meFilXIKE8SsxiGQ76CWDyWrZGU08QLT8ZTDBGxCe6ByTGVkOwjsByzoMb
	 mgk8e6tEQ6EXDq/sh/HHW+EuIH2v2UQzmaDCZKdwC/d4IwmVT3zEXiT8y4hjkrWs+DE/Z
	 LMVgMtE+dMLn5gNiOM4GBbLBqk6ucNvgo8Vsae5FZ8/lBLzTWBPNYv1K5pw25FCFLhIuh
	 0Ks5NLJHXGf/iXqUkYqM0yypsFk9gxmcho7jcZTEeaic9xDhSuo9xoJ0xNDlQrkVWyEZ2
	 TD9jXKiqlpctEkklKE76P9oCBtSp7Bv2vREUiMSyTgsfla95pR4OgYOYItaYwsmn/lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794276935;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-ADIRuleOP-NewSCL:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MX2AdBu9NCCSjXzWL7enR8wTxV3kmPEC0Ko8sSbmVks=;
	b=muTWP1g9yflddF/l0y+4BfREpSRCGYTtBstpo+2tmn/iyn7HeONF4esEJhE//wdWBy5U
	 Nh3pWFaVb+MCG8BpAL1IWWlzfE8HNMfHKDgExN26Q+YJ5BxseJW7i4QTzyd64d267/Je8
	 Yw0ZsbmsLBkmX6Ok2NxMujkNah686V47K9kAgbUzMJEcSmBJjSMcKs34etK4eXklg59Kr
	 8+xWGYc7JvBNQdJe4wKRDfs5YmcqQ4sDtNGeSb8KXuG0alzh41Tjx2rNXuJoIIMDAIP4y
	 QXGChX+DsAXVjaZ2qIoE1VOHSDnvhaHjV76Bo74vhgrpLP/I4SEW2xUw/5YvEbPNDBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=nzWw4t5a;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=vXOpDwLP;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0FF606A336;
	Tue, 10 Nov 2026 02:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD0FF606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=nzWw4t5a;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=vXOpDwLP
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA1QGRt2400950;
	Mon, 9 Nov 2026 21:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=MX2AdBu9NCCSjXzW
	L7enR8wTxV3kmPEC0Ko8sSbmVks=; b=nzWw4t5afMPtsSVofNNjnaMBG4cv41VL
	SxiWZ5WEjMZbBKRDJt0tY/8RK0vgRJwjVbnnquRsTqvHzrv7PNfseiy9tR9mEPtU
	6H7kZpiyaZBMs2sW/Ee9zQ2lL5vBECDnvY0CcvUnfSLLlkfBXspS46huDo9YeFg6
	WnL24yk5JBFDqMQnJvu7hA66IfJxiq6fnwFC/ng2e43K9d4titdA4Fi0FmOZmTcq
	r1SQsDfd27vqPQwdAE1PiIdHVZPaHENk5vaiuXTLVOj+xH36oHLfyq7h0Ozns52C
	+hs90QAlwwl6pEWMUSI03UoR0vNRsJOOtEw99nQevRctlyPY42Brcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=MX2AdBu9NCCSjXzWL7enR8wTxV3
	kmPEC0Ko8sSbmVks=; b=vXOpDwLPaBtBPtze84Te7RBm37FiwcDf6qnkU0mbYri
	L9XcPW6/3s2HR4LRJGpSqh4F/KpJBRBpoUy98GXW4Kv3bkqOWpWSb4xujbSEunui
	B0iFi8oYXR0s11FCHFwiwzooCpdTEWk1zcSvuN45mXmNVTWSj2xnySLjJOaiLL13
	HNv64WQT2FyZKhwisWTsGZzfNAiV0o19Ui09iiTScaWfZTAAkFZU+d6SmJn1nNGX
	n7+tmIdYk8oMfXrxqk1jEwVyKJPDD+/sqCLvrlrLjm+jE4950k9nJHmmaveVkpij
	4D0dybvMdRTDqn/P3LRLj7hWrBtSt03eTz1JiWERGZw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4huskw0cnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 21:15:09 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6AA2F6ms037979
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 21:15:06 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 9 Nov
 2026 21:15:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 9 Nov 2026 21:15:06 -0500
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AA2EovV016346;
	Mon, 9 Nov 2026 21:14:54 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <joshua.crofts1@gmail.com>, Guenter
 Roeck <linux@roeck-us.net>,
        <linux-hwmon@vger.kernel.org>
Subject: [PATCH v6 0/2] Add support for Analog Devices MAX30210
Date: Tue, 10 Nov 2026 10:14:40 +0800
Message-ID: <20261110021442.410-1-johnerasmusmari.geronimo@analog.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAwOCBTYWx0ZWRfX0bUviokDELjG
 6EAKy37iAbEygR9OYHxCGbkThZRF0jStu814DyXJvkjRf/1TIkRLotOI3sH05zCpXaeW1X4MiEV
 NkQaC8svCQalyPI6e2A5RMBZAD65weF1qgsEV1JRDejImvSvCcnG
X-Authority-Analysis: v=2.4 cv=RqdQvymK c=1 sm=1 tr=0 ts=6af27e2d cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=7p5wX0v9K91KSUfTPpYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAwOCBTYWx0ZWRfX569K9gpzysi5
 L74Ax8pvosrpbDGVhoAjYVAL5SM2R6f93wE/0eHBf+333pXPs5Pa36eIqCT07esatkLn5NzsvGN
 otZLB3al9B22VVdsmb0njQCMQNnJnbv/znVVnfEAEsrsBM5/CRqXeGUfjRbmAxp88QZOPHk1Qfs
 ho9Qh5lQDUT11hPn9HE3lMH+WaIvPhEt3Q22h87LXpFKpbc0OzU4mCQTqIiurge1QQ6gUZZxIoT
 anvEWlfXC7ytMrZStD7G+eaRw0iNsmB1t4OyBT+2F28RigEYDcj/lb4q7PaPFg5/q5ib+spHx3z
 9aSvn/TQj1XUFKzc49q5NeAjlEt9S0LPEAaiZ0Narl1OsIe1HmdwR7ETRe2bAkioWyxu/k07d47
 yvxaiZ232rgEHMPacvPNOkj9YO28TvUfWIOyDkBqHa1NtdS9QITRjOvI79O0SO098O9x455/8v2
 nuAR/0ziKN1kUV5OaQA==
X-Proofpoint-ORIG-GUID: t8Kqdiz6RLj7G2TooB6qtq6o0T_UCRZA
X-Proofpoint-GUID: t8Kqdiz6RLj7G2TooB6qtq6o0T_UCRZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100008

This series adds support for the Analog Devices MAX30210 I2C
temperature sensor.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/max30210.pdf

The device provides a 16-bit temperature output and includes
features such as a hardware FIFO, programmable sampling rate,
threshold alarms, and interrupt support. The FIFO is exposed as an
IIO buffered capture (kfifo buffer, fed from the FIFO watermark
interrupt) and the threshold alarms as IIO events. As far as I can
tell hwmon has no equivalent for streaming samples out of a hardware
FIFO, and the related MAX30208 is an IIO driver as well.

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

Changes since v5:
https://lore.kernel.org/all/20261023080623.1830-1-johnerasmusmari.geronimo@analog.com/
- Fix the temperature scale: one LSB is 5 milli degrees Celsius, so
  report 5 (IIO_VAL_INT) instead of 5/1000.
- Mask the interrupt status with the enabled interrupts, so threshold
  events and the FIFO that are not enabled are not serviced.
- Start the FIFO interrupt and the autonomous conversion in
  postenable(), after the watermark has been set, and stop them in
  predisable() followed by synchronize_irq(). This also removes the
  goto from preenable(), which mixed a guard with a goto.
- Read STATUS before enabling the FIFO interrupt so a stale A_FULL
  flag does not fire on the freshly flushed FIFO.
- Clamp the hardware FIFO watermark to the FIFO size instead of
  failing.
- Mark SYS_CONF_REG volatile (its reset bit is self-clearing).
- Use gpiod_set_value_cansleep() for the powerdown GPIO.
- Keep the powerdown GPIO asserted for 10 us before deasserting it,
  the datasheet lists a CVT/PDB input low-pulse width of 5 us.
- Do not expose the threshold events when there is no interrupt.
- Review cleanups: check the event type first, use a local regmap
  variable, regmap_test_bits(), simpler set/clear handling in
  write_event_config(), a logical split of the poll call, and rename
  the sampling frequency index to freq_idx.
- Not changed: the interrupt is still requested after
  devm_iio_device_register(), because the event interface is freed
  in iio_device_unregister_eventset(), and autoconv_put() still drops
  its reference when the register write fails (a later direct read
  rewrites TEMP_CONV_REG without AUTO, which stops it).
- Cover letter: removed the incorrect statement about hwmon and
  interrupts, thanks to Guenter for pointing it out.

Tested on real MAX30210 hardware (Raspberry Pi 4) with a 6.12 based
vendor kernel, which has no KASAN or lockdep; this version is only
build-tested against mainline. What was run: the sysfs scale against
the raw reading, FIFO streaming with a fresh first sample, the
watermark clamp, threshold events with the buffer off, disabled
events staying silent while the FIFO interrupt runs (checked against
v5, which leaked them), 50 buffer enable/disable cycles, 80
rmmod/insmod cycles (20 with armed events and 60 timed to land within
about 250 ms of live interrupt traffic), the no-interrupt and the
no-powerdown-GPIO configurations, and the INT_EN/TEMP_CONV state the
chip is left in after removal.

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
 drivers/iio/temperature/max30210.c            | 853 ++++++++++++++++++
 5 files changed, 936 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
 create mode 100644 drivers/iio/temperature/max30210.c

-- 
2.34.1

