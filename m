Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1464619938-988956-1-git-send-email-arnd@arndb.de>
References: <1464619938-988956-1-git-send-email-arnd@arndb.de>
From: Matt Ranostay <mranostay@gmail.com>
Date: Mon, 30 May 2016 10:33:20 -0700
Message-ID: <CAKzfze-eQ3zgodfE9rV1vJEkNgV3xaiTz9SJ1hWb4PjxTHR9zQ@mail.gmail.com>
Subject: Re: [PATCH] iio: as3935: improve error reporting in as3935_event_work
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>, Javier Martinez Canillas <javier@osg.samsung.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Reviewed-by: Matt Ranostay <mranostay@gmail.com>

On Mon, May 30, 2016 at 7:52 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> gcc warns about a potentially uninitialized variable use
> in as3935_event_work:
>
> drivers/iio/proximity/as3935.c: In function =E2=80=98as3935_event_work=E2=
=80=99:
> drivers/iio/proximity/as3935.c:231:6: error: =E2=80=98val=E2=80=99 may be=
 used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>
> This case specifically happens when spi_w8r8() fails with a
> negative return code. We check all other users of this function
> except this one.
>
> As the error is rather unlikely to happen after the device
> has already been initialized, this just adds a dev_warn().
> Another warning already existst in the same function, but is
> missing a trailing '\n' character, so I'm fixing that too.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/iio/proximity/as3935.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as393=
5.c
> index f4d29d5dbd5f..b49e3ab5730a 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -224,10 +224,16 @@ static void as3935_event_work(struct work_struct *w=
ork)
>  {
>         struct as3935_state *st;
>         int val;
> +       int ret;
>
>         st =3D container_of(work, struct as3935_state, work.work);
>
> -       as3935_read(st, AS3935_INT, &val);
> +       ret =3D as3935_read(st, AS3935_INT, &val);
> +       if (ret) {
> +               dev_warn(&st->spi->dev, "read error\n");
> +               return;
> +       }
> +
>         val &=3D AS3935_INT_MASK;
>
>         switch (val) {
> @@ -235,7 +241,7 @@ static void as3935_event_work(struct work_struct *wor=
k)
>                 iio_trigger_poll(st->trig);
>                 break;
>         case AS3935_NOISE_INT:
> -               dev_warn(&st->spi->dev, "noise level is too high");
> +               dev_warn(&st->spi->dev, "noise level is too high\n");
>                 break;
>         }
>  }
> --
> 2.7.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
