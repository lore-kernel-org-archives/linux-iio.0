Return-Path: <jic23@cam.ac.uk>
References: <4EE8A2E6.6070807@metafoo.de>
In-Reply-To: <4EE8A2E6.6070807@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Should we make mark_param_change buffer implementation internal?
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 14 Dec 2011 13:58:59 +0000
To: Lars-Peter Clausen <lars@metafoo.de>,Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <564046e1-d6a0-45b6-9634-98a25c0d2998@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Lars-Peter Clausen <lars@metafoo.de> wrote:

>Hi,
>
>Right now we have a =
mark_param_change callback in the buffer access
>functions struct, which sh=
ould be called whenever the parameters
>(length,
>bytes per datum) of the b=
uffer change. Each buffer implementation calls
>their own mark_param_change=
 callback in their set_length and
>set_bytes_per_datum callbacks. Additiona=
lly mark_param_change gets
>called
>when the user changes the buffer length=
. So in this case it will get
>called
>twice.
>
>So I'm wondering if we sho=
uld make it completely buffer implementation
>internal and not export it in=
 the buffer access functions struct, since
>the
>buffer implementation will=
 probably know best anyway if one of it's
>parameters has changed.

Makes s=
ense. 
>
>- Lars
>--
>To unsubscribe from this list: send the line "unsubsc=
ribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>Mor=
e majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent f=
rom my Android phone 
with K-9 Mail. Please excuse my brevity.
