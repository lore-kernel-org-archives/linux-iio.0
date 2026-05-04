Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502B2D8DDF
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919313; cv=pass; b=AH+NcE3qgBtqgLXGuus84SD5tQHozKoS5wyS5YGjA1HlWQMcIH/P8DDKzQdV/AfFFyNriu67InaZF3CqiPydPGzWgAYO8fUccmkAYxBzufGDj2zluFF1zwx4BrSy39TkTFP+iu81PJo//kBW3PZ0Z9Q8t73utRHA8VLxI3ZBdV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919313; c=relaxed/simple;
	bh=IFBWCxcFmaat8Vfs1iKHds6XZBrnpVZXdZ/KYEatALA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJKJK2lxeS381OPwpuEPIr96v+PGm1e6LRm4X7xNsHtVnwYYYOxxugClo9aR+hjgVIrkapS4tOMd6KDOu+vDXJy2tx2DcdAbCNqOt/MG29cbmPQaDddy1FjcxY4wxyJIUyvflw9CArR6liLVil11+vuEGy4SKz7wKpe8I/kQM88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9O5u0bM; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9O5u0bM"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79ea87af213so76970197b3.0
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 11:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777919311; cv=none;
        d=google.com; s=arc-20240605;
        b=NYopSeCsJPCntugyaj54qVBriZHlHWDTlAQCuZRm0OhKOt4ljuB7wG38lDv3arKrQv
         vzY/yvyDExapoZVYxB+oMMzJoS/ehO6cbt6TcsDOqXOb7wccGyzfW8on3yo+dK/asvq1
         tsdMCKmLmAfYeSHGXqmvsrHUgYA+XoP8NZRRrmqYCkJsY75Azn75jYYQgdPU9CZVnBOR
         sHHkpSMjj4S556gvHs2R+OO/gcvdS1nMg999WVHxY74Mc1gMqZw5aiDdl5E+psJGsTwU
         7ar6kGOZYpelUVS9ll1vtswlcJyXdwbRxPeW87oPzE09IfRqMR7ufFQF+ShbZOHcw0t/
         0+Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R1iBpVcy2tUdxbMNrmCF2c+EVXCDRDoLzbG10vy3+BQ=;
        fh=FJ+vV193AgmLs1l8Oy3ZJq6DEFKdO9KdAZ3meoBH3nk=;
        b=D7rMjGfHAa9UlNm3bGWKKyN1NOIPUisjDBlLL69JZCEHvz6OPgtPKrIcNcCUeoL7kJ
         74LVUg+aETHvrTBxPN07JPdUJBKRYqTwsfu6orVhbYPYKKIWV0Y5Ccda5ub1GwU/9j93
         NvurxODONcjpA9VO/YfwST+TNGUoJ8kY4LwJYWX5kq3Nbcri/mOOaMBNQTmrW+nB19m1
         KIEK52t8u5U7+3/YHWX5fsYG/PcZw4WBP5eTAyLIXZajsxb75rYsN/emIREN13lQFirc
         YrEelcCe7wBslFVk57W9+XfDM06d0XQIZX1EWwlKhArjNE29Clms+sDy9JBmDToHy/6G
         oxtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777919311; x=1778524111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1iBpVcy2tUdxbMNrmCF2c+EVXCDRDoLzbG10vy3+BQ=;
        b=H9O5u0bMRRt/HIM/Seh4qg4MFFNd911AadCsqex5KXdmehoq/YC9/4xXTojvZ0ige2
         uuD8LKl3mP5vxARXmw2o3oo5XjnwUKBW4IRMm5MT9YU12tZo/bfyRM9dQIG0mlAdLI1+
         35+bIR8RduVHqCz9U1f8LLDQpTn8oOw4YD1BovUwxOS+FBSqhBWHIzdYEonrNlVk2+hT
         UwSpzuypx3ereZalEY5nM9I1vMcpmt0E03InE+diLGszK5k0kBJ3ZIxLgB838jvgopI1
         QmrGrt1rc5BCl+k/9xvh9OCWwVU5Tr8WsbJdVHJqSn7ND9eW0+/t6PLD8qnx+VcomOs4
         om2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777919311; x=1778524111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R1iBpVcy2tUdxbMNrmCF2c+EVXCDRDoLzbG10vy3+BQ=;
        b=RDpdHjF/8vR7458qZ0wi7baCqoyxJpEIWI4wJq+cuB0437wHRKjUW1GwrkjXuEUpxr
         TZ8nxEf1rU3b+JtvsWcD0fuo40HtRK1kfHpMu9DjL5QimCLpi/YRVuPequ+9Mhw7H8yj
         0sXYIGbCk2qKzxB5yuRuexhCeHy9Chqn7/SR88qVu9n1HGqZjB3RE1xIujd9RiT50Tmy
         UR6I5tOrvpAAC2MLwIHyU6YC1JiK4d4tvkNnl4ZCEHFeo276/bqULpjDcQpOHqzzZxa2
         mBKFIUfYfIxr++oPhc+dQ0cRYTm362/3fVoxPIQsDoVvv/BHNH2NtmoqgnzZXH17lyrT
         R4IQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gEPd8G9YJS0h/DVvzTqiiL5iY40KmWdaqVUAie6vGQ0zMkAi/BPbKpIPv56arzjXkv2kgByIa36w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlieN0SChDYebRh9qu0yXfUuR2iFVRFgD4bXf579SbEEVTwS+m
	oY49v2s0lByi9Z+EkATMKPsaj7PBJTO60zwp4gbcF6F52Oz9zHKmdg45mNyhvBlnxHV5oTwU5xH
	M11FbbbaRjfz+1GbhddRJk8ZMghbBs88=
X-Gm-Gg: AeBDieurFOsBL1Y333KmTypJGPLtBsDPYY10k0i25UP3uTs1JCTK7m8BzAYvnJMjv2K
	nnxI7gSqT5haeqQA+X4usBXNkcg29YMnl+ZNsP5hjGMcNI18CGmQb6aXKSdxQcu6r9U+QA1GLsF
	Yp1nYLrpYAaPw6j+Ul3DSIwCaaTMZBHbeLoQEVY1BlcEN7I/NJLgltIGJRJYVsUvTL1ezat6ix9
	0xkRI8APSnUj9EMSf9UR9TWwdBnDJVq/zT3PwJt9vWl3zsx5CG4bHXHtwZUahX4HljVR8WCSYZF
	8jIBLAm+M4VvhVtXX+en
X-Received: by 2002:a05:690c:6d81:b0:7b3:8a18:ba7a with SMTP id
 00721157ae682-7bda8b09086mr6183187b3.17.1777919310940; Mon, 04 May 2026
 11:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502032455.76107-1-m32285159@gmail.com> <afhafBqBV79d9FBv@ashevche-desk.local>
In-Reply-To: <afhafBqBV79d9FBv@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 4 May 2026 13:28:19 -0500
X-Gm-Features: AVHnY4JBkR4-XIGUnbzWBUUKh2_i4_59QAQ5MyfEMwY4__AWYP02RES7uYxENSw
Message-ID: <CAKqfh0Gb3cidUWe91004wvzB9VoySPom6YUqrWFZ=r43FCS-CA@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: kmx61: Use guard(mutex)() family over manual locking
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Mon, May 4, 2026 at 3:36=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, May 01, 2026 at 10:24:54PM -0500, Maxwell Doose wrote:
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
> ...
>
> >               *val =3D sign_extend32(ret >> chan->scan_type.shift,
> >                                    chan->scan_type.realbits - 1);
> >               ret =3D kmx61_set_power_state(data, false, chan->address)=
;
>
> >
>
> Now this blank line becomes a bit confusing as the following conditional =
is
> tightly coupled with the above code, remove it.
>

Will do, sounds good.

>
> > -             mutex_unlock(&data->lock);
> >               if (ret)
> >                       return ret;
> >               return IIO_VAL_INT;
>
> ...
>
> > -     mutex_lock(&data->lock);
> > +     guard(mutex)(&data->lock);
> >       iio_for_each_active_channel(indio_dev, bit) {
> >               ret =3D kmx61_read_measurement(data, base, bit);
> >               if (ret < 0) {
> > -                     mutex_unlock(&data->lock);
> > -                     goto err;
> > +                     iio_trigger_notify_done(indio_dev->trig);
> > +                     return IRQ_HANDLED;
>
> Hmm... Is the HANDLED a right choice?
>

This is what was done at the former err goto label, so I thought it
was appropriate when we removed it to move it here.

>
>
> >               }
> >               buffer[i++] =3D ret;
> >       }
> > -     mutex_unlock(&data->lock);
> >
> >       iio_push_to_buffers(indio_dev, buffer);
> > -err:
> >       iio_trigger_notify_done(indio_dev->trig);
> >
> >       return IRQ_HANDLED;
>
> If the answer is yes, I'm wondering if we may deduplicate that...
>

Best way I can think of deduplication is:
A. __attribute__((cleanup())) function helper (overkill)
B. macro (bad idea)
C. refactor logic so that it will just fall through to the end

If we do go with option C then we should probably just wait until this
is merged and then send that patch...

>
> ...
>
> >  static int kmx61_suspend(struct device *dev)
> >  {
> > -     int ret;
> >       struct kmx61_data *data =3D i2c_get_clientdata(to_i2c_client(dev)=
);
> >
> > -     mutex_lock(&data->lock);
> > -     ret =3D kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MA=
G,
> > +     guard(mutex)(&data->lock);
>
> > +     return kmx61_set_mode(data, KMX61_ALL_STBY, KMX61_ACC | KMX61_MAG=
,
> >                            false);
>
> One line is okay in this case.
>

Also sounds good.

best regards,
max

>
>
> > -     mutex_unlock(&data->lock);
> > -
> > -     return ret;
> >  }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
