Return-Path: <steve@pressers.name>
MIME-Version: 1.0
References: <010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com>
 <20171210182152.70ad8fbf@archlinux> <01000160dccefcb4-25edfd89-56f3-486f-88a4-cb8c07253974-000000@email.amazonses.com>
 <20180114104330.2aa7c1fd@archlinux> <20180128094021.572ab366@archlinux>
 <CAHp75VenBEYSZ9okZfGZUmBX+ikL236a9_qjtn-DJtSihw5X+g@mail.gmail.com>
 <20180130160107.000006df@huawei.com> <CAHp75VchRJzp1CM33q18e9x8Uq7bNrPZykz-GdpRgB3=y2C+KQ@mail.gmail.com>
 <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
In-Reply-To: <CAHp75Vf==OQ=Cx4Nzrd+vAOJshT-oL6L8Y54aWt0cGyJJuacjg@mail.gmail.com>
From: Steve Presser <steve@pressers.name>
Date: Tue, 30 Jan 2018 17:25:32 +0000
Message-ID: <CADXBfmvKF_doLv0Vg0TY4cH_rDBEP5NvJ4jHJf85iuOjJB6TzA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: Check for a second ACPI device for BOSC0200
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Jeremy Cline <jeremy@jcline.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Lars Kellogg-Stedman <lars@oddbit.com>,
	Lars-Peter Clausen <lars@metafoo.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary="089e082409a8038682056401a711"
List-ID: <linux-iio@vger.kernel.org>

--089e082409a8038682056401a711
Content-Type: text/plain; charset="UTF-8"

Andy,

Where did the assertion the second device is a magnetometer come from? Just
the data sheet?

Steve

On Tue, Jan 30, 2018, 12:05 PM Andy Shevchenko <andy.shevchenko@gmail.com>
wrote:

> On Tue, Jan 30, 2018 at 6:40 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jan 30, 2018 at 6:01 PM, Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> >> On Mon, 29 Jan 2018 16:07:02 +0200
> >> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> >>> > But that would take much longer.  Feel free to propose it and a patch
> >>> > removing the ifdef fun if you like!
> >
> >>> Where can I see the patch?
> >
> >> Doh. I clearly forgot to push out.  Should be able to push to
> >> iio.git on kernel.org later.
> >
> > Thanks, I can see it now.
> >
> > This patch almost wrong. Not by functionality it brings, but by style.
>
> Oy vey, the second device is *not* accelerometer, it is a magnetometer [1].
>
> [1]: https://www.mouser.com/ds/2/783/BST-BMC150-DS000-04-786477.pdf
>
> > I'll send soon a series of fixes to the driver (compile tested only)
> > to provide my view on the matters.
> >
> > P.S. In the future (I have some kind of deja vu I have told this
> > already to someone), please, Cc one or more of Rafael, Mika and/or me
> > for ACPI matters.
>
> --
> With Best Regards,
> Andy Shevchenko
>

--089e082409a8038682056401a711
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Andy,</div><span>
</span><p dir=3D"ltr">Where did the assertion the second device is a magnet=
ometer come from? Just the data sheet?</p><span>
</span><p dir=3D"ltr">Steve</p><span>
</span><br><div class=3D"gmail_quote"><div dir=3D"ltr">On Tue, Jan 30, 2018=
, 12:05 PM Andy Shevchenko &lt;<a href=3D"mailto:andy.shevchenko@gmail.com"=
 target=3D"_blank">andy.shevchenko@gmail.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">On Tue, Jan 30, 2018 at 6:40 PM, Andy Shevchenko<b=
r>
&lt;<a href=3D"mailto:andy.shevchenko@gmail.com" target=3D"_blank">andy.she=
vchenko@gmail.com</a>&gt; wrote:<br>
&gt; On Tue, Jan 30, 2018 at 6:01 PM, Jonathan Cameron<br>
&gt; &lt;<a href=3D"mailto:Jonathan.Cameron@huawei.com" target=3D"_blank">J=
onathan.Cameron@huawei.com</a>&gt; wrote:<br>
&gt;&gt; On Mon, 29 Jan 2018 16:07:02 +0200<br>
&gt;&gt; Andy Shevchenko &lt;<a href=3D"mailto:andy.shevchenko@gmail.com" t=
arget=3D"_blank">andy.shevchenko@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt;&gt; &gt; But that would take much longer.=C2=A0 Feel free to propo=
se it and a patch<br>
&gt;&gt;&gt; &gt; removing the ifdef fun if you like!<br>
&gt;<br>
&gt;&gt;&gt; Where can I see the patch?<br>
&gt;<br>
&gt;&gt; Doh. I clearly forgot to push out.=C2=A0 Should be able to push to=
<br>
&gt;&gt; iio.git on <a href=3D"http://kernel.org" rel=3D"noreferrer" target=
=3D"_blank">kernel.org</a> later.<br>
&gt;<br>
&gt; Thanks, I can see it now.<br>
&gt;<br>
&gt; This patch almost wrong. Not by functionality it brings, but by style.=
<br>
<br>
Oy vey, the second device is *not* accelerometer, it is a magnetometer [1].=
<br>
<br>
[1]: <a href=3D"https://www.mouser.com/ds/2/783/BST-BMC150-DS000-04-786477.=
pdf" rel=3D"noreferrer" target=3D"_blank">https://www.mouser.com/ds/2/783/B=
ST-BMC150-DS000-04-786477.pdf</a><br>
<br>
&gt; I&#39;ll send soon a series of fixes to the driver (compile tested onl=
y)<br>
&gt; to provide my view on the matters.<br>
&gt;<br>
&gt; P.S. In the future (I have some kind of deja vu I have told this<br>
&gt; already to someone), please, Cc one or more of Rafael, Mika and/or me<=
br>
&gt; for ACPI matters.<br>
<br>
--<br>
With Best Regards,<br>
Andy Shevchenko<br>
</blockquote></div>

--089e082409a8038682056401a711--
