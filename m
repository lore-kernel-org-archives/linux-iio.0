Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBA332903
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770756405; cv=none; b=g+a37e4v9WFSajUM+K/nRnV3nAPCMqeeeQVtJYU/a4Vl3kwxmhx1QY0C6GVnW4CBsTbX2qZIAObNsjfpBG5pA3OUTYrreiEjQbAf5WZoIdDtAa18cnzpjupwPNmhGqTsHhb2uwgdtdKjcpl9jo2L1Wgot4gFVRQFvdrphsJOkcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770756405; c=relaxed/simple;
	bh=lazVxl8WJKg/jltTmr7HFjMBJRcsa2eV7m49E9VAdAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=quwg5YO9EF726GV6gH9p9PtNOyWXtjaJTG3kcCPw5meGXNv4uGf14yuAP+EFpYDbr3VXpSHbyoLeCj01wueM6c4F7y7kmxeKJ4Jffo7/aqMn1qqe+0Z11GaO0QJ6z3jhsQJ5cQOkNzdm8g1irzRkjyX0n35jxLklaqOyQLSxoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mp01AMXc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mp01AMXc"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so50411945e9.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 12:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770756403; x=1771361203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiO+nVc5IO8Z6Ent3/Ayytw2yL90H0wfU2AM1rR7mW8=;
        b=mp01AMXcKR10K0OhAWfgwPK1bDdtge5Degg31vKzuO3SocUaPCZPWximJKT/itRnHX
         NztSwcB2vF+lQUiNVKGQ7rdEH/RQFGCdc/1Hl5IlsQC20/+l9xfIMhBwUDz6mnEjDwPu
         xdTfYW5JOwXCaZUVrxpFC/AYXEMv1L5XOnKuH13X5dygs4dvTPR5ojpD44xj680CtwDj
         xG6Y+jmWsDpYQ9CyqBxJPY/K24HL0lWKCz3duOHchJK5bvtkiZjJKHJ96dWLenSYq9CL
         gSDzYJKRbiyXn9R0d7dUqTROxoMQlrTknwzkSYWGgm8G9GKI5//6YiRMiryfTMvwvcD7
         Fb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770756403; x=1771361203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OiO+nVc5IO8Z6Ent3/Ayytw2yL90H0wfU2AM1rR7mW8=;
        b=opFChXvFmXDylMp5j20GbTUSsbfNJRiTlqMkUH8GTQzA+AwV3k2rF2+GGc24bIWQxq
         OhLj59irwpAxEY0PaU1FvwHEaZ41bYvpVP/sNngdx9FJspE7Pm5LeAaWwDdHJeSW/2Um
         WHYcPbLG6x9bj1J/6FyGv/RsCoZHRZKxahgU8KpbDPX9kJ8XVEQZYFnxfoTPW3qpO6jX
         B3Vnf9hT5n+bCVFtPGkH8kdQ3pSz0X6o1ApqeceGD685M0c8m5XY0XhGDC3vkm4nGfnf
         ihLJNsWDdRYRJGkYDbV0qxGsDqQPknUE7OjfQl6NI7ATshm9jAQM5Q7QDb5Zsqq9v1NZ
         CMCw==
X-Gm-Message-State: AOJu0Yx5GiZFE+ng4FNXMb2+kqhX0xwdqbzMdfYLgbDqbeGOxdQCbgLt
	ATJWP2LEQyjiVGmPfNaLnC24LiETYPtR5Gjcj/sWmfAHi9vFqSbcjfea
X-Gm-Gg: AZuq6aKTec/0i6dG66U7gZpGh9z2FRQU2zHSssgsntLV+LePOeSi9ios480j0rvBby3
	M1nJE9MTBLvub5hE4pRvWmjZhCGuDAOpuQ4U0K9Pr1ZdYaFcObLUmkQFuQTSOds+JQ9QSn5ikY3
	AoBQW4pp/8WFzgEFUVrRxM1Y/DoZUBZ4eLdRtp7wIRjVbThkaz3nbVhRP3ylhSpXNew4euvJ/IA
	XQWAkZgniiX8rPSOhetqtdlrxUSaP1y35QTfYd6QPrcxFKX4rtVqTNnXUKbIREtvToHdA3ihtpP
	5A3k8qrrZX39etk5lyA/EqMLqaOqA11U83QMiMcleltJsCzTZTEaeljnuh4V2avhWjw/DdfSs8a
	pGcvVpuUxGOwLRx37nM12q6g9d5xIeMfVy7YCw0A8VykbP1J0Xg1TGvgCzH6VATPaJ7H63h1b6s
	Hkrs/UmTvyzQdn6od6xw6etbc8l0YnYNdUozDa
X-Received: by 2002:a05:600c:548d:b0:480:4b59:9327 with SMTP id 5b1f17b1804b1-483507d0344mr48000965e9.1.1770756402734;
        Tue, 10 Feb 2026 12:46:42 -0800 (PST)
Received: from [192.168.8.10] ([2a00:f502:160:28bc:a26c:adcb:8da8:2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d7d6f3esm71451965e9.9.2026.02.10.12.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 12:46:42 -0800 (PST)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Tue, 10 Feb 2026 22:46:10 +0200
Subject: [PATCH 1/2] dt-bindings: iio: light: vcnl4000: add Capella CM36686
 and CM36672P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-cm36686-v1-1-aef68dd46ad4@gmail.com>
References: <20260210-cm36686-v1-0-aef68dd46ad4@gmail.com>
In-Reply-To: <20260210-cm36686-v1-0-aef68dd46ad4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Capella CM36686 is an ambient light and proximity sensor developed by
Capella Microsystems, now a subsidiary of Vishay Intertechnology Inc. It
has an I2C address of 0x60 and is fully compatible with an existing
driver for VCNL4040. Capella CM36672P is a proximity-only sensor that
is fully compatible with CM36686, and therefore with VCNL4040. Add
compatibles for cm36672p and cm36686, with a fallback for cm36686 of
vcnl4040.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml  | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
index 4d1a225e8868..2ba4d5de4ec4 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
@@ -18,12 +18,17 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - vishay,vcnl4000
-      - vishay,vcnl4010
-      - vishay,vcnl4020
-      - vishay,vcnl4040
-      - vishay,vcnl4200
+    oneOf:
+      - enum:
+          - capella,cm36672p
+          - vishay,vcnl4000
+          - vishay,vcnl4010
+          - vishay,vcnl4020
+          - vishay,vcnl4040
+          - vishay,vcnl4200
+      - items:
+          - const: capella,cm36686
+          - const: vishay,vcnl4040
 
   interrupts:
     maxItems: 1

-- 
2.53.0

