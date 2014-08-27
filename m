Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <53FB6205.5020704@kernel.org>
References: <1408815064-5763-1-git-send-email-linus.walleij@linaro.org>
	<53FB6205.5020704@kernel.org>
Date: Wed, 27 Aug 2014 15:38:37 +0200
Message-ID: <CACRpkdb5NXJiTvaHz9_nJiZcFsyVnjPYjaYZ1YH9meBgJhoTJA@mail.gmail.com>
Subject: Re: [PATCH] iio: st-sensors: add support for lis3lv02d accelerometer
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, Pavel Machek <pavel@ucw.cz>,
	Eric Piel <eric.piel@tremplin-utc.net>, Yan Burman <burman.yan@gmail.com>,
	Yan Burman <yanb@mellanox.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 25, 2014 at 6:19 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 23/08/14 18:31, Linus Walleij wrote:
>> This adds support for the LIS3LV02 accelerometer found in the
>> ST Microelectronics Nomadik board series.
>>
>> Cc: devicetree@vger.kernel.org
>> Cc: Denis CIOCCA <denis.ciocca@st.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> This is a little 'interesting', given the part is already supported by
> drivers/misc/lis3lv02d*.c and already has bindings under there.
> Documentation/devicetree/bindings/misc/lis302.txt
> (some of these are interesting).

Grrr how come I missed this... It was originally merged as a
hwmon driver.


>> +/* CUSTOM VALUES FOR SENSOR 4 */
>>
> I wish now we'd nipped this naming convention in the bud and insisted
> on naming after a relevant part. Oh well.

Well we can always make an invasive patch fixing that. I can
probably do it using sed or something.

> Do we think this is the right way to handle the alternative support
> here?

Well this patch is a driver using the IIO framework and was written
by ST, but the other driver support a few other interesting features
and seems to be for the laptop usecase.

Adding the other authors to the TO: line...

Yours,
Linus Walleij
