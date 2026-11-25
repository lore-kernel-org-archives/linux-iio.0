Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575309;
	b=hNQimoTwGftqMw2N36L4YSyXVV2IV8FX9FZe4AniGXAAPYyhGu2FQXnnLkIqUaRnrByh
	 t6KIVLru61PJdHJJfVHBA495wZUrwJ2dqTTSb0ft8BAbXzJLNCP3y7fEQgnvLxe4Nfujg
	 bH/TmVKcvkQUv6HvfmkOcIJn+KF5YrvfqwfBSAZqdLcja7Qm1LwMaOgatlx71GZZiGLmc
	 AU8N5reChkefuXK6VJPab8zs27GFdFTpEWWahNn+JkC2zcJSXbecKOvVfr8lx1N3CXZtE
	 1258mnuzSV083eUfLPwpL04l/T7yCoAEl4wTPxzQS61vGdbpzUUMVwGWpKYQFNmjdiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575309;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cGZf12lYbOv8GeHOH6mP/MgEgG3TNZihs0+Tj/pWod0=;
	b=A+DG45svYZsrKziSaz7dJQJ7lGgCh7tBItfUWkb5v/omHC8YZ4nUswjwnDYoBEIFJuAM
	 l6xHlt0GOC/b5EjU/kee+6oWh7CbOQ++E4abosdFeVSdjEygP57xuabTNA3hhyhGMjj7c
	 u5RNN3CMmkoEaUzQdGZ3PM/s7RojPKgijuRbtSGFPOzymrDma02G04GWPfkmZLFE2EjiV
	 A8it/2YcEuYreLMO+1lL52uLxrv9uvHJRMBl/2Sel1zOkdabQ04pfycIC2URiqVxQ4kV9
	 wiB34bS7gMD5W01BTBnptuYQk4GzgvXxAIyqxWp4TVlYTxAEKOSWz8bXaYe+UOr9tpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=QbvZhA1c;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dMx8CW5r;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07756606A31E;
	Wed, 25 Nov 2026 02:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07756606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=QbvZhA1c;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=dMx8CW5r
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP2AkEp1029882;
	Tue, 24 Nov 2026 21:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=cGZf12lYbOv8GeHO
	H6mP/MgEgG3TNZihs0+Tj/pWod0=; b=QbvZhA1cviP0p8KiESn0QASE0N8AZ71B
	9W/cTkZL1N07rS8IrbMIP9bbzB+VTKx05cG6o2QcHGzMbtUJtAnNQqv/5NmMZsA2
	numnOG1oubVFdsNWJZljeOAd0wdWrOHUTfi+JxhoYEa3KYOuG1Mk4Bu41kxnG8LT
	BZTI+ISEqnuLix9KdbJW/N4vF/m6G4Upn1eZ8+Vw8RojRlYon2ioveRcO+3byRvD
	+7zDskS6xmaDo1nbqzkuZwvCu0zmWpAb19gh2m1gELkUyugqf63FwDHslVcvxmsd
	mBhhOBgqjo77PODJNTLk1x/9fu0iAzfYqng+nUnLjYojlfq4C7tUrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=cGZf12lYbOv8GeHOH6mP/MgEgG3
	TNZihs0+Tj/pWod0=; b=dMx8CW5r+92493RgOwzbEsx0Goy3sLA4aiflzkHRTj+
	YTuN41Jjw7AMZbji9I9uOgkENvOZkwlAW+vaAHrt6lmfTcPjBBfQWSVkeCZaXn3b
	xtZw1K72tGJcmx1Sp0FqAWdOhGHAEN/XdgT8I6Kwo9tktGPySBfrFAdNr+aArrhS
	fmNr2TttuPQhDbJuNjqePnvq1BaD/GmV/VvBvskzvHWOha19ul35YSib12HC0bGQ
	94jzTEJwu2/ylKth1Wgn/EP7U5adfRtTfOwoKDuzoQ+vdKdG5IqCOefd8ZEaCOES
	oFm76NePmJzsconwE64DIOUMgLtfK8/kCPyam3vn9VQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j4sv5he3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 21:54:57 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6AP2suJo011680
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Nov 2026 21:54:56 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 24 Nov
 2026 21:54:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 24 Nov 2026 21:54:56 -0500
Received: from JGERONI2-L01.ad.analog.com ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AP2sYQG016116;
	Tue, 24 Nov 2026 21:54:38 -0500
From: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <krzk+dt@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
        <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <joshua.crofts1@gmail.com>,
        Guenter
 Roeck <linux@sinkhole.paloaltonetworks.com>,
        <linux-hwmon@vger.kernel.org>
Subject: [PATCH v7 0/2] Add support for Analog Devices MAX30210
Date: Wed, 25 Nov 2026 10:54:23 +0800
Message-ID: <20261125025425.1176-1-johnerasmusmari.geronimo@analog.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAxMSBTYWx0ZWRfXyJeVYN5ijDM8
 dPcoSLlGSqi9RYG3AegxoQg/MWM0FOYHLgJaeKjkpSFmFpO08vHKechxFYTFNA1y1oh4iHMhkZb
 7u1mxkwh0DnaVCw1/qztMsHlENzw0XnblKvVqKdG6kZNO2moibHlQ/SsRmNe9dksEYuMmvArK5J
 eN/agOjeNMKF++9EP6ranlN5tH+9g69xwjHf6Oq7w7lmuUDD/WF0HWvfmLnDlFYZNbyf20jPwRv
 smsgl90h0O0hnyFFwrbvSr2tGGFxmxaVIIAW2wUz+TfstksS2qG9O/SjyrhMbSt8aazqclCW3XE
 L5UshU/0fWfSOiRpOml9N3RaEJ1MJY7zLForEAqjqM+dBFDpMJPyy/8VNqmJMGIr53vexZWoMir
 UCwjGcq50ALawXiHA4t4G9W3xGTvia0VHWIlTBulY3Y2LGp4/doZXgLG5VvgkoOjv1Oo9r7cqrf
 Vfx72neYZTFaIQdOPzA==
X-Authority-Analysis: v=2.4 cv=fIqsTpae c=1 sm=1 tr=0 ts=6b064e01 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=46eRfCW_0dCvvpRp6lMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HOCyQ8ATlZCu1t7OrpOjEy8UcUUxEdyX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAxMSBTYWx0ZWRfX6Lt+WcRyhi7L
 /PeZicU6TS8QKxAHTalaprlXSQ4bwrb/tUVC65JyKNaiOTwdt1OTO9vggRITs9i1oCqDJpguL3L
 Q+RoED7DM8famiO+gmphRw+SEaoB8+RCnAA8SeVpuZo20apGYCKC
X-Proofpoint-ORIG-GUID: HOCyQ8ATlZCu1t7OrpOjEy8UcUUxEdyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1011 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250011

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

Patch 1 adds the devicetree binding (unchanged since v5).
Patch 2 adds the IIO driver implementation.

Changes since v6:
https://lore.kernel.org/all/20261110021442.410-1-johnerasmusmari.geronimo@analog.com/
- Request the interrupt before devm_iio_device_register(), after the
  quiesce action is registered. Jonathan asked for this on v4 and I
  refused it on v5 and v6 because I believed the event interface was
  freed on unregister. That was wrong: iio_device_unregister_eventset()
  is only called from iio_dev_release(), which runs after all other
  devm actions, so the order is safe. Removal is now: unregister
  (predisable() synchronizes a live interrupt), free the interrupt,
  quiesce, power down. The interrupt handler returns IRQ_NONE while
  INT_EN is 0, so requesting it early is harmless. Sorry about that,
  and thanks to Jonathan and sashiko for not letting it go.
- postenable(): only read STATUS to drop a stale A_FULL when no
  autonomous conversion user (threshold event) exists, and do it
  before the conversion is started. Otherwise the clear-on-read could
  swallow a pending TEMP_HI/TEMP_LO flag of an armed event (sashiko).
  With events armed a stale A_FULL may remain and fifo_read() skips
  the invalid samples.
- Rate-limit the error messages in the interrupt handler and in
  max30210_fifo_read().
- Style cleanups from Andy: multi-line comment in autoconv_put(), an
  index variable in max30210_fifo_read(), local regmap and
  m/v variables with field_prep() in max30210_write_raw(), clamp the
  watermark before checking it for zero, "5 µs" in the comment.
- Rebased on the current iio togreg.

Tested on real MAX30210 hardware (Raspberry Pi 4) with a 6.12 based
vendor kernel, which has no KASAN or lockdep; this version is only
build-tested against mainline (W=1, checkpatch --strict and
dt_binding_check are clean). Re-run on this version: the sysfs scale
against the raw reading, FIFO streaming with a fresh first sample, the
watermark clamp, threshold events with the buffer off, disabled events
staying silent while the FIFO interrupt runs, 50 buffer
enable/disable cycles, the buffer enabled with events already armed
and the other way round, 80 rmmod/insmod cycles (20 with interrupts
firing and 60 timed to land within about 250 ms of live interrupt
traffic), 60 more rmmod cycles with the buffer and events active,
the no-interrupt and the no-powerdown-GPIO configurations, and the
INT_EN/TEMP_CONV state the chip is left in after removal (checked
against a driver without the quiesce action, which fails the check).

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
- Not changed: autoconv_put() still drops its reference when the
  register write fails (a later direct read rewrites TEMP_CONV_REG
  without AUTO, which stops it).
- Cover letter: removed the incorrect statement about hwmon and
  interrupts, thanks to Guenter for pointing it out.

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
 drivers/iio/temperature/max30210.c            | 859 ++++++++++++++++++
 5 files changed, 942 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
 create mode 100644 drivers/iio/temperature/max30210.c

-- 
2.34.1

