Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797061;
	b=qifhx0gnZHWTr7xrJdfGmC+zEGmFvr7iU4SrIJj3aCDjiM2RvRCm+kmNuoAMwIOk3u7J
	 vrKH7TYoz/OEMJoLHTxi7t2FwLsFcgNKkyvTdkva7g3JWC7rFOeNTzbY3RYMhN3ulZkoL
	 RH8/8WJwqnNr/SyU8UctgYIe3ldtRE1jDz/SH8PNaBsmubbQNmQ7OX/A7afTyzddI+K7O
	 w6yoa4FJy/+JQF+LSz53SLNGlJtHRkCmY6VoS1kX3EPl//9mAzVudeFTlT8B0L9XZpSNH
	 YP0ZM6oEqzzamTJjuS3I0KgZLPgvUcHjak1jovOPFm7a2FgL0OA4xk3/+z4APhsdqGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797061;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=ddmpdWi3QuBVMOiKneLveFAK1/e4+M4jtJ3iT9zThU4=;
	b=ka6x3aNqWARTfVo5smDMhYURv1hy8MaTl/kDzq9Zpl+69wlvDGFXHQWgv5FB5zjLGWms
	 RFbPIpVBBCT+NjKpi2cqc9dOfMxYAf5QcNd0BH9RFXoQ8B2XLROM7prTmXc3FL/WNPa0l
	 JksB52jwvjNrriwtHxlzZnQChoUbxep5AyDAQ2HgftievUvqfOVl0eKwDJ5Zir2g34JTI
	 UGCLTVakXSCVFZZTEXmSHQ6BqUipbrZx0qT3TM6oVuTnrNwYSY09C31ybn2Pq580Yy3yd
	 zhsC14ZSiGh/BOaDIGjgQpce680fkje0eBLLsgEK6YcF7AczQ413K0yP/Ijlu11FHIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Qt+kgrYy;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975AA606A32C;
	Wed,  4 Nov 2026 12:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 975AA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Qt+kgrYy
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B5999C8F46F;
	Wed,  4 Nov 2026 12:58:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ACBD760770;
	Wed,  4 Nov 2026 12:57:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D4C82103291D1;
	Wed,  4 Nov 2026 13:57:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793797055; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=ddmpdWi3QuBVMOiKneLveFAK1/e4+M4jtJ3iT9zThU4=;
	b=Qt+kgrYyM855vtsvc4bHisl78unXFWqv/+HI9+4yY4aBMDiGLFw4giYJI08F+FnbDeJpaR
	eTuGH434TIgDTPZj+zLAfMPhB5kP5wFInbX+xLypXItC64vqdZAceRKJugqCgOxgLU2Gk3
	GIgPdRr7b+zfGi1xCRxvd8nZH3Kxxwhl5OLdX3sS5B9SiLHWkBT+2UN20rdDT9MI+X3gjz
	KAvQT5EUiMrR6vbe88/6CgfbUqJEVeLVyqZ40yeAI2tTYkGWBTfQspQsT/cRHf5g0pB3eY
	XZMd7yQHXz0UUAqXyP9mERWGw93Zxc3PrWrviBJiXrpBJmB7o2f+O9nuK32C1Q==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	duje@dujemihanovic.xyz,
	herve.codina@bootlin.com,
	thomas.petazzoni@bootlin.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: adc: add driver for Texas Instruments TLA2528 adc
Date: Wed,  4 Nov 2026 13:57:23 +0100
Message-ID: <20261104125726.1754980-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.0
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
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

This is V3 for the TLA2528 ADC driver.

It takes all reviews from Jonathan, Matti, Rodolfo and Victor into
account, thanks again everyone for that :)

Matti, I've not put your review tag as I've reworked things quite a bit,
sorry about that.

Maxime

V3:
  - Require channels to be described
  - Use guard()
  - Add Datasheet link
  - Drop the unused registers
  - Use named initializers in the id table
  - Collect Conor's Ack

V2: https://lore.kernel.org/r/20261030164705.297354-1-maxime.chevallier@bootlin.com
  - Describe AVDD and DVDD in the bindings instead of vref.
  - Add gpio-controller
  - Allow describing individual ADC channels
  - Switch to regmap with caching
  - Reset the chip at probe time
  - Small cleanups following all the reviews
  - Moved MAINTAINERS to patch 1

V1: https://lore.kernel.org/linux-iio/20251223155534.220504-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (2):
  dt-bindings: iio: adc: add Texas Instruments TLA2528
  iio: adc: add driver for Texas Instruments TLA2528 adc

 .../bindings/iio/adc/ti,tla2528.yaml          |  91 ++++++++
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  12 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/ti-tla2528.c                  | 215 ++++++++++++++++++
 5 files changed, 326 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,tla2528.yaml
 create mode 100644 drivers/iio/adc/ti-tla2528.c

-- 
2.56.0

