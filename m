Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
In-Reply-To: <CAOhV88OJZO_zO7WJ4WAvToAJGzcXp+zZ6y8v_xMeRgbBbhYrkg@mail.gmail.com>
References: <CAOhV88NP+bpN6oVk3_DbszNqKAo4T9z-umfVQAcyS3QArwguTA@mail.gmail.com>
	<CAEnQRZACu89UR2w=rN3mve8DFniqdf2=Y69FuBnoyXUber=kZA@mail.gmail.com>
	<CAOhV88PGnVWbnCjTf3W-jD22rtQYSXDVWez+gFkrPYky9kkQnw@mail.gmail.com>
	<CAKv63uvEKOycY2pPCRwVXvYR1yj8SbBaPJyw41_7mc4Vnftkew@mail.gmail.com>
	<CAOhV88OJZO_zO7WJ4WAvToAJGzcXp+zZ6y8v_xMeRgbBbhYrkg@mail.gmail.com>
Date: Wed, 16 Dec 2015 23:55:02 +0100
Message-ID: <CAKv63uv5806-ecxGXK8HSOSnoHciXp8UHBcyvEqYk14BX1snVQ@mail.gmail.com>
Subject: Re: Issues with Lenovo Yoga 900 IIO devices (accelerometer, etc.)
From: Crt Mori <cmo@melexis.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a11c33eacf0407c05270bcb6e
List-ID: <linux-iio@vger.kernel.org>

--001a11c33eacf0407c05270bcb6e
Content-Type: text/plain; charset=UTF-8

On Dec 16, 2015 11:37 PM, "Nish Aravamudan" <nish.aravamudan@gmail.com>
wrote:
>
> Hi,
>
> On Wed, Dec 16, 2015 at 2:22 PM, Crt Mori <cmo@melexis.com> wrote:
> > On 16 December 2015 at 22:41, Nish Aravamudan <nish.aravamudan@gmail.com>
wrote:
> >> Hi Daniel,
> >>
> >> On Wed, Dec 16, 2015 at 1:43 AM, Daniel Baluta <daniel.baluta@gmail.com>
wrote:
> >>> On Tue, Dec 15, 2015 at 9:19 PM, Nish Aravamudan
> >>> <nish.aravamudan@gmail.com> wrote:
> >>>> So, I apologize in advance for this relatively vague report, but I'm
fairly sure
> >>>> the Yoga 900 has an accelerometer amongst other sensors (ambient
light?)
> >>>> exported over IIO.
> >>>>
> >>>> But, these sensors seem to not be updating at all with a 4.4-rc5+
kernel (a
> >>>> set of patches from https://lkml.org/lkml/2015/11/30/441 applied to
Linus'
> >>>> tree).
> >>>>
> >>>> The odd part is at some point in messing with this, I'm fairly sure
it did work!
> >>>> That is,
> >>>>
> >>>> `watch -n 0.1 cat '/sys/bus/iio/devices/iio:device'*/*raw*`
> >>>
> >>> Can you send us a sample of the output? Also, would be
> >>> good to identify the exact driver for accel.
> >>
> >> cat /sys/bus/iio/devices/iio:device*/*raw*
> >> 65478
> >> 7
> >> 1023
> >> 0
> >> 0
> >> 0
> >> 100
> >> -539062
> >> -742187
> >> 1292968
> >> 1592
> >> 64932
> >> 2
> >> 275
> >> 0 0 0 0
> >>
> >> Now, I should say that I distinctly remember at some point waving my
> >> laptop around and seeing these values change ... but now they seem to
> >> be "stuck". Maybe it's a hardware issue or something special that
> >> WIndows does to leverage the IIO sensors?
> >>
> >>> Perhaps: cat /sys/bus/iio/devices/iio:device'*/name
> >>
> >> $ cat /sys/bus/iio/devices/iio:device*/name
> >> accel_3d
> >
> > Can you list the directory of iio:device with this name (it is:
> > drivers/iio/accel/hid-sensor-accel-3d.c).
> > This is something you will be looking at for accel debugging, but it
> > seems more like
> > standard
>
> /sys/bus/iio/devices/iio:device0/name
> gyro_3d
> /sys/bus/iio/devices/iio:device1/name
> dev_rotation
> /sys/bus/iio/devices/iio:device2/name
> als
> /sys/bus/iio/devices/iio:device3/name
> magn_3d
> /sys/bus/iio/devices/iio:device4/name
> accel_3d
> /sys/bus/iio/devices/iio:device5/name
> incli_3d
>
> are all the IIO sensors, sorry about that!
>

I was more thinking what else is in iio:device4 directory, so that we can
see if it was initialized OK. Can you also grep the dmesg for any errors?

> >> gyro_3d
> >> als
> >> magn_3d
> >> incli_3d
> >> dev_rotation
> >>
> >>
> >>>>
> >>>> showed updating values as I moved the laptop around.
> >>>>
> >>>> I've not done any accelerometer debugging before, so any suggestion
on
> >>>> where to start would be greatly appreciated!
> >>>
> >>> Did you applied some patches and recompiled the kernel? Or when it
did stopped
> >>> working?
> >>
> >> As far as I can tell, it only worked that one one time and hasn't
> >> since. Although your question does make me wonder *which* kernel I was
> >> on that I experienced the values changing. Let me go back to a stock
> >> 4.4-rc5 and see.
> >
> > Did you compile the stock kernel? It might be that .dts file you are
> > using (or defconfig)
> > is not correct.
>
> I compiled the stock kernel, based off the the Ubuntu 15.04 .config,
> trimmed to account for the hardware I have on the system. I can attach
> the .config if that will be useful.
>
> I just went back to 4.4-rc4 and it also didn't seem to have any
> updates to the raw file contents.
>

I hope full post of your defconfig will not be needed. However could you
double check that you have enabled all drivers for accel (check the kbuild
file in drivers/iio/accel). If they have driver for accel in main kernel
(or staging) then it will link with existing device tree nicely.

Crt

--001a11c33eacf0407c05270bcb6e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
On Dec 16, 2015 11:37 PM, &quot;Nish Aravamudan&quot; &lt;<a href=3D"mailto=
:nish.aravamudan@gmail.com">nish.aravamudan@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Wed, Dec 16, 2015 at 2:22 PM, Crt Mori &lt;<a href=3D"mailto:cmo@me=
lexis.com">cmo@melexis.com</a>&gt; wrote:<br>
&gt; &gt; On 16 December 2015 at 22:41, Nish Aravamudan &lt;<a href=3D"mail=
to:nish.aravamudan@gmail.com">nish.aravamudan@gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt; Hi Daniel,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Wed, Dec 16, 2015 at 1:43 AM, Daniel Baluta &lt;<a href=3D=
"mailto:daniel.baluta@gmail.com">daniel.baluta@gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt; On Tue, Dec 15, 2015 at 9:19 PM, Nish Aravamudan<br>
&gt; &gt;&gt;&gt; &lt;<a href=3D"mailto:nish.aravamudan@gmail.com">nish.ara=
vamudan@gmail.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt;&gt; So, I apologize in advance for this relatively vague =
report, but I&#39;m fairly sure<br>
&gt; &gt;&gt;&gt;&gt; the Yoga 900 has an accelerometer amongst other senso=
rs (ambient light?)<br>
&gt; &gt;&gt;&gt;&gt; exported over IIO.<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; But, these sensors seem to not be updating at all wit=
h a 4.4-rc5+ kernel (a<br>
&gt; &gt;&gt;&gt;&gt; set of patches from <a href=3D"https://lkml.org/lkml/=
2015/11/30/441">https://lkml.org/lkml/2015/11/30/441</a> applied to Linus&#=
39;<br>
&gt; &gt;&gt;&gt;&gt; tree).<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; The odd part is at some point in messing with this, I=
&#39;m fairly sure it did work!<br>
&gt; &gt;&gt;&gt;&gt; That is,<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; `watch -n 0.1 cat &#39;/sys/bus/iio/devices/iio:devic=
e&#39;*/*raw*`<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Can you send us a sample of the output? Also, would be<br=
>
&gt; &gt;&gt;&gt; good to identify the exact driver for accel.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; cat /sys/bus/iio/devices/iio:device*/*raw*<br>
&gt; &gt;&gt; 65478<br>
&gt; &gt;&gt; 7<br>
&gt; &gt;&gt; 1023<br>
&gt; &gt;&gt; 0<br>
&gt; &gt;&gt; 0<br>
&gt; &gt;&gt; 0<br>
&gt; &gt;&gt; 100<br>
&gt; &gt;&gt; -539062<br>
&gt; &gt;&gt; -742187<br>
&gt; &gt;&gt; 1292968<br>
&gt; &gt;&gt; 1592<br>
&gt; &gt;&gt; 64932<br>
&gt; &gt;&gt; 2<br>
&gt; &gt;&gt; 275<br>
&gt; &gt;&gt; 0 0 0 0<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Now, I should say that I distinctly remember at some point wa=
ving my<br>
&gt; &gt;&gt; laptop around and seeing these values change ... but now they=
 seem to<br>
&gt; &gt;&gt; be &quot;stuck&quot;. Maybe it&#39;s a hardware issue or some=
thing special that<br>
&gt; &gt;&gt; WIndows does to leverage the IIO sensors?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt; Perhaps: cat /sys/bus/iio/devices/iio:device&#39;*/name<b=
r>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; $ cat /sys/bus/iio/devices/iio:device*/name<br>
&gt; &gt;&gt; accel_3d<br>
&gt; &gt;<br>
&gt; &gt; Can you list the directory of iio:device with this name (it is:<b=
r>
&gt; &gt; drivers/iio/accel/hid-sensor-accel-3d.c).<br>
&gt; &gt; This is something you will be looking at for accel debugging, but=
 it<br>
&gt; &gt; seems more like<br>
&gt; &gt; standard<br>
&gt;<br>
&gt; /sys/bus/iio/devices/iio:device0/name<br>
&gt; gyro_3d<br>
&gt; /sys/bus/iio/devices/iio:device1/name<br>
&gt; dev_rotation<br>
&gt; /sys/bus/iio/devices/iio:device2/name<br>
&gt; als<br>
&gt; /sys/bus/iio/devices/iio:device3/name<br>
&gt; magn_3d<br>
&gt; /sys/bus/iio/devices/iio:device4/name<br>
&gt; accel_3d<br>
&gt; /sys/bus/iio/devices/iio:device5/name<br>
&gt; incli_3d<br>
&gt;<br>
&gt; are all the IIO sensors, sorry about that!<br>
&gt;</p>
<p dir=3D"ltr">I was more thinking what else is in iio:device4 directory, s=
o that we can see if it was initialized OK. Can you also grep the dmesg for=
 any errors?</p>
<p dir=3D"ltr">&gt; &gt;&gt; gyro_3d<br>
&gt; &gt;&gt; als<br>
&gt; &gt;&gt; magn_3d<br>
&gt; &gt;&gt; incli_3d<br>
&gt; &gt;&gt; dev_rotation<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; showed updating values as I moved the laptop around.<=
br>
&gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt;&gt; I&#39;ve not done any accelerometer debugging before,=
 so any suggestion on<br>
&gt; &gt;&gt;&gt;&gt; where to start would be greatly appreciated!<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Did you applied some patches and recompiled the kernel? O=
r when it did stopped<br>
&gt; &gt;&gt;&gt; working?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; As far as I can tell, it only worked that one one time and ha=
sn&#39;t<br>
&gt; &gt;&gt; since. Although your question does make me wonder *which* ker=
nel I was<br>
&gt; &gt;&gt; on that I experienced the values changing. Let me go back to =
a stock<br>
&gt; &gt;&gt; 4.4-rc5 and see.<br>
&gt; &gt;<br>
&gt; &gt; Did you compile the stock kernel? It might be that .dts file you =
are<br>
&gt; &gt; using (or defconfig)<br>
&gt; &gt; is not correct.<br>
&gt;<br>
&gt; I compiled the stock kernel, based off the the Ubuntu 15.04 .config,<b=
r>
&gt; trimmed to account for the hardware I have on the system. I can attach=
<br>
&gt; the .config if that will be useful.<br>
&gt;<br>
&gt; I just went back to 4.4-rc4 and it also didn&#39;t seem to have any<br=
>
&gt; updates to the raw file contents.<br>
&gt;</p>
<p dir=3D"ltr">I hope full post of your defconfig will not be needed. Howev=
er could you double check that you have enabled all drivers for accel (chec=
k the kbuild file in drivers/iio/accel). If they have driver for accel in m=
ain kernel (or staging) then it will link with existing device tree nicely.=
</p>
<p dir=3D"ltr">Crt<br>
</p>

--001a11c33eacf0407c05270bcb6e--
