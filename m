Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3FE3FA5E8
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 13:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987638; cv=pass; b=LLRWxmUP0rrwOblmH6Pw2MfxWbaH1DjYKYPUluGCeSnKKzJlRRhSuYIaSBDhZ8N2DO/juX2ewBEJK/5l5xrXR8btq+HQSmXVu+5sVXwePHpDGpjtATTn2ckYMUV7LIgIHlYaPSy643lNaYGHeezSJvxjjp46eRNwaAiPUvitWeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987638; c=relaxed/simple;
	bh=1eD2Ehb41892j8NRvdWdejmSftUIAKIN/3VBdf/mA3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFwuuGOHiywcf9hpVskZagy9Y6/eyJ3/tfVH4KE5rd1Fm+Rpz+HEthwwEr5AXjcGbJRFeuJKttBJ389ZCQyj6Y/n184uBnmDT1B7hfVAVg5TtfxsIi/wBeTW6MWevOpQ7KDQ8ncszKgkZSEiQBUxoDvWlni7uRPACEJoBnTAkuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU7Ddxxz; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU7Ddxxz"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c5361142fso2037481d50.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 06:27:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777987636; cv=none;
        d=google.com; s=arc-20240605;
        b=RZPpWzklQFE8jrxz1eP6l367n+dHJRy6ZXNWYv5oCPMSI6ZEBk2r1Pf4Ka6BQLnkwk
         B84NoE0UWQuuH5A7FG9qKJsm2S+M56sNapG4/dAPsoaUDFLkrmDU5z0QKBT89ZRn44zj
         DyP4kbvWKqDC8xI7xV12VvdgQJUf3lyPfFiFnnC6RxiT4t4AB7xIiA//WozOiIAxi4qz
         jPGbh/+rEbENZi1q+Fn+Ybl+QV0WE68DbTWk2VOCwllSvUlhtLfaWPcCTJG1+pnhq+P6
         5bFMwlfRd0xgr0lZUK7nHzKQKN6plnp60YIGAFzpTPDQ/ppVYOcE27UU34PWbmyrclWs
         zcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NqQ8ANCGYllv/nG6jPR1ctYA97nShrGTtlRgZa+laOc=;
        fh=zBo6pFlG8M66UskTKlINfzKTMNn57zqGPzOk8Rjv3Ek=;
        b=C2YT5TZHNlVaG5Zt2OcKEai1si+k5noWtAIZosm6Aul5fOBtEE+nRtJC3SkLg1Hfi6
         yd5gBizHNMqs5+0zXIjvutJ6eXZGMhha1SCZE9WE1mJlN1ikiC3CbSNaV+7Ig4v6OqKR
         CfO5XB7w6NF02Fm5wC8G0RwqWs8fMQUndqRvdjolUeJ9/vIyMKqoKwCs+fFye9OAJFCb
         RelU2muuyDptSV1CHZJ7xX9/C3CJoT5icZNKokJk9gFtsJ2YaT0c3WY44BvYtEASAHLQ
         ihprGwoJibH00uUpl7V91KHj+vTdxU/aeDDR71rsSPkFX7iO/4P/G1yueEUyHwWzQSS8
         T4vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777987636; x=1778592436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqQ8ANCGYllv/nG6jPR1ctYA97nShrGTtlRgZa+laOc=;
        b=IU7Ddxxzu740xQbPAI61JCaxVkjnSz0YvG7bxhuYylZ5xN7sYLU/gkRUWjcEUq/7yE
         4zGuSOfHoNELlULHQM+XFCiTCfiK2E0mn947MgOMcteINnrZt83uNhu6Xm6TbWNMzvjR
         6WeVxCkADBltp3i0jEV8blZ2Y2W04jmuGSr7fd2MiBM1ZMhSG2LuRWZKiTu85R8O1FTH
         lmKZoHs36QGk25KHswEu2PE7aeVUXlhbsYu4YT9yPo8V4sbn4DsmZu6vjhs1irs/kDus
         NJQRrMFuEvjuKnFBtKf6fABoRlHdYiQbPyRKmerNWGZgbqGX2017I4YsYgTW/CB1u+WI
         Y79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777987636; x=1778592436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NqQ8ANCGYllv/nG6jPR1ctYA97nShrGTtlRgZa+laOc=;
        b=FPlBsy7CJgubUqP2M9QWIExvLdKLkTb5eWG7HYYbsLL2JSJzQoneOLP9lGGD2/vBSA
         fjFpj6vIvOFzqZuzY9nzaHJ5telarNFu3A/EqklSl9WEi5Omi7GjYecuhak9YoQkooYc
         uW5tTgMDG5wD85r5GQ/G0Z8XxylR5trwog1QV4PlJrC99Ijx4rQO/XBKvYaCGdvqMruN
         rxHOACVJToTOcqGznVw5VHxf0Q5v16annlRChwng+ZHxNt1spIpNJopxuk4TuRjlJGzK
         XsVsvB+AxLF7p1iBJJjG/PQ6PYB0AHhV0Ri3sYhXFv7tAz4nqRcOlBvz4ElUxy4W6J/k
         FOpA==
X-Forwarded-Encrypted: i=1; AFNElJ+0ltNc5cuhyomhsOhmFjY4McNdUh9vobVW8KE8k0jaZ7NxAb6iuwaUyRbkNIiHsgBJJyQX/NARHKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9R63hirI49mykbpQbQoaYs8g9gpVtCnhZqRzom5kXz93tYX2A
	Hwf5Qu1LyxxMX1+2dbv6YtH8Va8UHXjU9A2qDhyCnH5QUMTbczg1m1ET49Y6tp+yeZx8H96yQgL
	GI5ODMuhBDXhEpFxQZ3wLRDqzH20UEH28sfKU
X-Gm-Gg: AeBDievVyajf0VNYu5mGPhb6Ba/yeS0gBMa25+qOQgHJfRJs/d1FlKbk7cglQRbp8zV
	W7trqlYNLmXWsbF6rOAyUdarYKpr8YuI1Mbj0/bzsHCCH9U2GwjSPehugEb5zQ2DXX0YRO+kNG9
	bDFOBPRBr/Mwg7xXGkZsFVkc0hSqk1MTrzkyzaZVX5S2387ZDpHiA4oAHhTHAngpKpjzUdnUlti
	4czLXgw0W9aNsfQ+VxLC+ORu2q8LOAaGWRFSpn9zZCT1kaj32hNf+oyE9DBFAq1zkYwlTv/HCC7
	QoEwO5l5J06Z0V0jmNxTs+7oIt+fx6k=
X-Received: by 2002:a05:690e:4396:b0:65c:27b5:415b with SMTP id
 956f58d0204a3-65c3da0cdb2mr10298124d50.4.1777987636080; Tue, 05 May 2026
 06:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505124706.9862-1-m32285159@gmail.com> <afnr4TjC3DVxkVJt@ashevche-desk.local>
In-Reply-To: <afnr4TjC3DVxkVJt@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 5 May 2026 08:27:04 -0500
X-Gm-Features: AVHnY4L4ELeT4J-me2ldW23zCXHatxK-NYpe4k54AsGXhVGzAy3rA--p4v_I-vE
Message-ID: <CAKqfh0E8rSUGx1d3WEKhTLCteoQ9Bdctc+R8yVaw6_t_156zhA@mail.gmail.com>
Subject: Re: [PATCH v3] iio: imu: kmx61: Use guard(mutex)() family over manual locking
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 8:08=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Tue, May 05, 2026 at 07:47:06AM -0500, Maxwell Doose wrote:
> > Include linux/cleanup.h to take advantage of new macros.
> >
> > Replace manual mutex_lock() and mutex_unlock() calls across the file
> > with guard(mutex)() and scoped_guard() where appropriate. This will hel=
p
> > modernize the driver with up-to-date functions/macros.
> >
> > Remove now redundant gotos and ret variables, as the new RAII macros
> > make them unneeded.
>
> Did you compile this version?
>
> ...
>
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
>
> This looks suspicious.
>
> ...
>
> Please, slow down and check the patches you sent.
>
> Also, use, if not yet, --histogram when preparing patches, it might make =
them
> more readable.
>

Thanks for the tip.

>
[snip]
>
> Since guard()() is not like lock/unlock, the blank line is better for
> readability. lock/unlock scenarios look&feel as special scope, that's why
> the blank lines there are optional.
>


Sorry, I was in a rush this morning and I wanted to keep to my promise
of getting it out this morning. I can make a v4 but I currently don't
have time unfortunately, so it'll have to wait.

best regards,
max
