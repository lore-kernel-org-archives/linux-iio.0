Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:55439 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250Ab1CIOQN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2011 09:16:13 -0500
Message-ID: <4D778BE1.3090606@cam.ac.uk>
Date: Wed, 09 Mar 2011 14:17:05 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO:DAC: AD5624R: Update to IIO ABI
References: <1299593700-10724-1-git-send-email-michael.hennerich@analog.com> <4D775BF3.5090900@cam.ac.uk> <4D7783C4.9030400@analog.com>
In-Reply-To: <4D7783C4.9030400@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/09/11 13:42, Michael Hennerich wrote:
> On 03/09/2011 11:52 AM, Jonathan Cameron wrote:
>> On 03/08/11 14:15, michael.hennerich@analog.com wrote:
>>   
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> This driver did not conform with the IIO ABI for such devices.
>>> Also the sysfs files that this driver adds were not complete and
>>> partially un-documented.
>>>
>>> Update and document ABI
>>> Change License notice, stick to GPL-v2.
>>> Fix indention style
>>> Add option to specify external reference voltage via the regulator framework.
>>> Add mandatory name attribute
>>> Add mandatory out_scale attribute
>>>
>>>     
>> Hi Michael,
>>
>> Another nice bit of cleaning up.
>>
>> Couple of trivial bits and bobs inline. Only one I really care about is
>> that documentation of powerdown_mode should include descriptions of
>> all options that are used.  Do that or convince me otherwise before
>> sending on.
>>
>>   
> I'll add the existing options, but there might be some more
> - depending on the parts were going to add in future.
Yup. We'll add those when they occur.
...
>>> +What:                /sys/bus/iio/devices/deviceX/out_powerdown
>>> +KernelVersion:       2.6.38
>>> +Contact:     linux-iio@vger.kernel.org
>>> +Description:
>>> +             Writing 1 causes output Y to enter the power down mode specified
>>> +             by the corresponding outY_powerdown_mode. Clearing returns to
>>> +             normal operation. Y may be suppressed if all outputs are
>>> +             controlled together.
>>>     
>> I'm happy with the interface you've defined here, but do vaguely wonder if there
>> is anything similar in kernel already...  Can't immediately think where, but worth
>> keeping in mind.
>>   
> There is global power management support CONFIG_PM, allowing you to
> shutdown devices during sleep or hibernate.
> It might make sense, to support it here as well. But power down a set of
> outputs may be required during normal operation as well.
True. Guess we put it here until something better comes along.
..
>>> +/**
>>> + * struct ad5624r_chip_info - chip specific information
>>> + * @bits:            accuracy of the DAC in bits
>>> + * @int_vref_mv:     AD5620/40/60: the internal reference voltage
>>> + */
>>> +
>>> +struct ad5624r_chip_info {
>>> +     u8                              bits;
>>> +     u16                             int_vref_mv;
>>> +};
>>> +
>>>     
>> Whilst I have no particular problem with having these structures defined
>> in the header, is there a particular reason for doing so?
>>   
> No - If you prefer - I'll move them back int the main driver file.
I don't mind. Just in general go for minimal changes where possible.

>>> +/**
>>> + * struct ad5446_state - driver instance specific data
>>> + * @indio_dev:               the industrial I/O device
>>> + * @us:                      spi_device
>>> + * @chip_info:               chip model specific constants, available modes etc
>>> + * @reg:             supply regulator
>>> + * @vref_mv:         actual reference voltage used
>>> + * @pwr_down_mask    power down mask
>>> + * @pwr_down_mode    current power down mode
>>> + */
>>> +
>>> +struct ad5624r_state {
>>> +     struct iio_dev                  *indio_dev;
>>> +     struct spi_device               *us;
>>> +     const struct ad5624r_chip_info  *chip_info;
>>> +     struct regulator                *reg;
>>> +     unsigned short                  vref_mv;
>>> +     unsigned                        pwr_down_mask;
>>> +     unsigned                        pwr_down_mode;
>>> +};

...
