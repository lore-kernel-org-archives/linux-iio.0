Return-Path: <SRS0=AAL6=D4=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACRpkdaLFKy4Q4S0=6CUNftvJSTv+SVspiQoVjAyCYs0MWWbRA@mail.gmail.com>
References: <20171231210652.18820-1-martin@martingkelly.com>
 <20180101104245.694a76fa@archlinux> <CACRpkdaLFKy4Q4S0=6CUNftvJSTv+SVspiQoVjAyCYs0MWWbRA@mail.gmail.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Mon, 1 Jan 2018 16:32:00 +0100
Message-ID: <CAA2SeN+dQ4k=kOfJSoJ4TfrRgUSTVLFJQmWtcwvUhHMvsTwwmA@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: st_gyro: add support for the LSM9DS1
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Martin Kelly <martin@martingkelly.com>, linux-iio@vger.kernel.org,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Mon, Jan 1, 2018 at 11:42 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>
>> I'm rather unsure if we should be adding more gyro only
>> support for these devices.  Ths lsm9ds0 was in theory
>> a stop gap whilst support was properly sorted out.
>>
>> Looking back Crestez did post an RFC for each of the
>> parts as well for reference but made the point that this was
>> the wrong way to do things.
>>
>> This part (and the ds0) really need to be supported by a proper gyro/accel
>> driver rather than just cherry picking out the gyro part.
>
> So what we need is a combined driver that expose the gyro and accell
> channels in the same device, right?
>

Right. I added st_lsm6dsx driver to properly support that kind of
devices (accel + gyro).
At the moment it supports LSM6DS3/3H/M/L. I guess it is not so easy to
add LSM9DSx
support since if I am not wrong on LSM9DSx accel and gyro are not independent ,
but if you enable the gyro, the accel will be enabled as well, so hw queue
management has to be reviewed.

Regards,
Lorenzo

> What a mess. That means we can only use half the device at the time
> at best.
>
> Do we have a list of all of those ST devices that this situation pertains to?
>
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
