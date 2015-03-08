Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35143 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbbCHLv6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 07:51:58 -0400
Message-ID: <54FC37DC.4010608@kernel.org>
Date: Sun, 08 Mar 2015 11:51:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: daniel.baluta@intel.com, octavian.purdila@intel.com,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 2/4] iio: Introduce IIO_CHAN_INFO_RANGE
References: <1424720154-4762-1-git-send-email-roberta.dobrescu@gmail.com> <1424720154-4762-3-git-send-email-roberta.dobrescu@gmail.com> <54FC35A0.6000901@kernel.org>
In-Reply-To: <54FC35A0.6000901@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/03/15 11:42, Jonathan Cameron wrote:
> On 23/02/15 19:35, Roberta Dobrescu wrote:
>> Some ambient light sensors have hardware dependent ranges and
>> resolutions. In this case user won't be able to calculate illuminance
>> (lux) using only scale attribute.
>>
>> For instance, a device that uses a Full Scale Range is the
>> light sensor ISL29018. In this case, IIO_CHAN_INFO_RANGE is
>> needed since the number of ADC bits can be 4, 8, 12 or 16 and
>> using just scales would result in too similar values for different
>> ranges and resolutions.
> This is always an interesting corner.  The big question is what is
> to be gained by ever running these sensors in their lower resolutions?
> 
> The reason I've always resisted range is that it's too easy
> for people to be lazy and go with which ever of scale / range
> is presented in the datasheet.  Most of the time they are really
> the same thing.
> 
> The exception as you've noted here is in variable resolution devices.
> There is no way that any generic code is ever going to know the right
> option for the combinations of scaling and adc resolution vs time
> requirements.  So we are dealing here with parameters that might
> be hand tweaked for a particular board.
> 
> Anyhow, I'd like more opinions on this before I take it.
> 
> Lars, Peter, Hartmut - what you guys think on this?
> 
Actually please see my comments on patch 4.
This device has tight coupling between the integration time
and the adc resolution.  Hence that's the parameter to provide
/ control in my view.

Jonathan
> 
>>
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
>>  drivers/iio/industrialio-core.c         |  1 +
>>  include/linux/iio/iio.h                 |  1 +
>>  3 files changed, 15 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
>> index 9a70c31..ad1541f 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-iio
>> +++ b/Documentation/ABI/testing/sysfs-bus-iio
>> @@ -1249,3 +1249,16 @@ Contact:	linux-iio@vger.kernel.org
>>  Description:
>>  		Specifies number of seconds in which we compute the steps
>>  		that occur in order to decide if the consumer is making steps.
>> +
>> +What:		/sys/bus/iio/devices/deviceX/in_illuminance0_range
>> +KernelVersion:	3.21
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Hardware dependent ADC Full Scale Range used for some ambient
>> +		light sensors in calculating lux.
>> +
>> +What:		/sys/bus/iio/devices/deviceX/in_illuminance_range_available
>> +KernelVersion:	3.21
>> +Contact:	linux-iio@vger.kernel.org
>> +Description:
>> +		Hardware dependent supported values for ADC Full Scale Range.
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index aaba9d3..4138042 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -128,6 +128,7 @@ static const char * const iio_chan_info_postfix[] = {
>>  	[IIO_CHAN_INFO_CALIBWEIGHT] = "calibweight",
>>  	[IIO_CHAN_INFO_DEBOUNCE_COUNT] = "debounce_count",
>>  	[IIO_CHAN_INFO_DEBOUNCE_TIME] = "debounce_time",
>> +	[IIO_CHAN_INFO_RANGE] = "range",
>>  };
>>  
>>  /**
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index 80d8550..fbdd434 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -43,6 +43,7 @@ enum iio_chan_info_enum {
>>  	IIO_CHAN_INFO_CALIBWEIGHT,
>>  	IIO_CHAN_INFO_DEBOUNCE_COUNT,
>>  	IIO_CHAN_INFO_DEBOUNCE_TIME,
>> +	IIO_CHAN_INFO_RANGE,
>>  };
>>  
>>  enum iio_shared_by {
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

