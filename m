Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886A728466F
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 02:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774405463; cv=none; b=d7vTosHJYa3r68CsEhrEEJV/r5W0Ijxm9PpKGILufs4hT0jrRRCcef3OajCbUHn/+pgfzBnzXSAT658U4VokA4zWu3JZjoivMgQdPwTwNp+H4ub6TrUmXF4cXVnOFwl88Xc2ZDrko8gjqQf8ry7gSYxl1BuB/vEfbhBM8sUcZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774405463; c=relaxed/simple;
	bh=TvSITG3LE+Bng8Cblqu9isE4WnwGXqZ9Iao1MqgYEdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qi14FEOjp0ytIpccwiysrYX07sBtrdMPPyZ3zt5UHrLjkg7+XomYR4cpse6jxDqK2DJ+i0X+BPPWU4ia6+Vqjgy5/Ur58wwm3DgKrqK17UXwFspQe6X/SD9nYwvkES2TypJhRR9qCivbeQOoWlNkluGU/MwQ/LRom5GTUhOhWS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVdiGL8z; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVdiGL8z"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso1939579a12.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Mar 2026 19:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774405462; x=1775010262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ri1ylRQmHD70sRz0GnPg9oFsVJuulpHnpyaFrZpBYQ=;
        b=WVdiGL8z/ZkLDDKsWFgd2JdgkmWK1x0ZOc8s0bBeGl9rrnfbbVznntwaY5ceyGkVb5
         +RNePul+R3SC2KRYDYRX10fdZJOVS+3ORF1gHcdQt27xJJyOOyGAqNA4QhjSnV6Qrjkx
         0P9JS8HVWU0Eme3n0N3FDqS3KCqIDF5GAAqYxFUXGxpTz6eQJ6zInvR5rGuaANzXw2hY
         lmyEd1ghUH+B5SYvtBq3O4pK1OKKZ3E+irnCvlZFALy4VgIBecAo4OMwWGMUAOtPy+dg
         OGARbTtg9jBbzMws9crr0YGF7ukvJQlQXe4qV1AMLoovAauDngMp8adveJbSNNBGKgAc
         hsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774405462; x=1775010262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Ri1ylRQmHD70sRz0GnPg9oFsVJuulpHnpyaFrZpBYQ=;
        b=XUknSWGvusVkeS6iy6Vjyn6t0ZDPdU1YBY+fq+lB29o0NvWS+voPOi3b+K25lTRJna
         PRl4tYjLGOzs9LdNDq73HteegxSvhdasPVjLEYA5GM+pzi047V1v7R2MIcH8EndkboMD
         YZuNgFXDtA73/cOSdvQz8oorDdI/Jo9kZd6LqkpmmDaQipvVnv0xGAWEtnS8nUe2rSH9
         uX0y7yB4Haf4trypXFQPJ8slCsi3euui/yTTsw3UGIwnSFe4rDKGGhcTypzFYQp8EG9t
         XDfDmVygFWrPtEPiLVKWXXF9EZIw4AC3vmIPV1uOM7TJttwxJVc8CSyfXhTJMctymu1W
         ClRA==
X-Forwarded-Encrypted: i=1; AJvYcCUFzC8rsox5nQOqjw5xTToP94uXvqO7qhG7J+67MiomdlS6UHvr2htCr6FwNzEJZcWnvElfAsV5py0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyihcn88EFoTMdp617pCU+EO2l3Xl7CeTkSLciLrOuzj9h9yiIz
	N5lv0Ys7ZdHRAaDSMHWyasDZ9v4YgTvKIVJUSbX/0Uw6aG8Aqs0ibi8Q
X-Gm-Gg: ATEYQzzTg7nuYITRO0FuFc3EyS5eh2kM/tJBl65iayVgeL1Qkqc6QuekZ/eyzIvjIFO
	Tu8ylbxLtAUy4TaJaHzESBWbjjQvLQLnNa4d9CwCeC+ymRtejhqUotXrPf0CHnd5F9w2+LukeTJ
	6WsUD7YXItXnHjSKCMMQBSFrbF2MTEse+3lfBYYxQO7EVXTYU3h9jaM+1U1ni61XdiTR+Mjidrl
	Lbcz4scvBY3LKX4xZwhdtoQffXx5kVfI/9/h3M80Xn+Z42++qmZ4dkmuTWcXADdKJc/Og8VFoSr
	14s0i/CvXcVDbKNC3tNJWv+f4w+0KTX8//VVwat2UXaEfySpM6mXBURiDcSdJwmusO8eX59cWLH
	D5SdNr/xSsMIESG5VVHcogoRlXFAZHuH2f2yGd8nzYTp1egKgpdKqHRLLCNm99WwBXkNjpsJ8vY
	GCoLv3r3qG/mmg2CdX8KB0h/Aba1boGNOlZH3WzJ9DRXZpnLG/e2v2Rv64U+j9vtI=
X-Received: by 2002:a17:903:1b43:b0:2b0:74df:3c4c with SMTP id d9443c01a7336-2b0b0ae2f61mr20319795ad.42.1774405461846;
        Tue, 24 Mar 2026 19:24:21 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08352ae70sm170348635ad.23.2026.03.24.19.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 19:24:21 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 25 Mar 2026 10:24:20 +0800
Subject: [PATCH v5 1/3] dt-bindings: adc: ltc2497: add support for ltc2305
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-add_ltc2305_driver-v5-1-e0d29daa54f9@gmail.com>
References: <20260325-add_ltc2305_driver-v5-0-e0d29daa54f9@gmail.com>
In-Reply-To: <20260325-add_ltc2305_driver-v5-0-e0d29daa54f9@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1519;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=TvSITG3LE+Bng8Cblqu9isE4WnwGXqZ9Iao1MqgYEdA=;
 b=owGbwMvMwMW4tNlpO2fYkUbG02pJDJmH3eOPB1ocD3fedeTUloC/h59KpK6aYqRb9WFeZO9Dr
 xZxDl6zTkZjFgZGLgZZMUWWk3LHelOeR/w0PLZiOswgViaQKQxcnAIwEYVL7P9DRDuaXF+aOU9y
 4Kib7r3wEHvVzHYdtcCS9Z8TFMy0Gh5OvMz5WEbv631v8+crBKQ9jtxUr/T4Hp9sWfqq584Kb/m
 DfgylF9bKHFSbYXfWeqepQF7yqdCa6AjuxNnGq3y5Vi4wt5yS/Vs8VN7zY+KzCUkeLwQn1/0tUR
 La2bBIIUBxSZuf5/avarcZ0l5vjj5hlvljTvwbnk9rPPYHOD891Z/51LCQIbsk3it+Avfz5PzkW
 JenhlX7pjHoTmosuyx+tMmgTGjm9Cm3eXbxNl3jzFHZlJV13iKDm0f9rteGkmreh5oKZyeb+nFZ
 2sS6vGjx977ZdUKl/lHaoTXVKcbpf04dcpk76XuWxNy7AA==
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Add documentation for the 2-channel LTC2305 ADC in the
existing ltc2497 binding.
This enables automatic device tree matching for LTC2305
while using the LTC2309 driver (drivers/iio/adc/ltc2309.c),
since both ADCs share the same I2C interface and 12-bit SAR architecture.
The main difference is the number of channels (LTC2305: 2, LTC2309: 8).

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index 5cc6a9684077..c884b6e03767 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -11,6 +11,12 @@ maintainers:
   - Liam Beguin <liambeguin@gmail.com>
 
 description: |
+  LTC2305:
+    low noise, low power, 2-channel, 12-bit successive approximation ADC with an
+    I2C compatible serial interface.
+
+    https://www.analog.com/media/en/technical-documentation/data-sheets/23015fb.pdf
+
   LTC2309:
     low noise, low power, 8-channel, 12-bit successive approximation ADC with an
     I2C compatible serial interface.
@@ -28,6 +34,7 @@ description: |
 properties:
   compatible:
     enum:
+      - lltc,ltc2305
       - lltc,ltc2309
       - lltc,ltc2497
       - lltc,ltc2499

-- 
2.34.1

