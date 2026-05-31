Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D249376BC2
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780224925; cv=pass; b=O7BZRsIXNE+7YR+3pK7QghLBygVo8WjTHoZVBSt9numplVXjRKoQlRn3AZvKcRKmvUp00fcFn86zXjUhJHVjEDyNt+vjHRLfCHU1Xme+Z6d3R/TvjqH9/7X4Gsra2zhKjher4gKs+EDSGrW6pGMYaT9kPwEEyUW94cyEVUHkjgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780224925; c=relaxed/simple;
	bh=Nm0tmq5ULLWQNSJtXAjGCgBa0hYs9qgF5ZFGoPUTPQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/XeAC0C3oJoKyd+aC3bYGLBiBT1CY/QrmjkTp1+uHpIz9PQ9q+e4DATCdhsKlJ9+2TJfUJ42jiolP7DPoDCX94TT02CJkfuzt/hgEAajzPgwVqkbEzoF6HuRBQ9gX0yDP03LUm91Ef1SMNNxktr0rhOk8DFEay3XddmjTjQ82Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXuCp4Fs; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXuCp4Fs"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa612bf6efso1236797e87.3
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 03:55:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780224922; cv=none;
        d=google.com; s=arc-20240605;
        b=Ws/oHAPePg0Je65lstewyUvimqDyr96wMNOg/BT9OSwhMQcTBr9oMkeGW//2K+isdR
         kNJo8bXFNnj+64I/UTMhgeplxs6uP7PL6TT2QZ2qASjdIE41PLYPBmBp6AgmDquvAhug
         b+hKcBiQj23xwf+ycdhXbfgM+RSBFUlQFBKyKFXPAj3YwkV3KzkVzK8kF0YjkhM0s47Y
         3VG6ddCG1Z2o6YogZwoG6d2Os0Nnk5gxpr3TDApa2uyCAPxM2aPwhtRoxqCAyYJT1eiu
         +GJaten3gS0LnvU2sD36OciFXkuimds77QaqmMo4DE/e27Q6ef/+ExwxIFM2bAZIbRnx
         3fXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1093W6GwBbIGfmlyuBH18NfrL6utXJlkl45KlHg45Ho=;
        fh=5cXoLD7M0pWJF9pCYgpdVZOJmvqlq2Wc8xQAMw7db6w=;
        b=Y+hGezeHhujAPaSc6CMNhNKmtiAwmLCvJZ+cwxgQw46jZhIIzNpyXriqKIkRTgW35Y
         us3MGSqSrA7Ufpu6Jh9HxOJP4utq+21wAIyJrkAAAnmG/Tkzm4Fd1EOu4PTHBvuXHwwR
         LSxRbOIr6uSAEI/gF1W7XDkiA0j9e3PNLXXRN5ezNeeloHc8t5B1/yAFXTtsUPLnlcIv
         zcqbRUJCz69/M1751J4NHqj9IvajWKVGx5X/pNotdiQCmPT0ZjSJxJPlsjsD4J0AKTRW
         CFjt8Z36PMe1M4WbEHMEGJBy2mVnWEG38AK9i5uJj+eFX1aoMq0V8yr+h8OgGmdFGMXM
         Fmng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780224922; x=1780829722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1093W6GwBbIGfmlyuBH18NfrL6utXJlkl45KlHg45Ho=;
        b=AXuCp4FsWv4oU8VIQt/0bZeahKW19MoDGzxxlVea1p24lFy+lEziMsZJkCEnKtIbeB
         wckiQoHuZbSwChMkdhjCVulf61cxvIpVR/KtEh78F76vOF7Zb27DjIPHpypz7BsWwi7t
         C5c8+eFmooOhxUv8Gcieriv/Y9JtkbVayx5zqSVDvWCtVr9vHZPBvTTvoTT69NPaWpPE
         qKPmoFpnKqwfn0fbI8zvrjJdRneAQBTCK82lbe0e07AnlCrgESBULdEYK+Gum4YlgiWa
         5K2PwgsskqmA/ACq2TPzR+JY1gLDPNfUl19tFG13odrhWzC8FPY7yCIX/w2M79nc7uc5
         lBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780224922; x=1780829722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1093W6GwBbIGfmlyuBH18NfrL6utXJlkl45KlHg45Ho=;
        b=ihV6ocYUnt2OA1DEVATZTKHJEruEaDSMBtndzDeiWl/I5FHzMxLiJr9rXOexZ6Y/Ap
         91VhPOSEL+Kx/VoSVtZ2N/zI6sinY2kqleIvXZ3syf/SPZxBw+YrMQDom3hNEg58bxHL
         agNleE5rgj1TgTLmRMJeP9e4NYoBwPaNECdVaYCLf8Rqd/JVkFEkQcxoD89G55aGO/Ht
         D1LV+xgXqbUpjCyvbxkpOKwye68yZoF3e1yamevZgiD9VklD7tt7VGsjrURJ0H42kcze
         KM6EjkkQytERdojKrAZxB30r2h2XR6rH5w1BIB0RfmjtrYX/4OsCbf+h+h2GxFQcnvnb
         4xOw==
X-Forwarded-Encrypted: i=1; AFNElJ9yIKR3o8lzprXteWh9AJS3LGJETBP2DyDdn21d5Zpf6mYl2CJcQQhInnA/TYUl1eMJVISu/SDRDSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz4vyRz09Z9bq/lMytnb04cTS1iez+8KfqDxkXDnlYrKfX+6c2
	k9cyxcT+5t0NRPe2WC+RE1fRVWvDqMeAAC8RdA0j/bRCajXEAT+nUsf5Z0ewZQDpD8Gu6WztEaZ
	yqt+xsLSyiL9fdwN7WaUiaAfjsV80Q3U=
X-Gm-Gg: Acq92OHZRzZFrZCAMCuiw1vhsDstpoctLC0KXGgcUSCb268Gf4Jasuhqrh0mDops69n
	4b8T2UE5cSnNEiEC/+t7bxmKWGj9IuLBhdZ9rC8jhjB+V/HfynqVxOLQdM0rfEeSW//2LlmiyZU
	eS8Oyg/FLxokqDTm7Rb2Q6sohA9pXakO1YGctCc4Ite/4xvfl+Ez9yOy4kiEOwN69zBmqFqwVN0
	3TAqZv++a5m0Zh/W5oSXgw0wcmRbtq3CVV0Fkwiiyxwp1LDAR7poJInsQzF+IRr7oww2wBPA5E6
	x5TS0qUduYrIwes2OvdRgF2XpRtWiw9biWvJZQdlRk9xzbFoMg==
X-Received: by 2002:a05:6512:12c2:b0:5aa:6c27:c44e with SMTP id
 2adb3069b0e04-5aa6c27c552mr54641e87.22.1780224921700; Sun, 31 May 2026
 03:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530113938.171540-1-suunj1331@gmail.com> <20260530113938.171540-3-suunj1331@gmail.com>
 <CAHp75VeeAOnUj018z_JdSKZagXP7yYaw7okm0jdT8BBp_DM6iQ@mail.gmail.com>
In-Reply-To: <CAHp75VeeAOnUj018z_JdSKZagXP7yYaw7okm0jdT8BBp_DM6iQ@mail.gmail.com>
From: SeungJu Cheon <suunj1331@gmail.com>
Date: Sun, 31 May 2026 19:55:10 +0900
X-Gm-Features: AVHnY4I2Lr4axwE7KYByIRLLAi7ZshWau76NwjYsMhtD9kY8YK2GQ8Qs4a5SX5w
Message-ID: <CAGwK=3qzWZHaewUXyvmxEG8Ann=s9AButj=9+6LEobG+O09pgw@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: pressure: mpl3115: clean up interrupt handling
 and locking
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, apokusinski01@gmail.com, 
	me@brighamcampbell.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Sat, May 30, 2026 at 9:33 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> > Switch the trigger handler from explicit mutex_lock/unlock
> > to scoped_guard() for consistency with the locking style
> > used elsewhere in the driver.
>
> Split these two. Moving to scoped_guard() is a separate refactoring.

Will do. I'll move the scoped_guard() conversion to its own patch in
v2.

> > No functional change intended.
>
> But this is a lie. The change is a (big enough) functional change and
> actually it feels and sounds like it deserves a Fixes tag.

You're right, the IRQ_NONE change is a functional change. I'll split
it into its own patch with a Fixes tag and drop the "no functional
change" wording.

> > +reg1_cleanup:
> > +       i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> > +                                 data->ctrl_reg1);
>
> And if this fails?.. (Okay, this is not this patch issue, it's an
> original code.)

Right, that's pre-existing and outside the scope of this series.

> > Move mpl3115_config_interrupt() above the interrupt handler
> > in preparation for the FIFO support added in a subsequent
> > patch.
>
> If you need to move it up, split this move to a separate patch.

Will split the move into its own patch in v2.

Thanks for the review.

On Sat, May 30, 2026 at 9:33=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, May 30, 2026 at 1:40=E2=80=AFPM SeungJu Cheon <suunj1331@gmail.co=
m> wrote:
> >
> > Return IRQ_NONE instead of IRQ_HANDLED when reading
> > INT_SOURCE fails.
> >
> > On shared interrupt lines, returning IRQ_HANDLED after a
> > failed register read may prevent other handlers from being
> > invoked.
>
> > Switch the trigger handler from explicit mutex_lock/unlock
> > to scoped_guard() for consistency with the locking style
> > used elsewhere in the driver.
>
> Split these two. Moving to scoped_guard() is a separate refactoring.
>
> > Move mpl3115_config_interrupt() above the interrupt handler
> > in preparation for the FIFO support added in a subsequent
> > patch.
>
> > No functional change intended.
>
> But this is a lie. The change is a (big enough) functional change and
> actually it feels and sounds like it deserves a Fixes tag.
>
> ...
>
> > +reg1_cleanup:
> > +       i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> > +                                 data->ctrl_reg1);
>
> And if this fails?.. (Okay, this is not this patch issue, it's an
> original code.)
>
> > +       return ret;
> > +}
>
> ...
>
> > -static int mpl3115_config_interrupt(struct mpl3115_data *data,
> > -                                   u8 ctrl_reg1, u8 ctrl_reg4)
> > -{
> > -       int ret;
> > -
> > -       ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_RE=
G1,
> > -                                       ctrl_reg1);
> > -       if (ret < 0)
> > -               return ret;
> > -
> > -       ret =3D i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_RE=
G4,
> > -                                       ctrl_reg4);
> > -       if (ret < 0)
> > -               goto reg1_cleanup;
> > -
> > -       data->ctrl_reg1 =3D ctrl_reg1;
> > -       data->ctrl_reg4 =3D ctrl_reg4;
> > -
> > -       return 0;
> > -
> > -reg1_cleanup:
> > -       i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
> > -                                 data->ctrl_reg1);
> > -       return ret;
> > -}
>
> If you need to move it up, split this move to a separate patch.
>
> --
> With Best Regards,
> Andy Shevchenko
