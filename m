Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F3842AA9
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780144441; cv=pass; b=QjbUQVxfFpx/m59Eb3jNpsdKDVUSViNHM1H/WP+yqPVCP2Ub6wcE3VTC7jGlKrd7p25o3Z+9lOsSBHqt36UqYjCJ94FQqWN5IQQVm1nHpbgqGee6B7ua+pLk8Ph57iGl2heEEVb0PcmgKOBB6MZOYejdWNlnIESIWMMbAQLk3dQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780144441; c=relaxed/simple;
	bh=36c0unO8MWXWDDeFqNc9onABqLKdLE9E+dwU2fyUxqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdVTOPdppZo4goR7b3xifKWev1Jdh8SkflB12Bskil4iSoqgHzbTIRVaWJQ1wtVjA+eNQs6KPVOKRvn3yOVDP9DCpN3NDjoyn/rnnWVKtAQzY09q7mAIqn5kP5pmLsOvvcRHuJoEmtc++ecCVBmoJ6A0BZ5C/UjEhYdBbiEc5M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwNXVqzO; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwNXVqzO"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-bebc80100efso9033566b.1
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 05:34:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780144439; cv=none;
        d=google.com; s=arc-20240605;
        b=bj7akFcDGAorzpGtwyrCmTnev18v95UkwNs+pNcmoJO99Z380Jal7KdwA8VUCrdZe5
         6QJ8PaEHw15i3hta/2AQsS3k7yvwaY3TmGNB986ntNgbU3oLBYahtPje/Avk5HFW1/NP
         hwzuM98C8au5FfRJpG0VDOgo0XB1VN112c0ayJif66IBstPrla+a9fcHCCiRksChZn/K
         zLWTlsG4Ufd8BDbkQo654RPDhcT1JVRd3tveYm3JkrPGQKL01NQmPlnwacfv4DtveUH7
         OO47TXkEgC3hFQLSvML6H1c3QbkLDoHdbf2ydrfDJX6of0WI3PRCjuXpX3dXsujBh9Yv
         dD3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KObSDdJKT2yp6ibtTOcEqVNzY8XcmkFwEYsFtuWz+/g=;
        fh=BU5TyNzJpeaOwDkM0cYE+A7Z4a0XV50tXjpoqBuAwJM=;
        b=R0VM4l3XbRj0Wbvoeip7TpcRG6DqGjD5JMAjceoowlO2/DdEGvm9hdRK7B9+oHG9k3
         3QTHrn21PGC4sPNwBdJngvO/X7Oc7dVL6VvbgE7USAZ113J9FHKGRHIkkMR/vmik0XxI
         EWt7q+4NgJpBxnXkNjAq11ELaHSCU2vawBRD3mZaIAu5Rw9sPVa2dAYjKYyvcgoKFVbC
         KXOfhNW8ntCcCXFsyFzfFLS2Iyb132Xmh85vgC+la6IA3Gvu2nz+Ao6mnwniYbnf9EFz
         136SsEi835omInQlqp4RfYbI0Yp2/KWIVkhy7egVjbyw3tVkvuYvU6W0sYl8KfoZ6Q4l
         kdog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780144439; x=1780749239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KObSDdJKT2yp6ibtTOcEqVNzY8XcmkFwEYsFtuWz+/g=;
        b=FwNXVqzOYF8WGkqBtGQdQHPesEpBquQE7E6mR0kL3QGrovboAN3bh4vRYEYQKnoozy
         HoUsZtzo1i/0aOMm79T2AIG/CjKTselcHh2GLO/i2t3A70mHsWW5AZ9xd+CFRgCV8kS5
         Rfq4igcMFBsx+gslYsmi5Q8vcDMfJfEsUFrMd5cwQkcC3V7cImiIeopI1E4nfy4DA0Ew
         7rJ5hAQ6nEPvqZ8HZcp1LjauSUDKoGvnNgc06kJi0V2NlvC8JX4Ks9RQCqLgKfiH4LSo
         4oomtEA6OaVHReW/GIvqHP9J+q6TbuW+l9VTyl0OMn1tyWJxrxBhTg30yOaWOqyCYJT/
         4Yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780144439; x=1780749239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KObSDdJKT2yp6ibtTOcEqVNzY8XcmkFwEYsFtuWz+/g=;
        b=VkIkxG7Rg2cNX5TUDYd/s1On9Hr4FQTxhHUh6YFTeD/Kody/ypOmB0kiMypj/NxTny
         GOqCZGDfe1ybd8it5qxt0/bSW4JV0ebqrSxavUxOWk5NOcfm570VUqejnifnLwHVzTOi
         I1eFoAFqz5rm7sfScI923ikCExxMbomOj8GO6hOrI7GcZWcc6nKrlshxNi5svpgkM0Uh
         VVbn98gvaxcyEAWoO+FcKZSobFGTkFsYYEpMGoZqVgvdcw4BLvR8cg75+xGmOVTsUokP
         bMObBeoVZiY8n0KVN25Ig65NhjHUUMYVDTOGSR5KRvP9BpazsZ/HxNB4NeMVObuRWWA1
         gUQg==
X-Forwarded-Encrypted: i=1; AFNElJ/AfSICPF7IH6OmoszytX+vnzfFYuLvJfUKisL/GJlfFCKk2Nm1ehAoLJNhchfgAyNzgmfgHO6bYEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHU94PNP5uVYqZqYzwyu2Qmij3K/SlX9IqbW0Tj3tr7eH+kmz
	kIzIfvJUCyBVJf2Uuu3BLPRIJ1jdo+D/iXOSP0qnoXKfpM7Mi7vju4ha/iVNK8YJSTRczaEd9b8
	2iCotQkj5O03/3b7E86mC+8fHL7/ZD6g=
X-Gm-Gg: Acq92OGKgt9ONvhZ8j+gNY9GSFPMXZ2aPP/yfV8frgY2WDrPU9vI9hcFtQu0/gUgUVd
	lKzXUnR3PbQ6iXWwjrMdy2VBi3u01GXxNYww+q95Y/qPiaC1x/s7o7dqUrOpK7rCUGy2obhHfty
	miEtmH4qF5CLDjCL9NkN8k6tvGbTX9vG9q4DtKXQ3ZD/qEz5xiRx8+vAsB0F8+hikb7bTt9q/My
	3Bw+CspKTQmJx+6R/PEHDcD0Po9uQNAmCPEQWR90LRblipsMAsJ43FGnlAJHa89jvAPt9RNQyPT
	yiPjDmHI5RvQzdgEVG8P42CxOem4yAnmIq4OLxYyTmArU2igFfdrn94Yro83+fwFUiKzFlUbDDn
	qrz0VMqmbENyhD+h9SsLlR0Yj9Auo2DygV2uCIxJwEmXhQyKH+wowlZolqfaYzpRkAdz0FiUTJK
	VsrZcO
X-Received: by 2002:a17:906:4792:b0:be2:36d7:573b with SMTP id
 a640c23a62f3a-beab541eb92mr174787166b.12.1780144438732; Sat, 30 May 2026
 05:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530113938.171540-1-suunj1331@gmail.com> <20260530113938.171540-3-suunj1331@gmail.com>
In-Reply-To: <20260530113938.171540-3-suunj1331@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 May 2026 14:33:22 +0200
X-Gm-Features: AVHnY4Kn8G5KgjwULApCtLI6GYlsgGkapsmKD9_9XVVCstRmaIWeH1kuDVXFiv8
Message-ID: <CAHp75VeeAOnUj018z_JdSKZagXP7yYaw7okm0jdT8BBp_DM6iQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: pressure: mpl3115: clean up interrupt handling
 and locking
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, apokusinski01@gmail.com, 
	me@brighamcampbell.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 1:40=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.com>=
 wrote:
>
> Return IRQ_NONE instead of IRQ_HANDLED when reading
> INT_SOURCE fails.
>
> On shared interrupt lines, returning IRQ_HANDLED after a
> failed register read may prevent other handlers from being
> invoked.

> Switch the trigger handler from explicit mutex_lock/unlock
> to scoped_guard() for consistency with the locking style
> used elsewhere in the driver.

Split these two. Moving to scoped_guard() is a separate refactoring.

> Move mpl3115_config_interrupt() above the interrupt handler
> in preparation for the FIFO support added in a subsequent
> patch.

> No functional change intended.

But this is a lie. The change is a (big enough) functional change and
actually it feels and sounds like it deserves a Fixes tag.

...

> +reg1_cleanup:
> +       i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> +                                 data->ctrl_reg1);

And if this fails?.. (Okay, this is not this patch issue, it's an
original code.)

> +       return ret;
> +}

...

> -static int mpl3115_config_interrupt(struct mpl3115_data *data,
> -                                   u8 ctrl_reg1, u8 ctrl_reg4)
> -{
> -       int ret;
> -
> -       ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1=
,
> -                                       ctrl_reg1);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG4=
,
> -                                       ctrl_reg4);
> -       if (ret < 0)
> -               goto reg1_cleanup;
> -
> -       data->ctrl_reg1 =3D ctrl_reg1;
> -       data->ctrl_reg4 =3D ctrl_reg4;
> -
> -       return 0;
> -
> -reg1_cleanup:
> -       i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> -                                 data->ctrl_reg1);
> -       return ret;
> -}

If you need to move it up, split this move to a separate patch.

--=20
With Best Regards,
Andy Shevchenko
