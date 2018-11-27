Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46170 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeK0SUi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Nov 2018 13:20:38 -0500
Received: by mail-vk1-f193.google.com with SMTP id j23so4810078vke.13
        for <linux-iio@vger.kernel.org>; Mon, 26 Nov 2018 23:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20181119061219.14238-1-jian-hong@endlessm.com>
 <04d0345d6c6c4ac0950ab0676ffd7689@SFHDAG2NODE1.st.com> <CAPpJ_ed-A_mkPJieZA4pHaRbY0SGpOEXP04aY4g1b60PzMGQuA@mail.gmail.com>
 <20181125132257.6ae9fe82@archlinux>
In-Reply-To: <20181125132257.6ae9fe82@archlinux>
From: Jian-Hong Pan <jian-hong@endlessm.com>
Date: Tue, 27 Nov 2018 15:23:04 +0800
Message-ID: <CAPpJ_eeqxzgwXwm1v3n2u2cEiVgBPN9y96+5x589-bO3+k+1jg@mail.gmail.com>
Subject: Re: [PATCH] iio: st_sensors: Fix the sleep time for sampling
To: Jonathan Cameron <jic23@kernel.org>
Cc: Denis Ciocca <denis.ciocca@st.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>, linux@endlessm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2018=E5=B9=B411=E6=9C=8825=E6=
=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=889:23=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, 21 Nov 2018 13:13:40 +0800
> Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>
> > Denis CIOCCA <denis.ciocca@st.com> =E6=96=BC 2018=E5=B9=B411=E6=9C=8820=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:05=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > >
> > > Hi Jian,
> > >
> > > Not clear to me why should be + instead of *.
> > >
> > > ODR is expressed in Hz, so (1/Hz) =3D period in seconds (1 sample sam=
pling time) [s]
> > > 1000 * (1/Hz) =3D period in milliseconds (1 sample sampling time) [ms=
]
> > > n * 1000 * (1/Hz) =3D n times period in milliseconds (n times sample =
sampling time) [ms]
> > >
> > > In your case you assume bootime is in milliseconds.
> >
> > Yes, I assume that according to the original comment.
> >
> > >Maybe we can change the comment and use 'number of samples ...'.
> >
> > Making the meaning more clear is better.
> >
> > However, does the bootime of the measurement need as the long time to
> > be enabled?
> > If the sampling rate is 1Hz and n is 2, then they will do msleep with
> > 2000 ms for each st_sensors_read_info_raw.
>
> Superficially that seems correct as we need to be sure that a reading
> has occurred.  If you want it to be quicker than the ODR should be set
> faster so that the reading shows up reasonably quickly. At 1Hz and
> you want to drop 2 samples, it will indeed take 2 seconds.

Now, I understand with the description.  Thank you.

Jian-Hong Pan

> > > -----Original Message-----
> > > From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.or=
g> On Behalf Of Jian-Hong Pan
> > > Sent: Sunday, November 18, 2018 10:12 PM
> > > To: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx=
.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@=
pmeerw.net>; Dominique Martinet <asmadeus@codewreck.org>
> > > Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; linux@en=
dlessm.com; Jian-Hong Pan <jian-hong@endlessm.com>
> > > Subject: [PATCH] iio: st_sensors: Fix the sleep time for sampling
> > >
> > > According to the description of st_sensor_settings and st_sensor_data=
 structures' comments:
> > > - bootime: samples to discard when sensor passing from power-down to =
power-up.
> > > - odr: Output data rate of the sensor [Hz].
> > >
> > > The sleep time should be
> > > sdata->sensor_settings->bootime + 1000 / sdata->odr ms.
> > >
> > > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > > ---
> > >  drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/driver=
s/iio/common/st_sensors/st_sensors_core.c
> > > index 26fbd1bd9413..6b87ea657a92 100644
> > > --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> > > +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> > > @@ -594,7 +594,7 @@ int st_sensors_read_info_raw(struct iio_dev *indi=
o_dev,
> > >                 if (err < 0)
> > >                         goto out;
> > >
> > > -               msleep((sdata->sensor_settings->bootime * 1000) / sda=
ta->odr);
> > > +               msleep(sdata->sensor_settings->bootime + 1000 / sdata=
->odr);
> > >                 err =3D st_sensors_read_axis_data(indio_dev, ch, val)=
;
> > >                 if (err < 0)
> > >                         goto out;
> > > --
> > > 2.11.0
> > >
>
