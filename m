Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91952517A5
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778031746; cv=pass; b=BHGvM7fO0+iZ89C4AgEBCpacxoDFDZkO/oxOKwUYIgDCTlr9KTcHlgSW8T0R2dHa069yN/QlYQ1vdA/W6B772GGnZszHJD5V6d+00vrsWrKWavv9AfBVBOtw+wW3IlIGbeg5AKZSBt0GCzAY/uh+RGlGSXkMBedP8go4IV7VFIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778031746; c=relaxed/simple;
	bh=5npaDOtD8Kx4YdG/fickJGYg/Uk8GqQ1EH6vohb57PY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9MkQFImsvq/WNMqyJ5M7oJgG4qcF+tPN8nxViwiB7HrunXzC4cOZ9Rri/dcLWmkoj1eLslGB3k0527Kzqklemmgv0QW3KV+BkZTDXo9fJ2yrIkLpszLvhs1O9BP73Zg4XJD+9TqcXFJUjXGL017Rw5wUXObc8Cx8bS1/knBQPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Erz+kuGX; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Erz+kuGX"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-651c7ddf514so5949853d50.1
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 18:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778031743; cv=none;
        d=google.com; s=arc-20240605;
        b=aU4O5a4LW6jkD5tRYyKrabVg4oX3Q0SGHyfUPKEmsddu/zxkcJF6H4l0t4SRyeNoHC
         fcDEbkkzOLQPckrCMkIBJMmUoiWD53ptrsEuQff34iX0g6IY2RxHbpNEvoY8dlf9CozS
         spmCzGhYYqMrtM1uEcVQ+p1SkzmH4m94zJp1ZqekEK0Cz4Ygro6AYGbKeppnSPsSDTzF
         82RVhr6nRfycqI/NOVuZxnvA8AkSfgsTZ6Dv0fuInQM30pTuIotdd1V8rWp1M4E/xQxG
         vhBjcs1MWpn5TdiK/pt3mXnm2Wv1C3qqn9Abh4DcPHB1S+8lio1RbAtpMeRkJOhguFWz
         GAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xixHa8j1rJvg7+/344bd505izZwcoyvpiXwkXH7vPH4=;
        fh=Rnxg8zGLXQO+VpAnmcEoR3NZdew+fWa3XwmRhEM49nQ=;
        b=Pg6jfoYEduHVRrPlBSmzSwRMsL8DpERh0G2PDotIeIYn6TjREr08jPY2gpJ70UrqKK
         qNZlW2y5Bgxx2DGBkcs6gqmkO2ZTzgB+vlHnpziqpxCZ3vJ6zRQAzDtqWQNa8o41d1GE
         xGXq/RM2d5y8vZLRx+fHapaNJBKVcQg9gWRSYYBXt9JkUvWYUH5lntfSWJrYPXzdNjXA
         wHgOS7GqwiCKtqql6+iEUBlWV/16Nt5LoUpwTtL8RMzyJ0q41mj5c7rP0I2Y8lVKal4g
         6ik/WHUtBk6H3QQduXCk+lmM/e1sSyVyzdm1Ik8TwLP1pd30Yrs7vGQEaKv/7JgYHOxU
         QHtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778031743; x=1778636543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xixHa8j1rJvg7+/344bd505izZwcoyvpiXwkXH7vPH4=;
        b=Erz+kuGXkqcuCUs5QwH2ppf+ncQyiAj1vyT5lthVTQc8yQlEygxhpdRBLYJt3tOpi5
         HKYzoIayKN3crYs6aH/cwnivig/9E0Z6lcHeStxAW4SQz/A/TcI3222P1/jHXYbu9WEe
         cmijynpe5FonK2tQeCm3siRbVu1Dm7BVq3CNrbqp4/Xu6YuBKlGdvG2W0GmhDhPKHFx3
         iF6CpKpf7NuvSnbNgbRuqRANWcDFEjs2HgRc5Qn4Zb2r/uMDNSGTrPE06bqrxfjZv8cA
         AwKAp/0UYRqvsOnNzT0xTbl8dANfpBBQPpLZegXYc3IgvHvM4wQEvQu0sYrJ4YgWCVTb
         qY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778031743; x=1778636543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xixHa8j1rJvg7+/344bd505izZwcoyvpiXwkXH7vPH4=;
        b=tHKcn66cBxydjJNvu7+gidDku4A5cYjNzTaGrixupKP6xcTBemTM6m4X9J2ltG1XgY
         PCjwTBszx3fken5xnVb+G1ClOLUGpTjV6zJK54DVyAbVTw5gnZUtecpvtlRLRKKD1+RM
         iTYcNbS6Pt2tk9Jlfk0qyQWtihjA6UagtWPD/gI5ztMYslmIVBngbyBzp4lU8+YpwR9q
         jp82a268tphPB9nUOmo9ZwoMOw/79C8KmroCGlHNOGgUa/ckyaqJu/XDo7zW2/yQnPrc
         8J/toGedp0Jz0/iz7e4B/u0TSm/DLmbq+jMxLBlIfyADMuRHnSznU6l8U0wH/ocElPsW
         13Sw==
X-Gm-Message-State: AOJu0Yw2+cxmOszozV6XyhqWJOQ9w1JtHpOfwLSybw5Bws1J2JaQ3xux
	PNAub4w6EtQAG5Qcy9LOGRR/wcgyGWE7W8/F+IaLJY3KJRb0qv9RlOm2hSaEIIDkj6eFRL53Dky
	hPr4cNt8ZagUgwTIKhP7shBzxp3zMiXA=
X-Gm-Gg: AeBDieuCcdEXeR9Y9S/wzQSddYaqBgDNklbd4Cm3cy8yqK3t0a0pzq3GO9RsWk1xQKi
	IPPvVBPLWQYHS6ZSKzXCM9XOjhU55W1mX8VWObXkKqQxoPjTln9GGfZ8wLVOjgyZJeAiGwCUuQB
	U3Xj4w1EIbEz6ungSq6q/1iRg3Lb5acZSLL2m7PTQFVwlUCsgrYTG6uYTB/IDJpXC8joEvSR6OE
	eB/7Qpy/qA+Ryygyk2sJz7fPhglJnyhcLT3gQtnr0zJpVdTcANNKcauOYXBN0A894dq6HWx2PtD
	k2oh6/lRcvM0o+s=
X-Received: by 2002:a05:690e:190e:b0:65c:4066:d17c with SMTP id
 956f58d0204a3-65c79cefcf5mr2091822d50.8.1778031742959; Tue, 05 May 2026
 18:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com> <DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
In-Reply-To: <DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 5 May 2026 20:42:12 -0500
X-Gm-Features: AVHnY4KA0yJaavBYX_ssV3saio2nAKYpqpfYkbMLyBGlndKuEyqzTYNaIYG6P98
Message-ID: <CAKqfh0FhpVMtoRyBPjmv5JHn9ad4fPgn5wiyYpEnSYf73Wd-rw@mail.gmail.com>
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
To: joshua.crofts1@gmail.com, 
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 8:09=E2=80=AFPM Maxwell Doose <m32285159@gmail.com> =
wrote:
>
> On Tue May 5, 2026 at 6:46 AM CDT, Joshua Crofts via B4 Relay wrote:
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Add a check that ensures that valid data has been read from GPIOD. If
> > not, log an error and return the negative read value.
> >
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> >  drivers/iio/magnetometer/ak8975.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetomet=
er/ak8975.c
> > index 129c98c97071b4cf8efa3abf2364a3abbde129ba..b3caf5f3ebf29bf701bb214=
aa480fa7afb2651c6 100644
> > --- a/drivers/iio/magnetometer/ak8975.c
> > +++ b/drivers/iio/magnetometer/ak8975.c
> > @@ -658,6 +658,10 @@ static int wait_conversion_complete_gpio(struct ak=
8975_data *data,
> >                                timeout_ms * USEC_PER_MSEC);
> >       if (ret)
> >               return ret;
> > +     if (val < 0) {
> > +             dev_err(&client->dev, "Error in reading GPIOD\n");
> > +             return val;
> > +     }
> >
> >       ret =3D i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1=
]);
> >       if (ret < 0)
>
> Small nit but I wonder if we can change:
>
>         if (val < 0) {
>                 dev_err(&client->dev, "Error in reading GPIOD\n");
>                 return val;
>         }
>
> to something like:
>
>         if (val < 0)
>                 return dev_err_probe(&client->dev, val, "Error in reading=
 GPIOD\n");
>
> Would be good for code density.
>
> My rb will apply either way.
>
> Reviewed-by: Maxwell Doose <m32285159@gmail.com>
>
> best regards,
> max

Actually, timeout. Sashiko had a good potential catch here:

https://sashiko.dev/#/patchset/20260505-magnetometer-fixes-v5-0-831b9b5550f=
c%40gmail.com

"Does this new error path leak the pm runtime reference?
In ak8975_read_axis(), a pm runtime reference is acquired via
pm_runtime_get_sync(&data->client->dev). If this new error path returns
val back up the call chain through ak8975_start_read_axis() to
ak8975_read_axis(), the code jumps to the exit label.
The exit block unlocks the mutex and returns the error code, but it skips
calling pm_runtime_put_autosuspend()."

I'm going to withdraw my reviewed-by until I can confirm that this
isn't a problem, sorry about that.

best regards,
max
