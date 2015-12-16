Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
In-Reply-To: <CAOhV88NP+bpN6oVk3_DbszNqKAo4T9z-umfVQAcyS3QArwguTA@mail.gmail.com>
References: <CAOhV88NP+bpN6oVk3_DbszNqKAo4T9z-umfVQAcyS3QArwguTA@mail.gmail.com>
From: Crt Mori <cmo@melexis.com>
Date: Wed, 16 Dec 2015 10:31:36 +0100
Message-ID: <CAKv63usy345RSKG=mGY49w9WTHWa4-DnDRXOrCcKPqKP99hf8A@mail.gmail.com>
Subject: Re: Issues with Lenovo Yoga 900 IIO devices (accelerometer, etc.)
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi,
So you were using 4.4-rc5 before and it worked, but after applying a
patch it stopped?
The patch you pasted seems to relate to dts files and declarations in
it - did anything there change?

Best regards,
Crt


On 15 December 2015 at 20:19, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> So, I apologize in advance for this relatively vague report, but I'm fairly sure
> the Yoga 900 has an accelerometer amongst other sensors (ambient light?)
> exported over IIO.
>
> But, these sensors seem to not be updating at all with a 4.4-rc5+ kernel (a
> set of patches from https://lkml.org/lkml/2015/11/30/441 applied to Linus'
> tree).
>
> The odd part is at some point in messing with this, I'm fairly sure it did work!
> That is,
>
> `watch -n 0.1 cat '/sys/bus/iio/devices/iio:device'*/*raw*`
>
> showed updating values as I moved the laptop around.
>
> I've not done any accelerometer debugging before, so any suggestion on
> where to start would be greatly appreciated!
>
> -Nish
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
