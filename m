Return-Path: <SRS0=sfNV=6S=gmail.com=ctx.xda@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1500128998.2468.1.camel@hadess.net>
References: <20170715122721.6908-1-ctx.xda@gmail.com> <1500128998.2468.1.camel@hadess.net>
From: Patrick Pedersen <ctx.xda@gmail.com>
Date: Sat, 15 Jul 2017 19:52:20 +0200
Message-ID: <CAA7d1im1hxM13SrsF5pQsJmtugjT2CJZnJdmbC2KxL5_QPXd_Q@mail.gmail.com>
Subject: Re: [PATCH] HID: Add quirk for Lenovo Yoga 910 with ITE Chips
To: Bastien Nocera <hadess@hadess.net>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary="089e08231230dc471505545ed3c8"
List-ID: <linux-iio@vger.kernel.org>

--089e08231230dc471505545ed3c8
Content-Type: text/plain; charset="UTF-8"

On Sat, Jul 15, 2017 at 4:29 PM, Bastien Nocera <hadess@hadess.net> wrote:

> On Sat, 2017-07-15 at 14:27 +0200, Patrick Pedersen wrote:
> > As with previous generations of this device (see https://patchwork.ke
> > rnel.org/patch/7887361/), the ITE
> > HID Sensor Hub, responsible for the accelerometer and als sensor,
> > requires a quirk entry.
> >
> > Without the entry, the Sensor Hub can't be accessed and the kernel
> > fails to report any movements. As a result
> > iio-sensor-proxy receives no new data.
> >
> > It shall additionally be noted that the i2c-hid 'sleep' bug (present
> > since kernel ver. 4.3)
> > still affects the driver. This means that the sensor hub will not
> > report any movement, until
> > the device is suspended and resumed.
> >
> > Signed-off-by: Patrick Pedersen <ctx.xda@gmail.com>
> > ---
> >  drivers/hid/hid-ids.h        | 1 +
> >  drivers/hid/hid-sensor-hub.c | 3 +++
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 4f9a3938189a..b427a0bcfbe8 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -565,6 +565,7 @@
> >  #define USB_DEVICE_ID_ITE_LENOVO_YOGA   0x8386
> >  #define USB_DEVICE_ID_ITE_LENOVO_YOGA2  0x8350
> >  #define USB_DEVICE_ID_ITE_LENOVO_YOGA900     0x8396
> > +#define USB_DEVICE_ID_ITE_LENOVO_YOGA910     0x8186
> >
> >  #define USB_VENDOR_ID_JABRA          0x0b0e
> >  #define USB_DEVICE_ID_JABRA_SPEAK_410        0x0412
> > diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-
> > hub.c
> > index 4ef73374a8f9..85b8425483bd 100644
> > --- a/drivers/hid/hid-sensor-hub.c
> > +++ b/drivers/hid/hid-sensor-hub.c
> > @@ -820,6 +820,9 @@ static const struct hid_device_id
> > sensor_hub_devices[] = {
> >       { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > USB_VENDOR_ID_ITE,
> >                       USB_DEVICE_ID_ITE_LENOVO_YOGA900),
> >                       .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> > +     { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > USB_VENDOR_ID_ITE,
> > +                     USB_DEVICE_ID_ITE_LENOVO_YOGA910),
> > +                     .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> >       { HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,
> > USB_VENDOR_ID_INTEL_0,
> >                       0x22D8),
> >                       .driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
>
> At this point, wouldn't it make sense to apply the quirk to *all* ITE
> devices in Lenovo Yoga laptops?
>

I'm not sure If I got your suggestion right.

Those laptops do not share the same ITE chip. ITE is simply
the vendor/manufacturer of the hid sensor hub. All three defined
yoga laptops use a different ITE sensor hub model.

To make this clear, my device, the
Lenovo Yoga 910 uses a ITE8186,
where the Yoga 900 uses a ITE8396,
the Yoga 2 a ITE8350 and so on

Now what "could" me done, is to detect and set the quirk automatically.
This should be doable, as the Hardware PID corresponds to the
model number of the Sensor Hub (ex. ITE8186 = PID 0x8186)

--089e08231230dc471505545ed3c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On S=
at, Jul 15, 2017 at 4:29 PM, Bastien Nocera <span dir=3D"ltr">&lt;<a href=
=3D"mailto:hadess@hadess.net" target=3D"_blank">hadess@hadess.net</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div clas=
s=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On Sat, 2017-07-15 at 14:27 +020=
0, Patrick Pedersen wrote:<br>
&gt; As with previous generations of this device (see <a href=3D"https://pa=
tchwork.ke" rel=3D"noreferrer" target=3D"_blank">https://patchwork.ke</a><b=
r>
&gt; <a href=3D"http://rnel.org/patch/7887361/" rel=3D"noreferrer" target=
=3D"_blank">rnel.org/patch/7887361/</a>), the ITE<br>
&gt; HID Sensor Hub, responsible for the accelerometer and als sensor,<br>
&gt; requires a quirk entry.<br>
&gt;<br>
&gt; Without the entry, the Sensor Hub can&#39;t be accessed and the kernel=
<br>
&gt; fails to report any movements. As a result<br>
&gt; iio-sensor-proxy receives no new data.<br>
&gt;<br>
&gt; It shall additionally be noted that the i2c-hid &#39;sleep&#39; bug (p=
resent<br>
&gt; since kernel ver. 4.3)<br>
&gt; still affects the driver. This means that the sensor hub will not<br>
&gt; report any movement, until<br>
&gt; the device is suspended and resumed.<br>
&gt;<br>
&gt; Signed-off-by: Patrick Pedersen &lt;<a href=3D"mailto:ctx.xda@gmail.co=
m">ctx.xda@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/hid/hid-ids.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
&gt;=C2=A0 drivers/hid/hid-sensor-hub.c | 3 +++<br>
&gt;=C2=A0 2 files changed, 4 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h<br>
&gt; index 4f9a3938189a..b427a0bcfbe8 100644<br>
&gt; --- a/drivers/hid/hid-ids.h<br>
&gt; +++ b/drivers/hid/hid-ids.h<br>
&gt; @@ -565,6 +565,7 @@<br>
&gt;=C2=A0 #define USB_DEVICE_ID_ITE_LENOVO_YOGA=C2=A0 =C2=A00x8386<br>
&gt;=C2=A0 #define USB_DEVICE_ID_ITE_LENOVO_YOGA2=C2=A0 0x8350<br>
&gt;=C2=A0 #define USB_DEVICE_ID_ITE_LENOVO_<wbr>YOGA900=C2=A0 =C2=A0 =C2=
=A00x8396<br>
&gt; +#define USB_DEVICE_ID_ITE_LENOVO_<wbr>YOGA910=C2=A0 =C2=A0 =C2=A00x81=
86<br>
&gt;<br>
&gt;=C2=A0 #define USB_VENDOR_ID_JABRA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x=
0b0e<br>
&gt;=C2=A0 #define USB_DEVICE_ID_JABRA_SPEAK_410=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x0412<br>
&gt; diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-<br=
>
&gt; hub.c<br>
&gt; index 4ef73374a8f9..85b8425483bd 100644<br>
&gt; --- a/drivers/hid/hid-sensor-hub.c<br>
&gt; +++ b/drivers/hid/hid-sensor-hub.c<br>
&gt; @@ -820,6 +820,9 @@ static const struct hid_device_id<br>
&gt; sensor_hub_devices[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_H=
UB,<br>
&gt; USB_VENDOR_ID_ITE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0USB_DEVICE_ID_ITE_LENOVO_<wbr>YOGA900),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.driver_data =3D HID_SENSOR_HUB_ENUM_QUIRK},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB,<b=
r>
&gt; USB_VENDOR_ID_ITE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0USB_DEVICE_ID_ITE_LENOVO_<wbr>YOGA910),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0.driver_data =3D HID_SENSOR_HUB_ENUM_QUIRK},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_H=
UB,<br>
&gt; USB_VENDOR_ID_INTEL_0,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x22D8),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0.driver_data =3D HID_SENSOR_HUB_ENUM_QUIRK},<br>
<br>
</div></div>At this point, wouldn&#39;t it make sense to apply the quirk to=
 *all* ITE<br>
devices in Lenovo Yoga laptops?<br>
</blockquote></div><br></div><div class=3D"gmail_extra">I&#39;m not sure If=
 I got your suggestion right.<div><br></div><div>Those laptops do not share=
 the same ITE chip. ITE is simply=C2=A0</div><div>the vendor/manufacturer o=
f the hid sensor hub. All three defined=C2=A0</div><div>yoga laptops use a =
different ITE sensor hub model.</div><div><br></div><div>To make this clear=
, my device, the=C2=A0</div><div>Lenovo Yoga 910 uses a ITE8186,=C2=A0</div=
><div>where the Yoga 900 uses a ITE8396,=C2=A0</div><div>the Yoga 2 a ITE<s=
pan style=3D"color:rgb(0,0,0);font-size:12px">8350 and so on<br><br>Now wha=
t &quot;could&quot; me done, is to detect and set the quirk automatically.=
=C2=A0</span></div><div><span style=3D"color:rgb(0,0,0);font-size:12px">Thi=
s should be doable, as the Hardware PID corresponds to the=C2=A0</span></di=
v><div><span style=3D"color:rgb(0,0,0);font-size:12px">model number of the =
Sensor Hub (ex. ITE8186 =3D PID 0x8186)</span></div><div><span style=3D"col=
or:rgb(0,0,0);font-size:12px"><br></span></div></div></div>

--089e08231230dc471505545ed3c8--
