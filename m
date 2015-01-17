Return-Path: <thymythos@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <1504751.reIqVWQMRq@xps13>
References: <1504751.reIqVWQMRq@xps13>
Date: Sat, 17 Jan 2015 12:24:54 +0100
Message-ID: <CALm2MhfeO82HiTmkdFpHzomKdVrjnYXzGnsaTd6BwFyYT2wsAQ@mail.gmail.com>
Subject: Re: [PATCH v7] iio: acpi: Add ACPI0008 ALS driver
From: Manuel Stahl <thymythos@googlemail.com>
To: 1419349152.30443.0@smtp.gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=001a11c387d2a4a2d9050cd756a0
List-ID: <linux-iio@vger.kernel.org>

--001a11c387d2a4a2d9050cd756a0
Content-Type: text/plain; charset=UTF-8

Hi Gabriele,

can you please tell us what kind of laptop you have? On my Asus UX301L this
function is required. I have to see, how I can detect if it is available.

Regards,
Manuel

2015-01-16 18:36 GMT+01:00 Gabriele Mazzotta <gabriele.mzt@gmail.com>:

> Hi,
>
> I found this driver and I'm quite interested in it since my laptop has
> this kind of sensor.
>
> I've noticed a problem with v7, with acpi_als_enable() to be specific.
> The ACPI handles used to enable the sensor are not standard and as a
> matter of fact they are not available on my system, so the driver fails
> to load. This should not happen, I think some quirk should be used here.
>
> Please, Cc me, I'm not suscribed to this list.
>
> Regards,
> Gabriele
>

--001a11c387d2a4a2d9050cd756a0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gabriele,<div><br></div><div>can you please tell us wha=
t kind of laptop you have? On my Asus UX301L this function is required. I h=
ave to see, how I can detect if it is available.</div><div><br></div><div>R=
egards,</div><div>Manuel</div></div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">2015-01-16 18:36 GMT+01:00 Gabriele Mazzotta <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gabriele.mzt@gmail.com" target=3D"_blank">ga=
briele.mzt@gmail.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<=
br>
<br>
I found this driver and I&#39;m quite interested in it since my laptop has<=
br>
this kind of sensor.<br>
<br>
I&#39;ve noticed a problem with v7, with acpi_als_enable() to be specific.<=
br>
The ACPI handles used to enable the sensor are not standard and as a<br>
matter of fact they are not available on my system, so the driver fails<br>
to load. This should not happen, I think some quirk should be used here.<br=
>
<br>
Please, Cc me, I&#39;m not suscribed to this list.<br>
<br>
Regards,<br>
Gabriele<br>
</blockquote></div><br></div>

--001a11c387d2a4a2d9050cd756a0--
