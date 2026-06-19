Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B56B37FF50
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781870267; cv=none; b=h5p3aNHGmgUEBimk/Ko7tLoIl5p6CXeyNBWFQd8s8x9rIc2LOI/+BEQ2EreeljK427n36yx7uzo4KLcGjlNh0KTtow6rdeKYNuE6ThdQqzM9UZCZJgEN6p/2YuB4BIKRWnUfq3sT5s71V1m9AyJJgKhfDr2ot9w1ORZJOdHbzAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781870267; c=relaxed/simple;
	bh=qeOyo9+yDQeKXvN0Qu2xfRfXkt7RvI1EjMwY91NBdPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgOMKU+Yy3s9kclPGkwrLJQju4KmqMc1GhZOklhdqu76GM5c6P8GFnuX0+LkOHRX1TpZMnLgAlc7hML9s8apCyiHqdr/GJgSQm+fVTXK/P5nGNqqJSZXMIkxOHAK2AxCaH3x3kA8GytDuED7TkhZs83PpWpP6NvHVUASI/flYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qk/w/+Pl; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qk/w/+Pl"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso13776575e9.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781870264; x=1782475064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOLs0rfxO3llnr2jSc7fsrR1KU+Ukt3MCKcwcDXPyqU=;
        b=qk/w/+PlCvJTtZqzzWOQk6Ih1I+svT5guSh8/I9ztBFVBRw1tkeI0zQ8s5oQwsd3rC
         Dm7YjzzxUWxRV9/NGqoquNZI3cEPzxwgmecwVc3UzFRTTL2F3O1avn0LhlYmYn0HY0U2
         ggC+5LhTfA0YBSB8znd8aQ33cenSMa5SdM9lHSprn+PAA+sWhPm9wQE67q058Fu3TjD0
         oOh1jmbjQMMBDc+3bMuzVO6jAntzBNEVQdyBdX7/xsZpip7zQifMrHAG30WSlhTvaO0k
         HfrbpEivsO5udcjSjaDUG5riYR0uMcxctlgQg5kx8v6gF6DuGG1eFX1Ffhp1hf3Fh3e5
         RSgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781870264; x=1782475064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dOLs0rfxO3llnr2jSc7fsrR1KU+Ukt3MCKcwcDXPyqU=;
        b=rUYX5O7b+iQcEaTcp7g2Nr6loj+G2VTi3XaWRH+tsOjBk0zbaWU/ccJbKTaf1WVUYK
         W6/ZfqJjKCGNYGLAaqn4q74GThEnyqyLCLN8d9BPfuvyuKSVCVke/8G9VJx4TmOolpbZ
         4qvAjaQFh78/H1zSw9uLVe94zRfhSM5FRFxh4T25XeOgzz1dJO6r/f46K3/PP2eIqWxU
         Sxdn/0idfnwOqBpLsgpHYEaJ/HCZi1dX5BmKdXEthZ0MF2ybd0zTdxLI5tmuTNiA2Hv5
         keXuIoGj1h/uOW7T/kVgNt6loZZvEWrSudu0Dyh2xoV5E3WQBO2VbBrfnfaOsDQ93d70
         9m4A==
X-Forwarded-Encrypted: i=1; AFNElJ8ccgQs2YkLsusQFNPV3fcO09rteJMQpLgzSLThBtnOvyRdNV/VY/82esoIyojTUKIHQEwmilNmsf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVjVdj8OxW0UckKNl5bELuRedqXvg6xCWIb4Vo0mtjx2JuH07q
	NZW05gGVTb+KCcBQ+R9VN88bGXDz9O0jDz+vXuhXpNFDYtID0WvjXqbo
X-Gm-Gg: AfdE7cnZmZfU/WoPxGMDGm5TrOjMn1BU1PB2QzXFr7DO2LeZNYzdkJ+yTjDqrOWEDd+
	c9iZlBoONXY8ALxel6xl/S72XNuVtForzZNArsKxJkcme9dXHmvs9ZQq7lMPhD6879iME7hm6qc
	MLnOLI76g2Iml+8Xqgbx1U8wz9WxgGDjsO8JFIbtzvWDxcr1pJdq8pixOC4TwVRJs9HDg9HNXBY
	lBWQsafFg85jsjjG26nknxldLxW+mOjl3dNDEVIk3eTdHd5Ma2I819VNALQYUioW3hTuj+DjDsm
	6NiVGUk82+jvYa+vfpbLE/8EpR6KtbaKf9ucIVYRCSHzdPVovEj6YxwMI8755XjgpIQl6txidmw
	BRaIsP5xr6JbKeuGmS3RAWLnX406inzsRZod1RoiHxVMJykB6DvV8cvMuVyNi4rFoIYiuZrNx/Q
	qpmNoVJfdGvi3GC2mHm61n40cbxqloDSuYUzHhQZsCGQHhWfscr5UArniYTyb//EI9Ehc=
X-Received: by 2002:a05:600c:5289:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-49240e81ac2mr51163645e9.22.1781870264183;
        Fri, 19 Jun 2026 04:57:44 -0700 (PDT)
Received: from fedora ([196.112.134.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650b67a3f3sm8326131f8f.20.2026.06.19.04.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 04:57:43 -0700 (PDT)
From: Jad Keskes <inasj268@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Eric Piel <eric.piel@tremplin-utc.net>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jad Keskes <inasj268@gmail.com>
Subject: [PATCH 2/2] dt-bindings: iio: st-sensors: drop lis302dl-spi from deprecated list
Date: Fri, 19 Jun 2026 12:56:49 +0100
Message-ID: <20260619115649.840676-2-inasj268@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619115649.840676-1-inasj268@gmail.com>
References: <20260619115649.840676-1-inasj268@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

st,lis302dl-spi is only used by the misc/lis3lv02d driver. Its
binding is now in Documentation/devicetree/bindings/misc/.

Keep st,lis3lv02d in the deprecated list — the IIO i2c driver
still matches it for LIS3LV02DL support.

Tested: dt_binding_check, dtbs_check.

Signed-off-by: Jad Keskes <inasj268@gmail.com>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index a1a958215cdb..2a5451589fab 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -90,10 +90,8 @@ properties:
           - st,lsm9ds0-imu
       - description: Deprecated bindings
         enum:
-          - st,lis302dl-spi
           - st,lis3lv02d
         deprecated: true
-
   reg:
     maxItems: 1
 
-- 
2.54.0

