Return-Path: <viorel.suman@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1422537352-1374-1-git-send-email-irina.tirdea@intel.com>
References: <1422537352-1374-1-git-send-email-irina.tirdea@intel.com>
Date: Fri, 30 Jan 2015 06:03:38 +0200
Message-ID: <CAAH5R_OYTbY3AW-pA3-p4+Gzo3MdGYX0a52UtJTbt=F8HSOj0A@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: bmg160: optimize i2c transfers in trigger handler
From: Viorel Suman <viorel.suman@gmail.com>
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Content-Type: multipart/alternative; boundary=047d7bf0e73c80a9aa050dd6b0f1
List-ID: <linux-iio@vger.kernel.org>

--047d7bf0e73c80a9aa050dd6b0f1
Content-Type: text/plain; charset=UTF-8

Hi,

You might need more space in "values" buffer, for more details please check
the
"iio_push_to_buffers_with_timestamp" description and implementation.

Regards,
Viorel


On Thu, Jan 29, 2015 at 3:15 PM, Irina Tirdea <irina.tirdea@intel.com>
wrote:

> Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
> enable/disable the bus at each i2c transfer and must wait for
> the enable/disable to happen before sending the data.
>
> When reading data in the trigger handler, the bmg160 driver does
> one i2c transfer for each axis. This has an impact on the frequency
> of the gyroscope at high sample rates due to additional delays
> introduced by the i2c bus at each transfer.
>
> Reading all axis values in one i2c transfer reduces the delays
> introduced by the i2c bus.
>
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/iio/gyro/bmg160.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
> index 60451b3..814eb20 100644
> --- a/drivers/iio/gyro/bmg160.c
> +++ b/drivers/iio/gyro/bmg160.c
> @@ -115,6 +115,7 @@ enum bmg160_axis {
>         AXIS_X,
>         AXIS_Y,
>         AXIS_Z,
> +       AXIS_MAX,
>  };
>
>  static const struct {
> @@ -820,20 +821,21 @@ static irqreturn_t bmg160_trigger_handler(int irq,
> void *p)
>         struct iio_dev *indio_dev = pf->indio_dev;
>         struct bmg160_data *data = iio_priv(indio_dev);
>         int bit, ret, i = 0;
> +       s16 values[AXIS_MAX];
>
>         mutex_lock(&data->mutex);
> -       for_each_set_bit(bit, indio_dev->buffer->scan_mask,
> -                        indio_dev->masklength) {
> -               ret = i2c_smbus_read_word_data(data->client,
> -                                              BMG160_AXIS_TO_REG(bit));
> -               if (ret < 0) {
> -                       mutex_unlock(&data->mutex);
> -                       goto err;
> -               }
> -               data->buffer[i++] = ret;
> +       ret = i2c_smbus_read_i2c_block_data(data->client,
> BMG160_REG_XOUT_L,
> +                                           sizeof(values), (u8 *) values);
> +       if (ret < 0) {
> +               mutex_unlock(&data->mutex);
> +               goto err;
>         }
>         mutex_unlock(&data->mutex);
>
> +       for_each_set_bit(bit, indio_dev->buffer->scan_mask,
> +                        indio_dev->masklength)
> +               data->buffer[i++] = values[bit];
> +
>         iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
>                                            data->timestamp);
>  err:
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--047d7bf0e73c80a9aa050dd6b0f1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>You might need more space in &q=
uot;values&quot; buffer, for more details please check the<br> &quot;iio_pu=
sh_to_buffers_with_timestamp&quot; description and implementation.<br><br><=
/div>Regards,<br>Viorel<br><br></div><div class=3D"gmail_extra"><br><div cl=
ass=3D"gmail_quote">On Thu, Jan 29, 2015 at 3:15 PM, Irina Tirdea <span dir=
=3D"ltr">&lt;<a href=3D"mailto:irina.tirdea@intel.com" target=3D"_blank">ir=
ina.tirdea@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to<br>
enable/disable the bus at each i2c transfer and must wait for<br>
the enable/disable to happen before sending the data.<br>
<br>
When reading data in the trigger handler, the bmg160 driver does<br>
one i2c transfer for each axis. This has an impact on the frequency<br>
of the gyroscope at high sample rates due to additional delays<br>
introduced by the i2c bus at each transfer.<br>
<br>
Reading all axis values in one i2c transfer reduces the delays<br>
introduced by the i2c bus.<br>
<br>
Signed-off-by: Irina Tirdea &lt;<a href=3D"mailto:irina.tirdea@intel.com">i=
rina.tirdea@intel.com</a>&gt;<br>
Reviewed-by: Srinivas Pandruvada &lt;<a href=3D"mailto:srinivas.pandruvada@=
linux.intel.com">srinivas.pandruvada@linux.intel.com</a>&gt;<br>
---<br>
=C2=A0drivers/iio/gyro/bmg160.c | 20 +++++++++++---------<br>
=C2=A01 file changed, 11 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c<br>
index 60451b3..814eb20 100644<br>
--- a/drivers/iio/gyro/bmg160.c<br>
+++ b/drivers/iio/gyro/bmg160.c<br>
@@ -115,6 +115,7 @@ enum bmg160_axis {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 AXIS_X,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 AXIS_Y,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 AXIS_Z,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0AXIS_MAX,<br>
=C2=A0};<br>
<br>
=C2=A0static const struct {<br>
@@ -820,20 +821,21 @@ static irqreturn_t bmg160_trigger_handler(int irq, vo=
id *p)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D pf-&gt;indio_dev;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct bmg160_data *data =3D iio_priv(indio_dev=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int bit, ret, i =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0s16 values[AXIS_MAX];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;data-&gt;mutex);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_set_bit(bit, indio_dev-&gt;buffer-&gt;=
scan_mask,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 indio_dev-&gt;masklength) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D i2c_smbus_r=
ead_word_data(data-&gt;client,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 BMG160_AXIS_TO_REG(bit));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0mutex_unlock(&amp;data-&gt;mutex);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto err;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;buffer[i++=
] =3D ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D i2c_smbus_read_i2c_block_data(data-&gt;=
client, BMG160_REG_XOUT_L,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0sizeof(values), (u8 *) values);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;d=
ata-&gt;mutex);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&amp;data-&gt;mutex);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_set_bit(bit, indio_dev-&gt;buffer-&gt;=
scan_mask,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 indio_dev-&gt;masklength)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data-&gt;buffer[i++=
] =3D values[bit];<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_push_to_buffers_with_timestamp(indio_dev, d=
ata-&gt;buffer,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0data-&gt;timestamp);<br>
=C2=A0err:<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-iio&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
</font></span></blockquote></div><br></div>

--047d7bf0e73c80a9aa050dd6b0f1--
