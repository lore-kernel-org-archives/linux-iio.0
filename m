Return-Path: <mtitinger@baylibre.com>
Subject: Re: [RFC 6/9] iio: ina2xx: add direct IO support for TI INA2xx Power
 Monitors
To: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, lars@metafoo.de,
 pmeerw@pmeerw.net
References: <1447857515-23935-1-git-send-email-mtitinger@baylibre.com>
 <1447857515-23935-7-git-send-email-mtitinger@baylibre.com>
 <5650B42D.6040500@kernel.org>
Cc: daniel.baluta@intel.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
From: Marc Titinger <mtitinger@baylibre.com>
Message-ID: <56533B8E.6050905@baylibre.com>
Date: Mon, 23 Nov 2015 17:15:10 +0100
MIME-Version: 1.0
In-Reply-To: <5650B42D.6040500@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 21/11/2015 19:13, Jonathan Cameron wrote:
> On 18/11/15 14:38, Marc Titinger wrote:
>> Basic support or direct IO raw read, with averaging attribute.
>> Values are RAW, INT_PLUS_MICRO (Volt/Ampere/Watt).
>>
>> Output of iio_info:
>>
>>       iio:device0: ina226
>>        4 channels found:
>>          power3:  (input)
>>          1 channel-specific attributes found:
>>                  attr 0: raw value: 1.150000
>>          voltage0:  (input)
>>          1 channel-specific attributes found:
>>                  attr 0: raw value: 0.000003
>>          voltage1:  (input)
>>          1 channel-specific attributes found:
>>                  attr 0: raw value: 4.277500
>>          current2:  (input)
>>          1 channel-specific attributes found:
>>                  attr 0: raw value: 0.268000
>>          4 device-specific attributes found:
>>                  attr 0: sampling_frequency_available value: 61 120 236...
>>                  attr 1: in_averaging_steps value: 4
>>                  attr 2: in_calibscale value: 10000
>>                  attr 3: in_sampling_frequency value: 1506
>>
>> Tested with ina226, on BeagleBoneBlack.
>>
>> Datasheet: http://www.ti.com/lit/gpn/ina226
>>
>> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
> You have added some new ABI in here, but I'm not seeing any documentation
> for averaging_steps.  Does this map onto the existing oversampling_ratio?
>

I am not sure normal averaging maps well with oversampling. Normal 
averaging will provide one value every N samples (this is what this chip 
does), while oversampling will interpolate N value between sample 'k' 
and 'k-1', and decimate to provide a less-noisy version of sample 'k', 
the resulting sampling frequency is not lower.
