Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56181 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbbAJLDi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jan 2015 06:03:38 -0500
Message-ID: <54B10707.9060603@kernel.org>
Date: Sat, 10 Jan 2015 11:03:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sanchayan Maity <maitysanchayan@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: Query regarding a IIO consumer touchscreen driver
References: <54AF6DFA.7040204@gmail.com>
In-Reply-To: <54AF6DFA.7040204@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/01/15 05:58, Sanchayan Maity wrote:
> Hello,
> 
> I have been working on a IIO consumer touchscreen driver. On one of our Vybrid modules we use the ADC channels for
> the touchscreen. I ported an earlier driver in the 3.0 kernel done by my colleague to the recent 3.18/19 kernel to
> use the IIO based consumer interface.
> 
> The touchscreen driver is here
> http://git.toradex.com/cgit/linux-toradex.git/tree/drivers/input/touchscreen/colibri-vf50-ts.c?h=toradex_vf_3.18-next&id=7142dd741e948e1536632f9db1f3dd3a015450a5
> 
> The ADC driver with which it interacts is here
> http://git.toradex.com/cgit/linux-toradex.git/tree/drivers/iio/adc/vf610_adc.c?h=toradex_vf_3.18-next&id=7142dd741e948e1536632f9db1f3dd3a015450a5
> 
> Currently, this works in a limited capaicty I would say. One of the problems I have with this driver is that when
> this driver is used I can't get valid readings for any of the other ADC channels by using something like "cat". I
> believe this is because of the fact that the workqueue runs a while loop every 10ms and reads the channels. This
> clearly does not play well with reading of other channels and results in random reads on trying to read other channels,
> for example the temperature channel. The exact reason I have not figured out here. I was thinking may be a device
> lock would be required, but, that doesn't help.
Certainly sounds like something along those lines. 
> 
> The workqueue function
> http://git.toradex.com/cgit/linux-toradex.git/tree/drivers/input/touchscreen/colibri-vf50-ts.c?h=toradex_vf_3.18-next&id=7142dd741e948e1536632f9db1f3dd3a015450a5#n102
> 
> The primary read raw function
> http://git.toradex.com/cgit/linux-toradex.git/tree/drivers/iio/adc/vf610_adc.c?h=toradex_vf_3.18-next&id=7142dd741e948e1536632f9db1f3dd3a015450a5#n449
> 
> I was thinking this would need a better design than what has been done? Can someone give some suggestions as what
> would be the right design/architecture here. I was thinking if setting up a IIO ring buffer, pushing the readings
> to it and then reading from the touchscreen driver would work. One of the aims is also to make it clean enough for
> eventual submission to the mainline. 
This sort of use case was what the in kernel buffer interfaces were intended for.
They don't actually use a buffer as such - but rather at the same point where
we demultiplex the incoming data to fill the IIO buffer we can also send data
on to other 'consumer' drivers.

It's rather ancient but I did write a proof of concept input driver at one point.
http://permalink.gmane.org/gmane.linux.kernel.iio/5757
Might be the latest version...

Should give you an idea of the thinking behind it anyway.  We have have discussed
a generic approach to touchscreen drivers based on ADCs in the past, but that
has mostly been for devices with more explicit touch screen features and we
concluded that writing a generic driver would be 'tricky' given how many
subtle variants there are.

Looking at the driver - you are correct that the first step would be to
implement buffered IIO support and go from there.  It's a bit of an irritating
device by the look of it... Every time you want to grab a different channel
you have to explicitly change it (not concept of multichannel scans).
It does have a continuous mode which would be great to support, but that's
not going to be much use for your touch screen as it will only read one
channel.

Another more generic snag is that currently is drivers operate in one or other mode.
Either we do buffered access, or we do polled access.  The only devices
that do both are those that maintain hardware storage of the previous
value for a given channel.

I have some thoughts on how to deal with this by grabbing additional
'of interest' channels during buffered capture and stashing them.  The
main issue is that the userspace interface is then messy or non obvious.

Hope that might give you somewhere to get started.

Jonathan
> 
> Thanks & Regards,
> Sanchayan Maity.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

