Return-Path: <SRS0=JqCa=3S=google.com=raltherr@kernel.org>
MIME-Version: 1.0
In-Reply-To: <b1919652-4db7-0373-278b-483357968e7e@kernel.org>
References: <20170328215259.31622-1-raltherr@google.com> <20170328215259.31622-2-raltherr@google.com>
 <d05cadfe-e3d3-f4e8-129f-19dcd2f637da@kernel.org> <20170405215046.GE7065@codeaurora.org>
 <b1919652-4db7-0373-278b-483357968e7e@kernel.org>
From: Rick Altherr <raltherr@google.com>
Date: Mon, 10 Apr 2017 09:34:33 -0700
Message-ID: <CAPLgG=kQ-ZaG5W46A8sdtMdOGk7-8jpqTtFNTE_OwfnsYXhC9A@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: Aspeed ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	William Breathitt Gray <vilhelm.gray@gmail.com>, Michael Turquette <mturquette@baylibre.com>,
	Andreas Klinger <ak@it-klinger.de>, Rob Herring <robh@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Quentin Schulz <quentin.schulz@free-electrons.com>,
	linux-iio@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>,
	Scott Branden <scott.branden@broadcom.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>, Akinobu Mita <akinobu.mita@gmail.com>,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Hartmut Knaack <knaack.h@gmx.de>, linux-clk@vger.kernel.org
Content-Type: multipart/alternative; boundary=f403045f155eee357f054cd28c53
List-ID: <linux-iio@vger.kernel.org>

--f403045f155eee357f054cd28c53
Content-Type: text/plain; charset=UTF-8

I don't believe there are any bindings changes or a need to revert.
Stephen's suggested changes are small improvements that make the driver
suitable for non-DT platforms (not an issue anytime soon) and help with a
planned refactor of the clk_hw structure.  I'll send out follow-up changes
when Stephen and I have reached consensus on how to resolve the latter
improvement.

On Sat, Apr 8, 2017 at 9:15 AM, Jonathan Cameron <jic23@kernel.org> wrote:

> On 05/04/17 22:50, Stephen Boyd wrote:
> > On 04/01, Jonathan Cameron wrote:
> >> On 28/03/17 22:52, Rick Altherr wrote:
> >>> Aspeed BMC SoCs include a 16 channel, 10-bit ADC. Low and high
> threshold
> >>> interrupts are supported by the hardware but are not currently
> implemented.
> >>>
> >>> Signed-off-by: Rick Altherr <raltherr@google.com>
> >> Two really trivial things inline. I'll fix them whilst applying rather
> than
> >> having you do a v6 - please do sanity check I haven't messed it up
> though!
> >>
> >> Applied to the togreg branch of iio.git and pushed out as testing for
> >> the autobuilders to play with it.
> >>
> >
> > Oh I was too late. Blame work. Anyway, I made some comments on
> > v4. If they're fixed in a later patch or discussed on list that's
> > fine. No worries on my end.
> >
> Oops. I went a bit quick on this one I guess.
>
> Anyhow, from a quick read of your comments I'm not sure if any of
> them are such that we should revert.  Perhaps we Rick can prepare
> a follow up patch covering them?  I got a little lost so am not
> sure but if there is anything effecting bindings Rick, please
> get this through asap or let me know if we need to revert for now.
> Even if it is a case of adding a bit of binding and following up
> with the code using it a bit later.
>
> I'd asked for input on the clock stuff then forgot all about it on
> the later version. Sorry about that!
>
> Jonathan
>

--f403045f155eee357f054cd28c53
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I don&#39;t believe there are any bindings changes or a ne=
ed to revert.=C2=A0 Stephen&#39;s suggested changes are small improvements =
that make the driver suitable for non-DT platforms (not an issue anytime so=
on) and help with a planned refactor of the clk_hw structure.=C2=A0 I&#39;l=
l send out follow-up changes when Stephen and I have reached consensus on h=
ow to resolve the latter improvement.</div><div class=3D"gmail_extra"><br><=
div class=3D"gmail_quote">On Sat, Apr 8, 2017 at 9:15 AM, Jonathan Cameron =
<span dir=3D"ltr">&lt;<a href=3D"mailto:jic23@kernel.org" target=3D"_blank"=
>jic23@kernel.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
span class=3D"">On 05/04/17 22:50, Stephen Boyd wrote:<br>
&gt; On 04/01, Jonathan Cameron wrote:<br>
&gt;&gt; On 28/03/17 22:52, Rick Altherr wrote:<br>
&gt;&gt;&gt; Aspeed BMC SoCs include a 16 channel, 10-bit ADC. Low and high=
 threshold<br>
&gt;&gt;&gt; interrupts are supported by the hardware but are not currently=
 implemented.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Rick Altherr &lt;<a href=3D"mailto:raltherr@goo=
gle.com">raltherr@google.com</a>&gt;<br>
&gt;&gt; Two really trivial things inline. I&#39;ll fix them whilst applyin=
g rather than<br>
&gt;&gt; having you do a v6 - please do sanity check I haven&#39;t messed i=
t up though!<br>
&gt;&gt;<br>
&gt;&gt; Applied to the togreg branch of iio.git and pushed out as testing =
for<br>
&gt;&gt; the autobuilders to play with it.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Oh I was too late. Blame work. Anyway, I made some comments on<br>
&gt; v4. If they&#39;re fixed in a later patch or discussed on list that&#3=
9;s<br>
&gt; fine. No worries on my end.<br>
&gt;<br>
</span>Oops. I went a bit quick on this one I guess.<br>
<br>
Anyhow, from a quick read of your comments I&#39;m not sure if any of<br>
them are such that we should revert.=C2=A0 Perhaps we Rick can prepare<br>
a follow up patch covering them?=C2=A0 I got a little lost so am not<br>
sure but if there is anything effecting bindings Rick, please<br>
get this through asap or let me know if we need to revert for now.<br>
Even if it is a case of adding a bit of binding and following up<br>
with the code using it a bit later.<br>
<br>
I&#39;d asked for input on the clock stuff then forgot all about it on<br>
the later version. Sorry about that!<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Jonathan<br>
</font></span></blockquote></div><br></div>

--f403045f155eee357f054cd28c53--
