Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1435F199
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 07:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777016669; cv=none; b=QUsEexpTkNM3B4hN5NF9H1nQ049AIA0AO7sjA3NvjrDx3umOxpSeUu7QCyyh5GquEyBgTNCa53q3hEPFnLXSYUuvqIrpc514SSvHu2Gu7O8awxVbNnIjvhbB4WwXzJ1B0UzgaRydw93ee5iweNZ2gdLf5oqOBkInuBpa4imaRDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777016669; c=relaxed/simple;
	bh=tg5RkbWli/IPrfZHKyU24iERKTLpVG/rkUKE6DuIK+k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtgKMNvJLq95br2f+0vN6xO14wEUc2TsDR/rahmlivJO20ebZ9v1LUUgtGsGS08kOf3yImqIl9n0ZVejd4DGFbN0o7ydWTQY0KwZmK1OMDri6uEMFKR3rWjFX97CSpTIUyIvGb7YqyZZ17l21CBgFhMHqT48e0nNwcNNKGB5AGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n98caNP7; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n98caNP7"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so37147705e9.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777016665; x=1777621465; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0Nw3MbQBRl5e4oTEVERCLRkMcH5suU8nH+WToG2Fr4=;
        b=n98caNP7gEdVId9lkNqs8n94NM3jOeTrxB7zoCFHv9BMyVA12eWMT/dDkDsQnD7lo5
         FxNKshhG/2ssX67fLcAJwHkB3meIf+hycoQWV409CstlpnZfwTCczh3jTZHEkW61Xg8w
         iVRCamld1dkT6pkAqXGIoF1b3JUjSQSHnlNtw7/2CIcMdXrEufPA+twSAHIlPWHDDcmt
         PEGrDpJ0ybJPofpnwguS1urrboNP3pN6SzdECLPf4hd1XHaF8qbSz/hseXA81E1zqZLN
         sHwJpdHmYPzVfQgmufVHBMR7o2MRj018KgY1JTzTPSZlJ3gFfe/mx0K79d1bT/q+7BWD
         Ldrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777016665; x=1777621465;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0Nw3MbQBRl5e4oTEVERCLRkMcH5suU8nH+WToG2Fr4=;
        b=H2brEIQ/3RBg4q6L2zSH4BObzmXi8SIcKWXfSBmNngpCaMc+BeCNeL8ZkHoXkDu7+4
         ri8lLkxQGWdThl1hfbP3FwVE+Popb7UcuDG71ch5J3d5R+3sQWAL8lWep8heXqD51xM4
         Vqcqta5/ZxxGhErNlxx/gG7/dRhP/CldrytEdMXE3VYiqTzrqUIbUJM8L0qaLgIDZLH4
         ITxvUMjJtjlqJl5cMT46kwxdjADoN+h01ffT0ox11myLyUpapiVbKcDv58Fv7jG/bdGX
         hjZUIzqqif0CMdObX88tHOGQ3QoEbsntVf2osmS0o/yaIxAe1JZ4t23BJy2ZzMUX2eI/
         GacQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Rn+/xqOHJG1lJjcwHwwuGlv/2xgdfYgeDIOFgVoGMaQN4kKbBmbJgEOxPVYXaIAXjQqC/xBVmZIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylV+002aOyWa6J2qCMx78D3Sl3PrgpgKtuHuYlspYoOFqk/tjQ
	I/dBBpgCW7klarWCrUsLptIpnRwLLR3B1W6ScqwIIDfS22Zfu9XRWbG4
X-Gm-Gg: AeBDieucgZj0cPk3uEsxVxFkmkxfaa44sIHdTJKrcTjxzWWHgeJjTk7NsvB5jXSTRlJ
	6jCB/ZvB+8QaX0JdWiNcorm5SgcoTbu+vlcTu1W953CHlyvB3+jHoIjJ0SHSl9SQLntg0tnLlFx
	Foim5isHG6zC8Wh0r5hkrDHa/mW+eGIeyFSH7zk1ToOvYffqgeZTBv/HNX7A5NvQ4hxefQBlahj
	DqOq3PvZpB1BekNhGEEAur2K1tfl1u3PYDMiyE6yJ8bIMbUsMax04Ct+1V+Jlva8XIqv+uXeRTB
	ZbID9DJidWyBhKCL2FkyS2P/pInKl6/KM5/TrK0cY5R1lNdjDTqfo4hoWzJYZzJLWZwpWVDnGT9
	2yDG4242wocoS1Lkt5XUphzhUcKdcpLuIKly+Gat3ApEUcLAREcBEqVu10TNC2GICyXtgl3R8zr
	yebW4SjkjiZdub4t1EuK+a91mVLisPyBHJgAK2JEUdcoZOc8vSXnxG7Kl8eNYd46ohMKTYBxAts
	rkaCbJ9LA99RcvyZOoqsyVyW7QIO9W4DtJQGeO+SAUb9TMDGMuMPgCW3+Kq3DR1h0wa+uQ=
X-Received: by 2002:a05:600d:8447:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-488fb8b18d1mr303468305e9.10.1777016664498;
        Fri, 24 Apr 2026 00:44:24 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cca5743sm357547225e9.9.2026.04.24.00.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 00:44:23 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 24 Apr 2026 08:44:21 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 03/22] dt-bindings: iio: dac: ad5696: rework on power
 supplies
Message-ID: <g5a3zky54agp5juxbpn4yy6abhugazgzbyfau5va6r5bmrebxz@o4c5kf6ki24h>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-3-ed7dca001d1b@analog.com>
 <20260423184723.54ddbd67@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423184723.54ddbd67@jic23-huawei>

On 26/04/23 06:47PM, Jonathan Cameron wrote:
> On Wed, 22 Apr 2026 15:45:37 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add supplies for VDD, VLOGIC and VREF input voltage pins. The vcc-supply
> > property is deprecated.
> 
> Please provide some information on why? Was it always just wrong and that
> naming was never used for any of the supported parts?

yes, vcc does not exist, none of the devices describe any power input with
that name. The name is also misleading as it sounds like the input power
supply. It is being used as an external voltage reference, which is called
vref. Will add some of that to the commit message.

vdd should be required, but that would break the dt-binding ABI. Also, vref
should be required for parts that does not have an internal voltage reference
(the one with no 'R' in the end of the device name), but that would break
the ABI too.
 
> > Certain devices require vref-supply to be
> > available once an internal reference voltage is absent. Still, this patch
> > does not add those as 'required' so that the ABI is not broken.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> >  .../devicetree/bindings/iio/dac/adi,ad5696.yaml     | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > index f286e5072abc..21b80fe597d1 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> > @@ -38,9 +38,22 @@ properties:
> >    reg:
> >      maxItems: 1
> >  
> > +  vdd-supply:
> > +    description: Input power supply.
> > +
> > +  vlogic-supply:
> > +    description:
> > +      Digital power supply. If not supplied, it is assumed to be the same as
> > +      vdd-supply. VLOGIC may be hardwired to VDD in some board designs or
> > +      internally connected in small packages.
> > +
> > +  vref-supply:
> > +    description:
> > +      Reference voltage supply. If not supplied the internal reference is used.
> > +
> >    vcc-supply:
> > -    description: |
> > -      The regulator supply for DAC reference voltage.
> > +    deprecated: true
> > +    description: Use vref-supply instead.
> >  
> >    reset-gpios:
> >      description: Active-low RESET pin to reset the device.
> > @@ -88,7 +101,9 @@ examples:
> >        ad5696: dac@0 {
> >          compatible = "adi,ad5696";
> >          reg = <0>;
> > -        vcc-supply = <&dac_vref>;
> > +        vdd-supply = <&dac_vdd>;
> > +        vlogic-supply = <&dac_vlogic>;
> > +        vref-supply = <&dac_vref>;
> >          ldac-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
> >        };
> >      };
> > 
> 

-- 
Kind regards,

Rodrigo Alencar
