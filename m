Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.31.26.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957636;
	b=KGOQ5Ovs87EPR0BTc/iEbrPFXnzgMqfDUirXn8HWDZJWYnCMK1aw3ZJFWZ85Osgr61ZV
	 gvvTzHccyopxxWpwHq1C29rMB4xl3ZKGEyNNWEWJW9JPlrMuNmcxtRBP6HrHcxqjd3gg4
	 2Ho3CGokC8bgjO5suPyxzUGMM/eUVv2MgXT6KP6i5H5R+k3iaHcmijpLJjTjmxN4BmTqK
	 waeX/Z+xCqTqcXPolfRSdd199Cs34KY8jwW0HOOlVOx6/YcH/iAw+Y3MSw1kkSoyse2La
	 LU4bMHXems89u0WLfjl0aUt6K0qkNObUO7Zh3ESV7IozARNt6ebuBIimrW7BsIgLVTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957636;
	h=DMARC-Filter:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=JvdKZIEOWBKasj/2hhPNENnE38dnMCTRye+62CUj/EU=;
	b=Jnm1KmqXTMixfM+/2xLL/8cTHKfGF7xBmpIPWYkshAPa8AGHGsizDYbDJCPsjDzVgPXx
	 bTB9sPqXLsOHOX1dZ3mVTQw+mgFrYmkDrOGK+ad7p9wKHRDcm9tzaqIv4EbzZPcCHuYnV
	 /fSVqssC18Hsw5CGwh1Ipjc/G8lyTPUHU0c8MESlj0cuN+e7e1GNSUsE34zyJNyYAlRwE
	 ib4Io+lbWCpVo96l+qOJNG7BfbOrUVPvjKE7W0Cjx9xH0Zc4sZvIrFOrPCBygthS3Nwi8
	 O7BSHxfSQocZYRzj+iW84aR8BaPG6+/pOnX/8DY10m98bTJj8DSd16dv2tHpRI8lVrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rudorff.com;
	spf=pass smtp.mailfrom=rudorff.com;
	arc=none smtp.remote-ip=193.31.26.27
Received: from rudorff.com (rudorff.com [193.31.26.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DDD606D80C;
	Fri,  6 Nov 2026 09:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8DDD606D80C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rudorff.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rudorff.com
Received: from [127.0.1.1] (dynamic-002-211-221-196.2.211.pool.telefonica.de [2.211.221.196])
	by rudorff.com (Postfix) with ESMTPSA id 02B3B40318;
	Fri,  6 Nov 2026 10:33:45 +0100 (CET)
From: Christoph Rudorff <chris@rudorff.com>
Subject: [PATCH v5 0/3] MSM8916: improve gp2ap002 proximity sensor
Date: Fri, 06 Nov 2026 10:33:25 +0100
Message-Id: <20261106-iio-light-gp2ap002-v5-0-070631a7252c@rudorff.com>
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
X-B4-Tracking: v=1; b=H4sIAOWe7WoC/33PTW7DIBAF4KtErEsEA4bQVe9RdcHPYFO1wQLHa
 hX57sHJIlFjdfmkN9/TnEnFkrCS192ZFJxTTfnYQveyI36wxx5pCi0TYKA444qmlOlX6oeJ9iP
 YkTGgyoWuExa9k460w7FgTD9X9P3jluvJfaKfVmltDKlOufxeV2e+9v4dmDllVHsjBIdoD6F7K
 6eQS4x7n7/JOjHDI6I3EWhIUAdttNJWSvWMiAcE2CYiGuI0MiOVN6jNMyLvCGdyE5ENiZZ7Z20
 Aj3/eWZblAoEkr0GXAQAA
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
 Christoph Rudorff <chris@rudorff.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
Changes in v5:
- Add missing '---' cutter lines
- clean up code semantic
- Link to v4: https://patch.msgid.link/20261104-iio-light-gp2ap002-v4-0-fa1cbaad2ce5@rudorff.com

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
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts    | 52 +++++++++++++
 drivers/iio/light/gp2ap002.c                       | 88 +++++++++++-----------
 3 files changed, 97 insertions(+), 46 deletions(-)
---
base-commit: a2de78ee6ed8bf8cd99d177c74865a6e8c3cb6ea
change-id: 20261016-iio-light-gp2ap002-6bd553aecb4b

Best regards,
--  
Christoph Rudorff <chris@rudorff.com>

