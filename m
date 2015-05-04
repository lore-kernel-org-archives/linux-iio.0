Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47021 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbbEDQj7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 12:39:59 -0400
Message-ID: <5547A0D5.3000006@kernel.org>
Date: Mon, 04 May 2015 17:39:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 06/10] iio: st_accel: support 8bit channel data
References: <1430399755-26475-1-git-send-email-linus.walleij@linaro.org>	<1430399755-26475-6-git-send-email-linus.walleij@linaro.org>	<alpine.DEB.2.02.1504301637070.4190@pmeerw.net> <CACRpkdacUZfKkQz0XfXm4cqU+8B5TR8ZqJhXVzCTMcU+1EB2mA@mail.gmail.com>
In-Reply-To: <CACRpkdacUZfKkQz0XfXm4cqU+8B5TR8ZqJhXVzCTMcU+1EB2mA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/05/15 13:11, Linus Walleij wrote:
> On Thu, Apr 30, 2015 at 4:56 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>>
>>> Some sensors like the LIS331DL only support 8bit data by a single
>>> register per axis. These utilize the MSB byte. Make it possible
>>> to register these apropriately.
>>
>> this doesn't seem right;
>>
>> st_accel_8bit_channels is just added, but not used; this probably results
>> in a warning
> 
> Yes the actual LIS331DL patch adding support for this sensor is
> 7/11, the next patch in the series.
> 
>> the start address, ST_ACCEL_DEFAULT_OUT_X_L_ADDR, is +1 to read just the
>> MSB byte; but the storage size is still 16bit
> 
> So in the LIS331DL datasheet page 29 & 30.
> http://www.st.com/st-web-ui/static/active/en/resource/technical/document/datasheet/CD00172345.pdf
> 
> It is clear that registers 0x29, 0x2b and 0x2d contain
> 8-bit values of X,Y,Z respectively and 0x28, 0x2a and 0x2c
> are unused.
> 
> Since ST_ACCEL_DEFAULT_OUT_X_L_ADDR is 0x28, it
> is clear that ST choose to put the 8bit data into the MSB
> for this sensor. So when reading 8bit sensors we need to
> read MSB, and discard LSB.
> 
> +       ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
> +                       BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +                       ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 8, 16,
> +                       ST_ACCEL_DEFAULT_OUT_X_L_ADDR+1),
> 
>> the actual read is done in st_sensors_get_buffer_element(); with special
>> case handling for the reads depending on the number of channels
> 
> Not getting this, I traced around the code. When I cat in_accel_x_raw
> in sysfs the read happens in
> st_sensors_read_axis_data() called from st_sensors_read_info_raw().
> It reads correctly from 0x29, 0x2b and 0x2d as desired.
> 
> Same if I turn on buffered I/O.
> 
> Do I have to use buffered I/O *and* triggers to go down
> the execution path you point out? How do I do that from
> sysfs (no clue really)? Do I need a special testprogram?
Yup. It's in the trigger handler.  The generic_buffer.c
test app (now under tools/iio) should do the job for testing
this. The purpose of that one is to act as an example
of the chardev (buffered) interface and as documentation
as the docs always got out of date when we kept them seperately.
(yeah I'm lazy).

>From a quick look, I'd say storage_bits should be 8.  Then
it will just read one byte rather than the correct one and the next
address up (which might be 0, but in theory might not be for some sensor).

> 
>> I think either the _ADDR should not be +1 or the storage_bits should be 8,
>> but not both
> 
> But this works :/
> 
> The raw values I get seem correct.
> 
> I'm suspicious on the scale values though, they don't even
> trigger a read from the register.
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

