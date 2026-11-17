Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936818;
	b=bwJt//cSt1bGjitEj5O4/wTXYkBZv23QQau/70tkbvmVGfHDRfuTMeQ3eaWuQyVrhI8I
	 gnpnOJ/1cCrdy1oznx1PdP6fj670IyzisbjOI38722r9ou9c1S/lqMBL0WQSBJRmNd4Tv
	 j8Sl4CpW9XdHEo9xNcS1UQ4J0bRb9d9Q1FUIWUQeqM62SemHhnBm32rayFlP9IEMjzoi/
	 Hqt0+AZDLxSvautKHre0f2Djia+O0D4ePz6BDVaixFY9EkXLg4X4K1zCG3xrWEZ8f3gjQ
	 oZCo096l2SRMWHwKfIYo3aAbTApUvBx4QD5yaiVzIZ9vhYMEdVg4iGu3Nx0OUChPcnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BrMcWd7pvu75CincI1DxjIJtK+iHHZhWACFR9OMESAw=;
	b=KQpKEA2FTTL1rmz1rt0ZyKQR90qk7/em9VTijAiAL07UeSYuH3x9ZB1ukz7iN3m2fIOy
	 NhL1f2/Cl5tBL93mJVZrVZd4w+6jhAxnFeFtcmlWoVupTfMB1ztmJwIT/rADw17KwJNg2
	 GTHTs81B1oRCyxPagQtjWu0/WtUd3dJcsyRLR/OH0P3cAmJvM43wDFS1Eyru9OP/S24SA
	 TgEEmCHawo8UsKp2AgrTHk0vS0nl3isPLTyVCDy+AbYO+/k4wQyCJ/OXhqRJf4GKpFJsR
	 4Ssqa3uyLSttKrGLQI3UdnKAn6Y7ior+tGgfufa44z+my6Rsg5UNVfSR1Bwmyz1XCiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qq9cWzZj;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA99606A32A
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 17:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EA99606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qq9cWzZj
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso7713f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 09:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936815; x=1795541615; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrMcWd7pvu75CincI1DxjIJtK+iHHZhWACFR9OMESAw=;
        b=Qq9cWzZjrgVRuhct9Bs3XWPLq2gc4ngF99znVrHxGFg29CgIdyg5bdv1KU+5GCR47Z
         W/1CNTm0RFuyhIpOtfdFSDIYysMReXu9u5BkGqEZl1RqmCPbOIpv5apywR/27GszE4xG
         sl08M+PNPYGAaFy52pn8LZWsyjKd17q0jvIWtgJXTmK7bvHJfJz86Ijb2NIXSk61GxXR
         zBKdUn0p+UXoSd7HduOaTpXCQJXHXjJJ6Nw66bDPKeK3vhAgokzBUMH1YIrff1SLlMp7
         NQ5jTq/wn1Mn4jvL+AluffZnEGf9Wm+FP/G/j+Inm9WVYi4S4dABC0428Tgjx2HmggXu
         m7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936815; x=1795541615;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrMcWd7pvu75CincI1DxjIJtK+iHHZhWACFR9OMESAw=;
        b=wzoYRs46x7rUMqoUAnTbbiaiPoK+/bIN4K3EJwJQlqJr3mOVmwCSzVYTAS2PPHNKgB
         /JoyEz6UkgRS9KarGtMQ28Wo+emLIVq0hhOLu2LqDGhgV7PS9V2JmHfz+gaoTaacSRrr
         o28cElcRV7FUgoqr8LVSyiuvs2K1Ny28JsYdIhVtXIu7st9HKLocPzGtj7W6grI/qnEL
         BWU6g5n1gFeEJsBVtDE1/DNdXfJQptaIev044SjIA/JWKcgpFKj1rLR1DlzN9yXsfZPw
         x/X2Onkej3oziALoIUaGwZutO8d4I61bPqXeZsJ3WCBFhApp/X9ySt/lwp5b44SIX5WP
         8tSA==
X-Forwarded-Encrypted: i=1; AL+hErH2aIvTzgs2Ric/JbLY7saVIGJXpHnvH9I8pio8OkkMlfxr+Pz6YhIT03wTEsNbsUv7T/6hRnmQmFc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EjxADaUNUOhCcYk2NI7jvQfI2lf/FThFnxpNvZTdkGebxf5NH
	2C2/lvOp/wB1y1fCfL4SzJI2Dv4kSTqx8mVYTf78UzjbzP1jzn9KKzWw
X-Gm-Gg: AZFdTZebO+tlEEHjUnWKXgfligTLWYKI788k+OTCSR3bG5LAjL90SNPznyTQETkBMRe
	nY0/zI/w62K0cgO5G6FgJYQKSxzXWnSlEQaha91SCIJCFPXLNPGCLF9bWq2deYtO2ffw80uAENG
	2Mo1Z0iXr0HivarvnQ4oYEp9lg56i0imTV7Ht3qNsmKUirWE/tk4e38AR2pPjaobzAHNctm3gtt
	1nIKj7mtZUR2DQlJ7ZRdWqiKbVQ17azpREAPwLmUtufbYpXntlcjtvJr9lt3PddMTU2gTc/BNPN
	BfA7eFtrnmmDwYPqQUJbrfSPNPfMVxcJEwWNY613TJuPiJp+3dOxgR8+wMClb+q6ZgqoWIa/vIe
	NemOrk4LsytfSPv69pRjrTtEF7BLPkjBbO5aZlAJGq3TFtxj7C2MCKCuaXmHqKkiiHox3J0dqPW
	Fbi6g8C9uw+YskHheypYSAX1ZhwBXRDxU+DrrVU7bZVgvYY7Bg35ourBdhCCkPTrbpiNnHlJf/w
	I0Gt9JjvWkBB3+3pdD3oLWNgaYwUPl9uWirxuRr8iJCwl74OTeka7Y7Fj1KQKdGLnT4bBM4XkLU
	cZUcDlIo45E=
X-Received: by 2002:a5d:5e85:0:b0:490:f775:b00b with SMTP id ffacd0b85a97d-4a63f64de54mr255493f8f.52.1794936815359;
        Tue, 17 Nov 2026 09:33:35 -0800 (PST)
Received: from dl360p ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a2e6c765dfsm8165024f8f.33.2026.11.17.09.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:33:35 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v3 0/2] iio: proximity: add Imagis ISG5320A (Samsung Galaxy XCover5)
Date: Tue, 17 Nov 2026 20:33:31 +0300
Message-ID: <20261117173333.1853986-1-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116074013.355363-1-tadilhusrev@gmail.com>
References: <20261116074013.355363-1-tadilhusrev@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds an IIO driver and its DT binding for the Imagis
ISG5320A capacitive SAR/grip proximity sensor (I2C), as fitted on the
Samsung Galaxy XCover5 (SM-G525F, Exynos850).

  Patch 1  dt-bindings
  Patch 2  the IIO driver

v3 fixes the real review findings on v2: Sashiko AI caught a High-
severity INT-polarity bug in the reset sequence (eliminated by
dropping int-gpios from the driver and binding entirely, since the
pin is already described by the required "interrupts" property) plus
a Medium-severity devm unwind-order bug and a Low-severity unchecked
enable_irq_wake(). Both are now live-tested, not just built. Per-patch
details are below each patch's "---" line, as Andy Shevchenko asked.

Tested on a Samsung Galaxy XCover5 running 7.4-rc1 plus this series
(2026-11-17, kernel 7.4.0-rc1-00023-gdcb8b91fb779+ #30): the driver
binds, registers as iio:device4 "isg5320a", and in_proximity0_raw
tracked a live hand-proximity test (baseline ~0, swinging to
-12817/9748/10759 as a hand approached/withdrew the sensor).
checkpatch.pl --strict and dt_binding_check are clean.

Based on v7.4-rc1.

Tool usage
----------
This series was developed during XCover5 mainline bring-up with the
help of an AI coding assistant (Claude Code, Anthropic), which drafted
the IIO driver from the Samsung vendor driver's register map and
drafted these changelogs. I reviewed every line, built it (arm64, 0
warnings), ran checkpatch --strict (clean), and tested it on hardware
as described above, and take full responsibility for the contribution.
Review comments are welcome and I will answer them myself.

Adil Hüsrev Tepe (2):
  dt-bindings: iio: proximity: add Imagis ISG5320A
  iio: proximity: add Imagis ISG5320A SAR sensor driver

 .../bindings/iio/proximity/imagis,isg5320a.yaml   |  55 ++
 drivers/iio/proximity/Kconfig                     |  11 +
 drivers/iio/proximity/Makefile                    |   1 +
 drivers/iio/proximity/isg5320a.c                  | 848 +++++++++++++++++++
 4 files changed, 915 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml
 create mode 100644 drivers/iio/proximity/isg5320a.c

--
2.53.0
