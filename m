Return-Path: <klock.android@gmail.com>
MIME-Version: 1.0
In-Reply-To: <E1aPavY-0000Rc-Gk@stardust.g4.wien.funkfeuer.at>
References: <1453934762-6290-1-git-send-email-klock.android@gmail.com>
	<56ACF7E4.7040603@kernel.org>
	<E1aPavY-0000Rc-Gk@stardust.g4.wien.funkfeuer.at>
Date: Sun, 31 Jan 2016 00:08:12 -0500
Message-ID: <CALiE4M3BGE=_jWJu+s1SgDEfHD0r1md8yRjXFsRmNoL_Ta4HbA@mail.gmail.com>
Subject: Re: [PATCH] iio: dht11: Use boottime
From: Abhilash Jindal <klock.android@gmail.com>
To: Harald Geyer <harald@ccbib.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Content-Type: multipart/alternative; boundary=047d7b2e133950d20c052a9a410e
List-ID: <linux-iio@vger.kernel.org>

--047d7b2e133950d20c052a9a410e
Content-Type: text/plain; charset=UTF-8

Thanks Harald and Jonathan.

I would absolutely love to know the symptoms of the odd issue you mentioned.

Cheers,
Abhilash

On Sat, Jan 30, 2016 at 2:11 PM, Harald Geyer <harald@ccbib.org> wrote:

> Jonathan Cameron writes:
> > On 27/01/16 22:46, Abhilash Jindal wrote:
> > > Wall time obtained from ktime_get_real_ns is susceptible to sudden
> jumps due to
> > > user setting the time or due to NTP.  Boot time is constantly
> increasing time
> > > better suited for comparing two timestamps.
> > >
> > > Signed-off-by: Abhilash Jindal <klock.android@gmail.com>
> > Seems sensible to me, but would like Richard / Harald to take a quick
> > look before I apply it.
>
> Reviewed-by: Harald Geyer <harald@ccbib.org>
>
> I can't test this right now, but I think it will fix an odd issue I
> have seen in a log file (apparently was completely off track debugging it).
> As this very likely is a real world issue, I'd recommend applying the patch
> to the fixes branch, so that it hopefully gets picked up for LTS kernels.
>
> I used ktime_get_real_ns() because that is what iio_get_time_ns() uses.
> I should have thought about this twice - sorry about being sloppy!
>
> I just grepped the other iio drivers and none is using iio_get_time_ns() in
> a comparision like dht11 did, so maybe the other uses are safe. However
> I couldn't check variables containing timestamps that way, so maybe
> reviewing the users of iio_get_time_ns(), whether wall time is actually
> what is wanted, would be a worthwhile task if somebody has the time ...
>
> Thanks for the patch!
> Harald
>
> > Thanks,
> >
> > Jonathan
> > > ---
> > >  drivers/iio/humidity/dht11.c |    8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/iio/humidity/dht11.c
> b/drivers/iio/humidity/dht11.c
> > > index 1165b1c..cfc5a05 100644
> > > --- a/drivers/iio/humidity/dht11.c
> > > +++ b/drivers/iio/humidity/dht11.c
> > > @@ -117,7 +117,7 @@ static int dht11_decode(struct dht11 *dht11, int
> offset, int timeres)
> > >     if (((hum_int + hum_dec + temp_int + temp_dec) & 0xff) != checksum)
> > >             return -EIO;
> > >
> > > -   dht11->timestamp = ktime_get_real_ns();
> > > +   dht11->timestamp = ktime_get_boot_ns();
> > >     if (hum_int < 20) {  /* DHT22 */
> > >             dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec)
> *
> > >                                     ((temp_int & 0x80) ? -100 : 100);
> > > @@ -145,7 +145,7 @@ static irqreturn_t dht11_handle_irq(int irq, void
> *data)
> > >
> > >     /* TODO: Consider making the handler safe for IRQ sharing */
> > >     if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >=
> 0) {
> > > -           dht11->edges[dht11->num_edges].ts = ktime_get_real_ns();
> > > +           dht11->edges[dht11->num_edges].ts = ktime_get_boot_ns();
> > >             dht11->edges[dht11->num_edges++].value =
> > >
>  gpio_get_value(dht11->gpio);
> > >
> > > @@ -164,7 +164,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
> > >     int ret, timeres;
> > >
> > >     mutex_lock(&dht11->lock);
> > > -   if (dht11->timestamp + DHT11_DATA_VALID_TIME <
> ktime_get_real_ns()) {
> > > +   if (dht11->timestamp + DHT11_DATA_VALID_TIME <
> ktime_get_boot_ns()) {
> > >             timeres = ktime_get_resolution_ns();
> > >             if (DHT11_DATA_BIT_HIGH < 2 * timeres) {
> > >                     dev_err(dht11->dev, "timeresolution %dns too
> low\n",
> > > @@ -279,7 +279,7 @@ static int dht11_probe(struct platform_device
> *pdev)
> > >             return -EINVAL;
> > >     }
> > >
> > > -   dht11->timestamp = ktime_get_real_ns() - DHT11_DATA_VALID_TIME - 1;
> > > +   dht11->timestamp = ktime_get_boot_ns() - DHT11_DATA_VALID_TIME - 1;
> > >     dht11->num_edges = -1;
> > >
> > >     platform_set_drvdata(pdev, iio);
> > >
> >
>
> --
> If you want to support my work:
> see http://friends.ccbib.org/harald/supporting/
> or donate via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w
> or bitcoin 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
>

--047d7b2e133950d20c052a9a410e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Harald and Jonathan.<div><br></div><div>I would abs=
olutely love to know the symptoms of the odd issue you mentioned.</div><div=
><br></div><div>Cheers,</div><div>Abhilash</div></div><div class=3D"gmail_e=
xtra"><br><div class=3D"gmail_quote">On Sat, Jan 30, 2016 at 2:11 PM, Haral=
d Geyer <span dir=3D"ltr">&lt;<a href=3D"mailto:harald@ccbib.org" target=3D=
"_blank">harald@ccbib.org</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><span class=3D"">Jonathan Cameron writes:<br>
&gt; On 27/01/16 22:46, Abhilash Jindal wrote:<br>
&gt; &gt; Wall time obtained from ktime_get_real_ns is susceptible to sudde=
n jumps due to<br>
&gt; &gt; user setting the time or due to NTP.=C2=A0 Boot time is constantl=
y increasing time<br>
&gt; &gt; better suited for comparing two timestamps.<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Abhilash Jindal &lt;<a href=3D"mailto:klock.androi=
d@gmail.com">klock.android@gmail.com</a>&gt;<br>
&gt; Seems sensible to me, but would like Richard / Harald to take a quick<=
br>
&gt; look before I apply it.<br>
<br>
</span>Reviewed-by: Harald Geyer &lt;<a href=3D"mailto:harald@ccbib.org">ha=
rald@ccbib.org</a>&gt;<br>
<br>
I can&#39;t test this right now, but I think it will fix an odd issue I<br>
have seen in a log file (apparently was completely off track debugging it).=
<br>
As this very likely is a real world issue, I&#39;d recommend applying the p=
atch<br>
to the fixes branch, so that it hopefully gets picked up for LTS kernels.<b=
r>
<br>
I used ktime_get_real_ns() because that is what iio_get_time_ns() uses.<br>
I should have thought about this twice - sorry about being sloppy!<br>
<br>
I just grepped the other iio drivers and none is using iio_get_time_ns() in=
<br>
a comparision like dht11 did, so maybe the other uses are safe. However<br>
I couldn&#39;t check variables containing timestamps that way, so maybe<br>
reviewing the users of iio_get_time_ns(), whether wall time is actually<br>
what is wanted, would be a worthwhile task if somebody has the time ...<br>
<br>
Thanks for the patch!<br>
Harald<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; Thanks,<br>
&gt;<br>
&gt; Jonathan<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 drivers/iio/humidity/dht11.c |=C2=A0 =C2=A0 8 ++++----<br>
&gt; &gt;=C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/=
dht11.c<br>
&gt; &gt; index 1165b1c..cfc5a05 100644<br>
&gt; &gt; --- a/drivers/iio/humidity/dht11.c<br>
&gt; &gt; +++ b/drivers/iio/humidity/dht11.c<br>
&gt; &gt; @@ -117,7 +117,7 @@ static int dht11_decode(struct dht11 *dht11, =
int offset, int timeres)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0if (((hum_int + hum_dec + temp_int + temp_dec)=
 &amp; 0xff) !=3D checksum)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0dht11-&gt;timestamp =3D ktime_get_real_ns();<br>
&gt; &gt; +=C2=A0 =C2=A0dht11-&gt;timestamp =3D ktime_get_boot_ns();<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0if (hum_int &lt; 20) {=C2=A0 /* DHT22 */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dht11-&gt;temperat=
ure =3D (((temp_int &amp; 0x7f) &lt;&lt; 8) + temp_dec) *<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((temp_in=
t &amp; 0x80) ? -100 : 100);<br>
&gt; &gt; @@ -145,7 +145,7 @@ static irqreturn_t dht11_handle_irq(int irq, =
void *data)<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0/* TODO: Consider making the handler safe for =
IRQ sharing */<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0if (dht11-&gt;num_edges &lt; DHT11_EDGES_PER_R=
EAD &amp;&amp; dht11-&gt;num_edges &gt;=3D 0) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dht11-&gt;edges[dht11-&=
gt;num_edges].ts =3D ktime_get_real_ns();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dht11-&gt;edges[dht11-&=
gt;num_edges].ts =3D ktime_get_boot_ns();<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dht11-&gt;edges[dh=
t11-&gt;num_edges++].value =3D<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0gpio_get_value(dht11-&gt;gpio);<br>
&gt; &gt;<br>
&gt; &gt; @@ -164,7 +164,7 @@ static int dht11_read_raw(struct iio_dev *iio=
_dev,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0int ret, timeres;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;dht11-&gt;lock);<br>
&gt; &gt; -=C2=A0 =C2=A0if (dht11-&gt;timestamp + DHT11_DATA_VALID_TIME &lt=
; ktime_get_real_ns()) {<br>
&gt; &gt; +=C2=A0 =C2=A0if (dht11-&gt;timestamp + DHT11_DATA_VALID_TIME &lt=
; ktime_get_boot_ns()) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeres =3D ktime_=
get_resolution_ns();<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (DHT11_DATA_BIT=
_HIGH &lt; 2 * timeres) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_err(dht11-&gt;dev, &quot;timeresolution %dns too low\n&quot;,=
<br>
&gt; &gt; @@ -279,7 +279,7 @@ static int dht11_probe(struct platform_device=
 *pdev)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br=
>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;<br>
&gt; &gt; -=C2=A0 =C2=A0dht11-&gt;timestamp =3D ktime_get_real_ns() - DHT11=
_DATA_VALID_TIME - 1;<br>
&gt; &gt; +=C2=A0 =C2=A0dht11-&gt;timestamp =3D ktime_get_boot_ns() - DHT11=
_DATA_VALID_TIME - 1;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0dht11-&gt;num_edges =3D -1;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, iio);<br>
&gt; &gt;<br>
&gt;<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
If you want to support my work:<br>
see <a href=3D"http://friends.ccbib.org/harald/supporting/" rel=3D"noreferr=
er" target=3D"_blank">http://friends.ccbib.org/harald/supporting/</a><br>
or donate via peercoin to P98LRdhit3gZbHDBe7ta5jtXrMJUms4p7w<br>
or bitcoin 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS<br>
</font></span></blockquote></div><br></div>

--047d7b2e133950d20c052a9a410e--
