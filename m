Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792451863;
	b=jdSLJxXVionezDYPZX4W/1+Yb4TuLgfri7BHD15vSlrM/dBbQUHISB2+nUw7Mk+9cv55
	 5Q+15JiFtk0omCDc3p4iazCHUQZciWWTaDam66qF6RQvsMz3I2klribjHRSDK6KgPVorL
	 upc8tRZXIPIWGsGUpCeKEOzMLz1fIfuzvuCG2rQBlWFLn3P+3sztqm8TzXi4KBtKzOIt5
	 VKE5OWpCCwrnqqQT16JiNUfvS2vtqiatAqPIU+lM8OhNhvYAG7GaRwGRHG9lzMYCZN8El
	 48Kf6RCc/TJiJEGBI7UVutmfL7SRNMkYYfo8/d051eNFof+Oak0Y7jtj2dQT5+fUYow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451863;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=kGGGLP9z4tXsyl45NRkYOKObEn9kuAr+SkM2Bsz2wm4=;
	b=GfMmXH4jGjNsmKAqfgjFvvZupZO022b6KjPb/ELX9KNwSKowmmuRxCBgGFxr/2HUFLV8
	 GbCFiskopb3XTEn5GyCbfo/PXehQpfadxxNABFv8jzcMqta6rqqFfQLRDus/Ddw3LM3WR
	 fUDuCbmgfd6wNi2AUdihWemdH5jFA7z6WIHzoAa1hBn8dCstUBUqWydsSvtIyqKcFYCZM
	 KW8fh11DGOC6YRLZf9/WRKfP8m2+4ehO1vOcmw+liHySxrOuwe4ZvxMs0Iu/xJt/5uoJd
	 wq1t03CIPCvx88Tc6wO6KIva/dJdgITabDcYnkJ5T5eZZUDr3L+lR3rF3g3jnMZThZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGDcloJO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5211C606A324;
	Mon, 19 Oct 2026 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGDcloJO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792451863;
	b=RI/Dc9nP6RRV48wmxzCAUB4hui3MPKw9EDWrxFysIYrWD3j1TS6K3Ei9FanUl66dN1LG
	 TKVBFi4/rYcpZYNj1uAq2c9114KjvQ/Gq74de/2b0syv4d0yOGfFz9TP5elGEYv4+WVkX
	 rKK7PvrrIJJaaUre037Nz9A3bjSrbjT5Jrt7ODP8wfFxQXwZNbJLpUWtjEOey9xm2tNdy
	 Qi+IHcbC20EUoGOeKrob+50yfcPGvn07i0Ajpv2K98vgN+ww3aqv8bq+CTZsPI26dztbI
	 /mCxDqqQSoh+PpeYvgvkcR2a6LCneJTlddhC+MvKWteUueEUMhFJ+uBv0Ac3Z2jBgzA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792451863;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=kGGGLP9z4tXsyl45NRkYOKObEn9kuAr+SkM2Bsz2wm4=;
	b=hiZ299WyIxjrlGSCZVhyGv0OGkzHaoPYDITCGFzlTXuQWQ2pb6HvtwSm51CfLbeC+wn0
	 DEzKAKxGBxpxsWvyPLy7jdw908Pqd5EDv6ew9EhBxnNcxBAa81HqyfRR6ZKsItnK5benW
	 J3xVDZ7bdQ2sAIPVAqPTE7fU8O0WbMLwHUpiX8+v50n9eaJkvJZrEZ11dF19DFFh8Vebx
	 kPw/Y69nCMVrXua+l/hH8jd/9CnU3V+FnWfblUkbMARIhEqGKqrg5BTzSfFhdU14o78an
	 DQYlqWJpSzJEYJae36ZHXB/DBrAbyngvElqhL2Gh39p4j1BLSZ0PM9llLBU1fYFTsZQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2692A1F000C5;
	Mon, 19 Oct 2026 23:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792451863;
	bh=kGGGLP9z4tXsyl45NRkYOKObEn9kuAr+SkM2Bsz2wm4=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=KGDcloJODJQPD/dHSXADLHsTvU0dNbgRb7Nf0EUoayau9hQUinfdCm9r+K2Zr7pfU
	 gteJ2PpHuhkWmLwoxLvzzPlvdcU77m2BWMg5HpamRJTnrPT/cuxu2Svi4ztoB4YNks
	 4PW7idU0jEC3GSd2xxJfZJWXGHI6ty1knHLL1zA/s76erzXm1TEtBVqm3av5No7FZ2
	 aAT/a4pRYrLwiqQVKJWtGq4T8FgGBwOJiX2MZChzTzuQSNEogPqzDygJmpEpTkTLjB
	 YlrpB21TCm4gds6tXx10wV51pImS2P2WLjhy9E5fdL17P9D4k9bsb5eAjNwpqh0oyG
	 Y/FCDHJfvAVhg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 769224066C;
	Mon, 19 Oct 2026 23:17:40 +0000 (UTC)
From: Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org>
Subject: [PATCH 0/3] iio: proximity: Add Benewake TF-Luna LiDAR driver
Date: Tue, 20 Oct 2026 00:03:40 +0530
Message-Id: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMywrCMBBFf6XM2sEkkPr4FXGRpNN2RKaSSUUo/
 XcTXZ7LOXcDpcykcO02yPRm5UUq2EMHaQ4yEfJQGZxxvTX2gmXE5yoByfVnT8afzOCh2q9MI39
 +T7f7n3WND0ql5c2IQQljDpLmNjEvx0JaWCbY9y+uCS09iQAAAA==
X-Change-ID: 20261019-tf-luna-e2685e0570d5
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vidhu Sarwal <vidhu.linux@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792434836; l=2129;
 i=vidhu.linux@gmail.com; s=20260713; h=from:subject:message-id;
 bh=AqRUiR4PUtUlWpRVFT94V35Qa7422g3L1JI66lW1jU0=;
 b=xUYl31z5VBB+JqcWZAzEqY1h+b++lrUGMv2yptbu+6XiTcn6WTk10oCU6DJ8hj/ABvzH8lDUw
 v1S/yr78vnmA8OQUPtEOmHaGk0cM0KCNGeIC6O7h8Gtp1ibpyoN9xtg
X-Developer-Key: i=vidhu.linux@gmail.com; a=ed25519;
 pk=xDu3Cbesz76CQXwY8lteI74n3ELVIV7wCsuYAvcX1Q4=
X-Endpoint-Received: by B4 Relay for vidhu.linux@gmail.com/20260713 with
 auth_id=869
X-Original-From: Vidhu Sarwal <vidhu.linux@gmail.com>
Reply-To: vidhu.linux@gmail.com

This series adds support for the Benewake TF-Luna, a single point ToF
 LiDAR distance sensor with a range of 0.2 m to 8 m. The
sensor uses either UART or I2C, selected by a strap pin at power-up.
This series covers the I2C interface only.

Patch 1 adds the vendor prefix, patch 2 adds the binding and patch 3 adds the
driver, which reports distance using an IIO_DISTANCE channel.

The driver keeps the sensor in trigger mode and starts a measurement
per read. The manual warns that reads in continuous mode can race with
the sensor updating its result registers unless they are synchronised
to the data ready output, which the driver does not use yet.

Two issues I faced with the hardware that the manual does not mention:
- The sensor silently drops a register write that arrives right after
  another one, so probe reads the mode back after setting it.
- The boot time is not documented. I was able to measure 350ms after a
  reboot before the registers read back correctly, so probe waits
  500 ms after enabling the supply, keeping some buffer.

Later on I plan to add buffered caputure using data ready interrupt and 
runtime PM in a follow up series. 

This was tested on hardware using Raspberry Pi 4 and with firmware v3.6.0
built out of tree on the 6.18 RPi kernel both via new_device as well as a 
DT Overlay.

---
Vidhu Sarwal (3):
      dt-bindings: vendor-prefixes: Add Benewake
      dt-bindings: iio: proximity: Add Benewake TF-Luna
      iio: proximity: Add Benewake TF-Luna LiDAR driver

 .../bindings/iio/proximity/benewake,tf-luna.yaml   |  58 +++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   7 +
 drivers/iio/proximity/Kconfig                      |  11 +
 drivers/iio/proximity/Makefile                     |   1 +
 drivers/iio/proximity/tf-luna.c                    | 254 +++++++++++++++++++++
 6 files changed, 333 insertions(+)
---
base-commit: 43ffda3c7f8456bbe641ae8249a077a361b97880
change-id: 20261019-tf-luna-e2685e0570d5

Best regards,
--  
Vidhu Sarwal <vidhu.linux@gmail.com>


