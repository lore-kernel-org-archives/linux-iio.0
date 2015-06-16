Return-Path: <pmeerw@pmeerw.net>
Date: Tue, 16 Jun 2015 22:41:05 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Daniel Baluta <daniel.baluta@intel.com>
cc: jic23@kernel.org, vlad.dogaru@intel.com, tiberiu.a.breana@intel.com,
    knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
    linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: ABI: Clarify proximity output value
In-Reply-To: <1434037774-22081-2-git-send-email-daniel.baluta@intel.com>
Message-ID: <alpine.DEB.2.02.1506162234100.22088@pmeerw.net>
References: <1434037774-22081-1-git-send-email-daniel.baluta@intel.com> <1434037774-22081-2-git-send-email-daniel.baluta@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

> Current description for proximity measurement is ambiguous. While
> the first part says that proximity is measured by observing
> reflectivity, the second part incorrectly infers that reported values
> should behave like a distance.
> 
> This is because of AS3935 lightning sensor which uses the proximity
> API, while not being a true proximity sensor.

Acked-by: Peter Meerwald <pmeerw@pmeerw.net>
 
> Fixes:  614e8842ddf ("iio: ABI: add clarification for proximity")
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index bbed111..70c9b1a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1234,10 +1234,8 @@ Description:
>  		object is near the sensor, usually be observing

>  		reflectivity of infrared or ultrasound emitted.
>  		Often these sensors are unit less and as such conversion
> -		to SI units is not possible.  Where it is, the units should
> -		be meters.  If such a conversion is not possible, the reported
> -		values should behave in the same way as a distance, i.e. lower
> -		values indicate something is closer to the sensor.
> +		to SI units is not possible. Higher proximity measurements
> +		indicate closer objects, and vice versa.
>  
>  What:		/sys/.../iio:deviceX/in_illuminance_input
>  What:		/sys/.../iio:deviceX/in_illuminance_raw
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
