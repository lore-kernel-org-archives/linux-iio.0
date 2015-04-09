Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54298 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbbDIR4w (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 13:56:52 -0400
Message-ID: <5526BD63.3080509@kernel.org>
Date: Thu, 09 Apr 2015 18:56:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "s.rawat" <imsaurabhrawat@gmail.com>,
	Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Regarding generic_buffer.c Application for Android
References: <CALwa49vRGN_VaJ147PVF8Cf+8vnBotWVh7hmxLj=jaAba5QTTw@mail.gmail.com>
In-Reply-To: <CALwa49vRGN_VaJ147PVF8Cf+8vnBotWVh7hmxLj=jaAba5QTTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/03/15 17:36, s.rawat wrote:
> Hi Jonathan,
> 
> I have tested and used the generic_buffer.c application and found it
> to be good for testing the IIO drivers.I tried it on one of the
> android system and found it to be failing.(Android System has CPU ABI
> armv7-eabi )
> 
> Here is a short summary to investigate why it didnt work on
> Andorid.Can you plz provide your comments:
> 
> I have two system having different kernel version and drivers(IIO) on
> which I can run the
> generic_buffer.c(http://lxr.free-electrons.com/source/drivers/staging/iio/Documentation/generic_buffer.c)
> application .On one system it works(kernel 3.18.15) fine but on the
> other(3.10.20) it does not give the input reports data.I have already
> applied the attached patch to it.
> 
> I have checked that the system on which it is working has the
> following sysfs under /sys/bus/iio/devices/iio:deviceX (where X is
> 1,2,3...)
> 
> buffer
> 
> dev
> 
> in_accel_hysteresis
> 
> in_accel_offset
> 
> in_accel_sampling_frequency
> 
> in_accel_scale
> 
> in_accel_x_raw
> 
> in_accel_y_raw
> 
> in_accel_z_raw
> 
> name
> 
> power
> 
> scan_elements
> 
> subsystem
> 
> trigger
> 
> uevent
> 
>  
> 
> This is for accelerometer, similarly for magnetometer (in_magn_x_raw,_y_raw,z_raw etc) and for Gyrometer ( in_anglvel_x_raw,in_anglvel_y_raw,in_anglvel_z_raw )
> 
>  and the one on which it is not working has the below sysfs under /sys/bus/iio/devices/iio:deviceX (where X is 1,2,3...) :
> 
>  buffer
> 
> dev
> 
> in_accel_hysteresis
> 
> in_accel_offset
> 
> in_accel_sampling_frequency
> 
> in_accel_scale
> 
> name
> 
> power
> 
> scan_elements
> 
> subsystem
> 
> trigger
> 
> uevent
> 
>  
> 
> Is the missing *_x_raw,_y_raw and _z_raw* component main reason for not working of the app?If yes how can I enable it? –
Not as such. However it is certainly curious that you have them missing. 
These provide direct sysfs access to the accelerations. 

We did at one point make it a requirement for the iio_chan_spec to explicitly include the IIO_CHAN_INFO_RAW bit
rather than using the prior separate callbacks for that.  Perhaps it is missing in your driver?

What is the actual driver in question?

> 
> Additionally, the system on which it doesn’t works  is the Android System for which I have cross compiled the generic_buffer.c
> 
>  
> 
> *[1] + stopped (signal) ./generic buffer –c 10 –n accel_3d (*basically waits at some point in the application and then  some illegal termination may be)**
> 
>  
> 
> Plz let me know your  comments on this.I need to run the same app for the Android system.
> 
> 
> Many Thanks in advance !
> 
> Best Rgds,
> 
> Saurabh
> 

