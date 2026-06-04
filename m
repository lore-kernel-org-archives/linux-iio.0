Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38BE3C060E
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 20:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604456; cv=none; b=pmvzbhI+ZWirkxUQ+U0wF//JW7r1ubgGCZdNu5qW7SrCkzmrqfQKkCYiyUpp1kSOiWpCaclSCZGuPBl9c+D6njwYLw9y2SfZVUHvJk2XYvdwrb8BcoJbPHGv/bb3Zpo/k5BEjiNxTSs9tuFa+wY4hcsZAQtOxTE0q8p/EC+t44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604456; c=relaxed/simple;
	bh=BYwxpdwIOxf7wHqRQciuY2Af2ntz3zyjFfIha8IvcT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0/6hORYsSiz20f0vbx7coh2FuEaS6VpFJaj06A6sOu6PZfazLeNP1tFXGlclkU8+OT0FmnxC/9Qu/IZsA/ufSmhTma8e/SdiAXRCvjagVHKnSEwcPLmf+u448txqQgpqFl6EgF0xatOIaVGqjWJSg3Uju34FDzYSyiBeAG8eBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NN6uljEW; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN6uljEW"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6b5c374e5so1264401a34.0
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780604454; x=1781209254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcgz1FBr0J4qXoUHyaNL3XQfYa/z8zpzCDQPO3u6gd8=;
        b=NN6uljEWMgptGlZ+2BR7QSGrBsLugJ9s/L/Yp2GAjJvViGsk46qQUuR+2AzW0iT2yO
         sVG4mJidpQ9qdAstMo3fC2FZaBTFq8tlB+wboeZylbBq9o+2neSdxdcLzlF+Gf+NoG7t
         woHrDWzRxyWjqJQeI+Z6j6Qjj1cnTIbPFfJ1oYdBDRpzagNI+Pnn8JgPdD4dogtwJC2u
         SuvgL2LGnnm9oeBnhVaCWSarWUu5Q60WVK7AarBgOjOOsxGE79cS1M/3AA+PKJCnz44r
         SMrnTxwE1ZXH0oEsd01N8rS++a1tp7f2dauqNpexiG1OvnMCcJWXtuasE55be68DHBwF
         XzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780604454; x=1781209254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kcgz1FBr0J4qXoUHyaNL3XQfYa/z8zpzCDQPO3u6gd8=;
        b=E0WIKCBp3pjtKAX3U6Krlq6nR4Sr5o0Zl6C0pFn4Ebyz20ohPhNWY0arZz383xshLI
         cxvDnX6ijIrIhY3D2SkbzQY3PdJMxmz2+eaDLZ9fh0V/v81N/TdqDhZkUrzRxI4m313N
         +1tPSxiq33GdFL8c0GkZu8+sSshIbS0h7YiSV54TMwx5/jk6OVYyK6jQvr94l9qCl3B/
         My2P3CWIGKl6kp+acOGeIxC/iUPsxrHHYXS5KY3loyBnuwAO8IzbO6Lz5JT1jMUGfM8f
         tiKg2LIkpwgzwNVgRR/2HfmYwcZ881PkBZPCmEtZk/doRtfDc9lrsUMlujDmouhHkKf3
         h+rA==
X-Gm-Message-State: AOJu0YytIE/Jit4xYwZB4N0RBqwjkNPlcQJEX9zbo4E+VSeu7ToWrbZK
	PVDyKpxeuRP2aIVSLMqWI+uo6ZJoxiLD9fvBFMY/QdBMU1yHvG8u0C03Z+yL/c3c
X-Gm-Gg: Acq92OEWNjUyN66oCV9CkXdzKVg457uOTQHnrVshyOdt45OCCbsa3eGRk+sco+WPyMe
	294Rc8kwKUMEzoJFQeIy/suzb10VhyukSXu/AmGb5SyEk6NRTCBk4P5GbJVcphD07MfFjCPz1wt
	Tts6mdcrjWQAAQMMqVCxiwl5tO5WeUDRoAdchwLlN3DnfnJi2BsDBMmei8KKIwqiE8S7EO3ou/e
	e59qi4YAL4k/6HBFZXTtmIuZEYHhSFwm8+i+f3HXwht8SA9lDLQs+kDTolXX/Zo5GXAJbGPbzIQ
	GsutrnuVPLhGCZxh84O4wGaeUQTWZTmhvZFkhZvh4rYV0S1mLhNkf/+pSTToBzZYQWIHGtOwnn/
	Kqz2qxxVvmmuM28P2YBbAO/M7LqXhESBjPXh3jFiO+7+wYTsWVf8kgAMKS5PdjOq+5q7YHXZyZT
	jHqbQq63HuULu60GIqbhyucRsaDAkDoJw=
X-Received: by 2002:a05:6830:368a:b0:7e6:d7f4:16e with SMTP id 46e09a7af769-7e6f949fccemr2968986a34.12.1780604453769;
        Thu, 04 Jun 2026 13:20:53 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e796c675sm4541800a34.24.2026.06.04.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 13:20:53 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V10 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Date: Thu,  4 Jun 2026 15:18:24 -0500
Message-ID: <20260604201832.60656-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604201832.60656-1-macroalpha82@gmail.com>
References: <20260604201832.60656-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the ICM42607 and ICM42607P inertial measurement unit.

This device is functionally very similar to the icm42600 series with a
very different register layout. The driver does not require an
interrupt for these specific chip revisions.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/iio/imu/invensense,icm42600.yaml  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 9b2af104f186d..81b6e85decd52 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -30,6 +30,8 @@ properties:
       - invensense,icm42600
       - invensense,icm42602
       - invensense,icm42605
+      - invensense,icm42607
+      - invensense,icm42607p
       - invensense,icm42622
       - invensense,icm42631
       - invensense,icm42686
@@ -67,10 +69,24 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - invensense,icm42600
+              - invensense,icm42602
+              - invensense,icm42605
+              - invensense,icm42622
+              - invensense,icm42631
+              - invensense,icm42686
+              - invensense,icm42688
+    then:
+      required:
+        - interrupts
 
 unevaluatedProperties: false
 
-- 
2.43.0

