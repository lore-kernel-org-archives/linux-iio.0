Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792905494;
	b=aplLRnmJlQd/jPoGYMMQFyEYYUCsrtnm/iLRAqcRdZ4KOcJByWq9KRPA2HkuH3jxxxT8
	 RULnOkZOvMcMoRqUzjZK3tQrBeneSNQcvRNi+IeYeykgFTAehvUOI8k3+F0eKbBJomPzg
	 XijAtJiPnEwpa5evAdqMhjJ+mYKPDuBxlA9gPXYH3SKPB44XKs4lHd1EgG9vhNWxDWf7A
	 SIy1B6UKUScUb64Zq8fKK51+KRbP5z7CYDhV0pzjKOE0tAkshFbDus9fziW9828KtwV4g
	 QwcXpZkk8f1wul2sntWWAR9MyDhdryOFuG5KOPaM0D0J0cTP6h7XacCRRsc/kxNa66Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792905494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=/W2ZST1PdRMiETuySk5iN0wTTyj64nbsfp3hS9oPgWA=;
	b=zwuY7lbeqmbeXyExTUwbMmhVuakcU7VYJPmMuIprsD7a2PLmpqbKcvfttMFHdXlqkfR+
	 5lTZnO2uWodCalft1hWy6A23Z6WBlZrYPRhkbyFIDRJumkylUDjpYIC/alXcf1KRUlvjl
	 dCnpyHFhkcMIRgx3VKyzKxjB+1HxAoMjFgiU1D6cTtxO2mC0ePPK+rxjV8T+rS5hZ1kXg
	 YwE/K3oeouKPdvs7/eeogXHNeOJRyPvPGIeb9QinxRZCO5mcoRdxCe5Vho1FcQ9W01ynP
	 SQLB5m3Wu0GbC+ecOhiBajHf6djCAOMposTUOOGNs4rXdsQ62/SngX7rn1ig6e2kzGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=drja54eF;
	arc=none smtp.remote-ip=74.125.224.130
Received: from mail-yx2-f2.google.com (mail-yx2-f2.google.com [74.125.224.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4224606A31D
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2026 05:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4224606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=drja54eF
Received: by mail-yx2-f2.google.com with SMTP id 956f58d0204a3-679e6ab647dso907971d50.0
        for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 22:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792905492; x=1793510292; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/W2ZST1PdRMiETuySk5iN0wTTyj64nbsfp3hS9oPgWA=;
        b=drja54eFfOch0K2zQqZ+GcI5pRTkKIua+FkkXwTXsXLqxXMjggZrXYM4w7OdalIeQR
         8hn11BPeNLyLW1EqGm3B7ceBn8cAKPebgrcDuIE9uOoQmTzoTCBa15gr5Vc/yo3qNN5i
         LZcWIq9rLcstfAsz9YoOYcHF29T61rUHulmm9hxTJ6z+HIQ52MbbD1ug6AFryJY6QqOE
         vYsXIBD34c99QGkEWeHfKib+YMI222btcaBuP/DHz+5CYukhAEorA7l9wxp0YXGlkjQB
         MsNt9wn9QvDg7JNuQuAj9tAWqmS6y71dykTClSWk/O+LuJJPvx8wK+v++bPy2JVhaHqr
         t4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792905492; x=1793510292;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/W2ZST1PdRMiETuySk5iN0wTTyj64nbsfp3hS9oPgWA=;
        b=E2XseseutrZJLswWJ2iY93GibCayUUOl6HwgRQzZaTi4CQvZv9ZS1jlMgPXdzaVc1w
         MTFhL9crLkjnb3sKtHSAql0F3rCSR5jbzBzEykJPTJrBbEIkqYIdP9RtMz0qP9HxyosU
         YQ8LWSqyku7NreDZRAAT2fSx/f0pQb2WB8Ckb+MVQreB+840uHVSREAkqEKowpnr09O3
         n1zGcjmNd3xccZ+CXdsC0ZUtkGh1J+QF6UW+oUmXOkRufsjVTny1TL+rgm7RElJxvsvD
         5JPj4U2VLp3SQ57+v0Pnrkd7z8SXtEX2GhmEc3pwzB5KL/sTHxp5BaKO+tN4gWZbN3y5
         hzxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfOzD+ir3k3YbgWeafJ364Aa50iaUgYiv45061TXC60jx5hoSu9mDSMqRpb5cQR/ca+G8QzGt6aIc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLy8lYj9+Yi+VTB2R4rhj/06sfoKTXrOYcePROypp0nWsElJXid
	poX/KjU0hsKAt+v3hh3Q2bdJyQBWytoadKB15H0gBFyrk5eDtfEDji8B
X-Gm-Gg: AYBFou0lkbrvs7SUyYa+r41hLldy9rvkfU9wqOgTikvSQyVFKN0fJ7CzdzDcgj9IUIn
	YxkW9SQC72UdaGCn2ZHzdpwZYVC8j4QrjTL5cFh4SSn3wSbk8pRWwdcQlDzZeLIeuG4ugQWIuR1
	9duuwAPa38VrLJzTOpVi7/yoZnwH6nm/GizZA0tsxUajI8lPHU+WjcbyVBzgOs5Zh2ijgjGT5pf
	NsVdXEU/yLJRDZehsIiLtKXvuG6m0WQyb1sMienvRbQcbCqC4it2H3jxxwYdg2FmY10EZ5M4xq6
	NKVdPjaV/w2d/3b03MBojBrSoucfs9tq6WoUPuPVpIWB/H6ebo8+pj/c91kHVoieHkxHVMs3sTl
	9WOo+4DHZcTK0NV3m6jW39zJwBJCmtAP4PrzCvHMsGjlnsCVSrRVkYF3R1ANOBmwFo36iQVhfgD
	MV3IdX2Abf5fTxZANBo7Rex0RPBkcgwKCGl98w4mmM4vFIa2djscy9wYbkpiGddHryRPM0aRIdT
	vjrw7mQOlffIG33gBQcG/pKbO8r763z/gZcwZQaWNJsiQ==
X-Received: by 2002:a05:690c:3141:b0:8b0:a01e:2ccd with SMTP id 00721157ae682-8b166c938afmr20299057b3.62.1792905492438;
        Sat, 24 Oct 2026 22:18:12 -0700 (PDT)
Received: from [192.168.1.91] ([2600:1702:894b:4a00::12])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b166c5d605sm16477797b3.5.2026.10.24.22.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 22:18:11 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Subject: [PATCH v5 0/2] iio: adc: add mt6397 PMIC AUXADC support
Date: Sun, 25 Oct 2026 00:18:07 -0500
Message-Id: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-0-5c3c7a5a1851@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/43NQW6DMBBA0atYXjPVMIMdwir3qLow9oRYKhDZg
 NJG3L0iUiXUbtj+xftPnSVFybpRT51kiTmOg26UKZT2Nzd0AjHoRmlCsnguK0htmgXyLN8w3/O
 UxPVx6KCfLJ9P4OaHCx6MlEQ1kvEGdaH0Pck1Pl6b949C6VvM05i+Xtel3OrvwBwbLCUgBDaBn
 Odgr3jpehc/3/zY622w0B49HURpQ1s2dU3OYv0P5R1KeBBlQPCIEpxvRWz1F632aH0QrQCB2DA
 7DIzCe3Rd1x+DAIjN1wEAAA==
X-Change-ID: 20260914-rbrue-suez-upstreaming-mt6397-auxadc-5e1228025c50
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Roman Vivchar <rva333@protonmail.com>, 
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ryan Brue <ryanbrue.dev@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792905489; l=10472;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=hZ4ataN3TqF3XlcUTTlr0WAyyMp0HQO8iZw+M3vlDFw=;
 b=PGRd3RMljy/6mIRA8gGGOeRo7WduXda/Rryemi47hJYV3sSsq4sgHWrhfc4JzkvhM5IjreR0T
 CkV77HYcjVCDhu9OirSxZjs6ecT4tzXz5sn4coU1G5jEG5GuR5JXq9L
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The MediaTek mt6397 PMIC has a 10-bit AUXADC that nothing in-tree can
reach. On boards built around it that ADC is the only path to the battery:
the SoC's AUXADC is wired to board thermistors, and the charger ICs these
boards use have no ADC at all, so without it there is no pack voltage and
no state of charge.

Patch 1 adds the compatible to the existing MediaTek PMIC AUXADC schema and
the header naming the channels, patch 2 the driver. The MFD cell that
instantiates it was patch 3 of v4, which Lee has applied [1].

The mt6397 is not given mediatek,mt6359-auxadc as a fallback because the
two are not register compatible; patch 1 has the detail.

Only the two channels a board needs for its pack are described, so patch 1
ships a header naming them: a channel ID is an index into the driver's
array and not the PMIC's channel number, as in mt6323-auxadc. The register
sequences are the ones the vendor kernel's pmic_auxadc.c programs.

Tested on an Amazon Fire HD 10 (2017), an mt8173 with an mt6397. Both
channels are exercised: the battery channel by a fuel gauge, which reads
817 counts, 3830 mV with the pack at rest, and the thermistor channel by an
ntc-thermistor consuming it. The error paths are driven by injecting a
regmap failure into each helper in turn. The read returns the injected
error, and every bit is cleared again. The teardown writes were also made
to fail, one at a time. When one write fails, the others still run, and
only the failed write's bits are left set. The next read clears them
anyway. Run the same way, v3 stopped at the first failed write and left the
later bits set. v5 gives the same results as v4 in all of these. Loading
the two modules alternately on the board, their readings differ by 0.3 LSB
on the battery channel and 0.1 LSB on the thermistor, both inside the
comparison's own noise.

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

This series was developed with the help of an LLM coding assistant.

[1] https://lore.kernel.org/all/179206667779.1910726.5341177428334836457.b4-ty@b4/

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
Changes in v5:
- Split the read into one helper per channel, each doing its own setup,
  burst and teardown, and a caller that takes the lock and dispatches on
  the channel. mt6397_auxadc_release() is gone. The register sequence is
  unchanged on every path, including every failure path, and retested on
  hardware. (Jonathan)
- Keep Andy's Reviewed-by on patch 2, since the change is a restructure
  that does not change behavior. If that's incorrect let me know.
- Drop the MFD cell patch, applied by Lee from v4.
- Rebase onto iio/testing. The MAINTAINERS entry now follows the MT6323
  PMIC NVMEM one.
- Drop the Assisted-by trailers per the new kernel guidance, and put the
  disclosure in the cover letter.
- Link to v4: https://patch.msgid.link/20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-0-23533a0d30e3@gmail.com

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
Ryan Brue (2):
      dt-bindings: iio: adc: mediatek,mt6359-auxadc: add mt6397 PMIC AUXADC
      iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC driver

 .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |   1 +
 MAINTAINERS                                        |   7 +
 drivers/iio/adc/Kconfig                            |  11 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/mt6397-auxadc.c                    | 394 +++++++++++++++++++++
 .../dt-bindings/iio/adc/mediatek,mt6397-auxadc.h   |   9 +
 6 files changed, 423 insertions(+)
---
base-commit: c9dbe2a47f635465c9985b7af74d2ae310e98125
change-id: 20260914-rbrue-suez-upstreaming-mt6397-auxadc-5e1228025c50

Best regards,
-- 
Ryan Brue <ryanbrue.dev@gmail.com>

