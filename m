Return-Path: <SRS0=UtO/=M3=gmail.com=capellaresumo@kernel.org>
MIME-Version: 1.0
References: <20181006162715.GA8476@mantaray> <20181006202542.GC5035@x220.localdomain>
 <20181011073203.iesapekyqkma2cqa@mwanda> <20181011153152.GA1544@x220.localdomain>
In-Reply-To: <20181011153152.GA1544@x220.localdomain>
From: Gabriel Capella <gabriel@capella.pro>
Date: Mon, 15 Oct 2018 18:45:16 -0300
Message-ID: <CAHBXrbn-AhtnuGJBKRQ=da3m1JZpOmWOgVb79nhwcYW-GJOH8A@mail.gmail.com>
Subject: Re: [PATCH] staging: iio: adc: ad7280a: fix 2 checks
To: sst@poczta.fm
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
	dan.carpenter@oracle.com
Content-Type: multipart/alternative; boundary="0000000000004f154e05784b5a67"
List-ID: <linux-iio@vger.kernel.org>

--0000000000004f154e05784b5a67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

A few minutes ago a sent a patch adding this comment in two different
files.

Thank you for the suggestions.

Em qui, 11 de out de 2018 =C3=A0s 12:32, Slawomir Stepien <sst@poczta.fm>
escreveu:

> On pa=C5=BA 11, 2018 10:32, Dan Carpenter wrote:
> > On Sat, Oct 06, 2018 at 10:25:42PM +0200, Slawomir Stepien wrote:
> > > On pa=C5=BA 06, 2018 13:27, Gabriel Capella wrote:
> > > > This patch does not change the logic, it only
> > > > corrects the checkpatch checks.
> > > >
> > > > The patch fixes 2 checks of type:
> > > > "CHECK: spaces preferred around that '-'"
> > >
> > > I've made the same mistake few days ago. This change is incorrect.
> > > Please see: https://lore.kernel.org/patchwork/patch/635994/.
> > >
> >
> > You could add a comment.  /* do not put spaces around the hyphen.  #
> checkpatch.pl */
> >
> > These are the only places which use this style and a lot of people
> > bump into it.
>
> Gabriel go ahead if you want to. If not then I would be happy to prepare
> this
> patch.
>
> --
> Slawomir Stepien
>


--=20
Gabriel Capella
gabrielcapella.com
hardwarelivreusp.org
+55 11 98124-5668

--0000000000004f154e05784b5a67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace"><div class=3D"gmail_default" style=3D"font-family:Arial,Helvet=
ica,sans-serif"><font face=3D"monospace, monospace">A few minutes ago a sen=
t a patch adding this comment in two different files.=C2=A0</font></div><di=
v class=3D"gmail_default" style=3D"font-family:Arial,Helvetica,sans-serif">=
<font face=3D"monospace, monospace"><br></font></div><div class=3D"gmail_de=
fault" style=3D"font-family:Arial,Helvetica,sans-serif"><font face=3D"monos=
pace, monospace">Thank you for the suggestions.=C2=A0</font></div></div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr">Em qui, 11 de out de 201=
8 =C3=A0s 12:32, Slawomir Stepien &lt;<a href=3D"mailto:sst@poczta.fm">sst@=
poczta.fm</a>&gt; escreveu:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On pa=
=C5=BA 11, 2018 10:32, Dan Carpenter wrote:<br>
&gt; On Sat, Oct 06, 2018 at 10:25:42PM +0200, Slawomir Stepien wrote:<br>
&gt; &gt; On pa=C5=BA 06, 2018 13:27, Gabriel Capella wrote:<br>
&gt; &gt; &gt; This patch does not change the logic, it only<br>
&gt; &gt; &gt; corrects the checkpatch checks.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The patch fixes 2 checks of type:<br>
&gt; &gt; &gt; &quot;CHECK: spaces preferred around that &#39;-&#39;&quot;<=
br>
&gt; &gt; <br>
&gt; &gt; I&#39;ve made the same mistake few days ago. This change is incor=
rect.<br>
&gt; &gt; Please see: <a href=3D"https://lore.kernel.org/patchwork/patch/63=
5994/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.org/patchwo=
rk/patch/635994/</a>.<br>
&gt; &gt;<br>
&gt; <br>
&gt; You could add a comment.=C2=A0 /* do not put spaces around the hyphen.=
=C2=A0 #<a href=3D"http://checkpatch.pl" rel=3D"noreferrer" target=3D"_blan=
k">checkpatch.pl</a> */<br>
&gt; <br>
&gt; These are the only places which use this style and a lot of people<br>
&gt; bump into it.<br>
<br>
Gabriel go ahead if you want to. If not then I would be happy to prepare th=
is<br>
patch.<br>
<br>
-- <br>
Slawomir Stepien<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><font face=3D"monospace, mo=
nospace">Gabriel Capella</font><div><a href=3D"http://gabrielcapella.com" t=
arget=3D"_blank"><font face=3D"monospace, monospace">gabrielcapella.com</fo=
nt></a></div><div><a href=3D"http://hardwarelivreusp.org" target=3D"_blank"=
><font face=3D"monospace, monospace">hardwarelivreusp.org<br></font></a></d=
iv><div><font face=3D"monospace, monospace">+55 11 98124-5668</font></div><=
/div></div></div></div></div></div>

--0000000000004f154e05784b5a67--
