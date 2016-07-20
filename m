Return-Path: <pmeerw@pmeerw.net>
Date: Wed, 20 Jul 2016 10:18:54 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Enric Balletbo Serra <eballetbo@gmail.com>
cc: Jonathan Cameron <jic23@kernel.org>,
    Enric Balletbo i Serra <enric.balletbo@collabora.com>,
    linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>, Guenter Roeck <groeck@chromium.org>,
    Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH 04/10] iio: cros_ec: Add common functions for cros_ec
 sensors.
In-Reply-To: <CAFqH_529qL_NMSPQqBxD-nV5OYUxZw428CD33pk64gkG=vAgoQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1607201013140.18224@pmeerw.net>
References: <1468825370-20075-1-git-send-email-enric.balletbo@collabora.com> <1468825370-20075-5-git-send-email-enric.balletbo@collabora.com> <alpine.DEB.2.02.1607180908300.9730@pmeerw.net> <14477e63-8a78-b956-39bd-b71a808f6ab2@kernel.org>
 <CAFqH_529qL_NMSPQqBxD-nV5OYUxZw428CD33pk64gkG=vAgoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Thanks for the review, I'll add the changes in v2, some answers below ...

and my answers
 
> >>> +static ssize_t cros_ec_sensors_id(struct iio_dev *indio_dev,
> >>> +            uintptr_t private, const struct iio_chan_spec *chan,
> >>> +            char *buf)
> >>> +{
> >>> +    struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
> >>> +
> >>> +    return sprintf(buf, "%d\n", st->param.info.sensor_num);
> >>
> >> can't we be a bit more careful with buffer sizes here (and below)?
> >>
> 
> I'm not sure I get what you mean here.

snprintf(buf, PAGE_SIZE, ...
or maybe a more appropriate bound
 
p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
