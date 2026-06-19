Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D87C221275
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 00:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829199; cv=none; b=jRZKp1rqFjvQnOTAbganag/A58KHggxOCrgcwJBqM3MfQCBtjkxf9alk721HtUFbEYyUsN/I+JiQBHbmajeIKSW8kz0W4dlkuFfAQEkGvd0KrjFsKrSBfmgNgninf7RgYiBvNXXuxZpIoIFlHLe6mMbw3IQPVFBJua4ZofiyHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829199; c=relaxed/simple;
	bh=93B9LNByWqbkUcw8YTfLFyLPF/gQuktYnvqvIQkd918=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVG8K3sZJQqZvoiNM1Yf5rVs2N3G61uEsrczrxYTwcswC2USrswB8QMqOFw01wSD0+EYe857kNtzdNV7OMUEOeZkUwBhuW5qZZavhX88eo6PnuNrbGGnGW8vIzrxADWIJKrq4BSuNlIRrsHE8uvt/dqf0HWpw73DZetz7ygWvDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaQ3Ck/K; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaQ3Ck/K"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-59ecd51117dso1277228e0c.1
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 17:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781829197; x=1782433997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwHM3FchbyVBWBrJlS5o6K8hKzhNV74Xb5lNC7TOpR8=;
        b=UaQ3Ck/KoeuAKBfDToJweXgEyei1sU63reLIxFH+lNTND0mb+9ogMeP3cyvGA9xuV7
         u/hRxlaFzu9MRPRz/OMKXE/INhsKUpI4kiGSm9sQV+Cp/vM/G1NEhl5WzsGSXWqYNwHV
         ohcViDrntNVjSoSL4d9hkL41zroBQYpLbtqYBNFNApBov2NSpYXSAvws8GZkS7pa9zvV
         IWetBovajWPPub8m3YVRA1ryZoaEhjXSDUmpbHh3OhMGToXuRzQhbdkY8UJW84BcyNJT
         qqegCbJRi/2TH9n+CcA0V4r1m0o0R37TEUaoZLlk1NZXvagpask1WrShhz0WzvRJzb9K
         wVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781829197; x=1782433997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MwHM3FchbyVBWBrJlS5o6K8hKzhNV74Xb5lNC7TOpR8=;
        b=TX0TRkVYzCziPPSAytKGv4+3qpXrF5okdlG661wcJjYt0apVL9HLY6PI2EcU/4tRum
         PgYheK1UcE++5cCB5b8xL7lTnvCM9uuH000UDFqECDnou/5EYIDJr2DQy2bXN0FUOjJb
         fQdcmNabCDq/LXh10+R6vcxQQzAfVa0tfmf+LD6wuiirIL9Rw9iVCmcBATLxTwaPMlpV
         QFYKa6wLN6Rd/xJdEF8d5Ddio3pRIqrDlJegFKKpAUx1I4Lupe3aOGhkdZ7WzGxGbB2v
         6kow9auqBkCvx5LrqtG/l/HHFdjPpObbzKJfkCZ8h9IeTwPgLoyyl/nymf0AYFf9COOS
         /Y3A==
X-Forwarded-Encrypted: i=1; AFNElJ8+86HmIICrwgViCsKQIPBPhwk8DkKjYTa9ylWC98wHONalGXzCbNI/DwPu1k5yu7WdVjnowEvDXDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhW7ITO9/40JzfoCE8xPFjsa8Pmc4ZDwSUo9niRaKdzvQzJAgU
	RZE5Ufd1P5+/jUahFoASUzf6EH3Srnkq13j5MgrFFEOhvfSllA/fw4p9
X-Gm-Gg: AfdE7cmVb//97hjJFkrXZ/ZhGyPD0IiRz0zs5HGzML7OjInOtEzZKhTqTplkYLyFivr
	pd/mN7//2l+vVQ8pvnLja28O1x+4J39dyvwx8j/VtAfKLfmWKbd2LTTKXXiizv1iYe7zdT7KHfZ
	auVs7DCXZLpjG11A3/pkx1P4HbRP2HdXEwjmFAY6zBh8cNnnLMz7u016BbpexgWcYDkx+2KmXAu
	hNV+pLuwIkIq+6QWkHYmDt8CHLpmT1rtvY1tNlUrDcafQhX30aHSf8bGaePFejQhYtL11+mDTFx
	HwJSLqFI1KVs0JNT+DN3NlMs64x58eRJFSVzqWTGj9iJx7ZHEsrIRskbEZ6CZx6X4zf08j583Hk
	QHAZVSBakGttTACVCtq3Lc8+vyL4Y9Uqw/cZ4glQQi7ZrzbL8eJ3YaNuztUPci461Edb3f4LGRx
	uhizZPJJ74C6WRLuo=
X-Received: by 2002:a05:6123:2e3:b0:56f:696a:4fec with SMTP id 71dfb90a1353d-5bbeb0b594bmr649894e0c.5.1781829197406;
        Thu, 18 Jun 2026 17:33:17 -0700 (PDT)
Received: from [192.168.100.222] ([2800:bf0:177:563:8f3c:3421:b12:7a09])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbea36b5e6sm861581e0c.9.2026.06.18.17.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 17:33:17 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 18 Jun 2026 19:33:01 -0500
Subject: [PATCH RFC 1/3] dt-bindings: iio: adc: Add reference-source
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-new-channel-props-v1-1-963c1b5cf40a@gmail.com>
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
In-Reply-To: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1033; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=93B9LNByWqbkUcw8YTfLFyLPF/gQuktYnvqvIQkd918=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkmfZ66+gp/+dgXy3NYP1UVmm4gHvb/1KWTfgw8Qu13H
 Hu70jI6SlkYxLgYZMUUWdoTFn17FJX31u9A6H2YOaxMIEMYuDgFYCJ8+xgZfqZsmv132cw6kca8
 +FbNqbaC3CKzxdNmzNV5/Lrq3ptTigz/s496mLD6NYY+Yq/V8r70aPmHA5YTnfRFg6YlfzhhvUm
 QFwA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Some ADCs have configurable voltage reference sources for each channel.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index b9bc02b5b07a4c..c74c2084fdb68c 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -73,6 +73,16 @@ properties:
       device design and can interact with other characteristics such as
       settling time.
 
+  reference-source:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 2
+    minItems: 1
+    description:
+      Indicates the voltage reference source or sources for this channel.
+
+      This array describes either a single reference source or a positive and
+      negative reference sources.
+
 anyOf:
   - oneOf:
       - required:

-- 
2.54.0

