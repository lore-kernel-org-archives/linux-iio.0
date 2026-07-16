Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFC743E099
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784223376; cv=none; b=tCkwySfkbNCifoXfsWkinAPp+kO7xSWxXI0F7mrJ9CMqjPABLLnkGtx2rr7m8YhAJ5FNnR3HiOJh8j+et9/jPKBkvl0vyrYipZNFEhzUatiwAQYRiyDZEMp6jKl5qLFBihQJLFN5F5MmEOWBCtcS4o5QvJh8NhBAP7IhgJAYEvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784223376; c=relaxed/simple;
	bh=fJltLhLA2QC5IBK4IlrMdfGFMwZnwxS8+Su9z2qyXbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJilRc+rVJYRo54+nSg1OC6XQXvJTC0VurFD+k5PXZlwml7+CWlRBsqz2QjMC7vzLl9mZPOWJ7J+E1F1LfvzBY6GppW7p45F9LUu+QxfbCl82rzM6c9RDZF76TfNpHgRo+H+HgIiexlzvO+jP4/DAmX36Jv58+2w5Gbijc7d71Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpvWabJr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpvWabJr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493f60208a5so57548815e9.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784223372; x=1784828172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tH3vOBg6Uhm3v0R0bwuHJN3nbISSCYwbAVygdnWGM/8=;
        b=fpvWabJrFHTVvCFIzKUqu66GKsyxEniPU6ix/cU9s2O2d1wByBQ+YWbm9ASt+M50U5
         2/qD8gkNVE/HfX9WzrGjCokdQtK/U4JMt+0uUiun/UxFsTiD2WZu07Vd5nANWTX7t5HT
         4g2zzCROTZVJK2+YDd8f/+yJeNXymt/vknGuMJYdRxN2ySR0hjWI9gaZHTopqvabODYF
         8CFpx2KmkftKgY6sbY3KxXZzmV9jrxERxc2G/zVS7S2Sv+W1xDoO7Wwgj2WvXQCHw5UY
         fn3QmkrQ2Af4SRS8/142X6UMUC2IaKcB+2DySxXYHGzeS4rOS8SPJMtPb6bUsMg1tPXh
         wYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784223372; x=1784828172;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tH3vOBg6Uhm3v0R0bwuHJN3nbISSCYwbAVygdnWGM/8=;
        b=hOXSKQrXpcOcKF0vH3YhrOn1L2C1E/sTJVTEc/TOxuDBe0qvxxqQTWjXXnVo8ZRwt6
         Og+gWNPq9MNUcn2eUARfHXPTtxbBweY5E59+j5y9ws+VQTwDF23VIOoPty9TOqIU+eA5
         TRa90C/Xaems84B+wUx0k9nPvYBnvS8q4Xh0nlJGufeIU6fLJVKaq+nTZsry48M4Axu7
         GkEjHLLQlvAkVgd+lZGYUBWWS0SaLA9TjnB6RvUPr7UIdqoNm5kj+yk3e3odjB38d9Ti
         ElyMcpCRxcH+Rpo+gy8nB3uATft8Kxg1C6ilBktkDvLK4twtcTTOVC0voUCDfyT6l6sj
         fIHg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5LLaualp7+iFyIG6+km3EVdZSz1WM+dOfL6UHHMX08jwrd6V9XBwJuWtLI5Hlm2mEVOCyvMUSPGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5n+ER7jgR5qDVF4sjgRMcytFRi3K/wqY54zN5pTQMEUCX7r6V
	+Y5JJvwZsUfkrgIZoIrPKjOtKHh11XhlmiQ50v7DDtft3nvYrclWot7m
X-Gm-Gg: AfdE7cmzlIjIx9WE1GyzZXnUwYbUPIZ7AMBXyHshU+zDNQDxBCbt2xd4tJcuQQWx/CQ
	wpYaPzQzSHbZsx4p/lIoPnXKwY2aMEQw8Q/fXHW6eNiB3023cQYyN3+SVu2bmw4ji9eNXHLW9iy
	5TNQ3SvnrYN2wTBnoFN5x/FxRVo79w8NjZGP2/65YQKZK9ydmBBVeOANY4780O87g/hyHphp/1x
	vTObsRPJvdOf41QI2P2cw9gxIj6/9JLKgW1wiSsO4ncT0JPNpTXM8TXGxDCb7L4j2TtkadBUBkY
	ImioW8bPp/sJiQjJJA+se1zCNb6yY7QoJ2X9ksoJRDfeqgsVNJT/zHCIO8ppXzqfNkCCIwubDWG
	4Pn3F3/VPDHSGa7BSyM9LS9vdAfKMPjpvQchPAwkPWhDGA8QLwMDfHtxWxv9ET9c359nve/2UZz
	L/yywqMSnJvEQOnIadrCpTqXbMakrx5BxYCR4/Bnu5s4BUs5trAwux+Kt0Dxxf/HAa/bHKzMIDD
	F4nIQ==
X-Received: by 2002:a05:600c:4593:b0:493:cc25:85cb with SMTP id 5b1f17b1804b1-4953c14752amr98306525e9.8.1784223372404;
        Thu, 16 Jul 2026 10:36:12 -0700 (PDT)
Received: from izzolab.play.pl (77-236-3-190.static.play.pl. [77.236.3.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954812f0d0sm7983005e9.12.2026.07.16.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:36:12 -0700 (PDT)
From: =?UTF-8?q?Pawe=C5=82=20Wi=C5=9Bniewski?= <pawel.wis.me@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] dt-bindings: iio: proximity: Add Cytron HC-SR04
Date: Thu, 16 Jul 2026 19:35:55 +0200
Message-ID: <bb79ea1b842e062dd47bd1fb31fdd15a9ef76c29.1784221074.git.pawel.wis.me@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1784221074.git.pawel.wis.me@gmail.com>
References: <cover.1784221074.git.pawel.wis.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Cytron HC-SR04 starts a ranging cycle with an active-high trigger
pulse of at least 10 us and reports the acoustic round-trip time as
the width of an active-high echo pulse.

Add the cytron,hc-sr04 compatible and a reference to the product
manual. Update the trigger GPIO description to account for the pulse
durations used by the supported devices.

The interface matches the two-GPIO protocol implemented by the
existing SRF04 driver.

Assisted-by: ChatGPT:GPT-5.6 Thinking
Signed-off-by: Paweł Wiśniewski <pawel.wis.me@gmail.com>
---
 .../devicetree/bindings/iio/proximity/devantech-srf04.yaml   | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
index ce795279839e..f4237ae612ab 100644
--- a/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/devantech-srf04.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/proximity/devantech-srf04.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Devantech SRF04 and Maxbotix mb1000 ultrasonic range finder
+title: Devantech SRF04 and Maxbotix mb1000 and Cytron HC-SR04 ultrasonic range finder
 
 maintainers:
   - Andreas Klinger <ak@it-klinger.de>
@@ -21,9 +21,12 @@ description: |
 
   https://www.maxbotix.com/documents/LV-MaxSonar-EZ_Datasheet.pdf
 
+  https://botland.com.pl/index.php?controller=attachment&id_attachment=476
+
 properties:
   compatible:
     enum:
+      - cytron,hc-sr04
       - devantech,srf04
       - maxbotix,mb1000
       - maxbotix,mb1010
-- 
2.47.3

