Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228739B944
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258329; cv=none; b=KYQv6Rt4zLKVyR7Aoh3exADxwmf+bgtbw9FEr3AzVN4AUfG7itNvIZ0/hIX7ra6iqi/X1qM3zUFqWlI8syL4eJr1QkhffbFqSQqKXNPpnjM33JE13OLx2HBKYYlIPLskQF8YwmAn66vOb5LcswabXU2Nd9iOuBQyR9huTIN6k4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258329; c=relaxed/simple;
	bh=n7CgoaZqr25unr4no0HsGwzLBnJCj3mA2MkjSjcOB6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGFLLb7YVUUhNQbsg+vEDUZIXmSeD3YDM/BKUrwurZGeIQgjQtnAludVDEWH87Ok65Nw1bWJIw9KYkbbNTFU0CrgnH7IjdAdKwc6BlxACLHoe3XfxFVn2g3kamlkHh02ZmJgoK8XbpSXANUDGo/jhDa/utkLHEOHoXAlO044IE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiM17znt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiM17znt"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-471eeac43bfso93403f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 10:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258325; x=1785863125; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tYZP5/3CgfmqEEWV1DMpqycEKSi9QwQIjdLpIqKHQGs=;
        b=XiM17zntFyKPA4+ixNMomTahiTpPL5Q9c47fVBj02gphkiT2ce/IhPXe6MAjENLgFc
         gzH9Zk11LdfcmyYMIgeiy9+oUZybXhnSX2Q4r5Owl30GchTuhY7Vu0uw/rhhT+CwTyLV
         25duh5XVSoUefEMRyO/tzfnhHdtzxkwPib5nX+URMxJ0XYNY9JXMMwPkkln6F0/H1k5+
         1U0Sr47V8sdWFocuMxa8RxgcOfI83zzuEHkVH9D4ZZKRYfe2MT1/9DJCNYuNfPd3J9fl
         UzKNiRTKlWHeig2uze5ylGrtfnXahbVXuEOLwuCZ8uwnfjFK1ax4slJT40mhrnqtb+Xn
         nwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258325; x=1785863125;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tYZP5/3CgfmqEEWV1DMpqycEKSi9QwQIjdLpIqKHQGs=;
        b=OYOFhNpfuGw96ZFQDhw3uH1b5EcrtdikGVJFuHvnSZPBdQSNFeqjUu3kGL3sqmBWuv
         nUb+mMKqGmUt9kkQ9dVoWkG9U4k+aAPi6k9XQ+Y30NaA7ngyaAyU7RPFaUmX/6hhk3cx
         x/7tBnNzK1pp+4vnBvwETMeF1cOJLhjd9Bu1gMoQLL85TLfF8NI4PXB2B/SJDgXPNrRi
         zOKOEy6jPo2AvZeN7R9j196OcBsYx8Bp6uFUSVReKBLOPCwcUUW8yQstWMBc+6NPgDEu
         MlZGMaeJNIn1i3rpq5qZ6FLZ2kLdo6GKnV5hOM4wkSKAIDrIuDj/t+j6vG0Xb/4ZjvRY
         nH0g==
X-Forwarded-Encrypted: i=1; AHgh+Rrtd4H1o0K14yELE1/dPEVH90b4l8LbSoPd28kUZXwls0b7gYzzV+l6ioBe1UMWht0Sz8hQqHun9/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeneMpz+spa/0wxu8zyrX37zDrPIlJRIanCJ02cln2tf+T6H2s
	BHZlDwPSZcRN1jeHv5M+9bUiIQpndFEGil4e9x/+zzvvb6Cnh9tklkAY
X-Gm-Gg: AR+sD12j8cNazXBw5Hog3GSPKDAjiGm0G7mD49pusYjQa69VbfH3VdqAPiX4DACtrYW
	3v3GjFD6KQCyLaxBRP1y7HRWEyNMfo/uIHfvHyip55yWEyB2FAIDdLiwzaNa/AXYWr6Hc6Flokl
	puorqFSNDpf+MgRmA+FmldApCl1XOgcesl/RouqXB3e/cC9iX0y+unoGi6IRNvtdFRskmEnCwIm
	J+zhFNFMRRtYSIrTN2hU0s0/wiXow6/r4dJNVM6qgFOSqO8rwLA323R/GweKM3R71JPyRECJ11y
	q7J2veXT1p6nhlZqj84vGLnVprAPibPlM5XAflqH1CTEQ6GsOCDm6Br2H944mHmcMwisuX54NfJ
	YcE4Xr/my7wh2+PIdgUoZatu/gPkdtAJU6rsVXjUJjEURbQddHy9gL7fAeXT4CHViaJgY3g==
X-Received: by 2002:a5d:64c3:0:b0:47f:9446:95a8 with SMTP id ffacd0b85a97d-47fb1f359a2mr4033641f8f.59.1785258324657;
        Tue, 28 Jul 2026 10:05:24 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0f039sm538560f8f.18.2026.07.28.10.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 10:05:24 -0700 (PDT)
Date: Tue, 28 Jul 2026 18:06:32 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Janani Sunil <janani.sunil@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, 
	Marius Cristea <marius.cristea@microchip.com>, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>, 
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <amjgbH3VpssOlFzs@nsa>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
 <e2118cfc-feef-4843-917f-844834ef4e60@baylibre.com>
 <20260725230445.60a445a0@jic23-huawei>
 <20260728-barrette-rickety-788b47da503c@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728-barrette-rickety-788b47da503c@spud>

On Tue, Jul 28, 2026 at 05:10:55PM +0100, Conor Dooley wrote:
> On Sat, Jul 25, 2026 at 11:04:45PM +0100, Jonathan Cameron wrote:
> > On Sat, 25 Jul 2026 15:55:01 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> > 
> > > On 7/22/26 2:54 AM, Janani Sunil wrote:
> > > > Some SPI devices support sharing a single chip select across multiple
> > > > physical chips by encoding a device address in the SPI frame itself.
> > > > Add the generic spi-device-addr property for describing these hardware
> > > > addresses. The property is placed on the SPI peripheral node and may
> > > > contain multiple addresses.
> > > > 
> > > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > > index 880a9f624566..b59d047cf117 100644
> > > > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > > > @@ -142,6 +142,13 @@ properties:
> > > >      minItems: 2
> > > >      maxItems: 4
> > > >  
> > > > +  spi-device-addr:
> > > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > > +    description:
> > > > +      Device addresses used when multiple peripherals share a single chip
> > > > +      select. The array allows one logical peripheral to comprise multiple
> > > > +      physical devices, with one address per device.  
> > > 
> > > "per physical device" for clarity.
> > > 
> > 
> > We may end up relaxing that again if multichip packages start doing this.
> > Fine to add that clarification for now. We can revisit when / if it ever
> > needs that relaxing.
> > 
> > > > +
> > > >    st,spi-midi-ns:
> > > >      deprecated: true
> > > >      description: |
> > > >   
> > > 
> > > If there is nothing useful the SPI core code can do with this information,
> > > I'm not entirely convinced that this needs to be a common property.
> > 
> > I think being common does make some sense from a standarization point of
> > view and it isn't obvious where to put it other than under spi.
> > 
> > > 
> > > And this only allows for one logical device. If we wanted to treat each
> > > address as a logical device (all with same CS), we would need #address-cells = <2>;
> > > instead where the DT "address" is two values, the CS and the device address.
> > 
> > Ah.  Good point for the adc@address or similar needing to match a combination
> > of CS and spi-device-addr.  Conor any thoughts on how this would be done?
> 
> I'm sorry, I don't quite understand. Why do you want to support both of
> these representations? Hardware wise both of these things would be
> describing the same setup, so allowing this alternate "multiple logical
> device" typically is not permitted. What even is the use case of it?
> Does it matter at all if you have one or more logical devices from a
> consumer perspective?
> 
> I do have an idea of how to solve the adc@address problem (you can do
> adc@address,spi-device-address like some other devices) but as I said I
> don't get why it would be needed.

IIUC, I think for the current ADI device it could actually be useful to have
the above representation given that, in theory, any of the logical
devices can have their own supplies, pins, etc (so it would help to have
each of them as adc@address,spi-device-address)... But we choose not to go
down that path (in previous versions) for simplicity. So yeah, not sure
:).

- Nuno Sá

> 
> > 
> > 
> > Also feels like this series should update the one use of the microchip binding
> > in tree.
> > 
> > arch/riscv/boot/dts/microchip/mpfs-beaglev-fire.dts
> 
> I never asked for this cos I maintain the platform and was gonna fix it
> up myself, but sure!


