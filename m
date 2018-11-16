Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-it1-f178.google.com ([209.85.166.178]:40789 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeKQEp1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Nov 2018 23:45:27 -0500
Received: by mail-it1-f178.google.com with SMTP id e11so35591657itl.5
        for <linux-iio@vger.kernel.org>; Fri, 16 Nov 2018 10:31:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1541975146.git.lorenzo.bianconi@redhat.com>
 <e0b8bcec785b02cf14aab34a524878df6ed4cd7a.1541975146.git.lorenzo.bianconi@redhat.com>
 <20181116182123.422d9305@archlinux>
In-Reply-To: <20181116182123.422d9305@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date: Fri, 16 Nov 2018 19:31:47 +0100
Message-ID: <CAJ0CqmUf8O1xkb8O_Ka7ENLgNB0wAbLpYen0qquF-+bO1R6VTA@mail.gmail.com>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: do not use a fixed read len in read_oneshot
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> On Sun, 11 Nov 2018 23:28:28 +0100
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>

[...]

> > -     __le16 data;
> > +     int ret, delay, len = ch->scan_type.realbits >> 3;
> > +     u8 *data;
> >
> > -     err = st_lsm6dsx_shub_set_enable(sensor, true);
> > -     if (err < 0)
> > -             return err;
> > +     ret = st_lsm6dsx_shub_set_enable(sensor, true);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     data = kmalloc(len, GFP_KERNEL);
> > +     if (!data)
> > +             return -ENOMEM;
>
> Do we not want to disable should this fail?
> Easier might be to just do the allocation before the set_enable
> call.
>
> I'd also be tempted to just put a big enough buffer on the stack, or
> into the sensor structure.
>

ack, right. I will fix it in v2 using a u8 data[4] on the stack.
I guess it is reasonable, agree?

Regards,
Lorenzo

> Also, I haven't checked but is there potential for DMA into this
> buffer?
>
>
> >
> >       delay = 1000000 / sensor->odr;
> >       usleep_range(delay, 2 * delay);
> >
> > -     err = st_lsm6dsx_shub_read(sensor, ch->address, (u8 *)&data, len);
> > -     if (err < 0)
> > -             return err;
> > +     ret = st_lsm6dsx_shub_read(sensor, ch->address, data, len);
> > +     if (ret < 0)
> > +             goto out;
> >
> >       st_lsm6dsx_shub_set_enable(sensor, false);
> >
> >       switch (len) {
> >       case 2:
> > -             *val = (s16)le16_to_cpu(data);
> > +             *val = (s16)le16_to_cpu(*((__le16 *)data));
> > +             ret = IIO_VAL_INT;
> >               break;
> >       default:
> > -             return -EINVAL;
> > +             ret = -EINVAL;
> > +             break;
> >       }
> >
> > -     return IIO_VAL_INT;
> > +out:
> > +     kfree(data);
> > +     return ret;
> >  }
> >
> >  static int
>
