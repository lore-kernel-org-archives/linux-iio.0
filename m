Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B92B381B0A
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129713; cv=none; b=uhsfnHJ13hd7GUJ7DSfNtOO1Oq5pTRdu2jAnrxHymQQnwhjjK8NQUdgQOAiJJWJlaNO5YOzntmV4Q8wL555Mo9StUWqszcUcRkMcZ0Iltk2Yev3btZ8fNfQx9MH3jlWLii1b3HzqsQxc3GcMsW8H8ed+AlIRn1Bz9ZtJ4X9FQpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129713; c=relaxed/simple;
	bh=JNbCHaWL9A4MjehkdwtKJsbWrGA6dxODtuxGwf4j9hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+ONZyFHA5F+Sk0PbHu4Ot6c+T/iiaUM9icFPDArsgmk3FE3YcY2exTdLRnr93Wc1y6MfnszQGwp/NWaDIMNy4A/aDpJ7Jrjqp3jlSLmaV/iGpwUsqdOpTqfo5Ql+8+s1/0ZjlOUFhju4sc45XOIQKZDJtncWtj9u/3Ls5mdjQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW1/Fpr4; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW1/Fpr4"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e5eb0fabaso36870051cf.0
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 11:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779129711; x=1779734511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjcXx1L02D57/85kmr8KRIpyy2DN3BNEA8TDg2cGfrc=;
        b=GW1/Fpr4KJGV1w73HxVUBExobEEqxD+ZVKvNZzM3cODox/lJU6COlP3lO4/CvdOXE0
         JGTY3h0QVkg8jb5TosmM/0YN78pI3JlMqP/USMohv7pasTKsjP63Hm/LGwVKXbMlzSBZ
         w/j8Song2rMtZFCsTw+vocXOrT6AWIPy5Aejr7mexPBS+IixKirRKOD4X0GCN0uyFfdg
         Z/NCQxlwCqF5j9BvU1g+BPsC4lzskgWIq2IK4k80B8UTWN7q8qOHkuYLH0d//Go6Qlcu
         rNsmDX1NxObiej20UaelfHfmGXL49YuHIWN7ijjw8+LpwIE0S40Y0vRtffCXEWEEI69u
         Co6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129711; x=1779734511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjcXx1L02D57/85kmr8KRIpyy2DN3BNEA8TDg2cGfrc=;
        b=cnnQUnXhadrfhNeKtmQCjBm1CX+fr77Zk6mOAsbKhdBRnBpE67/Eb4zthnMiVUl441
         ObhnaQSI3KWc3NDpVlsGPLpot6CbgIWN7WKMr89t3wFLoXN9wlioSoVn9zlx/j4I1bPU
         KibzU+XHi5ahc0WohFyAseOlB9x9hxSGE91Yxc7Q/CSBLcVqkmnP9Bk4d9BpGdJzWoaE
         xs3l76VJ8RFeni/CyO3RWLvSsXWzFELe/4xdbU1jFhUbZ0ywV5vz+1paxSJu6V5i3y0j
         HgHP41SeFjM5onWMVPcWpFkSRXUqPmxutO6J6IhB+LcgkjdV98VPM9//X8nZw1KLL1X6
         rotg==
X-Gm-Message-State: AOJu0YyGE1ynHCODu2LSH08oghPPQJ7gZuUO5w0hO/v5q/1vAe2ZAZcm
	6XZYMk9ZAOifYcW98XaLgpLcAUKAEKvnaXK8tI+GI/CktoLA4vb5fWr2
X-Gm-Gg: Acq92OE3IDorKOyJVQzBqk818GrfGYrfBjPs67QQf+DWAdZDA8oOT5rjo/xbL6SSK1w
	A3BjSCp05DlFVyWuIvr1ci5TSokp03noF20NP/1KdHcMPh/5qKcQ7dc/30wvRuA+IwIvkU3NyRl
	E5K/q/ZlOGLrUprsYGFRX9NTWR+nGENaiQn32A/3XI1bDoX3vgNKKYAtSTSg28+lYEs/ux047SA
	8Si44MUuZysiTJKuhXSonXAkxWd72uJROP6Ks4H/HeyBPztJBVhDO+MYnbfOLUBGlD+BXDbYdSS
	QIkEeqTaelRaFejmL+k9SqsZrIt35qbU2u317A0D7MLo+jKEG9UHhERwK1ToCZ4KuHj/nibURaB
	M6f8JZTr5CvzUUHcOFdZdOznJAlBL2ZdXcamWjW7iG0XXmJwLtxFn3hX31rk1z9jzwzQd72rOYz
	e+31LzoBP0Ge9NMszOp+FShFfR2fpBsovK
X-Received: by 2002:a05:622a:1789:b0:509:3940:30ea with SMTP id d75a77b69052e-5165a255f15mr239848711cf.55.1779129710804;
        Mon, 18 May 2026 11:41:50 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5168c968930sm50529931cf.0.2026.05.18.11.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:41:50 -0700 (PDT)
Date: Mon, 18 May 2026 15:42:05 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: adc: Add ltc2378
Message-ID: <agtdfXdUR-zwtFOe@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1779117444.git.marcelo.schmitt1@gmail.com>
 <cf404216011b6972519436c63fcc7c4e2c883c54.1779117444.git.marcelo.schmitt1@gmail.com>
 <20260518-trapped-gauze-ada279af89fc@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518-trapped-gauze-ada279af89fc@spud>

Hi Conor,

On 05/18, Conor Dooley wrote:
> On Mon, May 18, 2026 at 12:21:01PM -0300, Marcelo Schmitt wrote:
> > From: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > 
> > Document how to describe LTC2378-20 and similar ADCs in device tree.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
...
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - adi,ltc2338-18
> > +          - adi,ltc2369-18
> > +          - adi,ltc2370-16
> > +          - adi,ltc2379-18
> > +          - adi,ltc2380-16
> > +      - items:
> > +          - enum:
> > +              - adi,ltc2364-18
> > +              - adi,ltc2364-16 # fallback compatible
> > +      - items:
> > +          - enum:
> > +              - adi,ltc2367-18
> > +              - adi,ltc2367-16 # fallback compatible
> > +      - items:
> > +          - enum:
> > +              - adi,ltc2368-18
> > +              - adi,ltc2368-16 # fallback compatible
> > +      - items:
> > +          - enum:
> > +              - adi,ltc2376-18
> > +              - adi,ltc2376-20
> > +              - adi,ltc2376-16 # fallback compatible
> > +      - items:
> > +          - enum:
> > +              - adi,ltc2377-18
> > +              - adi,ltc2377-20
> > +              - adi,ltc2377-16 # fallback compatible
> > +      - items:
> > +          - enum:
> > +              - adi,ltc2378-18
> > +              - adi,ltc2378-20
> > +              - adi,ltc2378-16 # fallback compatible
> 
> All of these are wrong.
> 
> Firstly, your "fallback" setups don't work, because they only permit a
> single compatible. Secondly, if they did work, you still need to define
> the fallback compatible in isolation for it to be permitted for use when
> it isn't a fallback.
> And thirdly, your driver appears to show that these devices aren't
> actually compatible at all, given there's unique match data for each
> one.
...
> 
> Why do you have fallbacks here? Is it because a limited set of channels
> could be used in the fallback case? At the very least, the rationale for
> fallbacks should be explained.
> 
Some devices can be grouped by main number (e.g. ltc2378-16, -18, -20) and
those vary only on the amount of precision bits. I initially thought we could
fallback to reading only 16 or 18 bits if a driver compatible with ltc2378-20 is
not found. Though, I now realize that won't work because the less significant
bits would be missing which would compromise scaling the data to milli volts.
Will make this a unique match list (no separate items lists, no fallbacks).

...
> > +
> > +additionalProperties: false
> 
> As sashiko pointed out, this is not correct if you want to permit spi
> properties other than spi-max-frequency (although I could definitely see
> how this would be correct).

Ack, switching to 'unevaluatedProperties: false'.

Thanks,
Marcelo
