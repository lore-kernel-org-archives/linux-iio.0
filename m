Return-Path: <SRS0=83Rr=26=gmail.com=arushisinghal19971997@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170321170221.GB2793@d830.WORKGROUP>
References: <20170321133021.6737-1-arushisinghal19971997@gmail.com>
 <20170321160348.GA1859@d830.WORKGROUP> <CA+XqjF9dVy33Dsv0H2z8xtaNeMOW7SQgr4qa4wLwz6xFNVTsUA@mail.gmail.com>
 <alpine.DEB.2.20.1703211738500.3785@hadrien> <20170321170221.GB2793@d830.WORKGROUP>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Tue, 21 Mar 2017 22:52:46 +0530
Message-ID: <CA+XqjF8Lsjf_55z+KdsWTxdGubG5PO1PYOY_N4wZDNrSNEBYBg@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 0/2] IIO coding tasks
To: Alison Schofield <amsfield22@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, outreachy-kernel@googlegroups.com,
	Michael Hennerich <Michael.Hennerich@analog.com>, lars@metafoo.de,
	Greg KH <gregkh@linuxfoundation.org>, speakup@linux-speakup.org,
	driverdevel <devel@driverdev.osuosl.org>, linux-kernel@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a113ebfcc861ba5054b40e47b
List-ID: <linux-iio@vger.kernel.org>

--001a113ebfcc861ba5054b40e47b
Content-Type: text/plain; charset=UTF-8

On Tue, Mar 21, 2017 at 10:32 PM, Alison Schofield <amsfield22@gmail.com>
wrote:

> On Tue, Mar 21, 2017 at 05:39:38PM +0100, Julia Lawall wrote:
> >
> >
> > On Tue, 21 Mar 2017, Arushi Singhal wrote:
> >
> > > On Tue, Mar 21, 2017 at 9:33 PM, Alison Schofield <
> amsfield22@gmail.com>
> > > wrote:
> > >       On Tue, Mar 21, 2017 at 07:00:17PM +0530, Arushi Singhal wrote:
> > >       > Patchseries of IIO coding tasks
> > >
> > >       This wouldn't be a patchset.  Although they touch the same
> > >       driver, the changes are unrelated.  See more below...
> > >
> > > This I have send as a Patchset because as you have mentioned below
> that the
> > > [PATCH 2/2] was already done before by someone but I think so it is
> not yet
> > > applied in the Greg's tree yet.So I have done both the changes and as
> they
> > > should be applied one after other so that's why I have send them as
> > > Patchset.
> >
> > For the IIO patches, it is better to work on the IIO tree, not Greg's.
> > Greg manages staging, not IIO.  The IIO patches should appear in Greg's
> > tree eventually.
> >
> > julia
>
> We didn't direct applicants to create an iio tree.  At this point,
> it seems more than is necessary.  They can follow the directions in the
> task descriptions and avoid the collisions.
>
> Of course, they are welcome to create a tree to iio/testing.
>
> (IMHO it's more overhead/busy work and maybe not the best use
> of time in the home stretch of the application period.)
>
> alisons
>

Hi Alison
As you have mentioned that my [PATCH 2/2] is already being done someone. So
how can I make the changes of [PATCH 1/2] on top of it as [PATCH 2/2] is
not yet applied on the staging tree.
Please suggest me.
Thanks
Arushi

> >
> > >       >
> > >       > Arushi Singhal (2):
> > >       >   staging: ad7759: Replace mlock with driver private lock
> > >
> > >       This one is already been submitted.  If you have a v2 for it,
> > >       then v2
> > >       the original patch.
> > >
> > > Is it submitted by me only before? And this is not the v2.
> > > I have just resed it.
> > >       >   staging: iio: ade7759: Move header content to implementation
> > >       file
> > >
> > >       This patch is done and applied already.  See the Coding Task #1
> > >       notes
> > >       in the IIO Tasks page.
> > >
> > > Not at applied I think so.
> > > Thanks
> > > Arushi
> > >
> > >       alisons
> > >
> > >       >
> > >       >  drivers/staging/iio/meter/ade7759.c   | 56
> > >       +++++++++++++++++++++++++++++++++--
> > >       >  drivers/staging/iio/meter/ade7759.h   | 53
> > >       ---------------------------------
> > >       >  2 files changed, 54 insertions(+), 57 deletions(-)
> > >       >
> > >       > --
> > >       > 2.11.0
> > >       >
> > > > --
> > > > You received this message because you are subscribed to the Google
> > > Groups "outreachy-kernel" group.
> > > > To unsubscribe from this group and stop receiving emails from it,
> > > send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > > To post to this group, send email to
> > > outreachy-kernel@googlegroups.com.
> > > > To view this discussion on the web visithttps://groups.google.
> com/d/msgid/outreachy-kernel/20170321133021.6737-1-ar
> > > ushisinghal19971997%40gmail.com.
> > > > For more options, visit https://groups.google.com/d/optout.
> > >
> > >
> > > --
> > > You received this message because you are subscribed to the Google
> Groups
> > > "outreachy-kernel" group.
> > > To unsubscribe from this group and stop receiving emails from it, send
> an
> > > email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > To post to this group, send email to outreachy-kernel@googlegroups.com
> .
> > > To view this discussion on the web visithttps://groups.google.
> com/d/msgid/outreachy-kernel/CA%2BXqjF9dVy33Dsv0H2z8x
> > > taNeMOW7SQgr4qa4wLwz6xFNVTsUA%40mail.gmail.com.
> > > For more options, visit https://groups.google.com/d/optout.
> > >
> > >
>
>

--001a113ebfcc861ba5054b40e47b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Tue, Mar 21, 2017 at 10:32 PM, Alison Schofield <span dir=3D"ltr">&l=
t;<a href=3D"mailto:amsfield22@gmail.com" target=3D"_blank">amsfield22@gmai=
l.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">On Tue, Mar 21, 2017 at 05:39:38PM +0100, Julia Lawall wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Tue, 21 Mar 2017, Arushi Singhal wrote:<br>
&gt;<br>
&gt; &gt; On Tue, Mar 21, 2017 at 9:33 PM, Alison Schofield &lt;<a href=3D"=
mailto:amsfield22@gmail.com">amsfield22@gmail.com</a>&gt;<br>
&gt; &gt; wrote:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0On Tue, Mar 21, 2017 at 07:00:17PM +053=
0, Arushi Singhal wrote:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Patchseries of IIO coding tasks<br=
>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0This wouldn&#39;t be a patchset.=C2=A0 =
Although they touch the same<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0driver, the changes are unrelated.=C2=
=A0 See more below...<br>
&gt; &gt;<br>
&gt; &gt; This I have send as a Patchset because as you have mentioned belo=
w that the<br>
&gt; &gt; [PATCH 2/2] was already done before by someone but I think so it =
is not yet<br>
&gt; &gt; applied in the Greg&#39;s tree yet.So I have done both the change=
s and as they<br>
&gt; &gt; should be applied one after other so that&#39;s why I have send t=
hem as<br>
&gt; &gt; Patchset.<br>
&gt;<br>
&gt; For the IIO patches, it is better to work on the IIO tree, not Greg&#3=
9;s.<br>
&gt; Greg manages staging, not IIO.=C2=A0 The IIO patches should appear in =
Greg&#39;s<br>
&gt; tree eventually.<br>
&gt;<br>
&gt; julia<br>
<br>
</span>We didn&#39;t direct applicants to create an iio tree.=C2=A0 At this=
 point,<br>
it seems more than is necessary.=C2=A0 They can follow the directions in th=
e<br>
task descriptions and avoid the collisions.<br>
<br>
Of course, they are welcome to create a tree to iio/testing.<br>
<br>
(IMHO it&#39;s more overhead/busy work and maybe not the best use<br>
of time in the home stretch of the application period.)<br>
<br>
alisons<br></blockquote><div><br></div><div>Hi Alison<br>As you have mentio=
ned that my [PATCH 2/2] is already being done someone. So how can I make th=
e changes of [PATCH 1/2] on top of it as [PATCH 2/2] is not yet applied on =
the staging tree.<br></div><div>Please suggest me.<br></div><div>Thanks<br>=
</div><div>Arushi <br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; Arushi Singhal (2):<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0staging: ad7759: Repla=
ce mlock with driver private lock<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0This one is already been submitted.=C2=
=A0 If you have a v2 for it,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0then v2<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0the original patch.<br>
&gt; &gt;<br>
&gt; &gt; Is it submitted by me only before? And this is not the v2.<br>
&gt; &gt; I have just resed it.<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 =C2=A0staging: iio: ade7759:=
 Move header content to implementation<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0file<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0This patch is done and applied already.=
=C2=A0 See the Coding Task #1<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0notes<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0in the IIO Tasks page.<br>
&gt; &gt;<br>
&gt; &gt; Not at applied I think so.<br>
&gt; &gt; Thanks<br>
&gt; &gt; Arushi<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0alisons<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 drivers/staging/iio/meter/<w=
br>ade7759.c=C2=A0 =C2=A0| 56<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0++++++++++++++++++++++++++++++<wbr>+++-=
-<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 drivers/staging/iio/meter/<w=
br>ade7759.h=C2=A0 =C2=A0| 53<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0------------------------------<wbr>---<=
br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;=C2=A0 2 files changed, 54 insertio=
ns(+), 57 deletions(-)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; --<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt; 2.11.0<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; You received this message because you are subscribed to the =
Google<br>
&gt; &gt; Groups &quot;outreachy-kernel&quot; group.<br>
&gt; &gt; &gt; To unsubscribe from this group and stop receiving emails fro=
m it,<br>
&gt; &gt; send an email to <a href=3D"mailto:outreachy-kernel%2Bunsubscribe=
@googlegroups.com">outreachy-kernel+unsubscribe@<wbr>googlegroups.com</a>.<=
br>
&gt; &gt; &gt; To post to this group, send email to<br>
&gt; &gt; <a href=3D"mailto:outreachy-kernel@googlegroups.com">outreachy-ke=
rnel@googlegroups.<wbr>com</a>.<br>
&gt; &gt; &gt; To view this discussion on the web visithttps://<a href=3D"h=
ttp://groups.google.com/d/msgid/outreachy-kernel/20170321133021.6737-1-ar" =
rel=3D"noreferrer" target=3D"_blank">groups.google.<wbr>com/d/msgid/outreac=
hy-kernel/<wbr>20170321133021.6737-1-ar</a><br>
&gt; &gt; ushisinghal19971997%<a href=3D"http://40gmail.com" rel=3D"norefer=
rer" target=3D"_blank">40gmail.<wbr>com</a>.<br>
&gt; &gt; &gt; For more options, visit <a href=3D"https://groups.google.com=
/d/optout" rel=3D"noreferrer" target=3D"_blank">https://groups.google.com/d=
/<wbr>optout</a>.<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; You received this message because you are subscribed to the Googl=
e Groups<br>
&gt; &gt; &quot;outreachy-kernel&quot; group.<br>
&gt; &gt; To unsubscribe from this group and stop receiving emails from it,=
 send an<br>
&gt; &gt; email to <a href=3D"mailto:outreachy-kernel%2Bunsubscribe@googleg=
roups.com">outreachy-kernel+unsubscribe@<wbr>googlegroups.com</a>.<br>
&gt; &gt; To post to this group, send email to <a href=3D"mailto:outreachy-=
kernel@googlegroups.com">outreachy-kernel@googlegroups.<wbr>com</a>.<br>
&gt; &gt; To view this discussion on the web visithttps://<a href=3D"http:/=
/groups.google.com/d/msgid/outreachy-kernel/CA%2BXqjF9dVy33Dsv0H2z8x" rel=
=3D"noreferrer" target=3D"_blank">groups.google.<wbr>com/d/msgid/outreachy-=
kernel/<wbr>CA%2BXqjF9dVy33Dsv0H2z8x</a><br>
&gt; &gt; taNeMOW7SQgr4qa4wLwz6xFNVTsUA%<a href=3D"http://40mail.gmail.com"=
 rel=3D"noreferrer" target=3D"_blank"><wbr>40mail.gmail.com</a>.<br>
&gt; &gt; For more options, visit <a href=3D"https://groups.google.com/d/op=
tout" rel=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/<wbr=
>optout</a>.<br>
&gt; &gt;<br>
&gt; &gt;<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a113ebfcc861ba5054b40e47b--
