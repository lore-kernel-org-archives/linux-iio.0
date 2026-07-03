Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FAA220687
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783098246; cv=none; b=NosxVT7F0eiNNzukPzVUripQnq+M41UUTov26VtRs5T/taiDAyxedWPF4Ffyz1yWXd73rqjD5fLy5E8iB9EUm7DUlVHOFlu2de6WMUdXhVzpysjq5nsfPsBzoLq3WEx1rI09NqM9+DuwvNbmVDXBa2ccEwGUCZNjbO1GB00BHgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783098246; c=relaxed/simple;
	bh=xfVxg6gl5w+u7tV6leMRJg88uDbrZR+IfArPfW8E5/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZBMeXWboadjDZCvkL+YuDtGZ2p77CXMrWbkomK7gnnhNa7G4WlnjuHUBDpDfh7Rol8Af7MSBpRMFax7YVnMMtCNGYP+nBFIBK+RsZXovp3oHszwiLEhxxAPq1CFh68p3efG7xRL3xFiJgNQaGjF4xLoyTb9HkdHdY3OB8z6KrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCUn/T8i; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCUn/T8i"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso404561a34.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Jul 2026 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783098244; x=1783703044; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dmaz70Zg8+nbLWCKBtz/pZ0mkbLi/T/8RKd4bWX5wQs=;
        b=eCUn/T8i+nUhnmBbIaXGoCrMjMcwxuPIEPKdoN/ryD0hGyeiFdm4he9hehPIOirGLw
         igfsJbvHXbNLz5lz38nhkHIiYNLIthb7xBs9FlHTBVw/axNUqLX7/xIHppw+W8lna+db
         H2ePAkmj1IW1PVtFF5g437w3H+CqBa2D4QN3DBPoj0Pffz4he3NKCJtZ2mQG4OaAsevU
         FCflTZoLWR6+GUpp/dajMeqAHYc1O8HJ4z7HXglTBaUWSvdBXxgp+1w/pM0dgTHeO+c0
         ES1TdYYd1u9ukidgREwXYNWbpHr/WAq9ZoSu+PPW3D09TtNoup6pm9nSiF2lBGrSZEue
         l+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783098244; x=1783703044;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dmaz70Zg8+nbLWCKBtz/pZ0mkbLi/T/8RKd4bWX5wQs=;
        b=h2XnptPu8kf1FlcA+4amaxhdzDgqWmFQhhYIoJfgoKTZMVFy8JbL2QysV76WOzPgzK
         tuqXI0woasfhuXK0PIlryuYMJUf5RxYy7EV0LcAnTRRQtm4KjjYuGT4MMz/Q9RNZLKNe
         HG6pHRaK2ZlruFHngot5mvxVKgvpFMgnSjxiuJLWMgaJ/23hHWtxa34iUJKDhCLqoXtq
         jdTCmmEB9lwT1HmO1jwAz8e3bEHXZRrruoXOsXfSY0qIkSxUJ1cRw32DEXBGz0xWojsE
         aMjg2poReOh13y2ZbU2s4F3F8auhQI8g4xm2tt4/ku9eT10R6z/nqsgxlJ8pbg/OG9Tu
         qFjQ==
X-Forwarded-Encrypted: i=1; AFNElJ87IV6lW3YaMjjZzzh/0FAX6Oy9MTjKReqDxGOI91rD19ouFFrezfO3QnEqDsSea972bxIiCnIt0AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzcPoujHNLygQCe/zVgqa5H60DtjevqX7yno3TkV6c1b6p23eP
	tKPehMs/Qjy5eXdeRa7sN4TmJEQ3B0+d4Vjzxhj8Q5O+yfHRn2NaQpuC
X-Gm-Gg: AfdE7cnR+a4TJBpjcXD+7raMtMBYJVJ82MRDjNxwt19NkpGRT67BUXOI/BOBHL5219M
	0YE1srAEXHGsZRmszgon6MDklA5G0FQSw9ZiC/53FJPHPoZT1MD4lpuzs92da6Zs4/QH9Ygihb6
	VtcGJGr7ByrKcD3qjrriSenUnL0SD1rxDDVdwaVVspEJow/3id/bO8Xts7T5hRJonb2HLba/69Y
	zOJruN2Ycp1zFObKf233QPG33t5ONHBwrNIQjDofWfg0vQYv0FWNiVibrC/3Q8uwkzrTdNxLaDN
	3r/MTj7L9ztYPZgOIDFOGlAR2Ks+tP3EoHIFnhWa33LL0LwGg4BEdJjxQpoCrE7ZOdlYwjKjy9o
	BS/Y84NJ8Xu8wAtYFoW94meSOf8mF8fvJilMm8D3lgFqYIV78JD5kQAmQ20FAMNWWhdABcEWrnS
	PCnsqvWSBF1/DlT9vmGTtA9Q==
X-Received: by 2002:a05:6830:838d:b0:7eb:3af8:8c1a with SMTP id 46e09a7af769-7eb7fda9ef3mr199373a34.9.1783098243743;
        Fri, 03 Jul 2026 10:04:03 -0700 (PDT)
Received: from localhost ([2804:30c:1618:8400:e838:86ad:21d4:de00])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb54534789sm5378744a34.26.2026.07.03.10.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 10:04:02 -0700 (PDT)
Date: Fri, 3 Jul 2026 14:04:51 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v5 1/4] dt-bindings: iio: adc: Add ltc2378
Message-ID: <akfrs7OtamEIoVxE@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1783028033.git.marcelo.schmitt@analog.com>
 <fa15b8fe33541fa2e8c7a3f124b2482872fdcf26.1783028033.git.marcelo.schmitt@analog.com>
 <20260702215235.517FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702215235.517FC1F000E9@smtp.kernel.org>

On 07/02, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Compatible strings with required fallbacks are incorrectly allowed as standalone strings.
> --
> 
> commit fff47614872c95c6a481f63da8b14dfcedd0bb53
> Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> dt-bindings: iio: adc: Add ltc2378
> 
> Document how to describe LTC2378-20 and similar ADCs in device tree.
> 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> > new file mode 100644
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> [ ... ]
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      # Single compatible string match.
> > +      - enum:
> > +          - adi,ltc2338-18
> > +          - adi,ltc2364-16
> > +          - adi,ltc2364-18
> > +          - adi,ltc2367-16
> > +          - adi,ltc2367-18
> > +          - adi,ltc2368-16
> > +          - adi,ltc2368-18
> > +          - adi,ltc2369-18
> > +          - adi,ltc2370-16
> 
> [Severity: Low]
> Does this standalone enum allow devices that should require a fallback
> to pass schema validation with only a single compatible string?
> 
> Because parts like "adi,ltc2370-16" and "adi,ltc2367-16" are listed here in
> the single enum match, a device tree node specifying only
> compatible = "adi,ltc2370-16" will satisfy this block and successfully pass
> schema validation.
> 
> This seems to bypass the fallback requirements defined below in the items
> blocks:
> 
> [ ... ]
> > +      # Low sample rate fallback for 16-bit unipolar sensors.
> > +      - items:
> > +          - enum:
> > +              - adi,ltc2370-16 # 2 MSPS
> > +              - adi,ltc2368-16 # 1 MSPS
> > +              - adi,ltc2367-16 # 500 kSPS
> > +          - const: adi,ltc2364-16 # fallback (250 kSPS)
> 
> Should the parts that require a fallback be removed from the single
> compatible string enum so the schema correctly enforces the fallback?

Why? Should users be prevented to specify a single specific compatible string?

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1783028033.git.marcelo.schmitt@analog.com?part=1
