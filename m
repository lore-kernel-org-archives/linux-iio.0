Return-Path: <SRS0=Jrji=D4=linaro.org=linus.walleij@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180101104245.694a76fa@archlinux>
References: <20171231210652.18820-1-martin@martingkelly.com> <20180101104245.694a76fa@archlinux>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 1 Jan 2018 16:19:56 +0100
Message-ID: <CACRpkdaLFKy4Q4S0=6CUNftvJSTv+SVspiQoVjAyCYs0MWWbRA@mail.gmail.com>
Subject: Re: [PATCH] iio: gyro: st_gyro: add support for the LSM9DS1
To: Jonathan Cameron <jic23@kernel.org>
Cc: Martin Kelly <martin@martingkelly.com>, linux-iio@vger.kernel.org,
	Denis Ciocca <denis.ciocca@st.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jan 1, 2018 at 11:42 AM, Jonathan Cameron <jic23@kernel.org> wrote:

> I'm rather unsure if we should be adding more gyro only
> support for these devices.  Ths lsm9ds0 was in theory
> a stop gap whilst support was properly sorted out.
>
> Looking back Crestez did post an RFC for each of the
> parts as well for reference but made the point that this was
> the wrong way to do things.
>
> This part (and the ds0) really need to be supported by a proper gyro/accel
> driver rather than just cherry picking out the gyro part.

So what we need is a combined driver that expose the gyro and accell
channels in the same device, right?

What a mess. That means we can only use half the device at the time
at best.

Do we have a list of all of those ST devices that this situation pertains to?

Yours,
Linus Walleij
