Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDF40911B
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 22:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723920; cv=none; b=uMqZn0tq53QAP9qXSQwvslX5yOFh6sFiw//be6b5yIo/yKY4/SsKBBhR7wxIJLyHMnfRvAacfdQ7J7pSxxbWEd1Oiui4Awpzq3XUCBXUixHY3q4W4i4QhA5tBf6nonf6z16ytoE6MPH4Osk5Ml/nUFGfWXt8hM30A5QMtI0ylhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723920; c=relaxed/simple;
	bh=tchtM/CNKCBh2VwCFZzbvRMHZi9l1Wj4nPv3JCL1bBg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rdXnznP88/geQiiOOdcjESy291h5T0/K6ljuSSY6xj55shmW3xvClU87mgz3YNbC2S3WDXpwt4Z3F/EKJ5KQb49SFcnuMOISAXhP/imjZvScrIGmU8QKgHLg8wQPUj2Q3sv7Yaoy7aPphJX2MeqSC2GwdL5u+/iMqKn6U92dOK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=AhxcK4im; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="AhxcK4im"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9f6b94a49so681142a34.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783723914; x=1784328714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=chR5rfZ5te5oi7PbKdpDkka/ehfZRp7YJnxIOLW27BU=;
        b=AhxcK4imrGLyHeoeMxQNjiNVtQXhSxr2bbFWw6pPB45tr0RaXnYVPb7cML4Tt61QWT
         PZHNmr8S/ct3F/Kws/Q02/lUAr0Ml4luUfimuEJP0m2QDZneCQp3hAL5a4psKYJhVhS2
         iob8SBidQb67EIjksDcRjMiM1kJMSpI+sat1ON5zt4XvO8Bt6tQjU/tFoCBs6D+Unq5v
         6RWzzpSBmbmHGxNliwwdNIiwYsWPMIDpqsegu8cfxfpQoOD7pcup7VRN/5DbJ9fvkydW
         uPyYS63JOit27/56PWNDn6v+3xzMP9SzHIiu6VRjRH3C/+tI3VAxRSg1onVUgaT914Mu
         o3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723914; x=1784328714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=chR5rfZ5te5oi7PbKdpDkka/ehfZRp7YJnxIOLW27BU=;
        b=LioGDF9xO9ornp9nlgtPfB6JiagFC4X2t2AUoCIB2tJvO0cdLlrkJQAZus0UrFqwHt
         sfqLXZVqzSemv/JnN3MyKZqFZKjkgk7sXUaNovIm3FmU4UfEZw8ROkbExGr2mz4wyuc7
         wUHVAaKtDMutpz0DEi27EFC3u3av8oKaSfksFXd0uEhyPWG0UBEAdJv7gKdP2YicSrMK
         9dzDtLpszQF4FuQcilFjISe4mfnofSVCPeNnQokc+Ui/rhH8Wc9rZU/wEWER2JZlmD+q
         pJnf2n555uKw9diHRoQCWpjWz4SxpZjSC8mLri09AIG3uqzpJOe4JfrQIYALs2AUnPZZ
         MGaA==
X-Forwarded-Encrypted: i=1; AFNElJ+3ensG7GPb1lmmKRgyiGgFA8c9ZmBzPkgtb/zeWh/HUiTMSgEcwaWzpyRAal4Q9ADfKLTxaYsyhq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBm6FM4M1jYeipXrNm5UYh3GQXFqPyThMhQuFukLLfn1MXdsjx
	xONPI05gsBjIl41jhAKZGUFRUdqMhpflfCG+VNzvZb18cHyvpwbFp/K8WgwidkqfavA=
X-Gm-Gg: AfdE7cnOwF/+JG0qPMBF/eeGzloWqI161NlsMHDDRoNcUn//klosHkLG5TodCknWXq8
	MiN1Fs1mzVT9d/OXDRukXOCJY9x6PXV//yQ2i8Eb4yL97GKYuq/NZUMHBGo/ZfLj2ya7FGwrUo9
	JAVG/37q6AHPl4DZ51SypxtM3JeOYm0cQPR3rtFr8fSPD8jVdNsNWDIkJZYyYiZ+QUmVPWs6U+d
	4Xw+pk39Zb/mvgByp4OUcZtTk4p+KV0oS2tqCbiqXP82nzo6uES5CSXkKBfm313YTab1E6QbWnc
	Ek+9rK+7Ajy/W/9oGFHmXVISxsWHIntNuovgPZyeeps+fkd4QrKS+B4fCzOv0KRXm8yh6/ZjRBP
	0iP02QpaAP2OOwco4IM7HAs0EvtDHsmYgBPgHjl9IYEt32XYdNw5mMAFtWNtm8gie8Mze2boRZ1
	yrkdjfzhcR62dUyRto
X-Received: by 2002:a05:6830:3819:b0:7eb:c792:5091 with SMTP id 46e09a7af769-7ec09951ae1mr421258a34.25.1783723914250;
        Fri, 10 Jul 2026 15:51:54 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm7613512a34.5.2026.07.10.15.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:51:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 17:50:36 -0500
Subject: [PATCH v3 3/8] dt-bindings: iio: adc: Add burn-out current
 properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-iio-adc-ti-ads122c14-v3-3-746d52cbf1d0@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=aK9CNEsNnSq/3fIxqxz+n6avckFsHfmVbhpJrvL/pTM=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGLICyyMZiljkjNU9ulKlmD7X6/dJsNaJ/J23UDhK5z3PZ
 /X/H4w7GY1ZGBi5GGTFFFneSNycl8TXfG3OjYwZMINYmcCmcHEKwEQe7WX/75GRmW8xxaKON+fp
 5mM3Snf3NrYzn3iy7sW5px7/Umy47xSs6RXWYPNIypOdlO3D4mnxSLUkomH+laSg/LhtqxYUpp3
 ob1h99ctjjbgIpdpDgk9qtMteb//p0fO+JiFalVF7n/2/t8t/h2feKkiUj7DLN5QJPutwTEzrxu
 f9dS2SJ/6w8jNIV3POjJ1wX+2n7O32m/tD3BRrau3mydm0pM/O7tnL8PBK5+T40wtcl6jt2imkN
 z8oceMpDwV7xmn7z119esiN9SBPu1jP67sMuSKFktHx+nesDRxOfD7TuN/kjkD6zY/9jef95TbH
 TpBhtTq3jMH04n7FJfv+ml19sZY7U0zlZnmziYZOzFIA
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

From: Kurt Borja <kuurtb@gmail.com>

Some ADCs incorporate burn-out current sources that provide current to
the channel's input pins for open-circuit or short-circuit detection.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v3 changes:
* Removed maxItems.

v2 changes (compared to Kurt's RFC v2):
* Changed units from microamps to nanoamps to fit known devices.
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index a21ed9ae4bab..308857f11220 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -100,6 +100,11 @@ properties:
       sources. The index in the array corresponds to the same index in the
       excitation-channels array.
 
+  burn-out-current-nanoamp:
+    description:
+      Burn-out current sources provide current to the channel's input pins for
+      open-circuit or short-circuit detection.
+
 anyOf:
   - oneOf:
       - required:

-- 
2.43.0

