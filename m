Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:40021 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752449AbcF2DYw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2016 23:24:52 -0400
Subject: Re: Question on shared attributes
To: "Cercueil, Paul" <Paul.Cercueil@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <e87b35bc-36e9-dc1a-a87e-4e1c20db8d2e@electromag.com.au>
 <1467110288.2364.11.camel@analog.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <8387fdf7-dc3a-fc06-9dc5-6c73995ad366@electromag.com.au>
Date: Wed, 29 Jun 2016 11:24:46 +0800
MIME-Version: 1.0
In-Reply-To: <1467110288.2364.11.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/06/2016 18:38, Cercueil, Paul wrote:
> Hi Phil,
>
> I think right now libiio doesn't handle shared-by-dir attributes yet,
> only shared-by-type. Ideally, 'in_sampling_frequency' should appear as
> a 'sampling_frequency' attribute on all input channels of your module0
> device.
>
> Regards,
> Paul Cercueil
>
> Le mardi 28 juin 2016 à 16:55 +0800, Phil Reid a écrit :
>> G'day All,
>>
>> Found something interesting.
>> For a new iio driver I have a shared attribute on direction.
>>
>> .info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ)
>>
>> Which results in sysfs attribute name of:
>> in_sampling_frequency
>>
>> Which results in iio_info giving the following output:
>> iio:device3: module0
>>          7 channels found:
*snip*
>>                  sampling:  (input)
>>                  1 channel-specific attributes found:
>>                          attr 0: frequency value: 24000
>>          2 device-specific attributes found:
>>                          attr 0: freq value: 6144000
>>                          attr 1: out_en value: 0
>>
>>
>> Note that the sampling_frequency attr has been converted into an
>> input channel.
>>
>> Modify the definition in industrialio-core.c
>> 	[IIO_CHAN_INFO_SAMP_FREQ] = "sampling_frequency",
>> to
>> 	[IIO_CHAN_INFO_SAMP_FREQ] = "samplingfrequency",
>>
>> Results in the following output:
>> iio:device4: module0
>>          6 channels found:
*snip*
>>          3 device-specific attributes found:
>>                          attr 0: freq value: 6144000
>>                          attr 1: in_samplingfrequency value: 24000
>>                          attr 2: out_en value: 0
>>
>> Which makes more sense. So libiio is treating the name sampling as a
>> channel name
>> in 'in_sampling_frequency' assuming that attributes never have an
>> underscore in there name.
>>
>> I'm guessing the same would be the case for out attributes as well.
>>
>> A quick search of the drivers in the kernel to date indicate that
>> IIO_CHAN_INFO_SAMP_FREQ is generally
>> shared by type or all. shared by dir occurs with the
>> iio_simple_dummy, but can't see anything with a real device.
>> I'm using libiio from git://github.com/analogdevicesinc/libiio.git
>>
>> So is this intended, or does libiio need to be smarter on identifying
>> channels and shared attributes?
>> I'm guessing we cant change the kernel interface, which would be the
>> easiest fix. :/
>>

I found making it a info_mask_shared_by_type resulted in the sampling_freq
becoming an attribute of all the input channels. I find it a little conintutive
that a shared attribute is populated into all the channels. libiio doesn't
seem to provide an interface I can find to indicate if a parameter is shared or not.
I guess with the current method of multiplexing the data streams it doesn't make
sense to have anything other than the same value for sample rate.
I just assumed that the sample_frequency would have been a device specific value.


-- 
Regards
Phil Reid


