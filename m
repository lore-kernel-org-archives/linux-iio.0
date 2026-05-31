Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0933DEE9
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780257519; cv=none; b=LniBUBGgmF8wkH85OL32lb9Hp96S7MkSavDzkiKSBTJBvktmNylsFNxfP+VPQuYrZRcR7l6pEsAMFaSUBE0zGjOfDHjp48R/E0HOTkwybFVb37iraJKv/3fxApSzT+RtyPM/2uKXcBj9bQb5rGxTR1bYnIkdikknMnArAkP/zsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780257519; c=relaxed/simple;
	bh=HJcKaiRHUPVVz44flDxq7RjqHlMgRL2UvrwWMWukkOU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kefHSFz/0Yyant+jyn7r+ZnOf/IzE/Euioxg+7DMb12t9ocdKFHnX/VvlivP1kbx2eALeIQvsZyMdN/fc4kyechxKHCQzr7vSiJp5JlFocCi1kXFO6vtU4LoBgXXP+LPWc3LsU69WTkNls2qRwZEmjh8CN8hlL7Cfh+vJrG5s3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1WVcK44; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1WVcK44"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4906238c62eso73968425e9.3
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780257516; x=1780862316; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=28TrmenFX4jJrjlN6PZ1KHA15XnNjrQNxHUo4wAACFA=;
        b=F1WVcK44cICGoqTLOnFOqFDlvQuaz7EfWIUZA0oOdj0pbTpeWxq9k9P7BzRl4z0VVz
         SZbcbPzjYKUIClLz2RD1xYsU90mlGvqcLAj/wUyeuxNyp5eN12+1ypefM1nrBTOp548/
         BBVwwwlozvzu2Tk7b8Isosj32j/36vP51ejMDzDDWgkU+6Fd48Fyr8vbtAjFuHcV2z1W
         sFHtUw+09xXCqcPtTq+TM9g1WOrUCb9D9CTw0sVBER8F9oXdgI1xCc+aIyTpAKKfk+WU
         5RE+Y7AdaBwjC+fz7hMTpdrXlTZo+acjxPj+ijkYRh+3qMkUeOYK4ku4tqaVYX9magWx
         F6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780257516; x=1780862316;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=28TrmenFX4jJrjlN6PZ1KHA15XnNjrQNxHUo4wAACFA=;
        b=qpCOcch3fO1F0lIWxSk69tPadRwVy5NoiZb4NRj8Cz3MoNOhPsb+l4pspoGrNjwuOl
         a1b+gX1YzkJViFAv5Q77gb9/YWyY3CCjgyXv4Kx21aabw78SOX5J8KdmtlLJaKzkivGo
         xCs9gxZK6jkRE165fqOnsvcf6lkE5ozG4hdffQ+I+7EjlHAKURpAJjXx+YGnR50sXvAV
         Dc58c3/FOYNEPMXvia3IGxsrEOuKlhxlkOsvQjwPlsz3Nt9kYi617Kw2L+G2c5JEh0Wv
         ofmVnnjxzgkJgdIptt7sZbbDGCn20gmG/Z4II00Y/e1MksBybAXUxwf2dKEpSBxa5sUO
         jJUA==
X-Gm-Message-State: AOJu0YwSYV9wBQL23dvs0u+Bnu2fJRoOjr3Av2Db5b9v2OteN3BTYgI8
	yk6hGYVECM66BsfxnO71hWxFwKI20MmN9bzQ/850i2vQvHJ6fJXmAfef
X-Gm-Gg: Acq92OEDKTEz8Rd8LqNEhHv4d0zy2ZrDKK8RzcUMiSoMWxYsUjljfWZbq8lLg/YMsqb
	KARbAJpVYJ1lQH4+0Kv0eMFZ9y257adITFW0fEYOT8gqtLi7ITk8zgrlm/3pHXXYtwLqNMr8kGz
	J8McuIXMgzaBVdrsBU9XY1dK2eEKwI+OQf7b9qDM3rqGj5b7E0cEuqwQwuLdGv0CiF3edbWgd4k
	Q1/Snos32uLrUEx2FG9Gzfp5NNrNjeffEa+7FVwZ1U7jm+RLE+DiRfV5bXYQLZQ6576k9K5r1bV
	WCqWqrTbKkfnAqXzArEaz+IaSlxzhxM9K7p9erHDkiUscuLunJngZU/+gZUkBBMmwa8yCEMnSag
	tqEH1KSpWTxqcRXJgtYiKzQnK971cJKa3lIwfVxN7e9pkB3gLnxCTxLLeq+BpqP94LU9N6Tyuwv
	AGNLIplVsT1hQQsWn09SI/kJ22VLC3GoCwOIz1yivlOO5NbJmwzQ==
X-Received: by 2002:a05:600c:1988:b0:490:44eb:c1dd with SMTP id 5b1f17b1804b1-490a294fe9cmr141548325e9.29.1780257515601;
        Sun, 31 May 2026 12:58:35 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:152:df59:bc17:a305:8902:fb31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d7002e8sm220323775e9.15.2026.05.31.12.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 12:58:35 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 31 May 2026 21:58:21 +0200
Subject: [PATCH v4 1/4] dt-bindings: iio: light: veml6030: add veml6031x00
 ALS series
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-veml6031x00-v4-1-e64f7fdce38d@gmail.com>
References: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
In-Reply-To: <20260531-veml6031x00-v4-0-e64f7fdce38d@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780257511; l=3301;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=HJcKaiRHUPVVz44flDxq7RjqHlMgRL2UvrwWMWukkOU=;
 b=/PVpw15lZ0+TPX6JQq+JbCzNeahWAhBqe7SGtPcGK1AuPeTrd2dAbXBTKAoUni/6VfW3qwqvH
 I9kAFKTZAfAD/RQV5wU9HBWRcXpXKaM1KatsdHlWMZWOiOWPvSEWlYG
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

These ambient light sensors share their properties with the ones
from the same manufacturer that are supported by this bindings.

Note that only two datasheets are provided as every one of them covers
two devices (veml6031x00/veml60311x00 and veml6031x01/veml60311x01).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/iio/light/vishay,veml6030.yaml        | 23 +++++++++++++++++++++-
 MAINTAINERS                                        |  5 +++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 4ea69f1fdd63..e01e8747e47c 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -4,7 +4,9 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: VEML3235, VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
+title:
+  VEML3235, VEML6030, VEML6031x00 series, VEML6035 and VEML7700 Ambient
+  Light Sensors (ALS)
 
 maintainers:
   - Rishi Gupta <gupt21@gmail.com>
@@ -22,12 +24,18 @@ description: |
   Specifications about the sensors can be found at:
     https://www.vishay.com/docs/80131/veml3235.pdf
     https://www.vishay.com/docs/84366/veml6030.pdf
+    https://www.vishay.com/docs/80007/veml6031x00.pdf
+    https://www.vishay.com/docs/80008/veml6031x01.pdf
     https://www.vishay.com/docs/84889/veml6035.pdf
     https://www.vishay.com/docs/84286/veml7700.pdf
 
 properties:
   compatible:
     enum:
+      - vishay,veml6031x00
+      - vishay,veml6031x01
+      - vishay,veml60311x00
+      - vishay,veml60311x01
       - vishay,veml3235
       - vishay,veml6030
       - vishay,veml6035
@@ -67,6 +75,8 @@ allOf:
       properties:
         compatible:
           enum:
+            - vishay,veml6031x00
+            - vishay,veml6031x01
             - vishay,veml6035
     then:
       properties:
@@ -79,12 +89,23 @@ allOf:
         compatible:
           enum:
             - vishay,veml3235
+            - vishay,veml60311x00
+            - vishay,veml60311x01
             - vishay,veml7700
     then:
       properties:
         reg:
           enum:
             - 0x10
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - vishay,veml3235
+            - vishay,veml7700
+    then:
+      properties:
         interrupts: false
 
 additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..921da7584963 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28375,6 +28375,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 F:	drivers/iio/light/veml6030.c
 
+VISHAY VEML6031X00 AMBIENT LIGHT SENSOR DRIVER
+M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+
 VISHAY VEML6046X00 RGBIR COLOR SENSOR DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 S:	Maintained

-- 
2.43.0

