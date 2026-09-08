Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA345AA696
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895265; cv=none; b=BT5Oa1H4XjNtV+sIu2sWSZHxjEJx05mUbamAlXPe3j1oZ6srfQAzPJ19sKa9ziJKGPvgQBGwE1aC01Yd8UYiatUmPTBTvSRwLIe1qY7VjxS7un++8Hyb6s00Gzl84/PdBrYAGrcFhYo/Mirz9oxvGM7jk+K0w1Q02SvC+pwki8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895265; c=relaxed/simple;
	bh=6A1+E/vOD7X29NvY+oVvPlZs2BNXNhPpx7MgYd5DIlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i6QeCbeMqpIr5vt/JhVXDCsk0IvegnEDRNi76wglNycE12IQoHinXRa63DtH3977v8Ah3gpkji8Y76klLW3UqNPLB4oU6t2NHXcacbOfwMZ44S0wCcq8rPvSyDeosGtkgQgYx/JdfsNpbiR9L8JxMrZhq5CzknvQ8hR4wVRISWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWHzRgJp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWHzRgJp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49ccfbe062eso48689685e9.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 12:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788895257; x=1789500057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+C2znoDc6QFtOLilfHto1MLA/C5JcF5zobRDR2Fyfh8=;
        b=BWHzRgJpnXvqYctyVfmeiQqdbiWdgKdoqxOGd9+3Z8OoOw/WgXgqoTHwGxfHsTkxpl
         5mX8Ds6ePsh4E7z2JLX28v7HiMvIycEN610oM6IJclOx3MRiUFmd249iqJJh0rZeR2zY
         vsa0ZJzqozus1LSaiPShqIV6yS+hOHgULU9R3KnVmQR4ey3nY1hiNDWa76aFHw2oETH/
         YzTs1WCzUBFdarLLju8/BpDSCREfFoGsebF4vFDWPyWt27IDACJVjOXts7UJAXWR9jAd
         XzZJJJdHagLQz2jsSRJ2hwmCzmH2nEeT8QrXcPiE5JAwrZBEFJvg+8DUe8XTpmAhjvUp
         boeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788895257; x=1789500057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+C2znoDc6QFtOLilfHto1MLA/C5JcF5zobRDR2Fyfh8=;
        b=T6baVA2uNusnzygBkiSvtTR4yZQyVS/GL/V/+lPbSLRbLzI/R/r0hmvUmu5fBGFEBb
         Sy9bkjPPzQKNYh4OuDLPzEe3AMe8dWTCbU5JC3iANmBN9skKKLeDQJGunE9dttuR0Qaj
         OTezCejKIdaX1CWExYRxVy09t7cH7sJYuSjLav6HXFq8rg9nqvAMg7HiJOwA4N2qLDwB
         Fq62j+xQWRaTPqNiBTJMRTb/Lkv6loZXUBbziXKarA4yBqWB4MmhBlDWoZ5DdzFo6TyM
         AusZ/RwMmwVSzSI/RN0WEXPK+INzpM8NByzr9PyM0cVwUn2/yyZ2/sbpXETV0AAhpXeq
         caFA==
X-Forwarded-Encrypted: i=1; AKwUvBz5by0+OJU4RZUrlA32pgo32GNd67z2cgBO9UcNEC1vnCNC4OwWAJaDVvvc6nNpU3ojYLvj6IncVN0=@vger.kernel.org
X-Gm-Message-State: AFuF++k3hijDWuqkM40o3NjC3mh4rysS+QBM/Mku3HhbaJNpU8GLDDZi
	/WG/GxgKeyg3pNLmlPBOG2XDcQPNrqXnHilfiv1VWqopVL6+6aO9j3UA
X-Gm-Gg: AYBFou2hIeI8RDUWwVCp9Hg5QTjVmzGy+CJohFV8J2A4e7QA2If2rgDwQIdqxikVFoF
	lwbuSVKrI0bCU4NnkAf3i3ihbCweNK/5+4YCVBkGtbk4yq51yZNmY3Wct41a8cxUWMry76h8b6f
	DiXTjT6XxDVjYQunQDk9r2llmsdnr+DKSOKn2SCPwbony5RuJE9mqXZES6jMeOpF23KLPlV79aa
	OkP8YWUAXIoivkiyvMT6KKqniJibEZDbVKLLzfLZUzXXi3D+mgi/TyRKu61ToJ1XkMYxCp0hGgl
	8IXm1VN2GrHIHn0VWFg7E0JAvZtGIb1FpMU6L3qR6e6UXHElYsJcCxVxv0XJgFfBuz5+SPeWmV9
	0qVsfHfvRvUWIQBmIgMHTC6Ol04zbblzHH//G6R2R1sV8PsfHJ7hJDyGAYdNnaTCFspbgaLhHNL
	MKJbOR6QaatGEk/9x0eE3yg4AYaZJLZARX3Ld7MCvkqLMkj/9CiaidbncoDsotH+QUAfWUtEBH+
	BXPFtFgVFlc0Ei4VuX8ELGTE4yv+nrI1g5m9iEDIQ==
X-Received: by 2002:a05:600c:3495:b0:49c:dadb:18a7 with SMTP id 5b1f17b1804b1-49cf8244260mr314855325e9.10.1788895257060;
        Tue, 08 Sep 2026 12:20:57 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([93.122.248.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf770fcf5sm407885845e9.6.2026.09.08.12.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 12:20:56 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/2] dt-bindings: iio: adc: ti,ads1015: Add label property
Date: Tue,  8 Sep 2026 22:20:35 +0300
Message-ID: <20260908192036.8503-2-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908192036.8503-1-flaviu.nistor@gmail.com>
References: <20260908192036.8503-1-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for an optional label property per channel similar to other ADC
chips. This allows assigning distinct names for each channel which can
match the schematic signal name.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
index 718f633c6e04..777a75c21d7f 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
@@ -66,6 +66,11 @@ patternProperties:
           - minimum: 0
             maximum: 7
 
+      label:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          A descriptive name for this channel, like "vcc_ram" or "CH3".
+
       ti,gain:
         $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
@@ -125,6 +130,7 @@ examples:
                 reg = <4>;
                 ti,gain = <3>;
                 ti,datarate = <5>;
+                label = "CH3";
             };
         };
     };
-- 
2.34.1

