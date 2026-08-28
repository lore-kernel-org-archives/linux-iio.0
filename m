Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2487F3CCFD4
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899123; cv=none; b=YBEXDYXOkDEy2eUjnWyQnBVYZW5YommtFhLyITfsqMoxGYTXmUBsib2PJSGUFL3WEKWxTqL71ORVq/eDviEBen5VzJZLFSFxdqkUTDu8LXbkAspOJE2w38krj7vjF+rjgTf+HpV5r7dfoG4nM7bTlVRHKHsso/Mk++1bAnVM67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899123; c=relaxed/simple;
	bh=Krf4k0YzPCfh28rpFAoWa340zlykWxBJ3urBqYrCa2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdcUDfE71917Z6s82hePcmn4Ia/8wY3Nn9JzH0D0zsOlx1/r/dTN+fmNKBmSRteRqW138V+106QKLmGkbbVD09pGWQ8cwWp0766LZYg7Wqyf+hke0DaFKoQFzSEhK5Fq6zORiJp4smzsY7itSeENAtctp1Kroq4mKcc611KzuQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmGFXTob; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmGFXTob"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bfb3347ce0so288128e0c.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 23:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787899121; x=1788503921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G5Uw2bvQ4z3aZMIzs9KIbg95WFBUx0+3WqEMDxXt7kU=;
        b=GmGFXTobeFsXTikgNUeZbAhWQZwkLC70u0zFLf4r09SaFFxZzfY8tF1kvIGq+NeGKc
         yk3+XD0K6LuZZh4rxnWej/79GKV8DjaFNK/1X5nXco+TmZaF9Qe0r0RgJGoXLuFw8JfS
         zvBAjiYO4SnEq3FyvfUF2bkEKdX0L/7hZG3Bhk1WpfeXhPCBW6mDK16XlCCVzqvsHkA1
         egl+TL5j0bFOJ1DAVjID7iSIjNEdCThwm//fibFQV668GL8jShEMDMtDz41V4u4QfqSE
         4jwbSBaGgBjyOv0LVvco9veW1VlXuOh/TKsQb30kP7BEUeUKFobZb52WHCWFOem2R9fm
         rZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787899121; x=1788503921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G5Uw2bvQ4z3aZMIzs9KIbg95WFBUx0+3WqEMDxXt7kU=;
        b=RtGwHSglEQIGAzzR8uhmuCiCigSWwMY59X9Ml6edpRSGsugH/Et0lxNGHVZxs91Sor
         PBxY6kCZ/IjjYFAzW5AdJjX/kSl1NUrI4vGyGWxm39Rfa5tkGSXQlpL+IY2HVVPIk3H6
         UmUTplmslT6NnbqN5ma6WAcWxyT+oie+nTrh3vqTffRSi2WjuKv+0KmokbkcNVOvQSxO
         u+Zb7JpLDhtNSPuxBojCHNeGwZeYqXhtO4MsClf0UBP9KcbixHupVT/0vhDbnyVv+cOC
         41HKojPsURU/QyMrbY4+2aYd2ujQFOMAAS/Vl/c83goTzxtMMQTANH6WA5ylrNLz5Ex4
         Ubmw==
X-Forwarded-Encrypted: i=1; AHgh+RpfUZ13tMkwiFjUnfsi+LLN66uT8NuvWSFyWEQSRnlOWOAMZABR7cef1+DNUp9yz3ZM/8+sB2E7LjE=@vger.kernel.org
X-Gm-Message-State: AFuF++lxWXf1YltTTVNaQZXHVByhs4Lpl+rg7FcqxIJq1f8ALG4ehhYE
	P+gbToA0YIUkboNaXCvDqbLj2SBoryp/BuTntxo/VIJCE2qM78dWOW7Q
X-Gm-Gg: AR+sD12HrF6VzhY1kRau25KmL21VXj2kk383F4BdgroiXuj9fDhk8ZuRo8iM2DMe2aW
	8iOvORJs3ILIwXrJxSrZyr8dj+3zFAdg0bdJzywwgq0fhnHxShl8E7E0nohDsEQsuNA5gFB1w/t
	SKyK+BKI99CUFEFIBvzBuzLZ5Ss68YZdxJz0LfX974TkDI+Dvj55M9fTzzoPmrAZGbss4Gtn8PD
	h1QiuLD/OGupbLw/kPHH+PeO7axaBurmv16qyaL2uBvkW08Atqoy6y3SGT8aDTdfWnNEzkH1WOT
	ZIQROT2x11VtYDXlxbprtboqrVUeQ3iccJNENliIjIBH1IjjgFAj3klGekuPIjOFiNrM4gu/oEO
	kUWqxCNcMNLnWgE8WzfMmnRiirANjBxx/0UuN/K/LJldLDkQZMUJ3C+XDPPmTpX8C8Cgo3NsLV1
	ha2wpzqSIhNWDtK8q7gwNzwYbgOizkkf17p73BVTqzO+Wq9hluV/r5fil13AP4AJ7c
X-Received: by 2002:a05:6102:50a9:b0:783:79ac:9dc3 with SMTP id ada2fe7eead31-7859a49efb7mr1250451137.10.1787899120853;
        Thu, 27 Aug 2026 23:38:40 -0700 (PDT)
Received: from [192.168.100.153] ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97e849d8494sm454195241.1.2026.08.27.23.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 23:38:40 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 28 Aug 2026 01:38:16 -0500
Subject: [PATCH v4 01/10] dt-bindings: adc: add excitation-current-chopping
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-ads126x-v4-1-1dc27e9c0260@gmail.com>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
In-Reply-To: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=Krf4k0YzPCfh28rpFAoWa340zlykWxBJ3urBqYrCa2I=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkTdV6nztI6r94nsmnC0cozS0t97H71Wx9POvfO6799z
 e4NuhObO0pZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAiCz8x/I+pOmUWk+7zpujz
 sgPLnpsK3Pr67MmKF9V3j0XGMOzPPreG4X9pp4TFsyO/Qx81JLz/8OD4xu646ikr3p+3sl15SEP
 0zj1OAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add a generic excitation-current-chopping property. This is a feature
seen frequently in ADCs that are designed to ratiometrically measure
resistive loads, such as RTDs and strain gauges. Enabling this can
reduce any error due to excitation current mismatch by swapping
excitation sources of alternate conversions. This can have side-effects
in timing and filter response, so it is not always desirable to enable
this feature in some applications. Therefore, it is best to make this a
property that can be enabled or disabled in the device tree.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index b673eaa5d072..fe20aa8f1bfc 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -109,6 +109,14 @@ properties:
       sources. The index in the array corresponds to the same index in the
       excitation-channels array.
 
+  excitation-current-chopping:
+    type: boolean
+    description:
+      If set, the excitation current sources are swapped and averaged on every
+      other conversion to reduce current mismatch. This generally comes at the
+      expense of added settling time between conversions, so should be omitted
+      on systems with high-frequency signals or high data rate requirements.
+
   burn-out-current-nanoamp:
     description:
       Burn-out current sources provide current to the channel's input pins for

-- 
2.55.0

