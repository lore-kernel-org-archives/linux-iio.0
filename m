Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870009;
	b=ynA3zrZv9PbRa9+TTKiYlTWpW4ADb96B7A64trvZAVme/q28L1zBp/qIHWWEKpCe3We/
	 a9lR4tIRL9jOkZtszBTdKeJMtdUcg552edHuCy8X8HYdE7Xo0a2mQv+3dXg0dg8Favll/
	 sIsOUVlqe5lqyxmHiXzA/pWIwhVHxGhMCPyDTrjDTcOLBMXa77G7tbPZo+07RqW2m0qKL
	 13CW5aqEKLLq7PxJ2BCDzSQpSPeiuQG8bKWgMAtdNmPN9uEeZYWzN8o8US1kx0fpAWGxO
	 OHUIqETop3YWZRwm/+LcR2OFbxvuNwXVBnqHTXOKyKXcJk/hv9Oj7XxwtEoZnsYz43w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870009;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=WUolhYDZbslOOIbkyOEoOPPNwXhWzrlgPsJ43aUqTJk=;
	b=woLuo6QrQek2VM0V7yr7rlRZD8+JKqtWhmRsBac5Jghc/5fkWltcz21h5j87tZZswJOA
	 VwIkl90PEKCKisQYvcnpyJhmVQLcQ2JosuJ0xr05dUDSGhK8mgU8yAZ3MiIgbblOZ02Sp
	 f6ZdtfETAIeWI0Zi1m3fnt9PA2x2T3PD2H7oA53Rj+fuMddhvsiCjtjjDZcWOlq0XNgHj
	 qaoHnB7EAJUZqNqZD5uFLwQDrQ0kiDJecSHgyl1jVoZzuyH+3zY9qTmWJqHdH81sKU5v4
	 0WsKw7hQakWdPVJG+SzF+A6gFpDGUZPWZY9+qBN4lEgh0I2GwT5824hazYcHV5iUb0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00A606A323
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 23:00:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA00A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b4d6981c67so11763707b3.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 15:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870008; x=1795474808;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WUolhYDZbslOOIbkyOEoOPPNwXhWzrlgPsJ43aUqTJk=;
        b=Z1AdrFWcQWOkt/298PeKSmEbpsReUrWuCgZEJMCZY8/yCPQ1Z4XxT+Z/5EAVr1RbbB
         65Ab38j5ujL0ySO0eJSlSwJUxmYVo7hW35sbivbjHdkONuIjJPYaAosfuD5B1mzeG82u
         zkyUcL9hzosU8cfT4/qS9UIh92KWQaq4h56DFEkr9j527Ak6RoAjFUv7DVt9Q/Xzq7ES
         h/SNL0TDGFPrZV0zwSTZqXBRnGU5SgjMvIwbw3bN1MEaanT6fuJ7u/qCQiAa6y82Jf1d
         2MNgZUenRq9ekOfVMC9mtz/kpRwe35a90covSLzVQkv5TtiWp5AuXupIISVPnNEG5ZtA
         QOPA==
X-Gm-Message-State: APuU4Z+5W40s+eLQssNSITZ8KiOaO5tmlrMKKRLudgfrvRw4whErdcgh
	9ClejsIHTrIzsynMpSyysxYNTkOp/GiyJshTpPo6gQvsMGmR+XLFPxV5
X-Gm-Gg: AZFdTZfaYPzwGBSUbrDbVyHPDHSSuEw3/ISBY9MXIt0GSp1XrP3EhP0Vl65nTx+FKeR
	4/q9dcQCZrncqV3bwCRuoxigcA5xdajEBrLCRX9LNc3JEL8RXdzKZEAqppncGg3vNY9YJhss1sV
	NS2o0Gx18dtH5GRWV538JYQdEfHBLgwrMpZolfe+GEAMg4Rcelo2zrNRoijGYcYtJhe25Kqa/vR
	BviSH5hud/ShUDF2sR6seeND/MMQq3gq0FXAeKAgmOdXRlgUjcMdsnYuxvNHy34tYRe+QBXDpx7
	NmYh9bTqQmK4vmFYTSgot4n1xJbNHXvyDLZOQCKLm8NAeCnTFXj0ggwSMOndSVKjlocI0ALaYl6
	PqqYvKHtJcSsc3XUoI68G3UXmlQRE2UP1ViuP5MG1EFGZ46EUlO9Dch0LgcP1uiK6JsIAFoYKB1
	LHxUwlookm40ZMoDmjM/1DX6a0TuSeWrCVv2v4bLxEZtlgJz2yb3g5X7YpFCUYo7U1rbq8abcFo
	sitYZwoapGdyuQ3HsF8QTl4zxs319Sy2PxptXqZ0T4qhCFEUnZU8VJA9w0EV2hxm5myUG1ILhPc
	ZcQdTK6SJKwxFYA21r9fXjwT5KISQEctoFpMozw8KuDyCeoF+D30aC2MprqW2hEsjJPhjl/Uuy7
	7IAILCf4Y1TPc1YXuL3ivyceeOltywrglZBKmIFX6x8H+9LJoyZmQIA==
X-Received: by 2002:a05:690c:e3ed:b0:8b0:89ea:6aca with SMTP id 00721157ae682-8b4aa0d0116mr67609057b3.6.1794870007633;
        Mon, 16 Nov 2026 15:00:07 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ebc50e40sm10721347b3.17.2026.11.16.15.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:00:06 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Subject: [PATCH 0/5] iio: potentiometer: mcp4018: Add Analog Devices AD5246
Date: Mon, 16 Nov 2026 17:59:49 -0500
Message-Id: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQ5AMBBA0avIrDUxVa24iligg7FAWkTSuLti+
 Rb/B/DkmDxUSQBHJ3telwhME+indhlJsI0GmUmNiFowr6K1hVRalFblxqAsjTIQg83RwNc3q5v
 f/uhm6vf3APf9AOCXSituAAAA
X-Change-ID: 20261116-iio-ad5246-8d4377128747
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

The AD5246 is a 128-position I2C rheostat that speaks the MCP4017/18/19
protocol. This series adds it to the mcp4018 driver, so it can be an IIO
channel provider for an in-kernel consumer, here one that sets a fan's
speed through the channel.

Patch 1 moves the out_resistance*_raw_available ABI to the generic file,
patch 2 reports the wiper range, patch 3 adds the binding, patch 4 turns
on the vdd supply, and patch 5 adds the parts.

---
Joseph Telaak (5):
      iio: ABI: Move out_resistance_raw_available to sysfs-bus-iio
      iio: potentiometer: mcp4018: Report the available wiper positions
      dt-bindings: iio: potentiometer: Add Analog Devices AD5246
      iio: potentiometer: mcp4018: Turn on the vdd supply
      iio: potentiometer: mcp4018: Add Analog Devices AD5246

 Documentation/ABI/testing/sysfs-bus-iio            |  9 ++++
 .../testing/sysfs-bus-iio-potentiometer-mcp4531    |  8 ---
 .../bindings/iio/potentiometer/adi,ad5246.yaml     | 54 ++++++++++++++++++++
 MAINTAINERS                                        |  2 +-
 drivers/iio/potentiometer/Kconfig                  |  6 +--
 drivers/iio/potentiometer/mcp4018.c                | 59 +++++++++++++++++++---
 6 files changed, 120 insertions(+), 18 deletions(-)
---
base-commit: 94921bc9eb214f838481faa847cda5c42e486013
change-id: 20261116-iio-ad5246-8d4377128747

Best regards,
--  
Joseph Telaak <joseph@telaak.dev>

