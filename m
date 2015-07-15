Return-Path: <gizero@gmail.com>
MIME-Version: 1.0
In-Reply-To: <50E24B24-6DC9-4ECB-8752-B974BD6C53E8@kernel.org>
References: <1436880983-29017-1-git-send-email-gizero@gmail.com>
	<50E24B24-6DC9-4ECB-8752-B974BD6C53E8@kernel.org>
Date: Wed, 15 Jul 2015 07:07:27 +0200
Message-ID: <CAC+thW18COMt48VYwMOSMgP8huSRfhu7RLFvpObkAWVAWkS8Uw@mail.gmail.com>
Subject: Re: [PATCH 1/4] iio: adc: mcp320x: add masking of unknown bits
From: Andrea Galbusera <gizero@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a11c37f7e5b2432051ae2ee09
List-ID: <linux-iio@vger.kernel.org>

--001a11c37f7e5b2432051ae2ee09
Content-Type: text/plain; charset=UTF-8

On Tue, Jul 14, 2015 at 11:04 PM, Jonathan Cameron <jic23@kernel.org> wrote:

>
>
> On 14 July 2015 14:36:20 BST, Andrea Galbusera <gizero@gmail.com> wrote:
> >According to the datasheet, the 2 MSBs for parts 3001 and 3201 are
> >unspecified and should be masked out
> Theoretical issue or one with observed bad effects?
>

Hi! Thanks for reviewing. While in the business of adding support for 3301,
I couldn't figure out why no masking wasn't done for similar parts like
3001 and 3201. Further investigation of previous patches reviews [1], where
masking was suggested and initially implemented, convinced me the bit was
lost somewhere, with no explicit motivation. Nevertheless, 3301 is the only
chip of the family I have at hands: hence, yes, this specific patch in the
set is addressing a theoretical issue.

[1] http://marc.info/?l=linux-iio&m=140748835509583&w=2


> Changes the path and timing of this getting applied. Patch itself is fine
> either way!
> >
> >Signed-off-by: Andrea Galbusera <gizero@gmail.com>
> >---
> >
> >This was already suggested but for some reason got lost during review
> >of a
> >previous patch. See http://marc.info/?l=linux-iio&m=140748835509583&w=2
> >and following discussion
> >
> > drivers/iio/adc/mcp320x.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> >index 8d9c9b9..0673ee7 100644
> >--- a/drivers/iio/adc/mcp320x.c
> >+++ b/drivers/iio/adc/mcp320x.c
> >@@ -114,13 +114,13 @@ static int mcp320x_adc_conversion(struct mcp320x
> >*adc, u8 channel,
> >
> >       switch (device_index) {
> >       case mcp3001:
> >-              return (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
> >+              return ((adc->rx_buf[0] & 0x1f) << 5 | adc->rx_buf[1] >>
> 3);
> >       case mcp3002:
> >       case mcp3004:
> >       case mcp3008:
> >               return (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
> >       case mcp3201:
> >-              return (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
> >+              return ((adc->rx_buf[0] & 0x1f) << 7 | adc->rx_buf[1] >>
> 1);
> >       case mcp3202:
> >       case mcp3204:
> >       case mcp3208:
>
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
>

--001a11c37f7e5b2432051ae2ee09
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On T=
ue, Jul 14, 2015 at 11:04 PM, Jonathan Cameron <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:jic23@kernel.org" target=3D"_blank">jic23@kernel.org</a>&gt;</s=
pan> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-lef=
t-style:solid;padding-left:1ex"><span class=3D""><br>
<br>
On 14 July 2015 14:36:20 BST, Andrea Galbusera &lt;<a href=3D"mailto:gizero=
@gmail.com">gizero@gmail.com</a>&gt; wrote:<br>
&gt;According to the datasheet, the 2 MSBs for parts 3001 and 3201 are<br>
&gt;unspecified and should be masked out<br>
</span>Theoretical issue or one with observed bad effects?<br></blockquote>=
<div><br></div><div style=3D"font-size:12.8000001907349px">Hi! Thanks for r=
eviewing. While in the business of adding support for 3301, I couldn&#39;t =
figure out why no masking wasn&#39;t done for similar parts like 3001 and 3=
201. Further investigation of previous patches reviews [1], where masking w=
as suggested and initially implemented, convinced me the bit was lost somew=
here, with no explicit motivation. Nevertheless, 3301 is the only chip of t=
he family I have at hands: hence, yes, this specific patch in the set is ad=
dressing a theoretical issue.=C2=A0</div><div style=3D"font-size:12.8000001=
907349px">=C2=A0</div><div><span style=3D"font-size:12.8000001907349px">[1]=
=C2=A0</span><a href=3D"http://marc.info/?l=3Dlinux-iio&amp;m=3D14074883550=
9583&amp;w=3D2" rel=3D"noreferrer" target=3D"_blank" style=3D"font-size:12.=
8000001907349px">http://marc.info/?l=3Dlinux-iio&amp;m=3D140748835509583&am=
p;w=3D2</a>=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rg=
b(204,204,204);border-left-style:solid;padding-left:1ex">
Changes the path and timing of this getting applied. Patch itself is fine e=
ither way!<br>
<div><div class=3D"h5">&gt;<br>
&gt;Signed-off-by: Andrea Galbusera &lt;<a href=3D"mailto:gizero@gmail.com"=
>gizero@gmail.com</a>&gt;<br>
&gt;---<br>
&gt;<br>
&gt;This was already suggested but for some reason got lost during review<b=
r>
&gt;of a<br>
&gt;previous patch. See <a href=3D"http://marc.info/?l=3Dlinux-iio&amp;m=3D=
140748835509583&amp;w=3D2" rel=3D"noreferrer" target=3D"_blank">http://marc=
.info/?l=3Dlinux-iio&amp;m=3D140748835509583&amp;w=3D2</a><br>
&gt;and following discussion<br>
&gt;<br>
&gt; drivers/iio/adc/mcp320x.c | 4 ++--<br>
&gt; 1 file changed, 2 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt;diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c<br>
&gt;index 8d9c9b9..0673ee7 100644<br>
&gt;--- a/drivers/iio/adc/mcp320x.c<br>
&gt;+++ b/drivers/iio/adc/mcp320x.c<br>
&gt;@@ -114,13 +114,13 @@ static int mcp320x_adc_conversion(struct mcp320x<=
br>
&gt;*adc, u8 channel,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (device_index) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case mcp3001:<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (adc-&gt;rx_bu=
f[0] &lt;&lt; 5 | adc-&gt;rx_buf[1] &gt;&gt; 3);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ((adc-&gt;rx_b=
uf[0] &amp; 0x1f) &lt;&lt; 5 | adc-&gt;rx_buf[1] &gt;&gt; 3);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case mcp3002:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case mcp3004:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case mcp3008:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return (adc-&gt;=
rx_buf[0] &lt;&lt; 2 | adc-&gt;rx_buf[1] &gt;&gt; 6);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case mcp3201:<br>
&gt;-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (adc-&gt;rx_bu=
f[0] &lt;&lt; 7 | adc-&gt;rx_buf[1] &gt;&gt; 1);<br>
&gt;+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ((adc-&gt;rx_b=
uf[0] &amp; 0x1f) &lt;&lt; 7 | adc-&gt;rx_buf[1] &gt;&gt; 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case mcp3202:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case mcp3204:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case mcp3208:<br>
<br>
--<br>
</div></div>Sent from my Android device with K-9 Mail. Please excuse my bre=
vity.<br>
</blockquote></div><br></div></div>

--001a11c37f7e5b2432051ae2ee09--
