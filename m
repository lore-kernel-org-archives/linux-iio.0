Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585901;
	b=pPWnAw/eUSBsOll7yBJNC7woFzGiYAXNsPDnn9Pdl4DQLP++4YAA9sfZJO4ehdnKWKQD
	 kQsQjBL2SwMpy0ttF8cQRe4n13fMs8Li7oFTvLzR1YIHhtTdNh5eh/9yQiNiFAmJuOyrV
	 KuIhJLTf6HnNCTFPHrJNgENHmr1iT9f55yBZgBWdF/FJWrZn7ao8G5//LubAaBKVVo1/v
	 Q+xt9y+VTQLjv8Oizv0oAZuMCI3zMNu1NQS9eGgcrPqIi5KVmTUxn7dH/FB1Mgwqz9YdG
	 2c5FXCqotiPC0dTxkkd3fZIc2izn8MAxUPcGmnUBoy0xoqa+u7KsPhWbUaHj5tyx3LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585901;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=HwMUb4dEkzr3j3kYrSUeFqOaaM2WvdCtqrwakPH61UQ=;
	b=bwmxydE21PrvSCVRNLV2+VBeHzUk4+CH84wv8RtHcUDfdreNMZLIggEV42aSDscgODVJ
	 8crewaVlbgN7dUK7WWHMob42NlnBz2EvLwwjJ/OFDj8nSMMTGz1+v7RO77YTY1RqT6oi+
	 BIYTDH7nhQGoRItomhF+mMkjMsPD9YhAU1fATkOxX3FxsmsGpVkQVBKa1Hm1cGwktJ67U
	 JL+oST4k3xgWuGpSpPqpaBuzqNAAqUtb3l1peKeI8U883xdUnRPy9UmPoWdzZygEEwQb+
	 J4S1oQLjRaI2DRkRhvc6YefkkGyEbcykUs8RBjKxlLHvH2QDXMRRubF1Mjmqfd8VeJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fairphone.com;
	spf=pass smtp.mailfrom=fairphone.com;
	dkim=pass header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=TMizCCmw;
	arc=none smtp.remote-ip=74.125.228.71
Received: from mail-ed2-f7.google.com (mail-ed2-f7.google.com [74.125.228.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AAE606FFD4
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 16:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1AAE606FFD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.a=rsa-sha256 header.s=fair header.b=TMizCCmw
Received: by mail-ed2-f7.google.com with SMTP id 4fb4d7f45d1cf-6b587ca1306so662603a12.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 08:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1794585898; x=1795190698; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HwMUb4dEkzr3j3kYrSUeFqOaaM2WvdCtqrwakPH61UQ=;
        b=TMizCCmwf8mG/JV9eviD9QSmLpeGVHgmSZsbfOa8NLMU8Cpo5WfKMUv5tUSq40GbS6
         NW4O3S+jnsPLGnT4w4iq0qzMEYdjeX2nbriDhkrMAHHfJQ698tj7hGF7R0M8jC3rd2iO
         SkoVNWx48RiYRJ47mP4wm2SHgzlALTJyfvl0pMNE1mauqdQ2uvGhABKBFyFE8GN3JfJI
         l8kN7akXW9XitcAD6G0l6ZlbSoW+JSzA67VXa1FIGwJt+qRprMEVYNPy7gzNiIxNS6gm
         WZKvHmW3b0NrID67oek21Rl6lvTGGiN494NIjDdFneMtyDg5W5w1StgNvvCuJnD4YOzF
         3cAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585898; x=1795190698;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HwMUb4dEkzr3j3kYrSUeFqOaaM2WvdCtqrwakPH61UQ=;
        b=jMK799x03t3W7X9VM6bfKZTsLXYJv424xySzZVsrwXd3BSJxahQsDH/I3atQ7NSbQb
         lRUkRWkoyx/yfcK2j+YeYTJA2kVOwc3UJoF/dZq6UKyRj1LpfN1CBcz6YHP80e3ZWJAJ
         +chjuenwm3CIHtTTOqTKfJUdEq2Aa+sJ2kZ7/fC7OYjXfmWrNzfSqCBYmLt2sBvJ1GL5
         vI5qf7WB7hLsK7dXPSBswei1rcda8+5ecBN8Op7XDs17L3jPRhMAIp5Wn59ZMN6jZC+/
         jOems7QKFxJ9QYdweJuhSBPJGqP7anuVuA4iBr+JzV8+dNqpIimDEvlVDRITP7UE/4yk
         M72Q==
X-Forwarded-Encrypted: i=1; AL+hErHZQHhcSrkOgXY5IGPQAshyherZwFlQZelMsz0ad7EQdsRYAWr9iXpQHYHrojTMhz1dLXcDOqIyneM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8L3G+634bIm8sfRE/DVeLOcGSkJeCOlB+r9C9TdvvbrLj2kdSS
	NYKKgCvkzESkyB3ahDGgKUWnWY1vVg8jiG9oxCEiygnSXK88+v9+DtGmn3sbcGN3JyA=
X-Gm-Gg: AYBFou1h1ihm9hdUimiGwyGIJd15ShsiiYrPTQaVlDlVtq1aFU/juVODPjOUhMOAL7V
	jdl644OjY5xxHQs04/aP9wwQQsF1bDN6n9adW38ljIKGgwurKy2Nxs1xhrZnfYI1Y3FMSj5uouE
	czbiy9CS9Q4KhF9Hdv52Iuf9nxidCugQpFUEaHpq1FJBI9Eyhb4plYKvFGS4amTmkdS/100fVmB
	hBwog17JpbxXuKqsuCrMBGZxrvaRbxWZRe6h11IMQlgNugb8l5xRrV5y60Iqkb8KLqErdqhL4Yp
	CHAae39JbMl1FwRGOks4ouaLH3h/wdWwQF2oK7ROBNfC3rEXp2zEhhmaFpoh1HZTSwPm9AbbtZY
	1Gk6u7xlo6cEZJCwx/JKx0y+QcDo1R7DOHR68itHt0xkjsfzl/6q7zt4ivTY07nOT+G1sxhYFfy
	BL84vYlR0U7m4UYuY2zRjwuVaAvZgpZi9CeaoYh2u2VT/tfWA7cBnbHN4Oal3SilC9ruG0My9Uq
	Eq1QI/oF5/c1TlG1E0pSbW6o2Pw9u+d/LkkJeXAsY/zIWC0G+QsC+nYnAhZ3Ag29Q9TpmqvZMr/
	FfbLf1zPg9lGODVwiLJ1JDFDrQqa9ICvOsMFlxcP0KKia3zCeVZ3TpXo8lhhkkG/zC/NjPGlM9Z
	TPMRrLnE=
X-Received: by 2002:a05:6402:e9d:b0:6b4:9c38:a990 with SMTP id 4fb4d7f45d1cf-6b7c0c75afbmr2983164a12.31.1794585898224;
        Fri, 13 Nov 2026 08:04:58 -0800 (PST)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl. [144.178.202.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c264d99csm1123946a12.36.2026.11.13.08.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:04:57 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/5] Battery temperature ADC plumbing on Qualcomm
 platforms
Date: Fri, 13 Nov 2026 16:56:41 +0100
Message-Id: <20261113-bat-temp-adc-v3-0-743979a8fd90@fairphone.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23Oyw6CMBAF0F8hXTumLZQUV/6HcdHHVLrgYVsJh
 vDvVogb4uzuJPfMLCRi8BjJpVhIwMlHP/Q5lKeCmFb1DwRvcyaccsEoo6BVgoTdCMoakKJstKN
 aCm1IrowBnZ837nbfc8DnK6tpXxKtIoIZus6nS9HjnCDLNctDvoXWxzSE9/bOxLbG/8sTAwpWM
 DSyEVaZ+uqUD2M79HjO/IZN/AfUlPMjwDPgsKzQVqikYEdgXdcPJZAI/x4BAAA=
X-Change-ID: 20251010-bat-temp-adc-8539bf0b85bc
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Jens Reidel <adrian@mainlining.org>, 
 Casey Connolly <casey.connolly@linaro.org>, Val Packett <val@packett.cool>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794585895; l=2567;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=AnCETj31XseSXn+d00dwl6t6SQEdfssfzEz2saX1ad4=;
 b=B1fAUfgQCruIJjGIq6oviNi2fMjyU85Otv492YGAgSOdFhXiv+VZQXayVf13n0Q3YFM8+/zB+
 WQwi6BTRzcyAnpZTL2e1Z2TszEbZKLJv/y8QbvXZ0G4dhmqQIRrjgEB
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

This implements a solution to get battery temperature readings working
on (for example) smartphones with Qualcomm SoCs.

The solution chosen in downstream Qualcomm kernels is exposing
ADC_BAT_THERM_PU* in the ADC driver as temperature channels with the
lookup table ("struct vadc_map_pt") for the specific NTC found in a
device's battery patched to adjust the lookup table. Patching a kernel
per-device is obviously nothing we can put upstream.

The high level solution proposed here:
* ADC driver provides temperature channel in (milli)volt as IIO channel
* generic-adc-thermal driver converts voltage to temperature based on
  provided lookup table from DT (driver has one IIO channel input, one
  IIO channel output)
* The fuel gauge driver can use that temperature IIO channel to expose
  battery temperature via the power supply device

See RFC for other variants or alternatives considered.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v3:
- Expand commit message on dt-bindings patch (Rob)
- Some commit message improvements in generic-adc patch (Andy)
- Fix dt node location, move higher up (Konrad)
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20260220-bat-temp-adc-v2-0-fe34ed4ea851@fairphone.com

Changes in v2:
- Rebase on linux-next (a different patch to add IIO to
  generic-adc-thermal has already landed upstream)
- Un-mark as RFC
- Link to v1: https://lore.kernel.org/r/20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com

---
Luca Weiss (5):
      iio: adc: qcom-spmi-adc5: Add battery thermal channels
      dt-bindings: thermal: generic-adc: Document #io-channel-cells
      thermal/drivers/generic-adc: Allow probe without TZ registration
      arm64: dts: qcom: pm7250b: Define battery temperature ADC channels
      arm64: dts: qcom: sm7225-fairphone-fp4: Add battery temperature node

 .../bindings/thermal/generic-adc-thermal.yaml      |  4 ++
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              | 24 +++++++
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts  | 83 ++++++++++++++++++++++
 drivers/iio/adc/qcom-spmi-adc5.c                   |  6 ++
 drivers/iio/adc/qcom-vadc-common.c                 | 16 +++++
 drivers/thermal/thermal-generic-adc.c              | 20 +++---
 include/linux/iio/adc/qcom-vadc-common.h           |  3 +
 7 files changed, 147 insertions(+), 9 deletions(-)
---
base-commit: 6aa7dbf8ad5ebd3babf53a4d6209018f86939f17
change-id: 20251010-bat-temp-adc-8539bf0b85bc

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

