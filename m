Return-Path: <bfreed@google.com>
MIME-Version: 1.0
Sender: bfreed@google.com
In-Reply-To: <1330967759-18660-1-git-send-email-grundler@chromium.org>
References: <1330967759-18660-1-git-send-email-grundler@chromium.org>
Date: Mon, 5 Mar 2012 13:53:47 -0800
Message-ID: <CAEYUcX0ofOgv+G2aUaqcpEZhJU7UmBpxTZ0ye1FkcWdkHLR0MA@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:tsl2563 rewrite probe error handling
From: Bryan Freed <bfreed@chromium.org>
To: Grant Grundler <grundler@chromium.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Benson Leung <bleung@chromium.org>, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary=bcaec553fefa0912a404ba85f696
List-ID: <linux-iio@vger.kernel.org>

--bcaec553fefa0912a404ba85f696
Content-Type: text/plain; charset=ISO-8859-1

Looks good to me, too, but couldn't we get rid of one fail state (fail3) by
reversing the order of schedule_delayed_work() and iio_device_register()?

Reviewed-by: Bryan Freed <bfreed@chromium.org>

bryan.

On Mon, Mar 5, 2012 at 9:15 AM, Grant Grundler <grundler@chromium.org>wrote:

> tsl2563 probe function has two minor issues with it's error handling paths:
> 1) it is silent (did not report errors to dmesg)
> 2) did not return failure code (mixed up use of ret and err)
>
> and two major issues:
> 3) goto fail2 would corrupt a free memory pool ("double free")
> 4) device registration failure did NOT cancel/flush delayed work.
>   (and thus dereference a freed data structure later)
>
> The "double free" is subtle and was introduced with this change:
>    Author: Jonathan Cameron <jic23@cam.ac.uk>
>    Date:   Mon Apr 18 12:58:55 2011 +0100
>    staging:iio:tsl2563 take advantage of new iio_device_allocate private
> data.
>
> Originally, chip was allocated seperately. Now it's appended to the
> indio_dev by iio_allocate_device(sizeof(*chip)). So we only need one
> kfree call as well (in iio_free_device()).
>
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> ---
>  Gory details of tracking this down are here:
>    http://crosbug.com/26819
>
>  Despite iio_device_registration failing, system can at least now boot.
>  Will follow up with a fix to "double register : in_intensity_both_raw"
>  error that is included in the bug report.
>
>  drivers/staging/iio/light/tsl2563.c |   39
> +++++++++++++++++++++++-----------
>  1 files changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/staging/iio/light/tsl2563.c
> b/drivers/staging/iio/light/tsl2563.c
> index 7e984bc..bf6498b 100644
> --- a/drivers/staging/iio/light/tsl2563.c
> +++ b/drivers/staging/iio/light/tsl2563.c
> @@ -705,7 +705,6 @@ static int __devinit tsl2563_probe(struct i2c_client
> *client,
>        struct tsl2563_chip *chip;
>        struct tsl2563_platform_data *pdata = client->dev.platform_data;
>        int err = 0;
> -       int ret;
>        u8 id = 0;
>
>        indio_dev = iio_allocate_device(sizeof(*chip));
> @@ -719,13 +718,15 @@ static int __devinit tsl2563_probe(struct i2c_client
> *client,
>
>        err = tsl2563_detect(chip);
>        if (err) {
> -               dev_err(&client->dev, "device not found, error %d\n",
> -err);
> +               dev_err(&client->dev, "detect error %d\n", -err);
>                goto fail1;
>        }
>
>        err = tsl2563_read_id(chip, &id);
> -       if (err)
> +       if (err) {
> +               dev_err(&client->dev, "read id error %d\n", -err);
>                goto fail1;
> +       }
>
>        mutex_init(&chip->lock);
>
> @@ -748,40 +749,52 @@ static int __devinit tsl2563_probe(struct i2c_client
> *client,
>        indio_dev->num_channels = ARRAY_SIZE(tsl2563_channels);
>        indio_dev->dev.parent = &client->dev;
>        indio_dev->modes = INDIO_DIRECT_MODE;
> +
>        if (client->irq)
>                indio_dev->info = &tsl2563_info;
>        else
>                indio_dev->info = &tsl2563_info_no_irq;
> +
>        if (client->irq) {
> -               ret = request_threaded_irq(client->irq,
> +               err = request_threaded_irq(client->irq,
>                                           NULL,
>                                           &tsl2563_event_handler,
>                                           IRQF_TRIGGER_RISING |
> IRQF_ONESHOT,
>                                           "tsl2563_event",
>                                           indio_dev);
> -               if (ret)
> -                       goto fail2;
> +               if (err) {
> +                       dev_err(&client->dev, "irq request error %d\n",
> -err);
> +                       goto fail1;
> +               }
>        }
> +
>        err = tsl2563_configure(chip);
> -       if (err)
> -               goto fail3;
> +       if (err) {
> +               dev_err(&client->dev, "configure error %d\n", -err);
> +               goto fail2;
> +       }
>
>        INIT_DELAYED_WORK(&chip->poweroff_work, tsl2563_poweroff_work);
> +
>        /* The interrupt cannot yet be enabled so this is fine without lock
> */
>        schedule_delayed_work(&chip->poweroff_work, 5 * HZ);
>
> -       ret = iio_device_register(indio_dev);
> -       if (ret)
> +       err = iio_device_register(indio_dev);
> +       if (err) {
> +               dev_err(&client->dev, "iio registration error %d\n", -err);
>                goto fail3;
> +       }
>
>        return 0;
> +
>  fail3:
> +       cancel_delayed_work(&chip->poweroff_work);
> +       flush_scheduled_work();
> +fail2:
>        if (client->irq)
>                free_irq(client->irq, indio_dev);
> -fail2:
> -       iio_free_device(indio_dev);
>  fail1:
> -       kfree(chip);
> +       iio_free_device(indio_dev);
>        return err;
>  }
>
> --
> 1.7.3.4
>
>

--bcaec553fefa0912a404ba85f696
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Looks good to me, too, but couldn&#39;t we get rid of one fail state (fail3=
) by reversing the order of=A0schedule_delayed_work() and=A0iio_device_regi=
ster()?<div><br><div>Reviewed-by: Bryan Freed &lt;<a href=3D"mailto:bfreed@=
chromium.org">bfreed@chromium.org</a>&gt;</div>
<div><br></div><div>bryan.</div><div><br><div class=3D"gmail_quote">On Mon,=
 Mar 5, 2012 at 9:15 AM, Grant Grundler <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:grundler@chromium.org">grundler@chromium.org</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
tsl2563 probe function has two minor issues with it&#39;s error handling pa=
ths:<br>
1) it is silent (did not report errors to dmesg)<br>
2) did not return failure code (mixed up use of ret and err)<br>
<br>
and two major issues:<br>
3) goto fail2 would corrupt a free memory pool (&quot;double free&quot;)<br=
>
4) device registration failure did NOT cancel/flush delayed work.<br>
 =A0 (and thus dereference a freed data structure later)<br>
<br>
The &quot;double free&quot; is subtle and was introduced with this change:<=
br>
 =A0 =A0Author: Jonathan Cameron &lt;<a href=3D"mailto:jic23@cam.ac.uk">jic=
23@cam.ac.uk</a>&gt;<br>
 =A0 =A0Date: =A0 Mon Apr 18 12:58:55 2011 +0100<br>
 =A0 =A0staging:iio:tsl2563 take advantage of new iio_device_allocate priva=
te data.<br>
<br>
Originally, chip was allocated seperately. Now it&#39;s appended to the<br>
indio_dev by iio_allocate_device(sizeof(*chip)). So we only need one<br>
kfree call as well (in iio_free_device()).<br>
<br>
Signed-off-by: Grant Grundler &lt;<a href=3D"mailto:grundler@chromium.org">=
grundler@chromium.org</a>&gt;<br>
---<br>
=A0Gory details of tracking this down are here:<br>
 =A0 =A0<a href=3D"http://crosbug.com/26819" target=3D"_blank">http://crosb=
ug.com/26819</a><br>
<br>
=A0Despite iio_device_registration failing, system can at least now boot.<b=
r>
=A0Will follow up with a fix to &quot;double register : in_intensity_both_r=
aw&quot;<br>
=A0error that is included in the bug report.<br>
<br>
=A0drivers/staging/iio/light/tsl2563.c | =A0 39 +++++++++++++++++++++++----=
-------<br>
=A01 files changed, 26 insertions(+), 13 deletions(-)<br>
<br>
diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/ligh=
t/tsl2563.c<br>
index 7e984bc..bf6498b 100644<br>
--- a/drivers/staging/iio/light/tsl2563.c<br>
+++ b/drivers/staging/iio/light/tsl2563.c<br>
@@ -705,7 +705,6 @@ static int __devinit tsl2563_probe(struct i2c_client *c=
lient,<br>
 =A0 =A0 =A0 =A0struct tsl2563_chip *chip;<br>
 =A0 =A0 =A0 =A0struct tsl2563_platform_data *pdata =3D client-&gt;dev.plat=
form_data;<br>
 =A0 =A0 =A0 =A0int err =3D 0;<br>
- =A0 =A0 =A0 int ret;<br>
 =A0 =A0 =A0 =A0u8 id =3D 0;<br>
<br>
 =A0 =A0 =A0 =A0indio_dev =3D iio_allocate_device(sizeof(*chip));<br>
@@ -719,13 +718,15 @@ static int __devinit tsl2563_probe(struct i2c_client =
*client,<br>
<br>
 =A0 =A0 =A0 =A0err =3D tsl2563_detect(chip);<br>
 =A0 =A0 =A0 =A0if (err) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;client-&gt;dev, &quot;device not=
 found, error %d\n&quot;, -err);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;client-&gt;dev, &quot;detect err=
or %d\n&quot;, -err);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail1;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
 =A0 =A0 =A0 =A0err =3D tsl2563_read_id(chip, &amp;id);<br>
- =A0 =A0 =A0 if (err)<br>
+ =A0 =A0 =A0 if (err) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;client-&gt;dev, &quot;read id er=
ror %d\n&quot;, -err);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail1;<br>
+ =A0 =A0 =A0 }<br>
<br>
 =A0 =A0 =A0 =A0mutex_init(&amp;chip-&gt;lock);<br>
<br>
@@ -748,40 +749,52 @@ static int __devinit tsl2563_probe(struct i2c_client =
*client,<br>
 =A0 =A0 =A0 =A0indio_dev-&gt;num_channels =3D ARRAY_SIZE(tsl2563_channels)=
;<br>
 =A0 =A0 =A0 =A0indio_dev-&gt;dev.parent =3D &amp;client-&gt;dev;<br>
 =A0 =A0 =A0 =A0indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<br>
+<br>
 =A0 =A0 =A0 =A0if (client-&gt;irq)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0indio_dev-&gt;info =3D &amp;tsl2563_info;<b=
r>
 =A0 =A0 =A0 =A0else<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0indio_dev-&gt;info =3D &amp;tsl2563_info_no=
_irq;<br>
+<br>
 =A0 =A0 =A0 =A0if (client-&gt;irq) {<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_threaded_irq(client-&gt;irq,<=
br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D request_threaded_irq(client-&gt;irq,<=
br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 NULL,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 &amp;tsl2563_event_handler,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 IRQF_TRIGGER_RISING | IRQF_ONESHOT,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 &quot;tsl2563_event&quot;,<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 indio_dev);<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;client-&gt;dev, =
&quot;irq request error %d\n&quot;, -err);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail1;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
 =A0 =A0 =A0 =A0}<br>
+<br>
 =A0 =A0 =A0 =A0err =3D tsl2563_configure(chip);<br>
- =A0 =A0 =A0 if (err)<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;<br>
+ =A0 =A0 =A0 if (err) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;client-&gt;dev, &quot;configure =
error %d\n&quot;, -err);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail2;<br>
+ =A0 =A0 =A0 }<br>
<br>
 =A0 =A0 =A0 =A0INIT_DELAYED_WORK(&amp;chip-&gt;poweroff_work, tsl2563_powe=
roff_work);<br>
+<br>
 =A0 =A0 =A0 =A0/* The interrupt cannot yet be enabled so this is fine with=
out lock */<br>
 =A0 =A0 =A0 =A0schedule_delayed_work(&amp;chip-&gt;poweroff_work, 5 * HZ);=
<br>
<br>
- =A0 =A0 =A0 ret =3D iio_device_register(indio_dev);<br>
- =A0 =A0 =A0 if (ret)<br>
+ =A0 =A0 =A0 err =3D iio_device_register(indio_dev);<br>
+ =A0 =A0 =A0 if (err) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;client-&gt;dev, &quot;iio regist=
ration error %d\n&quot;, -err);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail3;<br>
+ =A0 =A0 =A0 }<br>
<br>
 =A0 =A0 =A0 =A0return 0;<br>
+<br>
=A0fail3:<br>
+ =A0 =A0 =A0 cancel_delayed_work(&amp;chip-&gt;poweroff_work);<br>
+ =A0 =A0 =A0 flush_scheduled_work();<br>
+fail2:<br>
 =A0 =A0 =A0 =A0if (client-&gt;irq)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(client-&gt;irq, indio_dev);<br>
-fail2:<br>
- =A0 =A0 =A0 iio_free_device(indio_dev);<br>
=A0fail1:<br>
- =A0 =A0 =A0 kfree(chip);<br>
+ =A0 =A0 =A0 iio_free_device(indio_dev);<br>
 =A0 =A0 =A0 =A0return err;<br>
=A0}<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.3.4<br>
<br>
</font></span></blockquote></div><br></div></div>

--bcaec553fefa0912a404ba85f696--
