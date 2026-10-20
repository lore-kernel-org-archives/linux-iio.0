Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792496163;
	b=oZ3GmIdwcnquspSqFGFhXobO1w8Tpr22jE9KBcGNg/GMAlhIhuBWOOMXtnj3Dstqy0wN
	 rCGDL2EQ/4rOZK2m4TeaaofYpv6euZxz/TlPjpIL147vKC/SJjp1Uw/7Z7PzWdI8z3RHg
	 cNcwK/fGxxyRYmSRSlzdsgIbfUr2AkhHPudxkKGerVT3iLCan3inlTg2Ho+Av56WzXac9
	 9J8U8+QAP9MwCl4puik3E8tuihqvIDGSKz6AuhnzwIdkNe4xpddsDxAUcHNG/M/XGy1WM
	 2PwY63MBo1YJ+MFixF9h7sSy9P2idNG93kXBL3pIfjm5l3V+cHeZWEq/ytHbeKh1Fxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792496163;
	h=DMARC-Filter:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=Rzd3KXkKs8OARCZDjNbZVOo6RskRwPB+dmfqIWgTCGk=;
	b=NhRQeTrz0H5HOhFlwlKKQhm14MoAgzuRTMyJWN5woKXkv7v9wh4V956j65PbkRsw3Rzf
	 ApKU1I7b/dttKHP0nK4qs9tV7+jvsDWlOdFNhVwUlXk+rbmpWBoEwkGRNRtv9z3nDefcS
	 Ar4nwmbzGWN8MQsscXqtl6PnaDbPL5hhdsEwtj1KHC/+TCIvDGWLK9VvPx7cSCm1EOoO3
	 MvfHG6xInGZjkKICGc3uny0GRs9uXPvPKmFjeyY6dmCo1LtM1nAu/x528+it9VQdlCMwB
	 nf1ZR9HAykQ/33WqPKpjGyQgzZZvmG7H4PLTsBAgNVOEJdm9glUsytDrIkTprhJmzIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E9A606A31B;
	Tue, 20 Oct 2026 11:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E9A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 1F73C4035A;
	Tue, 20 Oct 2026 13:35:52 +0200 (CEST)
From: Christoph Rudorff <chris@rudorff.com>
Subject: [PATCH v3 0/3] MSM8916: improve gp2ap002 proximity sensor v3
Date: Tue, 20 Oct 2026 13:35:37 +0200
Message-Id: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com>
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
X-B4-Tracking: v=1; b=H4sIAAlS12oC/32Nyw6CMBQFf8V0bU0f0IIr/8O46Au4RilpodEQ/
 t2CG02My0nOmZlRdAFcRMfdjIJLEMH3Gfh+h0yn+tZhsJkRI0xQQgUG8PgGbTfidmBqIIRhoW1
 ZcuWMLjTKxyG4Bh6b9Hx5c5z01ZlxNa2LDuLow3OrJrru/gYSxQRLU3NOWaMqW57CZH1omoPxd
 7QmEvuUyJ8SliVWVLKWQqqiEN+SZVle9mKM5Q0BAAA=
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

Now it works. Tested on samsung-j5:

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
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    | 52 ++++++++++++++
 drivers/iio/light/gp2ap002.c                       | 84 ++++++++++------------
 3 files changed, 93 insertions(+), 46 deletions(-)
---
base-commit: a2de78ee6ed8bf8cd99d177c74865a6e8c3cb6ea
change-id: 20261016-iio-light-gp2ap002-6bd553aecb4b

Best regards,
--  
Christoph Rudorff <chris@rudorff.com>

