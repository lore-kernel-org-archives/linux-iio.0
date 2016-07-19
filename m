Return-Path: <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH v2 4/4] hwmon: iio: add label for channels read by
 iio_hwmon
To: Jonathan Cameron <jic23@kernel.org>, jdelvare@suse.com,
 linux@roeck-us.net, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 maxime.ripard@free-electrons.com, wens@csie.org, lee.jones@linaro.org
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-5-git-send-email-quentin.schulz@free-electrons.com>
 <aa889446-d68c-a05f-83c1-4d54fe814000@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 thomas.petazzoni@free-electrons.com, antoine.tenart@free-electrons.com
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <578DCED5.6080408@free-electrons.com>
Date: Tue, 19 Jul 2016 08:55:17 +0200
MIME-Version: 1.0
In-Reply-To: <aa889446-d68c-a05f-83c1-4d54fe814000@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 18/07/2016 14:24, Jonathan Cameron wrote:
> On 15/07/16 10:59, Quentin Schulz wrote:
>> Currently, iio_hwmon only exposes values of the IIO channels it can read
>> but no label by channel is exposed.
>>
>> This adds exposition of sysfs files containing label for IIO channels it
>> can read based on extended_name field of the iio_chan_spec of the channel.
>> If the extended_name field is empty, the sysfs file is not created by
>> iio_hwmon.
> Hmm. This is not the intent of extended name at all.  That exists to add
> a small amount of information to an constructed IIO channel name.
> Typically it's used to indicate physically wired stuff like:
> 
> in_voltage0_vdd_raw for cases where that channel of the ADC is hard wired
> to the vdd.  In this particular case the use might actually work as the
> vdd makes it clear it's a voltage - in general that's not the case.
> 
> Use of extended_name at all in IIO is only done after extensive review.
> It adds nasty custom ABI to a device, so the gain has to be considerable
> to use it.
> 
> When I read your original suggestion of adding labels, I was expecting the
> use of datasheet_name.  That has the advantage of being well defined by
> the datasheet (if not it should not be provided) + not being used in
> the construction of the IIO channel related attributes.  However, that
> may still not correspond well to the expected labelling in hwmon.

Good to know for extend_name use cases. While doing further testing, I
noticed the extend_name is also appended to the sysfs filename.. which
is definitely not what we want.

I've checked for datasheet_name and it is only used to be compared to
adc_channel_label from iio_map structure. Same for adc_channel_label
(which has to be the same as datasheet_name of the iio_chan_spec it is
linked to). So I could use this instead of extend_name to put a label on
a channel.
However, I thought of it to be more a way to identify the hardware in
the datasheet more than giving users a hint on what it is. That's what
"git grep adc_channel_label" told me. It's definitely better to use
datasheet_name over extend_name for channel labeling but I don't know if
it's really the good variable to use for labeling? In my understanding
of datasheet_name, in my case it would be more "temp_gpadc" than "SoC
temperature", that's what I mean.

> Thinking more on this, the label is going to often be a function of how
> the board is wired up...  Perhaps it should be a characteristic of the
> channel_map (hence from DT or similar) rather than part of the IIO driver
> itself?

Hmm.. I would not put a property in the DT only for labeling.

[...]
