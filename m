Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41342 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab3GPIbQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 04:31:16 -0400
Message-ID: <51E504D2.5030000@kernel.org>
Date: Tue, 16 Jul 2013 09:31:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: Help with fitting unusual devices into IIO framework
References: <51E46F7A.9020400@cogentembedded.com>
In-Reply-To: <51E46F7A.9020400@cogentembedded.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/15/2013 10:54 PM, Sergei Shtylyov wrote:
> Hello.
> 
One quick point first, if you could persuade your email client to wrap at 80 characters
that  would be great.

> Recently I have posted a driver for drivers/misc/ driving a pair of devices: Renesas R-Car > Gyro-ADC and speed-pulse interfaces [1]. Arnd Bergmann, one of the maintainers told me
> that such driver would fit better into the IIO infrastructure. I have studied this
> infrastructure for some time and only found in it a place for the Gyro-ADC
> interface.

> Let me describe the devices to be driven in some detail. Gyro-ADC i/f is an
> interface to multichannel serial ADC (of 3 certain models) which can also calculate and
> average of each 8 samples and sum up 10 of these average values.
That is indeed fairly standard although some of the ABI for summed values is still under
discussion.

http://thread.gmane.org/gmane.linux.kernel.iio/7978/focus=79864 for example.

> Speed-pulse interface
> can count PWM-type input signal pulses and period between them. Though  being
> two separate devices, these two have to be driven together because of the shared 
> start/stop register (located in Gyro-ADC i/f still) and the clock with 1.25 ms period
> supplied from the Gyro-ADC i/f to the speed-pulse i/f; at the same time speed-pulse i/f
> generates interrupt with 100 ms period to be used by both interfaces. At this time, only
> speed-pulse interface support is required, Gyro-ADC can be largely ignored (though it
> has to be initialized). Perhaps  we could add a new I/O channel type for speed-pulse i/f?
> What's your thoughts?

I certainly have no problem with adding this device type.
Would you like to propose a suitable ABI addition to
/Documentation/ABI/test/sysfs-bus-iio to cover this type of device.

I do vaguely wonder if we would be better treating these entirely generically as pulse
counters rather than specifically as being for speed measurement? (Note I have only
the sketchiest idea of what this device actually does ;)
> 
> [1] marc.info/?l=linux-kernel&m=137367311823027
> 
> WBR, Sergei
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
