Return-Path: <victorcolombo@gmail.com>
MIME-Version: 1.0
References: <CAHd-oW7fA_1H3jnUTOhs7VXJ3Zciq6j2WthAytE39NedYpTibg@mail.gmail.com>
 <20181023104554.155dcdcf@archlinux>
In-Reply-To: <20181023104554.155dcdcf@archlinux>
From: Victor Colombo <victorcolombo@gmail.com>
Date: Fri, 26 Oct 2018 03:35:34 -0300
Message-ID: <CADGsZakW=0BRnuYx47mQVxzjcTbP+80wjaFt_ZB1pY3G6_TfQw@mail.gmail.com>
Subject: Re: Work plan on ad2s90
To: jic23@jic23.retrosnub.co.uk
Cc: Matheus Tavares Bernardino <matheus.bernardino@usp.br>, linux-iio@vger.kernel.org,
	kernel-usp@googlegroups.com
Content-Type: multipart/alternative; boundary="0000000000006308d505791beff7"
List-ID: <linux-iio@vger.kernel.org>

--0000000000006308d505791beff7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

Thank you for the insights! We have sent a patch set addressing the points
you brought up, except the device tree one.

We didn't quite get what needs to be done on the device tree. Do you have
some pointers to help us with that?

Best,
Victor

Em ter, 23 de out de 2018 =C3=A0s 06:45, Jonathan Cameron <
jic23@jic23.retrosnub.co.uk> escreveu:

> On Fri, 19 Oct 2018 23:49:06 -0300
> Matheus Tavares Bernardino <matheus.bernardino@usp.br> wrote:
>
> > Hello everyone.
> Hi Matheus.
> >
> > I'm looking at the code and datasheet of ad2s90, trying to understand
> > what is needed to move it to the main tree. I and my study group
> > intend to work on it.
>
> Great,
>
> >
> > I do not understand all the necessary steps yet, but I will present
> > here some brief items for discussion. I'd like to ask if I'm on the
> > right track. All feedback will be much appreciated.
> >
> > Some of the things that I think need to be done:
> > - The IIO_CHAN_INFO_SCALE information mask is not set yet
> Good point, that should be possible to establish for a resolver.
>
> > - The read_raw function does not return the error code returned by
> > spi_read on failure
> Good spot (I missed that one at first glance ;)
>
> > - There is no channel for velocity yet
>
> I'm fairly sure that's because the device doesn't allow you to read that
> via the serial bus.  There is an analog velocity outlook so you could
> read it via an ADC and do the appropriate chaining of IIO devices
> to provide that in this driver, but I wouldn't necessarily suggest doing
> that without some hardware to test it.
>
> > - There are two minor codestyle corrections to be made
> > - Maybe it's possible to change the bit operations at the read_raw for
> > a bitops.h function call
> Not really.  It is a weird form of shifted endian conversion, so you
> 'could' do it that way and in theory make it a single shift in once case
> and swap and shift in the other.  Probably not worth it though.
>
> a few additions.
> * Devicetree support with standard devicetree id table.
>
> * The spi setup at the end of probe occurs 'after' the device is ready
> for use.  A definite race condition that needs fixing.
>
> * Some pointless variable initial assignments that are always overwritten=
.
>
> >
> > Best regards,
> > Matheus
>
> Thanks,
>
> Jonathan
>

--0000000000006308d505791beff7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi Jonathan,</div><div><br></div><di=
v>Thank you for the insights! We have sent a patch set addressing the point=
s you brought up, except the device tree one.</div><div><br></div><div>We d=
idn&#39;t quite get what needs to be done on the device tree. Do you have s=
ome pointers to help us with that?</div><div><br></div><div>Best,</div><div=
>Victor</div><div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr">Em t=
er, 23 de out de 2018 =C3=A0s 06:45, Jonathan Cameron &lt;<a href=3D"mailto=
:jic23@jic23.retrosnub.co.uk" target=3D"_blank">jic23@jic23.retrosnub.co.uk=
</a>&gt; escreveu:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">On Fri, 19 Oct 2018 23:49:06 -0300<br>
Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.bernardino@usp.br"=
 target=3D"_blank">matheus.bernardino@usp.br</a>&gt; wrote:<br>
<br>
&gt; Hello everyone.<br>
Hi Matheus.<br>
&gt; <br>
&gt; I&#39;m looking at the code and datasheet of ad2s90, trying to underst=
and<br>
&gt; what is needed to move it to the main tree. I and my study group<br>
&gt; intend to work on it.<br>
<br>
Great,<br>
<br>
&gt; <br>
&gt; I do not understand all the necessary steps yet, but I will present<br=
>
&gt; here some brief items for discussion. I&#39;d like to ask if I&#39;m o=
n the<br>
&gt; right track. All feedback will be much appreciated.<br>
&gt; <br>
&gt; Some of the things that I think need to be done:<br>
&gt; - The IIO_CHAN_INFO_SCALE information mask is not set yet<br>
Good point, that should be possible to establish for a resolver.<br>
<br>
&gt; - The read_raw function does not return the error code returned by<br>
&gt; spi_read on failure<br>
Good spot (I missed that one at first glance ;)<br>
<br>
&gt; - There is no channel for velocity yet<br>
<br>
I&#39;m fairly sure that&#39;s because the device doesn&#39;t allow you to =
read that<br>
via the serial bus.=C2=A0 There is an analog velocity outlook so you could<=
br>
read it via an ADC and do the appropriate chaining of IIO devices<br>
to provide that in this driver, but I wouldn&#39;t necessarily suggest doin=
g<br>
that without some hardware to test it.<br>
<br>
&gt; - There are two minor codestyle corrections to be made<br>
&gt; - Maybe it&#39;s possible to change the bit operations at the read_raw=
 for<br>
&gt; a bitops.h function call<br>
Not really.=C2=A0 It is a weird form of shifted endian conversion, so you<b=
r>
&#39;could&#39; do it that way and in theory make it a single shift in once=
 case<br>
and swap and shift in the other.=C2=A0 Probably not worth it though.<br>
<br>
a few additions.<br>
* Devicetree support with standard devicetree id table.<br>
<br>
* The spi setup at the end of probe occurs &#39;after&#39; the device is re=
ady<br>
for use.=C2=A0 A definite race condition that needs fixing.<br>
<br>
* Some pointless variable initial assignments that are always overwritten.<=
br>
<br>
&gt; <br>
&gt; Best regards,<br>
&gt; Matheus<br>
<br>
Thanks,<br>
<br>
Jonathan<br>
</blockquote></div></div></div></div></div>

--0000000000006308d505791beff7--
