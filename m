Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9663546EB
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236354; cv=none; b=mrumbpH6FJdfNVeiHGaSe+19+dFjIHy/6rF7+LrBvJehsJ1fezfnU17kTlCFZRMf05/BLl5aJ1736zqonz8JhO1ts/agDUevzUMNR+EnoRQRFgViw4cVxs/9XuZ58UVM97PNtiGwQEi3W8qUkz2riyXF++nld7UKwqZq9MVCuVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236354; c=relaxed/simple;
	bh=a5RakhIEYhfE5aUZzebBLZ1wAm/eAbhVK1uouFMH8eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUKbUt4fHkZTKQofqiJGxDzh/ucAypeIsvpsYeF9rUdp3BHmn02JhmYj4pTKCjccePqbNtGDrNlh6PS6LbqXt87nS2g7t65gB3jfa7FDPSjkWWWJqW/bInewzu2V7netvqdAMiI9qzwOTUCzS/RbujLzo+/ofKUZXW1sNAu8i6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE5Soujw; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE5Soujw"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c2c46a428eso1767129e0c.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 07:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787236352; x=1787841152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=T85RHS8VejstyEgBz1/jasjfhA3Et8B7A5u7SqIabRM=;
        b=IE5Soujwbit64cJH/D5E1UTwfDu4hmr4bT9iuGr+HbIYHtxVcdH+x4WMFNzFVS0kDA
         JokQGCtc8h6cS1rJ1ASXfyBGLxKUmD3VlIIv2fHCq68s42OHT8ZFYxD3X50/9lxLAV8t
         5VpO8DXkQkDxgD3cqHJJ4khwFMFynaWQfwyJ1q2GA8iWMIRIQuJdme3mow/0vsCFGH6/
         sBd7GG9K1fI1pq2cqhAj11lBr+/l7JQM/x+FQlMXU6QjMmF5WDT8JpEOT+zE3L1bW8IG
         +cBIJBAxSFAyycQfxLM8fnLZnOT9zEJJo+mUBwZAW3qbJ+G4kTdAiRRIbP4Jpc2+Dw1E
         i0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236352; x=1787841152;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T85RHS8VejstyEgBz1/jasjfhA3Et8B7A5u7SqIabRM=;
        b=OAw+3yHnF3/576A68UYNVBoynA2Xs5uz2coKuOUT0PtRgoYLFPo0rI5wjbbyFMrrVL
         UPzgnouVJvYrY8tUI9Y0P/FwfJ448KqReeA0pCL+pxyYoMehBvGhWgkmmaUA1RLWOnut
         SfnuID8mB+3xMbRM/AiflB0+WCRniozF8xexVLMd2BPPEhVwdh6i2RXMOP0QXTPDe49g
         2H2rS1q306dPSm924Zt6VSOcv41arhF+3gzonf1zAMkGYSMJLO61fztYRte7nQOdVXPh
         NL65jriUgkm3wMtNIQzquw9T9ZY8dZBdLJbJK7xCD5df3gB+80BVjCOLt1JMAjI3Jot1
         gTRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKypmwL0ZGVbB1FGQwMjyVEJ7NCuHGH0z9DW53hwvS9nr8Fa7mTTOZAdAa2rehpYnmdl4Q+hf2sdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9p66yPjZcCE9B7zgGsS4fUV2+Bav4P759y33KkYvbHnOWUhu8
	Dj+xMFL6MAktLyg3pmvnx8qBRQ+hunXzfrrf6B2Te1926/eyjilKaMY=
X-Gm-Gg: AR+sD11Ipu5WKYK91LDuOunVXxWbn72lTIJXbu/OqnAhn7nQ83FS8VFd2FrlgfcEJRj
	z7oMyBc+0qaqPYlBQ7jVWLwCbfDvu9/kQ/OX2+BqgBr2ngGeA0IR43MFX1w6pDh/Gb8vI6kZBNE
	SmKjEMbY/nT/vqGa/Itgf8uSYDrjVzGarNtImRZ//q/Sm+TeqDj9ZXHe0dCu8q0Su/R1LEYcNN7
	XuDk01Y57M8UHgUhy9PJOY3wyQAbWh917bjLmZNHPwNCThwWd84sQlcWQkb4T7H9J8zfVkQ/Be4
	wvNnzOipGLFe5NpXyjFc6dr8F7KI586WF4K7rlYNn2WMadOE+rd4JZ6WIv6+pjrFxPLMYl+p6s/
	JGF5o0ikzWvWzni2X9ZTVlS9HkN86unT4/01LJlcU00DvdS3mZcXEP68krraaEg2P88NOPAtBZZ
	mBtMEY0gM1Q04Vmr8wI5vTywlKFnLQn2c4qzbAmxBxPOW5728ypUyhgfBm6SlKxSNtwZG5g4NmG
	O3dhxL+Joa7BfriQDFOPUp/8+qHcoecAdCwmvfY
X-Received: by 2002:a05:6122:3a16:b0:5bf:8c77:e89a with SMTP id 71dfb90a1353d-5c5e3de4dcemr5807238e0c.2.1787236351791;
        Thu, 20 Aug 2026 07:32:31 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5e25e3459sm6393922e0c.4.2026.08.20.07.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:32:31 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/2] dt-bindings: trivial-devices: add Aosong AM2315 and AM2320 chips
Date: Thu, 20 Aug 2026 11:31:09 -0300
Message-ID: <355f97d79939b0fee740f91e0d4a74b484639092.1786973355.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1786973355.git.nico.antinori.7@gmail.com>
References: <cover.1786973355.git.nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Aosong AM2315 and AM2320 are temperature and humidity sensors that do
not require configuration.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 435c4baab436..92b757579eef 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -62,6 +62,8 @@ properties:
             # Aosong temperature & humidity sensors with I2C interface
           - aosong,aht10
           - aosong,aht20
+          - aosong,am2315
+          - aosong,am2320
           - aosong,dht20
             # Arduino microcontroller interface over SPI on UnoQ board
           - arduino,unoq-mcu
--
2.47.3

