Return-Path: <jic23@hermes.cam.ac.uk>
Date: 09 Jan 2011 21:05:11 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: "J.I. Cameron" <jic23@cam.ac.uk>
Cc: Roland Stigge <stigge@antcom.de>, Greg KH <greg@kroah.com>, devel@driverdev.osuosl.org,
   linux-iio@vger.kernel.org
Subject: Re: Linux driver for MAX517/518/519
Message-ID: <Prayer.1.3.3.1101092105110.31514@hermes-2.csi.cam.ac.uk>
In-Reply-To: <Prayer.1.3.3.1101092055540.18031@hermes-2.csi.cam.ac.uk>
References: <4D21A2AA.6080006@antcom.de>
 <20110103222834.GA11277@kroah.com>
 <4D29F9DB.9000006@antcom.de>
 <Prayer.1.3.3.1101092055540.18031@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Jan 9 2011, J.I. Cameron wrote:

>On Jan 9 2011, Roland Stigge wrote:
>
>>Hi,
>>
>>On 03/01/11 23:28, Greg KH wrote:
>>> It's best to convert to the iio subsystem, as that is the way to go in
>>> the future.
>>
>>I'm also preparing a plain PWM driver for the LPC3250 SoC.
>>
>>Would IIO be an appropriate place?
> No. There is a pwm subsystem. I think thee actual drivers tend to go in 
> the relevant arch directory. So far I think all of the are all arch 
> specific. We do have some recently added support for direct digital 
> synthesis (from Analog devices). There's obviously some common 
> functionality, though the DDS devices tend to be for modulation purposes. 
> Obviously pwm's have loads of uses, but tend to only need a very simple 
> interface. I have wondered if we ought to support this as part of the dds 
> interface, but so far I don't think we have a device anyone would 
> actually use as simply a pwm.
>
> Anyhow, see include/linux/pwm.h for pwm interface. Examples of 
> implementations in arch/arm/plat-pxa and a few others in arch arm. Not 
> that many users yet based on a quick grep.
>
>Anyhow, the code in place looks to have come from Russell King (arm 
>maintainer). I know Bill Gatliff proposed something similar... 
>http://lists.openwall.net/linux-kernel/2010/02/02/353
>
>Hope that helps. Will take a look at ADC driver sometime tomorrow with
>a bit of luck.
Doh! DAC...  
>
>Thanks,
>
>Jonathan
>
>>
>>Thanks in advance,
>>
>>Roland
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
