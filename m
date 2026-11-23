Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446460;
	b=Z8XddSNUnq1kaMy6Mq2yFGA9VaLe7l5QyTMgJX7+9+co1JSAefpokOUlTIkbyT+U/RfH
	 T8QSpO/93PBuuIhzdSlb89wng8WS2V02sAXnBC0I0gJb58XebkhJsk4zkc9sx1/AaTajv
	 a1UYkVk4GzFVbsD88lj14PI2aj1mDO4nrnel5gRbLV6sK+b/8vnjsg5HYg2XFGZp83B0b
	 hPLoZGLOX0hDYcdQtEmB2gHCi39kK2iLRLRVexrG1PMsceGLYmVtyTqaIwGWz/v2H27yh
	 5p8vvVyypD1xQkyMwPFfaX42RjoicFJncuPymZAg5MvKvoP0JQ2wR1XaQ/hOJRUlxPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tg6KFP5XFzkAyQjLfZmU84t0tWUyWBd7hqF2C+KuWOI=;
	b=12bOmmkndmN1iRjVCRPO1YLEeleGjq5/TxbKR4rurJxFVJuiKI9BZDmLWUoUbSfgTtbj
	 k2gtaHn5G5ouLp3Tb5WDLKI2HPl67s1mwNsbf8Ay9f+6tWuvAfwEIL6+Eraob/NEGj53R
	 PpHoGxT7VlMztPKHZ0IKvXJnN8nG3LPs6/MEl+FI57+B31yWVztee2XSD5zfLVSnyNA0+
	 9Co/mLuxmgtpiWBkLe7K3YPtxkWUPLesYcQOCos75bfy7pcByAzxND0yMXVTD7THTq/oR
	 7VbZWS9N6j+wNmlwBxo2GwEYG8q766SGw8wVYe62d3hjR9NDx5wjLEes0GnSMycFf+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KggIy63c;
	arc=none smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC02606A321
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 15:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FC02606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KggIy63c
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b87a240de3so4165559a12.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446459; x=1796051259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tg6KFP5XFzkAyQjLfZmU84t0tWUyWBd7hqF2C+KuWOI=;
        b=KggIy63cUOF/wLb9vIJA/xy4P8AXOgUW7Dxtxd1/05kwp23tSarT4fzRj3eDS75YCt
         3wirC89MyzFi41LnZmF8VdIwBR9H4u5GgAEsYjjS/d+dMe7ltrDQgBL4LUaDsRk3ie2J
         IiMU9XoFdFS4juoAM+5IiiJwOlMlN4zaAOnohB1Be0ALq5za7JAOwdfKtJA3Qzytqg68
         s2E6bMZ0JMIm3dMW8usaY4UWoAUj/irnLvcsza0O1byS2ElUNmmqH4cSVbXUY3R4Zu6y
         lrdPfX8fupZa5Jv1gXICHIbCptn5clWWhWBJTVqkPDlcVQgmFkQhI5vIx4Prxm1blgLL
         LxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446459; x=1796051259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tg6KFP5XFzkAyQjLfZmU84t0tWUyWBd7hqF2C+KuWOI=;
        b=sEZXtpNswIMCR/Szs1s9ibko7OBq3OdJezvAB7JSlsY+eziWsBW2RVpeOYzEwujCaM
         KRwJfPJ1J5Gb721xRz018iMnUzy2AUbz3c03yq2TxvEIH+bVItJ+krPCZ+0rt+joUTs3
         q9wM5jHIeSNu5i90w90SADoGaQfy7yJ8vmpaPRdK6Sgj+oDzbrkPe86T9ncrHpduFJ1t
         NyysAzFfZva0a4zHWlFIw9KlF1EWTLDpIqowXI0MROkB0dvoYdBseqAtvZMrDJUTdrAW
         x9/lE/Cif4x0ZhXd7Iw2x5ff8vPdR2KqyIm9CYVnkBT4l7zyHk9AWyLTmIEUGz3wNBY/
         Mn6A==
X-Forwarded-Encrypted: i=1; AL+hErERksmEMT9FOzuCXwKv1DUODq1V5G80P893HDwqxK17Hvh3yeUZzxHFYEtcN6Av7/m+7F3L4TFQsQM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Nxn3wtgvk61uLvV1g2b6DP3HFD+viTxWP0eUBSCW06ISHxjGG
	nm/360XjrSIp2lKn4DwpW9CMYuTFzoDxS0CDNkahSez9svgsGv+b3S6o
X-Gm-Gg: AZFdTZfPENEl4422t6D3/z7zHF4MiDeY6cpjosHQ2ILe3QfgbGFIA6/Ld5Mn3g0vxU3
	LjLBw+cFZsnvxC5il2EcXvDKRVvfrIl+NBR/MpukXPV70SGS2+jTTOhoDn5A+8+ZPdkyfe5GgFe
	CJu2ICA9VtKW/vEO0vzkOSjzkTtyAhq2Oy9IxlI4Kak9v9UthSB4S7TCTiB13Dj0x1RCSjhfJFu
	iiljjWQOJJ2CQiYz/+EoDB4Z2PS3cedSpUvvA4JxizxgygouTT2gPfzdh0YuQf9pjLvr/D3r94D
	5CpxBSj+3/nUSuArw4d03VnxEmAzFgYP1LPxL2wFxFe6LxXp7+K2Qg4xQjEiv/rSRH6M6Nlq8p/
	zRBN28gVyXhiGVZAbM2iHRMj6r7/363Ll9f+XssAKjyVHCvQ/Jroei67s5MbV68+DcnkyPIN7Fu
	gP9H+2meFx1hhMnoY/DmigBdJPsBJnBWzC+ukUcNppOIzOpqnV3mleC1tIPDtYMSsojWYuUnwRe
	a2HHkWniz2ZYfSsQo8VDweQoeYxXUVC1bpVwhtEQhNbXGjMI6YpY9bHTpE1Ombq+2XJmQrNl/LW
	0pWJssOlP3t0dgIJ6wuXZtIYtLpdwzMS/R4MS/F66RE+2+UXOlYdqtXyGQzv2fxiznuawioBpi2
	pY7Iw59Cifg==
X-Received: by 2002:a05:6402:5686:b0:6b8:823:9b4f with SMTP id 4fb4d7f45d1cf-6ba37eb1d98mr6528446a12.38.1795446458383;
        Mon, 23 Nov 2026 07:07:38 -0800 (PST)
Received: from xeon ([188.163.112.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fc020sm5446279a12.25.2026.11.23.07.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:07:37 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v3 1/4] regulator: dt-bindings: maxim,max8907: Document io-channel-cells property
Date: Mon, 23 Nov 2026 17:07:22 +0200
Message-ID: <20261123150725.212836-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123150725.212836-1-clamor95@gmail.com>
References: <20261123150725.212836-1-clamor95@gmail.com>
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

The Maxim MAX8907 has a built-in 8-channel ADC. It does not require any
Device Tree-based configuration and is folded into the main PMIC
node. Document the io-channel-cells property in PMIC's node to be able to
request channel data in the Device Tree using the phandle of the PMIC.

Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 Documentation/devicetree/bindings/regulator/maxim,max8907.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml
index ee1a305d1c210..ccdeb9ba21e26 100644
--- a/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml
+++ b/Documentation/devicetree/bindings/regulator/maxim,max8907.yaml
@@ -27,6 +27,9 @@ properties:
 
   system-power-controller: true
 
+  "#io-channel-cells":
+    const: 1
+
   mbatt-supply:
     description:
       The input supply for MBATT, BBAT, SDBY, VRTC.
-- 
2.53.0

