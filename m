Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07EB2D23A4;
	Mon,  8 Jun 2026 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934437; cv=none; b=A3WSsDfztlJHbTUjqhsRRqhLxB2BC4os9/qU2Xn7tWXb8ZD8Iugs5L5fXWoJenevF6Vzbab2A5kPz4bDmKD3g6JIyU/IFBE9zhaveoymzT71exyO3IdQEtI49XB+yEFw7VFqdbyiHTZloSlOssvD/2zaZFWoKSdhoSsU2BBfTi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934437; c=relaxed/simple;
	bh=pGU8EB5ADjrlLOQFLQI9C7usqPVt4L1wtHKJmfejY2o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O7iMPj17VkmTaczq4xw/iikQECHHShGOAfZBRSRl6PXhh76K4/HcW3yFjpcmUKAL0C3UOvoLVH3L3Ka7QNi1pm/LX9QJiovOP0lr557xvSui6wa/TKdxeSBunLV6WAYl9BwkzHFhsc6AL2RyrH0E6EX5rRpqInKiLUFn+OKlov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rtXrL/9z; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rtXrL/9z"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 82A44C5147B;
	Mon,  8 Jun 2026 16:00:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D88D5FFB7;
	Mon,  8 Jun 2026 16:00:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 969A0106A19A4;
	Mon,  8 Jun 2026 18:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780934432; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ZHuO2xQq4j7QDhpW+P+JxUWJLGa7dIksU1T5inWVaGg=;
	b=rtXrL/9zy08Nzpn7ONIzwhDZTcc2wj9uL4cmNhpqlk1yw0yXWny0UvkzAkBWqg5i3X+zJI
	ELx1arnxnQ8mEukXwzw8J+s6jRiwAppN3o8ZYgkRSyvztYc9iDLRP1bzKUeHMAgdbqWWNX
	rqxZT7tBGyCMGV1Lnj1iC6HajUdY73udy5eske5/qg0LMxlUg2QRkQTuGN8uQ0SzqcSU9y
	n3N4MnvQGvp437JNe2WdZDkGpTVKBWMrj1N47CiOQt/4JQKCW7l9l01f9aecsPkqzot9Pk
	tKj37ORGzAk8IvDbcf9kh3/2yS2rKz2+pzxDdCdONeKa8h0W5h2ObyCkojQ7Kg==
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH v2 0/2] iio: temperature: tmp117: Support the TMP119 sensor
Date: Mon, 08 Jun 2026 18:00:23 +0200
Message-Id: <20260608-tmp119-v2-0-30c3537d5097@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBBFr0JmbU2nlBJccQ/DQuggY4SSthIN4
 e4WXLp8yfvvrxDIMwW4ZCt4WjiwmxKoUwbdcJvuJNgmBiWVkUYWIo4zYiWMUVYhaZtjCUmePfX
 8PkLX5sfh1T6oi/t6NwYO0fnP8bTg7v1FFxRS5LrqddFjaVHVrXPxydO5cyM027Z9AbkFQMewA
 AAA
X-Change-ID: 20260605-tmp119-662d21e4d317
To: Puranjay Mohan <puranjay@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Wil Stark <wil_stark@keysight.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Hello everyone,

This is version two of my series which adds support for the TMP119, which has
an identical programming model to the TMP117, but slightly different specs and
electrical characteristics.

Best Regards,

Romain

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
Changes in v2:
- Used ti,tmp117 as a fallback compatible
- Made sure the correct IIO device name was exposed to userspace
- Link to v1: https://patch.msgid.link/20260605-tmp119-v1-0-349f45f17d12@bootlin.com

To: Puranjay Mohan <puranjay@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Romain Gantois (1):
      dt-bindings: iio: ti,tmp117: add binding for the TMP119

Wil Stark (1):
      iio: temperature: tmp117: add TI TMP119 support

 .../devicetree/bindings/iio/temperature/ti,tmp117.yaml   | 16 +++++++++++-----
 drivers/iio/temperature/tmp117.c                         | 10 ++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)
---
base-commit: ddd664bbff63e09e7a7f9acae9c43605d4cf185f
change-id: 20260605-tmp119-662d21e4d317

Best regards,
--  
Romain Gantois <romain.gantois@bootlin.com>

