Return-Path: <ldewangan@nvidia.com>
Message-ID: <571828F0.8000101@nvidia.com>
Date: Thu, 21 Apr 2016 06:42:16 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: Eduardo Valentin <edubezval@gmail.com>
CC: <jic23@kernel.org>, <robh@kernel.org>, <rui.zhang@intel.com>,
	<mark.rutland@arm.com>, <pawel.moll@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH V4 2/2] thermal: generic-adc: Add ADC based thermal sensor
 driver
References: <1461050521-6080-1-git-send-email-ldewangan@nvidia.com> <1461050521-6080-2-git-send-email-ldewangan@nvidia.com> <20160420234322.GA2558@localhost.localdomain>
In-Reply-To: <20160420234322.GA2558@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>


On Thursday 21 April 2016 05:13 AM, Eduardo Valentin wrote:
> Laxman,
>
> On Tue, Apr 19, 2016 at 12:52:01PM +0530, Laxman Dewangan wrote:
>> In some of platform, thermal sensors like NCT thermistors are
>> connected to the one of ADC channel. The temperature is read by
>> reading the voltage across the sensor resistance via ADC. Lookup
>> table for ADC read value to temperature is referred to get
>> temperature. ADC is read via IIO framework.
>>
>> Add support for thermal sensor driver which read the voltage across
>> sensor resistance from ADC through IIO framework.
>>
>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> I really like this driver, as I mentioned  before. Just one comment
> though.
>
>> +
>> +	gti->tz_dev = thermal_zone_of_sensor_register(&pdev->dev, 0,
>> +						      gti, &gadc_thermal_ops);
> Why not using the devm_ version you introduced?
>
> Any particular reason?
>

Yaah, the reason is just to maintain the proper sequence in releasing of 
resource during driver unbinding.

Sequence in probe are:
         iio_channel_get()
         thermal_zone_of_sensor_register()

and on release, sensor should be released first before iio channel.
As of now, we do not have devm_iio_channel_get() [I already post patch 
and it is accepted by Jonathan in iio sub system] and hence I can not 
use the devm_ for sensor register to avoid race.

However, once the devm_ for iio channel get available in all subsystem 
(may be in next release), I will post the patch to use devm_.

Currently, we can go with these APIs.
