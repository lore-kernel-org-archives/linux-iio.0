Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE1B3F3280
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225566; cv=none; b=YbhC3Zkzc6iOxUJDp4dYU68L9z61Vj6glrxhMMnYkOdlZ6+ZGdwzIh1tvqH4G8NnKJpmnDID4zRWefYCpdq9epe3ExP5XK88/7UXhDSUyjDCmyfTnzkNpyjL3cFVPWphIz3doctZ6ajq3nU0h+cWqxGzB8SWHSpNe2Cptn7Mr0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225566; c=relaxed/simple;
	bh=UgBTQH7GpSUIQwncRoW5RM++cyy215AnSvysVsOpvRM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LkN3Q6cyj65SuoxgU0jWjptO8irlehsEVPbbhjrgaYx8qKY8DyQmZQ6Qx407kAziy6Sc6RDHOY5tWm2/ehHE6mg3FsBtK2aatF5GL59f1JMkYxlaScoa64Nm11Qwn3MqmcXovKWD/GZaPvekK8anlka+jCdHpScDw7y61k4RoME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2CftCgJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2CftCgJ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf50c6f235so43134995ad.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785225565; x=1785830365; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R88QuZxfpdQjWFdL/UX0MN9xrstZMv3cCY685maQmlI=;
        b=n2CftCgJghHnbiS9ImBk349RihNy2e6I1pX1Cd31eT3BMCGkPNNHdng4oIfed229rP
         GwUEfdeDmqOifW4LSVTT/gx8DHX1NXvTZ8Udte3htPJznSUT6WBS+R88anEYAFSKE0IT
         wlqOV867ZAuKG6hpdjsM21XCF57xUs+KLen6Td17B0k9hz9FEFTStR1zkqO1KXTRoTq+
         RY6oSWTXGGjgTXsJrlKAxvxbkIX4KbWIPiwR7rqzjmmVNNVIZPHEdD6I6Zt6/X3ZrmiA
         /XgpPxubcBSyzkwBQAxu4fASLImx+8NW+/c4iWZvLjY1/fsT44tchxjyWFy3ZQVBa27+
         wtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785225565; x=1785830365;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R88QuZxfpdQjWFdL/UX0MN9xrstZMv3cCY685maQmlI=;
        b=ZcKJvh4e/ErGDcC2quSf3xIyu/DLBLwcND06rJvbc4OLXNRRcZ1rcvHyICYHzlr9Wo
         GIx7WebEgV7wCBZyI0Q8Silz/6zff3ydcUvAcmQXasEuJbYHbVsvRxlTJuq7S/JdH10C
         kU6rh0bk8rWdETOW92TxaxxYzZ9W8jWCWzEp0usCEAoKamdO6SCCa6m8bluBbc/Muh3P
         2iLVb60KZFzG2sNMm5KYcxkTRjhuP7VKQOCCZ788rl2aGngLDBeOggP/kZI2R9wQyZ91
         BOV8vuK19jisZILRx7bNf1IAan0KqC+wxFGRvoaYFFi+xZB+k9gtUirz1r1QfN2+NbiC
         uS6Q==
X-Gm-Message-State: AOJu0YxRXh1geh1kMEg3WCY6LVq9ftoXrXUtCAHiNvTmURD0TExTHWVk
	pWe58v697irOUMW+9CntaTvDGW1EBc1a80xQGyCV/OfOhdbLrUQZIhHd
X-Gm-Gg: AR+sD13cVCnCQxLcp2PAribaj6TiI+ljuB542DQduS4C73aWL91T0+OjWGjCTuMPCFS
	JL7lvoOdqia3CE4s7zEgeYSUbEoz6e9liE8JROfbxDCV/F6NQzCMVAcYq0SvQRsFoFcU6+pKxi7
	MxR/Y1t74X8hSy0785lS/G4EzfskXOWEv4dcIHws3RlidJqEoB5VbnPoCpvaRG5DJ1j8rJN1I4q
	SUEv74BT+lTqcxPD2oaKe6Omb2f9eZprNucwrXNdJiahB2D80QeocJIEAezkM993za6VJVp933h
	BHWxUOLyd2h9uzgwThbFeZ1bBA3o0LDYnQNpVvT8MggrZ+p2sYsiGnOjpq+NOLxA5pSINso++e7
	PqGZBhtZPXE83JYcmwOXlWob7CYQdRPtnC0O0uKMXoLVY1qSXTlhmDjctkGsvj0ZlS/51e23NMf
	UN0yiEHcLmZ/Td1G2XGj048FwL9U/DPhmgy+Vq01WDyg==
X-Received: by 2002:a17:902:f78d:b0:2c9:97a7:3289 with SMTP id d9443c01a7336-2d015dbc958mr14645265ad.43.1785225564742;
        Tue, 28 Jul 2026 00:59:24 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81d81csm47543915ad.80.2026.07.28.00.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 00:59:23 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH 0/2] iio: adc: Add support for Texas Instruments ADS112C04
Date: Tue, 28 Jul 2026 16:01:16 +0800
Message-Id: <20260728-ti-ads112c04-driver-v1-0-475efe4e2b78@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMxhaGoC/x3MQQqAIBBA0avErBtQk7SuEi0qp5pNxRgSSHdPW
 r7F/xkiCVOEvsoglDjyeRTouoJln46NkEMxGGVa5YzFm3EKUWuzKItBOJHgTI58p6zzjYVSXkI
 rP/91GN/3A20C4wZlAAAA
X-Change-ID: 20260724-ti-ads112c04-driver-be7e89047834
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=UgBTQH7GpSUIQwncRoW5RM++cyy215AnSvysVsOpvRM=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqaGHQ/1AGTtbpoWMNgqPkPT861vDNSceKl087U
 xvshrMRU12JATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCamhh0AAKCRClg0K3CVbE
 ge71CACEmsQM2PPE08Q2PwZ52TMhOq3OpFqngbpYTwBiqxW/i9gSFmtQ6mr95sDc8dYUR4785o5
 A4Q90+1GM15wRM38T66yjGFuk4kOt4im5cCtibMYBhVrW927cPyHn1k+mr1T7io2XLOXGXsZsUF
 GKQnYSw0lLNElLyOJKtcO9fafmbhZWI0f2S+4++iD27e1tkXVgnpwYXmSRHL2LedftcCf0GSTxa
 KwvJAfkjDnuPcrTJx5HAWi3GM//GKChrtoI4dDYaCGHe2NunR01YDNxTD+beOUIhRLAX+wGHm5l
 D2p/WJzAMtV05T5KnX9nUAsw8u6CspxDNd6nNPagvXjEbG6B
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

This patch series introduces support for the Texas Instruments ADS112C04
Analog-to-Digital Converters.

The ADS112C04 (16-bit) is precision, low-power, delta-sigma ADCs with
an I2C interface. They feature a flexible input multiplexer supporting
single-ended and differential measurements, a programmable gain amplifier,
and an internal voltage reference.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Kyle Hsieh (2):
      dt-bindings: iio: adc: ti,ads112c04: Add binding for ADS112C04
      iio: adc: ti-ads112c04: Add support for TI ADS112C04

 .../devicetree/bindings/iio/adc/ti,ads112c04.yaml  |  76 +++++
 drivers/iio/adc/Kconfig                            |  10 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/ti-ads112c04.c                     | 317 +++++++++++++++++++++
 4 files changed, 404 insertions(+)
---
base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
change-id: 20260724-ti-ads112c04-driver-be7e89047834

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>

