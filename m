Received: from mail-qk2-f3.google.com (mail-qk2-f3.google.com [74.125.230.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543104FB9D1
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629049; cv=none; b=Jse9rrUkIj5AX4B7MLVQAJ3bn0W3xAi5WcF4pYxG8AI/K7+r9Gl/KymSalxY6bXs6I4glgXH98u25C8Fo2PcK4gpd5oYlYtbIUGWMr6Y5kVw33Tm2ONRM3Idi3DquU5ZsjKN+IMHz1R+A7mnk+zJK+F9VlaeaOrWdS8pk7SRjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629049; c=relaxed/simple;
	bh=X7rWD2jzzHbsWFfZ3PsGJIz721WPwrvFp+KPtPDgD9g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UWLx6vs0F+CIYor6CraWNp44uQPqsbgYLpZhM7wslGSTYzaYYm5HpHHDVwoUSZmx4HiMeJ8hMHyC/7HbMJFybGzseSuvad+pJ0/NT5t1gFijZrp4za2dL+pQc3rCPGXQyFFxcZTXC36hjM9RUKTKDR4CHFI4HHwN+sav5yfEJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIsUeUDb; arc=none smtp.client-ip=74.125.230.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIsUeUDb"
Received: by mail-qk2-f3.google.com with SMTP id d75a77b69052e-5330918daeaso6928491cf.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 13:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790629046; x=1791233846; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=W7dESHL0vifQnHIeAhXaCrb7JvaI9KDwDeR5hQlydKw=;
        b=MIsUeUDbL7hyl2GTqvU9p0p7/s+gAdMCfmLswfNJXQRQcXQAB3Vp4Kxc30lub3dJXs
         oXSmgKnuX2gHXzT85jJy2aHp8ZfcDs4PNoZQdG3Z/BQgVxQamAqpPJP32AHh7Oo6VZnN
         Oj/6j/5uk+ofs7ZEvi2pSWrqQwZmllEXNq98Dh+eeLvZPD6DyTWUCxQzDuQxECVc4YQX
         eRw5hhDOQdHR8NKsCzXrxD3pqk2POk1TOVOOSwJz71qxu0cxKwH9Om2AXXPbez4zzvSt
         8R0tDdHu0Djrf3jABRmoCwlHYlEvM7VsJrNxulMLcYnoFBdRwB+CqtMc/PTeSkajdyTf
         O4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790629046; x=1791233846;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=W7dESHL0vifQnHIeAhXaCrb7JvaI9KDwDeR5hQlydKw=;
        b=DnfyeoaaECy829uhH9mk9K8ew52bNvX47HeVJpk7RdsaBTjZRRQ7T9MPHPoZ9rm/Y9
         XRGeAaENjuzjfuTLfrb6VxR7c80CPmETz16r6PRc4BuzkNHrEzn+/Ub81w7h9/Az2wWL
         QaekPhGWqSMrdM34cLlI/vhQzoD+VsxsrB+3N+bC48K+x5G2j2eTly9FwD8hLqHZ7BjR
         CGmDeOoX26DyNLb3qLJ+ePwhFJZzk0iVzTi4Ozq0ExkWLGC36CK21oH77JTTCfKCkTja
         oCpaXsZWgFpRdyuWd1X7elXVMfHirYBqZnhNa6hnHmjTqda3+n03obq4lUKf0usEqCct
         efUA==
X-Gm-Message-State: AFuF++k5nqIDSSacX4Kj7yV4ykKWeIvRoUdclv8HoCbd/Z1d02sVSVg1
	BBxzfNYFwLWwwCQRu6YrccazhfAobO6q1TmTdiK3xWknli03o3/P+K7F
X-Gm-Gg: AYBFou2fWKO1+RtSo+jN7zQNncxNNBMGpSU4S79wPE6d3290JKAyTfHaLQoCweA/Dhu
	RNgJJrQTRhNvuwoXDx2kUW8vp7r6y1K7PYylYdFgtI7VQ/ZhRpmKobkIwGA5jPYgFRbS2MP8iLY
	ZAYy5HOcy+b8e+kiVakbrEbnxzkqi27TNwevjquKgJy2+LGRiQyHZBjzwhKLTtobQBo1Eka1gma
	R0SISLplqPCI52VW9vNGZ7DMKa6Swt+yxqE2I5rRYwHk4GDxgmcXKK+WLGiK7MwHR1rzv5+kmOI
	A9LLAVxVnszrzhRPSdlI0DNx/cDFr6hydcMs5Z42KtMNPhiSbEjmZRIuYpa2LWNH8NoTOXkVp7Y
	2IdDZ8oBpghaBZfC5Wy4Bw0veG8nQeOtwV4+47uHjDk/f5c7Jdq99hk7CV5q65luEo+T4J1DBOB
	yDs55TDn9U2ylv8VnOtpfyUDTg+wXIrSr66TPN0bxwTsqH6dYPioTrleSXjSiqVCclDR7J0ZV3V
	NIK0Oh+T1Lmw2dr3QEE6nS4tAuTmsxoN40BHR07y97HE+dMQWneTtHBWa+uHRVp
X-Received: by 2002:a05:622a:491:b0:532:a2ba:c3d with SMTP id d75a77b69052e-5330b5572c9mr235921541cf.10.1790629046042;
        Mon, 28 Sep 2026 13:57:26 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-533223c6d82sm71443421cf.21.2026.09.28.13.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:57:25 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH v4 0/3] iio: adc: add mt6397 PMIC AUXADC support
Date: Mon, 28 Sep 2026 15:57:18 -0500
Message-Id: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-0-23533a0d30e3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NywrCMBCF4VeRrB2ZTppYXfke4iJNxhqwF5K2e
 KHvbioIBTddnrP4/reIHDxHcdy8ReDRR982aeTbjbA301QM3qUtCEnjIcshlGFgiAO/YOhiH9j
 Uvqmg7rU87MEMD+MsKM6ICiRlFYpEdYGv/vHNnC9p33zs2/D8Vsdsfn8BtS4wZoDgpHJkrHT6i
 qeqNv6+s20t5sBIS3S/EqUZLaUqCjIaiz9ULlDClahMqEVkZ2zJrPMlOk3TBxPKj3SCAQAA
X-Change-ID: 20260914-rbrue-suez-upstreaming-mt6397-auxadc-5e1228025c50
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, mfd@lists.linux.dev, 
 Roman Vivchar <rva333@protonmail.com>, 
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Ryan Brue <ryanbrue.dev@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790629044; l=9791;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=X7rWD2jzzHbsWFfZ3PsGJIz721WPwrvFp+KPtPDgD9g=;
 b=LzhRpY3f7y28sCPo1w0Dus+9fZPfV+dyY5AItrh98GZKaCBTgm1Pv4YK8Cq15vaV472K18L7H
 bGtxQrr4LU1DbeLBNEoIlL0TZSEf/H/z9I2MioA8eyebWad/veuCsvR
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The MediaTek mt6397 PMIC has a 10-bit AUXADC that nothing in-tree can
reach. On boards built around it that ADC is the only path to the battery:
the SoC's AUXADC is wired to board thermistors, and the charger ICs these
boards use have no ADC at all, so without it there is no pack voltage and
no state of charge.

Patch 1 adds the compatible to the existing MediaTek PMIC AUXADC schema and
the header naming the channels, patch 2 the driver, patch 3 the MFD cell
that instantiates it. The cell comes last so that no commit in between
registers a child no driver can claim.

The mt6397 is not given mediatek,mt6359-auxadc as a fallback because the
two are not register compatible; patch 1 has the detail.

Only the two channels a board needs for its pack are described, so patch 1
ships a header naming them: a channel ID is an index into the driver's
array and not the PMIC's channel number, as in mt6323-auxadc. The register
sequences are the ones the vendor kernel's pmic_auxadc.c programs.

One note on patch 3: it adds a cell to mt6397_devs[], which Luca Leonardo
Scorcia's MT6392 series converts to the MFD_CELL_* macros in its patch
4/9 [1]. Whichever of the two lands second needs a respin. Mine would
become a single MFD_CELL_OF(), and I can do a respin if that patch arrives
first.

Tested on an Amazon Fire HD 10 (2017), an mt8173 with an mt6397. Both
channels are exercised: the battery channel by a fuel gauge, which reads
817 counts, 3830 mV with the pack at rest, and the thermistor channel by an
ntc-thermistor consuming it. The error paths are driven by injecting a
regmap failure into each helper in turn. The read returns the injected
error, and every bit is cleared again. The teardown writes were also made
to fail, one at a time. When one write fails, the others still run, and
only the failed write's bits are left set. The next read clears them
anyway. Run the same way, v3 stopped at the first failed write and left the
later bits set.

A new driver was created here, instead of modifying an existing driver such
as mt6323-auxadc or mt6359-auxadc, for the following reasons:

 - Both mt6323-auxadc and mt6359-auxadc select channels through a request
   register (1 bit per channel), while mt6397 uses a 4-bit numeric field
   CHSEL in CON1 (10:7), and then pulses a START bit (CON1 bit 0).

 - For mt6323-auxadc, which is the closest I could find to the mt6397
   (CON0..CON27), it has 13 more registers than the mt6397 (CON0..CON14).
   It uses CON22 for its request register, and reads the result value
   from the same register as the ready bit. We don't do that - the mt6397
   has a factory-calibrated value for each channel at 0x16 higher than the
   raw value. mt6323 also has a 1800 mV / 15 bit scale / resolution while
   we have 1200 mV / 10 bits. We also have some per-channel preparation
   that we have to do before the burst, that the mt6323 doesn't have to
   do.

 - For mt6359-auxadc, it has a more generic framework for describing the
   AUXADC, but it assumes requests are channel-per-bit, and so we would
   have to basically ignore req_idx, req_mask, rdy_idx, and rdy_mask.

 - We also have our own software sampling, which the vendor does too
   (Amazon Fire OS based on Linux 3.18). We'd have to have our own
   sampling callback to do it.

I have two things in the driver different from the vendor (Amazon
Fire OS based on a 3.18 kernel). Verified with over 150 interleaved reads
per setting:

 - Leaving the ISENSE input enabled between reads, as the vendor does,
   makes no difference to the value, so the driver switches it off again.
   Both ADC input enables are clear when idle, unless a teardown write
   itself fails: the rest of the teardown still runs, and the next read of
   the channel clears whatever was left set.

 - The chip's sample accumulator makes no difference at 4, 8, 16 or 31
   samples and costs no measurable time, so it is left at one. Software
   averaging helps, but only by about a quarter: in one interleaved run,
   0.92 LSB standard deviation for one conversion against 0.67 for sixteen,
   where independent samples would have given 0.23. Conversions in a burst
   are correlated.

The reading was checked against the charger, which regulates the pack to
a programmed voltage in constant-voltage mode. Over twelve such voltages
from 3904 to 4080 mV, and charge currents from 111 to 778 mA, the driver's
reading is a mean of 0.9 mV from the regulated value, well inside
the charger's regulation tolerance. That also settles reading the chip's
trimmed result register rather than the raw one - the raw register is
20.7 mV low at every one of the twelve points.

[1] https://lore.kernel.org/all/20260902193351.185771-5-l.scorcia@gmail.com/

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Changes in v4:
- Attempt every teardown write even if a previous one fails, so a failed
  write doesn't leave the buffer, bias, or input powered. Reverses the v3
  change. The teardown neither checks nor logs errors for failed writes,
  similar to mt6358_stop_imp_conv(). The next read will rewrite those bits
  anyway. (Angelo, sashiko-bot, Andy)
- Move teardown into mt6397_auxadc_release(), keep error paths out of line
  with goto, and use mutex_lock() / mutex_unlock() rather than guard().
  (Jonathan)
- Reword the comment above the BATSNS disable prior to ISENSE enable.
  (Jonathan)
- Collect tags.
- Link to v3: https://patch.msgid.link/20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com

Changes in v3:
- Move the sample loop into its own function, so read_channel() is setup,
  then a conditional burst, then an unconditional teardown, with no goto
  mixed with guard(). (Andy, sashiko-bot)
- battemp_bias_off() and isense_disable() now return on the first failed
  write, as mt6323_auxadc_release() does, and twelve other teardowns in
  drivers/iio that I could find. A failed write can leave the later bits
  set; the teardown runs at the end of every read, so the next read of that
  channel clears them. (Andy)
- Drop the "if (!ret) ret = err;" accumulators with it. A teardown failure
  now goes to dev_err() rather than being returned, since the caller cannot
  act on it, and read_channel() takes the iio_dev so no struct device * is
  stored. (Andy)
- Split battemp_bias(adc, bool on) into battemp_bias_on() and
  battemp_bias_off(), and drop the bool. (Andy)
- Make the SCALE case an if-else. (Andy)
- Move the "why a new driver" rationale below the --- marker in patch 2,
  out of the commit message. (Andy)
- Reduce the CHSEL regmap_update_bits() call from four lines to two. (Andy)
- Drop the comment above guard(mutex). (Andy)
- Say in a comment why lowering START needs no settling delay. The ready
  bit survives the fall and is cleared by the rise before the next
  transaction on the PMIC wrapper can observe it. I measured this, and the
  details are in the reply on 2/3. (Andy)
- Cc Luca Leonardo Scorcia with a trailer rather than in prose. (Andy)
- Link to v2: https://patch.msgid.link/20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-0-db35882a6080@gmail.com

Changes in v2:
- Add justification for this being a new driver rather than folded into
  mt6323-auxadc.c or mt6359-auxadc.c, in the cover letter and patch 2.
- Drop the "ret = ret ?: ..." chains, and let teardown fall through on
  errors, allowing the chance for all bits to be properly torn down. The
  errors are now held rather than discarded. (Andy and sashiko-bot)
- Run teardown even when per-channel setup fails part-way through, so we
  don't leave bits enabled that would have been cleared. (sashiko-bot)
- Set ISENSE settle time to (1 * USEC_PER_MSEC). (Andy)
- Write the two channel descriptors out instead of using a macro. Also
  gets rid of the padded column. (Andy, Jonathan)
- Move the MAINTAINERS entry for the dt-bindings header into patch 1, as
  the mt6323 series does.
- Declare the sample loop counter in the loop, instead of with sum, and
  split the declaration of sample and ret. (Andy)
- Keep the two CHR_CON16 ADCIN bits as BIT()s rather than turning them
  into values of a GENMASK field. Fix OR operator on the bits, treat them
  as mutually exclusive. (Jonathan)
- The rest of Jonathan's v1 review: two-space indent separating a register's
  fields from the register, a blank line before the settle times, a lock
  comment that says why the lock is held, the two CON1 START writes on one
  line each, the single-call init helper inlined into probe, and { } for the
  of_device_id sentinel.
- Add the additional three CHR_CON16 ADCIN defines that make up the 5
  single-bit enables. These are currently unused.
- Link to v1: https://patch.msgid.link/20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com

---
Ryan Brue (3):
      dt-bindings: iio: adc: mediatek,mt6359-auxadc: add mt6397 PMIC AUXADC
      iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC driver
      mfd: mt6397-core: Add mt6397 AUXADC support

 .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |   1 +
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/mt6397-auxadc.c                    | 377 +++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   3 +
 .../dt-bindings/iio/adc/mediatek,mt6397-auxadc.h   |   9 +
 7 files changed, 409 insertions(+)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20260914-rbrue-suez-upstreaming-mt6397-auxadc-5e1228025c50

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

