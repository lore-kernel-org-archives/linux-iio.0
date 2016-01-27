Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <CAKi4VA+n63x=HXGpijksCSMC6tb0ppCqxqAiVwSuGnw2TkzS7g@mail.gmail.com>
References: <1452788708-3003-1-git-send-email-daniel.baluta@intel.com>
	<CAKi4VA+n63x=HXGpijksCSMC6tb0ppCqxqAiVwSuGnw2TkzS7g@mail.gmail.com>
Date: Wed, 27 Jan 2016 11:49:28 +0200
Message-ID: <CAEnQRZDeLoOUbF-jw81t-LUFQYAjqX84tA_ZyHCPWWxbGSN6KA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: Add TI ADS1015 ADC driver support
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, lkml <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Lucas De Marchi <lucas.demarchi@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jan 27, 2016 at 12:28 AM, Lucas De Marchi
<lucas.de.marchi@gmail.com> wrote:
> Hi,
>
> On Thu, Jan 14, 2016 at 2:25 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
>> The driver has sysfs readings with runtime PM support for power saving.
>> It also offers buffer support that can be used together with IIO software
>> triggers.
>>
>> Datasheet can be found here:
>>         http://www.ti.com.cn/cn/lit/ds/symlink/ads1015.pdf
>>
>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>> ---
>
> [ ... ]
>
>> +static const struct i2c_device_id ads1015_id[] = {
>> +       {"ads1015", 0},
>
> shouldn't this be ti-ads1015 so not to clash with the hwmon driver?

The plan is to remove hwmon driver and replace it with the a backward
compatbile IIO driver.

I am now working to address the comments from this thread and send a v2
asap.

>
>> +       {}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, ads1015_id);
>> +
>> +static struct i2c_driver ads1015_driver = {
>> +       .driver = {
>> +               .name = ADS1015_DRV_NAME,
>
> same here, otherwise we will have an i2c:ads1015 alias

thanks,
Daniel.
