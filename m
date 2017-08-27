Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:38037 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdH0PBn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2017 11:01:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id f86so370411pfj.5
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2017 08:01:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170825053916.lbubxudnm3errnld@lenoch>
References: <20170824082708.6qkcmf6qt2wjvqd3@lenoch> <CAC5umyhkGSN5DYJM6Qp-05MASZLBNpcSna1pVGN4feR=_MH5fQ@mail.gmail.com>
 <20170825053916.lbubxudnm3errnld@lenoch>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Mon, 28 Aug 2017 00:01:22 +0900
Message-ID: <CAC5umyi-f2+xfv=apiMk8cfA0iqAovStj-GcB5=tFkDJKsVZbQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads1015: add 10% to conversion wait time
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2017-08-25 14:39 GMT+09:00 Ladislav Michl <ladis@linux-mips.org>:
> As user's guide "ADS1015EVM, ADS1115EVM, ADS1015EVM-PDK, ADS1115EVM-PDK
> User Guide (Rev. B)" (http://www.ti.com/lit/ug/sbau157b/sbau157b.pdf)
> states at page 16:
> "Note that both the ADS1115 and ADS1015 have internal clocks with a =C2=
=B110%
> accuracy. If performing FFT tests, frequencies may appear to be incorrect
> as a result of this tolerance range.", add those 10% to converion wait
> time.
>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>  Changes:
>  -v2: Add comment explaining why those 10% are needed
>
>  drivers/iio/adc/ti-ads1015.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 034e48566ab5..ae29dd87c597 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -268,6 +268,7 @@ int ads1015_get_adc_result(struct ads1015_data *data,=
 int chan, int *val)
>                 dr_old =3D (old & ADS1015_CFG_DR_MASK) >> ADS1015_CFG_DR_=
SHIFT;
>                 conv_time =3D DIV_ROUND_UP(USEC_PER_SEC, data->data_rate[=
dr_old]);
>                 conv_time +=3D DIV_ROUND_UP(USEC_PER_SEC, data->data_rate=
[dr]);
> +               conv_time +=3D conv_time / 10; /* 10% internal clock inac=
curacy */

Perhaps we'd better use DIV_ROUND_UP to avoid the worst case.

Anyway, this and patch 2/2 look good to me.

Reviewed-by: Akinobu Mita <akinobu.mita@gmail.com>

>                 usleep_range(conv_time, conv_time + 1);
>                 data->conv_invalid =3D false;
>         }
> --
> 2.11.0
>
