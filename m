Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A5E3DE421
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782842239; cv=none; b=e5ZrDw/hRFKbTJnRLaB+twNP+GJC7GLQkcqRU1YdF9rf0wuX91TLmEtuVThUXSPTu5Hhbu/J0+FgwnWe53mxThncLeq/IX+V3VH3uLVvCG2ex5xza/DewXv59E5A1yJoXCLIK9RrzhtCe3SUdx1qOMe+srxOKYCnnVp8RFw6ZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782842239; c=relaxed/simple;
	bh=DfodaKs73ASy+k9kkxlyhApLwpcDTKXLkhb6UqXhIMA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=fa9JrM7nm62oIG/5vnhzurllU8u3OXZt1olNf/Rn3VvEBpNCdksHNTmVA30brrH0fTT10R5WooVtTmAFA4x/2Jk2ilmK0ONAH7h3XNYsfTD0RFzMUxNpHM4VuO0vSUdEuUon/IRt7eS/EeZqhDrefOKeXdLVwPgb5FUU0JQViYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MH6y4cXI; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH6y4cXI"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-96925a563b5so564251241.0
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 10:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782842237; x=1783447037; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zszSd/4534beWTeNxatevOKQZCXmJgc2+K+OkRrzhYA=;
        b=MH6y4cXIQHtzWOX0ukzUsoQtTPrKyk+c1rYTcbxpxfwLB1R9s157OXINeesLk0/X2m
         UQ1p1LWB/WW13/cG7malX94uQDw73Bt6hYVVxCLBTlDhzi2iRrVhZu8tXeo/6i9B/FQr
         OvZ5fhKZDSZ24eZeOGIud63yoRYvLfAJdsTPpHwf9jbhVjfDL2eekrBvc4f9FJrPDPCN
         MKOrqkwtMo8+zrdNRCs5IE0cn2dD9ARyiNjuCA2z8uL9HMxPTQomw8n/ku5RO0HOHCv6
         z0Hocbrzj/EHJeWRxdDB9F8aMrXnMxBhTzYhzeh7AeNSBezsOyDHfYo+DKKB0ibmDu6x
         mOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782842237; x=1783447037;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zszSd/4534beWTeNxatevOKQZCXmJgc2+K+OkRrzhYA=;
        b=sY752VaPpRdFdEAO/MPP1UoIfAzAaOx6Tr+jR3+fCkBwpb0Qcl0+EmMG2sZCLtCnKc
         t1dhpkCld7daQYut9sRSQOuMqhQ/phN5g789GPFWIU06YopPOOAKoxb5KvHjioR4mkIl
         0FgaW9BEylPN9vDybsnAgbRp5jltTiS8FGd4OcHIHHgLja/Ng/oAFv7oB/KqP8QDCXHy
         OAj0iYcka6QTzk97KDsMUOvosXBP36MaOSUeGzDg47st4flEbFtXs/BT292Ky3n5mCtE
         N9ZnQ7yQJwKdrvI6hNAeXBdD6ieZUFof7KBrD7ftYLWwgHVXQsKZiZlOd/yDZqsT2Nnn
         9y8g==
X-Forwarded-Encrypted: i=1; AHgh+RrWvxUKXoNUuJsSyrun/OBF7bbKaiEN7td5hYw9Hdp5Pwf3MKwOG0US8Po6k9NEBXvK//LuJ6zwhXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBH5F/Nqi6lSVaYxoyOQOZS0cXXhYbAvONbyQwmNLo5BEmVs+n
	JFQKidYAaK32j2L6YJYwZkqI/9vexqbHwsHC/6u0YE8LNKjHwVx7T2/K
X-Gm-Gg: AfdE7clDRpM0IAveNZoGwtv3XkbMUgVOKjPmGO0ZmvSJb3t4DQnnZ+953jHnv2XjnAn
	+kvjjvhhzUxI6n8Q6EruZU7HPZob6z5je/oofzYjXmDsfTDbq+OJrzpnDJ62fz2pQr2HXVvBZxi
	bLlfQUWW28w8SS1Uwkk8jomMytcKpON0dXj4vLorIIpu1f5A3ctMdXJmemgg8hl7AytTEnFqupc
	tosD1WPt1ZKOuzKrBeH2xnNAsgNlCddPSxRDSky0F5yYKDIM7RuDC0pjzBE68lx3Hw/DbQjEsVr
	hSYu+xChC8jsxfAWN/ajxhISZJ1U0pAOESjKdkLJ7vcA4FLKs88fPWb26MevH6g8mtyhgCQlyS1
	/sFg2KS98IdOzfPxT1ITQ7urYwSBEQPB5Y2vo7EVh/AKY/vVw0ZpdFTHqxGKsyFbCCtb/aJ3ChJ
	MkYailxJgBxmzSug==
X-Received: by 2002:a05:6102:370e:b0:632:5db8:f672 with SMTP id ada2fe7eead31-73bd337b103mr1022815137.6.1782842237357;
        Tue, 30 Jun 2026 10:57:17 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-73a81c973dcsm1493120137.2.2026.06.30.10.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 10:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 12:57:08 -0500
Message-Id: <DJMKTP1FHTIY.161J5V5PQF62O@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>
Cc: "Kurt Borja" <kuurtb@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] iio: adc: Add ti-ads1263-adc2 driver
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260628-ads126x-v2-0-4b1b231325ba@gmail.com>
 <20260628-ads126x-v2-7-4b1b231325ba@gmail.com>
 <caf89e08-6ce1-4dbb-adc1-7fbb2a60fd7b@baylibre.com>
 <DJKYDBR2CR3V.JU80TA4QDQLT@gmail.com>
 <8da7db13-5c6a-42cf-8546-f0e580c3b278@baylibre.com>
 <20260630020052.4ab593f4@jic23-huawei>
In-Reply-To: <20260630020052.4ab593f4@jic23-huawei>

On Mon Jun 29, 2026 at 8:00 PM -05, Jonathan Cameron wrote:
> On Mon, 29 Jun 2026 11:38:26 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
>> On 6/28/26 3:08 PM, Kurt Borja wrote:
>> > On Sun Jun 28, 2026 at 12:22 PM -05, David Lechner wrote: =20
>> >> On 6/28/26 12:36 AM, Kurt Borja wrote: =20
>> >>> The TI ADS1263 embeds a second 24-bit delta-sigma ADC (ADC2) with it=
s
>> >>> own input mux, reference, gain and sample-rate selection.
>> >>>
>> >>> Model ADC2 as a separate IIO device on the auxiliary bus: the ti-ads=
1262
>> >>> SPI driver instantiates the auxiliary device and exports a small set=
 of
>> >>> TI_ADS1262-namespaced helpers for the conversion and register access=
es
>> >>> that must go through the shared bus. ADC2 channels are derived from =
the
>> >>> parent's configured channels.
>> >>> =20
>> >> Can these just be additional channels in the main iio device rather
>> >> than a separate iio device? =20
>> >=20
>> > I guess we can do it, but wouldn't it be quite a mess? I think doing i=
t
>> > that way adds a lot of complexity: channel naming, available scan mask=
s
>> > (because both ADCs can be sampled at the same time), optimized softwar=
e
>> > sequencing would only work in ADC1 channels, ADC2 doesn't have a DRDY
>> > IRQ, etc. =20
>>=20
>> Channel naming is easy, e.g. just add 100 to channel and channel2 for
>> ADC1 and 200 for ADC2.

It wouldn't be the end of the world, but it would be confusing without
some documentation or without relying on channel labels.

>>=20
>> And if ADC2 is mostly for diagnostics, do we really care about trying
>> to optimize it?

Oh I meant the ADC1 optimization, the ADC2 has no optimization
considerations.

>>=20
>> >=20
>> > IMO separating both drivers makes everything simpler, easier to
>> > understand and easier to maintain in the future.
>> >  =20
>>=20
>> Sure, I don't have any strong objection to doing this way. We just
>> usually try to avoid multiple IIO devices for a single chip. Although
>> one of the exceptions to this is when a chip has independent cores.
>> I guess this fits that description, although it is a little muddled due
>> to sharing the same input pins, sensor bias, IDACs and probably a few
>> other things - i.e. doing buffered reads on both cores at the same time
>> requires a static IDAC output to avoid issues.

Yes, the IDAC stuff is the most annoying detail. The datasheet claims:

	All input configurations (channel select, IDAC, level-shift,
	sensor bias) are available to ADC2.

and is technically true, but IDAC configuration is not independent so
it's really up to the driver to make it "available" to ADC2.

My approach for now is to not support the IDACs in the ADC2. This makes
sense for me because I can set a static IDAC output on ADC1 and sample
ADC2 on the side.

I can support it later though, shouldn't be too hard. When ADC1 is
sampling just one channel we can -EBUSY, when there's more than one
channel reads are already synchronized so we can just switch the IDAC
without much trouble.

>
> There are (I think) still some gaps in the multibuffer support.
> Ideally we'd have long ago solved those, but without that (I think we
> can't support different triggers for example) I'm not sure we could do
> this as a single device if we support buffered capture.
>
> The question that comes to mind is do the usecases for this 'debug'
> ADC need that support?  If it were just sysfs then a single device
> would be easy to do.  On the other side, splitting it is up later
> isn't something we can easily retrofit.  There is precedence for

IMO the ability to buffer read ADC2 at a much lower trigger rate is not
_absolutely necessary_ but it's still very confortable. And although the
code simplification is not that HUGE, it's still significant to me.

> multiple devices like this for sensor hubs (also driven by the lack
> of complete multibuffer support).  That doesn't hit all the isseus
> here though as I can't immediately think of a case where properties
> set for one iio_dev effect another (I didn't check though!)

All channel properties are independent, except for the IDAC stuff
described above. As for the Sensor Bias (burn-out current stuff), if we
end up only having sysfs sampling (_burnoutraw) then it's not really a
problem.

>
> To me the multidevice support is fine - particularly if it's optional
> - so the sub driver can be skipped if someone doesn't care about
> this extra ADC.
>
> Thanks,
>
> Jonathan

--=20
Thanks,
 ~ Kurt
