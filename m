Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44163 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbbK2PSD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Nov 2015 10:18:03 -0500
Subject: Re: [RFC 6/9] iio: ina2xx: add direct IO support for TI INA2xx Power
 Monitors
To: Marc Titinger <mtitinger@baylibre.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <1447857515-23935-1-git-send-email-mtitinger@baylibre.com>
 <1447857515-23935-7-git-send-email-mtitinger@baylibre.com>
 <5650B42D.6040500@kernel.org> <56533B8E.6050905@baylibre.com>
Cc: daniel.baluta@intel.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <565B1727.8090506@kernel.org>
Date: Sun, 29 Nov 2015 15:17:59 +0000
MIME-Version: 1.0
In-Reply-To: <56533B8E.6050905@baylibre.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/11/15 16:15, Marc Titinger wrote:
> On 21/11/2015 19:13, Jonathan Cameron wrote:
>> On 18/11/15 14:38, Marc Titinger wrote:
>>> Basic support or direct IO raw read, with averaging attribute.
>>> Values are RAW, INT_PLUS_MICRO (Volt/Ampere/Watt).
>>>
>>> Output of iio_info:
>>>
>>>       iio:device0: ina226
>>>        4 channels found:
>>>          power3:  (input)
>>>          1 channel-specific attributes found:
>>>                  attr 0: raw value: 1.150000
>>>          voltage0:  (input)
>>>          1 channel-specific attributes found:
>>>                  attr 0: raw value: 0.000003
>>>          voltage1:  (input)
>>>          1 channel-specific attributes found:
>>>                  attr 0: raw value: 4.277500
>>>          current2:  (input)
>>>          1 channel-specific attributes found:
>>>                  attr 0: raw value: 0.268000
>>>          4 device-specific attributes found:
>>>                  attr 0: sampling_frequency_available value: 61 120 236...
>>>                  attr 1: in_averaging_steps value: 4
>>>                  attr 2: in_calibscale value: 10000
>>>                  attr 3: in_sampling_frequency value: 1506
>>>
>>> Tested with ina226, on BeagleBoneBlack.
>>>
>>> Datasheet: http://www.ti.com/lit/gpn/ina226
>>>
>>> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
>> You have added some new ABI in here, but I'm not seeing any documentation
>> for averaging_steps.  Does this map onto the existing oversampling_ratio?
>>
> 
> I am not sure normal averaging maps well with oversampling. Normal
> averaging will provide one value every N samples (this is what this
> chip does), while oversampling will interpolate N value between
> sample 'k' and 'k-1', and decimate to provide a less-noisy version of
> sample 'k', the resulting sampling frequency is not lower.
> 
Oversampling is wonderfully badly defined as a term.  Often it is use precisely for the
method or noise reduction that is infact just an average.   Usually it implies:
1) Sampling at a higher rate than the eventual output will be provided at. This is the oversampling bit.
2) Sometimes adding carefully controlled noise - effectively dithering but ensuring the
noise is not at a frequency of interest so it can be removed later without effecting
what we are after - this allows obtaining a theoretically higher bit rate signal than
what you are measuring with - in extreme cases it allows the one bit adc trick - more
commonly it's just about reducing the noise as a result of the measurement process.
3) ADC conversion - post noise addition if we are deliberately adding some.
4) Applying digital filters as desired.
5) Finally outputing at the reduced data rate.

So - in the simplest form we actually have a straight forward average filter just like
the one your device is applying.  

Now you are correct that the data goes digital at a much higher rate than the output
rate in oversampling - however if we assume a chip is providing an oversampling function
inherently it must then be dropping it down to a more reasonable level in chip (rather than
leaving it to the CPU)  Hence if we have an iio chip with oversampling it's applying a
filter - whether that is a simple average filter, or something a touch more clever is the
only real question.

Now I've probably confused this discussion even more ;)

Jonathan

