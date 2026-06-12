Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE43002CF
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781304423; cv=none; b=io0g1kf++B00nv2coJezf+6zea8LFeHIEWTjHoARktrNxGGHzUCZWNmmQQ8p2+poFuNxkU+JAk7DC7ECUiI5r8B2f2AFOyVZ7aLCt+JsiJOfaHBGb6VmMtGZu0MqSE5j3v6KSJEAGB5uUvd39OXVehQYFMrULpg5rvz59uJwXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781304423; c=relaxed/simple;
	bh=DnQqRk8Wr3CWD8K3b2VzKXlVynzHi8xJBBFO2aUAQTw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EZrOmmOkEuyfy68GbUUZwsIsoFpFHuqvlKPt+0H8dKG929IEozOlRQlXyS+f3o4hBwSBDK4mmChxDBp+Hd2c+UFQBOzsXKEvReSlFzdnipLGLgvMcrOZ3Do48ltsCL9w6KhqMSwR3raSuS6ykTaBcWz4Vah1hNWd2X/CjdS5z2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2dDb9UD; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2dDb9UD"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-59be89d310aso1511524e0c.0
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 15:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781304421; x=1781909221; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jPinIBTvadn6Wv8oxclaLI9sZqTMC+eS72l1Gak81fk=;
        b=F2dDb9UDuHSQP0ItNP+xI2ylfUd3azMotZ3Xc7DWDo0wzpRjSPqhsfHerV5TzNaADG
         ar8woOvvc1rRGwxNeDYfzS/bOX92wIG21MTaYQWDbXQ7SINYEuQsx9H2N9ShYM877WtY
         WYRprkBYIWlfnlyiD9ACJYfGw+cDAXBi8rDOV2zsiE9nf3HdHtGxHLs88MWdaCHBioZU
         zMpWjE1zMWbOZgFbI167WwN+Z9WfjoM9f8RBKCxjhPv9BXwhMDvBBR8mAZcjAkvPyWOg
         2s1h6bDF5Drfolf+jUftAI229ECze52jiB2QbTyTfGYEsOhy5491BMtVao/W63+A0cY0
         s6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781304421; x=1781909221;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPinIBTvadn6Wv8oxclaLI9sZqTMC+eS72l1Gak81fk=;
        b=ZAtjh6hnYpb477JKDgiyLpDbR/uOCInaTs755xvI5AWN1SfqkIw3+uCaWytVgaemrE
         pEGb93Zj/wZDuLbqaEr3JLmVNbSwMq/7dVlQPEszqbGbApA4EG0sgdO8dJBEpvgl9iU9
         jVIXiurraDdDEsrhYxRfai7KLa3qpyhhDrkq+Lh7jkEqkd5QAPUQz3z/di5EO2BTWEaT
         V8BqgSuvcyftIZ+0NpSJV/GcG1lcqIZtaGPifougJQrzS/pl7W6EFt2n2c+Vn1gqmQ2l
         RvcE7TwLTLYV+5kPy/J2bZMh9fI5UpaaMp6WXNIovni0jVWKWithhVMydEBNQexvrfiP
         XCWQ==
X-Forwarded-Encrypted: i=1; AFNElJ8dGey6pz/pzxvEpbsfgelRFsHQr4f/7Napb2QDC+npvlTVhpuuM5znFIo41ltKyBwluP8RJBcItmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4u2147/NWFmkrqIEEr2VT1TGRuNaKduFzJNPKKNu94lQxpag/
	QzQgVFpYf6c70Wy5u1bu6yqqtOOg4EvaS8AipwOMI6L4SBtrDH7xrGmF
X-Gm-Gg: Acq92OHauQcUHHrEDY5SVkoYwu8ahXt1lEPlbUOmjMYG6DUMJJF0kEe9SGkDeoE1eTv
	PHdG86HwsZQVUulDr/xEnFDkyR3Rbf9rsajDuKltiNLsvUbbwo0VJMFFoKgyq4yeeKnrMjTtVh9
	ihYAgUZ7q5QAF+DUTA51UyOg830zwTYKUQGrinTP4UGCbsoLSAX3dJNg79sUYDstlJJ9diojkPi
	OZMwrFo29tQjdRD5E8VolGLYc4/uPB/kiQVSv+Wp5N4jyt6xuj2AsCs2N6zdTLz/jfFhmpt1QKH
	PWRqaIQ3UrEV8oI1hkGkK0ewtOf2SWO26P53Q4YqGy5ieHrg6CblIC6mKAPvuAYq1zZ/K9qhPnA
	xHZe+DgqtS0dDC7dzgs+TFSJaYF/sflwCyjr01jzFEX3Hv097UHV4NRhDkpuzwcj/owog56fW6o
	nEgXtCL6O3eLiwh5p8s3pdFg==
X-Received: by 2002:ac5:c0c9:0:b0:59c:627b:8425 with SMTP id 71dfb90a1353d-5bb6a20c818mr1891552e0c.10.1781304420670;
        Fri, 12 Jun 2026 15:47:00 -0700 (PDT)
Received: from [192.168.100.6] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb691fd8adsm4244553e0c.13.2026.06.12.15.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 15:47:00 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Subject: [PATCH 0/5] iio: adc: Add TI ADS126X ADC family support
Date: Fri, 12 Jun 2026 17:46:18 -0500
Message-Id: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQyNL3cSUYkMjswrdtCQzQwNzUwPT5MRUJaDqgqLUtMwKsEnRsbW1AEJ
 Wc4ZZAAAA
X-Change-ID: 20251129-ads126x-fb6107505cae
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Kurt Borja <kuurtb@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2823; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=DnQqRk8Wr3CWD8K3b2VzKXlVynzHi8xJBBFO2aUAQTw=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFk6PSEvDK5L/5u+Ol4odc5EIRk1ljh9gcUGlyb32k3+f
 Yex4U53RykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAEzEaykjw7LT5VwlE576GuQa
 3GN7n9l58b9ajESEs8ybKLty16nrgxkZLgkdjwnYy76p89nThz15b4qnC+n/F77VKt38ueiUxBE
 tTgA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Hi all,

This series introduces support for TI ADS1262 and ADS1263 ADCs [1].
These devices are very similar (if not the same), except ADS1263
includes a secondary auxiliary ADC.

The main ADC has quite a few features supported the main driver
(ti-ads1262), including:

  - Power management
  - IIO direct and buffer modes
  - Channel hot-reloading
  - Internal or external oscillator
  - Internal or external voltage reference
  - Filter configuration
  - Sensor bias configuration
  - IDAC configuration
  - Level-shift voltage configuration
  - Manual calibration support
  - GPIO controller capabilities

I plan to add these features to the main driver soon:

  - SPI offload support (38400 SPS turns out to be too high for some
    systems)
  - User triggered, automatic calibration (Datasheet 9.4.9)

Additionally, full support for the (less capable) auxiliary ADC is
introduced by the auxiliary ti-ads1263-adc2 driver included in this
series.

The auxiliary ADC operates almost completely independent of the main
ADC. The only consideration that has to be taken for interoperability is
when reading conversion data in direct mode (Datasheet 9.4.7.1), which
happens only in buffer mode, when multiple channels are enabled.

When reading data in direct mode, all SPI activity is forbidden between
the data-ready signal and the data retrieval. To achieve this a second
mutex called xfer_lock was introduced to block SPI activity on the
device.

This is one of the biggest drivers I've developed, so I hope the code
and the comments are self-explainatory. If not, please let me know so I
can clarify them.

As always, thanks for your reviews and help. Submitting upstream is
always a great learning experience :)

[1] https://www.ti.com/lit/ds/symlink/ads1263.pdf

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Kurt Borja (5):
      dt-bindings: iio: adc: Add TI ADS126x ADC family
      iio: adc: Add ti-ads1262 driver
      iio: adc: ti-ads1262: Add GPIO controller support
      iio: adc: ti-ads1262: Add calibration support
      iio: adc: Add ti-ads1263-adc2 driver

 .../devicetree/bindings/iio/adc/ti,ads1262.yaml    |  308 +++
 .../bindings/iio/adc/ti,ads1263-adc2.yaml          |   49 +
 MAINTAINERS                                        |   10 +
 drivers/iio/adc/Kconfig                            |   26 +
 drivers/iio/adc/Makefile                           |    2 +
 drivers/iio/adc/ti-ads1262.c                       | 2180 ++++++++++++++++++++
 drivers/iio/adc/ti-ads1262.h                       |   39 +
 drivers/iio/adc/ti-ads1263-adc2.c                  |  470 +++++
 8 files changed, 3084 insertions(+)
---
base-commit: ae696dfa47c30016cd429b9db5e70b259b8f509e
change-id: 20251129-ads126x-fb6107505cae

-- 
Thanks, 
 ~ Kurt

