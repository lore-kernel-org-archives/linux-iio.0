Return-Path: <SRS0=oPXI=3L=google.com=raltherr@kernel.org>
MIME-Version: 1.0
In-Reply-To: <968a3a78-49d3-138b-ef6e-7cee3c133471@kernel.org>
References: <20170328215259.31622-1-raltherr@google.com> <CACPK8Xcf2A8RMy7cthJrdi2CA0L_Hfi+2Hy3JBCzLTsofjhEuA@mail.gmail.com>
 <968a3a78-49d3-138b-ef6e-7cee3c133471@kernel.org>
From: Rick Altherr <raltherr@google.com>
Date: Mon, 3 Apr 2017 10:17:00 -0700
Message-ID: <CAPLgG=my4re27Mx5Uruc9s_OEPpT6YG17VTf908iyi4GsD70yg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] Documentation: dt-bindings: Document bindings for
 Aspeed ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Rob Herring <robh+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Mark Rutland <mark.rutland@arm.com>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: multipart/alternative; boundary=001a114b3ebcd42e28054c46537c
List-ID: <linux-iio@vger.kernel.org>

--001a114b3ebcd42e28054c46537c
Content-Type: text/plain; charset=UTF-8

On Sat, Apr 1, 2017 at 3:51 AM, Jonathan Cameron <jic23@kernel.org> wrote:

> On 29/03/17 03:33, Joel Stanley wrote:
> > On Wed, Mar 29, 2017 at 8:22 AM, Rick Altherr <raltherr@google.com>
> wrote:
> >> Signed-off-by: Rick Altherr <raltherr@google.com>
> >> ---
> >
> > Acked-by: Joel Stanley <joel@jms.id.au>
> I can't see why Rob would mind any of the changes made since he
> Acked this (and having acked it I doubt he is looking at newer versions!)
> so I'm going to take the view his Ack still applies.
>
> Applied to the togreg branch of iio.git which will get pushed out first
> as testing for the autobuilders to have a chance to play with it.
>
> Thanks,
>
> Jonathan
>

Thanks!  I realized I forgot to include Acks when I sent out later
versions.  I'll be more careful on that for future patches.


> >
> >>
> >> Changes in v5: None
> >> Changes in v4: None
> >> Changes in v3:
> >> - Consistently write hex contstants with lowercase letters
> >> - Drop model numbers from description as same IP is used in every
> generation
> >>
> >> Changes in v2:
> >> - Rewritten as an IIO ADC device
> >>
> >>  .../devicetree/bindings/iio/adc/aspeed_adc.txt       | 20
> ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>  create mode 100644 Documentation/devicetree/
> bindings/iio/adc/aspeed_adc.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> >> new file mode 100644
> >> index 000000000000..674e133b7cd7
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/adc/aspeed_adc.txt
> >> @@ -0,0 +1,20 @@
> >> +Aspeed ADC
> >> +
> >> +This device is a 10-bit converter for 16 voltage channels.  All inputs
> are
> >> +single ended.
> >> +
> >> +Required properties:
> >> +- compatible: Should be "aspeed,ast2400-adc" or "aspeed,ast2500-adc"
> >> +- reg: memory window mapping address and length
> >> +- clocks: Input clock used to derive the sample clock. Expected to be
> the
> >> +          SoC's APB clock.
> >> +- #io-channel-cells: Must be set to <1> to indicate channels are
> selected
> >> +                     by index.
> >> +
> >> +Example:
> >> +       adc@1e6e9000 {
> >> +               compatible = "aspeed,ast2400-adc";
> >> +               reg = <0x1e6e9000 0xb0>;
> >> +               clocks = <&clk_apb>;
> >> +               #io-channel-cells = <1>;
> >> +       };
> >> --
> >> 2.12.2.564.g063fe858b8-goog
> >>
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
>
>

--001a114b3ebcd42e28054c46537c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sat, Apr 1, 2017 at 3:51 AM, Jonathan Cameron <span dir=3D"ltr">&lt;=
<a href=3D"mailto:jic23@kernel.org" target=3D"_blank">jic23@kernel.org</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 29/=
03/17 03:33, Joel Stanley wrote:<br>
&gt; On Wed, Mar 29, 2017 at 8:22 AM, Rick Altherr &lt;<a href=3D"mailto:ra=
ltherr@google.com">raltherr@google.com</a>&gt; wrote:<br>
&gt;&gt; Signed-off-by: Rick Altherr &lt;<a href=3D"mailto:raltherr@google.=
com">raltherr@google.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;<br>
&gt; Acked-by: Joel Stanley &lt;<a href=3D"mailto:joel@jms.id.au">joel@jms.=
id.au</a>&gt;<br>
</span>I can&#39;t see why Rob would mind any of the changes made since he<=
br>
Acked this (and having acked it I doubt he is looking at newer versions!)<b=
r>
so I&#39;m going to take the view his Ack still applies.<br>
<br>
Applied to the togreg branch of iio.git which will get pushed out first<br>
as testing for the autobuilders to have a chance to play with it.<br>
<br>
Thanks,<br>
<br>
Jonathan<br></blockquote><div><br></div><div>Thanks!=C2=A0 I realized I for=
got to include Acks when I sent out later versions.=C2=A0 I&#39;ll be more =
careful on that for future patches.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">&gt;<br>
&gt;&gt;<br>
&gt;&gt; Changes in v5: None<br>
&gt;&gt; Changes in v4: None<br>
&gt;&gt; Changes in v3:<br>
&gt;&gt; - Consistently write hex contstants with lowercase letters<br>
&gt;&gt; - Drop model numbers from description as same IP is used in every =
generation<br>
&gt;&gt;<br>
&gt;&gt; Changes in v2:<br>
&gt;&gt; - Rewritten as an IIO ADC device<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 .../devicetree/bindings/iio/<wbr>adc/aspeed_adc.txt=C2=A0 =
=C2=A0 =C2=A0 =C2=A0| 20 ++++++++++++++++++++<br>
&gt;&gt;=C2=A0 1 file changed, 20 insertions(+)<br>
&gt;&gt;=C2=A0 create mode 100644 Documentation/devicetree/<wbr>bindings/ii=
o/adc/aspeed_adc.<wbr>txt<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/Documentation/devicetree/<wbr>bindings/iio/adc/aspeed=
_adc.<wbr>txt b/Documentation/devicetree/<wbr>bindings/iio/adc/aspeed_adc.<=
wbr>txt<br>
&gt;&gt; new file mode 100644<br>
&gt;&gt; index 000000000000..674e133b7cd7<br>
&gt;&gt; --- /dev/null<br>
&gt;&gt; +++ b/Documentation/devicetree/<wbr>bindings/iio/adc/aspeed_adc.<w=
br>txt<br>
&gt;&gt; @@ -0,0 +1,20 @@<br>
&gt;&gt; +Aspeed ADC<br>
&gt;&gt; +<br>
&gt;&gt; +This device is a 10-bit converter for 16 voltage channels.=C2=A0 =
All inputs are<br>
&gt;&gt; +single ended.<br>
&gt;&gt; +<br>
&gt;&gt; +Required properties:<br>
&gt;&gt; +- compatible: Should be &quot;aspeed,ast2400-adc&quot; or &quot;a=
speed,ast2500-adc&quot;<br>
&gt;&gt; +- reg: memory window mapping address and length<br>
&gt;&gt; +- clocks: Input clock used to derive the sample clock. Expected t=
o be the<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SoC&#39;s APB clock.<br>
&gt;&gt; +- #io-channel-cells: Must be set to &lt;1&gt; to indicate channel=
s are selected<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0by index.<br>
&gt;&gt; +<br>
&gt;&gt; +Example:<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0adc@1e6e9000 {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compatible=
 =3D &quot;aspeed,ast2400-adc&quot;;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0reg =3D &l=
t;0x1e6e9000 0xb0&gt;;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clocks =3D=
 &lt;&amp;clk_apb&gt;;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#io-channe=
l-cells =3D &lt;1&gt;;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
&gt;&gt; --<br>
&gt;&gt; 2.12.2.564.g063fe858b8-goog<br>
&gt;&gt;<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">&gt; --<br>
&gt; To unsubscribe from this list: send the line &quot;unsubscribe linux-i=
io&quot; in<br>
&gt; the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">=
majordomo@vger.kernel.org</a><br>
&gt; More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordo=
mo-info.html" rel=3D"noreferrer" target=3D"_blank">http://vger.kernel.org/<=
wbr>majordomo-info.html</a><br>
&gt;<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a114b3ebcd42e28054c46537c--
