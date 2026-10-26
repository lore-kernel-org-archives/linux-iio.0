Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793003870;
	b=TmMF8upQnjFi8b04zT5pCvz0b1OWygGpqm0ea1Gi0yzDGkRtZzcT+/kgMuQjLMg79dbi
	 o4dWKd+oWwFUalYizLVWkX40Ciruxhs2Q1Am1Tkw0i2Z1DghMfQtr+LxYYCcX1ZF+KpZO
	 kpNFs2abU9foBVTWNYrcD8OYnhTDRdckarRDDWKvArp+bh8FO7awjaymSld+UoVQM/ccx
	 xT5/SJpf11d5AOjg5q0AMCUiNlOfyyZ17Se2ouDyDhgJUdQs6jPbSlyZtteeuAhQlL5/G
	 NZrbZF2Sh+LzNmwh9gw6sHzm0MaCzWka3+7vGnBANI6/59R5qJsxUgI8qLdTBvL1gjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793003870;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oXR60LDsYky2VqOqQue7mRL+b3w0NTwVzf5xVpsjh8Q=;
	b=wOqg1DuAtTS0zrUrXaMIhihYNBITL0umMzYii6K9gWZWJhvSyQzd7AbLyggbrZ6vY6ss
	 1UmMcB0557ZPkNy12FfoRS5dCcF17lELi/Wp2YY8jZ5dXshTq/2t5usD7Coh4uuWQ7js4
	 8/qq+6qZ+MWaynVtXGOc9ra0p2FNLnPaSerGyQ94gHFUglMGCGCWKYwEwSVdjuAiDjEbu
	 mD2aaNDgZ3AAnreemiVhwg0IMB1rw3Yq6UxuUCIMnnqW4fmW7InHInltsQUdc4vVyp8eq
	 Nc+iSc7aq8vepW7isRAKgR8i2I6sMqIuuy+TURKr03Nv3rZaP8QgvB6/KXHu+Nma+rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=qBsIi2dB;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6045A606A31A
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 08:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6045A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=qBsIi2dB
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso20521695e9.1
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1793003868; x=1793608668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oXR60LDsYky2VqOqQue7mRL+b3w0NTwVzf5xVpsjh8Q=;
        b=qBsIi2dBdH7dA6rq5ePwsw1KhbbX7/GTANSCFjSkBKYprl0XlzFBnQ813b4EXpOedd
         jHjGq2ZKDpPxVtnmckN1HCLMAVW0lbzGAjU6C74A2CGBHcA0wlKckkUo+FuA3jQ5uQh7
         d0pf8I2mcBWArLgDtcf4wB66d6IQdntMYP5jEzquTSfY7FS9uh1MlN5nvY25hSczip5F
         pZ53jHutnqOFMpQJ9niydqUe0V8uM63NCXf4pxUqo2TpyYa0dReoj301BixIa+tNg7yC
         5bDIZtFeVIP9RJLhpL8FwqnMGa73Avd6xWvlNy3q5um49If4pY3KTri+EyHkDSZ/qhJg
         VxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793003868; x=1793608668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oXR60LDsYky2VqOqQue7mRL+b3w0NTwVzf5xVpsjh8Q=;
        b=oIj4kbSq0/owGQYXMG0cpZGALAG2O66mAGOuBXEe+hZGUaYW6GCKqjrsELCtcSQV3v
         KDRINTprVw9ynsOZr4vGcih7z8yf9UsR5t9nN3SFxnhJfb9HIF4T91TM+yUv+aYDZa7b
         a2aGIwvS52bJLnXISVH/8NFfiz/oDcvsq6KuLTG0jPQBk24C00IEmqka28zXMFvF+RXi
         s2QGxpG9Ek5A2k3MlAtjcaCecsc7cB2lvHNNMzn1F7Ms/FBj4nRo3F8mHVcnsoCD3PMU
         nDAQCxs85pesilJf27P9UcXgavRDrKcFSvPv7iYz+EAzMhwGT3+e80vSvmje8oyV5RlO
         AjSQ==
X-Forwarded-Encrypted: i=1; AKwUvByTBeGwz3e1pGTvy9bZHaSHxMVVkf7vJ79V1T7Y5ftZAqmqrJhIEpNFGONKxG5jU7L/yzK5l+Yh8c0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjfpO+6XoTslSKf0E7+MXWaObP/W2nWCpTwZBzvB1BSBGB0qGz
	YAKlp3KF3AgB5F+Q/57oIpcZMcT9Hwgnruk/3DW1Ky83NpUdKM0Kr6j53OLEV/cLSy0=
X-Gm-Gg: AYBFou2uqG3qlFjgBH2BDISx6nNPc+VqKZl8wCXkFwWrsfNvDKB+Tdz8do+E7XjiVHX
	K5+XmpN8EAckpOBkackvuLJobAMfa052oBaHEWdrEFPOAWQGIafUa3jYW9wKFqPL3QYPOUurWwB
	5xP7evqx7YmS+mgcBmDgIa7bMIoa7ZQjd+3uF2pCqL4venw2RFYKSpP7/96wvrU0sXGsqpaJW/Y
	7u7bMaggdymiwk1iTlUhOyk0C7OjOcnKmWSjdfFXmkV5QfnZlT94R82CRQ6DZtVsj0Y+dFOskoq
	rYjLnsfF/FaFupV+GCRYGmOs0yR4W5pInFhN8c/tm2N6izFDl35THx6KuZMRL6qYjSC8EqYTJD6
	/EQLdc4wDy+bkLkoACtqHSBvl3QF9y58kA8cUUNE/ADS/UN+xKF4ogaZoOYLzJ5FYbUZuhyOE9U
	cBMvik0np7GOF+qrqva47ctsrVrj+odFHNUxW8onqAIw7fdtDsgfiyI8qQiIdpqdCu34/aT9/Ys
	jnZEog2eZ3ADVDf8P5tftMURgw2Fnhl1vaP+i4bSyOW9SCSx0Cr2+0lHJ9k+VlQJ/bjj+GPbXHQ
	hJ/1h90UBGpyjQ==
X-Received: by 2002:a05:600c:4f10:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4a35acaa4a8mr111672015e9.27.1793003867665;
        Mon, 26 Oct 2026 01:37:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6dfc:5715:ead7:7540])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd8dcfsm15091889f8f.50.2026.10.26.01.37.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 01:37:47 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v3 0/2] iio: adc: Add the Ingenic X1600 ADC
Date: Mon, 26 Oct 2026 09:36:29 +0100
Message-ID: <20261026083631.48406-1-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
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

A driver for the SAR ADC of the Ingenic X1600: four auxiliary channels,
12 bits, one interrupt per channel. Tested on a HiBy R1, whose keys are on
channel 0 behind adc-keys.

By their programming manuals, the X1830 (3 channels, 10 bits) and the
X2000 (5 channels, 10 bits, one more data register) have the same
register layout, two results to a data register. As Jonathan said on v2,
the X1600 name stays, and supporting them now is welcome but not
required: I have neither to test on, so this version is X1600-only, and
a chip_info with the channel count and the resolution can add them
later. Nikolaus, if Letux has either at hand, adding them on top with a
test would be welcome.

Changes since v2:
- Cover letter (Andy, Joshua).
- MAINTAINERS: no list line; the binding's path in patch 1, the driver's
  in patch 2 (Joshua).
- Includes for what the driver uses, copyright line, MODULE_AUTHOR(),
  reverse xmas tree, open-coded return, no message after
  devm_request_irq(), a blank line (Joshua; Andy on the return).
- fsleep(2 * USEC_PER_MSEC) (Andy).
- The ADC clock divider is now even, as the X1600 programming manual
  has it; v2 wrote the divider minus one, as the vendor kernel does. The
  divider fields are named as in the manual, and the two clocks only
  repeated sampling uses stay at their reset values.
- The probe comment on staying powered up no longer names the keys
  (Jonathan).

v2: https://lore.kernel.org/all/20261024041357.34346-1-olivier@mgcrea.io/

Olivier Louvignes (2):
  dt-bindings: iio: adc: Add the Ingenic X1600 ADC
  iio: adc: Add a driver for the Ingenic X1600 ADC

 .../bindings/iio/adc/ingenic,x1600-adc.yaml   |  60 +++++
 MAINTAINERS                                   |   6 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ingenic-x1600-adc.c           | 242 ++++++++++++++++++
 5 files changed, 319 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
 create mode 100644 drivers/iio/adc/ingenic-x1600-adc.c


base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.39.5

