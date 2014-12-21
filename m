Return-Path: <devendra.aaru@gmail.com>
MIME-Version: 1.0
References: <1418644006-5558-1-git-send-email-devendra.aaru@gmail.com> <549341D4.7040807@gmx.de>
From: "devendra.aaru" <devendra.aaru@gmail.com>
Date: Sun, 21 Dec 2014 13:00:23 +0000
Message-ID: <CAHdPZaP1mA2uenXQJwsr5HXZr2qnixbXKjiV3z2tz2phtCafJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: meter: ade7754: fix build warnings with make randconfig
To: Hartmut Knaack <knaack.h@gmx.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7b10c86b6b7480050ab9868e
List-ID: <linux-iio@vger.kernel.org>

--047d7b10c86b6b7480050ab9868e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

Sorry for sending the email in the holidays...

On Thu Dec 18 2014 at 4:06:45 PM Hartmut Knaack <knaack.h@gmx.de> wrote:

> Devendra Naga schrieb am 15.12.2014 um 12:46:
> > fixes
> >
> > drivers/staging/iio/meter/ade7754.c:222:6: warning: =E2=80=98val=E2=80=
=99 may be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> > drivers/staging/iio/meter/ade7754.c:368:6: warning: =E2=80=98val=E2=80=
=99 may be used
> > uninitialized in this function [-Wmaybe-uninitialized]
> >
> > the fix here is to check the return value of ade7754_spi_read_reg_8.
> Hi,
> I would recommend to use a different topic name, which represents a bit
> better what your patch actually does (something like add error handling
> in _reset and _stop_device).


Okay. Got you.


>

Your attempt is basically right, but in _stop_device I would at least
> recommend to add an error message, given that it is only called from
> _remove, which does no error handling. So, at least it becomes clear
> that something went wrong and the device didn't get powered down.
> Since your second patch is very similar to this one, the same applies
> there, too.
> Thanks,
>
>
Okay. Will add the error message in _stop_device.

I will update both of the patches with your comments.

-- Devendra

--047d7b10c86b6b7480050ab9868e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br>Hello,<div><br><div>Sorry for sending the email in the holidays...</div=
><div><br><div class=3D"gmail_quote">On Thu Dec 18 2014 at 4:06:45 PM Hartm=
ut Knaack &lt;<a href=3D"mailto:knaack.h@gmx.de">knaack.h@gmx.de</a>&gt; wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">Devendra Naga schrieb am 15.12.2014 =
um 12:46:<br>
&gt; fixes<br>
&gt;<br>
&gt; drivers/staging/iio/meter/<u></u>ade7754.c:222:6: warning: =E2=80=98va=
l=E2=80=99 may be used<br>
&gt; uninitialized in this function [-Wmaybe-uninitialized]<br>
&gt; drivers/staging/iio/meter/<u></u>ade7754.c:368:6: warning: =E2=80=98va=
l=E2=80=99 may be used<br>
&gt; uninitialized in this function [-Wmaybe-uninitialized]<br>
&gt;<br>
&gt; the fix here is to check the return value of ade7754_spi_read_reg_8.<b=
r>
Hi,<br>
I would recommend to use a different topic name, which represents a bit<br>
better what your patch actually does (something like add error handling<br>
in _reset and _stop_device).</blockquote><div><br></div><div>Okay. Got you.=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=C2=A0</blockquote><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
Your attempt is basically right, but in _stop_device I would at least<br>
recommend to add an error message, given that it is only called from<br>
_remove, which does no error handling. So, at least it becomes clear<br>
that something went wrong and the device didn&#39;t get powered down.<br>
Since your second patch is very similar to this one, the same applies<br>
there, too.<br>
Thanks,<br><br></blockquote><div><br>Okay. Will add the error message in _s=
top_device.</div><div><br></div><div>I will update both of the patches with=
 your comments.</div><div>=C2=A0</div><div>-- Devendra</div></div></div></d=
iv>

--047d7b10c86b6b7480050ab9868e--
