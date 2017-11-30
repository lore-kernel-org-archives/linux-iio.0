Return-Path: <SRS0=AYhO=C4=larsshack.org=lars@kernel.org>
MIME-Version: 1.0
In-Reply-To: <0100016009e7c075-ae3eb98f-22d0-4fae-bcff-93102508b227-000000@email.amazonses.com>
References: <0100016009e7c075-ae3eb98f-22d0-4fae-bcff-93102508b227-000000@email.amazonses.com>
From: Lars Kellogg-Stedman <lars@oddbit.com>
Date: Thu, 30 Nov 2017 16:19:42 -0500
Message-ID: <CA+Q+rdwpgoiHVqvkF-gTb8g1BsVRqQucNRm0nWcmtJvzeeyqHQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: accel: bmc150: Check for a second i2c resource
To: Jeremy Cline <jeremy@jcline.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hans de Goede <hdegoede@redhat.com>,
	Steven Presser <steve@pressers.name>, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a113cf17a8ffc61055f39cfe0"
List-ID: <linux-iio@vger.kernel.org>

--001a113cf17a8ffc61055f39cfe0
Content-Type: text/plain; charset="UTF-8"

On Wed, Nov 29, 2017 at 5:31 PM, Jeremy Cline <jeremy@jcline.org> wrote:

> Some BOSC0200 ACPI devices, like the one in the Yoga 11e, have two i2c
> accelerometers listed under a single ACPI device. This checks to see if
> there is an ACPI companion and if so handles a second i2c client.
>

I am going to try this out (on a yoga 11e) over the weekend.

Will this require an additional patch to iio-sensor-proxy in order to
provide the appropriate input events to enter/exit tablet mode? I believe
these need to be generated based on the relative position indicated by the
two accelerometers.

-- 
Lars Kellogg-Stedman <lars@oddbit.com> | larsks@{twitter, irc, github, ...}

--001a113cf17a8ffc61055f39cfe0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On W=
ed, Nov 29, 2017 at 5:31 PM, Jeremy Cline <span dir=3D"ltr">&lt;<a href=3D"=
mailto:jeremy@jcline.org" target=3D"_blank">jeremy@jcline.org</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Some BOSC0200 ACPI devices, like=
 the one in the Yoga 11e, have two i2c<br>
accelerometers listed under a single ACPI device. This checks to see if<br>
there is an ACPI companion and if so handles a second i2c client.<br></bloc=
kquote><div><br></div><div>I am going to try this out (on a yoga 11e) over =
the weekend.</div><div><br></div><div>Will this require an additional patch=
 to iio-sensor-proxy in order to provide the appropriate input events to en=
ter/exit tablet mode? I believe these need to be generated based on the rel=
ative position indicated by the two accelerometers.<br></div><div>=C2=A0</d=
iv></div>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_sign=
ature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><f=
ont face=3D"monospace, monospace">Lars Kellogg-Stedman &lt;<a href=3D"mailt=
o:lars@oddbit.com" target=3D"_blank">lars@oddbit.com</a>&gt; | larsks@{twit=
ter, irc, github, ...}</font></div></div></div></div></div></div></div>
</div></div>

--001a113cf17a8ffc61055f39cfe0--
