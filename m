Received: from mail-oi2-f5.google.com (mail-oi2-f5.google.com [74.125.231.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A321283FC4
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698020; cv=none; b=RcfUBeyr9Kzh8J4SXd1pT3oKmYjmEB5vU3BvdJIEJDWWFVbM8iPSsWyY0dc8KthWBPiO6YdRc6FSL+064O1qe02W8ZbNNVASwy9oqtKs2Vx0kPuP99pp3H4w408BI72PEBhaRACm9jwKGWLpWjLDMG7JrUA552XyEacAIQKAma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698020; c=relaxed/simple;
	bh=y1XijeL7ERuaPsHwAqTxsTx8YvMIXk+ce3oHtZNzHHE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IGV2Kk3A37B3sMkpajxDGxt0oviH0rEGxuLTG9u0XaaEO/swiSjKBk/YI+B7ssuPwKScRvq15v3GqLqUChh9qky7qw27P+fPAemSiZWqJuxdY4TT5PWn2uVsTJrNThx82YwS41BkqDG3npxdhpfVsIekuTzuzxMbXnwQpUclNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlR5mNjy; arc=none smtp.client-ip=74.125.231.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlR5mNjy"
Received: by mail-oi2-f5.google.com with SMTP id 5614622812f47-4b3759b7ff0so154234b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 19:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789698010; x=1790302810; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sc2r2klq9bIyV1XXapVYTBuFntdUrMrqc3FpTwDvDDw=;
        b=WlR5mNjyoTrlcE9cxjPbh86tcd03VfXoAkhFz8VSWxtzqTkXMlhbfZpJaDaMC/G7y6
         6fo/NXW8/jjdu+2jU0BJsXDCx/cRMwXTe0kFGpzVDF/KEHidNaRBrgANLDnuusIXnLXl
         qoi3P+oAABpzQhqutYyKcbTN+d3u4XmTPAJyDyyFQGed/s3+uDfYC/cNC9f0ezmSiZ/3
         aG2NBCjVyXW/RVT3/k0/GchFt6qKWbVytQqlLxpsmtuWu3VQbLAN1irnNqBH8id1xAMF
         IO8Amvm/nPCX0FKJA/lW3ZXkKesAT+HhNklpmHYnIOAGx14jE4BTHyGtZvXj4J22BLhU
         LfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789698010; x=1790302810;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sc2r2klq9bIyV1XXapVYTBuFntdUrMrqc3FpTwDvDDw=;
        b=wIwwQiRLcq9ZW7py93Yac5WfwD46E20wl2+8vpwotG4K90sTWCTKa9Mfy6V43CevjR
         O70ij1y0Khv5xAjxs5bl0eFpu4URddXu7EIiFr2UIVXHKncz3SQipTkq8bWpOMCqYURF
         kaKgdhgPuTyUNHodGXiPDsz29imPnGkjgdwQLBMrmBqNbMMjzQvSBh2u2p4zPZ41DA2U
         U7eLFZBxChxAi06fPE8QEYiDpzoZ9EftsHNVnWhR96yg9EHQDi/CfZZASKhi9Q+DdHWn
         RhDWGMSex8ybQlJRgo3TnjtSEsRB7ipeVB+eBuSMzfMLHBsGqZ0+w6JADoOr8WQCbZLP
         Mo0Q==
X-Gm-Message-State: AFuF++lRNTCWX8MFhFzYTEhgIUanoP3oxbr46nqLL8Dqah5FQq/z8Dq2
	VW3gm2obYGGBltp5wJXOjVI0pec8V1bEf6dTm11MMtmfWVJ36u80iRcg
X-Gm-Gg: AYBFou1ndZilvX5K7SKhAf1pKcUt7TJBy73t9l5GV8z4URap678x7Kkv/GYVKWBcn9a
	5i8DYj07mc/xny5T+P1Sp6eiN9hOSXg/ybNrXnnt5QSLN2w3fPFE5Omk0xq1fvhKot7RwHep82v
	7asA2N07SQrqnXkHShgkoHRfnD0uaiu+n596A/9+lc39zfgvFgm4rBMfIhIvsXlcmbUgdZln9O3
	5Z4Qnm3CZlZFSEo+fMtwvfjcpFQ2HX9DMZKTBiFTd7Go9jEpUgzJ1N4L6FNAdDtEHSQxF9LKuEM
	+Z/VcaoZRZGg0A3nfyZepV5uPtaN7Ab9UwplJsZlhYFvNhfYhZmIqJjx4RAORsVmDC1uMZGnlmO
	ktvISJjdlGjMAFHZN1FjLMqiWEaJ9oZqMMNx1uHHLYQeVaS7pLdlUsQq0ll86LDj55HqNYWZv1d
	HE0HRa3Ih3FIqsMzSYSMThW60xTK49FyEt7I+RHBg6aboCGCNXO892iYvnsZdIuj2mCw==
X-Received: by 2002:a05:6808:1687:b0:4b9:a829:f00a with SMTP id 5614622812f47-4ccf6e76820mr1386242b6e.22.1789698010143;
        Thu, 17 Sep 2026 19:20:10 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80e5226786csm295476a34.22.2026.09.17.19.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 19:20:09 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH v2 0/3] iio: adc: add mt6397 PMIC AUXADC support
Date: Thu, 17 Sep 2026 21:19:49 -0500
Message-Id: <20260917-rbrue-suez-upstreaming-mt6397-auxadc-v2-0-db35882a6080@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NQQ6CMBCF4auQrh3TFoviynsYFrUdYBJLSUsJS
 ri7lcS9y/8t3reyiIEwsmuxsoAzRfJDDnkomOn10CGQzc0klxWvxQnCIySEmPANaYxTQO1o6MB
 NVVmfQadFWwMKhZQXLpVRnOWrMWBLy87cm9w9xcmH167O4rv+APUfMAvgYEtlpTalrVp+65ym5
 9F4x5pt2z71T+yd2AAAAA==
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
 Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789698008; l=6852;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=y1XijeL7ERuaPsHwAqTxsTx8YvMIXk+ce3oHtZNzHHE=;
 b=FCTap6xMVd8AUK+hpvcJVgk4cUYYkXyTqgE1215eBhIbPDxwSKbDPiV3mwBUvfJfMEljyiFuh
 TmSXQurH25iAqdTLf6NrBwRHXlqr6IVrBxX3zPmRt5+JFeYot8yuenp
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
ships a header naming them: a channel ID is an index into the driver's array
and not the PMIC's channel number, as in mt6323-auxadc. The register
sequences are the ones the vendor kernel's pmic_auxadc.c programs.

One note on patch 3: it adds a cell to mt6397_devs[], which Luca Leonardo
Scorcia's MT6392 series converts to the MFD_CELL_* macros in its patch
4/9 [1]. Whichever of the two lands second needs a respin. Mine would
become a single MFD_CELL_OF(), and I can do a respin if that patch arrives
first.
Cc'd Luca.

Tested on an Amazon Fire HD 10 (2017), an mt8173 with an mt6397. Both
channels are exercised: the battery channel by a fuel gauge, which reads 817
counts, 3830 mV with the pack at rest, and the thermistor channel by an
ntc-thermistor consuming it.

A new driver was created here, instead of modifying an existing driver such
as mt6323-auxadc or mt6359-auxadc, for the following reasons:

 - Both mt6323-auxadc and mt6359-auxadc select channels through a request
   register (1 bit per channel), while mt6397 uses a 4-bit numeric field
   CHSEL in CON1 (10:7), and then pulses a START bit (CON1 bit 0).

 - For mt6323-auxadc, which is the closest I could find to the mt6397
   (CON0..CON27), it has 13 more registers than the mt6397 (CON0..CON14).
   It uses CON22 for its request register, and reads the result value
   from the same register as the ready bit. We don't do that - the mt6397
   has a factory calibrated value for each channel at 0x16 higher than the
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
   makes no difference to the value, so the driver switches it off again
   and leaves both ADC input enables clear when idle.

 - The chip's sample accumulator makes no difference at 4, 8, 16 or 31
   samples and costs no measurable time, so it is left at one. Software
   averaging helps, but only by about a quarter: 0.92 LSB standard
   deviation for one conversion against 0.67 for sixteen, where independent
   samples would have given 0.23. Conversions in a burst are correlated.

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
 drivers/iio/adc/mt6397-auxadc.c                    | 378 +++++++++++++++++++++
 drivers/mfd/mt6397-core.c                          |   3 +
 .../dt-bindings/iio/adc/mediatek,mt6397-auxadc.h   |   9 +
 7 files changed, 410 insertions(+)
---
base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
change-id: 20260914-rbrue-suez-upstreaming-mt6397-auxadc-5e1228025c50

Best regards,
--  
Ryan Brue <ryanbrue.dev@gmail.com>

