Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C92DB798
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464302; cv=pass; b=HB7UZx4lxItux/y0x+6OHLJ9fRVW2eqxhwFEvKE5rMN9ArRQFkoJROW7DrVEz95MqCUXrtGGIHiGYZF582MjsE4gOJ40oc8+DMOelaWASPdSUyD07F+RdMHkjFPafG0o/xIAVSRvs+noNCYC8/jbJ1QoBu7+SJDpm++owDnw/0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464302; c=relaxed/simple;
	bh=Qw5yRvYiS7kUwQJfLdr6trlIk9lV5G1avsCnGWCVnK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnDFYsJsKYaOpo1KR+IPrHLNgeZCnUoIzXHjSd+QeirKxLbtHjsazDiCT26Irnk9+C4qTPYLWxkwknVLy8vYz1OKnarDXv6FHqUT+OwaRF2pVcHUFbl05DdC84v5rdRbJiTA3+6rSHhDxzFp+ItUAjBIYE87qHdsEsnkifg5KVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwYIQmCA; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwYIQmCA"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65eb1b25c77so2060978d50.0
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 08:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779464300; cv=none;
        d=google.com; s=arc-20240605;
        b=VJI9YWl1O7EgoWWh9p/PJaz5438KmLDCfndVMbIviu9KWKHG5SlagO6yccwzMdvHGT
         RI+zl88WpfpAmAJEA7CbCwdFZDGs5+sDK8IMHjdvXC3PjQTThQhU80+PxXSbFLqYBCW/
         EFck61O7q08ibjhWjoHiBCqIg6DnxgAq7bkaJkKebtaiugZawNIrBGxPXfiuUJ4UcBdv
         FB6rzO2jvOz6rUISAakOrMNqPzgKQ8y5fcldQqLpZx2WebAEWEzmQ+ENLMHEMksiC8S5
         fQiOYj/6GBz/unkTOZw4W8+gbIpQsUzsWj7SjomOgabFkkizbdccKZYbQZyQc/ITjk/G
         5Q5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQhZueqFcTevnVAsV6SgxaCamdNjCQhEZlja+rUV3a8=;
        fh=ZHVGG2Slv0kEx2O21b8rYISfysFGq9TSCPilQ1UoPd4=;
        b=ggFKkN3Fcpi7qKWiUXr+rNhccUOr5c3Vi204gbyFNXwG6Hv1kqaagrvSvH7t7+Gqvn
         geh5+i3yPI3405NfKLmaDrQXPCctnckucP98PzYtG9Lt0G6fAiFjl1wr+4kXje4l3/dp
         xPKuWftvtf/2dwhhiKNF9epx0sX6An0ANBQe6TQN/F46tQINZAfMh0OX7slpd+fRguaW
         V0YT8hoCIhYJWQFCBuhlf4QQIbnGfjNsZWUDaDnmPsIZKaLDV7ubu5wSXO9tPmulMTMS
         UE72YRingEZA22SgvqRix6g8DAgN1/aAo4ox/KtYdOnzLKEUOAvK/qn9/FjY6vCNRDlI
         bAMA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779464300; x=1780069100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQhZueqFcTevnVAsV6SgxaCamdNjCQhEZlja+rUV3a8=;
        b=UwYIQmCAPh37JMqgPjQjX+6bATXuAcODLXgC8S6u1/5EPpGUTA3dGIGQDb7aSBsoY6
         viO5e6xRytqv1LTCrEjcl153YC4suQ/Y4KU2Z2SmDR8LT2u6dABtqu/ZcZ9Zwu3YQjny
         F/pP9y5Btbtxjxg3baKxp/oTP0MPSu/emc9OZM3Ed7GLWf9OGd7IKEXEhWrBe38LQir2
         UN8Qw6Ura46E1JhBfm05q/p4JzwiVKHKL9CU39BtpF2im72qWze4I2U95UCOrffy9Dor
         QOSDO0JOsYUXqILLs3p/aHcIY7ovsUWZGwG9I5fsZtSiPlqP1f4qQXXsPuhPabVmad9m
         wfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779464300; x=1780069100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQhZueqFcTevnVAsV6SgxaCamdNjCQhEZlja+rUV3a8=;
        b=qVLX6Hcxw35b/Ch4XtNUsF7rgtBfGw38EFd6+SQ4Z6SDphvBKhuipfA9zEG+Vh6WP3
         6qqkr27jIXGtRqTI9V6g+s7nafhBpjGiF7lzDqdAPep+T+zs5obx1Of0AqnLWyxgN6P+
         2USQKLXVJ9UtXYqaJYcqX1Uth8Mw49Tlefgn5PF5MAciUfzyzxcikd29HADtYO32kh1X
         rTjK2YHPYuZyge1Xx+FMA6SP5wg6Gs2uqgne199eQECRgMSGgK+mStH6xA0c0jZPe950
         1EU4XnEKawL9Tb6hBw8pDvK1qEk9vBTHWgA1MIO6rAt6M9sWbvuXAhi+8ydXwOtzP9Yb
         JkjA==
X-Forwarded-Encrypted: i=1; AFNElJ/Zb5KDBlpq0r1z/16/jmIK/GhYXXu3S/L3PSkNdnD9x7JpS5OrO2j8LK4qyy/UuSr2R7nclXBTcS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxAs3/bhnp2kQ9GsrE6eJ4QCa/vVV+qdAIF272o48rpsICQPDC
	iTFjNv4Oa6Ky0sOPNtErBksQcGZCXSMb35EKTSo9kEizzHYi64ncxyUlZVTF13f0InjcFbn6gjI
	rcADgPZIsEsnk9ygkA2Dz1s+9AQGUKeI=
X-Gm-Gg: Acq92OEmhPOXBmQ+/pWENyrTTjZ163YrNLbaN9+nHdjzlnoRJP5+Q+Mifr363t2Xw8N
	NkTuMiRs4qCSi9hFWd0o2LLU4vqAwxaTJJmGja12wTCwd8krYIGglXhDlfYGvnFoH5o1o9Dkbos
	qSCMlTJ1NTyH3Rjtf+wIlVrooNQyYsanrdrSZtG9c47YzjhGoDy9tOkl4FBcBWIvHwWukqy1h+s
	wqxYr+rVfGy4bTdjyiS2Ng6wHMXJuxSEh9TwjqmYCdFoIJtwPtVUGS+Vt0saBOPSD8EtOlb4ioY
	aUBocqzeI6lj5zT1bEka
X-Received: by 2002:a53:acd0:0:10b0:65e:18a4:3021 with SMTP id
 956f58d0204a3-65ec992ca26mr3414034d50.52.1779464300161; Fri, 22 May 2026
 08:38:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521223044.61410-1-m32285159@gmail.com> <20260522134603.07d31cbd@jic23-huawei>
In-Reply-To: <20260522134603.07d31cbd@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 22 May 2026 10:38:09 -0500
X-Gm-Features: AVHnY4JWnyaRSpI7abnP3XfruUQNTk9LvZwKSHJiVLEqtkrxAi1WR3OWB9k57ZM
Message-ID: <CAKqfh0FE+gvh+Mfn=f-9c2XVYg8uekru908ye6fzQoFoXrpGVA@mail.gmail.com>
Subject: Re: [PATCH v7] iio: imu: kmx61: Use guard(mutex)() over manual locking
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 7:46=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 21 May 2026 17:30:43 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > Include linux/cleanup.h to take advantage of new macros.
> >
> > Replace manual mutex_lock() and mutex_unlock() calls across the file
> > with guard(mutex)() and scoped_guard() where appropriate to simplify
> > error paths and eliminate manual locking calls.
> >
> > Add new helper function kmx61_read_for_each_active_channel() to mitigat=
e
> > certain style issues and to prevent notifying that the IRQ is finished
> > whilst holding the lock.
> >
> > Update certain returns, and add default case to return -EINVAL in
> > kmx61_read_raw().
> >
> > Remove now-redundant gotos and ret variables, as the new RAII macros
> > make them unneeded.
>
> A few remaining things inline.  I'll tweak whilst applying.
>
> Tweaked as:
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 52a6e044e1e5..b8a8297b39af 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -827,15 +827,17 @@ static int kmx61_read_raw(struct iio_dev *indio_dev=
,
>                 default:
>                         return -EINVAL;
>                 }
> -       case IIO_CHAN_INFO_SAMP_FREQ:
> +       case IIO_CHAN_INFO_SAMP_FREQ: {
>                 if (chan->type !=3D IIO_ACCEL && chan->type !=3D IIO_MAGN=
)
>                         return -EINVAL;
>
> -               scoped_guard(mutex, &data->lock)
> -                       ret =3D kmx61_get_odr(data, val, val2, chan->addr=
ess);
> +               guard(mutex)(&data->lock);
> +
> +               ret =3D kmx61_get_odr(data, val, val2, chan->address);
>                 if (ret)
>                         return -EINVAL;
>                 return IIO_VAL_INT_PLUS_MICRO;
> +       }
>         default:
>                 return -EINVAL;
>         }
> @@ -1178,8 +1180,6 @@ static irqreturn_t kmx61_data_rdy_trig_poll(int irq=
, void *private)
>   * @indio_dev: IIO Device struct to read from
>   * @buffer: Destination buffer to write to, the array must be of at leas=
t size 8
>   *
> - * Intended only for use in kmx61_trigger_handler().
> - *
>   * Return:
>   * 0 on success,
>   */
>
> See below for why.
>
>
> >
> > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > ---
> >  drivers/iio/imu/kmx61.c | 129 +++++++++++++++++++++-------------------
> >  1 file changed, 67 insertions(+), 62 deletions(-)
> >
> > diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> > index 3cd91d8a89ee..6e9eafc06d78 100644
> > --- a/drivers/iio/imu/kmx61.c
> > +++ b/drivers/iio/imu/kmx61.c
> > @@ -7,6 +7,7 @@
> >   * IIO driver for KMX61 (7-bit I2C slave address 0x0E or 0x0F).
> >   */
> >
> > +#include <linux/cleanup.h>
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/mod_devicetable.h>
> > @@ -783,7 +784,7 @@ static int kmx61_read_raw(struct iio_dev *indio_dev=
,
> >       struct kmx61_data *data =3D kmx61_get_data(indio_dev);
> >
> >       switch (mask) {
> > -     case IIO_CHAN_INFO_RAW:
> > +     case IIO_CHAN_INFO_RAW: {
> >               switch (chan->type) {
> >               case IIO_ACCEL:
> >                       base_reg =3D KMX61_ACC_XOUT_L;
> > @@ -794,28 +795,24 @@ static int kmx61_read_raw(struct iio_dev *indio_d=
ev,
> >               default:
> >                       return -EINVAL;
> >               }
> > -             mutex_lock(&data->lock);
> > +             guard(mutex)(&data->lock);
> >
> >               ret =3D kmx61_set_power_state(data, true, chan->address);
> > -             if (ret) {
> > -                     mutex_unlock(&data->lock);
> > +             if (ret)
> >                       return ret;
> > -             }
> >
> >               ret =3D kmx61_read_measurement(data, base_reg, chan->scan=
_index);
> >               if (ret < 0) {
> >                       kmx61_set_power_state(data, false, chan->address)=
;
> > -                     mutex_unlock(&data->lock);
> >                       return ret;
> >               }
> >               *val =3D sign_extend32(ret >> chan->scan_type.shift,
> >                                    chan->scan_type.realbits - 1);
> >               ret =3D kmx61_set_power_state(data, false, chan->address)=
;
> > -
> > -             mutex_unlock(&data->lock);
> >               if (ret)
> >                       return ret;
> >               return IIO_VAL_INT;
> > +     }
> >       case IIO_CHAN_INFO_SCALE:
> >               switch (chan->type) {
> >               case IIO_ACCEL:
> > @@ -834,41 +831,40 @@ static int kmx61_read_raw(struct iio_dev *indio_d=
ev,
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
>
> Why is this one a scoped_guard()?  Seems like it would be more consistent
> if it was done like the one above with {} and guard()
>

I'm guessing you're talking about the {} in the switch-case. I guess
it's likely because the guard()() in that specific case goes for the
whole scope of the case, whereas we only need to hold the lock for
this call (I tend to keep section length as close as possible when
doing these things, and typically I'd use scoped_guard() for a single
call).

>
> >               if (ret)
> >                       return -EINVAL;
> Unconnected to this patch but why are we eating the error code from kmx61=
_get_odr()?
> In practice makes no difference as -EINVAL is the only error returned.
>
> Still nice to do
>                 if (ret)
>                         return ret;
> so we don't need to go check that.
> I'd be fine with you sneaking this in this patch with a brief not in the =
commit
> message if you want to. Or can leave for another day.
>

Seems like a better idea to do this in a separate patch, perhaps where
we refresh some of the returns/control paths in the file. But at the
same time not opposed to sneaking this in if I end up touching that
function in a different patch.

>
> >               return IIO_VAL_INT_PLUS_MICRO;
> > +     default:
> > +             return -EINVAL;
> >       }
> > -     return -EINVAL;
> >  }
> >
> ...
>
>
> >
> >  static void kmx61_trig_reenable(struct iio_trigger *trig)
> > @@ -1181,30 +1172,51 @@ static irqreturn_t kmx61_data_rdy_trig_poll(int=
 irq, void *private)
> >       return IRQ_HANDLED;
> >  }
> >
> > -static irqreturn_t kmx61_trigger_handler(int irq, void *p)
> > +/**
> > + * kmx61_read_for_each_active_channel() - Read each active channel int=
o a buffer
> > + *
> > + * @indio_dev: IIO Device struct to read from
> > + * @buffer: Destination buffer to write to, the array must be of at le=
ast size 8
> > + *
> > + * Intended only for use in kmx61_trigger_handler().
> Not seeing a reason to have this comment.  If there is another useful
> place to use it the function is fairly generic.  Right now there
> isn't obvious, but we don't need to justify that!
>

That's probably just me erring on the side of caution just to make
sure nobody uses this erroneously. Although, I guess I could see this
being used somewhere else (assuming it was tweaked a little bit).

best regards,
max


> > + *
>
