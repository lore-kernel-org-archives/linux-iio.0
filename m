Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B546513D8B1
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 00:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782088359; cv=none; b=YRXB9uzDSWwpqLub4RHbklnVR4YzLoQBabFdr7xzdLuTX2lgULgd6m5tDJvNIMd/zL7xvcDDQTRWCXobmcH/rPgQloMD01c+3nwrj8rY/wSoPClL+fg5sNoPu0SFeM1BLQDmNGJ35UP+AVBZkqvEJ6fNJh22QCYujUj9JUeX49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782088359; c=relaxed/simple;
	bh=cUisQLFRsURZfS85m/2Dh/uhROQZRUBGJNUYjKys20I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ruQyiOFtkY/YeDlD6lrDMKeGqSxRHKJ0z6h1z6TQtdxbGP0uerDKuWAU3DEqbj+rKXp4oHcpefcxzl1UofSrtXJjfXoTjLt0VMuq/L7UHa7NRQGitcgP23MzoYA7gwwKUWC/dmryNB59Hf6URi9XQ1A9CnWBMii8+3mSfnBXKsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfYYsLxI; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfYYsLxI"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5b22b023e1dso2248932e0c.2
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 17:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782088357; x=1782693157; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiv8NIXgo0QMaAneD0dYAgas4YcxF4gZNjfT4OS1uuA=;
        b=BfYYsLxI5Wt3xywCQJonYG5P7jKDGvOsac83dY73NYlrE3NvERegvf8Sh6enTnCwC0
         W3mG6K97qxsw2+BPsLmfm6La8p6B+IyJ6uRv2P61KWbxu69LyztEYRtl5XwUHkfhAI2Q
         d7tpseGho/0rj5SC2e9vUVeuBDkpo03hQ9VfvXgSjKf8y77PZTflwXSUD84mybdthwvV
         Q1BNJy7UmKlRQPZslPcLo6hnt99cDbA9TU/ulhuX6pn5MLt9d05JppSXig1z2jvQw82k
         xFFQtxrp+7dcWPATdK29e7l/LmDT3NZuTXRNiUinInSAl4WOGMzF0qNRUuwv3CcQbdhf
         irZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782088357; x=1782693157;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eiv8NIXgo0QMaAneD0dYAgas4YcxF4gZNjfT4OS1uuA=;
        b=Inq0SS6BIrlS5ZVepYM01yRZBrWPuHD3yNT+yJ8oGTKRUXNQqUg1BUrQ3IxIpLKTll
         7nmly+l/074mhUHxH3nQX0/X9KRtsPpfZgST1aUreoAAHYPrUuUDy2iBLmklW+oMh/pT
         fVkfQ6drZP7be4c6NHTIbWfvW/LogQHOn+Zp3vmajrf4yjUtwJ441jpYxTgYkDZIw3zR
         43QjxuWYmJOR4eRfk5jkNs6KXNJR8fNXVKuE/zO2zFzSIEwCTV7xj64ahVBY+mG/RIne
         uvdFyR0tVjYgweIX1qalXb9vIgYZ+MpGPP0TSqfvFHrvNzNu5f7CtjwNFsTgyO5Dfsje
         KyWA==
X-Forwarded-Encrypted: i=1; AFNElJ94KTbieF+pYTLrAzfJiItbyAIdXmaE0WQ5NM0mb4Bq7X0fJUAAtGWsaFL6D0vPSrNL+5WFfjaUjpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrHj5iqAd7/UTOGeZhyrnDojI9P2AZ1H5Lw/dD7wiRdJ1XAvif
	k2tLDcch69IiWzT1nyf9jS5Aq+Y0IKswoeX5YoQKKoMeZgQY3w6Ib6u8
X-Gm-Gg: AfdE7ckX2i373DJECfb+hsuMY1DD1RPv1/9p1bTf9xrccN3Z5XGTkdP5fgbWqNVujbK
	z+BQSZR505X8MnFGWk4sgaJQ44uvFn4ZBBQmLUzLsl6Ik6oB3KfAl7A881HszchHKzYdqiSbOyv
	A2uD5R1C8VmyL45qfcA5ex0A+dXVpTXAtyU7cghP5bE6q6ZeeBUAXnWkrJxVNeqnMPT+FnBGTmq
	9BkZ9x+39KsWUmVmRK9qYpF37woNxZo9T0EDfo4wmDosdhcM3yF423jukxGhpWG2NsdTI4HYrSm
	VitloZRwWjHmINSxGWCLHQT0yLzszvvr0z5oe9lgW3q1cPaJ3J9aY6QxJKxN7N+6NcBPWDofPOG
	gwF9gcOB7hy84Sp0INc4E6T0b/mcVxAQZZPXdQpqE6CrwT5CuioPeKPZti+ehpIO3rDB1HsoihK
	vhMzs=
X-Received: by 2002:a05:6122:1807:b0:5a0:2018:4dfa with SMTP id 71dfb90a1353d-5bbeba5a9cemr5647255e0c.3.1782088356755;
        Sun, 21 Jun 2026 17:32:36 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbfb7d30besm5506475e0c.2.2026.06.21.17.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2026 17:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 21 Jun 2026 19:32:29 -0500
Message-Id: <DJF5LHOE6368.2QCY5LIPT8098@gmail.com>
Cc: "Kurt Borja" <kuurtb@gmail.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Nguyen Minh Tien" <zizuzacker@gmail.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] iio: adc: new ti-ads112c14 driver
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <DJA1J8D91ESA.2XU7OCVKN7LXU@gmail.com>
 <d3270250-ae18-4c0f-a0fe-e0fdabfce046@baylibre.com>
 <DJANEYYA4QTA.1JBN2L78PNXDD@gmail.com>
 <9b8d5cfc-e392-45aa-9adc-867c364dd36e@baylibre.com>
 <20260621201412.0ce54fa8@jic23-huawei>
In-Reply-To: <20260621201412.0ce54fa8@jic23-huawei>

On Sun Jun 21, 2026 at 2:14 PM -05, Jonathan Cameron wrote:
> On Tue, 16 Jun 2026 13:16:46 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>
>> On 6/16/26 12:26 PM, Kurt Borja wrote:
>> > On Tue Jun 16, 2026 at 10:21 AM -05, David Lechner wrote: =20
>> >> On 6/15/26 7:18 PM, Kurt Borja wrote: =20
>> >>> On Mon Jun 15, 2026 at 4:59 PM -05, David Lechner (TI) wrote: =20
>>=20
>> ...
>>=20
>> >>>> All of these chips have in common that they are designed for use wi=
th
>> >>>> RTDs and thermocouples and so they look very similar to each other =
in
>> >>>> terms of wiring and feature set, even if the register maps are
>> >>>> different. They are in the gray area where we could either keep the=
m
>> >>>> separate because they are just different enough, or we could do lik=
e
>> >>>> we've done before with ad_sigma_delta and have a bit of an abstract=
ion
>> >>>> layer for the register differences and otherwise try to share as mu=
ch
>> >>>> code as possible. Normally, I would lean towards keeping them separ=
ate,
>> >>>> but in this case, I'm considering trying to share code because the
>> >>>> devicetree bindings for the inputs is complex and is going to be mo=
stly
>> >>>> the same across all of these chips. =20
>> >>>
>> >>> The channel configuration is indeed very similar for the three chips=
.
>> >>> All three have IDAC, BOC and VREF configurations. =20
>> >>
>> >> Hmm... I forgot to include the burnout current in the DT bindings. Fo=
llowing
>> >> the channel =3D "conditions for measurement" pattern that I have set =
out here
>> >> I guess that would mean that we would need to have the same inputs tw=
ice
>> >> when using the burnout. One "channel" would be the one used to do a "=
precision"
>> >> measurement and the other would be the one to do open/short circuit d=
etection.
>> >>
>> >>
>> >>     i2c {
>> >>         #address-cells =3D <1>;
>> >>         #size-cells =3D <0>;
>> >>
>> >>         adc@40 {
>> >>             compatible =3D "ti,ads112c14";
>> >>             reg =3D <0x40>;
>> >>
>> >>             avdd-supply =3D <&avdd>;
>> >>             dvdd-supply =3D <&dvdd>;
>> >>
>> >>             refp-supply =3D <&avdd>;
>> >>
>> >>             #address-cells =3D <1>;
>> >>             #size-cells =3D <0>;
>> >>
>> >>             channel@0 {
>> >>                 reg =3D <0>;
>> >>                 diff-channels =3D <1>, <2>;
>> >>                 excitation-channels =3D <0>, <3>;
>> >>                 excitation-current-microamp =3D <500>;
>> >>                 current-chopping;
>> >>                 ti,vref-source =3D <ADS112C14_VREF_SOURCE_EXTERNAL>;
>> >>                 label =3D "rtd-precision";
>> >>             };
>> >>
>> >>             channel@1 {
>> >>                 reg =3D <0>;
>> >>                 diff-channels =3D <1>, <2>;
>> >>                 excitation-channels =3D <0>, <3>;
>> >>                 excitation-current-microamp =3D <500>;
> Maybe use an example with more stuff changing? Do we want same excitation
> for burn out? I've no idea.
>
>> >>                 burnout-current-nanoamp =3D <1000>;
>> >>                 ti,vref-source =3D <ADS112C14_VREF_SOURCE_EXTERNAL>;
>> >>                 label =3D "rtd-diagnostic";
>> >>             }; =20
>> >=20
>> > This would mean we wouldn't be able to use iio_chan_spec .channel and
>> > .channel2 to describe inputs because of duplicate sysfs attributes, no=
?
>> >  =20
>>=20
>> Yes, that is a bit unfortunate. At least there the labels to tell them
>> apart. I guess we would just need to use consecutive channel and channel=
2
>> when dynamically allocating the channels to avoid conflict.=20
>
> From a very initial look, maybe do something similar to the folk have
> been looking at for the more complex DDS devices where we have lots
> of channels that are on the same 'wires'.  Basically add a numbering
> scheme to keep them reasonably separate - channel numbers are cheap.
> Maybe first channel is 10->1f, second 20-2f etc.  They are differential
> so it will get ugly.  Perhaps have a play around and see if there is
> a reasonable channel naming scheme for this 'same inputs, different thing
> being measured case'

May I also suggest having some sort of IIO_VOLTAGE_DIAGNOSTIC channel
type? Would that be worth the trouble?

We could also maybe just drop burn-out current completely from
dt-bindings and add IIO_CHAN_INFO_BURNOUT_CURRENT. Given that this
feature is only used ocasionally for diagnostic purposes (I assume...).

>
> I'm not yet sure I'm convinced that a separate channel model makes sense.
> Even less in the DT given these are different settings for one channel.
> That doesn't mean we don't split them up in the driver if channels
> are the best implementation / ABI to userspace.
>
> Basically nothing actually says diff-channels numbers match the
> userspace ABI, so break that link.
>
>>=20
>> >>>> This makes things more flexible, but does make the driver a bit mor=
e
>> >>>> complex. For example, knowing when the current output needs to be
>> >>>> enabled or disabled. For now, I have chosen a lazy-enable where the=
y
>> >>>> are not turned on until the first measurement is taken that require=
s
>> >>>> them, but then they stay on until another measurement is taken that
>> >>>> doesn't require them. This can lead to some oddness with the diagno=
stic
>> >>>> channels that may be measuring something that indirectly requires t=
he
>> >>>> current output (i.e. the external reference voltage when it is conn=
ected
>> >>>> to a resistor rather than a power supply). This means you need to t=
ake
>> >>>> a measurement that requires the current output to be enabled before=
 the
>> >>>> diagnostic channels will give accurate readings. =20
>> >>>
>> >>> This is the same approach I took around the BOC, it feels kinda hack=
y
>> >>> but it makes sense. Just an idea I thought about just now: What if w=
e
>> >>> have an additional write-only "_enable" sysfs attribute for these
>> >>> channels? =20
>> >>
>> >> I would not want to make a write-only attribute, we always want to be
>> >> able to read back what the current state is. =20
>> >=20
>> > Yeah, I don't know why I said WO. Reading would be fine too.
>> >  =20
>> >>
>> >> Do you mean an _enable for just the BOC? I think I would do it like I
>> >> suggested above instead. =20
>> >=20
>> > No, no just the BOC. The BOC, IDAC and rest of side effects. Thinking
>> > about it some more, it would be a bit redundant but clearer if proper
>> > documentation is provided.
>> >  =20
>> I would be interested to see what Jonathan has to say about this too.
>> Generally, his advice has been to avoid attributes that power things
>> on and off if we can help it.
>>=20
> This is again a bit similar to the DDS case, but there we have more than
> one on at a time (as controlling different parts of the signal - freq
> / phase / amplitude).  Here we at least avoid that complexity.
>
> I didn't really like that solution but we didn't come up with any other
> way to support the complex stuff going on.  Hence I'm not necessarily
> suggesting to go that way here.
>
> I think this may be a case of laying out different options in an ABI
> doc then reviewing that to make sure we spot corner cases etc.
>
> Thanks,
>
> Jonathan
>
> p.s. Sometimes it feels like the world just keeps getting more complex!

--=20
Thanks,
 ~ Kurt
