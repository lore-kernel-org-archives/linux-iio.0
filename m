Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1437934B1A5
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035643; cv=pass; b=gFKruXp1imCSw8msGqGOWuOI6lGtu76MMaqoLk9D5qiCoDfWJmJrYwmXWhUuAYKJ9AfLkcB7bro5nsyRVOZXvtQyl8yTnxA3Pt571C397fT6zw9gurL9n4IgVPTThyAQSp8MOMoxyptkEcY5zghJDsSgO2gu1SESsrgGnXwuBH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035643; c=relaxed/simple;
	bh=Hqx+/2gwUQf5oktWMVU1iaI86zBAPEpohyRmf9hMejs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDGmVzPsBx7VJwTYOzDd8viyav0gYsjfekBUToqayzdVwEKRTkvQHmcIEP4NGfxOPOvwcLCEyxWG6KKMNsW59Zw+9CORD3HIx9uSgyUKq+fU7R2RqHGRAi0ex6QGnja6b5KOkFA8I/nXIH+WwXER4mfKYcoK4iyrOlvQa5ixol8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egSKewjS; arc=pass smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egSKewjS"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso617050a12.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 06:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784035641; cv=none;
        d=google.com; s=arc-20260327;
        b=IAYy2mEqzS5uMsYx7ZVoIdZjQyTXFESFcRBMmCeCFpBMq0YPvMuleMZFLrcYFP7IAL
         bIjHLlQ0cKstFExF+kUFgUha/K2vq1ldP/Fv2fRhrjbWeiTuDOhiVARATwuhqfhT2Ovp
         KWn3/adDJd8EX+Juj9L0mSAolnl7i1gYJj92N116uOElSwg3JPyQqjrIDz1nh986LJzB
         PIDUyC7UHyvVE+e29+32LM27VX8Yt8YYqRda+uizbQA3KZktIO7Xf+xWSn445Is1ellr
         r4unaik6RUQB6qkudI4yNqkPcp1p1k4KZP3cWinjFXhkNcnXqhZ3O5Yx94h+KqBwm0+p
         7aaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PSq/mUWM2YvpW32XDTn1fQtxRJbdlACjQCMNg3wpfiM=;
        fh=X7o1tS9Lb8hrAdpoJnRZBW3GO64UdtgM2OcBLNbdmvw=;
        b=WiwFLzbW4UoeRshwByHuBVQdRCivsEktBW7LwsnBX600W4ZhB97TK3qajfib4pz0TO
         JCSZXGTlCZL8stI5vnB+uE29M0vzRynBICAfpKOqwZJNG6PC3R2UVIqAPuCylZi/k42K
         7q1lS18d2X5LbK1xT1FaSo6z/IQVPj3a49FW6Y4RIDZTRwHUohSDcbTuxuFbptfiWsnS
         K1GrisOHglVRF7UXeBO05xwhhvera+su45kgHD/sF3HYeq1TC2mH/tFQgpLC/n52A/Pv
         kZxVvF5l0tm2qjMevQCarj2E9FH4Fgoyf/cMFpgKqAPgoexS5sDL9IMAHC1Jv4mVv6Ei
         PMuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784035641; x=1784640441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PSq/mUWM2YvpW32XDTn1fQtxRJbdlACjQCMNg3wpfiM=;
        b=egSKewjSB9QKWsQQJRVJxdBUYM87L3b2NzHjTXY2e4Lyrhp2z86pdRrS8fcXMNTw3m
         EXgJDomP8VGJNhY6mFQX3GG4onLh2IeZQaS7sh1lgkvjgT2vWxMR/eICi0cUg8kz7xv2
         r5c9voSjZr145JyTG74rT2ZgPcvogC5asUowiQ+oum+MXEuQzsLme9xiAk28xOZruLIa
         +YMgud91p92rVOdeACWN8wzl7tVSMLbF2oYYaUdUrr/qqq88DJE4ZN5Ni1h7BTnQBNMM
         i2OG54H6DA//CUQ08xfVEiYxayqkjHU5Y+uzlQcbs9v61CbLoF8FD7MaKOJ9oij+Jcvp
         T+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784035641; x=1784640441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PSq/mUWM2YvpW32XDTn1fQtxRJbdlACjQCMNg3wpfiM=;
        b=MfueACzQEGQFE1fOWm0j+c189u/soXRWOileQ9bBeOqZgfsNtIgVxf5SpcHiMhGn1D
         uL16UruB2JGtpCDZQavoZOjRO/DmyBc/5lnk+6oCu0mEeb66rG5iwOIFiF/f6DVOeZmS
         RSO1/PpxaiyN7mbFNGz/pJkqQMVH4LtSYCOAZNN+epIpuNk9Hdi4tOZPbVz5uychQJQM
         2QWrkHgbMm1+AdrUzO6cvRgJadSBGOPkVTzTXvjnpj+ITZwzZxTzx2U4Fl2LEgpq6pem
         hq6uEHmh5SzSlM03eAz5kV1Dera/yMg+rj70qoAfWBJP3XLIyqEDJBXG+fgobDN4lgbW
         15+w==
X-Forwarded-Encrypted: i=1; AHgh+RpVCIjh+xdp8GMMFHVT6T0DccMPvHdDP0BifDIISMww0HVd6fgdIc0QMpbSXnt1mfXqRWhIV9KbgV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YztrOna/lE3cqLI0kZNRB3x7xLH1mcZmQWLxlLUwary1aN3oDpl
	7IoyXWXrjSmeAdNHTzbK/6uV+kE7QrbQwI1hsN2O3p+1UkV/Drd8EADzuvmHNqeg+M/DJBRblSd
	MqoIFw512TYmXgUlQwVy3ijfD923sK/4=
X-Gm-Gg: AfdE7cmZMDA6KfE7a+GbyyIb2++W/uVfoKzXGta2ljCGav6sR+tk02djRG5hPVBuVGK
	rr9AfhYyz+pK0mTJSydTO3UJoP2TQ2VgLfoKCxgzAm/4+RsdsbGPnZfObgeO8XKYtLIlD1xW0R1
	b9dzHlv8t+WzL4gw6HvfSYkpSaZPPCUVnYPArMOr3uFkZjyfjSOFxPMbm+BUSxsxFeuIVFk7T30
	J4PlxerohF0M9koEDVy0HC9pbgXXUbl2kI3dLlDkA73vBv3CUd4O/AwaYyS/kidwIF0UVLZZZ09
	SiUK10NR5Zk6ZqEtZcOMAyiXA6RB9Q==
X-Received: by 2002:a05:6a20:d70a:b0:3c0:b55a:80ff with SMTP id
 adf61e73a8af0-3c11063d595mr14450342637.24.1784035641387; Tue, 14 Jul 2026
 06:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-2-clamor95@gmail.com>
 <akeFmMQ_S1Y18hlu@hovoldconsulting.com>
In-Reply-To: <akeFmMQ_S1Y18hlu@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:27:08 +0300
X-Gm-Features: AUfX_myw9KUnmAWsWcXDIJL61TlrVu8UIEI1kefy-2iSBs3h-OI28TD8pRQoND4
Message-ID: <CAPVz0n23=F2Q2fSJJx1E_mST2zhomKcvhKtOy-Af3aoq-pZ-Zw@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] dt-bindings: leds: Document TI LM3533 LED controller
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 12:49 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:18AM +0300, Svyatoslav Ryhel wrote:
> > Document the LM3533 - a complete power source for backlight, keypad and
> > indicator LEDs in smartphone handsets. The high-voltage inductive boost
> > converter provides the power for two series LED strings display backlig=
ht
> > and keypad functions.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Jonathan Cameron <jic23@kernel.org> #for light sensor
> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backl=
ight
> > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +
> > +    i2c {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        led-controller@36 {
> > +            compatible =3D "ti,lm3533";
> > +            reg =3D <0x36>;
> > +
> > +            enable-gpios =3D <&gpio 110 GPIO_ACTIVE_HIGH>;
> > +            vin-supply =3D <&vdd_3v3_bat>;
> > +
> > +            ti,boost-ovp-microvolt =3D <24000000>;
> > +            ti,boost-freq-hz =3D <500000>;
> > +
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            backlight@0 {
> > +                compatible =3D "ti,lm3533-backlight";
> > +                reg =3D <0>;
> > +
> > +                default-brightness =3D <113>;
> > +
> > +                led-max-microamp =3D <23400>;
> > +                led-sources =3D <0 1>;
> > +            };
> > +
> > +            led@2 {
> > +                compatible =3D "ti,lm3533-leds";
> > +                reg =3D <2>;
> > +
> > +                led-max-microamp =3D <23400>;
> > +                led-sources =3D <0 1>;
> > +            };
> > +
> > +            led@4 {
> > +                compatible =3D "ti,lm3533-leds";
> > +                reg =3D <4>;
> > +
> > +                led-max-microamp =3D <23400>;
> > +                led-sources =3D <2>;
> > +            };
> > +
> > +            led@5 {
> > +                compatible =3D "ti,lm3533-leds";
> > +                reg =3D <5>;
> > +
> > +                led-max-microamp =3D <23400>;
> > +                led-sources =3D <3 4>;
> > +            };
> > +
> > +            light-sensor {
>
> Doesn't the binding (or dts) checker complain about this node not having
> an address?
>

No it does not

> > +                compatible =3D "ti,lm3533-als";
> > +
> > +                interrupt-parent =3D <&gpio>;
> > +                interrupts =3D <80 IRQ_TYPE_LEVEL_LOW>;
> > +
> > +                ti,pwm-mode;
> > +            };
> > +        };
> > +    };
> > +...
>
> Johan
