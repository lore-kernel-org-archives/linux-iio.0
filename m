Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5A43A9615
	for <linux-iio@vger.kernel.org>; Sun,  9 Aug 2026 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786264199; cv=none; b=l7Ug8+Xm0DTV1hGb73We58ZbrXtd+GaWsQ95KFYwGM9VXPT1ncXITMbhnqTWYy0Y9TlW4dKrYO7uR0qIDbtHlSqC6dAsFNQda22XvTEE0afyDBHDTtbU8DqH0rEG06S47VfThGgR93IZ8KqjfHXD7P6VukbVFah8hsXfUk7HBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786264199; c=relaxed/simple;
	bh=Tr0vhSlpYrIm8pUdtGcembVGsxzFGAswf+yCpBXcDns=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:Mime-Version:
	 References:In-Reply-To; b=bvtAuzU9xnyrJAg+cpnVDt7sWGDjSshTx8tf7Ofu8xS8294p9ATzcEF3RwrTssz/a+u5YxDaSCyWB7Duyu2X4waJw5hb4w+5JNI5nAP3LNus8mOpWgacGPuttA04iXxCo2fRIl3OlQQ8UT279cZn5GCIpFO0asC1s+/vxOzgqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYVeFaCw; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYVeFaCw"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5bfb5e20a90so735646e0c.2
        for <linux-iio@vger.kernel.org>; Sun, 09 Aug 2026 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786264196; x=1786868996; darn=vger.kernel.org;
        h=in-reply-to:references:mime-version:content-transfer-encoding:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d8UdgNkOqkWbZyhRHf5OOeBdpskYt04c7oStZ3xaPyw=;
        b=NYVeFaCwJ1w9W8lBSg19+M1n3++sgJndS1B6Kr4q9aG8FX8X7wfBVSr7SbyNrOLK7E
         k69KfK9vKh4MA6o0kig3qc4aZEKaymfh5VozEHOgULEXfDM0IzJX9450A5BeK/0+YHfH
         6lmyWnZMNbk4HEcL/QEMDwqK75x3H+iun5OmTmQCIqo3TIxvgsYrefvmYCXLCV8vEPN1
         XxXwVR5T63KbKQirbFAczjeYLKVrb6iVuyy/5mfY6Zdf1JO9QGux+sCE8Mri9Fu/h7z4
         bmm7FG7sdVtZ+ZSWP+O2MyJ2IvvEysedx/MPzvWUH+Uk6DzDNUe4uaR5d47TedF/LFwU
         QNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786264196; x=1786868996;
        h=in-reply-to:references:mime-version:content-transfer-encoding:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d8UdgNkOqkWbZyhRHf5OOeBdpskYt04c7oStZ3xaPyw=;
        b=kuUidn3XxFLynlBVFLjfXRE6zp8qnQWuTFxpxEjqN5oH4CjsQpi7+POcaxb4rrv2RA
         AnbF9Sg87LshNn179HJuQgwH1KLCco2YOYjj3EzDo5JjHjs8W11zTg31XocuLxj7QWz2
         z+zM9AmeWD9NAln9crrqfMRFxOrnVrPq3HeptTfXQpsMYQB3HfUre79uToeRO5B/eioF
         M/iO6achkn6NlEuFlpDprPogdL3BBKPXcVJPJyg/mqVfOugSQFKN5Jc9sGJ0FaIFgvDE
         OxBiWnO+8qMxPtP5lMO3pVsnqJ02FO1P3Y9dF81Lk7f3c5HKOhcRjaVLU0PKDx2kTZ7l
         VLFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5OV8d15uhIDkq6zqGJQiuf6ZjbNqjeDFm9fYHo/4Rz+Gnm8U5Wv6XldgIgp3ORGBl6DlmI3es7dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJ8CnFvvW9b1KjeKfoIMiBkoiu0XpioL+405FH92gUtGLF9sA
	ED4cCAtKrz/Z1ocUnVZDTf7P5x9MlqQSvcrHoWPQ67eEnrOvuVdnCXhO
X-Gm-Gg: AR+sD13e8rxISy7WetlrBQm/6gpUZj3XJAa4UH60JpTqriawryy79pfq3TwyI3zXXUR
	uWLewfbOfaS/1ZYZ0B3mimMSp8TqOnI8yPXNrcCrfjRZgTQF0tYH6MUJcTqmV2oVv+CFofGQLMh
	p5h63lvSiEIOrqK/hCFbgDBRIT9Y8raywrZFnZZpHPLCDLis+vT/UTC3JiS83uXhEKLa2Sk/5ep
	lPECYdK8KKfvCRnA6KJ/E3tvGOM5XlQBpUO/6GyZAoBQQhbB7ZI/jGW8P2/QrUe0dMm7XV5QZTh
	4jEhZS4uMw6W9N5+r03tN8Jz8FENrIXvvkL99rWNG9gDqeMwNF/G1D95XN6rjmjrOIFx3D8KtiR
	uzMMnhlIr0nGEKF3GIWwgi3O1YgcJJw2EpwtvBmvkGrVKgMxufZFbDMoXGO9IMFtAPqtM4Ar8/r
	6DmqqXtBDkKL65wjc8wAlkFnN2IulUSoF9k1wWK8z3NfXd//H4JOQ=
X-Received: by 2002:a05:6102:801b:b0:744:dd70:a364 with SMTP id ada2fe7eead31-7634d10f5c8mr6869570137.9.1786264196337;
        Sun, 09 Aug 2026 01:29:56 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-763feadc5e1sm3238702137.6.2026.08.09.01.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 01:29:55 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Aug 2026 03:29:49 -0500
Message-Id: <DKK9T3XRZJEV.R83PII0D35H@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 0/9] iio: adc: Add TI ADS126X ADC family support
From: "Kurt Borja" <kuurtb@gmail.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <9c2e2c46-32de-4e8a-88c3-bfc2cfe8157c@baylibre.com>
In-Reply-To: <9c2e2c46-32de-4e8a-88c3-bfc2cfe8157c@baylibre.com>

On Sat Aug 8, 2026 at 1:37 PM -05, David Lechner wrote:
> On 8/7/26 10:58 PM, Kurt Borja wrote:
>
> ...
>
>>   - @David: I added support for the monitor channels, but I prefer to
>>     parse them from DT instead of making them static (similar to the
>>     ad4170-4 approach too :p).
>
> Why? Unless there really is some property that depends on how the
> system is wired up, it seems like this is just making unnecessary
> work for users to be able to use the monitor channels. And if someone
> decided later that they do in fact want to use the monitoring channel
> and it wasn't in the devicetree, sometimes it can be very difficult
> to actually change the devicetree.

The only thing I can think of is the reference source. The datasheet
says "Measure the supply monitor readings using either the internal or
an external reference".

I saw that the ti-ads112c14 also allows the monitors to be referenced
externally but you didn't implement support for it. In my case I think
it's okay to leave it unimplemented too and make the channels static.

>
> The monitor inputs also have many restrictions compared to a
> normal input that it would be really hard to describe correctly
> in the bindings without allowing things that should not actually
> be allowed. (can't have excitation current or burnout, temperature
> channel requires internal reference, most should be single-channel,
> etc.)

Good point.

>
>>=20
>>   - @David: About filters... As I mentioned in the previous version, the
>>     data_rate configuration takes precedence over the filter selection.
>>     If an incompatible filter (given a data rate) is selected, the chip
>>     resorts to a sane compatible one when doing conversions (either
>>     SINC1 or plain SINC5).
>>=20
>>     Now, I don't know how to expose this in userspace. Should I limit
>>     the sampling_frequency_available attribute (given a filter)? Or
>>     should it be the other way around, limit the filter_type_available
>>     attribute (given a data rate)?.
>  I figured that the filter type selection would be more important than
> the rate so when I implemented it for ADS112C14, I made it so that
> one has to pick the filter first and everything else flows from that.
> (I didn't expose sampling frequency until the same time as filter type.)
>
> The thinking behind this is that if you do care about filtering, then
> you are picking filter type and sampling rate to get certain notches
> and/or frequency response of the filter rather than trying to get a
> faster or slower sample rate.

I think this makes a lot of sense in your chip because there is no
plain "data rate" register. The data rate ends up being a consequence of
the modulator divider + OSR/filter settings.

>
> And the driver also allows using an hrtimer trigger to do single-shot
> samples for cases where one doesn't want to sample as fast as possible
> in continuous mode. This would be more useful to someone who just cares
> about sample rate and not about filtering.

Why did you go for this instead of just leaving the continuous mode
running and reading on each trigger?

>
> Just posted the series yesterday:
> https://lore.kernel.org/linux-iio/20260807-iio-adc-ti-ads112c14-filter-su=
pport-v1-0-4d3ba00caf18@baylibre.com/T/#t

Can you Cc me this series too? The settlingtime stuff is something I'll
implement too.

>
> ADS126X seems a little less complicated in this regard though
> as the same sampling rates are available for all filters with
> the exception of the FIR filter having a limited subset. So I
> would go with the option to limit sampling rate based on filter
> type, not the other way around. If a higher rate is selected
> when changing to the FIR filter type, just have it go to the
> max (20 SPS).

I'll go for this!

>

Thank you very much for your review and tags :)

--=20
Thanks,
 ~ Kurt
