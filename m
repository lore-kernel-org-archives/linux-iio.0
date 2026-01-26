Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914091DDC07
	for <linux-iio@vger.kernel.org>; Mon, 26 Jan 2026 01:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769391000; cv=none; b=n0dhroJsbmyu7epVpc8XO7INopi8MT5KBshMpVav3/ZJk0ClaTbSiH3c8tU9JlxZ5hDWVjed/AbKAr5orN7BnI46Ua+XCxMQCon/SHIzh8W3F77Kfb3chbfrYgjaWVsh9TqmRjUK0e2hcHd8nkFhlYUlNpqx+WXNwe0yIOe1tmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769391000; c=relaxed/simple;
	bh=S8OEpcXpBEONfmjqfR3syMAXK/IV6W+U/9C5wzdJYO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5VxZLt74Ikzxo8j6OK/laB50gVTf4D144uuhV6bwjrDBwBgeTOipGtulFsVRe1ulKn3uqcmjHSmZBncnRZHWeV4Jv4R3tbb2YXHOTLqvsyow/6hT44wXaqpBoPd/O4WMjSle12FKdUga9SC0r+Ts6OwoQShjInRSaT65Y1RbQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErI7aThN; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErI7aThN"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c5513f598c0so1405100a12.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Jan 2026 17:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769390999; x=1769995799; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKre85fWvMpDGBSufwyT7PttY316kDFDWNTXYHvVPt4=;
        b=ErI7aThNgoI2vG+WpnDXeBRby4DpIMoRPVjxUxsYuPmI2GAEMHg1aqA4Es2YK92ClL
         TcwYF7s+vS5dXes5sAVCiQ9gpg0J7NQ2mlgQL25i9wXE7j47GPy2mmR/arucYyBhl0Yp
         Arv7lRR8PYB3QAdPQ1cOATO9zYDoPdCGY4BqiIrUrfJP8v0MlBtoW7hJXEDHwUxDabl+
         QxANgfVF5mkwipYrti/AeMn99xWRillA1+BJRefgJq4wklsmFyvk+tfSJlwHyMNb81eQ
         Vv/DKa0uLdepKJAyCZWZ+ccsfqX4PadE1M4IzADYfP7FH2F8JDrkrO18XI7E1Tm4FGxd
         5q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769390999; x=1769995799;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pKre85fWvMpDGBSufwyT7PttY316kDFDWNTXYHvVPt4=;
        b=lClNCwRLK1YRh+qhYmnyUjErGy1WTsSyjzSwnIkkJAobyK0DvHFqJTzyFQdA0CIdSV
         VPsaD1zNJe8N8jZ1gVEjaJBldP1Y9UC0vlYHeaONjrZAsG2Y4TYj6GQyhiAaGCD7XlmN
         e8/CnqOQZw6ta3RLYCX4mrT1JHcgVSJb917fTE++DrAh6SvHI4lD9anL84nZkH/Sp3YM
         uEWCl7zZxMiH+iRi3od7fzRuQu1/2AtnL0/QSbSkyq0821UM+p03PcnXZk+RHcEv1LI0
         xUtZH0i8BXXr7jHS/62mtsCko6v2HHL0UuuCuiWa+XNC2frFL1uJWgJXR3AV8zZUr5qx
         J+AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXzw3JYpDGQ1HpTT1n1DmaIpPXFMIlzW+bKsU45DlyRN7CHqfNw2zLEXkiYUGaCdpeaQnRinYeF5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9a51KaJfDbroSv8RP9AY+5z9G1z+wrH6iVLRrtNcQ67fcPyX1
	uLcQyHIjOjcumiH0sGBEQAgqkZEMbNvW9ke/r11MCyrZzjZWEVyrX9NM
X-Gm-Gg: AZuq6aKPZ/HDWJGykSva9Pl07uB0YoOIjAal5+4LCoAZR/Tx99T16ZyfjYLzBPecxL8
	VxSHEhHx6GKcf9JV/PSawQFG8Il4KV/S34hKrYtHxsbtoNjrce2Q7kk/+umAG9VYni+dxIXa7wC
	V7qi+TljRofNOOpr040oIn8JaWpEC93duz6G6vbefqEwaY1NM1lrqI3V/FNSjwNhF96hJh0c/jL
	S+fqya3XYHNowlouC1UkNBs2PMDNpwYB/PY0W+6twAaxw2ELVG6xKiR9EXJ1hqehUOOyLAImZxs
	x9M+k8QZECZg6DKL5255z+SNbRrJ1Lg6ybZ0I3swKDW6aaATQNnSRBzeI9eP877P+8ZjWfPhvAC
	o2MCLQyz/IMdsACAE9+COFnGtQ+IKbT3BLWb8340Sm0zinlukJvg5F+JH5hqA1ap4kg1evomUm/
	bRGT15UOrErxCXAMEs4dO/H/Y674R3aAtiqQmn3eJdfRfHC6T1pRE=
X-Received: by 2002:a05:6a21:398f:b0:35e:3cac:858c with SMTP id adf61e73a8af0-38e9f166cb1mr2419176637.33.1769390998758;
        Sun, 25 Jan 2026 17:29:58 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a1309dfsm7010359a12.6.2026.01.25.17.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 17:29:58 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Mon, 26 Jan 2026 09:29:41 +0800
Subject: [PATCH v3 1/2] dt-bindings: adc: ltc2497: add support for ltc2305
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-add_ltc2305_driver-v3-1-951349a87f97@gmail.com>
References: <20260126-add_ltc2305_driver-v3-0-951349a87f97@gmail.com>
In-Reply-To: <20260126-add_ltc2305_driver-v3-0-951349a87f97@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=S8OEpcXpBEONfmjqfR3syMAXK/IV6W+U/9C5wzdJYO0=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpdsOQLuw0cN6rc/rw/ZauqQb9eFcDov8xkV6jZ
 TBh6je1UiOJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaXbDkAAKCRClg0K3CVbE
 gdRAB/425xk+uGr6mgYPZvX4GOzehEQD6w9/7E9SbYEp8sVP5YpSDlk95deXw3cXX5y5EqYcUv0
 W32dkQvj1TSY9iCT1lKkl3EGih5imyLOlJLNuVPARK+9FPmQLOKyeE9zBrUC2Eedjr66o7GOl3Q
 rWPa4gfJd03cYMitIy1a/tUb77u3Vnt0q7F6A2fOuTMOy4paprmhFoF+mdrW41RWDo6eo0AsG13
 HgWUxqpPbuDBA1A7nbXE/m8d2G8qLIEFtEs8u33kmMDKauKi78k0FX9n4xn6wwkydDFC2AGQNyE
 QiVcSYXBXyUYfJis7V0o/zTLxKPz2AkTj+SPZxkMW8x4J+r9
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add documentation for the 2-channel LTC2305 ADC in the
existing ltc2497 binding.
This enables automatic device tree matching for LTC2305
while using the LTC2309 driver (drivers/iio/adc/ltc2309.c),
since both ADCs share the same I2C interface and 12-bit SAR architecture.
The main difference is the number of channels (LTC2305: 2, LTC2309: 8).

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index 5cc6a9684077..c884b6e03767 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -11,6 +11,12 @@ maintainers:
   - Liam Beguin <liambeguin@gmail.com>
 
 description: |
+  LTC2305:
+    low noise, low power, 2-channel, 12-bit successive approximation ADC with an
+    I2C compatible serial interface.
+
+    https://www.analog.com/media/en/technical-documentation/data-sheets/23015fb.pdf
+
   LTC2309:
     low noise, low power, 8-channel, 12-bit successive approximation ADC with an
     I2C compatible serial interface.
@@ -28,6 +34,7 @@ description: |
 properties:
   compatible:
     enum:
+      - lltc,ltc2305
       - lltc,ltc2309
       - lltc,ltc2497
       - lltc,ltc2499

-- 
2.34.1

