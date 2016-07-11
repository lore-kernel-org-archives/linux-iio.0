Return-Path: <capellamicro@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKv63uvgCayndcK-uF69Uy4wvud5V06HEh3DP-J-LYnWL3y1sg@mail.gmail.com>
References: <dc764217a7c6265d30a588e966f4b133@doppler.thel33t.co.uk>
 <c0d19ba9-4c6f-5728-7528-75c27f2f8047@kernel.org> <aa60431d268e961e1d0eb6cb589cf443@doppler.thel33t.co.uk>
 <CAKv63uvgCayndcK-uF69Uy4wvud5V06HEh3DP-J-LYnWL3y1sg@mail.gmail.com>
From: "K. T." <capellamicro@gmail.com>
Date: Mon, 11 Jul 2016 12:32:04 -0700
Message-ID: <CAHvdCWgdgGT4kHKsaUeRxPV_ae5HrzToLuJn1ax7AysbN8wQqQ@mail.gmail.com>
Subject: Re: Some advice required for IIO driver (cm3218)
To: Crt Mori <cmo@melexis.com>
Cc: Leigh Brown <leigh@solinno.co.uk>, Jonathan Cameron <jic23@kernel.org>,
	Kevin Tsai <ktsai@capellamicro.com>, Linux Iio <linux-iio@vger.kernel.org>
Content-Type: multipart/alternative; boundary=94eb2c11f1340b53ac0537613521
List-ID: <linux-iio@vger.kernel.org>

--94eb2c11f1340b53ac0537613521
Content-Type: text/plain; charset=UTF-8

Hi Leigh,

Thanks for helping CM3218 driver.  Sorry that my ASUS T100 is somewhere.  I
will try to do my best to help.  Please see the inline.

Kevin Tsai

On Mon, Jul 11, 2016 at 1:30 AM, Crt Mori <cmo@melexis.com> wrote:

> Hi Leigh,
> Short comments inline (from what I am certain).
>
> Best regards,
> Crt
>
> On 11 July 2016 at 10:17, Leigh Brown <leigh@solinno.co.uk> wrote:
> > Hi Jonathan,
> >
> > Thanks very much for replying to my email, I appreciate it is probably
> > annoying having to
> > repeat yourself to every newcomer.
> >
> > On 2016-07-10 16:17, Jonathan Cameron wrote:
> >>
> >> On 05/07/16 22:23, Leigh Brown wrote:
> >>>
> >>> Hi Guys,
> >>>
> >>> I just bought an Asus T100 transformer which has a cm3218 ALS and I'm
> >>> keen to get it working.
> >>
> >> Cool.
> >>>
> >>> I've seen two drivers hanging around:
> >>>
> >>> 1.
> >>>
> https://github.com/jfwells/linux-asus-t100ta/blob/master/cm3218_ambient_light_sensor_driver/cm3218.c
> >>>
> >>> 2. http://marc.info/?l=linux-iio&m=146038141909068&w=2
> >>
> >> Would be interesting if you could provide a few details on where these
> >> two drivers are less than ideal.  Useful info to have when considering a
> >> 3rd option ;)
> >>
> >> Also, ideally talk to Kevin to find out what the status of updates to
> the
> >> above so you
> >> can both avoid duplicating effort.
> >
> >
> > Thanks, I will (Hi Kevin :-) )  My main problem with Kevin's driver is
> there
> > is a whole load of
> > IRQ handling and threshold maintenance that doesn't actually do anything.
>

You can use I2C protocol to access CM3218 registers.  However, you have to
use SMB protocol to read Alert Response Address (ARA) to clean interrupt.
However, ARA is a sharing address.  It's possible to get respond from other
devices.  Jonathan and other guys had discussion for this topic years ago.
That's why I didn't update it.


> > Plus, the processed
> > value is wrong (certainly when I have compared output with my android
> > phone).
> >
>

The driver is the old version without ACPI support.  ASUS T100 has ACPI
table
for lens factor.  Let me find whether I have newer driver.


> >>> Neither worked really well so in the spirit of things I've created a
> >>> third driver which I'm
> >>> hoping to get into a state worth submitting (famous last words).  It's
> >>> not ready for review
> >>> yet (I've pasted it below for anyone who is interested) but I have a
> >>> couple of questions  and
> >>> I would be really grateful if someone could assist.
> >>>
> >>> Q1. What do IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_CALIBSCALE mean?
> >>>
> >>> This is slightly embarrassing, but I can't really figure out what they
> >>> mean. I'd appreciate it
> >>> if someone could supply a simple definition in relation to this driver.
> >>
> >> IIO_CHAN_INFO_SCALE is a scaling factor that is applied to
> >> IIO_CHAN_INFO_RAW
> >> output data in userspace as a linear scaling.  Basic rule of thumb is
> that
> >> if
> >> we can describe the conversion from raw data to our 'base units', here
> >> illuminance
> >> we leave it up to userspace to do the maths rather than doing it in
> >> kernel.
> >> If writable it is controlling the scaling of data coming of the ADC.
> >> Clearly
> >> we have no way of knowing if this is due to changes in say the ADC
> >> reference
> >> or due to analog front end changes.
> >
> >
> > Just to clarify, in this case the relationship between the raw sensor
> value
> > and the result in
> > Lux *is* linear, so the driver should *not* provide the processed output,
> > but instead provide
> > the raw output and the scale?  Even though providing the processed
> output is
> > pretty simple?
> It might be simple in your case, but what if there was a need for
> floating point calculations, etc.?
> >
> > Conversely, if it were *not* linear then you would not provide a scale
> > attribute and instead
> > just provide processed output?
> Correct.
> >
> >
> >> IIO_CHAN_INFO_CALIBSCALE is a scaling typically applied as an electrical
> >> gain
> >> inside the device as a form of 'trim'. It's about calibrating out part
> to
> >> part variation.
> >>
> >> The key thing is that it needs to look like this is hardware trim to
> >> userspace,
> >> but it isn't necessarily an actual hardware applied gain.  In the
> >> case of light sensors, the conversion from the raw ADC value to
> >> illuminance in lux
> >> is often non linear (and can involve several input sensors).  Thus we
> >> often have
> >> to provide an IIO_CHAN_INFO_PROCESSED output where the maths has
> >> already been done
> >> (it's too complex to sensibly describe to userspace).  In this
> >> circumstance if
> >> the device has registers to tell the software what it's calibration gain
> >> is
> >> (from factory calibration) but that is not applied in hardware
> >> IIO_CHAN_INFO_CALIBSCALE may be used to control a scaling value
> >> which might as well be implemented in hardware as it is always applied
> >> before
> >> userspace sees it.
> >>
> >> So as you may have noticed there is sometimes a bit of a gray area when
> >> the
> >> calibscale is being used for things that aren't actually controlling
> >> hardware
> >> amplifiers.
> >>
> >>> Q2. What's the best unit to return the processed ambient light sensor
> >>> value?
> >>>
> >>> My first choice would be in milliLux,
> >>
> >> lux as per Documentation/ABI/testing/sysfs-bus-iio
> >> is where you need to end up, but it is up to you whether you output in
> >> millilux as IIO_CHAN_INFO_RAW and provide a scale of 0.001 or output
> >> as IIO_CHAN_INFO_PROCESSED directly in lux.
> >>
> >>> my second would be in Lux using IIO_VAL_INT_PLUS_MICRO.
> >>> The first requires less calculation in the driver, but I'm easy either
> >>> way, as long as the
> >>> value returned has all the significant bits in it.
> >>>
> >>> Q3. The device has a high sensitivity mode (either x1 or x2
> sensitivity).
> >>> I'd like to expose
> >>> that feature in sysfs.  What would be the best description of it?
> >>>
> >>> I would suggest something on the lines of IIO_CHAN_INFO_SENSITIVITY.
> If
> >>> so, would the best
> >>> thing to do be to submit a patch adding that to
> include/linux/iio/iio.h ?
> >>
> >> What does it really correspond to?  I'm guessing integration time...
> >> There
> >> are various ways of getting sensitivity and they have direct effects on
> >> the noise characteristics, so we really want to know what is going on.
> >>
> >> (looking below I see there is a separate integration time control, so we
> >> are talking either an electrical gain (amplifier) or something more
> >> closely related to the diode itself.)
> >> Could do it via scale.
> >>
>

High sensitivity is useful for a dark lens (less than 1% transparent) on
the cover.
But you need to change the integration time to avoid saturated (16-bit).


> >>>
> >>> Q4. Similarly, the device has the ability to specify how many samples
> are
> >>> outside of the
> >>> configured threshold before raising an interrupt.  What would be the
> best
> >>> description of
> >>> this?
> >>>
> >>> I'm thinking something on the lines of IIO_EV_INFO_CYCLE_DELAY or some
> >>> such?  I'm not sure.
> >>
> >>
> >> period.  See the ABI docs.  You'll need to provide it in seconds however
> >> rather
> >> than samples.
> >
> >
> > Okay.  I have a question on this.  If you change the integration time,
> for
> > example, then the
> > period would change (as it is expressed in number of cycles, 1, 2, 4 or
> 8).
> > So if you started
> > with an integration time of 0.2s, and set period to 0.4s (2 cycles), that
> > would be fine.  Then,
> > if you change the integration time to 0.4s, then without changing
> anything
> > else the period
> > would jump to 0.8s.  In addition, the periods available would be
> different
> > depending on the
> > integration time.
> >
> > Is that the behaviour you would expect to see if the period is
> configured in
> > seconds?
> >
>

I think Leigh is talking about the persist mode.  This mode is to avoid
generate
multiple interrupt in a rapid lighting changing environment.  It only
delays the
interrupt happen, sensor still use the integrate time to update the raw
data.


> >>> Q5. The device is very simple and will continue to raise an interrupt
> >>> every sample that is
> >>> outside of the threshold.  To deal with this I have written code to
> >>> change the range to not
> >>> interrupt until the reading returns to within the defined threshold.  I
> >>> was thinking of
> >>> adding a hysteresis value to this.  What would be the preferred unit of
> >>> this?  MilliLux/Lux
> >>> or percent or something else?
> >>
>

Most customers request to trigger interrupt when +/- 5% light change.  So,
when sensor trigger the interrupt, ISR should read the new value and
calculate the hi/lo thresholds. I did try to implement this to ISR.  But,
kernel
people doesn't agree this approach.  Any idea to implement this "percent"
threshold?


> >> Match units with the channel.  Also we already have hysteresis defined
> for
> >> events so use that.
> >
> >
> > Based on your feedback that the driver should not perform the calculation
> > (and rely on the
> > scale attribute to allow userspace to perform the calculation), then it
> > would follow that the
> > upper and lower thresholds would also be exposed in raw values.  Again,
> the
> > issue with that is
> > that the scaling factor changes depending on the configuration
> (integration
> > time and hardware
> > sensitivity).
> >
> > Does that sound reasonable to you?  It would mean that user space would
> have
> > to recalculate the
> > thresholds after every change to the integration time or hardware
> > sensitivity.  Currently my
> > driver is doing that but I suppose the idea is to minimise that kind of
> > thing in the driver?
> >
> >> Sometimes it gets fiddlier on light sensors (though I don't think so
> >> here). Events can
> >> be based on the outputs of one of the multiple diodes whose values are
> >> combined to
> >> calculate an illuminance value.  In those cases we have the unitless
> >> 'intensity'
> >> channel types so that the underlying ADC values can be exposed + the
> >> events that operate
> >> on them.  It's a pain for userspace to interpret this but we haven't yet
> >> come
> >> up with a better way to describe it.
> >>
> >>
> >>>
> >>> Apologies for the dumb questions, but if someone can point me in the
> >>> right direction I'll
> >>> try and get the driver into a good shape over the next week or so.
> >>>
> >>> Regards,
> >>>
> >>> Leigh.
> >
> > [snip driver]
> >
> > Regards,
> >
> > Leigh.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--94eb2c11f1340b53ac0537613521
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Leigh,<div><br></div><div>Thanks for helping CM3218 dri=
ver.=C2=A0 Sorry that my ASUS T100 is somewhere.=C2=A0 I will try to do my =
best to help.=C2=A0 Please see the inline.</div><div><br></div><div>Kevin T=
sai</div><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On =
Mon, Jul 11, 2016 at 1:30 AM, Crt Mori <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:cmo@melexis.com" target=3D"_blank">cmo@melexis.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Hi Leigh,<br>
Short comments inline (from what I am certain).<br>
<br>
Best regards,<br>
Crt<br>
<div><div class=3D"h5"><br>
On 11 July 2016 at 10:17, Leigh Brown &lt;<a href=3D"mailto:leigh@solinno.c=
o.uk">leigh@solinno.co.uk</a>&gt; wrote:<br>
&gt; Hi Jonathan,<br>
&gt;<br>
&gt; Thanks very much for replying to my email, I appreciate it is probably=
<br>
&gt; annoying having to<br>
&gt; repeat yourself to every newcomer.<br>
&gt;<br>
&gt; On 2016-07-10 16:17, Jonathan Cameron wrote:<br>
&gt;&gt;<br>
&gt;&gt; On 05/07/16 22:23, Leigh Brown wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hi Guys,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I just bought an Asus T100 transformer which has a cm3218 ALS =
and I&#39;m<br>
&gt;&gt;&gt; keen to get it working.<br>
&gt;&gt;<br>
&gt;&gt; Cool.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;ve seen two drivers hanging around:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 1.<br>
&gt;&gt;&gt; <a href=3D"https://github.com/jfwells/linux-asus-t100ta/blob/m=
aster/cm3218_ambient_light_sensor_driver/cm3218.c" rel=3D"noreferrer" targe=
t=3D"_blank">https://github.com/jfwells/linux-asus-t100ta/blob/master/cm321=
8_ambient_light_sensor_driver/cm3218.c</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; 2. <a href=3D"http://marc.info/?l=3Dlinux-iio&amp;m=3D14603814=
1909068&amp;w=3D2" rel=3D"noreferrer" target=3D"_blank">http://marc.info/?l=
=3Dlinux-iio&amp;m=3D146038141909068&amp;w=3D2</a><br>
&gt;&gt;<br>
&gt;&gt; Would be interesting if you could provide a few details on where t=
hese<br>
&gt;&gt; two drivers are less than ideal.=C2=A0 Useful info to have when co=
nsidering a<br>
&gt;&gt; 3rd option ;)<br>
&gt;&gt;<br>
&gt;&gt; Also, ideally talk to Kevin to find out what the status of updates=
 to the<br>
&gt;&gt; above so you<br>
&gt;&gt; can both avoid duplicating effort.<br>
&gt;<br>
&gt;<br>
&gt; Thanks, I will (Hi Kevin :-) )=C2=A0 My main problem with Kevin&#39;s =
driver is there<br>
&gt; is a whole load of<br>
&gt; IRQ handling and threshold maintenance that doesn&#39;t actually do an=
ything.<br></div></div></blockquote><div><br></div><div>You can use I2C pro=
tocol to access CM3218 registers.=C2=A0 However, you have to</div><div>use =
SMB protocol to read Alert Response Address (ARA) to clean interrupt.<br></=
div><div>However, ARA is a sharing address.=C2=A0 It&#39;s possible to get =
respond from other</div><div>devices.=C2=A0 Jonathan and other guys had dis=
cussion for this topic years ago.</div><div>That&#39;s why I didn&#39;t upd=
ate it. =C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><d=
iv class=3D"h5">
&gt; Plus, the processed<br>
&gt; value is wrong (certainly when I have compared output with my android<=
br>
&gt; phone).<br>
&gt;<br></div></div></blockquote><div><br></div><div>The driver is the old =
version without ACPI support.=C2=A0 ASUS T100 has ACPI table</div><div>for =
lens factor.=C2=A0 Let me find whether I have newer driver.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div><div class=3D"h5">
&gt;&gt;&gt; Neither worked really well so in the spirit of things I&#39;ve=
 created a<br>
&gt;&gt;&gt; third driver which I&#39;m<br>
&gt;&gt;&gt; hoping to get into a state worth submitting (famous last words=
).=C2=A0 It&#39;s<br>
&gt;&gt;&gt; not ready for review<br>
&gt;&gt;&gt; yet (I&#39;ve pasted it below for anyone who is interested) bu=
t I have a<br>
&gt;&gt;&gt; couple of questions=C2=A0 and<br>
&gt;&gt;&gt; I would be really grateful if someone could assist.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Q1. What do IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_CALIBSCALE m=
ean?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This is slightly embarrassing, but I can&#39;t really figure o=
ut what they<br>
&gt;&gt;&gt; mean. I&#39;d appreciate it<br>
&gt;&gt;&gt; if someone could supply a simple definition in relation to thi=
s driver.<br>
&gt;&gt;<br>
&gt;&gt; IIO_CHAN_INFO_SCALE is a scaling factor that is applied to<br>
&gt;&gt; IIO_CHAN_INFO_RAW<br>
&gt;&gt; output data in userspace as a linear scaling.=C2=A0 Basic rule of =
thumb is that<br>
&gt;&gt; if<br>
&gt;&gt; we can describe the conversion from raw data to our &#39;base unit=
s&#39;, here<br>
&gt;&gt; illuminance<br>
&gt;&gt; we leave it up to userspace to do the maths rather than doing it i=
n<br>
&gt;&gt; kernel.<br>
&gt;&gt; If writable it is controlling the scaling of data coming of the AD=
C.<br>
&gt;&gt; Clearly<br>
&gt;&gt; we have no way of knowing if this is due to changes in say the ADC=
<br>
&gt;&gt; reference<br>
&gt;&gt; or due to analog front end changes.<br>
&gt;<br>
&gt;<br>
&gt; Just to clarify, in this case the relationship between the raw sensor =
value<br>
&gt; and the result in<br>
&gt; Lux *is* linear, so the driver should *not* provide the processed outp=
ut,<br>
&gt; but instead provide<br>
&gt; the raw output and the scale?=C2=A0 Even though providing the processe=
d output is<br>
&gt; pretty simple?<br>
</div></div>It might be simple in your case, but what if there was a need f=
or<br>
floating point calculations, etc.?<br>
<span class=3D"">&gt;<br>
&gt; Conversely, if it were *not* linear then you would not provide a scale=
<br>
&gt; attribute and instead<br>
&gt; just provide processed output?<br>
</span>Correct.<br>
<div class=3D"HOEnZb"><div class=3D"h5">&gt;<br>
&gt;<br>
&gt;&gt; IIO_CHAN_INFO_CALIBSCALE is a scaling typically applied as an elec=
trical<br>
&gt;&gt; gain<br>
&gt;&gt; inside the device as a form of &#39;trim&#39;. It&#39;s about cali=
brating out part to<br>
&gt;&gt; part variation.<br>
&gt;&gt;<br>
&gt;&gt; The key thing is that it needs to look like this is hardware trim =
to<br>
&gt;&gt; userspace,<br>
&gt;&gt; but it isn&#39;t necessarily an actual hardware applied gain.=C2=
=A0 In the<br>
&gt;&gt; case of light sensors, the conversion from the raw ADC value to<br=
>
&gt;&gt; illuminance in lux<br>
&gt;&gt; is often non linear (and can involve several input sensors).=C2=A0=
 Thus we<br>
&gt;&gt; often have<br>
&gt;&gt; to provide an IIO_CHAN_INFO_PROCESSED output where the maths has<b=
r>
&gt;&gt; already been done<br>
&gt;&gt; (it&#39;s too complex to sensibly describe to userspace).=C2=A0 In=
 this<br>
&gt;&gt; circumstance if<br>
&gt;&gt; the device has registers to tell the software what it&#39;s calibr=
ation gain<br>
&gt;&gt; is<br>
&gt;&gt; (from factory calibration) but that is not applied in hardware<br>
&gt;&gt; IIO_CHAN_INFO_CALIBSCALE may be used to control a scaling value<br=
>
&gt;&gt; which might as well be implemented in hardware as it is always app=
lied<br>
&gt;&gt; before<br>
&gt;&gt; userspace sees it.<br>
&gt;&gt;<br>
&gt;&gt; So as you may have noticed there is sometimes a bit of a gray area=
 when<br>
&gt;&gt; the<br>
&gt;&gt; calibscale is being used for things that aren&#39;t actually contr=
olling<br>
&gt;&gt; hardware<br>
&gt;&gt; amplifiers.<br>
&gt;&gt;<br>
&gt;&gt;&gt; Q2. What&#39;s the best unit to return the processed ambient l=
ight sensor<br>
&gt;&gt;&gt; value?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; My first choice would be in milliLux,<br>
&gt;&gt;<br>
&gt;&gt; lux as per Documentation/ABI/testing/sysfs-bus-iio<br>
&gt;&gt; is where you need to end up, but it is up to you whether you outpu=
t in<br>
&gt;&gt; millilux as IIO_CHAN_INFO_RAW and provide a scale of 0.001 or outp=
ut<br>
&gt;&gt; as IIO_CHAN_INFO_PROCESSED directly in lux.<br>
&gt;&gt;<br>
&gt;&gt;&gt; my second would be in Lux using IIO_VAL_INT_PLUS_MICRO.<br>
&gt;&gt;&gt; The first requires less calculation in the driver, but I&#39;m=
 easy either<br>
&gt;&gt;&gt; way, as long as the<br>
&gt;&gt;&gt; value returned has all the significant bits in it.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Q3. The device has a high sensitivity mode (either x1 or x2 se=
nsitivity).<br>
&gt;&gt;&gt; I&#39;d like to expose<br>
&gt;&gt;&gt; that feature in sysfs.=C2=A0 What would be the best descriptio=
n of it?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I would suggest something on the lines of IIO_CHAN_INFO_SENSIT=
IVITY.=C2=A0 If<br>
&gt;&gt;&gt; so, would the best<br>
&gt;&gt;&gt; thing to do be to submit a patch adding that to include/linux/=
iio/iio.h ?<br>
&gt;&gt;<br>
&gt;&gt; What does it really correspond to?=C2=A0 I&#39;m guessing integrat=
ion time...<br>
&gt;&gt; There<br>
&gt;&gt; are various ways of getting sensitivity and they have direct effec=
ts on<br>
&gt;&gt; the noise characteristics, so we really want to know what is going=
 on.<br>
&gt;&gt;<br>
&gt;&gt; (looking below I see there is a separate integration time control,=
 so we<br>
&gt;&gt; are talking either an electrical gain (amplifier) or something mor=
e<br>
&gt;&gt; closely related to the diode itself.)<br>
&gt;&gt; Could do it via scale.<br>
&gt;&gt;<br></div></div></blockquote><div><br></div><div>High sensitivity i=
s useful for a dark lens (less than 1% transparent) on the cover.</div><div=
>But you need to change the integration time to avoid saturated (16-bit).</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><=
div class=3D"h5">
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Q4. Similarly, the device has the ability to specify how many =
samples are<br>
&gt;&gt;&gt; outside of the<br>
&gt;&gt;&gt; configured threshold before raising an interrupt.=C2=A0 What w=
ould be the best<br>
&gt;&gt;&gt; description of<br>
&gt;&gt;&gt; this?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;m thinking something on the lines of IIO_EV_INFO_CYCLE_D=
ELAY or some<br>
&gt;&gt;&gt; such?=C2=A0 I&#39;m not sure.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; period.=C2=A0 See the ABI docs.=C2=A0 You&#39;ll need to provide i=
t in seconds however<br>
&gt;&gt; rather<br>
&gt;&gt; than samples.<br>
&gt;<br>
&gt;<br>
&gt; Okay.=C2=A0 I have a question on this.=C2=A0 If you change the integra=
tion time, for<br>
&gt; example, then the<br>
&gt; period would change (as it is expressed in number of cycles, 1, 2, 4 o=
r 8).<br>
&gt; So if you started<br>
&gt; with an integration time of 0.2s, and set period to 0.4s (2 cycles), t=
hat<br>
&gt; would be fine.=C2=A0 Then,<br>
&gt; if you change the integration time to 0.4s, then without changing anyt=
hing<br>
&gt; else the period<br>
&gt; would jump to 0.8s.=C2=A0 In addition, the periods available would be =
different<br>
&gt; depending on the<br>
&gt; integration time.<br>
&gt;<br>
&gt; Is that the behaviour you would expect to see if the period is configu=
red in<br>
&gt; seconds?<br>
&gt;<br></div></div></blockquote><div><br></div><div>I think Leigh is talki=
ng about the persist mode.=C2=A0 This mode is to avoid generate</div><div>m=
ultiple interrupt in a rapid lighting changing environment.=C2=A0 It only d=
elays the</div><div>interrupt happen, sensor still use the integrate time t=
o update the raw data.=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><div class=3D"HOEnZb"><div class=3D"h5">
&gt;&gt;&gt; Q5. The device is very simple and will continue to raise an in=
terrupt<br>
&gt;&gt;&gt; every sample that is<br>
&gt;&gt;&gt; outside of the threshold.=C2=A0 To deal with this I have writt=
en code to<br>
&gt;&gt;&gt; change the range to not<br>
&gt;&gt;&gt; interrupt until the reading returns to within the defined thre=
shold.=C2=A0 I<br>
&gt;&gt;&gt; was thinking of<br>
&gt;&gt;&gt; adding a hysteresis value to this.=C2=A0 What would be the pre=
ferred unit of<br>
&gt;&gt;&gt; this?=C2=A0 MilliLux/Lux<br>
&gt;&gt;&gt; or percent or something else?<br>
&gt;&gt;<br></div></div></blockquote><div><br></div><div>Most customers req=
uest to trigger interrupt when +/- 5% light change.=C2=A0 So,</div><div>whe=
n sensor trigger the interrupt, ISR should read the new value and</div><div=
>calculate the hi/lo thresholds. I did try to implement this to ISR.=C2=A0 =
But, kernel</div><div>people doesn&#39;t agree this approach.=C2=A0 Any ide=
a to implement this &quot;percent&quot;</div><div>threshold?</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D=
"h5">
&gt;&gt; Match units with the channel.=C2=A0 Also we already have hysteresi=
s defined for<br>
&gt;&gt; events so use that.<br>
&gt;<br>
&gt;<br>
&gt; Based on your feedback that the driver should not perform the calculat=
ion<br>
&gt; (and rely on the<br>
&gt; scale attribute to allow userspace to perform the calculation), then i=
t<br>
&gt; would follow that the<br>
&gt; upper and lower thresholds would also be exposed in raw values.=C2=A0 =
Again, the<br>
&gt; issue with that is<br>
&gt; that the scaling factor changes depending on the configuration (integr=
ation<br>
&gt; time and hardware<br>
&gt; sensitivity).<br>
&gt;<br>
&gt; Does that sound reasonable to you?=C2=A0 It would mean that user space=
 would have<br>
&gt; to recalculate the<br>
&gt; thresholds after every change to the integration time or hardware<br>
&gt; sensitivity.=C2=A0 Currently my<br>
&gt; driver is doing that but I suppose the idea is to minimise that kind o=
f<br>
&gt; thing in the driver?<br>
&gt;<br>
&gt;&gt; Sometimes it gets fiddlier on light sensors (though I don&#39;t th=
ink so<br>
&gt;&gt; here). Events can<br>
&gt;&gt; be based on the outputs of one of the multiple diodes whose values=
 are<br>
&gt;&gt; combined to<br>
&gt;&gt; calculate an illuminance value.=C2=A0 In those cases we have the u=
nitless<br>
&gt;&gt; &#39;intensity&#39;<br>
&gt;&gt; channel types so that the underlying ADC values can be exposed + t=
he<br>
&gt;&gt; events that operate<br>
&gt;&gt; on them.=C2=A0 It&#39;s a pain for userspace to interpret this but=
 we haven&#39;t yet<br>
&gt;&gt; come<br>
&gt;&gt; up with a better way to describe it.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Apologies for the dumb questions, but if someone can point me =
in the<br>
&gt;&gt;&gt; right direction I&#39;ll<br>
&gt;&gt;&gt; try and get the driver into a good shape over the next week or=
 so.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Leigh.<br>
&gt;<br>
&gt; [snip driver]<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; Leigh.<br>
&gt;<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-i=
io&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/m=
ajordomo-info.html</a><br>
</font></span></blockquote></div><br></div></div></div>

--94eb2c11f1340b53ac0537613521--
