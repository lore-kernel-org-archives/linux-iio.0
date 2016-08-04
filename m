Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1608040718070.16194@pmeerw.net>
References: <20160804033253.GA31586@d830.WORKGROUP> <CAKzfze9bEdoPTri=+MTK2LPXAJZxwXKP=T_jTKk4aO38ZyANzA@mail.gmail.com>
 <alpine.DEB.2.02.1608040718070.16194@pmeerw.net>
From: Matt Ranostay <mranostay@gmail.com>
Date: Wed, 3 Aug 2016 22:50:54 -0700
Message-ID: <CAKzfze8Ane_fR0-MamHFsVXfdORra9wt-qxrWf5yuRRKqQckkg@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: hdc100x: use i2c_master_recv to read
 sensor data
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Alison Schofield <amsfield22@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary=047d7ba97ba0e5cef20539388a69
List-ID: <linux-iio@vger.kernel.org>

--047d7ba97ba0e5cef20539388a69
Content-Type: text/plain; charset=UTF-8

On Wed, Aug 3, 2016 at 10:19 PM, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
wrote:

>
> > > Replace the i2c_smbus_read_byte commmands used to retrieve the sensor
> > > data with an i2c_master_recv command.
> > >
> > > The smbus read byte method fails because the device does not expect a
> > > stop condition after sending the first byte. When we issue the second
> > > read, we are getting the first byte again. Net effect is that of the 14
> > > bits used for the measurement, the 8 most significant bits are correct,
> > > the lower 6 are not.
> > >
> > > None of the smbus read protocols follow the pattern this device
> requires
> > > (S Addr Rd [A] Data [A] Data NA P), hence the switch to an i2c receive
> > > transaction.
> > >
> > > Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> > > Cc: Daniel Baluta <daniel.baluta@gmail.com>
> > > ---
> > >  drivers/iio/humidity/hdc100x.c | 27 +++++++--------------------
> > >  1 file changed, 7 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/drivers/iio/humidity/hdc100x.c
> b/drivers/iio/humidity/hdc100x.c
> > > index a03832a..643a42d 100644
> > > --- a/drivers/iio/humidity/hdc100x.c
> > > +++ b/drivers/iio/humidity/hdc100x.c
> > > @@ -142,7 +142,7 @@ static int hdc100x_get_measurement(struct
> hdc100x_data *data,
> > >         struct i2c_client *client = data->client;
> > >         int delay = data->adc_int_us[chan->address];
> > >         int ret;
> > > -       int val;
> > > +       u8 buf[2];
>
> __le16 val;
>
> > >
> > >         /* start measurement */
> > >         ret = i2c_smbus_write_byte(client, chan->address);
> > > @@ -154,26 +154,13 @@ static int hdc100x_get_measurement(struct
> hdc100x_data *data,
> > >         /* wait for integration time to pass */
> > >         usleep_range(delay, delay + 1000);
> > >
> > > -       /*
> > > -        * i2c_smbus_read_word_data cannot() be used here due to the
> command
> > > -        * value not being understood and causes NAKs preventing any
> reading
> > > -        * from being accessed.
> > > -        */
> > > -       ret = i2c_smbus_read_byte(client);
> > > +       /* read the 2 byte measurement */
> > > +       ret = i2c_master_recv(data->client, buf, 2);
> > >         if (ret < 0) {
> > > -               dev_err(&client->dev, "cannot read high byte
> measurement");
> > > +               dev_err(&client->dev, "cannot read sensor data\n");
> > >                 return ret;
> > >         }
> > > -       val = ret << 8;
> > > -
> > > -       ret = i2c_smbus_read_byte(client);
> > > -       if (ret < 0) {
> > > -               dev_err(&client->dev, "cannot read low byte
> measurement");
> > > -               return ret;
> > > -       }
> > > -       val |= ret;
> > > -
> > > -       return val;
> > > +       return (int)(buf[0] << 8 | buf[1]);
> >
> > Pretty sure you don't need to cast to int type here.
>
> return le16_to_cpu(val);
>
>
You mean le16_to_cpu(&buf)  I assume?


> >
> > >  }
> > >
> > >  static int hdc100x_get_heater_status(struct hdc100x_data *data)
> > > @@ -272,8 +259,8 @@ static int hdc100x_probe(struct i2c_client *client,
> > >         struct iio_dev *indio_dev;
> > >         struct hdc100x_data *data;
> > >
> > > -       if (!i2c_check_functionality(client->adapter,
> > > -                               I2C_FUNC_SMBUS_WORD_DATA |
> I2C_FUNC_SMBUS_BYTE))
> > > +       if (!i2c_check_functionality(client->adapter,
> I2C_FUNC_SMBUS_WORD_DATA |
> > > +                                    I2C_FUNC_SMBUS_BYTE |
> I2C_FUNC_I2C))
> >
> > Not sure we want to kill smbus support for this device...  iwe should
> > have two read methods for i2c and smbus (see the PulsedLight LIDAR
> > driver) in this case.
> >
> > Ideally I wouldn't have written it with only smbus in mind, but can
> > kill backwards compatibility unless we have a good reason.
> >
> > Thanks,
> >
> > Matt
> >
> > >                 return -EOPNOTSUPP;
> > >
> > >         indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> > > --
> > > 2.1.4
> > >
> >
>
> --
>
> Peter Meerwald-Stadler
> +43-664-2444418 (mobile)
>

--047d7ba97ba0e5cef20539388a69
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Aug 3, 2016 at 10:19 PM, Peter Meerwald-Stadler <span dir=3D"lt=
r">&lt;<a href=3D"mailto:pmeerw@pmeerw.net" target=3D"_blank">pmeerw@pmeerw=
.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"=
HOEnZb"><div class=3D"h5"><br>
&gt; &gt; Replace the i2c_smbus_read_byte commmands used to retrieve the se=
nsor<br>
&gt; &gt; data with an i2c_master_recv command.<br>
&gt; &gt;<br>
&gt; &gt; The smbus read byte method fails because the device does not expe=
ct a<br>
&gt; &gt; stop condition after sending the first byte. When we issue the se=
cond<br>
&gt; &gt; read, we are getting the first byte again. Net effect is that of =
the 14<br>
&gt; &gt; bits used for the measurement, the 8 most significant bits are co=
rrect,<br>
&gt; &gt; the lower 6 are not.<br>
&gt; &gt;<br>
&gt; &gt; None of the smbus read protocols follow the pattern this device r=
equires<br>
&gt; &gt; (S Addr Rd [A] Data [A] Data NA P), hence the switch to an i2c re=
ceive<br>
&gt; &gt; transaction.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Alison Schofield &lt;<a href=3D"mailto:amsfield22@=
gmail.com">amsfield22@gmail.com</a>&gt;<br>
&gt; &gt; Cc: Daniel Baluta &lt;<a href=3D"mailto:daniel.baluta@gmail.com">=
daniel.baluta@gmail.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 drivers/iio/humidity/hdc100x.c | 27 +++++++----------------=
----<br>
&gt; &gt;=C2=A0 1 file changed, 7 insertions(+), 20 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidit=
y/hdc100x.c<br>
&gt; &gt; index a03832a..643a42d 100644<br>
&gt; &gt; --- a/drivers/iio/humidity/hdc100x.c<br>
&gt; &gt; +++ b/drivers/iio/humidity/hdc100x.c<br>
&gt; &gt; @@ -142,7 +142,7 @@ static int hdc100x_get_measurement(struct hdc=
100x_data *data,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct i2c_client *client =3D da=
ta-&gt;client;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int delay =3D data-&gt;adc_int_u=
s[chan-&gt;address];<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0int val;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0u8 buf[2];<br>
<br>
</div></div>__le16 val;<br>
<div><div class=3D"h5"><br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* start measurement */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D i2c_smbus_write_byte(cli=
ent, chan-&gt;address);<br>
&gt; &gt; @@ -154,26 +154,13 @@ static int hdc100x_get_measurement(struct h=
dc100x_data *data,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* wait for integration time to =
pass */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usleep_range(delay, delay + 1000=
);<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * i2c_smbus_read_word_data cannot() =
be used here due to the command<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * value not being understood and cau=
ses NAKs preventing any reading<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 * from being accessed.<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D i2c_smbus_read_byte(client);<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* read the 2 byte measurement */<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D i2c_master_recv(data-&gt;clie=
nt, buf, 2);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&=
amp;client-&gt;dev, &quot;cannot read high byte measurement&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&=
amp;client-&gt;dev, &quot;cannot read sensor data\n&quot;);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn ret;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D ret &lt;&lt; 8;<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D i2c_smbus_read_byte(client);<=
br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&=
amp;client-&gt;dev, &quot;cannot read low byte measurement&quot;);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return re=
t;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0val |=3D ret;<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return val;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return (int)(buf[0] &lt;&lt; 8 | buf[=
1]);<br>
&gt;<br>
&gt; Pretty sure you don&#39;t need to cast to int type here.<br>
<br>
</div></div>return le16_to_cpu(val);<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br></div></div></blockquote><div><=
br></div><div>You mean le16_to_cpu(&amp;buf) =C2=A0I assume?</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D=
"h5">
&gt;<br>
&gt; &gt;=C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static int hdc100x_get_heater_status(struct hdc100x_data *d=
ata)<br>
&gt; &gt; @@ -272,8 +259,8 @@ static int hdc100x_probe(struct i2c_client *c=
lient,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_dev *indio_dev;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct hdc100x_data *data;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!i2c_check_functionality(client-&=
gt;adapter,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0I2C_FUNC_SMBUS_WORD_DATA | =
I2C_FUNC_SMBUS_BYTE))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!i2c_check_functionality(client-&=
gt;adapter, I2C_FUNC_SMBUS_WORD_DATA |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 I2C_FUNC_SMB=
US_BYTE | I2C_FUNC_I2C))<br>
&gt;<br>
&gt; Not sure we want to kill smbus support for this device...=C2=A0 iwe sh=
ould<br>
&gt; have two read methods for i2c and smbus (see the PulsedLight LIDAR<br>
&gt; driver) in this case.<br>
&gt;<br>
&gt; Ideally I wouldn&#39;t have written it with only smbus in mind, but ca=
n<br>
&gt; kill backwards compatibility unless we have a good reason.<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Matt<br>
&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0retu=
rn -EOPNOTSUPP;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev =3D devm_iio_device_al=
loc(&amp;client-&gt;dev, sizeof(*data));<br>
&gt; &gt; --<br>
&gt; &gt; 2.1.4<br>
&gt; &gt;<br>
&gt;<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
<br>
Peter Meerwald-Stadler<br>
<a href=3D"tel:%2B43-664-2444418" value=3D"+436642444418">+43-664-2444418</=
a>=C2=A0(mobile)<br>
</font></span></blockquote></div><br></div></div>

--047d7ba97ba0e5cef20539388a69--
