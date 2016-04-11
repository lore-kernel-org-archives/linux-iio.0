Return-Path: <mtitinger@baylibre.com>
MIME-Version: 1.0
In-Reply-To: <20160411180839.GA10942@roeck-us.net>
References: <1460139580-11865-1-git-send-email-afd@ti.com>
	<570A3FB2.7000600@kernel.org>
	<570BC74B.3000208@ti.com>
	<20160411163843.GA27218@roeck-us.net>
	<570BD530.8060508@ti.com>
	<20160411180839.GA10942@roeck-us.net>
Date: Tue, 12 Apr 2016 00:56:19 +0200
Message-ID: <CAHxRqk8aUGFLFcPB_GMjDUeqrp_85i7NF7i3f=oXtUCEyrMWcw@mail.gmail.com>
Subject: Re: [PATCH 1/1] iio: adc: Add driver for the TI INA3221 Triple
 Current/Voltage Monitor
From: Marc Titinger <mtitinger@baylibre.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, "Andrew F. Davis" <afd@ti.com>,
	linux-hwmon@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7b33dd8cec1a6305303d730c
List-ID: <linux-iio@vger.kernel.org>

--047d7b33dd8cec1a6305303d730c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le 11 avr. 2016 8:08 PM, "Guenter Roeck" <linux@roeck-us.net> a =C3=A9crit =
:
>
> On Mon, Apr 11, 2016 at 11:47:44AM -0500, Andrew F. Davis wrote:
> > On 04/11/2016 11:38 AM, Guenter Roeck wrote:
> > > On Mon, Apr 11, 2016 at 10:48:27AM -0500, Andrew F. Davis wrote:
> > >> On 04/10/2016 06:57 AM, Jonathan Cameron wrote:
> > >>> On 08/04/16 19:19, Andrew F. Davis wrote:
> > >>>> The INA3221 is a three-channel, high-side current and bus voltage
monitor
> > >>>> with an I2C and SMBUS compatible interface.
> > >>>>
> > >>>> Signed-off-by: Andrew F. Davis <afd@ti.com>
> > >>> Hi Andrew,
> > >>>
> > >>> My immediate thought on this one is whether it would be better off
in hwmon.
> > >>> I'm not convinced either way from a quick glance at the data sheet,
but the
> > >>> question needs to be addressed.
> > >>>
> > >>
> > >> I was on the fence with this also, I was leaning towards hwmod until
I
> > >> looked onto how the ina2xx driver has been ported to iio. This is
almost
> > >> the same part but the ina3x has three monitors vs one. In addition i=
t
> > >> looks like NVIDIA has written a hwmod driver for this part
> > >> (
https://github.com/Bogdacutu/STLinux-Kernel/blob/master/drivers/hwmon/ina32=
21.c
)
> > >> but then also ported it over to IIO (although doesn't appear to be
> > >> upstream ready or ever has been submitted for such)
> > >> (
https://github.com/SuperPichu/shield-tablet-kernel/blob/master/drivers/stag=
ing/iio/meter/ina3221.c
)
> > >> So I figured this was the way things are moving, but I have no
problem
> > >> working this as a hwmod driver. The IIO work is already done here,
I'll
> > >> write the hwmod version also but keep working this, I see no reason
we
> > >> cant have both if needed. (unless using this and just using
iio_hwmod.c
> > >> if needed is more acceptable?)
> > >>
> > >
> > > You can not have both since they would conflict with each other.
> > > ina2xx has possibly created a bad precedent. I am not inclined to
accept
> > > a hwmon driver if an iio driver already exists. If you want an iio
driver,
> > > fine with me, but then you (and its users) will have to live with its
> > > limitations when it comes to hardware monitoring.
> > >
> >
> > Hmm, my plan was an MFD device core, that then could mediate the two
> > sub-drivers, but I'm not sure about this yet.
> >
> mfd is intended to separate multi-function devices, not multiple
> linux subsystems accessing the same logical functionality in a chip just
> because the subsystems don't have a means to communicate with each other.
> I don't think using mfd for this purpose is a good idea; someone would
> have to work hard to convince me that it is.
>
> > > I don't really mind if things are going all towards iio if that is
where
> > > the community wants to go. However, if that is the case, I would
suggest
> > > that someone should spend the time to define a clear sense of 'limits=
'
> > > as well as alert handling in iio, in a way that is exportable to othe=
r
> > > subsystems (hwmon and thermal come into mind).
> > >
> >
> > I agree. I think both frameworks offer useful interfaces, so I would
> > hate to limit users to one, but for now I'll just post the hwmon versio=
n
> > here in a bit and live with that until someone requests the IIO support=
.
> >
> Ultimately it might make sense to create a hwmon->iio bridge in the hwmon
> core (just like it would make sense to create a hwmon->thermal bridge).
> This way drivers could be implemented whereever it is more convenient,
> and where the primary use case fits best. The basic idea would be for a
> hwmon driver to register with a flag such as "register with the iio
> subsystem as well".
>
> However, that would require substantial structural changes (or call it
> modernization) of the hwmon driver core API. Unfortunately, that is
unlikely
> to happen anytime soon - I don't have the time, and no one else seems to
> show much interest in hwmon lately. So instead of doing that, people end
up
> writing drivers for the same chip in multiple subsystems, and end up with
> limitations one way or another. ina2xx is a perfect example.

Neither versions of the ina2xx support threshold/alert yet so it is not
really a limitation trade-off that motivates the coexistence of both
drivers but the respective userland ecosystem over IIO or hwmon that have
unique features and use cases. IMHO it would make more sense to put effort
in merging into a common driver/lib with a united capability set rather
than bridging, since it is mostly about keeping things tidy.

BR,
Marc

>
> Guenter

--047d7b33dd8cec1a6305303d730c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
Le=C2=A011 avr. 2016 8:08 PM, &quot;Guenter Roeck&quot; &lt;<a href=3D"mail=
to:linux@roeck-us.net">linux@roeck-us.net</a>&gt; a =C3=A9crit=C2=A0:<br>
&gt;<br>
&gt; On Mon, Apr 11, 2016 at 11:47:44AM -0500, Andrew F. Davis wrote:<br>
&gt; &gt; On 04/11/2016 11:38 AM, Guenter Roeck wrote:<br>
&gt; &gt; &gt; On Mon, Apr 11, 2016 at 10:48:27AM -0500, Andrew F. Davis wr=
ote:<br>
&gt; &gt; &gt;&gt; On 04/10/2016 06:57 AM, Jonathan Cameron wrote:<br>
&gt; &gt; &gt;&gt;&gt; On 08/04/16 19:19, Andrew F. Davis wrote:<br>
&gt; &gt; &gt;&gt;&gt;&gt; The INA3221 is a three-channel, high-side curren=
t and bus voltage monitor<br>
&gt; &gt; &gt;&gt;&gt;&gt; with an I2C and SMBUS compatible interface.<br>
&gt; &gt; &gt;&gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt;&gt; Signed-off-by: Andrew F. Davis &lt;<a href=3D"ma=
ilto:afd@ti.com">afd@ti.com</a>&gt;<br>
&gt; &gt; &gt;&gt;&gt; Hi Andrew,<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;&gt; My immediate thought on this one is whether it would=
 be better off in hwmon.<br>
&gt; &gt; &gt;&gt;&gt; I&#39;m not convinced either way from a quick glance=
 at the data sheet, but the<br>
&gt; &gt; &gt;&gt;&gt; question needs to be addressed.<br>
&gt; &gt; &gt;&gt;&gt;<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; I was on the fence with this also, I was leaning towards=
 hwmod until I<br>
&gt; &gt; &gt;&gt; looked onto how the ina2xx driver has been ported to iio=
. This is almost<br>
&gt; &gt; &gt;&gt; the same part but the ina3x has three monitors vs one. I=
n addition it<br>
&gt; &gt; &gt;&gt; looks like NVIDIA has written a hwmod driver for this pa=
rt<br>
&gt; &gt; &gt;&gt; (<a href=3D"https://github.com/Bogdacutu/STLinux-Kernel/=
blob/master/drivers/hwmon/ina3221.c">https://github.com/Bogdacutu/STLinux-K=
ernel/blob/master/drivers/hwmon/ina3221.c</a>)<br>
&gt; &gt; &gt;&gt; but then also ported it over to IIO (although doesn&#39;=
t appear to be<br>
&gt; &gt; &gt;&gt; upstream ready or ever has been submitted for such)<br>
&gt; &gt; &gt;&gt; (<a href=3D"https://github.com/SuperPichu/shield-tablet-=
kernel/blob/master/drivers/staging/iio/meter/ina3221.c">https://github.com/=
SuperPichu/shield-tablet-kernel/blob/master/drivers/staging/iio/meter/ina32=
21.c</a>)<br>
&gt; &gt; &gt;&gt; So I figured this was the way things are moving, but I h=
ave no problem<br>
&gt; &gt; &gt;&gt; working this as a hwmod driver. The IIO work is already =
done here, I&#39;ll<br>
&gt; &gt; &gt;&gt; write the hwmod version also but keep working this, I se=
e no reason we<br>
&gt; &gt; &gt;&gt; cant have both if needed. (unless using this and just us=
ing iio_hwmod.c<br>
&gt; &gt; &gt;&gt; if needed is more acceptable?)<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; You can not have both since they would conflict with each ot=
her.<br>
&gt; &gt; &gt; ina2xx has possibly created a bad precedent. I am not inclin=
ed to accept<br>
&gt; &gt; &gt; a hwmon driver if an iio driver already exists. If you want =
an iio driver,<br>
&gt; &gt; &gt; fine with me, but then you (and its users) will have to live=
 with its<br>
&gt; &gt; &gt; limitations when it comes to hardware monitoring.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; Hmm, my plan was an MFD device core, that then could mediate the =
two<br>
&gt; &gt; sub-drivers, but I&#39;m not sure about this yet.<br>
&gt; &gt;<br>
&gt; mfd is intended to separate multi-function devices, not multiple<br>
&gt; linux subsystems accessing the same logical functionality in a chip ju=
st<br>
&gt; because the subsystems don&#39;t have a means to communicate with each=
 other.<br>
&gt; I don&#39;t think using mfd for this purpose is a good idea; someone w=
ould<br>
&gt; have to work hard to convince me that it is.<br>
&gt;<br>
&gt; &gt; &gt; I don&#39;t really mind if things are going all towards iio =
if that is where<br>
&gt; &gt; &gt; the community wants to go. However, if that is the case, I w=
ould suggest<br>
&gt; &gt; &gt; that someone should spend the time to define a clear sense o=
f &#39;limits&#39;<br>
&gt; &gt; &gt; as well as alert handling in iio, in a way that is exportabl=
e to other<br>
&gt; &gt; &gt; subsystems (hwmon and thermal come into mind).<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I agree. I think both frameworks offer useful interfaces, so I wo=
uld<br>
&gt; &gt; hate to limit users to one, but for now I&#39;ll just post the hw=
mon version<br>
&gt; &gt; here in a bit and live with that until someone requests the IIO s=
upport.<br>
&gt; &gt;<br>
&gt; Ultimately it might make sense to create a hwmon-&gt;iio bridge in the=
 hwmon<br>
&gt; core (just like it would make sense to create a hwmon-&gt;thermal brid=
ge).<br>
&gt; This way drivers could be implemented whereever it is more convenient,=
<br>
&gt; and where the primary use case fits best. The basic idea would be for =
a<br>
&gt; hwmon driver to register with a flag such as &quot;register with the i=
io<br>
&gt; subsystem as well&quot;.<br>
&gt;<br>
&gt; However, that would require substantial structural changes (or call it=
<br>
&gt; modernization) of the hwmon driver core API. Unfortunately, that is un=
likely<br>
&gt; to happen anytime soon - I don&#39;t have the time, and no one else se=
ems to<br>
&gt; show much interest in hwmon lately. So instead of doing that, people e=
nd up<br>
&gt; writing drivers for the same chip in multiple subsystems, and end up w=
ith<br>
&gt; limitations one way or another. ina2xx is a perfect example.</p>
<p dir=3D"ltr">Neither versions of the ina2xx support threshold/alert yet s=
o it is not really a limitation trade-off that motivates the coexistence of=
 both drivers but the respective userland ecosystem over IIO or hwmon that =
have unique features and use cases. IMHO it would make more sense to put ef=
fort in merging into a common driver/lib with a united capability set rathe=
r than bridging, since it is mostly about keeping things tidy. </p>
<p dir=3D"ltr">BR, <br>
Marc <br></p>
<p dir=3D"ltr">&gt;<br>
&gt; Guenter<br>
</p>

--047d7b33dd8cec1a6305303d730c--
