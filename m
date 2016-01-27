Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <569A3299.3@kernel.org>
References: <1452788708-3003-1-git-send-email-daniel.baluta@intel.com>
	<569A3299.3@kernel.org>
Date: Wed, 27 Jan 2016 18:31:42 +0200
Message-ID: <CAEnQRZBb5xK0=i1=Dwhcdkj1baSg4LGgFwzP8uQfeV29M+Cypg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Add TI ADS1015 ADC driver support
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jan 16, 2016 at 2:07 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 14/01/16 16:25, Daniel Baluta wrote:
>> The driver has sysfs readings with runtime PM support for power saving.
>> It also offers buffer support that can be used together with IIO software
>> triggers.
>>
>> Datasheet can be found here:
>>       http://www.ti.com.cn/cn/lit/ds/symlink/ads1015.pdf
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>

Thanks for the feedback! Few questions below.


> The hwmon compatibility stuff has been covered by others so I'll just assume
> you'll sort that out :)
>
> Various bits and bobs inline.

Do you think it is worth to have both of the drivers in parallel for a
period until
we figure out that everything is correct? The IIO config symbol can be enabled
only hwmon symbol is not enabled?

<snip>

>> +struct ads1015_data {
> I was a little suprised to see both the i2c_client and regmap in here...
> Could use regmap_get_device for most if not all uses in here of the
> client pointer..

That's a good point. Anyhow, there is no single instance of regmap_get_device
in the IIO tree. I counted at least 4 drivers where we could use it.
Do you think
is there a great benefit from using it?

This will be a nice change for Linux kernel outreachy applicants :).
I'm sure they will
love to work on it.

>> +     struct i2c_client *client;
>> +     struct regmap *regmap;
> You only use buffer[0] that I can see...

The rest should be for the timestamp and I will fix it :).

<snip>

thanks,
Daniel.
