Return-Path: <SRS0=yyGB=7U=gmail.com=s.abhisit@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170818025835.GE19152@localhost>
References: <1501578742-4501-1-git-send-email-s.abhisit@gmail.com>
 <alpine.DEB.2.20.1708011317000.5987@vps.pmeerw.net> <20170811143847.GA19152@localhost>
 <CAMV_pUa0XvzNYcR0ryHSt=qsdLKCtOLfQNz3LsWxaj9VGmFxLw@mail.gmail.com> <20170818025835.GE19152@localhost>
From: Abhisit Sangjan <s.abhisit@gmail.com>
Date: Fri, 18 Aug 2017 10:15:29 +0700
Message-ID: <CAMV_pUYqGnDQmn+j9y85e9y8f7nuewAHTnDxm-goJ+mW-kMhUg@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: Add support for LMP92001 ADC
To: jmondi <jacopo@jmondi.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	fabrice.gasnier@st.com, Lee Jones <lee.jones@linaro.org>, robh@kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>, marek.vasut+renesas@gmail.com,
	jacopo+renesas@jmondi.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary="f403045ec4328cc73c0556fe8ae2"
List-ID: <linux-iio@vger.kernel.org>

--f403045ec4328cc73c0556fe8ae2
Content-Type: text/plain; charset="UTF-8"

Hi Jmondi,

On Fri, Aug 18, 2017 at 9:58 AM, jmondi <jacopo@jmondi.org> wrote:

> Hi Abhisit,
>
> On Fri, Aug 18, 2017 at 09:34:16AM +0700, Abhisit Sangjan wrote:
> > Hi Jmondi,
> >
> > Thank you for your recommend, I am testing the code will be send the new
> > patch in soon.
>
> [snip]
>
> > > > > +
> > > > > +        switch (mask)
> > > > > +        {
> > > > > +        case IIO_CHAN_INFO_RAW:
> > > > > +                switch (channel->type) {
> > > > > +                case IIO_VOLTAGE:
> > > > > +                case IIO_TEMP:
> > > > > +                        *val = code;
> > > > > +                        return IIO_VAL_INT;
> > > > > +                default:
> > > > > +                        break;
> > > > > +                }
> > > > > +                break;
> > > > > +        default:
> > > > > +                break;
> > >
> > > You can remove these default cases or return -EINVAL here.
> > >
> >
> > Abhisit: Okay, I will remove it.
> >              Could you tell me in detail. Sorry, I do not understand the
> > Technical.
>
> This can potentially be reduced to
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
>                 switch (channel->type) {
>                 case IIO_VOLTAGE:
>                 case IIO_TEMP:
>                         *val = code;
>                         return IIO_VAL_INT;
>                 }
>          }
>
>          return -EINVAL;
>
>
> But that's definitely not a big deal, there are no optimization in
> this code change, just less typing and less default: and break; here
> and there
>

Abhisit: Thank you so much.

--f403045ec4328cc73c0556fe8ae2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jmondi,<br><div class=3D"gmail_extra"><br><div class=3D=
"gmail_quote">On Fri, Aug 18, 2017 at 9:58 AM, jmondi <span dir=3D"ltr">&lt=
;<a href=3D"mailto:jacopo@jmondi.org" target=3D"_blank">jacopo@jmondi.org</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i Abhisit,<br>
<span class=3D"gmail-"><br>
On Fri, Aug 18, 2017 at 09:34:16AM +0700, Abhisit Sangjan wrote:<br>
&gt; Hi Jmondi,<br>
&gt;<br>
&gt; Thank you for your recommend, I am testing the code will be send the n=
ew<br>
&gt; patch in soon.<br>
<br>
</span>[snip]<br>
<span class=3D"gmail-"><br>
&gt; &gt; &gt; &gt; +<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (mask)<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_CHAN_INFO_RAW:<br=
>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 switch (channel-&gt;type) {<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 case IIO_VOLTAGE:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 case IIO_TEMP:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *val =3D code;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IIO_VAL_INT;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 break;<br>
&gt; &gt;<br>
&gt; &gt; You can remove these default cases or return -EINVAL here.<br>
&gt; &gt;<br>
&gt;<br>
&gt; Abhisit: Okay, I will remove it.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Could you tell me in d=
etail. Sorry, I do not understand the<br>
&gt; Technical.<br>
<br>
</span>This can potentially be reduced to<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (mask) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_CHAN_INFO_RAW:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (channel-&gt=
;type) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_VOLTAGE:<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_TEMP:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 *val =3D code;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return IIO_VAL_INT;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
<br>
<br>
But that&#39;s definitely not a big deal, there are no optimization in<br>
this code change, just less typing and less default: and break; here<br>
and there<br></blockquote><div><br></div><div>Abhisit: Thank you so much.</=
div><div>=C2=A0</div></div><br></div></div>

--f403045ec4328cc73c0556fe8ae2--
