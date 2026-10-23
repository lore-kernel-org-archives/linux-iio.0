Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778368;
	b=XRdoy8noT5zs6OhZx6nXWLnkGA+PX4hqqxT2jxGlWBoEQEbfn3VAfUblTHds3fRw7URQ
	 zEAPQrIkHsVnizsDAJtWXnTIwRHDH9NEbXcGJ7Bb9mVdN2/G9klC7EuW1/LKoC+Le5xQX
	 IuQrVgccSx8T6DfBtrPfNiX6sgrnVl3rgSzKuPgbFg8Y1wIVfOfIwY6Mo7xM4j/lAZo0/
	 ZQYYOWABqOOU8FCPN4zj25WtmLYyzdYyRp064RHic+h4yHs5abQECmZ8F6tJGv7RB4gZt
	 7iO1FIKCoXvckKY3UV4WTALn+U2O2glRh0EncxbEOtN91BxVyu4ayoRLCW6WQ4+78SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778368;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qpKChd7cX2IKr3NLYeu19b4piYqsJmCK1pOKyiliy74=;
	b=C1LIGR0cn8u+y2Q7cyCGV06IBSePzzJgU4T0EXFK+Gpx1cy1XcWKmr5JMwFOD/PvR5rI
	 oH+kv3b2Bcw9E50x/i0jEYnasBaUZcziXYpC26zkhI8zi8hFar9LtjIcnTPGwK3QHeAOD
	 vBHGT3/UOJjf/VBO/kwiej2piL83j/6pT1ihHQtuBXf/haH/MBQPg5k0dumvsx5jdkqXn
	 1tT1aYIALZzX/fmeYy4T1cgKaS3JCiOy7PILfr5UKCkEHa+W4vfyMLojPuCIJE6lTJiKf
	 Eq7HUf1e4VIlbCGlJOuRQhxaShjN1wCLRRErIRGVU/LNHDkKLp1CcPbha1qh9VxVXDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FMPVSIPU;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D81606A326
	for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 17:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91D81606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FMPVSIPU
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dee593f18so826160f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 23 Oct 2026 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792778366; x=1793383166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qpKChd7cX2IKr3NLYeu19b4piYqsJmCK1pOKyiliy74=;
        b=FMPVSIPUP4r2nJIpBzw+AnOH4syghw9n89Z8Gr3tcHyhYZgMPSW2wo/l9P2KmSJ6xE
         JWW0NRo8Cd/tIuttGp9/u6xE7Eg5agM3nbdUJg9/0sJnaA0r6MYoWRVrBBYtC4EG3Bny
         nhMSK4DUyGvJkJPZWKU+rkgxoGy5Wkh3FW1All8qDORLYNHrFMq+ixmvOR0XjB3fuzWg
         UGvy3wPcZdItGmCc9upmVxpWcNNdbPdThBM/QOQUbsq8JhbkUQhKlyqxhh0DbCL5IFu8
         OK3QcDAmweCwbP5xQOoi2yZwNAnRClPpbrAXkmHWqPOGmvQJVb/J9RVmF4KhqIqrCP/j
         meEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792778366; x=1793383166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qpKChd7cX2IKr3NLYeu19b4piYqsJmCK1pOKyiliy74=;
        b=ZFlZONv6ETp145Z7Co2ix8elFyNJEsvYLqZzniyMemJLJAleQZN9GiDv0g1VXZCCNm
         PKc7Kd/T/KwFhmmaDBD75LTuZA1OmOqI+8Hc6lrP5b3CSqH+9fj61ytnFGh+ivoqZW3r
         heVvFGmjdDVsbqf5Tge5y6WCKdrnzlPn5MFxbwxr2Hm8zUWg6recJ3KK/A3lM9W3OuuC
         u7Kygc5hoPsiW84CUNz1xfrmfu9dYU1VH2GQ12SpdxnT/2ZA8o7LHa4H8zw6FmKU2M6f
         kYjdgD7W9DeoRZbcW/rQpk0T7fRoJYzoJZ1UI2zs2pkJSK74/cDiFMXz3LvqAqXL86dA
         yDWA==
X-Gm-Message-State: AFq9FYI9rpf2cQtwA2cKcIZ7rhSkotVUe0Fa8sbSgp02QnoplK3GlN/0
	WT6hRRpiPuwByJ4EfhsNmavWiWCQBYaLBZmOS8nfM0r3cWsOwZXvlhJNT/82GQTE
X-Gm-Gg: AYBFou2Y1U8+Gu6SukkxYjmxzb911xG8Ax9FvbO0LXBuoB6JZu0nNoCCk7MjgNHVm/H
	b4ogdrB9ykBk/d3A/UcTMMXCmwR3vDwMuOxaJ13PLmcGPpRnRRDBynaTSEdrTW7WXadDBl4jdyr
	w+0fJvo1aX05pxGCxrcV1yZSRmTuzzNRisZ4Y/W+iwfI0mL5+mcYxN7yqmmCzp8HIMHrilGnkZm
	DeL7+0SXSKHLzQHzCZdHVVPtQjAKmabDPxBd4ZH/t3DmE9ag97CkftOOMc1I4n7t+o3QX3w11mH
	oBa3vWc03wuSUNo5NP00fYEpBcrpSpuzyOSaPFA7n+CwXedHs5e/RIHGdZN/ifKcZYbgQ5Nha2e
	iFqam3+uuhK9BgTwv/K/w6GRjKA5jK5gXXXtveKei0TltxZxxmAcgbj2+oy+VJjOY/NxYFdBXbx
	bD32reOfeK8nhKKR9TCOXGEOKbl5KnwMdSvUb5O2ZK/T5FrKy3VY+d3S3adQKfERozcmr2sZ+u+
	PaPAYOHl6f3354baJJq+PyGtj0GNYTfAzbRM70JY5TxGWM1Jc/eWANH9tKYBLQSTQiJkZ0xErDe
	tcHxFnW1pvC/O1rTFUwU4MyMpVpAghUjB00zdm8O/LcnXKrO8Br4BQGAhM1Izzm04MRXXgZD1wd
	QINNUQMgCmvHBgzzQuzvpb1jF7mMiG4KPtKfx6jJGv+sn
X-Received: by 2002:a05:6000:46c8:b0:488:8384:c382 with SMTP id ffacd0b85a97d-48e385a2ca8mr3518753f8f.49.1792778365736;
        Fri, 23 Oct 2026 10:59:25 -0700 (PDT)
Received: from iku.example.org (host86-133-9-17.range86-133.btcentralplus.com. [86.133.9.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3d37ca2asm1342800f8f.8.2026.10.23.10.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 10:59:25 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 0/8] Add ADC driver support for RZ/V2H(P) and RZ/V2N SoCs
Date: Fri, 23 Oct 2026 18:59:11 +0100
Message-ID: <20261023175919.160103-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This patch series aims to add ADC support for the RZ/V2H(P) and RZ/V2N
SoCs. The ADC IP on these SoCs is similar to the one found on the RZ/T2H
SoC but varies slightly in terms of available channels and configuration
options.

v2->v3:
- Added Ack from Conor for the DT binding patch
- Avoided splitting up the ndelay calculation into multiple lines
  in patch#2
- rzt2h_adc_pm_runtime_suspend() now checks the return value of
  reset_control_assert() and returns if non-zero. This is to
  avoid churn in future patch.
- In rzt2h_adc_write_scale() used multiplication() operation
  for comparison by dropping the div_u64_rem in patch #8

v1->v2:
- Dropped using DIV_ROUND_UP_ULL to DIV_ROUND_UP
- Included time64.h
- Returned -ENODATA in case device_get_match_data() returns NULL
- Renamed RZT2H_ADC_VREF_MV to RZT2H_ADC_VREF_mV
- Updated Kconfig description
- Included array_size.h
- Dropped unnecessary extra line in rzt2h_adc_write_scale

v2: https://lore.kernel.org/all/20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
v1: https://lore.kernel.org/all/20260929124248.237032-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (8):
  dt-bindings: iio: adc: renesas,r9a09g077-adc: Add RZ/V2H(P) and RZ/V2N
    support
  iio: adc: rzt2h: Wait for the analog part to stop after a forced stop
  iio: adc: rzt2h: Add chip-specific configuration
  iio: adc: rzt2h: Add optional reset support
  iio: adc: rzt2h: Prepare for SoCs without sample state registers
  iio: adc: rzt2h: Prepare for SoCs with different ADC info
  iio: adc: rzt2h: Use scan type for ADC scale
  iio: adc: rzt2h: Add support for RZ/V2H(P) SoC

 .../iio/adc/renesas,r9a09g077-adc.yaml        |  38 +-
 drivers/iio/adc/Kconfig                       |  10 +-
 drivers/iio/adc/rzt2h_adc.c                   | 327 ++++++++++++++++--
 3 files changed, 346 insertions(+), 29 deletions(-)

-- 
2.55.0

