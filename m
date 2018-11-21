Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33008 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeKUPrM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Nov 2018 10:47:12 -0500
Received: by mail-vs1-f65.google.com with SMTP id p74so2540901vsc.0
        for <linux-iio@vger.kernel.org>; Tue, 20 Nov 2018 21:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20181119061219.14238-1-jian-hong@endlessm.com> <04d0345d6c6c4ac0950ab0676ffd7689@SFHDAG2NODE1.st.com>
In-Reply-To: <04d0345d6c6c4ac0950ab0676ffd7689@SFHDAG2NODE1.st.com>
From: Jian-Hong Pan <jian-hong@endlessm.com>
Date: Wed, 21 Nov 2018 13:13:40 +0800
Message-ID: <CAPpJ_ed-A_mkPJieZA4pHaRbY0SGpOEXP04aY4g1b60PzMGQuA@mail.gmail.com>
Subject: Re: [PATCH] iio: st_sensors: Fix the sleep time for sampling
To: denis.ciocca@st.com
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>, linux@endlessm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Denis CIOCCA <denis.ciocca@st.com> =E6=96=BC 2018=E5=B9=B411=E6=9C=8820=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Jian,
>
> Not clear to me why should be + instead of *.
>
> ODR is expressed in Hz, so (1/Hz) =3D period in seconds (1 sample samplin=
g time) [s]
> 1000 * (1/Hz) =3D period in milliseconds (1 sample sampling time) [ms]
> n * 1000 * (1/Hz) =3D n times period in milliseconds (n times sample samp=
ling time) [ms]
>
> In your case you assume bootime is in milliseconds.

Yes, I assume that according to the original comment.

>Maybe we can change the comment and use 'number of samples ...'.

Making the meaning more clear is better.

However, does the bootime of the measurement need as the long time to
be enabled?
If the sampling rate is 1Hz and n is 2, then they will do msleep with
2000 ms for each st_sensors_read_info_raw.

Regards,
Jian-Hong Pan

>
>
> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> O=
n Behalf Of Jian-Hong Pan
> Sent: Sunday, November 18, 2018 10:12 PM
> To: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>=
; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmee=
rw.net>; Dominique Martinet <asmadeus@codewreck.org>
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; linux@endles=
sm.com; Jian-Hong Pan <jian-hong@endlessm.com>
> Subject: [PATCH] iio: st_sensors: Fix the sleep time for sampling
>
> According to the description of st_sensor_settings and st_sensor_data str=
uctures' comments:
> - bootime: samples to discard when sensor passing from power-down to powe=
r-up.
> - odr: Output data rate of the sensor [Hz].
>
> The sleep time should be
> sdata->sensor_settings->bootime + 1000 / sdata->odr ms.
>
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/ii=
o/common/st_sensors/st_sensors_core.c
> index 26fbd1bd9413..6b87ea657a92 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -594,7 +594,7 @@ int st_sensors_read_info_raw(struct iio_dev *indio_de=
v,
>                 if (err < 0)
>                         goto out;
>
> -               msleep((sdata->sensor_settings->bootime * 1000) / sdata->=
odr);
> +               msleep(sdata->sensor_settings->bootime + 1000 / sdata->od=
r);
>                 err =3D st_sensors_read_axis_data(indio_dev, ch, val);
>                 if (err < 0)
>                         goto out;
> --
> 2.11.0
>
