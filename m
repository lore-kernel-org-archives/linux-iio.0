Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9841B346
	for <linux-iio@vger.kernel.org>; Fri,  6 Feb 2026 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770398955; cv=none; b=JEoNw9WUR5oSiUSYFby4zn3yxOowNyCLq9Axklac7fGvFatSsEXwSwmbKhQDX2pU5EAeT7qzP8DuNP2k7RfuUqsBGAfXpAZp0JhSe9JAEku2nHlmqgdOehozRmzSUrYOd585yhBS1ZGNzs+WOC6SVYWaLQJBbecEChT8z3lnn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770398955; c=relaxed/simple;
	bh=X4OCnQEpeJBorGqYXoi+7J81mCo8rWEmlgZBzdUxnPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOL+kIun3X1C2v6uQFb84fF7lj22tuG7Xv/BtK797/n/fe4IrCDzgJ8ZiT5/cSEUacis7Ce5HrIBcgdVdCWHGTW1T/gr3dJ2szDseSP1FH5DUEACJcrz5KXBNpagBziqQ1K92GVZ2VvKw1NvGo5+Js9yz/mSFciBFLEfdW+uvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAlnoLPS; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAlnoLPS"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-432da746749so1581237f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Feb 2026 09:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770398954; x=1771003754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxB3vH0iuOXdnI22F4EJHvjyJ371rVhhdGFC5x7FW5o=;
        b=FAlnoLPSlM8dtR82duwvTKydAMNVEJ7Bc4wOmX8xhb9085zI3CzfT5/HmfpvjLr9Ts
         Hm77f7JOfB3lqeefu/AGkeSSUKRSZ2uYBZYRo0+opD3k23ZwJHa3rzZyTuPcBGYJS6XO
         VBgy9TYCmjjOcOymRhLR8GeTOyWBJIOi2QtlmK+wkfM6gR0350m4n8RKlSL/Dmf/ONIa
         Y89qkcXLPoFNesVkYVIfSBIhfKshsuNn1dvSxmD3HA2F5h7wQ+EJCVaYAOTlBhSEAkKO
         d6FpYOtT/nIoyGY4PStK2aW+e8fg06UrBsYmir5v4vb1s7UZTO550QaP7nPcMB2A3npj
         8rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770398954; x=1771003754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxB3vH0iuOXdnI22F4EJHvjyJ371rVhhdGFC5x7FW5o=;
        b=Ozr7VEOK3Qo84HC6XeSK3XNP0B2yACTVYKIUiDppOUi1XQDxbADsY8cYk1y7Ly0ULq
         KBn2+namKZSG0HdY3r5wyE0Jyl4aNFXT7OeoZxuOdcRNwDtb5VQmHKaCKfhEDjHu1Kps
         fccsHVoGSO7vh/wonZQDS1GIFTXoM0IdytmF0KO5TTGVa7f/mTwjFLiyXXhNH5AAB/Zo
         y/akIP4jKLWq+cpSGEmTGsJa1fwECuTuASZQe6VX3ZHhm6IGhOicoXlZRlr7z+qF3kf7
         cTEwrtOwmZ4fiKI7HgXGOTkipmkDwAATtuSpvMUva/cubnQCjUJu7c4/YXVED+xqMdTe
         aacg==
X-Gm-Message-State: AOJu0YxI433bL1JOao/AtEeKOLKBxW5KcoUwNshKMVZlLqWs2zz3EaND
	g9d52619Ci1GAh3mPgrtWBHuiAcLC59gzeiRl1lx81ljcfJIgXOez2Es
X-Gm-Gg: AZuq6aI8Px3T6hh2nNjlRaQksY0V79CHxcub6Yt8eCNhHXEzHbnMxQYcC4nWL7EvvPE
	k/CZQ78WgXFcbsfp66ah1qoTdLjQ9uhRRb7Fu0lZrkoYFwZ/hHh+wB1LJUWWOB/gK/9az5HuqZG
	rd1Cqih+J0ebHr+5uhAaohQHjYQm7AgcjcR83Ni5cg8IpkWpLONixeUnbZzvCwtso8lr7c44D4d
	goAbvPi3jktK+EMIYGKGVpYBiQkCyvARUOewIdy3iy4hiBo50wONR6g3qGDDXU0bssb5XP5Dd25
	vHqyHmfN5PekWh1CcRODHQ1eqpUVA4Zpx2tSt3JSTdIwj8ArXbs3EbBTzTgUgDcyQf2UDAkxxXu
	sS51wrgc63YuI6g0quNN+5JIVhtdrs0HIPY9a/snsm83Sc3QnWIt/RrdAnHIyr2ZzMXD4cmNYtl
	Px
X-Received: by 2002:a05:6000:1445:b0:432:5c43:76 with SMTP id ffacd0b85a97d-4362967e34bmr4965535f8f.39.1770398953684;
        Fri, 06 Feb 2026 09:29:13 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629734268sm6846033f8f.24.2026.02.06.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:29:13 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v2 04/11] dt-bindings: iio: adc: cpcap-adc: document Mot ADC
Date: Fri,  6 Feb 2026 19:28:38 +0200
Message-ID: <20260206172845.145407-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206172845.145407-1-clamor95@gmail.com>
References: <20260206172845.145407-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible for ADC used in Mot board. Separate compatible is required
since ADC in the Mot board uses a unique set of configurations.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
index 9ceb6f18c854..1f77da7f8e06 100644
--- a/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - motorola,cpcap-adc
       - motorola,mapphone-cpcap-adc
+      - motorola,mot-cpcap-adc
 
   interrupts:
     maxItems: 1
-- 
2.51.0

