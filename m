Return-Path: <omaplinuxkernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1375813453-2290-1-git-send-email-ktsai@capellamicro.com>
References: <1375813453-2290-1-git-send-email-ktsai@capellamicro.com>
Date: Wed, 7 Aug 2013 12:01:35 +0530
Message-ID: <CAM=Q2cto2Wp2e74ttVNeQ1nnJYAJ5A6=nZYuAT7_aaqS7xm3+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] Added Capella CM3218 Ambient Light Sensor IIO driver.
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Kevin Tsai <ktsai@capellamicro.com>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>, Peter Meerwald <pmeerw@pmeerw.net>,
	Alexander Holler <holler@ahsoftware.de>, srinivas pandruvada <srinivas.pandruvada@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a11c3ed3474759104e355b139
List-ID: <linux-iio@vger.kernel.org>

--001a11c3ed3474759104e355b139
Content-Type: text/plain; charset=ISO-8859-1

<snip>

> +       chip->suspended = true;
> +
> +       mutex_unlock(&chip->lock);
> +       return 0;
> +}
> +
> +static int cm3218_resume(struct device *dev)
> +{
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct cm3218_chip *chip = iio_priv(indio_dev);
> +       struct i2c_client *client = chip->client;
> +       int err;
> +
> +       mutex_lock(&chip->lock);
> +
> +       err = cm3218_chip_init(client);
>
We do a reinit every time is there a way to know if the context was lost?


> +       if (!err)
> +               chip->suspended = false;
> +
> +       mutex_unlock(&chip->lock);
> +       return err;
> +}
> +
>
> --
> 1.8.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--001a11c3ed3474759104e355b139
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
&lt;snip&gt;<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail=
_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:=
1ex">
+ =A0 =A0 =A0 chip-&gt;suspended =3D true;<br>
+<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;chip-&gt;lock);<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static int cm3218_resume(struct device *dev)<br>
+{<br>
+ =A0 =A0 =A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);<br>
+ =A0 =A0 =A0 struct cm3218_chip *chip =3D iio_priv(indio_dev);<br>
+ =A0 =A0 =A0 struct i2c_client *client =3D chip-&gt;client;<br>
+ =A0 =A0 =A0 int err;<br>
+<br>
+ =A0 =A0 =A0 mutex_lock(&amp;chip-&gt;lock);<br>
+<br>
+ =A0 =A0 =A0 err =3D cm3218_chip_init(client);<br>
</blockquote><div>We do a reinit every time is there a way to know if the c=
ontext was lost?<br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">+ =A0 =A0 =
=A0 if (!err)<br>

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip-&gt;suspended =3D false;<br>
+<br>
+ =A0 =A0 =A0 mutex_unlock(&amp;chip-&gt;lock);<br>
+ =A0 =A0 =A0 return err;<br>
+}<br>
+<br><br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.8.3.1<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-iio&qu=
ot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at =A0<a href=3D"http://vger.kernel.org/majordomo-info.=
html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><br>
</font></span></blockquote></div><br></div></div>

--001a11c3ed3474759104e355b139--
