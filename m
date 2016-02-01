Return-Path: <klock.android@gmail.com>
MIME-Version: 1.0
In-Reply-To: <E1aPoxA-0000TS-KM@stardust.g4.wien.funkfeuer.at>
References: <1453934762-6290-1-git-send-email-klock.android@gmail.com>
	<56ACF7E4.7040603@kernel.org>
	<E1aPavY-0000Rc-Gk@stardust.g4.wien.funkfeuer.at>
	<CALiE4M3BGE=_jWJu+s1SgDEfHD0r1md8yRjXFsRmNoL_Ta4HbA@mail.gmail.com>
	<E1aPoxA-0000TS-KM@stardust.g4.wien.funkfeuer.at>
Date: Mon, 1 Feb 2016 00:15:34 -0500
Message-ID: <CALiE4M3mXx5JMwk7OfuH7G9aGO2mp7_SrvkkoBLa20v4+osn6A@mail.gmail.com>
Subject: Re: [PATCH] iio: dht11: Use boottime
From: Abhilash Jindal <klock.android@gmail.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Content-Type: multipart/alternative; boundary=001a1141d0e27efcf5052aae79da
List-ID: <linux-iio@vger.kernel.org>

--001a1141d0e27efcf5052aae79da
Content-Type: text/plain; charset=UTF-8

Great, thanks.

Best,
Abhilash

On Sun, Jan 31, 2016 at 5:09 AM, Harald Geyer <harald@ccbib.org> wrote:

> Abhilash Jindal writes:
> > Thanks Harald and Jonathan.
> >
> > I would absolutely love to know the symptoms of the odd issue you
> mentioned.
>
> Sure. What I was seeing was a number of zero humidity, zero temperature
> values reported for some time after boot. Then the sensors started to work
> normally.
>
> Given that "all transmission bits zero" passes the checksum test, I thought
> that maybe there is some ressource conflict of the irq line causing
> edges to come in at way too fast pace. However the bug you found explains
> it neatly if we assume that the system clock is set after probe() but
> before
> the sensor is read for the first time and the zeros I saw in the log were
> actually uninitialized memory.
>
> Maybe setting
> dht11->timestamp = ktime_get_real_ns() - DHT11_DATA_VALID_TIME - 1;
> in probe() wasn't such a good idea.
> dht11->timestamp = -1;
> probably would have been more robust. But of course your patch is fixing
> the true problem.
>
> best regards,
> Harald
>
> > Cheers,
> > Abhilash
> >
> > On Sat, Jan 30, 2016 at 2:11 PM, Harald Geyer <harald@ccbib.org> wrote:
> >
> > > Jonathan Cameron writes:
> > > > On 27/01/16 22:46, Abhilash Jindal wrote:
> > > > > Wall time obtained from ktime_get_real_ns is susceptible to sudden
> > > jumps due to
> > > > > user setting the time or due to NTP.  Boot time is constantly
> > > increasing time
> > > > > better suited for comparing two timestamps.
> > > > >
> > > > > Signed-off-by: Abhilash Jindal <klock.android@gmail.com>
> > > > Seems sensible to me, but would like Richard / Harald to take a quick
> > > > look before I apply it.
> > >
> > > Reviewed-by: Harald Geyer <harald@ccbib.org>
> > >
> > > I can't test this right now, but I think it will fix an odd issue I
> > > have seen in a log file (apparently was completely off track debugging
> it).
> > > As this very likely is a real world issue, I'd recommend applying the
> patch
> > > to the fixes branch, so that it hopefully gets picked up for LTS
> kernels.
> > >
> > > I used ktime_get_real_ns() because that is what iio_get_time_ns() uses.
> > > I should have thought about this twice - sorry about being sloppy!
> > >
> > > I just grepped the other iio drivers and none is using
> iio_get_time_ns() in
> > > a comparision like dht11 did, so maybe the other uses are safe. However
> > > I couldn't check variables containing timestamps that way, so maybe
> > > reviewing the users of iio_get_time_ns(), whether wall time is actually
> > > what is wanted, would be a worthwhile task if somebody has the time ...
> > >
> > > Thanks for the patch!
> > > Harald
> > >
> > > > Thanks,
> > > >
> > > > Jonathan
> > > > > ---
> > > > >  drivers/iio/humidity/dht11.c |    8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/humidity/dht11.c
> > > b/drivers/iio/humidity/dht11.c
> > > > > index 1165b1c..cfc5a05 100644
> > > > > --- a/drivers/iio/humidity/dht11.c
> > > > > +++ b/drivers/iio/humidity/dht11.c
> > > > > @@ -117,7 +117,7 @@ static int dht11_decode(struct dht11 *dht11,
> int
> > > offset, int timeres)
> > > > >     if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) !=
> checksum)
> > > > >             return -EIO;
> > > > >
> > > > > -   dht11->timestamp = ktime_get_real_ns();
> > > > > +   dht11->timestamp = ktime_get_boot_ns();
> > > > >     if (hum_int < 20) {  /* DHT22 */
> > > > >             dht11->temperature = (((temp_int & 0x7f) << 8) +
> temp_dec)
> > > *
> > > > >                                     ((temp_int & 0x80) ? -100 :
> 100);
> > > > > @@ -145,7 +145,7 @@ static irqreturn_t dht11_handle_irq(int irq,
> void
> > > *data)
> > > > >
> > > > >     /* TODO: Consider making the handler safe for IRQ sharing */
> > > > >     if (dht11->num_edges < DHT11_EDGES_PER_READ &&
> dht11->num_edges >=
> > > 0) {
> > > > > -           dht11->edges[dht11->num_edges].ts =
> ktime_get_real_ns();
> > > > > +           dht11->edges[dht11->num_edges].ts =
> ktime_get_boot_ns();
> > > > >             dht11->edges[dht11->num_edges++].value =
> > > > >
> > >  gpio_get_value(dht11->gpio);
> > > > >
> > > > > @@ -164,7 +164,7 @@ static int dht11_read_raw(struct iio_dev
> *iio_dev,
> > > > >     int ret, timeres;
> > > > >
> > > > >     mutex_lock(&dht11->lock);
> > > > > -   if (dht11->timestamp + DHT11_DATA_VALID_TIME <
> > > ktime_get_real_ns()) {
> > > > > +   if (dht11->timestamp + DHT11_DATA_VALID_TIME <
> > > ktime_get_boot_ns()) {
> > > > >             timeres = ktime_get_resolution_ns();
> > > > >             if (DHT11_DATA_BIT_HIGH < 2 * timeres) {
> > > > >                     dev_err(dht11->dev, "timeresolution %dns too
> > > low\n",
> > > > > @@ -279,7 +279,7 @@ static int dht11_probe(struct platform_device
> > > *pdev)
> > > > >             return -EINVAL;
> > > > >     }
> > > > >
> > > > > -   dht11->timestamp = ktime_get_real_ns() - DHT11_DATA_VALID_TIME
> - 1;
> > > > > +   dht11->timestamp = ktime_get_boot_ns() - DHT11_DATA_VALID_TIME
> - 1;
> > > > >     dht11->num_edges = -1;
> > > > >
> > > > >     platform_set_drvdata(pdev, iio);
> > > > >
> > > >
> > >
> > > --
> > > If you want to support my work:
> > > see http://friends.ccbib.org/harald/supporting/
> > > or donate via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
> > > or bitcoin 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
> > >
> >
>
> --
> If you want to support my work:
> see http://friends.ccbib.org/harald/supporting/
> or donate via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
> or bitcoin 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
>

--001a1141d0e27efcf5052aae79da
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Great, thanks.<div><br></div><div>Best,</div><div>Abhilash=
</div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Su=
n, Jan 31, 2016 at 5:09 AM, Harald Geyer <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:harald@ccbib.org" target=3D"_blank">harald@ccbib.org</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Abhilash Jindal wr=
ites:<br>
&gt; Thanks Harald and Jonathan.<br>
&gt;<br>
&gt; I would absolutely love to know the symptoms of the odd issue you ment=
ioned.<br>
<br>
</span>Sure. What I was seeing was a number of zero humidity, zero temperat=
ure<br>
values reported for some time after boot. Then the sensors started to work<=
br>
normally.<br>
<br>
Given that &quot;all transmission bits zero&quot; passes the checksum test,=
 I thought<br>
that maybe there is some ressource conflict of the irq line causing<br>
edges to come in at way too fast pace. However the bug you found explains<b=
r>
it neatly if we assume that the system clock is set after probe() but befor=
e<br>
the sensor is read for the first time and the zeros I saw in the log were<b=
r>
actually uninitialized memory.<br>
<br>
Maybe setting<br>
<span class=3D"">dht11-&gt;timestamp =3D ktime_get_real_ns() - DHT11_DATA_V=
ALID_TIME - 1;<br>
</span>in probe() wasn&#39;t such a good idea.<br>
dht11-&gt;timestamp =3D -1;<br>
probably would have been more robust. But of course your patch is fixing<br=
>
the true problem.<br>
<br>
best regards,<br>
Harald<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; Cheers,<br>
&gt; Abhilash<br>
&gt;<br>
&gt; On Sat, Jan 30, 2016 at 2:11 PM, Harald Geyer &lt;<a href=3D"mailto:ha=
rald@ccbib.org">harald@ccbib.org</a>&gt; wrote:<br>
&gt;<br>
&gt; &gt; Jonathan Cameron writes:<br>
&gt; &gt; &gt; On 27/01/16 22:46, Abhilash Jindal wrote:<br>
&gt; &gt; &gt; &gt; Wall time obtained from ktime_get_real_ns is susceptibl=
e to sudden<br>
&gt; &gt; jumps due to<br>
&gt; &gt; &gt; &gt; user setting the time or due to NTP.=C2=A0 Boot time is=
 constantly<br>
&gt; &gt; increasing time<br>
&gt; &gt; &gt; &gt; better suited for comparing two timestamps.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Signed-off-by: Abhilash Jindal &lt;<a href=3D"mailto:kl=
ock.android@gmail.com">klock.android@gmail.com</a>&gt;<br>
&gt; &gt; &gt; Seems sensible to me, but would like Richard / Harald to tak=
e a quick<br>
&gt; &gt; &gt; look before I apply it.<br>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: Harald Geyer &lt;<a href=3D"mailto:harald@ccbib.org"=
>harald@ccbib.org</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; I can&#39;t test this right now, but I think it will fix an odd i=
ssue I<br>
&gt; &gt; have seen in a log file (apparently was completely off track debu=
gging it).<br>
&gt; &gt; As this very likely is a real world issue, I&#39;d recommend appl=
ying the patch<br>
&gt; &gt; to the fixes branch, so that it hopefully gets picked up for LTS =
kernels.<br>
&gt; &gt;<br>
&gt; &gt; I used ktime_get_real_ns() because that is what iio_get_time_ns()=
 uses.<br>
&gt; &gt; I should have thought about this twice - sorry about being sloppy=
!<br>
&gt; &gt;<br>
&gt; &gt; I just grepped the other iio drivers and none is using iio_get_ti=
me_ns() in<br>
&gt; &gt; a comparision like dht11 did, so maybe the other uses are safe. H=
owever<br>
&gt; &gt; I couldn&#39;t check variables containing timestamps that way, so=
 maybe<br>
&gt; &gt; reviewing the users of iio_get_time_ns(), whether wall time is ac=
tually<br>
&gt; &gt; what is wanted, would be a worthwhile task if somebody has the ti=
me ...<br>
&gt; &gt;<br>
&gt; &gt; Thanks for the patch!<br>
&gt; &gt; Harald<br>
&gt; &gt;<br>
&gt; &gt; &gt; Thanks,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Jonathan<br>
&gt; &gt; &gt; &gt; ---<br>
&gt; &gt; &gt; &gt;=C2=A0 drivers/iio/humidity/dht11.c |=C2=A0 =C2=A0 8 +++=
+----<br>
&gt; &gt; &gt; &gt;=C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)<b=
r>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; diff --git a/drivers/iio/humidity/dht11.c<br>
&gt; &gt; b/drivers/iio/humidity/dht11.c<br>
&gt; &gt; &gt; &gt; index 1165b1c..cfc5a05 100644<br>
&gt; &gt; &gt; &gt; --- a/drivers/iio/humidity/dht11.c<br>
&gt; &gt; &gt; &gt; +++ b/drivers/iio/humidity/dht11.c<br>
&gt; &gt; &gt; &gt; @@ -117,7 +117,7 @@ static int dht11_decode(struct dht1=
1 *dht11, int<br>
&gt; &gt; offset, int timeres)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0if (((hum_int + hum_dec + temp_int +=
 temp_dec) &amp; 0xff) !=3D checksum)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
EIO;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0dht11-&gt;timestamp =3D ktime_get_real_ns=
();<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0dht11-&gt;timestamp =3D ktime_get_boot_ns=
();<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0if (hum_int &lt; 20) {=C2=A0 /* DHT2=
2 */<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dht11-&g=
t;temperature =3D (((temp_int &amp; 0x7f) &lt;&lt; 8) + temp_dec)<br>
&gt; &gt; *<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0((temp_int &amp; 0x80) ? -100 : 100);<br>
&gt; &gt; &gt; &gt; @@ -145,7 +145,7 @@ static irqreturn_t dht11_handle_irq=
(int irq, void<br>
&gt; &gt; *data)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0/* TODO: Consider making the handler=
 safe for IRQ sharing */<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0if (dht11-&gt;num_edges &lt; DHT11_E=
DGES_PER_READ &amp;&amp; dht11-&gt;num_edges &gt;=3D<br>
&gt; &gt; 0) {<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dht11-&gt;edg=
es[dht11-&gt;num_edges].ts =3D ktime_get_real_ns();<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dht11-&gt;edg=
es[dht11-&gt;num_edges].ts =3D ktime_get_boot_ns();<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dht11-&g=
t;edges[dht11-&gt;num_edges++].value =3D<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt;=C2=A0 gpio_get_value(dht11-&gt;gpio);<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; @@ -164,7 +164,7 @@ static int dht11_read_raw(struct ii=
o_dev *iio_dev,<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0int ret, timeres;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;dht11-&gt;lock);<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0if (dht11-&gt;timestamp + DHT11_DATA_VALI=
D_TIME &lt;<br>
&gt; &gt; ktime_get_real_ns()) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0if (dht11-&gt;timestamp + DHT11_DATA_VALI=
D_TIME &lt;<br>
&gt; &gt; ktime_get_boot_ns()) {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeres =
=3D ktime_get_resolution_ns();<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (DHT1=
1_DATA_BIT_HIGH &lt; 2 * timeres) {<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0dev_err(dht11-&gt;dev, &quot;timeresolution %dns too<br=
>
&gt; &gt; low\n&quot;,<br>
&gt; &gt; &gt; &gt; @@ -279,7 +279,7 @@ static int dht11_probe(struct platf=
orm_device<br>
&gt; &gt; *pdev)<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -=
EINVAL;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; -=C2=A0 =C2=A0dht11-&gt;timestamp =3D ktime_get_real_ns=
() - DHT11_DATA_VALID_TIME - 1;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0dht11-&gt;timestamp =3D ktime_get_boot_ns=
() - DHT11_DATA_VALID_TIME - 1;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0dht11-&gt;num_edges =3D -1;<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, iio);<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; If you want to support my work:<br>
&gt; &gt; see <a href=3D"http://friends.ccbib.org/harald/supporting/" rel=
=3D"noreferrer" target=3D"_blank">http://friends.ccbib.org/harald/supportin=
g/</a><br>
&gt; &gt; or donate via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w<br>
&gt; &gt; or bitcoin 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS<br>
&gt; &gt;<br>
&gt;<br>
<br>
--<br>
If you want to support my work:<br>
see <a href=3D"http://friends.ccbib.org/harald/supporting/" rel=3D"noreferr=
er" target=3D"_blank">http://friends.ccbib.org/harald/supporting/</a><br>
or donate via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w<br>
or bitcoin 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS<br>
</div></div></blockquote></div><br></div>

--001a1141d0e27efcf5052aae79da--
