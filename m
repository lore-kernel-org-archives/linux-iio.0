Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6E23393F
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 00:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829201; cv=none; b=U04wUzvMNEmv9BLjtmMii030KEXddmJsSHLiZ6WdVj/iff6SpIQEiVKXTxvl3sExzamVXp0NsQSIOV0gSkXc/wKas0PeiWOH1KZEIVr2kDnZgKtfs2GGAHCI6tFOyZMDB18ShO+dcuwvvWTnFbpY25OQ/8ECC5iqhOWRNLKzYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829201; c=relaxed/simple;
	bh=+o1IWm3ogx4anjm8wKaVkDQQRpMYjTWor6stuR4Q8HE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lF/0attACf9wkZ1oVRvgSNKbJLDFydKkL5fyvIAc1svXUY8zLJEtgIdo/ty/BX3gC1Uj2S5a+UsEtjq6vlLLsaFfRZj7sqlNcK32wgidEAYiLTU/ygE0spso9LQu86910hrq5oixz0KDla39bNrk1DUqBnlgfPud7kBUhinBt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIUt2vA/; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIUt2vA/"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bbce09791aso489745e0c.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 17:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781829199; x=1782433999; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1PpCHW3MF9RlXP4kf1MhsbG+5YRxmne5CpCTsQxScI=;
        b=lIUt2vA/KxIKD9jIikK/TXeOxBOgUk2/3IirfOcSni8fHKce1XhFzrhJyMwPRuqhP6
         MjRkD5UnDrOggbt1h64pu9ODQo8nsIA+3Qtc1anA/kMTzLVy1/iAhsviidiNSCTzNYRy
         ud536oR8Wsjs9yJrXDB6wnFnZ73xDEb8herIjJk9cNIpR1TT9lI65CYqW+udNArv1utu
         iU131MHTP5PWzFkMMQqzxqNS29dVg9iVfBoC4pvy28+Vdnbja5XHaJcwcKRRDVp0SmlT
         qXUBiUoCIrOpCSqAnkyd5mwtSHacVCxzVEqKcrKX6oNh3P4rO5xn3TM//+S8KsqxPInZ
         vgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781829199; x=1782433999;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K1PpCHW3MF9RlXP4kf1MhsbG+5YRxmne5CpCTsQxScI=;
        b=Zfxkt7XYrw3j/Up1mdeLns71QDce53+nKcisNAjJ3xVrSmu8SQRTxkO6QcVqOps7fP
         3zshCWeNFBsNWVO0ssJPlj4ULxGwBMB41ocJJzBC/v4J6bn+39QJFx1eD4p5aWdCo5Kz
         YdRz0n4qsN16yQwP94bwdeBZLZCczl5K892UwWBBUAn5oEocCC2zH7ijL4DCteq6oBMd
         f9nWdRdc4QNCpFj7qKMXTAv8c728bhEfIT43irn2wapscL7HfLD+2DxizqoC8YW5sL24
         gqzwhYl0Tsjcf5Xo8K9vvmdAYESTw77osgSaN4wN3ruqlh3VKuR7u7gUNycvkwv40ZP/
         K4tQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NY85GsYuvjD90gx22v4DFiiMd9q7/GdVCyHOjHBzPKt5w+xQV9Os6PeBR7NAbbZLnVQWcTbpdoKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLHzExbTxjlO1VsdFMyLfhChjY8wUzkp9SFs2ccEUn/uPc+mSo
	u7YCXvjvYyuRwRTYcqt/oLvfIkBUH9J3SjEnB/PgbCLQgGHL10d8DLal
X-Gm-Gg: AfdE7ckaGZ9evS1B5thcRb7d2iCePCUNbipZwsFKRYpFg4Exk4F4G/vJa8KmvsfVWIT
	4QAC4ep+sXhBkNkU4dNAdrXCZ+46fDd1g4gW7cU2CHXabQ5/TJamIcVCQq92IB/Muq29CaaG9Ee
	llOuWaJ+pBm83XccIm3lVpFSCYVhzUxHtNPdXWvmJ0C8NAO9AsgQT+WTTlMpI15gUfimg+hHw3o
	VPKsxrxZ/fuZOn5ycOoGtPJ4OOv3MjGbGYLJiJoC32i5TWavjJaqUyoEl0R+1UGR/OnmJVAdt02
	vLKU3CJPL2K9GHvVIrB04ytU2nZ+BdsNPchznHOAxG7c39+6K6ZQZ/czK6+AcYfoStmm9bK8WtT
	6pfJRfrsDaFwJ408dQjiV8pps4TbWRFgLGjBubrdQzYl6Dgs/emb1bBcBv07Q08ZjkX/dcYN9Vu
	0Rzuea8Z7gDy8PCiSPhv6aaeE45A==
X-Received: by 2002:a05:6122:6606:b0:56c:d34e:bb1a with SMTP id 71dfb90a1353d-5bbee61a891mr264303e0c.4.1781829199079;
        Thu, 18 Jun 2026 17:33:19 -0700 (PDT)
Received: from [192.168.100.222] ([2800:bf0:177:563:8f3c:3421:b12:7a09])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbea36b5e6sm861581e0c.9.2026.06.18.17.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 17:33:18 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 18 Jun 2026 19:33:02 -0500
Subject: [PATCH RFC 2/3] dt-bindings: iio: adc: Add excitation current
 sources properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-new-channel-props-v1-2-963c1b5cf40a@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=+o1IWm3ogx4anjm8wKaVkDQQRpMYjTWor6stuR4Q8HE=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkmfZ5nf3P8NpKe+mmbbtfT917PHZn3GSgm150KX5Vrq
 7j1r3NdRykLgxgXg6yYIkt7wqJvj6Ly3vodCL0PM4eVCWQIAxenAEwk8wIjwzOZG8vmqCd/mGrh
 vSktxmKFctCpHdo/ZIyWXW3dEbRg73VGhv5tOrUfW/zt7edsNGdXdHoT1nc5/pTiNvZ4Ad2oold
 ZnAA=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Some ADCs incorporate current sources that provide excitation current to
resistive temperature devices (RTDs), thermistors diodes and other
resistive sensors that require constant current biasing.

The maxItems constraint of 16 is arbitrary but should be big enough for
most devices.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index c74c2084fdb68c..106b1e317411d5 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -83,6 +83,29 @@ properties:
       This array describes either a single reference source or a positive and
       negative reference sources.
 
+  excitation-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 16
+    minItems: 1
+    description:
+      Excitation current sources provide current to resistive temperature
+      devices (RTDs), thermistors diodes and other resistive sensors that
+      require constant current biasing.
+
+      This array describes the mux configuration of the excitation current
+      sources.
+
+  excitation-current-microamp:
+    maxItems: 16
+    minItems: 1
+    description:
+      Excitation current sources provide current to resistive temperature
+      devices (RTDs), thermistors diodes and other resistive sensors that
+      require constant current biasing.
+
+      This array describes the current configuration of the excitation current
+      sources or the single matched current for all sources.
+
 anyOf:
   - oneOf:
       - required:

-- 
2.54.0

