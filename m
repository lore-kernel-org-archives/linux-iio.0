Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EDD369204
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782424571; cv=none; b=Kc7V+om95MhDHeYmXHjA8mu32WLbN9wV1kQeH+lkxorWmtGsdE9LX7vPAF/7w0DSGn1FeO3H55B55Ojr6nu16M0MhFIYMmokNfxossBsoL3hI8GgwmxqoUjbpv1wLnVnAmjcAciPSKr2qczl0P8xtThjf1Mp8D+GuruF4kAS/KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782424571; c=relaxed/simple;
	bh=lukM+Wf3ULNqjeyOPZiPJXnxhdqiCx8ZwaqvGu1DSUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bv4smuV/cgtojlzuyPmbgi4jDQG2rwPM8tePfxXeUyDdiqo309W4tHqh4cK6NwHANbhXCH84/8RXk3uimZUpihMjYZWFqygUKcyowID0ByPZFeLdiykUGZga7a+ijcx/VGdqaUeLLCy9V0W3rWbhd/NAaW254MZoC6ZpsZhm1xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Q8wNSTkD; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Q8wNSTkD"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6d37b7098so329727a34.0
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782424569; x=1783029369; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PyOiPMSqrkJp0SvXAGsNdlFr3/6yaTMdBW/g1Kb1HrM=;
        b=Q8wNSTkD7eY3IhECfr7tNk8OSp4qD1Y3fh4h0jxz59NiaAg0H6Hmk6+9kYDlDnortC
         fZ7Olrd43mWov+PmNOhsHCFq/qxXShLiGvqEU1VRnvFd10KeLK4/pPzW0NbnB+vQDDSz
         OlCr6Asgix24zQgn3XH/q8dJ9zizqVQsBlJQ+jynWAXuDB7qG9Z/SdO3Mlms+I83AKDc
         EaeWLPMjvLqZUUeIPnvh13ehQiHfsoPToj4GSB8qkanU6icMzA1/dJDG5wqpWmgeMz17
         yRn4QzMZ5cNaStom3IHkpgqSr5T+s09wH6Kc4oNzdlqLgKt51rEhZdYQ4f46Fdj8lNCh
         U5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782424569; x=1783029369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PyOiPMSqrkJp0SvXAGsNdlFr3/6yaTMdBW/g1Kb1HrM=;
        b=X7u5D77Yc9X3BWj7A5qUqMQpNj6URlRvaoEQzGpyxEDrawPzBV9FQMODxcHqck76aq
         kE/ZydDdCUYovYgEIXQlzlEZg5I6500Gqdx3UBm2tPJqlPt4Xm0F83EZNlCEvNbdBpNf
         dazuK7UnTpDXx4UoWv5Qxh6k0/6AjUKlucwehxqV4r3iE5WaGdBmdlzlplqemIM8ITje
         /AUcDTHwvtoE1voOk9Ja6EMn6oD+8a/xihbAoXHlHavpuxEPmf/HS8yZDrN9bEw7xOoE
         c01Hd4D8wkIy/xkxv+nPxxn6c+o9kO1H/ycIzEQRo+kdTqggJxYmlj+iGw+O08IVrCLi
         nstw==
X-Forwarded-Encrypted: i=1; AFNElJ8A+unn5vhqngqXzjLSMNJ6hblu1eqVuWiZTKVBzWVy1Q/2jdDgs7JVV1zyK88rzWatBOi/RfQGSYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyywBmK5kP8zRZQS27ErXwd/mFyhbxH0ppQo2jwlJG/fxKYQ2E
	TgrH72u4Q0RydhawBHMo/WATCpuwKzb9aNLkD8v6V4nzXv26dftOrk1IbRDINB2NQWA=
X-Gm-Gg: AfdE7cmgjO9N+tyHUj9DAC41dLbOpKRUbXZ1ljL+RE49B1J4+BbBgLVgbIQ5ikKGpJp
	XgYHOQLF9H5wFwGxDuC3ds7WwkRYQmSM9xYD3jG+YVBaVIURZnkuJxgNApyWBSKHSMFGcMxZTX7
	S1+sKehauFD5O2e9NVI1moRGa174ex0ZuXWAkcjMXFxziqqM2XoIaiWnIHZFecRttOaxBr9/o01
	5t2ZcWJsYkw7Be40cOWDMXCmLZmWIDecketRJXJqEoqiZSN0L3ARYRKBEpmmwofpouX38NlgF96
	ekiRrOxLcbrLcMnmfvCvqS13jQ8XEdHJrK+RcJlz5dzdSxxzKJV63QZY7W7iIwpXN373sp73ixB
	c5LFye4ZaRkGUzjdvUm9DKSkmzcbMorsFRwMj//jGAmJoTgeFRyY+3iDk2T5COx5PdBACfPE8ST
	mFFQ/wXm3r/+xUsP7NnQ==
X-Received: by 2002:a05:6830:d8d:b0:7e6:e022:4b44 with SMTP id 46e09a7af769-7e99c35cd63mr4393078a34.15.1782424568999;
        Thu, 25 Jun 2026 14:56:08 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:f1f0:2d9f:2f31:3426])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9aa5e575csm206058a34.11.2026.06.25.14.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:56:08 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 25 Jun 2026 16:55:03 -0500
Subject: [PATCH v2 1/8] dt-bindings: iio: adc: Add reference-sources
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-iio-adc-ti-ads122c14-v2-1-ceb9b0b561cb@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=wmC3rJ2+hVY+xkwcr3Oj3oblZhpD5wKRDtYOppYjMJk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqPaPBVwHC9uxAfS3Z9dlUYFpH2YcG8vzKsueZx
 jLB7NBYd0+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaj2jwQAKCRDCzCAB/wGP
 wHauB/9QYJzzP5Uw60OzbEFeRNEc/q/Yt005k2r/vFHeoHV2LEoa/WO+bS7mgOLjusSpLZUAh5R
 gGPQxZ7xQwNY223kbuPEAk+jjZTaf2XvFNbBw4dmSe1JqnHtLKrqYuQoAVEa4L4eWmM/WJC9d5j
 T4S3s3oXyP+537D6CYSPsSfC+RPuFOJf0vkVUZmZZsdOrKPnYpjBt7nP1iAh9oK+uK4MYDei5vP
 1FLavbpRqeensxKBf3GcRFmX0u2+e8l6VjyTwg9FcmDR/jYEmEmJQOG/l+OF/bhaVizCoIriRE5
 OwBalPtB8t1qNCaxrY+04aUPrUfMWYujBzpo3N3oqJbe7j7U
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

From: Kurt Borja <kuurtb@gmail.com>

Some ADCs have configurable voltage reference sources for each channel.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v2 changes (compared to Kurt's RFC v2):
* Drop maxItems.
* Drop 2nd paragraph of description.
* Make reference-sources plural since it is an array.
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index b9bc02b5b07a..12800737d4fb 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -73,6 +73,14 @@ properties:
       device design and can interact with other characteristics such as
       settling time.
 
+  reference-sources:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    minItems: 1
+    description:
+      Indicates the voltage reference source or sources for this channel. Some
+      ADCs usually allow choosing between internal reference sources or a pair
+      of external pins.
+
 anyOf:
   - oneOf:
       - required:

-- 
2.43.0

