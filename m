Return-Path: <SRS0=TgUD=72=gmail.com=harinath922@kernel.org>
MIME-Version: 1.0
In-Reply-To: <d2c0cc909ca48d674c1432233ef02c57@posteo.de>
References: <1503245215-12150-1-git-send-email-harinath922@gmail.com>
 <b5ba8c62743486649f99625d7a43e42b@posteo.de> <99ef70c3-64f0-66eb-5c1a-45a034ead5d5@gmail.com>
 <d2c0cc909ca48d674c1432233ef02c57@posteo.de>
From: harinath Nampally <harinath922@gmail.com>
Date: Wed, 23 Aug 2017 22:38:30 -0400
Message-ID: <CAAGUq_r4Foj1YFCDAotEWufr272VeBEfpoStf+01iuA6ZD3Ktw@mail.gmail.com>
Subject: Re: [PATCH v4] iio: accel: mma8452: improvements to handle multiple events
To: Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg KH <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alison Schofield <amsfield22@gmail.com>, linux-iio-owner@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a114675aac1a68d055776bba4"
List-ID: <linux-iio@vger.kernel.org>

--001a114675aac1a68d055776bba4
Content-Type: text/plain; charset="UTF-8"

>
> Am 23.08.2017 02:29 schrieb Harinath Nampally:
>
>>
>>> If rising: use transient OR ff_mt device-dependent like before. But now
>>> save it in a simple flag,
>>> whether transient registers are available.
>>>
>> Ok, is it good idea to add the flag to struct mma_chip_info like below?
>>
>>   * @mma_scales:                        scale factors for converting
>> register values
>>   *                             to m/s^2; 3 modes: 2g, 4g, 8g; 2 integers
>>   *                             per mode: m/s^2 and micro m/s^2
>> + * @transient_supported:       flag indicating whether chip support
>> transient
>> + *                             event, as not all chips support transient
>> event
>>   */
>>  struct mma_chip_info {
>>         u8 chip_id;
>>         const struct iio_chan_spec *channels;
>>         int num_channels;
>>         const int mma_scales[3][2];
>> +       bool transient_supported;
>>  };
>>
>>
> I'd avoid boolean and use int and define EVENT_TYPE_TRANSIENT BIT(1) and
> EVENT_TYPE_FF_MT BIT(0) for example. So something like
> "supported_event_types"
> can have all types supported.

ok sure, I am thinking to adding 'int supported_event_types'(chip supported
events) and 'int enabled_event_types'(events enabled by this driver for
this chip). So in the probe method based on chip specific
'supported_event_types' and 'enabled_event_types' I can configure the
interrupt register accordingly.

>
> But this has quite some implications on your implementation, so your
> complete
> solution would be more interesting to see. Keep it simple and focus on
> only this one
> issue of enabling freefall (FF_MT registers) for the devices that
> currently use
> transient registers.

The main motivation of this patch was to add new events like tap and
orientation for fxls8471, So I would like to
make code changes such a way that it fixes the issue of enabling freefall(FF_MT
registers) for the devices
that currently use transient registers and also make the driver flexible
enough to add multiple new events.

Thanks,
Hari


On Wed, Aug 23, 2017 at 12:52 AM, Martin Kepplinger <martink@posteo.de>
wrote:

> Am 23.08.2017 02:29 schrieb Harinath Nampally:
>
>>
>>> If rising: use transient OR ff_mt device-dependent like before. But now
>>> save it in a simple flag,
>>> whether transient registers are available.
>>>
>> Ok, is it good idea to add the flag to struct mma_chip_info like below?
>>
>>   * @mma_scales:                        scale factors for converting
>> register values
>>   *                             to m/s^2; 3 modes: 2g, 4g, 8g; 2 integers
>>   *                             per mode: m/s^2 and micro m/s^2
>> + * @transient_supported:       flag indicating whether chip support
>> transient
>> + *                             event, as not all chips support transient
>> event
>>   */
>>  struct mma_chip_info {
>>         u8 chip_id;
>>         const struct iio_chan_spec *channels;
>>         int num_channels;
>>         const int mma_scales[3][2];
>> +       bool transient_supported;
>>  };
>>
>>
> I'd avoid boolean and use int and define EVENT_TYPE_TRANSIENT BIT(1) and
> EVENT_TYPE_FF_MT BIT(0) for example. So something like
> "supported_event_types"
> can have all types supported.
>
> But this has quite some implications on your implementation, so your
> complete
> solution would be more interesting to see. Keep it simple and focus on
> only this one
> issue of enabling freefall (FF_MT registers) for the devices that
> currently use
> transient registers.
>
> thanks
>
>
>
>>> If falling: switch to ff_mt in any case. (fixing freefall for the
>>> transient-devices)
>>>
>> ok sure.
>>
>> Thanks,
>>
>> Hari
>>
>> On 08/21/2017 04:47 AM, Martin Kepplinger wrote:
>>
>>>
>>> If rising: use transient OR ff_mt device-dependent like before. But now
>>> save it in a simple flag,
>>> whether transient registers are available.
>>>
>>> If falling: switch to ff_mt in any case. (fixing freefall for the
>>> transient-devices)
>>>
>>
>

--001a114675aac1a68d055776bba4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span cl=
ass=3D"gmail-im" style=3D"font-size:12.8px">Am 23.08.2017 02:29 schrieb Har=
inath Nampally:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><br>If rising: use transient OR=
 ff_mt device-dependent like before. But now save it in a simple flag,<br>w=
hether transient registers are available.<br></blockquote>Ok, is it good id=
ea to add the flag to struct mma_chip_info like below?<br><br>=C2=A0 * @mma=
_scales:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 scale factors for converting<br>register values<br>=C2=A0=
 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to m/s^2; 3 modes: 2g, 4g, 8g; 2 integers<br=
>=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0per mode: m/s^2 and micro m/s^2<br>+ =
* @transient_supported:=C2=A0 =C2=A0 =C2=A0 =C2=A0flag indicating whether c=
hip support transient<br>+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event, as not al=
l chips support transient event<br>=C2=A0 */<br>=C2=A0struct mma_chip_info =
{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 chip_id;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 const struct iio_chan_spec *channels;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 int n=
um_channels;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 const int mma_scales[3][2];<br>=
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool transient_supported;<br>=C2=A0};<br><br></=
blockquote><br></span><span style=3D"font-size:12.8px">I&#39;d avoid boolea=
n and use int and define EVENT_TYPE_TRANSIENT BIT(1) and</span><br style=3D=
"font-size:12.8px"><span style=3D"font-size:12.8px">EVENT_TYPE_FF_MT BIT(0)=
 for example. So something like &quot;supported_event_types&quot;</span><br=
 style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">can have all t=
ypes supported.</span></blockquote><div>ok sure, I am thinking to adding &#=
39;int supported_event_types&#39;(chip supported events) and &#39;int enabl=
ed_event_types&#39;(events enabled by this driver for this chip). So in the=
 probe method based on chip specific &#39;supported_event_types&#39; and &#=
39;enabled_event_types&#39; I can configure the interrupt register accordin=
gly.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br style=
=3D"font-size:12.8px"><span style=3D"font-size:12.8px">But this has quite s=
ome implications on your implementation, so your complete</span><br style=
=3D"font-size:12.8px"><span style=3D"font-size:12.8px">solution would be mo=
re interesting to see. Keep it simple and focus on only this one</span><br =
style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">issue of enabli=
ng freefall (FF_MT registers) for the devices that currently use</span><br =
style=3D"font-size:12.8px"><span style=3D"font-size:12.8px">transient regis=
ters.</span></blockquote><div>The main motivation of this patch was to add =
new events like tap and orientation for fxls8471, So I would like to=C2=A0<=
/div><div>make code changes such a way that it fixes the issue of enabling =
freefall<span style=3D"font-size:12.8px">(FF_MT registers) for the devices=
=C2=A0</span></div><div><span style=3D"font-size:12.8px">that currently use=
=C2=A0</span><span style=3D"font-size:12.8px">transient registers and also =
make the driver flexible enough to add multiple new events.</span></div><di=
v><span style=3D"font-size:12.8px"><br></span></div><div><span style=3D"fon=
t-size:12.8px">Thanks,</span></div><div><span style=3D"font-size:12.8px">Ha=
ri</span></div><div><br></div></div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On Wed, Aug 23, 2017 at 12:52 AM, Martin Kepplinger <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:martink@posteo.de" target=3D"_blank">ma=
rtink@posteo.de</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><sp=
an class=3D"">Am 23.08.2017 02:29 schrieb Harinath Nampally:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
If rising: use transient OR ff_mt device-dependent like before. But now sav=
e it in a simple flag,<br>
whether transient registers are available.<br>
</blockquote>
Ok, is it good idea to add the flag to struct mma_chip_info like below?<br>
<br>
=C2=A0 * @mma_scales:=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 scale factors for converting<br>
register values<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0to m/s^2; 3 modes: 2g, 4g, 8g; 2 inte=
gers<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0per mode: m/s^2 and micro m/s^2<br>
+ * @transient_supported:=C2=A0 =C2=A0 =C2=A0 =C2=A0flag indicating whether=
 chip support transient<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0event, as not all chips support transient=
 event<br>
=C2=A0 */<br>
=C2=A0struct mma_chip_info {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 u8 chip_id;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct iio_chan_spec *channels;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int num_channels;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const int mma_scales[3][2];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool transient_supported;<br>
=C2=A0};<br>
<br>
</blockquote>
<br></span>
I&#39;d avoid boolean and use int and define EVENT_TYPE_TRANSIENT BIT(1) an=
d<br>
EVENT_TYPE_FF_MT BIT(0) for example. So something like &quot;supported_even=
t_types&quot;<br>
can have all types supported.<br>
<br>
But this has quite some implications on your implementation, so your comple=
te<br>
solution would be more interesting to see. Keep it simple and focus on only=
 this one<br>
issue of enabling freefall (FF_MT registers) for the devices that currently=
 use<br>
transient registers.<br>
<br>
thanks<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
If falling: switch to ff_mt in any case. (fixing freefall for the transient=
-devices)<br>
</blockquote>
ok sure.<br>
<br>
Thanks,<br>
<br>
Hari<br>
<br>
On 08/21/2017 04:47 AM, Martin Kepplinger wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
If rising: use transient OR ff_mt device-dependent like before. But now sav=
e it in a simple flag,<br>
whether transient registers are available.<br>
<br>
If falling: switch to ff_mt in any case. (fixing freefall for the transient=
-devices)<br>
</blockquote></blockquote>
<br>
</div></div></blockquote></div><br></div>

--001a114675aac1a68d055776bba4--
