Return-Path: <SRS0=FWgg=3H=gmail.com=arushisinghal19971997@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170330182210.GA6160@d830.WORKGROUP>
References: <20170330124603.GA29301@arushi-HP-Pavilion-Notebook> <20170330182210.GA6160@d830.WORKGROUP>
From: Arushi Singhal <arushisinghal19971997@gmail.com>
Date: Thu, 30 Mar 2017 23:57:22 +0530
Message-ID: <CA+XqjF_vNXqs54=a6Zp_7PB+aYfUwkZDDLcW0iAme3s794gnow@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] iio: adc: replace comma with a semicolon
To: Alison Schofield <amsfield22@gmail.com>
Cc: outreachy-kernel@googlegroups.com, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary=001a113c0ac21a039c054bf6d833
List-ID: <linux-iio@vger.kernel.org>

--001a113c0ac21a039c054bf6d833
Content-Type: text/plain; charset=UTF-8

On Thu, Mar 30, 2017 at 11:52 PM, Alison Schofield <amsfield22@gmail.com>
wrote:

> On Thu, Mar 30, 2017 at 06:16:03PM +0530, Arushi Singhal wrote:
> > Replace a comma between expression statements by a semicolon. This
> > changes the semantics of the code, but given the current indentation
> > appears to be what is intended.
>
> Hi Arushi,
>
> Well, you've gotten a lot of comments on this one, and I too, couldn't
> resist ;)  My comment is to test things like this out. Of course, you're
> not going to go off and test the max11100 driver (BTW - driver name in
> Subject line please), but you can write a simple C program to verify
> the behavior of commas vs semi-colons in assignment statements.
> That'll prove it to yourself, and then you can write the changelog
> with confidence. (That this is cosmetic ;))
>
> It's a useful habit to pick up.  When you see a code segment that
> makes you wonder, you can often pluck it out of context and try
> it in a simple c program.
>
> Thanks Alison
I'll write a C-program to explain more better,
Thanks
Arushi


> alisons


> > A simplified version of the Coccinelle semantic patch that performs this
> > transformation is as follows:
> >
> > // <smpl>
> > @r@
> > expression e1,e2;
> > @@
> >
> >  e1
> > -,
> > +;
> >  e2;
> > // </smpl>
> >
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> > ---
> >  drivers/iio/adc/max11100.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> > index 23c060e1b663..1180bcc22ff1 100644
> > --- a/drivers/iio/adc/max11100.c
> > +++ b/drivers/iio/adc/max11100.c
> > @@ -124,8 +124,8 @@ static int max11100_probe(struct spi_device *spi)
> >       indio_dev->name = "max11100";
> >       indio_dev->info = &max11100_info;
> >       indio_dev->modes = INDIO_DIRECT_MODE;
> > -     indio_dev->channels = max11100_channels,
> > -     indio_dev->num_channels = ARRAY_SIZE(max11100_channels),
> > +     indio_dev->channels = max11100_channels;
> > +     indio_dev->num_channels = ARRAY_SIZE(max11100_channels);
> >
> >       state->vref_reg = devm_regulator_get(&spi->dev, "vref");
> >       if (IS_ERR(state->vref_reg))
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
> msgid/outreachy-kernel/20170330124603.GA29301%
> 40arushi-HP-Pavilion-Notebook.
> > For more options, visit https://groups.google.com/d/optout.
>

--001a113c0ac21a039c054bf6d833
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Mar 30, 2017 at 11:52 PM, Alison Schofield <span dir=3D"ltr">&l=
t;<a href=3D"mailto:amsfield22@gmail.com" target=3D"_blank">amsfield22@gmai=
l.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D"">On Thu, Mar 30, 2017 at 06:16:03PM +0530, Arushi Singhal wrote:<br>
</span><span class=3D"">&gt; Replace a comma between expression statements =
by a semicolon. This<br>
&gt; changes the semantics of the code, but given the current indentation<b=
r>
&gt; appears to be what is intended.<br>
<br>
</span>Hi Arushi,<br>
<br>
Well, you&#39;ve gotten a lot of comments on this one, and I too, couldn&#3=
9;t<br>
resist ;)=C2=A0 My comment is to test things like this out. Of course, you&=
#39;re<br>
not going to go off and test the max11100 driver (BTW - driver name in<br>
Subject line please), but you can write a simple C program to verify<br>
the behavior of commas vs semi-colons in assignment statements.<br>
That&#39;ll prove it to yourself, and then you can write the changelog<br>
with confidence. (That this is cosmetic ;))<br>
<br>
It&#39;s a useful habit to pick up.=C2=A0 When you see a code segment that<=
br>
makes you wonder, you can often pluck it out of context and try<br>
it in a simple c program.<br>
<br></blockquote><div>Thanks Alison<br></div><div>I&#39;ll write a C-progra=
m to explain more better,<br></div><div>Thanks<br></div><div>Arushi<br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
alisons=C2=A0</blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; A simplified version of the Coccinelle semantic patch that performs th=
is<br>
&gt; transformation is as follows:<br>
&gt;<br>
&gt; // &lt;smpl&gt;<br>
&gt; @r@<br>
&gt; expression e1,e2;<br>
&gt; @@<br>
&gt;<br>
&gt;=C2=A0 e1<br>
&gt; -,<br>
&gt; +;<br>
&gt;=C2=A0 e2;<br>
&gt; // &lt;/smpl&gt;<br>
&gt;<br>
&gt; Signed-off-by: Arushi Singhal &lt;<a href=3D"mailto:arushisinghal19971=
997@gmail.com">arushisinghal19971997@gmail.<wbr>com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/iio/adc/max11100.c | 4 ++--<br>
&gt;=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c<b=
r>
&gt; index 23c060e1b663..1180bcc22ff1 100644<br>
&gt; --- a/drivers/iio/adc/max11100.c<br>
&gt; +++ b/drivers/iio/adc/max11100.c<br>
&gt; @@ -124,8 +124,8 @@ static int max11100_probe(struct spi_device *spi)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;name =3D &quot;max11100&quot;;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;info =3D &amp;max11100_info;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;channels =3D max11100_channels,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;num_channels =3D ARRAY_SIZE(max1110=
0_channels),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;channels =3D max11100_channels;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0indio_dev-&gt;num_channels =3D ARRAY_SIZE(max1110=
0_channels);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0state-&gt;vref_reg =3D devm_regulator_get(&a=
mp;spi-&gt;dev, &quot;vref&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(state-&gt;vref_reg))<br>
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
gle.com/d/msgid/outreachy-kernel/20170330124603.GA29301%40arushi-HP-Pavilio=
n-Notebook" rel=3D"noreferrer" target=3D"_blank">https://groups.google.com/=
d/<wbr>msgid/outreachy-kernel/<wbr>20170330124603.GA29301%<wbr>40arushi-HP-=
Pavilion-Notebook</a>.<br>
&gt; For more options, visit <a href=3D"https://groups.google.com/d/optout"=
 rel=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/<wbr>opto=
ut</a>.<br>
</font></span></blockquote></div><br></div></div>

--001a113c0ac21a039c054bf6d833--
