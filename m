Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:42410 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751120AbaGGQPd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 7 Jul 2014 12:15:33 -0400
Message-ID: <53BAC828.7020602@kernel.org>
Date: Mon, 07 Jul 2014 17:17:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [RESEND PATCH 3/3] iio: st_sensors: add devicetree probing support
References: <1404726525-2649-1-git-send-email-linus.walleij@linaro.org>	<53BA918D.2050402@kernel.org> <CACRpkdYCh7qQM7C1WpphNyhi96NkYEP8chXOtQP3YdyuprmptA@mail.gmail.com>
In-Reply-To: <CACRpkdYCh7qQM7C1WpphNyhi96NkYEP8chXOtQP3YdyuprmptA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/14 14:54, Linus Walleij wrote:
> On Mon, Jul 7, 2014 at 2:24 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
>> ERROR: "st_sensors_of_i2c_probe" [drivers/iio/pressure/st_pressure_i2c.ko]
>> undefined!
>> ERROR: "st_sensors_of_i2c_probe" [drivers/iio/magnetometer/st_magn_i2c.ko]
>> undefined!
>> ERROR: "st_sensors_of_i2c_probe" [drivers/iio/gyro/st_gyro_i2c.ko]
>> undefined!
>> ERROR: "st_sensors_of_i2c_probe" [drivers/iio/accel/st_accel_i2c.ko]
>> undefined!
>> scripts/Makefile.modpost:90: recipe for target '__modpost' failed
>> make[1]: *** [__modpost] Error 1
>> Makefile:1047: recipe for target 'modules' failed
>> make: *** [modules] Error 2
>>
>> When CONFIG_OF not selected.
>
> Um, when CONFIG_OF is *not* selected?
>
> This looks more like it is selected, but the symbol is missing, since
> I missed to export that symbol, right?
*coughs* Yup you are right of course.  The build in question did indeed
have CONFIG_OF selected.
>
> In the !CONFIG_OF case there is a static inline in
> <linux/iio/common/st_sensors_i2c.h> to handle that.
>
> The v2 patch I just sent should fix this issue...
Cool.
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

