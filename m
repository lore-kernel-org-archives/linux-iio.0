Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465581;
	b=HqhIoOfu0DtJgNLSLFPyGiEIgdGtqJOm0uTm2kyes3ZXo44dg1YMTHzIn4C4iP4juJ1K
	 y8izd+1c9d6T1GtrcEau8X2804Ppit6yxJd+dKreiv6g7yFq8r4DWKQpyOgZv1K470AyT
	 Uenk8xoZDJdO7E8ZcND5CQFKOQ7cXQ5PZZPOgkak6ZwiBf/t98Q+PRrafT6hdtjIXH2JR
	 rAhICSvCELiZlJOAstbvb++/NnLdyr+3zc5bzy7CSeo/BrUqLF3lp/QjjA8efMoSzzT9x
	 LlKoP8fDgAqghl193p+9cXfonrzSvAMrWN+mZJsnio9Q7OiMGcLCx/acCzo3tr4BRyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qmc5lnHTHHHfRq/qfxs84Enao8q8XNbu3+of0yEPf4A=;
	b=x+kQAAKZ9IzQqyMaZfHSoGVWLTAG/0l1Es0xQ+EUfncRWwILv32mpRXHcI72GoPlJOec
	 pIidVfL2OpE7m7H4KPi0XlICerOeIeegSSO2o4i+2Z4jrJxDzDHxB73MsvSGgoVbcXzif
	 06YVpCIBxUdNTF606EL9Cz8YtOxgnqrE+3E2juANrRY1Bj1fWqbifUuV90gde0N4qKfZ4
	 uPri32xmXqF3yYgfi9ugILnj1Vum1DFuy+94L6dPMEarNOLbHdOiU89qg0gooUpoSjqvY
	 AMPjtvuOsjOeBr8Liuf8uVhY0nQR/aoOdDeWeKNefceYaRHMD9w/d+D2OsJQiXyUyOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dPYjC6L6;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3059606A327
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 20:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3059606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dPYjC6L6
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4a357b1c649so2232278f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 12:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795465579; x=1796070379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qmc5lnHTHHHfRq/qfxs84Enao8q8XNbu3+of0yEPf4A=;
        b=dPYjC6L63YHdLT0szS2CodZQfYWxLhIVXN0cMjEXKLWwlPsR+Y3mkIaQTYFBxZgQXH
         3Sh0+2WGwFJZ47FfQE0qSj2LDVluDd95tGjR4wxfY+XeiYC/z5gCjFJvoZ+jiykmeyYZ
         g2nYq/nlEeGoDlB7/D34UbitpIu2o0i4e7y2qjtCbZwXAWgJIY3PX8TQAPPtPNuyaxVh
         5DI19f0Rhd9EvBEZzjRupMyKb4//SxxSuykmcNJTWxbPGIYhkdo2h0jgELUPVch37Re+
         fReFv5gGr8e4c2DHih8NF83SVLMzjuc5iAffSO0sQvFf34YZsLEwbPo4FhROIuG+r4Nw
         EfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465579; x=1796070379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qmc5lnHTHHHfRq/qfxs84Enao8q8XNbu3+of0yEPf4A=;
        b=131b0CyzXHyty0g9tdUWquisSsbxshHz3rEocvRAs00ByhA8pXfbZimpqz6rxJr4fT
         UOIfAl0whUPk5LvaXOHNYYqxuvsJto8kokmfFe7jthgBN3e0oP1vLuDQP0kOpOTAyOj3
         ViGMjhJxiADILI9ycYi9NSJqwfCHa15DvTevLP6gD6EG/bsHzvz8NCBav7ZZsxtJg5KF
         y4BFzzVeMQ+/txEAMb3wfKklwYecePvg8S4+kGIVkMCZrPIxUmoBNaxoLPrZUVIH9u/P
         Ubtrj+txTEgpWTKVzd3M93GPiOzuhZRx8HIWhx6c10DhYAnBrT/isz3+2zAoBJGuTXxz
         NyDg==
X-Forwarded-Encrypted: i=1; AL+hErHzC/5sK6nG3isbbuIR4hfu/pldyDWE8wuABv7iG1D5O+b2dxUH1ueM9sBKJyhx7wQjHXXc3TBeJ1E=@vger.kernel.org
X-Gm-Message-State: APuU4Z8AouFHbMN3Pgidz2uZzpSMcJKkjuhidEHoLqDStFrA2Jh1iHo8
	bs6bSN+vmKVcuDyzTxHaW6mjuSZ3bkJ6r/M43U0yh5tvxlObBh6v30rvOwuXfXrWxqo=
X-Gm-Gg: AZFdTZfz0KuokFMQXS1A+2DWsQ+voZIf4Oo7FIjQ/nf1HtyvLJ4QsDhIaXgcFAAvIo6
	oXmE2281Zqa1IaKJBJOiY78qu5kUGoawR4rBX5nbOmf2ki2Td3EZEsiyEyEwf2eRrOfhyBLkamq
	WH5Ef/Vvba68ethZvRv1eackALgimroDBxVhXpo7N7HWb6+amSRVogA3/Q37EtTFuodVUnE7K0G
	JbABw5eCQMp7YU1k8mHTkBB60MgpclvduNSE+L2AgMrDhyVk24u8vwbeJe1hZw17mPM3AShcWEP
	7aJfqzAO5233L6Rql3sgyX7BNXPnZ4f6CknhxH85GQmZI6J1j5F7phxQzWImxwfyCjeKm2efXW3
	txAFwKkYTiqmZcJoFr0vukPFH5sVLwSaagADBbplxKzoGps65evpzMvYoa+RJu0oNKwDo5LnYTK
	ja+guZi9cvlnQsDWaQj2Hf/HP/HeBCPPG2DVw5GM4uIYOKcE7FcWCxohshPvM/gfBpHJ6yY0yZw
	1Z5WMERkCoRg9h+FrIL6UJVzZiuNNmeJkUbSIX1coQi+snKTmsCYlTo7nzezBAdnPzv0LfACXIQ
	FeoVREajlGeCleFefANI9dcjiKKtVoMiMwjgcdhLipfF8jhubMpThf8VI8tTDz+YVD4kWURBqUS
	zsVK/TMD3hrHC
X-Received: by 2002:a5d:5f51:0:b0:4a5:a777:b5d5 with SMTP id ffacd0b85a97d-4abb4c7aad1mr23466010f8f.55.1795465579053;
        Mon, 23 Nov 2026 12:26:19 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm20108713f8f.46.2026.11.23.12.26.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 12:26:18 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] iio: magnetometer: mmc5633: Binding, supply and mount matrix
Date: Mon, 23 Nov 2026 21:26:11 +0100
Message-ID: <20261123202616.17334-1-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
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

The MMC5603 and MMC5633 are listed in trivial-devices.yaml, but boards
need to describe their supply and orientation. Patch 1 gives them a
binding of their own. These bindings are also used by PebbleOS, which
is where the need came from.

Patches 2 to 4 add the matching support to the driver. I have no board
running Linux with these sensors, so they are only compile tested (W=1);
feel free to take only patch 1 if you prefer.

Changes in v4:
- Describe tSR and tOp where they are defined, citing both datasheets
  by revision, page and section, and drop the older tSR comment at its
  use (Andy)

Changes in v3:
- Reference the datasheet timings tOp and tSR in comments, with the
  tSR one in a new patch 2 (Jonathan)

Changes in v2:
- Cover the MMC5633 too, including its I3C connection (Jonathan)
- Add supply and mount matrix support to the driver (Jonathan)
- Drop the mention of the missing I/O supply (Jonathan)

v3: https://lore.kernel.org/all/20261123194943.57601-1-gerard@teslabs.com/
v2: https://lore.kernel.org/all/20261122190836.66111-1-gerard@teslabs.com/
v1: https://lore.kernel.org/all/20261122093412.71604-1-gerard@teslabs.com/

Gerard Marull-Paretas (4):
  dt-bindings: iio: magnetometer: Add MEMSIC MMC5603 and MMC5633
  iio: magnetometer: mmc5633: Reference the datasheet for the SET/RESET
    wait
  iio: magnetometer: mmc5633: Enable the VDD supply
  iio: magnetometer: mmc5633: Add mount matrix support

 .../iio/magnetometer/memsic,mmc5633.yaml      | 61 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  4 --
 drivers/iio/magnetometer/mmc5633.c            | 41 +++++++++++--
 3 files changed, 98 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml


base-commit: c44104f3642da720164042623e4832836aefdd8e
-- 
2.45.2

