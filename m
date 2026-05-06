Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3AD3F23CE
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079506; cv=pass; b=OyFGZDu+kv9jK4heqZ0Hp/8COAMQRjWM0aUfG/gLQZGFJmhR+b3f/PU5ACgWJEDdVMdA1Hnfptyi5myEZwfvlXGAfkn1S0CPWOm4NFzEHAYtiwmKg39rh0ROQ6M5+wmlJvakbFuK6hyRUvvQvXVMb/bGAPfECI+qhy0za+J2TZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079506; c=relaxed/simple;
	bh=B8MTdoZ/4J5nA4tlrm7Z4wnW7n5xhFBIdc1GhRFa8oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KhtADMEYe9ELeUcQQ9FQbWk4txSkMrZWusbPXxUuw/5IVXW+NRdRKdLnl+kwNbaI+ztbBkY1KTG5syRJTUIuMDlclBfVtaq6pqWpGKUbCXXE1DUI56gK6guoJCZqkNTRRwT8ckj56lmTfxnmHphSGWksFr8kMDWbpG8Aqs3obM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRW+BiUC; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRW+BiUC"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bd87e5d8ffso11488957b3.1
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 07:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778079504; cv=none;
        d=google.com; s=arc-20240605;
        b=QDTKoakstrGAOhIBmaIraLk/3n6JH4o55dKoNWClQjpf75NHPD8sZYTHERKbjYmJ4C
         QWjdSr/hE2+uzvmfZEmMeMsvj0j7twa8UUCP8WzByBpjL43N5/10I1IMYv45q5ZouOr0
         YLpvV9XgLV6kqLUxvqEKqBFQgPSf2K5b31iks314EqFhz3Skb699kjjUJw5bon0WLbkw
         eOFDWiDaLV8H1IinrTDVba2wqKoG6xHR1YiWqIMDEJwbzhfId/GiGAXYs+dwimrG0aiv
         Qeu3Xyd42iV3CAj+XKJJNVrArmjRHow4avwcZfljXoP0//G2fSjIqWmByV29oJYHSXoE
         zF8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iSOsuLkaHRGhr2vYgjNeBFoaA6Sp0FHRZCtuC7QxsvI=;
        fh=IsFWoqJ1cwvcoQioN8FgimY8kI6fFzqysaZQWOBSDKc=;
        b=ASJm/hOE7Uw1CXvJyY9SsFUULCQfolHspBg/uFJKZ1fNBwqgxtcToHZvNBLVSjB+K7
         i8BjYLYqkUysVHDC9vBZfgj0s1L2Em53PjrXCCmxEY0RWbOlc8GoRyDdNCYm1dmPGLj9
         0eS1N8RNZ5yNjYXtTTnvWNslTXaVKBT+9iakP69F5S8JvC0jmmxPV+kFhxNr0iTMZfG0
         E4ySsjM+N8ZQ60vFtkF0iQ2KzlMrGauRzoWviyrMauF9sa55Etz/CHEe6dB0prGdQlZb
         YwJ5657wxgub0N7BC6fwCgL5tzmpPBuli5pi2isDDVCya3f8oezMeXa195tJdDEhkDEr
         3cdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778079504; x=1778684304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSOsuLkaHRGhr2vYgjNeBFoaA6Sp0FHRZCtuC7QxsvI=;
        b=IRW+BiUCrp9iwhDbsGjyz66UDq6rWLE6yWmulm6zeyYX5DJoVlk31CaD+RLELTMajL
         z4OABat9x3PW1voda3WWF9W8dAX7NlEh50IKFc1RjQ3f7pZ1//qSRDTXTL2g0ovRsHIe
         PPifiMTNE+ri1Gtu3QTyWIDA3bH0X5iIjZ524O7Qgnvqpr6BhPsZ+rEMmwiqUZ1x8WWh
         BZ0rVWrIQWyY8m5R1cvxfGgmgajk7NSq8iLk5tqEqMzefAP4Ih6N+z14Np1Dh+iOrgGw
         yloX+aWyE5XwFtVdj2iCENVABPnRBvSiSqTz3fIEOKOrVvWyMxIxLhJH6kI1ipQDgndZ
         M8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778079504; x=1778684304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iSOsuLkaHRGhr2vYgjNeBFoaA6Sp0FHRZCtuC7QxsvI=;
        b=WvHjGAfiKr00geHj1E9pifrbhT76n+dtDApbM/ik5otxLnqKCm27BD5lqUfNrfYxiC
         3V72DeOvOb80NN4OJFgtXSnN1w89ukq6dHX76ii/8GHyBjI3A9oko3kyble3v8BVpZIT
         Qd3sL9Lh1EmSobqegJbLP4tT4bTEoYnbkfrgLyt69HWPwswIKWF5HBW9wsT7eAMH5uPU
         VlgrM0+3C908pO17i9moIxgMARaWntOZziJdyMKuiuD6bu+dgLj8yCb6CwHDnraqec2N
         jnF35xgnDgopDC2QmweYRWEuPBnVFm5mcwh+GY+2wtdOiXp/e2qXYJvBce+KvEKTjMA6
         j/lw==
X-Forwarded-Encrypted: i=1; AFNElJ++zu9k67i6YB/zA1Mp5Ak8RMrmT1yq0Q265mFa0SCWf3OnS50d+js+qFQUsXIPngyfLd2IGwda2MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR8BgMS1/KnWV6SZzggUeQ2rgSc1/VWzkkNgVZA3mDXRM59aWq
	Yvp4UDSvbmVh+/R5p3fo2xTrqBydUgOO80qH/0BBPdmSOpyDb4nxotRBV3sOINSyIWlbswIl8HW
	nOjLCqSYgYYr7y5frbY0UQnZR5hSCgKS1iQwT
X-Gm-Gg: AeBDietAH7Y88VsJmc+4WpMiho49ERT8EN+sYMv72ZS8TLCDjQHDpLjU/BV/WM1uxoN
	U5gB8bM5vq0wiSiEeEUE5c5AQ/NVV87gz8HCH0zKVv64VmJ8n/LOUohO/jn7heiaQL58iAMGzqe
	3y/jVJWxhCbm0Rs3VSP/7BdvAAUMW/KwK/97iJrC1h8A4vDOFPdET8q0sY5poZ7RyhLWy2D6r06
	N+VfWPVd4M3PsKxxTKMFP+Kk4eOkT0dAAu19AAFcsFs+tJOc3BKeISgrbn3dg+7MkF2P97mK7nb
	ntwSCwYqjo53QrSQu0eDrIqSG25HK8Q=
X-Received: by 2002:a05:690c:660e:b0:7ba:ff4b:553e with SMTP id
 00721157ae682-7bdf649dc66mr31058397b3.8.1778079504268; Wed, 06 May 2026
 07:58:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505220719.44646-1-m32285159@gmail.com> <afsElj3doL4HZqYd@ashevche-desk.local>
In-Reply-To: <afsElj3doL4HZqYd@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 6 May 2026 09:58:11 -0500
X-Gm-Features: AVHnY4JN6zgCrrFgeS1bVockIok5PzF7oFEyi4G6I-m-YZoEWRycezZ1ypUU00Q
Message-ID: <CAKqfh0ECu8cgbXc0JMr6oWA-5W14ttP1u2hLfQPS8vv08G+HFw@mail.gmail.com>
Subject: Re: [PATCH v4] iio: imu: kmx61: Use guard(mutex)() over manual locking
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 4:06=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, May 05, 2026 at 05:07:19PM -0500, Maxwell Doose wrote:
[snip]
> > -     case IIO_CHAN_INFO_SAMP_FREQ:
> > +     case IIO_CHAN_INFO_SAMP_FREQ: {
> >               if (chan->type !=3D IIO_ACCEL && chan->type !=3D IIO_MAGN=
)
> >                       return -EINVAL;
> >
> > -             mutex_lock(&data->lock);
> > -             ret =3D kmx61_get_odr(data, val, val2, chan->address);
> > -             mutex_unlock(&data->lock);
> > +             scoped_guard(mutex, &data->lock)
> > +                     ret =3D kmx61_get_odr(data, val, val2, chan->addr=
ess);
> >               if (ret)
> >                       return -EINVAL;
> >               return IIO_VAL_INT_PLUS_MICRO;
> >       }
> > +     }
> >       return -EINVAL;
>
> For making the above less ambiguous, add default case here instead of the
> standalone return.
>

Sounds good, I'll get that into the next version.

>
>         }
>         default:
>                 return -EINVAL;
>         }
>
> >  }
>
> ...
>
> >  static int kmx61_runtime_suspend(struct device *dev)
> >  {
> >       struct kmx61_data *data =3D i2c_get_clientdata(to_i2c_client(dev)=
);
> > -     int ret;
> >
> > -     mutex_lock(&data->lock);
> > -     ret =3D kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MA=
G, true);
> > -     mutex_unlock(&data->lock);
> > -
> > -     return ret;
> > +     guard(mutex)(&data->lock);
>
> Leave a blank line here. Same applies to all guard()() cases like this.
>

Ah, got it. I'm used to grouping related stuff in the code so to me
it's a bit strange but I'll also add that in the next version.

best regards,
max



>
> > +     return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG=
, true);
> >  }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
