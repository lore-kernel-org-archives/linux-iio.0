Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397B71E8320
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 12:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779885694; cv=pass; b=AlS/7Ljqin8HSVezgt+PeCPM/tad+yp6ZpSOrKf4/TBP4s2pN6nujmLiqOpnFXjTN2U3JxfwC3pJNvIkK41EpKbJ1LEPcbGrDyxLak6O/dr4JNTpj5CZf2yR5w/WGfuQORusTRqwi/jVtZcYUzK4ZbtFU98QJRq67MO73JkJpDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779885694; c=relaxed/simple;
	bh=M72oM2ZDp6DuH4KclZ9yUoy0ikJ69OVhdRmub6QcovI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpITgBQgH5az5kdYHh6x1P4wYdvtUMGK+p1veYn+wi7S12QgoQB5SwRVX9DtpKqMPW4bN4rj2KXjGTpZZg9QbVdNmOM959JcucUXktcRw70oEwJLjYeGaV7E7QEuJhPNT9sGJQC8ZXC6JH94w3yyQZ63Ll63E9vqwZt+FgP4vLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ds5hfhoh; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds5hfhoh"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-660323f7b27so240913d50.3
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 05:41:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779885692; cv=none;
        d=google.com; s=arc-20240605;
        b=hZniis6C1KCouxQjIEnFX9n861s0u7AMT5u4XX0oqZ8vVEiAPDFJnPxDBFP+QpXMA5
         S93XQscLJGfl9YPpIyO054lfBAuClJ8VPjUqlcftSLO/drp2fLVuna+Lg7dKbsJbeCwH
         iD7CLQwYstKXsEV5jfDb16gli2D8cdHEI9oBJbeXU9neb2KQQW2ZRwjmohqheCuI0rqm
         sowfCgTGHpHxd7rdGkGyZNmfapvV7elZytjBZGTvbCPG1CAvcrd7HNsv3jhR4PC6Yj/f
         /PKxmxF9AoDNzjamn1tx8Xx4JJSdAl4NFvOZoCWY5vNOAU7OdafTcqSpuF7ls/5+9qBc
         il6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZRp6/qeJqHVRGXUiDpRbIwAz1boK36R0cED1c44k9/Y=;
        fh=unxk7Z9PFI1wGWqv5X49EjoYhoo1gOp+gy46jKZrT48=;
        b=iPozR8A955iDMw8B0OD/6pK+gJ44bSBzwySzhNrz72nY7uug9CfiSYleKjMvgrmehS
         PFbVi4noFWvBaOkvPjpw98c9muvQE+oxynilF/7L4rdh+nXmOldirhYMmkzkzyW3U/OO
         I5ArH/LUXCHfmSPyLrhQFfgV3GKlNpFNJtKH0NRI49CKpzcRjmz2fX9jsJtrrHYN5iNh
         ZCMqzxXKu1jJWh+J8hdbnuMCuGNoxS35ocGPI1NCHpUm9giGGvBfvWTuHAX4roHqSsEi
         bd9bQpSotInV+ZWeuj1j37XeToOfcYjMNmwPGR62yQPJxVcc7vsIFpj6xEksTSwR3aY3
         dtFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779885692; x=1780490492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRp6/qeJqHVRGXUiDpRbIwAz1boK36R0cED1c44k9/Y=;
        b=Ds5hfhohIsTW3kNmmIhcQKJy7RhKfy+4bdzcYYVxQmLvwRcDJ83jPwNdx/HzhFrik4
         apdC0ud72x+kbTrc0Wf3I6nk3HUnbJl9esY+OMcN/WABRbDTMLg286vyiOQuUlN6KiQc
         ewUvAXpp8gUOqac6FGm3VJtacSPvFqEBV5e7bN57Qa5D1AQEaOI2lcKdwzayM5Mnct//
         5rI20ezxXyBqKVzV1y+Q3ja+XdA0uUFCBs5sja9y+Co//0z0sSPbK7Mxhjx6fz1/BGrQ
         jBDK3STWw7mdDze5Exqx+OfBbQjIR0N4KS7/rNXn2JI4fKhOuTrgx6RFNsKDx+TjMWte
         JxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779885692; x=1780490492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRp6/qeJqHVRGXUiDpRbIwAz1boK36R0cED1c44k9/Y=;
        b=Sw0HEMuQecfsN1+uxGDmI/KsAnQmsiJ5ck3I4fiZCvZYJE+DdzC1vCghnsflj1/e2k
         zPw7lZkCa4MtXBL+RcU5EbbEgbkLtNZGQbrFIaN4ctU8eODI9VoGi/eFAxV+9AWSK8TS
         pdwWOTgwj/fRBqtavK0emNh9F39w41Wqn0um2MguTvvsy009FGhQ0XE/yvKQ7erfHfOM
         XbU7K9XEf1FuntlY4m3yzrT79exNT1COYL3CyGE3JHhOLLDdk2OKa/m3m8ovkHIEq/N5
         /x3XVaFS4LsKnlVSh5cMkZec0DJScY7ICZfmosS9yjwXJqGnFrYriq+2iP2zy+tmIcpK
         oHfQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DoIXBytVHRZf7X57udzqOwpIAZFomY/A62PAf7KJrfknAGD7lGhZx5CfTfm7qlGGXhYo7pms8F/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMXnLieFjVqmlU8LmQco8ApbIJvFAwII84nGy+o/Fy3peV3OKt
	mp3Nm2hBTT9dGsT1uTnNOzFkjjmGE8m4bn2tqcgrQlDSUhU6Xll7Mv/zSoOTLUZZijIzl5NHmLQ
	lmVf/uy+gJNk6RwlkV/7jXibJgAu9+vs=
X-Gm-Gg: Acq92OFkmORVuDdDNH42gu5XQtJX/OCrbwkqogtT5BjABcsGVoMNuXjDvXFFBnHfQIQ
	bXTUcXBzwncUid2lkTD6wVdOMLoDBfV0pkMicgoA0PgL9LoGbyKdNwRxaI2zQaZBFA6eUQUPcsr
	a6n3KzMYtvF+HDzIT4Ml58JV+nVq1mBraTS8Q4/9fdKCnv7hqB2GZKs/vFjkSAmkJzgiZ4xM65C
	W1yObn/AaFIUUNBhFzUh9P+eF6p84iW6GmU4a4Y4YVVPyjZbvKsBBIWiuzu1iSpopyK13HXhLE7
	2yhZ
X-Received: by 2002:a05:690e:2501:10b0:65d:8f98:6bb4 with SMTP id
 956f58d0204a3-65ec9805888mr17369857d50.29.1779885692091; Wed, 27 May 2026
 05:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523182531.10146-2-m32285159@gmail.com> <20260526154709.7dfa5f0c@jic23-huawei>
 <CAKqfh0ErDrDi++OZiQhJVLujtwKV3vN-zmNZzhz7EfF8wAc-WQ@mail.gmail.com> <20260527112924.465bc273@jic23-huawei>
In-Reply-To: <20260527112924.465bc273@jic23-huawei>
From: Maxwell Doose <m32285159@gmail.com>
Date: Wed, 27 May 2026 07:41:21 -0500
X-Gm-Features: AVHnY4KK4_Rwu6-LuD7XviOHoXa0uEB3xN7y0O0NjCBHGSEclN6xwqGKZZXQ9dU
Message-ID: <CAKqfh0Frh-Lk4x5==Hp9jzLVjjOwY1a7yJUfDFYrp03Y8Dz0qA@mail.gmail.com>
Subject: Re: [PATCH v4] iio: chemical: scd30: Replace manual locking with RAII locking
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 5:29=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 26 May 2026 15:31:10 -0500
> Maxwell Doose <m32285159@gmail.com> wrote:
>
> > On Tue, May 26, 2026 at 9:47=E2=80=AFAM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > >
> > > On Sat, 23 May 2026 13:25:32 -0500
> > > Maxwell Doose <m32285159@gmail.com> wrote:
> > >
> > > > scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> > > > calls. Replace them with the newer guard(mutex)() for cleaner RAII
> > > > patterns and to improve maintainability.
> > > >
> > > > Add new helper function scd30_trigger_handler_helper_locked() conta=
ining
> > > > the critical section for scd30_trigger_handler(). After moving
> > > > scd30_trigger_handler()'s critical section into the new helper, tun=
e up
> > > > control logic to return ret early and not memcpy() if it's an error
> > > > condition.
> > > >
> > > > In addition, small refactor to replace "?:" operator with regular
> > > > if/else returns.
> > > >
> > > > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > > Just some naming things inline.
> > >
> > > I thought about just changing them and applying but decided
> > > I'd rather you took another look to make sure you agree
> > > with the suggested changes (and if you do send me a v5)
> > >
> > > Thanks,
> > >
> > > Jonathan
> > >
> > > >  static ssize_t calibration_forced_value_store(struct device *dev, =
struct device_attribute *attr,
> > > > @@ -424,11 +430,13 @@ static ssize_t calibration_forced_value_store=
(struct device *dev, struct device_
> > > >       if (val < SCD30_FRC_MIN_PPM || val > SCD30_FRC_MAX_PPM)
> > > >               return -EINVAL;
> > > >
> > > > -     mutex_lock(&state->lock);
> > > > -     ret =3D scd30_command_write(state, CMD_FRC, val);
> > > > -     mutex_unlock(&state->lock);
> > > > +     guard(mutex)(&state->lock);
> > > >
> > > > -     return ret ?: len;
> > > > +     ret =3D scd30_command_write(state, CMD_FRC, val);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     return len;
> > > >  }
> > > >
> > > >  static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
> > > > @@ -579,24 +587,36 @@ static irqreturn_t scd30_irq_thread_handler(i=
nt irq, void *priv)
> > > >       return IRQ_HANDLED;
> > > >  }
> > > >
> > > > +/* Meant ONLY for scd30_trigger_handler() */
> > >
> > > No need to say this in a comment. The code naming is clear enough. Ho=
wever...
> > >
> >
> > Agree here with the removal of said comment.
> >
> > > > +static int scd30_trigger_handler_helper_locked(struct iio_dev *ind=
io_dev,
> > > > +                                            int *scan_data, int ar=
r_size)
> > >
> > > Avoid using _locked() in naming.  It isn't clear to readers if that
> > > means it is locked already, or will lock..  Also somewhat unnecessary
> > > here. We don't need the function name to say why there is a helper.
> > >
> >
> > Ah...I'm honestly not sure. I know we've decided that _locked was
> > appropriate in certain cases, I wonder if that may also be the case
> > here. I guess though since I'd have to send a v5 anyways I'll change
> > that.
> >
> > >
> > > arr_size would normally mean array size - i.e. how many ints
> > > there are in scan_data.  Here it is the size of scan_data - probably
> > > also make it a size_t
> > >
> >
> > Hm, perhaps? I definitely agree with size_t, I'm not so sure on
> > changing the name. However like I said since I'd likely have to send a
> > v5 anyways I'll switch up the naming.
>
> Given people will associate arr_size with ARRAY_SIZE() which on this arra=
y
> would return the number of ints (so /4), that name definitely needs to ch=
ange.
> Exactly what it changes to is a different question!
>

I wonder, perhaps either size (not as good) or arr_size_bytes? Maybe
also scan_data_byte_size? Probably still something better out there,
those are just some names I can come up with off the top of my head.

best regards,
max



> >
> > >
> > > So this whole thing becomes
> > >
> > > static int scd30_trigger_handler_helper(struct iio_dev *indio_dev,
> > >                                         int *scan_data, size_t scan_d=
ata_size)
> > >
> > >
> >
> > Sounds good.
> >
> > best regards,
> > max
>
