Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <5649BA9A.50206@st.com>
References: <1447664287-17310-1-git-send-email-linus.walleij@linaro.org>
	<5649BA9A.50206@st.com>
Date: Mon, 16 Nov 2015 14:20:26 +0100
Message-ID: <CACRpkdaumSNemq63o7s5EeZuBtTKmXqzd9_Kb5ZfouNQbfvEOg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] iio: st_sensors: support active-low interrupts
From: Linus Walleij <linus.walleij@linaro.org>
To: Giuseppe BARBA <giuseppe.barba@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Nov 16, 2015 at 12:14 PM, Giuseppe BARBA <giuseppe.barba@st.com> wrote:
> On 16/11/2015 09:58, Linus Walleij wrote:

>> I am still missing a data sheet for the LSM303AGR sensor that
>> Giuseppe added recently, so I have no idea what bits to poke to get
>> active low IRQs (or open drain) on that sensor.
>
> I'm surprised that the datasheet is not available yet on
> STMicroelectronics site. I've checked and it should be available in the
> next days. I'll reply to you again  with the link.
> Anyway, I can confirm you that the register 0x25 (mask 0x02) is the
> correct one to use for setting interrupt active high/low.

For the accelerometer I guessed it's the same as the other sensors,
but as LSM303AGR also has DRDY for the magnetometer, I was
wondering if there is a bit for IHL and OD also for the magnetometer
side?

Yours,
Linus Walleij
