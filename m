Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7E374E57
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 21:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424572; cv=none; b=FGgq2kS18fIVENY/iKoMv4Tq/0nbO1CwGeeIxv0THlBbYKXEnNCbQ30ooiv7KjqJUN+tIZqQBkdSUEXRtyGe5xI3B7zsOS906WQ3SQKaI47coavmYyP77EFTZrQM1DLfgRlVDr1nTcIpNfOL31W9PwRvHRX4zHNp08roFv/7Tm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424572; c=relaxed/simple;
	bh=oT7d6Nij5xBJ0GhxOmbCXfPhv8G03zGfAYJpoiI7Gpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AXViZlvsCCDwFT7hNbcBIG4kxEe4fqq9+K7FvhecnJfE4msQcS6GA8uU6pNcu03hCy3vp/hFvFcggpam93DTk+HBsWcLfuhlTvxwP1ptKTQkbdwd6uIDyEzT9MGA8qj0sXgRw6U62f2/e16ddZMMjUPm1P7itXuReKB5GX5Iigc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=F291xIRi; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="F291xIRi"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e6e9408e30so260704a34.2
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 14:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782424570; x=1783029370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsHIhdRuiUrZeov8w2Nm806VX3ukPZRV2odhXBkDNHc=;
        b=F291xIRiLPw3WbQmg9qYGV9E8XW0yOIKjwJGAP5TmowmvU9ugLmeKYzDvadbM0A45j
         fvU64+t3KpzsTPfBc5pMKCpQ9QhYEF5npyou3hLC36uCF/EqhXd2KNQJmeirDFkQ70Ch
         QUQ5ZdTkj5kdej5sw1HeifT8XwqVkshynjMdmgb9WQW1lYU1GuCL2VhUbXg056Gaz2Yx
         13dzCtuu5k7LdBIJQNcNt/IlKoZCmB6aGgL1hI0InMk1JT/yNeLxtjJj0OJUzXhMBc1A
         PSxvD3wBvmN1yjjmagSuioyQWO9svl3xvSQ05D+IpSJjPZiSQS98IekJ1HQ0D36hZ3O4
         rT3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424570; x=1783029370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VsHIhdRuiUrZeov8w2Nm806VX3ukPZRV2odhXBkDNHc=;
        b=Hfp9ffTMQ7uxd4LHsztgDGGOClEz9tnU/q9eQs3IekRq1dvSMheG0OQC45KakE2cVo
         aApzfKy278vyPxM0taWU8dofVQ3e8VXs6dC9o9sIbeQyvta9Le+IZCZGQBA+4+tQeoyh
         4sVzHnJW6Gg8leoO8hv51tgzKBuVZ4aIDUV/JZLc+0RO1CyPe8GSODcKNCP5otkRqlXM
         KUegbe6XJLwpTBGZHeqQgoyyuTWsAcohtqC+6BTuARFZv3KJaC/2k7dgiAIek/4L6NXd
         dj//VN8W/WY+TJ7+70/C4KB4IGE2KpYMNeFUVF6t3AE8m0p87KSvKMrkiC9B9m/qUDEu
         Y4qQ==
X-Forwarded-Encrypted: i=1; AFNElJ8654Dy9S14ozvIZtZ15wIUZsd5HOywjWa1hTDVx++e1VBJ3GarIIGPuDDvXuLWSkGDazUYlNaNkqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAb7VWLBigiWVRA3abtzDBuXTDuVOUyNZ3y30biYsqvzcXoqeN
	sdW30+SJFm9dnrjTebLY9ksBCGULCcRNH7AJptC6jpion18a2FWjd/gligymdPe/qoc=
X-Gm-Gg: AfdE7ckftGyMrN1E/GJGwavnA9AVn0y8A9kPDHqvbSONUFSj6e/hHJw1fxxPuYo2rPT
	aoxd43eqAszJJPxDcYZon0RBUJ/AHkxzIjBG77yFzlQtWTdW04CKqtJeoER5CMdtykNkgpe83f3
	XA2/kA3/b7CX7ecOOBcnEm1lSDkcNtafcHHI8AKccHqvxWqYx1s1qJILQzdhm2mmMDZyNNesBM1
	E9xhwossBpvVrygSNrfp7/6rxDNoPXQTJp6915QVot3Sf6NF9AyRxAwCHqRsNzfZQVBdT8BgQ44
	nC6Ua5KESTFiysaWvWYa8nO82xRXT/XuWNqPpr5MfAA8w52rFQs3jxUXIswkRP6UpIjUGgcihhb
	qxB6i9VeqZ/nN1E0rhovCO+YYUgXQA05AgbpSSsIkO3csMQfF/pGEQi5xu350yQUf1wIFh09UKo
	kW44uKlSXGaeArOVTc5Q==
X-Received: by 2002:a05:6830:8295:b0:7dc:c7aa:22d4 with SMTP id 46e09a7af769-7e99bf3fdfdmr4319532a34.1.1782424570353;
        Thu, 25 Jun 2026 14:56:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f1f0:2d9f:2f31:3426])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa5e575csm206058a34.11.2026.06.25.14.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:56:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 25 Jun 2026 16:55:05 -0500
Subject: [PATCH v2 3/8] dt-bindings: iio: adc: Add burn-out current
 properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-iio-adc-ti-ads122c14-v2-3-ceb9b0b561cb@baylibre.com>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=KXYgI9rKSrwXDaiih3yLVG5FeAxJstEB+wScOVS9eEA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqPaPPx+i+G+uvga2coWlwkMuoYqCJY0yLabfU0
 fTBlhjLzN6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaj2jzwAKCRDCzCAB/wGP
 wIg/B/9uZ0SQ+KLcG4GRJLXEY5ggN0MPW/UZXZhajU4RMuWtwsCyzVysCRq4IVRp8gZimrF4i9m
 sOIRSk2+E2jlRw7UJzQlRIw1jZqLMLwqjWI0/1Oy9j6X+K+kTOp/94bq4KyvuEeM23HR9urKctg
 7h+z+ms20MPVSd0waZXOO9S5pxt5CQoKvQWnSzDTQGUwbw/Q1osaScWNEvxwFaIw8Is6zOXn1Ga
 OSqZO8VAxY3CvZ8tHK7a0yICHRWI9+upPWrDhQnhGfYnbkcqck6z+X6ZeJ70Ngf21sA5IyvGRu6
 NjCq/PjD7NZ030P8+bJMQsWp9VhGGLBnceFl4V6nMTF8Lwgq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

From: Kurt Borja <kuurtb@gmail.com>

Some ADCs incorporate burn-out current sources that provide current to
the channel's input pins for open-circuit or short-circuit detection.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v2 changes (compared to Kurt's RFC v2):
* Changed units from microamps to nanoamps to fit known devices.
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 860601ec5334..9ec1f447b565 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -101,6 +101,12 @@ properties:
       sources. The index in the array corresponds to the same index in the
       excitation-channels array.
 
+  burn-out-current-nanoamp:
+    maxItems: 1
+    description:
+      Burn-out current sources provide current to the channel's input pins for
+      open-circuit or short-circuit detection.
+
 anyOf:
   - oneOf:
       - required:

-- 
2.43.0

