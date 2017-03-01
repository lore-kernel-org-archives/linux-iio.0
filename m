Return-Path: <SRS0=b79K=2K=gmail.com=ksenija.stanojevic@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1332233362.76422.1485734109212@email.1und1.de>
References: <cover.1485711797.git.ksenija.stanojevic@gmail.com>
 <d18975ff97a8855e9221b0a180b3664a0d04348c.1485711797.git.ksenija.stanojevic@gmail.com>
 <1332233362.76422.1485734109212@email.1und1.de>
From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
Date: Wed, 1 Mar 2017 15:42:42 +0100
Message-ID: <CAL7P5jKqY_4CAzvw2BiCbAPW7QEs6XNY7Qaec8GMp7Nxzp_71Q@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] input: touchscreen: mxs-lradc: Add support for touchscreen
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, linux-kernel <linux-kernel@vger.kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Harald Geyer <harald@ccbib.org>,
	Fabio Estevam <fabio.estevam@freescale.com>, linux-iio@vger.kernel.org,
	Marek Vasut <marex@denx.de>
Content-Type: multipart/alternative; boundary=001a1149a2f43cc7cb0549ac53f0
List-ID: <linux-iio@vger.kernel.org>

--001a1149a2f43cc7cb0549ac53f0
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Jan 30, 2017 at 12:55 AM, Stefan Wahren <stefan.wahren@i2se.com>
wrote:
> Hi Ksenija,
>
>> Ksenija Stanojevic <ksenija.stanojevic@gmail.com> hat am 29. Januar 2017
um 19:04 geschrieben:
>>
>>
>> Add 4-wire/5-wire touchscreen controller.
>
> i compiled all 3 driver as a module and kept the devicetree for the
Olinuxino iMX233 [1] as it is (no touchscreen). After booting all 3 driver
are loaded:
> where
> Module                  Size  Used by
> mxs_lradc_adc          11000  0
> industrialio_triggered_buffer     2628  1 mxs_lradc_adc
> kfifo_buf               3337  1 industrialio_triggered_buffer
> mxs_lradc_ts            4192  0
> mxs_lradc               4402  0
> mfd_core                4612  1 mxs_lradc
>
> But the touchscreen driver threw this error:
>
> [  427.230000] mxs-lradc-ts: probe of mxs-lradc-ts failed with error -22

I think it should be like that. In earlier versions module wouldn't load if
there was no touchscreen device (it was done in the mfd part). But Lee
suggested that it there is no device it should fail in the touchscreen
driver.

> I didn't expect this behavior. I expect that the touchscreen driver
notice that there isn't a touchscreen property and abort probing silently.
Also i didn't expected that the driver is still loaded in case of a probe
error.

Well module can be loaded if probe fails see __driver_attach [1] . But in
order that driver won't load in case of probe error I think init function
should be changed somehow, unregistered driver in case of error but I'm not
sure how...

> Btw shouldn't be the mxs_lradc_adc "Used by" mxs_lradc?
>
> Because "modprobe -r mxs_lradc" doesn't unload mxs_lradc_adc.

both adc and touchscreen driver can't load if mfd part is not loaded but in
order to be listed in Used by column and unload if mfd part is unloaded I
think that they need to use symbols from the mfd part.

[1] http://lxr.free-electrons.com/source/drivers/base/dd.c#L731

--001a1149a2f43cc7cb0549ac53f0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br>On Mon, Jan 30, 2017 at 12:55 AM, Stefan W=
ahren &lt;<a href=3D"mailto:stefan.wahren@i2se.com">stefan.wahren@i2se.com<=
/a>&gt; wrote:<br>&gt; Hi Ksenija,<br>&gt;<br>&gt;&gt; Ksenija Stanojevic &=
lt;<a href=3D"mailto:ksenija.stanojevic@gmail.com">ksenija.stanojevic@gmail=
.com</a>&gt; hat am 29. Januar 2017 um 19:04 geschrieben:<br>&gt;&gt;<br>&g=
t;&gt;<br>&gt;&gt; Add 4-wire/5-wire touchscreen controller.<br>&gt;<br>&gt=
; i compiled all 3 driver as a module and kept the devicetree for the Olinu=
xino iMX233 [1] as it is (no touchscreen). After booting all 3 driver are l=
oaded:<br></div>&gt; where <br><div>&gt; Module =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Size =C2=A0Used by<br>&gt; mxs_lradc_adc=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A011000 =C2=A00<br>&gt; industrialio_trigg=
ered_buffer =C2=A0 =C2=A0 2628 =C2=A01 mxs_lradc_adc<br>&gt; kfifo_buf =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 3337 =C2=A01 industrialio_tri=
ggered_buffer<br>&gt; mxs_lradc_ts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A04192 =C2=A00<br>&gt; mxs_lradc =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 4402 =C2=A00<br>&gt; mfd_core =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A04612 =C2=A01 mxs_lradc<br>&gt;<br>&gt; But the touchscr=
een driver threw this error:<br>&gt;<br>&gt; [ =C2=A0427.230000] mxs-lradc-=
ts: probe of mxs-lradc-ts failed with error -22<br><br>I think it should be=
 like that. In earlier versions module wouldn&#39;t load if there was no to=
uchscreen device (it was done in the mfd part). But Lee suggested that it t=
here is no device it should fail in the touchscreen driver.<br><br>&gt; I d=
idn&#39;t expect this behavior. I expect that the touchscreen driver notice=
 that there isn&#39;t a touchscreen property and abort probing silently. Al=
so i didn&#39;t expected that the driver is still loaded in case of a probe=
 error.<br><br>Well module can be loaded if probe fails see __driver_attach=
 [1] . But in order that driver won&#39;t load in case of probe error I thi=
nk init function should be changed somehow, unregistered driver in case of =
error but I&#39;m not sure how... <br><br>&gt; Btw shouldn&#39;t be the mxs=
_lradc_adc &quot;Used by&quot; mxs_lradc?<br>&gt;<br>&gt; Because &quot;mod=
probe -r mxs_lradc&quot; doesn&#39;t unload mxs_lradc_adc.<br><br>both adc =
and touchscreen driver can&#39;t load if mfd part is not loaded but in orde=
r to be listed in Used by column and unload if mfd part is unloaded I think=
 that they need to use symbols from the mfd part.<br><br>[1]<a href=3D"http=
://lxr.free-electrons.com/source/drivers/base/dd.c#L731"> http://lxr.free-e=
lectrons.com/source/drivers/base/dd.c#L731</a></div></div>

--001a1149a2f43cc7cb0549ac53f0--
