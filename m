Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502677;
	b=R6IMCgG+j40QooswQ8todX8+tPVAAhUJLeDTh4MZAuq8BeE8/D05T5+fgPu2yU19R5cZ
	 /nkagCwEBVNY+tQyCv2i9lnC8WIFubDeXdTyksC3CdPBMF6OPL+y0eRJ+aIBI1qm+Lo6k
	 D+wfL8VnaRX5CftzVaRHL+2NPtfpkQW8Pr1BG/YYPF4sw2nHKrBnyXUs/gz74gyz5IOZw
	 UOcliIEEZW8OVgjS8sn0goe7DTwSi8ktQ0Dy6lN3Dfh3DdmBCS9BGUB4X9dtBqa+JxUcI
	 mFhPkq85KRkNnOnBwBs96ZD1O4tqTz7Mmb89PQohVresEVEvRnmJhFbuVjvK37IfK3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502677;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 Received:Received:From:In-Reply-To:MIME-Version:References:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=COWPlZdRueN7pSY6pOWaLdT4Jys7uGpWmTmqPkHcMl8=;
	b=kHGV1Z3+oG78mMNi486ZzBlqc8s+8ZAagOzCZ+f4eF1iwLVfhhGOXlQufCt2NHtd9sHz
	 Os1JqyLgHxF3vDLFyYhLI1GpuMY8b0gUyzbIIgpiLIc8lMtA9t1CbvnmVfTa/EMfFjStS
	 osn1dn/3ZEq4p1QCIUmEqh+cmQ34Ca+B6hzc2oRuUqJnB9Bh0DEotwb0ieY/jx/7X3JMx
	 aeArLb8mQVAlWn+276XfrefzG50uyCj93jEjkM97XrpQkHQ7MpBSpaiaUywkdtPOK6Sc5
	 kNmigE3JCRZ+bmkARBrRCypitJ5/Ze5VX3/ZkOT9V5cQTCqwMSv1WfDokLvobyfwOcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmEXTee3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08720606A323
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 13:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmEXTee3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFA31F000D0
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 13:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792502675;
	bh=COWPlZdRueN7pSY6pOWaLdT4Jys7uGpWmTmqPkHcMl8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=PmEXTee3Pb1/Z2oHDK9VdfnvCM4Ux1PZEFvf8G7QLnqQLAgFCDKb2xcoijp+hqKzL
	 o5CSN3VuG7XuaQUgKnXm6CHAzH16T/4cqXRSG5ZF80eXFkch5OaCwuDIQ3N6HOuZP+
	 5RP2iflcCjL8T5WmD4RP2zZ9SUCfTbNEJ6Exjj+kLGPIvJmwzFX6Dicy1kx6px4ctK
	 pEIiwLxlr2czPJg5c1S+oJ2yY3yX8wOoNBKc0ly8amOeVEF7w+whT5p4NsfJQ9Ec4z
	 RsvTj3+w6iYxxmVwFKKNpTixzeE1sR2whQocKWE6HJ8EY/koowwyafEAFo4Aj43wos
	 bY0qoENVV78HQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a5a26c8412so27227341fa.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 06:24:35 -0700 (PDT)
X-Gm-Message-State: AFq9FYJT9QeSxeGYLfBFs0UIY6N3yjTChPLb/kU4VXo/zzev4RJkjTyQ
	rcgA22BPcuDk2cxPQqYk1WmfOrol9z6rOxL/Fqs9NWHI8euRWXIeDP0SY2RJNhOjA+UA+rkgORJ
	ZctpaFYNHTv+SLq0fVnJmgygipcWeyJbr93Y89PuZOg==
X-Received: by 2002:a05:651c:2108:b0:3ab:4412:354b with SMTP id
 38308e7fff4ca-3ab44123804mr14301701fa.1.1792502674348; Tue, 20 Oct 2026
 06:24:34 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 09:24:31 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 09:24:31 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <cde9d00a-bfe4-4093-b03d-f76a122e4ded@baylibre.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
 <20261009-iio-adc-ti-ads112c14-gpio-v2-2-3231a795fa63@baylibre.com>
 <CAMRc=Mfn7+uQYvLjGLxU9wMOnRwx5pyPgaLp6oNx+ZcFXyXL=A@mail.gmail.com> <cde9d00a-bfe4-4093-b03d-f76a122e4ded@baylibre.com>
Date: Tue, 20 Oct 2026 09:24:31 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mfu6moWg6bomoPHqgR=7F9QoPVy62Za_EegP3eb8+jctQ@mail.gmail.com>
X-Gm-Features: AclHuK_UJ2IGCUSDhuuXQjxJ1GUIk0fxrp4qAJiEjRQoj2s0LGafMJ4oqarMM3M
Message-ID: <CAMRc=Mfu6moWg6bomoPHqgR=7F9QoPVy62Za_EegP3eb8+jctQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads112c14: add gpio support
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>, 
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Oct 2026 15:46:30 +0200, David Lechner <dlechner@baylibre.com> said:
> On 10/10/26 4:00 AM, Bartosz Golaszewski wrote:
>> On Sat, 10 Oct 2026 01:25:52 +0200, "David Lechner (TI)"
>> <dlechner@baylibre.com> said:
>>> Add support for using the AIN4/GPIO0 to AIN7/GPIO3 pins as GPIOs when
>>> the gpio-controller property is present.
>>>
>
> ...
>
>>> @@ -2574,6 +2726,12 @@ static int ads112c14_probe(struct i2c_client *client)
>>>  	if (ret)
>>>  		return ret;
>>>
>>> +	if (device_property_read_bool(dev, "gpio-controller")) {
>>
>> I think the right one to use is device_property_present().
>
> I thought this was the one case where device_property_read_bool() is
> actually correct because gpio-controller property is a
> /schemas/types.yaml#/definitions/flag.
>
> Otherwise, we should just remove device_property_read_bool() from the tree
> because there would never be a reason to use it.
>
> My understanding is we should use device_property_present() for non-boolean
> properties when we want to know if it is present or not before reading the
> value of it.
>

Right, I remembered seeing commits from Rob Herring changing read_bool() to
present() but it's like so:

commit a570feff16bd4fdaa247b4ef13f4d28f8c73903b
Author: Rob Herring (Arm) <robh@kernel.org>
Date:   Mon Nov 4 13:06:49 2024 -0600

    interconnect: Use of_property_present() for non-boolean properties

    The use of of_property_read_bool() for non-boolean properties is
    deprecated in favor of of_property_present() when testing for property
    presence.

    Signed-off-by: "Rob Herring (Arm)" <robh@kernel.org>
    Link: https://lore.kernel.org/r/20241104190650.275278-1-robh@kernel.org
    Signed-off-by: Georgi Djakov <djakov@kernel.org>

So only for non-boolean properties. You're right.

Bart
