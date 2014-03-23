Return-Path: <zubair.lutfullah@gmail.com>
Date: Sun, 23 Mar 2014 18:54:47 +0000
From: "Zubair Lutfullah :" <zubair.lutfullah@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: gmane@reliableembeddedsystems.com, linux-iio@vger.kernel.org,
	Zubair Lutfullah:  zubair.lutfullah@gmail.com
Subject: Re: iio on beagle bone black 3.13.6 kernel
Message-ID: <20140323185446.GA2485@gmail.com>
References: <be30164b26d247c2576ba7369032bc23@reliableembeddedsystems.com>
 <532F1DE0.9090908@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <532F1DE0.9090908@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Mar 23, 2014 at 05:46:08PM +0000, Jonathan Cameron wrote:
> On 22/03/14 17:19, gmane@reliableembeddedsystems.com wrote:
> >Hi,
> >
> >I use a beagle bone black with a 3.13.6 kernel and would like to get the
> >./generic_buffer test which comes with the kernel to work.
> >
> >This is what I do:
> >
> >echo 1 > /sys/bus/iio/devices/iio_sysfs_trigger/add_trigger
> >
> >ls /sys/bus/iio/devices/
> >iio:device0  iio_sysfs_trigger  trigger0
> >
> >cat /sys/bus/iio/devices/trigger0/name
> >sysfstrig1
> >
> >echo 1 > /sys/bus/iio/devices/iio:device0/scan_elements/in_voltage5_en
> >
> >
> >./generic_buffer.out -n TI-am335x-adc -t sysfstrig1 -l 128
> >iio device number being used is 0
> >iio trigger number being used is 0
> >  sysfstrig1
> >---> Could not open /trigger/current_trigger
> >Failed to write current_trigger file
> >
> >How can I get rid of this?
> >
> >Is this a problem with my driver, or should I just create this magic
> >file somewhere?
> Does /sys/bus/iio/device/iio:device0/trigger/current_trigger exist?
> If so, try
> echo sysfstrig1 > /usys/bus/iio/device/iio:device0/trigger/current_trigger
> and see if that gives an error or not, then cat the same file to see if
> it 'took'.
> 
> Otherwise, I'm not sure...
> 
> Zubair, any thoughts?
> 

I thought we removed trigger from this driver for using continuous sampling.
It was a hardware buffer driver with not proper support in generic_buffer.c

For one-shot sampling you just cat /sys/bus/iio/devices/iio:device0/channel etc.
For continuous sampling, modify generic_buffer.c to remove trigger checks.

Could you please tell me where you got this driver? It shouldn't be in any tree..

Regards
ZubairLK
