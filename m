Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CD838398E
	for <linux-iio@vger.kernel.org>; Fri,  4 Sep 2026 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554829; cv=none; b=DFBUsACpospREJehpZxowxSZp2bhmwGsUt8jKNmj2cysxRE0VxxBAD+7/MgFMRcTSzdnbnbOuzhwYhO16w+xiIAv8ElI3WnF+f/GoXk3wUEQDCFbR96rH307kO6SL6ImPqcUJnc5v/wvWp3+w6B4x0Z/ePf77nHAsIrrxFNVdJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554829; c=relaxed/simple;
	bh=VqRTI1vSnxqFnngxsPxK1C9AC5MxqlqL7Rry6uCm37k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1zMfKvMc8g3ip3hBt0FA9ypLqV4ILXdt4YdDYCRkAvG7hnm0aypjiC5tMHrVlVhbrN/yo3MMLR6AX7P9duZlAGHjtxV8TBYlSKiIhUy5Dp7ZdiBCY/Y8xZClZHfktjNg7LIZJouX5Hdk1lJ3OpSba9FgWqO5VYuC9lR8/V0XgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlFNGKSo; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlFNGKSo"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-866e57f63a3so18575587b3.3
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 13:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788554824; x=1789159624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bt1HqSrLvYKEai7M5FJi0Yxz+CgX3DRE2Qu0CFMj0Ww=;
        b=XlFNGKSoL562DbhqLVPpHZYqOT4tW40WxfEqRe2KEMUaK7u47t8iprHFOWdz+dbRxP
         UqI7INtC1nEW/VOIzAtzsda7amhpZJ7mmphJuedYgVDQo3f53AxD60eAYtq7lbVEur/5
         sE38ansDBhn9tDeARp+F1n3Rn+scZJEU119PAzy9gXiNxZ+DmAYhfHEL+ToBzNGsBJ+9
         JsClHSyoWU3HDPPZW5aIjDTzaxprMwKGzomgmbD6HSMEkckpXJZdP7HG727ZTkvxxZQs
         fLyKLhhn/RtDDq+v218tAyyq2cT/phKnq7IQ2DNpXJLovXi0+18hczXWa/NnHUmaRTg2
         ujpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788554824; x=1789159624;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bt1HqSrLvYKEai7M5FJi0Yxz+CgX3DRE2Qu0CFMj0Ww=;
        b=YsJVHrYXf8oBmO7jIC9uIcFBzulU/QMArCuA6Iwz0eXKMYXGupGzGn2e0Dh5vfdoNg
         cTEb++7jDUr5l97bcpXid4VnwH/ssLbUWeTLYe3o9UhaYq0u8SWI2bKuNX1Dy+fJMuA5
         h7hF1uN0KfiVeOHdNtz1ViVo/AuLkPjyQ5zJ8ZxiB/ar7Dn1kG6iTDybPHcQM26FjUlK
         OQJkLaXtgZE6Vx9HinK2M5PEYrGc3aE0aqj4k9SCVyqt5EQfI+DoYddclQOCfVQ1b/u5
         MPyzX1nbXINSwjM7gULUsWf55YPCDpxPh5kiEhSuF0fg8MO3H/IvTISqKjTsDL+4s9eV
         nTUQ==
X-Forwarded-Encrypted: i=1; AKwUvByabLhy7CCa5wbyxKSVMfOi73d+rcrm9fXO6pm5Zyi9GAr30UqJSG9XgdqYPn3XZ0uVjyCJb8+J6hk=@vger.kernel.org
X-Gm-Message-State: AFuF++k3TZjZv/lKp1kKB6d5A5ucAs7bFPuhJNoJ2laF8vb8Xym6W2cM
	371RkrRusvWCbs98+ayIAcJY9py4VNON62pnO43y96DYuUSIsQNzy/H1
X-Gm-Gg: AYBFou2/YloNCh7Vy/SAHLGwNoresdjA97q/bxKuUE7YCKbHE5QiUMQGxKLL+/kCx+l
	PfO11alXwKqund6hSZY7rK713ASwxn0R1bNHH9m63anDSxeLKnc0+lBlh9HZRFrr6qVvj2xG/SK
	DzKI8Af2+6d1ZV9OrtdNY28WOa/D3rizJcFLlT+hy3la5VtS2LbBEftFNbFJ6BgNlb/Fq7DYYQ+
	pgce6e/f+Z3/uqXCQ89pDyPdNpiKC/tijSEYEQGNAcoAYqAn3DFaEK9KyVBjjxlgbCeEy9VRRXy
	VM4gYQ9pQBXR+Sp4M3OxmUKYtbNQ9TLi9iO8zREf613f9RyS/bmvuOgTwSe6I2V0FfJnNNmaNxl
	XXkK2KVxlEPtdvCK0SYzcowBYi4Q97MVSzpQ/hCHiM+BUCUMoi2f+crfbcoSyi6aEr2Qsy56e1T
	lJjKQOQW6VcdICB4zO/dlQhYz0nTC/BBkOs1VL2vDQTcn3awXldkKXeRNRUx3IM2EHPtpx
X-Received: by 2002:a05:690c:5310:b0:873:5ddf:d865 with SMTP id 00721157ae682-8735ddfdac0mr10268087b3.48.1788554823272;
        Fri, 04 Sep 2026 13:47:03 -0700 (PDT)
Received: from localhost ([2804:30c:94d:7300:da0f:c2c1:1aa6:43da])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714a0ae915sm26231117b3.24.2026.09.04.13.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 13:47:02 -0700 (PDT)
Date: Fri, 4 Sep 2026 17:47:56 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, jic23@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH v1 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <apsufKf-EOvTfpwf@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
 <d9b759d29fa8ca12b6cf083e180b2556ca4533f0.1788368334.git.marcelo.schmitt@analog.com>
 <20260903-liquefy-prologue-9ec914cccf04@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903-liquefy-prologue-9ec914cccf04@spud>

On 09/03, Conor Dooley wrote:
> On Wed, Sep 02, 2026 at 02:24:02PM -0300, Marcelo Schmitt wrote:
> > Document how AD4134 chips are connected to the host SPI controller
> > according to different wiring configurations.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,ad4134.yaml          | 22 +++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > index ea6d7e026419..d843c02a394a 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> > @@ -131,6 +131,28 @@ properties:
> >      enum: [ free-running, gated ]
> >      default: gated
> >  
> > +  adi,spi-mode:
> > +    $ref: /schemas/types.yaml#/definitions/string
> > +    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
> > +    description: |
> > +      This property indicates the SPI wiring configuration.
> > +
> > +      When this property is omitted, it is assumed that the device is using
> > +      'no-cs' wiring. When this property is present, it indicates that the
> > +      device is using one of the following wiring configurations:
> 
...
> I'd also really appreciate a dts example for a system
> with one-channel-chain or two-channel-chain looks, given the second
> device may require different supplies etc. I have no impression in my
> head of how the dt would be constructed, so I'd like to see wht you have
> in mind.

I've added the daisy-chain modes for completeness. It has the same semantics of
ad7944 (daisy-)chain, despite the wiring being different. It looks like the
supplies for the chained devices are simply assumed to be there (unless I'm
missing something?). Though, now that I'm checking how to configure AD4134
for daisy-chain, I'm not sure how we could set them in dt. For 3 devices,
we would have

    spi {
        ...
        adc@0 {
            compatible = "adi,ad4134";
            reg = <0>;
            spi-rx-bus-width = <1>, <1>; /* 2 lanes of 1 bit each */

            <supplies, clock, and other properties ...> 

            #daisy-chained-devices = <2>;

            adi,spi-mode = "4-wire";
        };
    };

But, the peripheral needs a register write to set the DOUT lines to 2-line
daisy-chain and it doesn't seem to have register access propagation. So, we
would need

    spi {
        ...
        adc@0 {
            compatible = "adi,ad4134";
            spi-rx-bus-width = <1>, <1>; /* 2 lanes of 1 bit each */

            <supplies, clock, and other properties ...> 

            #daisy-chained-devices = <2>;

            adi,spi-mode = "4-wire";
        };
        adc@1 {
            compatible = "adi,ad4134";
            <supplies, clock, and other properties ...> 

            adi,spi-mode = "4-wire";
        };
        adc@2 {
            compatible = "adi,ad4134";
            <supplies, clock, and other properties ...> 

            adi,spi-mode = "4-wire";
        };
    };
with adc@1 and adc@2 only set for register access. Even if not a dt-doc issue,
that might (probably) lead to interface issues. The top of the daisy-chain may
want to read from the other ADCs, but those could also be requested by IIO sysfs
operations.

> 
> > +
> > +      * no-cs: The datasheet calls this "minimum I/O mode". In this mode, the CS
> > +        line is not used (tied to GND).
> > +      * 4-wire: Specifies a conventional SPI wiring configuration.
> > +      * one-channel-chain: In this mode, the DOUT0 line of one chip is connected
> > +        to DOUT2 of the next chip upstream in the chain. Only the data interface
> > +        of the upmost device in the stream is in direct connection with the
> > +        digital host.
> > +      * two-channel-chain: In this mode, the DOUT0 and DOUT1 lines of one chip
> > +        are respectively connected to DOUT2 and DOUT3 of the next chip upstream
> > +        in the chain. Only the data interface of the upmost device in the stream
> > +        is in direct connection with the digital host.
> > +

With best regards,
Marcelo
