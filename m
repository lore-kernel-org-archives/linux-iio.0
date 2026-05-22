Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD6520D4E9
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779414544; cv=pass; b=nbD8tH6E93qjUT0i3h9FapYGdo8NmDXPIquTmkEaqFCdFDSCsthwRWrjSOSgPCUFqEq6BlwgsVtJthzO/OIitOP9AWHJ5sORaTPGer+k4a3xwjKL6Z1zmSfi4ed0qTBsHnzWL87KrApTCHQ6Ddo6vxT9T/Z5VVXTTCx0H1cRv+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779414544; c=relaxed/simple;
	bh=sGmVuAKZIKkuAUnENQmP5Ay5WG82ih/V0rTY+vXg6jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OOlkA1Mc0/Qas08yM8hFd3o4C9N0F7UycT2MPzYuqItz9G7mtmYPHBWX3Vlm91AU7Mi5nIxcN2tEcsywyDJr2uzWLyBuh9phOayiDuzhHPAAjj/IwHlz/cDB3zOWO48aZXq56wO6WdbS2sEW07bYhdmXXPs7rsII5Z/gyjgNuSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqvMeOoc; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqvMeOoc"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c0bda7f15so6844468d50.0
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2026 18:49:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779414542; cv=none;
        d=google.com; s=arc-20240605;
        b=LImD+1aM0tfJFeFb/vonyL6nbe4NP/Ksowa2Elnf+CnfNnRv1jnUMPWmDfOwrWKO6L
         JvZOicSjI77T4tDAZpMdCYppOeusn52+GTNv1sGSsd+8GpYQhgH9hnvKTvVV/ycJztqH
         tQQMSmfPFR4pGrjFyIBiejE/oE8lftkuGsGuC6nWeljftGWNbNpzW8Y9N/v6Xr0s4poc
         lQXy5MIa5Qam98Rjagu31gRPIooun+ZLwkj6dCCsimJFNjluI3uSExKDXKYD0zIivyaM
         5CE1c+rMP3kjxSQaJURYP/Qm3rL0IInI5f6Agmi6DQ7UK40VFOpNii12L+xXjkiv7Agq
         +bIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gfhbZuSTK0oNiarVrbLwkyBCF54lFloe5DaHmAP7RjY=;
        fh=5WFg/lkGJ7FO+bGvvRciIuBrc5uUP2mEMo441+TLS68=;
        b=OMochqmayyk270L70ZY5mxzxiABwG/xXcL93BxPh5IllfjgWkROADZBHXmRxCsGKnZ
         14njADD6vb9e4m18P0DXysvOqDjqORDTyoqbR0JUsPDDDXxyw0eW2JNG+TY80uwCALun
         1lfE0d0Zj5pKWkpyf3YDYZfEdVYgz9jEGkC9YkmKtInbmyMoPz8EkCVuE3Ct9hrnaO85
         H0kw2KlVtH5fHbUhUxbQxT0KhyczSG/0bO7s+UJs54uJRRh1v6Vxc9RyZmNBsPodk5Sv
         uuU8CqHGGfx2yT+tESQzWHAqOKpwtpYofSY7IUKH8KrZ0ABdovc9SwcudR9u7jYy2ulT
         h+Cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779414542; x=1780019342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfhbZuSTK0oNiarVrbLwkyBCF54lFloe5DaHmAP7RjY=;
        b=NqvMeOocS2kyS0WspSr+xvgmQmB0hGwGnQiO/rQtSVGQSnwqF9c5kZCPinKDCZGxGk
         T3j8o4lHHXzprlvOUaMXN9OUZ85S+OIKpkz7SrkklL2KLoPLhcc8IJs7FdD/o1WAmlAp
         gHsBqm+5gFNxv7yvjDEb0jCsuTXDiwqp98w9sI8cL/unlrdzcPfo/jEzsaSzaRQCy8DS
         19B8hS5Wuyw+IPR0x5IdmKrHrwc9iZeNwdNH2WWT4VXuPOA892t6TNjazPE5QeFvelMB
         FrWBtwDOs5MQ4eaIS2ePfRxs20OsOuslpKUPpgEb3o7sBcw5vPe41pUBzgnpMC7lj6R9
         C7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779414542; x=1780019342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gfhbZuSTK0oNiarVrbLwkyBCF54lFloe5DaHmAP7RjY=;
        b=jBJOXXNnS51h9wa5M/nD7W6utbPy+pecCeJazrIaMhEbZ75zi6H87cbinLNJ0t36lw
         GGtlIWilEpYkvHLFybpIQaeqJkDHhFlEpQdMd3om/DwG6F56pcd0JOVeQntS0+VdEob1
         nc95UBSW5TZ6XKs/9FcvkgfIdkfDhGxy7MGKbgE2B9OnS80a9OGlyY1qeOQ+1VOlainn
         ujLyXEUBtZFO2rKk5mr8QXO8GT+sB6Ofu5BbMrfU2D1WGBRLp6MyQfTT6+5v6NmFmK9L
         7749BembOxzfoBPJ7abyGicmS04eFqLlqZgUCV6k3HqOUQRB3dNod3lR19wtD5ep78BW
         BAvg==
X-Forwarded-Encrypted: i=1; AFNElJ8hmZLKzZRIviIK6+Fvb+/BzhK05XbNYNuGLCImH7UthLdFnLhjcZeTyGiUgjgYykSpbUOgMMzNJdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgJCqlil1vkCkxqXdVKQ4hsF6LXmCJXNAxCkPf+R3wPc3YQ6We
	UboMOy5cc2RsbKtMGEgLVMq5GJ4NgMQY+yPEklhR7n7shLdWtGdcD9n4zmb33PgGvbNfeOsACAo
	2qlEDMdyfr+pXJK+cZC/mlwKSlEI+9tE=
X-Gm-Gg: Acq92OGRDJtIj9/+VwWrxZdoc5STSfvox2jtthcv6OvaBfjyYd3sqMV5nmL2ZplPgDo
	7B0J3vxNeB3T60GKn00JdvwPD3qUB4OBYEXysLJzYgO15VGfn3K8dPCf7V9jgOTlXl0u4NBM2iJ
	WcVJwZZMBJi1djYcnnGE4MpDtWdb7hJqWnB7uwuS5/NMhFX27FkrHCAFpjjeJE8NW1oVVeMzlv7
	WODBAookIPmCJtuYKJ21tqOfcB3WblvOPdTdRzIQ5TQXWEYfpZ4Kvgs/ZO10yGZxC4PEsl3yDHb
	pynu
X-Received: by 2002:a05:690e:1544:10b0:65d:bf4b:f16b with SMTP id
 956f58d0204a3-65ec96129d6mr1646605d50.3.1779414542022; Thu, 21 May 2026
 18:49:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com> <20260521-opt3001-cleanup-v3-5-820169dec8c3@gmail.com>
In-Reply-To: <20260521-opt3001-cleanup-v3-5-820169dec8c3@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 21 May 2026 20:48:49 -0500
X-Gm-Features: AVHnY4IWIkf_a9w8iHjKJOQu5wuEb8jcMh9_SR4F7oVdO-sM64eoLkweYfguxEc
Message-ID: <CAKqfh0GeFG7Jw8==fjve9oZ=xy4AnitzF6z84iTLtNKB4wLLHA@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] iio: light: opt3001: prefer dev_err_probe()
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
	Michael Hornung <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joshua,

On Thu, May 21, 2026 at 5:13=E2=80=AFAM Joshua Crofts via B4 Relay
<devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> From: Joshua Crofts <joshua.crofts1@gmail.com>
>
> Switch driver to use dev_err_probe() to unify error messages generated
> in *_probe() and probe path functions.
>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/opt3001.c | 56 ++++++++++++++++++---------------------=
------
>  1 file changed, 22 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 22a73c1afa74988dabf9db10c3b55bd07529fb20..d5262488dac889066a53d3234=
762e0557f9e3cbc 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -706,21 +706,17 @@ static int opt3001_read_id(struct opt3001 *opt)
>         int ret;
>
>         ret =3D i2c_smbus_read_word_swapped(client, OPT3001_MANUFACTURER_=
ID);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to read register %02x\n",
> -                       OPT3001_MANUFACTURER_ID);
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "failed to read register %=
02x\n",
> +                                    OPT3001_MANUFACTURER_ID);
>
>         manufacturer[0] =3D ret >> 8;
>         manufacturer[1] =3D ret & 0xff;
>
>         ret =3D i2c_smbus_read_word_swapped(client, OPT3001_DEVICE_ID);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to read register %02x\n",
> -                       OPT3001_DEVICE_ID);
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "failed to read register %=
02x\n",
> +                                    OPT3001_DEVICE_ID);
>
>         device_id =3D ret;
>
> @@ -738,11 +734,9 @@ static int opt3001_configure(struct opt3001 *opt)
>         u16 reg;
>
>         ret =3D i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION=
);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to read register %02x\n",
> -                       OPT3001_CONFIGURATION);
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "failed to read register %=
02x\n",
> +                                    OPT3001_CONFIGURATION);
>
>         reg =3D ret;
>
> @@ -766,28 +760,22 @@ static int opt3001_configure(struct opt3001 *opt)
>         reg &=3D ~OPT3001_CONFIGURATION_FC_MASK;
>
>         ret =3D i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATIO=
N, reg);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to write register %02x\n",
> -                       OPT3001_CONFIGURATION);
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "failed to write register =
%02x\n",
> +                                    OPT3001_CONFIGURATION);
>
>         ret =3D i2c_smbus_read_word_swapped(client, OPT3001_LOW_LIMIT);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to read register %02x\n",
> -                       OPT3001_LOW_LIMIT);
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "failed to read register %=
02x\n",
> +                                    OPT3001_LOW_LIMIT);
>
>         opt->low_thresh_mantissa =3D OPT3001_REG_MANTISSA(ret);
>         opt->low_thresh_exp =3D OPT3001_REG_EXPONENT(ret);
>
>         ret =3D i2c_smbus_read_word_swapped(client, OPT3001_HIGH_LIMIT);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to read register %02x\n",
> -                       OPT3001_HIGH_LIMIT);
> -               return ret;
> -       }
> +       if (ret < 0)
> +               return dev_err_probe(dev, ret, "failed to read register %=
02x\n",
> +                                    OPT3001_HIGH_LIMIT);
>
>         opt->high_thresh_mantissa =3D OPT3001_REG_MANTISSA(ret);
>         opt->high_thresh_exp =3D OPT3001_REG_EXPONENT(ret);

Ah, but all of the above don't seem like _probe() functions. I'm not
an expert on dev_err_probe() but I'm pretty sure it's only for use (or
at least, designed for use) in _probe() functions. Only function where
I know it's 100% fine in is the one below.

> @@ -894,10 +882,10 @@ static int opt3001_probe(struct i2c_client *client)
>                 ret =3D request_threaded_irq(irq, NULL, opt3001_irq,
>                                            IRQF_TRIGGER_FALLING | IRQF_ON=
ESHOT,
>                                            "opt3001", iio);
> -               if (ret) {
> -                       dev_err(dev, "failed to request IRQ #%d\n", irq);
> -                       return ret;
> -               }
> +               if (ret)
> +                       return dev_err_probe(dev, ret,
> +                                            "failed to request IRQ #%d\n=
",
> +                                            irq);
>                 opt->use_irq =3D true;
>         } else {
>                 dev_dbg(dev, "enabling interrupt-less operation\n");
>
> --
> 2.47.3
>

Regardless, I'd wait for Jonathan or Andy to give their comments on
this before you make any decisions regarding which ones to switch over
(I also haven't looked at the v1 or v2 so I don't know whether or not
they recommended you put dev_err_probe() in the non-_probe()
functions).

best regards,
max
