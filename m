Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171AD36F415
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193398; cv=none; b=PMR7viFQif6m7vwC/6UBuXbEsipyOtWx0PM3Y5e3xZ1TNekfrG4zSzz9hIB/DBUjDQlQarEWinem0GeOGMGdwl8YLBXg95zelFQwuiSpWks7J5gdB2kR6WR/0vzSwvitZD9dI0wpZkU5sAZDxdZ/1se4MI2eHExSsTDL+6uW8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193398; c=relaxed/simple;
	bh=TvSITG3LE+Bng8Cblqu9isE4WnwGXqZ9Iao1MqgYEdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hf8Mf9nXb58z6LZHoYPqsjv+eO3n68RQMVVwQA4F52vtaBopH1sMRWb/IyQt1XzNKPAlIeZXPmtVadF0HkywDsK++nXLEKFJvRouKM1+H/sB+i5fqE1+3g/HXLkYNWq+OXLGIit3HPpRsw9VTbbykrHfkwQNRCmT43q84wXmuws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nnx025kN; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nnx025kN"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70f91776fcso5770896a12.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 18:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773193396; x=1773798196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Ri1ylRQmHD70sRz0GnPg9oFsVJuulpHnpyaFrZpBYQ=;
        b=Nnx025kNSID5wOTHB0nfZY8fok1FYhGNCbHJyiRB5PpuKSUibw20o78ixAD8eQn7gs
         BIVzn1eUdudj53/gZvW9FJmL+DWEiCx3jIh9QkzFr9SCKT6UgrfFbWKJb3xQfF4SS4q3
         8wLcsETd4A+dxPii5+7V/TDiSXDWDhaorXoM0qM8UAEs7ime7jFdMgBZ0YC+KFReOqV4
         8BSiOaEJV02VUcrRXONJwri8gF1mJo1/VNmgaOBe33OpO8CEB9/j8ZTNnnDMR6qUIa+A
         7HnASKQ817JQNC/wwr0GN3q3iWFeK8l5ziBCLc5oZwwWUzMg8XR2mUK1oAA1lH60yg46
         4Mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773193396; x=1773798196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+Ri1ylRQmHD70sRz0GnPg9oFsVJuulpHnpyaFrZpBYQ=;
        b=XKkk79MaAQ41ySi1qiZmh9XXHOD3pjn8c0cbpX38d0KEFoZe3eWS+0tpYNPsODfaHQ
         5pMq1s3UcNWwQf+J20/NVh9OYkGDN2PkgtzYJWYeDhF3JZnSIhmmsudOI8sl5mxtapUc
         J3G0zSPWa2A6UtmcqpPPLwDp7tnrYlDDlwklwUIL1FKrIMUqWw0ESyWE0Y2vtgePnk9u
         YHJO6VHbi6o+SSZ210cNgGcQ9ELuZg+OMzfOeLtDX1Ell7GFPhL+TfJJDdPSp8RF/HM8
         jWRpM7lIYg84f0ZhwsasXiWWFIcaj257hC14xG7c7dfEZ1KzJPXTO3uH/nfmBQXFdfo9
         TVCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr6cuIeyXdncRznxxVJ2AcL/q5ovLeNkftDTkQwO3Z3i9F1NThFuMzZndZ0/ahclDnfdB4bMO7h24=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw7OT0ObVh/haWVAclY9Tc059V9TqY34QFuxLz8OW3z44FNXbm
	FmT6lqp6mE2VVwmrDgaPNr/fu63ELE4Kw+gTnHi3NuSlsHgKO24Gb/84
X-Gm-Gg: ATEYQzx1mz5YRYoc+xCgWlGKCs5iUL9Q3nA/Kq/O58Va9EUmfjaw8Hk7B0kJSUZT1MJ
	+/9TpManbE1C5b4zPlNr7nhcEUYMHt3nveJnyN4bxavVzXetHqE+VfhUq7EMs/tX/16zzwPKVdM
	Sv6+25ezEmeHWefZSRuMmO8aKCE/6Yl+6TsBIvaHhJQU/l9PJrqa5woiSPm/DBOrPkgp+8US5pe
	N/XHkZbKHRyNSb/fVlk+/TRJ4N/Ku4OWqYCS2URlkAdvHTMxyfJBnkLFK0CIIz/vKw+7OdJ5/Q6
	5itBETKRtNnnBtBZv5Fec11UY177T+Fs+goudL6kJ8GaO1E9XBcw8vIewMKZnci08rudBNvlALp
	nUqx00Ebv48fFms5mwdjJOOu/90tWH2Mo6sZ9fSQnZfwoWgFAJ/tC8ZKw9+L5baA4fb55rmna7m
	jVRc54NBg9PbpKimdLoBzkwQyzPes6uEedc7vdEFHIqfmMx6k1MvtwRboNKwHenqc=
X-Received: by 2002:a17:903:18b:b0:2ae:456d:b836 with SMTP id d9443c01a7336-2aeae8f4d8bmr7958935ad.47.1773193396382;
        Tue, 10 Mar 2026 18:43:16 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378980sm5219545ad.84.2026.03.10.18.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:43:16 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Wed, 11 Mar 2026 09:43:01 +0800
Subject: [PATCH v4 1/2] dt-bindings: adc: ltc2497: add support for ltc2305
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-add_ltc2305_driver-v4-1-bc350d347f33@gmail.com>
References: <20260311-add_ltc2305_driver-v4-0-bc350d347f33@gmail.com>
In-Reply-To: <20260311-add_ltc2305_driver-v4-0-bc350d347f33@gmail.com>
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
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBpsMiuQr0v3Tpnbe0JWIWNBzuoAbYgw8z157FDl
 hf1vdy4WViJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCabDIrgAKCRClg0K3CVbE
 gT4jCAC9onAGYF7TuW80NbJxdpRSa6Ca5Oc2/cJphnCRk5lutYWrFohCaJALpnzE0N5Mpal71X+
 H9jzSN2b8tIcb6yyyi6jc5EHJ/RrssKCwVPuX9j7UGF4/8dLoxWDeVBaQQs+wdQpdlL5MA4a233
 kFn4Kn9pq4nxraFZPVP2VOGvk8LsaaGii7QiCzZVOlnX42Oajdwin+ArQeenKE9w6+J3Pv3XQZ7
 7z0mwzlaPjqNL4j1yuTuEoCGmcMWHh9NoAxoJQpuXYrHR0LsOxWHCVMn60dZI4PoilrIIlHleWm
 8La+2+04wjb0GDXeVW8Kjrmn/bVdVkVPZNAxrmyI2UbKslIW
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

