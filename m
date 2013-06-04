Return-Path: <bigeasy@linutronix.de>
Date: Tue, 4 Jun 2013 12:19:36 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>,
	Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 11/19] iio & mfd: ti_tscadc: Update with IIO map
 interface & deal with partial activation
Message-ID: <20130604101936.GB1151@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
 <1369681926-22185-12-git-send-email-bigeasy@linutronix.de>
 <51AB838B.5060602@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <51AB838B.5060602@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

* Jonathan Cameron | 2013-06-02 18:40:27 [+0100]:

>On 05/27/2013 08:11 PM, Sebastian Andrzej Siewior wrote:
>> From: Pantelis Antoniou <panto@antoniou-consulting.com>
>>
>> Add an IIO map interface that consumers can use.
>>
>> While we're here fix the mfd device in the case
>> where a subdevice might not be activated.
>Any time I read 'while we're here' it rings alarm bells.
>Two issues -> Two patches please.
>
>The level of reworking here is rather high. Probably better
>to do the structural changes in one patch then follow with the
>new functionality in another.

Okay, will try.

>Other comments inline.
>>
>> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
>> Signed-off-by: Felipe Balbi <balbi@ti.com>
>> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> ---
>>  drivers/iio/adc/ti_am335x_adc.c      |   53 +++++++++++++++++++++++++++++-----
>>  drivers/mfd/ti_am335x_tscadc.c       |   29 ++++++++++++-------
>>  include/linux/mfd/ti_am335x_tscadc.h |    8 ++---
>>  3 files changed, 67 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>> index d821d88..cceff09 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -20,16 +20,19 @@
>>  #include <linux/slab.h>
>>  #include <linux/interrupt.h>
>>  #include <linux/platform_device.h>
>> -#include <linux/io.h>
>why? Not immediately obvious this has anything to do with the rest of this patch.

Yeah, a patch later or two it is added again :P Will drop this nonsense.

>>  #include <linux/iio/iio.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> +#include <linux/iio/machine.h>
>> +#include <linux/iio/driver.h>
>>
>>  #include <linux/mfd/ti_am335x_tscadc.h>
>>
>>  struct tiadc_device {
>>  	struct ti_tscadc_dev *mfd_tscadc;
>>  	int channels;
>> +	char *buf;
>> +	struct iio_map *map;
>>  };
>>
>>  static unsigned int tiadc_readl(struct tiadc_device *adc, unsigned int reg)
>> @@ -76,25 +79,59 @@ static void tiadc_step_config(struct tiadc_device *adc_dev)
>>  static int tiadc_channel_init(struct iio_dev *indio_dev, int channels)
>>  {
>>  	struct iio_chan_spec *chan_array;
>
>> -	int i;
>> -
>> -	indio_dev->num_channels = channels;
>> -	chan_array = kcalloc(indio_dev->num_channels,
>> -			sizeof(struct iio_chan_spec), GFP_KERNEL);
>> +	struct iio_chan_spec *chan;
>> +	char *s;
>> +	int i, len, size, ret;
>>
>
>This is less than beautiful... It'll cost you marginally more to
>allocate a separate array for the strings, but will be a lot nicer
>to read.  If we are dealing with a relatively small maximum number
>then just do it as a static const char * array of all possible
>strings.

The EVM board takes 4 and the maximum is 8. This is 20 bytes on EVM and
40 for the max. This probably does not hurt in data segment, will
change.

>
>> +	size = indio_dev->num_channels * (sizeof(struct iio_chan_spec) + 6);
>> +	chan_array = kzalloc(size, GFP_KERNEL);
>>  	if (chan_array == NULL)
>>  		return -ENOMEM;

Sebastian
