Return-Path: <SRS0=83Rr=26=gmail.com=arushisinghal19971997@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170321160348.GA1859@d830.WORKGROUP>
References: <20170321133021.6737-1-arushisinghal19971997@gmail.com> <20170321160348.GA1859@d830.WORKGROUP>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Tue, 21 Mar 2017 22:06:36 +0530
Message-ID: <CA+XqjF9dVy33Dsv0H2z8xtaNeMOW7SQgr4qa4wLwz6xFNVTsUA@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 0/2] IIO coding tasks
To: Alison Schofield <amsfield22@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, outreachy-kernel@googlegroups.com,
	Michael Hennerich <Michael.Hennerich@analog.com>, lars@metafoo.de,
	Greg KH <gregkh@linuxfoundation.org>, speakup@linux-speakup.org,
	driverdevel <devel@driverdev.osuosl.org>, linux-kernel@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a1140379e6035df054b403f1f
List-ID: <linux-iio@vger.kernel.org>

--001a1140379e6035df054b403f1f
Content-Type: text/plain; charset=UTF-8

On Tue, Mar 21, 2017 at 9:33 PM, Alison Schofield <amsfield22@gmail.com>
wrote:

> On Tue, Mar 21, 2017 at 07:00:17PM +0530, Arushi Singhal wrote:
> > Patchseries of IIO coding tasks
>
> This wouldn't be a patchset.  Although they touch the same
> driver, the changes are unrelated.  See more below...
>
This I have send as a Patchset because as you have mentioned below that the
[PATCH 2/2] was already done before by someone but I think so it is not yet
applied in the Greg's tree yet.So I have done both the changes and as they
should be applied one after other so that's why I have send them as
Patchset.

> >
> > Arushi Singhal (2):
> >   staging: ad7759: Replace mlock with driver private lock
>
> This one is already been submitted.  If you have a v2 for it, then v2
> the original patch.
>
> Is it submitted by me only before? And this is not the v2.
I have just resed it.

> >   staging: iio: ade7759: Move header content to implementation file
>
> This patch is done and applied already.  See the Coding Task #1 notes
> in the IIO Tasks page.
>
Not at applied I think so.
Thanks
Arushi

>
> alisons
>
> >
> >  drivers/staging/iio/meter/ade7759.c   | 56
> +++++++++++++++++++++++++++++++++--
> >  drivers/staging/iio/meter/ade7759.h   | 53
> ---------------------------------
> >  2 files changed, 54 insertions(+), 57 deletions(-)
> >
> > --
> > 2.11.0
> >
> > --
> > You received this message because you are subscribed to the Google
> Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send
> an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To post to this group, send email to outreachy-kernel@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/
> msgid/outreachy-kernel/20170321133021.6737-1-
> arushisinghal19971997%40gmail.com.
> > For more options, visit https://groups.google.com/d/optout.
>

--001a1140379e6035df054b403f1f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On Tue, Mar 21, 2017 at 9:33 PM, Alison Schofield <span di=
r=3D"ltr">&lt;<a href=3D"mailto:amsfield22@gmail.com" target=3D"_blank">ams=
field22@gmail.com</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Tu=
e, Mar 21, 2017 at 07:00:17PM +0530, Arushi Singhal wrote:<br>
&gt; Patchseries of IIO coding tasks<br>
<br>
</span>This wouldn&#39;t be a patchset.=C2=A0 Although they touch the same<=
br>
driver, the changes are unrelated.=C2=A0 See more below...<br>
<span class=3D""></span></blockquote><div>This I have send as a Patchset be=
cause as you have mentioned below that the [PATCH 2/2] was already done bef=
ore by someone but I think so it is not yet applied in the Greg&#39;s tree =
yet.So I have done both the changes and as they should be applied one after=
 other so that&#39;s why I have send them as Patchset. <br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><span class=3D"">&gt;<br>
&gt; Arushi Singhal (2):<br>
&gt;=C2=A0 =C2=A0staging: ad7759: Replace mlock with driver private lock<br=
>
<br>
</span>This one is already been submitted.=C2=A0 If you have a v2 for it, t=
hen v2<br>
the original patch.<br>
<span class=3D""><br></span></blockquote><div>Is it submitted by me only be=
fore? And this is not the v2.<br></div><div>I have just resed it.<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><span class=3D"">
&gt;=C2=A0 =C2=A0staging: iio: ade7759: Move header content to implementati=
on file<br>
<br>
</span>This patch is done and applied already.=C2=A0 See the Coding Task #1=
 notes<br>
in the IIO Tasks page.<br></blockquote><div>Not at applied I think so.<br><=
/div><div>Thanks<br></div><div>Arushi<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
alisons<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt;=C2=A0 drivers/staging/iio/meter/<wbr>ade7759.c=C2=A0 =C2=A0| 56 ++++++=
++++++++++++++++++++++++<wbr>+++--<br>
&gt;=C2=A0 drivers/staging/iio/meter/<wbr>ade7759.h=C2=A0 =C2=A0| 53 ------=
------------------------<wbr>---<br>
&gt;=C2=A0 2 files changed, 54 insertions(+), 57 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.11.0<br>
&gt;<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; You received this message because you are subscribed to the Google Gro=
ups &quot;outreachy-kernel&quot; group.<br>
&gt; To unsubscribe from this group and stop receiving emails from it, send=
 an email to <a href=3D"mailto:outreachy-kernel%2Bunsubscribe@googlegroups.=
com">outreachy-kernel+unsubscribe@<wbr>googlegroups.com</a>.<br>
&gt; To post to this group, send email to <a href=3D"mailto:outreachy-kerne=
l@googlegroups.com">outreachy-kernel@googlegroups.<wbr>com</a>.<br>
&gt; To view this discussion on the web visit <a href=3D"https://groups.goo=
gle.com/d/msgid/outreachy-kernel/20170321133021.6737-1-arushisinghal1997199=
7%40gmail.com" rel=3D"noreferrer" target=3D"_blank">https://groups.google.c=
om/d/<wbr>msgid/outreachy-kernel/<wbr>20170321133021.6737-1-<wbr>arushising=
hal19971997%40gmail.<wbr>com</a>.<br>
&gt; For more options, visit <a href=3D"https://groups.google.com/d/optout"=
 rel=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/<wbr>opto=
ut</a>.<br>
</font></span></blockquote></div><br></div></div>

--001a1140379e6035df054b403f1f--
