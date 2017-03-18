Return-Path: <SRS0=+0on=23=gmail.com=miltmobley@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1489767728.88966.8.camel@intel.com>
References: <1489659652-35608-1-git-send-email-hongyan.song@intel.com>
 <1489716812.10281.4.camel@intel.com> <1489756594.18490.22.camel@hadess.net> <1489767728.88966.8.camel@intel.com>
From: Milton Mobley <miltmobley@gmail.com>
Date: Fri, 17 Mar 2017 17:24:31 -0700
Message-ID: <CAB5G33c3DUOpgVGPacBFLhzkqNiX8scM2ZmyDdF1=sfZoo_bHw@mail.gmail.com>
Subject: Re: [PATCH] iio: hid: hid-sensor-accel-3d: Add second ACC sensor support
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "Song, Hongyan" <hongyan.song@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "hadess@hadess.net" <hadess@hadess.net>,
	"jikos@kernel.org" <jikos@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>
Content-Type: multipart/alternative; boundary=001a114e7e3667cbf9054af65196
List-ID: <linux-iio@vger.kernel.org>

--001a114e7e3667cbf9054af65196
Content-Type: text/plain; charset=UTF-8

Your device naming convention should be:

1) consistent with usual linux kernel practice
2) compatible with acpi-based systems (x86 and arm64)
3) compatible with device tree based systems (all others, I believe).

Here is some info from my dell 2-in-1 touch laptop:

Device(u'/sys/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-1/i2c-
DELL0742:00/0018:06CB:7E92.0009/input/input13')

According to the description in acpi programming reference, this suggests
acpi loaded the pci bus enumerator, which found the i2c-designware
host controllers, called the i2c_designwarer driver's probe function, which
did not scan the bus for slaves. But someone else has, possibly a driver
in the input system, and created the /sys node.

As you can see, '/', ':', '-' and '.' are being used as separators.

My hardware info says the laptop has two designware i2c host controllers,
thus the 'i2c-1' above refers to one of these.
I don't know what the following stuff is, but the '.0009' is probably an
i2c slave device specific value.

So you could, for example use 'accel_3d.1', etc for your naming. Where you
would create it is an open question.

Finally, I see some general problems in creating a system to monitor many
sensors:

Common sensors  don't have usb interfaces, so you couldn't use usb or hid
interface to control them.

These sensors do have either i2c or spi or both interfaces. Some have uart
interfaces

Sensors with i2c interfaces may have either one or two slave addresses. If
two, the address is selected by an input pin.
There is probably no name register you could program or use to distinguish
two devices on the same bus.
You would have to store the slave address somewhere, perhaps in a struct
with a name like 'chip_info'.

Of course in a device tree based system, you could just declare the slaves
as resources, and specify their slave addresses.

spi has the problem that 'in band' slave addressing is not supported, i.e.
there is no slave address in the data messages,
so you have to use extra gpio pins to select multiple devices.

On Fri, Mar 17, 2017 at 9:22 AM, Pandruvada, Srinivas <
srinivas.pandruvada@intel.com> wrote:

> On Fri, 2017-03-17 at 14:16 +0100, Bastien Nocera wrote:
> > On Fri, 2017-03-17 at 02:13 +0000, Pandruvada, Srinivas wrote:
> > >
> > > On Thu, 2017-03-16 at 18:20 +0800, Song Hongyan wrote:
> > > >
> > > > As accelerometer sensor becomes more and more popular, there are
> > > > more
> > > > user scenarios have been developed, "Hinge" is a very important
> > > > usecase
> > > > which needs two accelerometer sensors to calculate the included
> > > > angle
> > > > of keyboard and screen.
> > > > In this case, two accelerometer sensors will be exposed.
> > > > Currently,
> > > > IIO interface hasn't other way to distinguish two sensors with
> > > > same
> > > > sensor type, except sensor name. So a new sensor name
> > > > "accel_2nd_3d"
> > > > is added for secondary accelerometer sensor.
> > >
> > > This type of interface will not satisfy all cases. We have some
> > > hubs
> > > with  many accelerometers attached. Same case is also true even for
> > > discrete sensors. So there should be some framework way to expose
> > > location of sensors.
> >
> > So you're nacking as well?
> Yes.
>
> >
> > >
> > > ACPI has special method called _PLD (Physical Device Location),
> > > which
> > > can  be used to specify location of any device. So we need to be
> > > able
> > > to export such information to user space. We can add for each
> > > sensor
> > > the location information.
> > >
> > > I can propose some ABI for exporting location information.
> >
> > There were patches floating around to do this, but they were never
> > finished:
> > http://www.spinics.net/lists/linux-acpi/msg51540.html
> We need to add some of those element related to sensors to IIO ABI.
> I will propose an ABI as Jonathan suggested.
>
> Thanks,
> Srinivas
>

--001a114e7e3667cbf9054af65196
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>Your device naming convention sho=
uld be:<br><br></div>1) consistent with usual linux kernel practice<br></di=
v>2) compatible with acpi-based systems (x86 and arm64)<br></div>3) compati=
ble with device tree based systems (all others, I believe).<br></div><br></=
div>Here is some info from my dell 2-in-1 touch laptop:<br><br><div><div><d=
iv><div><div>Device(u&#39;/sys/devices/pci0000:<wbr>00/0000:00:15.0/i2c_<wb=
r>designware.0/i2c-1/i2c-<wbr>DELL0742:00/0018:06CB:7E92.<wbr>0009/input/in=
put13&#39;)<br><br></div><div>According to the description in acpi programm=
ing reference, this suggests acpi loaded the pci bus enumerator, which foun=
d the i2c-designware<br></div><div>host controllers, called the i2c_<wbr>de=
signwarer driver&#39;s probe function, which did not scan the bus for slave=
s. But someone else has, possibly a driver<br>in the input system, and crea=
ted the /sys node.<br><br></div><div>As you can see, &#39;/&#39;, &#39;:&#3=
9;, &#39;-&#39; and &#39;.&#39; are being used as separators.<br><br></div>=
<div>My hardware info says the laptop has two <wbr>designware i2c host cont=
rollers, thus the &#39;i2c-1&#39; above refers to one of these.<br></div><d=
iv>I don&#39;t know what the following stuff is, but the &#39;.0009&#39; is=
 probably an i2c slave device specific value.<br><br></div><div>So you coul=
d, for example use &#39;accel_3d.1&#39;, etc for your naming. Where you wou=
ld create it is an open question.<br><br></div><div>Finally, I see some gen=
eral problems in creating a system to monitor many sensors:<br><br></div><d=
iv>Common sensors=C2=A0 don&#39;t have usb interfaces, so you couldn&#39;t =
use usb or hid interface to control them.<br></div><div><br>These sensors d=
o have either i2c or spi or both interfaces. Some have uart interfaces<br><=
br></div><div>Sensors with i2c interfaces may have either one or two slave =
addresses. If two, the address is selected by an input pin.<br></div><div>T=
here is probably no name register you could program or use to distinguish t=
wo devices on the same bus.<br></div><div>You would have to store the slave=
 address somewhere, perhaps in a struct with a name like &#39;chip_info&#39=
;.<br></div><div><br></div><div>Of course in a device tree based system, yo=
u could just declare the slaves as resources, and specify their slave addre=
sses.<br><br></div><div>spi has the problem that &#39;in band&#39; slave ad=
dressing is not supported, i.e. there is no slave address in the data messa=
ges,<br>so you have to use extra gpio pins to select multiple devices.<br><=
/div></div></div></div></div></div><div class=3D"gmail_extra"><br><div clas=
s=3D"gmail_quote">On Fri, Mar 17, 2017 at 9:22 AM, Pandruvada, Srinivas <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:srinivas.pandruvada@intel.com" target=
=3D"_blank">srinivas.pandruvada@intel.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><span class=3D"">On Fri, 2017-03-17 at 14:16 +0100, =
Bastien Nocera wrote:<br>
&gt; On Fri, 2017-03-17 at 02:13 +0000, Pandruvada, Srinivas wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Thu, 2017-03-16 at 18:20 +0800, Song Hongyan wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; As accelerometer sensor becomes more and more popular, there=
 are<br>
&gt; &gt; &gt; more<br>
&gt; &gt; &gt; user scenarios have been developed, &quot;Hinge&quot; is a v=
ery important<br>
&gt; &gt; &gt; usecase<br>
&gt; &gt; &gt; which needs two accelerometer sensors to calculate the inclu=
ded<br>
&gt; &gt; &gt; angle<br>
&gt; &gt; &gt; of keyboard and screen.<br>
&gt; &gt; &gt; In this case, two accelerometer sensors will be exposed.<br>
&gt; &gt; &gt; Currently,<br>
&gt; &gt; &gt; IIO interface hasn&#39;t other way to distinguish two sensor=
s with<br>
&gt; &gt; &gt; same<br>
&gt; &gt; &gt; sensor type, except sensor name. So a new sensor name<br>
&gt; &gt; &gt; &quot;accel_2nd_3d&quot;<br>
&gt; &gt; &gt; is added for secondary accelerometer sensor.<br>
&gt; &gt;<br>
&gt; &gt; This type of interface will not satisfy all cases. We have some<b=
r>
&gt; &gt; hubs<br>
&gt; &gt; with=C2=A0=C2=A0many accelerometers attached. Same case is also t=
rue even for<br>
&gt; &gt; discrete sensors. So there should be some framework way to expose=
<br>
&gt; &gt; location of sensors.<br>
&gt;<br>
&gt; So you&#39;re nacking as well?<br>
</span>Yes.<br>
<span class=3D""><br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; ACPI has special method called _PLD (Physical Device Location),<b=
r>
&gt; &gt; which<br>
&gt; &gt; can=C2=A0=C2=A0be used to specify location of any device. So we n=
eed to be<br>
&gt; &gt; able<br>
&gt; &gt; to export such information to user space. We can add for each<br>
&gt; &gt; sensor<br>
&gt; &gt; the location information.<br>
&gt; &gt;<br>
&gt; &gt; I can propose some ABI for exporting location information.<br>
&gt;<br>
&gt; There were patches floating around to do this, but they were never<br>
&gt; finished:<br>
&gt; <a href=3D"http://www.spinics.net/lists/linux-acpi/msg51540.html" rel=
=3D"noreferrer" target=3D"_blank">http://www.spinics.net/lists/<wbr>linux-a=
cpi/msg51540.html</a><br>
</span>We need to add some of those element related to sensors to IIO ABI.<=
br>
I will propose an ABI as Jonathan suggested.<br>
<br>
Thanks,<br>
Srinivas<br>
</blockquote></div><br></div>

--001a114e7e3667cbf9054af65196--
