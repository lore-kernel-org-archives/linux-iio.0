Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797361;
	b=ennSnDuVmPQLWOcq+lDS1XOXkrnnJKYANc0JklqqoWWzzrIBG0YHI2dc/+uj6PjAolPE
	 TGryDPOY/VD0b3Iiw4V0qXxyZVNE/CMKcsH9yyJtR2DygUSNK64a03lFZSeuvi8I8bxyl
	 ND4sUDllGNJS5RpvdlDoSrxNnIdKLwQ8pPDVdMMmUOnNojKDOWQ+EbDZ/EZOHkDE0YBPC
	 IcQfEx+r/EjTGGIsgEssX84qO0nz+LQJ0rWYWySIPcO32Fi4QXr1TqnfseyqkojQIIxee
	 UfHpKMMGwQRDHNWQMaqv0bUwM+gEp7e2GXaIZRFvstCSYGhwn19zRjV5DhvNmRypUzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797361;
	h=DMARC-Filter:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=ryK6A3KvYO4YaJ/RAZroWoOyiQyTzv7niD20z4N8Www=;
	b=REnCjRcHryceNo5Lact2dpqf3OoTE3HYr2l8BHDmI3eBhuWezkUEw40VIEmHDFopXn+i
	 I4s9wfY3INyymUAo5kCYn8MjEWIvfNo+1F7DdxaHEyQjbGKvu152UCMjsUOgpOv/MHMhq
	 MROcMI5M6q/L914xLKQZJPdO1ZYEtLxqFhxz1+QSF/SnK+HR+OpTnGgl6FJBWWN+szCBl
	 j8NLJmQev3KC43s3mEcRwk8bsWlhiIaoTp24rnHhxEMne/gC7YPsNiBNzAA+Mg2sFmBv4
	 Y4RtHy8/IukjjklLPZyGdnxDS9diJemX7pqDgvWd7/75VZAgUcgOfUUwFrDyQJ+CyOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3D606EEA4;
	Wed,  4 Nov 2026 13:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34A3D606EEA4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id DCC4C4081B;
	Wed,  4 Nov 2026 14:02:37 +0100 (CET)
From: Christoph Rudorff <chris@rudorff.com>
Subject: [PATCH v4 0/3] MSM8916: improve gp2ap002 proximity sensor
Date: Wed, 04 Nov 2026 14:02:26 +0100
Message-Id: <20261104-iio-light-gp2ap002-v4-0-fa1cbaad2ce5@rudorff.com>
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
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOIs62oC/33Ny27CMBQE0F9BXmPkV2zMiv+ouvDjJrlVwZEdo
 lZR/h0nbEBFXY40c2YmBTJCIafdTDJMWDBda1D7HQm9u3ZAMdZMBBOaM64pYqLf2PUj7QbhBsY
 E1T42jXQQvPKkDocMLf5s6MfnI5eb/4IwrtLa6LGMKf9urxNfe/8eTJwyaoKVkovWHWNzzreYc
 tseQrqQ9WISz4h5i4iKRH001mjjlNJ/EfmECPYWkRXxBphVOlgw9hVZluUO8dR45lIBAAA=
X-Change-ID: 20261016-iio-light-gp2ap002-6bd553aecb4b
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Christoph Rudorff <chris@rudorff.com>
X-Mailer: b4 0.16.0

Samsung J5 is equipped with GP2AP002 proximity sensor.
Unfortunally the driver wasn't working, no irq received.

According to datasheet page 8 "Recommended external circuit",
it got tree pins to supply: vio, vdd and vled->leda.

It missed to power up the LED.

I found this looking in downstream kernel, where
several #ifdefs handled the case of 2 or 3 supplies.

Now it works. Tested on samsung-j5 (msm8916):

$ cd /sys/bus/iio/devices/iio\:device1
$ echo 1 > events/in_proximity_thresh_either_en

$ iio_event_monitor /dev/iio\:device1

Event: time: 1791460068846871297, type: proximity, channel: 0,
evtype: thresh, direction: rising

Event: time: 1791460068876669724, type: proximity, channel: 0,
evtype: thresh, direction: falling

Signed-off-by: Christoph Rudorff <chris@rudorff.com>
Assisted-by: gpio-hammer
---
Changes in v4:
- reword commit messages
- gp2ap002: Applied Andy Shevchenko suggestions, namespace etc...
- Link to v3: https://patch.msgid.link/20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com

Changes in v3:
- rename vled leda
- j5 dt: moved declarations from j5-common
- Link to v2: https://patch.msgid.link/20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com

Changes in v2:
- reorganized patch serie
- gp2ap002: use regulator bulk framework
- Link to v1: https://patch.msgid.link/20261016-iio-light-gp2ap002-v1-0-7c93312fa8d5@rudorff.com

To: Linus Walleij <linusw@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

---
Christoph Rudorff (3):
      dt-bindings: iio: light: gp2ap002: add leda power supply
      iio: light: gp2ap002: add led power supply
      arm64: dts: qcom: msm8916-samsung-j5: Add proximity sensor

 .../bindings/iio/light/sharp,gp2ap002.yaml         |  3 +
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    | 52 ++++++++++++
 drivers/iio/light/gp2ap002.c                       | 92 ++++++++++------------
 3 files changed, 98 insertions(+), 49 deletions(-)
---
base-commit: a2de78ee6ed8bf8cd99d177c74865a6e8c3cb6ea
change-id: 20261016-iio-light-gp2ap002-6bd553aecb4b

Best regards,
--  
Christoph Rudorff <chris@rudorff.com>

