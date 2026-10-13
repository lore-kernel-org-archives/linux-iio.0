Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9989651A151
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 15:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904540; cv=none; b=DnV9b/CwSLboJdCxzXM61e7p6jY2nRKL1jeSS7+43qQqsNBpAFCc6vAhFcpOCW+hbfXzIHk0o/ECkWKGrLCmAlW8hQqU6sjc1r19uEE2+h7mAaPr8uCqpHtyP81/BX7H0dC9EosLGbLR4U7K+bB/9mLdN0lOi39E0xbhyBhjfrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904540; c=relaxed/simple;
	bh=NapyJptIydBk5J98yC370DZ0xJWQKRaBbCy2B6XYHdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSO5NsrYKeBqUnfZSPdS6jfBJ5RFmBeWuHkY3kZdlV9TERSy42rB8XV1M+sC4QBIkNXC2nZNImBuoddI17cy/kuG8SoUK2ZJ2wNs/h1dNA5v7EzI/HWHakay+pKGvY/8bwIrm7ss3nKbeUrcJqsd6JwqAH/DM1K722uF645eVYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBR1jNe2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBR1jNe2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e8ad5b31c7so17165305ad.3
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 08:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791904538; x=1792509338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2rkGQo5r8xJBTb8dqMKiMW12xMK6T9au6oc+12YcxIA=;
        b=dBR1jNe2zWAjzp5Bc6vkfwkBFJT/e/xEeahREKd0JJot7RWYmlid9VLytpa/O3jrwW
         P5Ptck1EnD1e8U7lCGtukjez7EDLIMYgIVSGIfCbRg5zZe2bIeLv/0yrrfpgxzweip1s
         R0otIA3SH4LNMPXlLyxZwpZ/F3T85Ssk0Z/3V6Yo3ESx6iTitPmD7zfxRduALS11tctY
         jnNMq0SVZeOzUlal2D3yFrMeycUtMFX2h+/LR910q61QM97mZz5DeCK7fefFAI9fDhAJ
         zXF2aP7VzDt1z1GZrVbQkZKDyFsublEff2OzotGs8KhTDvcYAoGJoPCQ1tXyIqCrmhb3
         Ju3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904538; x=1792509338;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2rkGQo5r8xJBTb8dqMKiMW12xMK6T9au6oc+12YcxIA=;
        b=iXqFYUcQ0EYXJJ37pKZtYDg2NHdMBa7lzqg7cph0JckJcQ+LgLxzsQWi+Dk0gpt+gf
         MDK6gGSbc7SuAmwHZEsy+/n43gZSg/7yBJfD8xbyYe+GLO3Dwfl5NkT5EjUOEE9t1mUo
         1PdETB3+7xzbDZMKpmcbrWmY6pjidVTJFdpKJsIL8wMVHwMLDfPqT/8BlMDqbPdarF+s
         8lOUO7IuEfzbNJ7dphWUyjuyfV29mLXYGicfarkgWRbtBXok5tBR6KpuBMVsyjNTqLyW
         5ZVh4ZPO9tz/YLIUjA81PmIsEOVGFWB0zKSkeW82/tpD7tzefts+wbsJyr1h0Px6zm48
         yFLA==
X-Forwarded-Encrypted: i=1; AKwUvBwj9xrALWTON3+i82QNtcUKF1vlVBfFHZwdfd6e4fnpSmCpZEwZbtBBydNco9JiysBXkm9G6da3ooM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIk1fbaWr8G9sY2IWfHaB6Vc+VuaNktEheR5zKhfIBu5qb/JL6f
	SjLZKGv5WcEKDiEwyY9xZpbDRrH5PJ8Odn8Pww277OY83aG1ic3oQXgA4E+direOf8U=
X-Gm-Gg: AYBFou0FoZhNwNhipDid8YaA29PgFE+x0lZB5wix6lR0Es7106dlC+0XC6Y71yTkp2F
	WIQUUoheh8U+Hx9VLBiKe8txISkFFft4lsw7308SpLwGEpbHqA9xsYx0ctXJLstYzG5tuBBN4tT
	5zj5gSZnUoCY0u2K8dVHURCvCwBtSwPzce6GinIKsCBdmZRja5CLJmKLksHLkdjUwEN99diqQYj
	sf1WtTh7eiYowbuURSD8Awb3M5zIxXDstAkFNfqHbY+ErjWgaeEs/EAPr5P3RA16IppK7dnlFuj
	eTVtPHtPcjKktGpQna+zOUruDsEqvd+sF7yhoXkoUzhFSwIiKDNdnzYJ0DIVePg+HEMeusqiEPs
	XiPYLnolYOaugl5799RIjVba9lauGpCvr9lhdYVXhL7eYjEWBVUfWf+eRQhLbrXq66GH2hqYZdO
	umtY3pPUeOIFWeSTiP1eyO4LyZiCoGnpsPQK7yeSZFmabLFzaz6OZv9J7/X/ngK6ezocct4qetj
	g==
X-Received: by 2002:a17:902:f54f:b0:2e6:1a1:ef63 with SMTP id d9443c01a7336-2e842cdb1e7mr112815415ad.44.1791904537778;
        Tue, 13 Oct 2026 08:15:37 -0700 (PDT)
Received: from localhost ([104.156.230.40])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8c4csm58698205ad.56.2026.10.13.08.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:15:37 -0700 (PDT)
Date: Tue, 13 Oct 2026 23:15:21 +0800
From: Chang Yu <marcus.yu.56@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Chang Yu <marcus.yu.56@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shi Hao <i.shihao.999@gmail.com>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: light: add as7343
Message-ID: <as5LCasyTFjTNL0x@zephyrus-g14.localdomain>
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
 <20261013115639.167433-2-marcus.yu.56@gmail.com>
 <20261013143639.000017b9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013143639.000017b9@gmail.com>

On Tue, Oct 13, 2026 at 02:36:39PM +0200, Joshua Crofts wrote:
> On Tue, 13 Oct 2026 19:56:38 +0800
> Chang Yu <marcus.yu.56@gmail.com> wrote:
> 
> > Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
> > with i2c address of 0x39.
> > 
> > The GPIO pin is not described because the datasheet does not document
> > how to use it for hardware synchronization at all. The GPIO register
> > also has no mode-select bit to isolate the pin from the chip's
> > internal control logic. Exposing it as a generic GPIO could result
> > in kernel writes being overwritten by internal logic.
> > 
> > Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> > Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> > ---
> > Changes in v6:
> >  - Add a ref to leds/common.yaml for the LDR pin.
> > 
> > Changes in v5:
> >  - Remove the GPIO pin.
> > 
> > Changes in v4:
> >  - Fix led-max-microamp property name.
> > 
> > Changes in v3:
> >  - Add missing include for gpio.
> >  - Expand GPIO descrption to include hardware synchronization.
> >  - Use led-max-microamp instead of led-current-microamp for the LDR pin.
> > 
> > Changes in v2:
> >  - Add the LDR, the interrupt pin, and the GPIO pin to the bindings.
> >  - Fix node name and unit address mismatch.
> >  - Include MAINTAINERS changes.
> > 
> >  .../bindings/iio/light/ams,as7343.yaml        | 66 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 ++
> >  2 files changed, 72 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> > new file mode 100644
> > index 000000000000..7fb10b0d4843
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/light/ams,as7343.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMS AS7343 14-Channel Multi-Spectral Sensor
> > +
> > +maintainers:
> > +  - Chang Yu <marcus.yu.56@gmail.com>
> > +
> > +description: |
> > +  The AMS AS7343 is a 14-channel multi-spectral sensor with i2c address of 0x39.
> > +  https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ams,as7343
> > +
> > +  reg:
> > +    description:
> > +      I2C address of the device (0x39).
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description:
> > +      Open drain output active low interrupt pin.
> > +    maxItems: 1
> > +
> > +  vdd-supply: true
> > +
> > +  led-max-microamp:
> > +    description:
> > +      The driver current for the external LED connected to the LDR pin.
> > +    minimum: 4000
> > +    maximum: 258000
> > +    multipleOf: 2000
> > +    default: 12000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vdd-supply
> > +
> > +additionalProperties: false
> 
> Should be unevaluatedProperties as you're using $refs in the binding,
> but Jonathan could tweak that when applying.
> 
There was a discussion about this back in v2 in which Conor was suggesting
keeping additionalProperties: false if I recall. I don't know the exact
pros vs cons so I'll defer to the experts here.
