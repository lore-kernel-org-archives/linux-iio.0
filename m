Return-Path: <charles-antoine.couret@essensium.com>
Subject: Re: [PATCH 1/2] Add driver for Texas Instrument DAC7311 It is a
 driver for Texas Instruments 8/10/12-bit 1-channel compatible with DAC6311
 and DAC5311 chips.
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org
References: <20181006203108.20439-1-charles-antoine.couret@essensium.com>
 <20181007173630.212baa45@archlinux>
From: Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Message-ID: <27950c9e-9899-7b43-ea67-12c0030d06f9@essensium.com>
Date: Mon, 8 Oct 2018 23:34:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181007173630.212baa45@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,
Like the previous driver, thank you for the code review, I have some 
questions before making V2.

Le 07/10/2018 à 18:36, Jonathan Cameron a écrit :
>> +enum {
>> +	SINGLE_8BITS = 0,
>> +	SINGLE_10BITS,
>> +	SINGLE_12BITS,
>> +};
>> +
>> +enum {
>> +	POWER_RUNNING = 0,
>> +	POWER_1KOHM_TO_GND,
>> +	POWER_100KOHM_TO_GND,
>> +	POWER_TRI_STATE,
>> +};
>> +
>> +struct ti_dac_spec {
>> +	u8 num_channels;
>> +	u8 resolution;
>> +};
>> +
>> +static const struct ti_dac_spec ti_dac_spec[] = {
>> +	[SINGLE_8BITS]  = { .num_channels = 1, .resolution = 8  },
> I think I'd prefer to see the enum as part names.  It is easy
> to see the number of channels and resolution here anyway.
I still don't understand the "part names" thing here.
>> +}
>> +
>> +static const char * const ti_dac_powerdown_modes[] = {
>> +	"running",
> What is running in a power down mode?

For me it was the list of power status of the device. And using 
"running" allow us to set to running state with the right command.

But I probably misunderstand its purpose. Why we have to put only power 
down in that structure?


Thank you.

Regards,

Charles-Antoine Couret
