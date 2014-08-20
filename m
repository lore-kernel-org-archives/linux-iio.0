Return-Path: <sanjeevsharmaengg@gmail.com>
MIME-Version: 1.0
In-Reply-To: <53F4451B.3040209@metafoo.de>
References: <1408516869-6099-1-git-send-email-sanjeev_sharma@mentor.com>
	<53F441FF.9090304@metafoo.de>
	<CAGUYZuSENkSjoA9U0E8MQKp0a1J3moE8p8NYAzfiZ+BpxND4Aw@mail.gmail.com>
	<53F4451B.3040209@metafoo.de>
Date: Wed, 20 Aug 2014 12:32:52 +0530
Message-ID: <CAGUYZuQwKMG0OFt_gJVPTj3EWin68Jg3jzD9T_Rje-UroOCf=g@mail.gmail.com>
Subject: Re: [PATCH] staging:iio: moved platform_data into include/linux/iio
From: sanjeev sharma <sanjeevsharmaengg@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Sanjeev Sharma <sanjeev_sharma@mentor.com>, jic23@kernel.org,
	gregkh <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devel <devel@driverdev.osuosl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary=089e015371c4512d6b05010a31f9
List-ID: <linux-iio@vger.kernel.org>

--089e015371c4512d6b05010a31f9
Content-Type: text/plain; charset=UTF-8

Hi,

I have only moved some header files because other header files are already
present there and these are only pending files which is not moved outside
the staging directory.

@Greg:What is your though on this ?

Regards
Sanjeev Sharma


On Wed, Aug 20, 2014 at 12:20 PM, Lars-Peter Clausen <lars@metafoo.de>
wrote:

> On 08/20/2014 08:44 AM, sanjeev sharma wrote:
>
>> Hi,
>>
>> This was the action item(TO-DO). IMO, it make sense to move into
>> include/linux/iio because IIO complete subsystem may take some time.
>>
>
> The code that is in staging is not supposed to 'leak' outside of staging.
> So either you move the driver as a whole out of staging or leave it there,
> but do not move individual files of the driver out of staging. The action
> item is for when the driver is moved out of staging.
>

--089e015371c4512d6b05010a31f9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Hi,<br><br></div>I have only moved some header f=
iles because other header files are already present there and these are onl=
y pending files which is not moved outside the staging directory.<br><br></=
div>
<div>@Greg:What is your though on this ?<br><br></div><div>Regards<br>Sanje=
ev Sharma<br></div></div><div class=3D"gmail_extra"><br><br><div class=3D"g=
mail_quote">On Wed, Aug 20, 2014 at 12:20 PM, Lars-Peter Clausen <span dir=
=3D"ltr">&lt;<a href=3D"mailto:lars@metafoo.de" target=3D"_blank">lars@meta=
foo.de</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">On 08/20/2014 08:44 AM, sanj=
eev sharma wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
<br>
This was the action item(TO-DO). IMO, it make sense to move into<br>
include/linux/iio because IIO complete subsystem may take some time.<br>
</blockquote>
<br></div>
The code that is in staging is not supposed to &#39;leak&#39; outside of st=
aging. So either you move the driver as a whole out of staging or leave it =
there, but do not move individual files of the driver out of staging. The a=
ction item is for when the driver is moved out of staging.<br>

</blockquote></div><br></div>

--089e015371c4512d6b05010a31f9--
