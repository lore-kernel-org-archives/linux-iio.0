Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993D431E76
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071360; cv=none; b=nWG49+zfGYT79j9oi77PI67uvIJJcjljOW/5TeU3OfBJoSQPr9PbwcLC5HjR8aZVRuxijssadvtO80R/b2j6YT5nryLEZ++86ZJnEOcGFn0yxKlzX5kkRoaAnSoSezGTAKkselRQbgcJPdg3Q8BZbJjgJ5v0oP4jlGfoJvcpQAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071360; c=relaxed/simple;
	bh=s5we3EIogjcFMVGpKBg1jRISXbFhD/6aQFi9zxu63xk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLJ8qZ62ZQqTiDaDyD0JUZu1sRFI/Y9IUMMIleuBlfCpYF6SC7NBVbEOrAexVH0eHpqz2SyGXpiPrqcSkCv7uz8KNKcQB2e9gb8hUcObBxXH+DqgpTHhupKwL3MnNxctq1RHKL3KPmqLM3G0uB84JDnholByDMKQ4r1BLxA9Uks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hR7QyeFf; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hR7QyeFf"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43cce34c881so865874fac.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 16:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784071350; x=1784676150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CnM6cAp2TMWm35jXNIN+b+Kb6RD7lXwbzaZa1hCMfZM=;
        b=hR7QyeFfSmQl06iJcTPcVEhnWcxebJlISnShMVNXxKC7EiRu7wNeNUx1I1BTOc13am
         ci4dQeXi/IUaiZpe9GGodPVZCiwqWEJyPpjWLSjKIBYXBWQZ7MLuf42LKAxcvZ9/AHOy
         iQkTzq3Cd5tvDj672jqrsRdtHS5PAav6QJzZNOjTOiiupujS2ESzkGNltWr4Ml47VRQ4
         PkUQxNdaj2sxkiKyxxunX1ge5baLGHhHGp0Fb991Dg97fsP38tp7O9S+wdoUbgE5BLo4
         kNVKdFhcZd8CrNvQjpzGjbmnnXJHqXlJOwsDc4m4iawHVUYBVwedlPjj/7WOkiEotpyo
         AGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784071350; x=1784676150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnM6cAp2TMWm35jXNIN+b+Kb6RD7lXwbzaZa1hCMfZM=;
        b=BTg0Cdu1OrfKW9hnDIuV0BCTm9sWXRY5aAUIp5ycZ+0Wv0P/ityysu1wTtmqoIL10Z
         PMELEPocjkaZQOeFovjEnBqBbp0f1IASeAsPyOavL4R35DVLITi4YgOLSYOJR1uPSCme
         3wM1vkD4Uyx+EQJePjhpgNLGmGQvya8R6xS9Q+FWps0WJNnFqXgsPLKSBiZNGFFFgJLC
         dGKnUzZwA6G1aF1wJmIrfMALVQOPBSdhF53EBnx3Ml3uehgCnCJnE03WYkjqv1OVjS9d
         PSCq4kwcT+aQpYtb1b7vN2kwv5hEuBVikLvjmDiUJDtdmT5eYSXuhEyKH3yaGG1nu3kT
         ww2w==
X-Forwarded-Encrypted: i=1; AFNElJ+vn+P+x/623GlqCWVpW5YvBAV5LNAx7Us6Cf+cWqqWS1oJheLq5KN9pnjRmzodSX3GcjLMbMWHwAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa8W0HCNuCnOkIzf6B/RiIvuwyGYKt7DVsG0h56/40NZz4Td/7
	1yGhnhI3e04W+7rhOIrcIT/x+bxgBEGMp2Q4WJPn+bUEJOHqSIb2wGNs3VJzX4lceE8=
X-Gm-Gg: AfdE7ck5zJxy+bc1aHvN0FDkxPbBNOtHjjUQw7U4HFlcBis2MvXXUEqWvPKtxa0w2Fy
	YbwNUPB8YiuxBoonjtA2gFmO2BR9O5Q64WBq9qptzXIaYBDX7gojWiwQ4qwkfFGE5jMYoadPRyf
	JFLN048G0K37tPmg79B2hqdAd1KDEMoTcO6eQyyymw5OxQDHqxE/ftgutAISYN8aqExFjpcFiSO
	vOIqnIAu48991UvvZtuL7WOn6aOX1qPxQJdxe4dOhpJ65DTBbTieSxX5c8/86Cp+DNrqY/9shyg
	kCF3O8Waet6O8+iMCMyGXbi5AEyB6n75ffhytEHrLSSavFbrEnlzuluAX374XvSQc3aDIeAmvyI
	qyRZYoagZhUmKUaSiXyGiNAe7TsoOkWpKdnqh/7lXYXNhnAOGANOxB5lBJCAaJ6NwnsMiDZaXjA
	4ORTcr/SPuWVfy7FHAuQ==
X-Received: by 2002:a05:6820:3102:b0:6a1:5cd7:226f with SMTP id 006d021491bc7-6a39a860e27mr9369359eaf.66.1784071350459;
        Tue, 14 Jul 2026 16:22:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a39af0e953sm7561978eaf.3.2026.07.14.16.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 16:22:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 14 Jul 2026 18:21:23 -0500
Subject: [PATCH v4 1/8] dt-bindings: iio: adc: Add reference-sources
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-iio-adc-ti-ads122c14-v4-1-25f8e3084485@baylibre.com>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=gnJcOpkZvI6QrZ8vVSRd8XUtUDqGn+U84NE4BPUS78o=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqVsR9/capx2PP3w4wNGfR/Bc1DLXlx+TQflrix
 6Lemmt6mMuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalbEfQAKCRDCzCAB/wGP
 wFGfB/9UhTU+DhxboN7kD6yBq+l+yMfqE1SWEPDhrm0JzrxF8xviVxhS6l2kXD/dhJVpoY1IDI7
 noGG9iITPJgS5wzUW4u4w2o8SdiKUiwkoNZXipYoR1UMo4QfwdEA8n8e8odJPW4uzzBiUutDdav
 sNiZTUV6oeiWdcsF94Zl2pJjftgtvvOPLMB/i6nato9E5Qq9cyVUYjQcWbe+hnE2IdaOtEScYjr
 EvGuR6e+AOvYaLG2oFDAzF4mBwoG6c1+4CJjFz4YKcDpKDbR7Dj/+D+T3H4yx955qPC52JZMZDT
 ptiDTvK+aG7xqGpv/ABMhTE2TUJu2FlE+GaqQIRd7UQb3Wk9
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

From: Kurt Borja <kuurtb@gmail.com>

Some ADCs have configurable voltage reference sources for each channel.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v3 changes:
* Removed minItems.

v2 changes (compared to Kurt's RFC v2):
* Drop maxItems.
* Drop 2nd paragraph of description.
* Make reference-sources plural since it is an array.
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index b9bc02b5b07a..8f608bf0b24d 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -73,6 +73,13 @@ properties:
       device design and can interact with other characteristics such as
       settling time.
 
+  reference-sources:
+    $ref: /schemas/types.yaml#/definitions/string-array
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

