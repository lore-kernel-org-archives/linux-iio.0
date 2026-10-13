Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027B85505FA
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925542; cv=none; b=M0O9ZEwmG1H0ZZxQeecc0SJhSsIXx5VB8hGFbXz05Vm2y7YVFMcFgkS0vTFdiDLGVT/hZV2wvx7adnE6x/kxC2DxQuB+k7RYV7YdkLPQrbDU48Rd++098S0YR2tb898hlPQl2/RFxs/0nsPw3PPXdqIiGIO4WMXjQA3aeao0YC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925542; c=relaxed/simple;
	bh=VY9hMjAXDh1ftFERqn9Z7cXPYFaO8/7QJudSZTKJFGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqD4WaB5+83YnfqtceZcnFhnk0ALxzoE6X6YcWQWaWyVdnYoD7LjPRTCRhe3Qo3/QDbzsEYs2WoBc2+f1Lz4FgQ5vWyTH/hbvPhZ1aQzH82DObVDid+bmCJ9WabvQiE0WWoP6CcSWGPSczXQK1XzyKY6Zihak6xqN9aw1VUCxsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCdxl6ow; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCdxl6ow"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5e95b036302so977257e0c.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791925540; x=1792530340; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/hCnLD9wzCgwKNHoCJ7lYMaaHNFptFWgp7Dc0EKbjrs=;
        b=XCdxl6owE+DjoN7jVA3nxCupMkP6Emw1V86aXYn4RYpy0GJFuj+yMn5csEqcZ5V4YH
         Hf5nIEj4SO4avMQnzfjhN4EEMKLw1wbcdaWPaH7CcGXf7ZKAx8ZJ7sfsj+kpbI/NpB9N
         AlN89xOspkiVaCbXI/1BOBJ0cPxsbGW/dKPiDeJqVhrcc+KHh4ARdRLyzfVAD0fF7Lj0
         tLa+2uieKvX060aufplEc9BD10xgAnwXl8mKdheNBJ9KkO7SNUlqLqFMnMTx3FqIK78K
         81ECxI9lwKzrh06qMyCe7oSgXtFemGEQGsIODHwPLTKZ5954Msj4YgYQ6UVR6UBlzFEp
         WurA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791925540; x=1792530340;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/hCnLD9wzCgwKNHoCJ7lYMaaHNFptFWgp7Dc0EKbjrs=;
        b=Zdmy5mTbXq2L40bhXTDKV1VJGTMYiHu5BgD8NDinTQdUIh23nvrLEyRY2zw3xh1iTP
         7oYkiZFVHDCh3wJ8pHWze8NJ9SH5SuaCQEFMHCx4kr0thY/g/Nd6EXyjmig5OmF2zQpR
         apfEUxfLPjjFGC60fpsVCuq+mZQb8yS6oUn/S44a0BLa1Pg/t/4zbDaTulY9xWgG9qCc
         YALCFnN0R4AV0s3uKqulomA5RDqCsob1f0p7drdtzNPAFP5OhVSXyqAyVpZjuZSvnmQ2
         sprn8tWU0iGh2u8iWgW7PYKmni7Q6O6bv2pYeXZ1m0lHGwmgIlpJg5D0dSMxAyFM0jjw
         pWuQ==
X-Gm-Message-State: AFq9FYKGvB4/kUvd1r9LorALxKgOg52xWGBFkiOoe7KCOnx6p5FwSF99
	gwtZkDBUTYYNJXGm7zCwjAnxFtF7PX/t6fAxLUXeLSM6xB+W3i/VtKisK7/Z7le2
X-Gm-Gg: AYBFou1gffUSPLcKxYHj6IKpwz2xGNcGd/MRCo3Rxjd3r/5euwRE0uqxeSvepnHDGLs
	e/IsUIFb/IwSw+BV9k0/jUCtq0ZmR+TkRaG21xCiBo8kRWDIxx+SReZQXG3Y4NMI0LH1KczvYCd
	gPm5V/l5AbjXOVdUGhnKpX6N7lu3ewnHCAdXxs1L1ojx6qKkkssmj8B2GFID4a1+xOXiLhZRa3a
	ySCwP+NJzuYT3jitXWFbjL+YVcLUC234EEir4pZjQl56ikoicAcWgq1UzrBEtPBmfqmFkuEijuh
	2WKKpymFdhxpK6cT7K/ZNcxlkc9+ZfyO9kdQWql+ZQWIXaPPu2gTJDSSNwB3xJL1I/0d57/zinn
	GOG76dG9yc5AWyeKTc4kwokPN3KQJpTDhodQPjsLBmpY1diqWk6Pq0Yp7fGwXKprtPqT9v9/PCs
	37/V74hZQ2cVwDDF+O9/JzCmJ4PAd12XXiFsZQk0Nx3+QYGMx19CzOzhIFYpfzBiWStIRMTCGVM
	FrLzkchHIfeRGg=
X-Received: by 2002:a05:6122:4a0c:20b0:5c9:a5b6:27b5 with SMTP id 71dfb90a1353d-5e91e74d733mr2547872e0c.18.1791925539808;
        Tue, 13 Oct 2026 14:05:39 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e93683455csm7033499e0c.13.2026.10.13.14.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 14:05:39 -0700 (PDT)
Date: Tue, 13 Oct 2026 18:06:01 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, robh@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <as6dOTPvdfCtgtJg@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
 <6afeb3fcb39f73edde5f39f6f37a1ecea5523319.1791309733.git.marcelo.schmitt@analog.com>
 <sashiko-outbox-162344@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-162344@kernel.org>

On 10/06, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] dt-bindings: invalid and incomplete constraints for spi-rx-bus-width
> --
> 
> commit a58d6d0037332b8cd9f5b3717ec4b6ddd8e36734
> Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> dt-bindings: iio: adc: adi,ad4134: Document SPI connection mode
> 
> This commit updates the AD4134 device tree bindings to document different SPI 
> connection modes. It introduces the adi,spi-mode and #daisy-chained-devices 
> properties along with corresponding constraints for different wiring 
> configurations.
> 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > index ea6d7e0264190..970e7adb2405b 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> [ ... ]
> > @@ -141,13 +161,36 @@ required:
> >    - clocks
> >    - clock-names
> >  
> > -oneOf:
> > -  - required:
> > -      - ldoin-supply
> > -  - required:
> > -      - avdd1v8-supply
> > -      - dvdd1v8-supply
> > -      - clkvdd-supply
> > +allOf:
> > +  - oneOf:
> > +      - required:
> > +          - ldoin-supply
> > +      - required:
> > +          - avdd1v8-supply
> > +          - dvdd1v8-supply
> > +          - clkvdd-supply
> > +
> > +  - oneOf:
> > +      - required: ['adi,spi-mode', '#daisy-chained-devices']
> 
> [Severity: Low]
> Neither chain configuration includes spi-rx-bus-width in the required list.
> 
> Since JSON Schema property constraints only evaluate when the property is 
> present, omitting spi-rx-bus-width from a chain node bypasses the hardware 
> constraint. 
> 
> Should spi-rx-bus-width be added to the required lists so the SPI controller 
> doesn't silently initialize with a single receive lane?

I don't think that would necessarily be a problem.

> 
> > +        properties:
> > +          adi,spi-mode:
> > +            const: one-channel-chain
> > +          spi-rx-bus-width:
> > +            const: 1
> 
> [Severity: Low]
> Because the core SPI bindings define spi-rx-bus-width as a uint32-array, 
> evaluating a device tree value (such as <1>, parsed internally as the JSON 
> array [1]) against a scalar causes a strict type mismatch. 
> 
> Could this falsely reject valid configurations during dt_binding_check?

When spi-rx-bus-width = <1>; the property can be omitted and the pair
#daisy-chained-devices = <N>;
adi,spi-mode = "one-channel-chain";
passes dt_binding_check.

> 
> > +      - required: ['adi,spi-mode', '#daisy-chained-devices']
> > +        properties:
> > +          adi,spi-mode:
> > +            const: two-channel-chain
> > +          spi-rx-bus-width:
> > +            items:
> > +              - const: 1
> > +              - const: 1
> 
> [Severity: Low]
> This array items constraint validates the first two lanes, but it lacks bounds 
> checks. 
> 
> Does this need minItems: 2 and maxItems: 2 to properly restrict the overall 
> length of the array?

I've tried that before preparing v4 and the result was dt_binding_check hints.
'hint: "maxItems" is not needed with an "items" list'
'hint: "minItems" is only needed if less than the "items" list length'

> 
> > +      - properties:
> > +          '#daisy-chained-devices': false
> > +          adi,spi-mode:
> > +            enum:
> > +              - no-cs
> > +              - 4-wire
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1791309733.git.marcelo.schmitt@analog.com?part=8
