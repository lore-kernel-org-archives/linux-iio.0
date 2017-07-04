Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34364 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbdGDKkf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jul 2017 06:40:35 -0400
MIME-Version: 1.0
In-Reply-To: <1494751435-14189-1-git-send-email-der.herr@hofr.at>
References: <1494751435-14189-1-git-send-email-der.herr@hofr.at>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Jul 2017 12:40:33 +0200
Message-ID: <CAMuHMdXdcY1fsZsdgUe7=gNUaKannGe==4BvQTwren898QXPfw@mail.gmail.com>
Subject: Re: [PATCH RFC] iio: pressure: zpa2326: report interrupted case as failure
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        simran singhal <singhalsimran0@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Nicholas,

On Sun, May 14, 2017 at 10:43 AM, Nicholas Mc Guire <der.herr@hofr.at> wrot=
e:
> If the timeout-case prints a warning message then probably the interrupte=
d
> case should also. Further, wait_for_completion_interruptible_timeout()
> returns long not int.
>
> Fixes: commit 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer supp=
ort")
> Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
> ---
>
> The original control-flow was technically not wrong just confusing and a =
bit
> complicated. Not clear if reporting the interrupted case actually is usef=
ul,
> but given that the timeout is relatively long (200ms) it is not that unli=
kely
> so differentiating the cases seems helpful.
>
> Patch was compile-tested with: x86_64_defconfig + CONFIG_IIO=3Dm, CONFIG_=
ZPA2326=3Dm
>
> Patch is against v4.11 (localversion-next is next-20170512)
>
>  drivers/iio/pressure/zpa2326.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa232=
6.c
> index e58a0ad..617926f 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -867,12 +867,13 @@ static int zpa2326_wait_oneshot_completion(const st=
ruct iio_dev   *indio_dev,
>  {
>         int          ret;
>         unsigned int val;
> +       long     timeout;
>
>         zpa2326_dbg(indio_dev, "waiting for one shot completion interrupt=
");
>
> -       ret =3D wait_for_completion_interruptible_timeout(
> +       timeout =3D wait_for_completion_interruptible_timeout(
>                 &private->data_ready, ZPA2326_CONVERSION_JIFFIES);
> -       if (ret > 0)
> +       if (timeout > 0)

Check for strict positive timeout.

>                 /*
>                  * Interrupt handler completed before timeout: return ope=
ration
>                  * status.
> @@ -882,13 +883,15 @@ static int zpa2326_wait_oneshot_completion(const st=
ruct iio_dev   *indio_dev,
>         /* Clear all interrupts just to be sure. */
>         regmap_read(private->regmap, ZPA2326_INT_SOURCE_REG, &val);
>
> -       if (!ret)
> +       if (!timeout) {

Check for zero timeout.

>                 /* Timed out. */
> +               zpa2326_warn(indio_dev, "no one shot interrupt occurred (=
%ld)",
> +                            timeout);
>                 ret =3D -ETIME;
> -
> -       if (ret !=3D -ERESTARTSYS)
> -               zpa2326_warn(indio_dev, "no one shot interrupt occurred (=
%d)",
> -                            ret);
> +       } else if (timeout < 0) {

So if we get here, timeout is always strict negative, so the check can
be removed.

> +               zpa2326_warn(indio_dev, "wait for one shot interrupt canc=
eled");
> +               ret =3D -ERESTARTSYS;
> +       }
>
>         return ret;

But gcc-4.1.2 is not smart enough:

drivers/iio/pressure/zpa2326.c:868: warning: =E2=80=98ret=E2=80=99 may be u=
sed
uninitialized in this function

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
