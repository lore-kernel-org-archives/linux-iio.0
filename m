Return-Path: <SRS0=AypB=JX=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAC5umyjerEZ6pWePwz-N13s+qbuDfXwUVACsu2akrBnnV1FNmQ@mail.gmail.com>
References: <1530376365-23946-1-git-send-email-akinobu.mita@gmail.com>
 <1530376365-23946-5-git-send-email-akinobu.mita@gmail.com>
 <CAHp75VfADqXh4DUqPT-9Cd2ER5Zk_mFRC3tUFNrk+aCRTL=1cg@mail.gmail.com> <CAC5umyjerEZ6pWePwz-N13s+qbuDfXwUVACsu2akrBnnV1FNmQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 7 Jul 2018 19:40:18 +0300
Message-ID: <CAHp75Vehy0niViBLL-93SYTzhVP_t6Ab0kv1KJejE=WRG4GwFA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] iio: accel: adxl345: add sampling frequency support
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio <linux-iio@vger.kernel.org>, Eva Rachel Retuya <eraretuya@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Jul 6, 2018 at 7:08 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote=
:
> 2018=E5=B9=B47=E6=9C=885=E6=97=A5(=E6=9C=A8) 7:06 Andy Shevchenko <andy.s=
hevchenko@gmail.com>:

> Sounds good.  I'll use clamp_val() instead of clamp_t().
>
>         n =3D clamp_val(ilog2(n), 0, ADXL345_BW_RATE);

Yup! But put it directly to the call instead of min_t(). No need to
assign n again (and it would mislead the n meanning).

--=20
With Best Regards,
Andy Shevchenko
