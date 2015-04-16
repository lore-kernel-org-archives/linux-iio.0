Return-Path: <jic23@jic23.retrosnub.co.uk>
References: <BN1PR0301MB0612F81FA6EDAADE705E39CEE2E40@BN1PR0301MB0612.namprd03.prod.outlook.com>
In-Reply-To: <BN1PR0301MB0612F81FA6EDAADE705E39CEE2E40@BN1PR0301MB0612.namprd03.prod.outlook.com>
From: jic23@jic23.retrosnub.co.uk
To: "utkarsh.gupta@freescale.com" <utkarsh.gupta@freescale.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
  "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "Jonathan
  Cameron" <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
  "Lars-Peter Clausen" <lars@metafoo.de>, Peter Meerwald
  <pmeerw@pmeerw.net>
Subject: Re: Advice needed on combination sensor driver implementation
Date: Thu, 16 Apr 2015 12:51:11 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Message-Id: <20150416115111.613FC405F1@saturn.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

utkarsh.gupta@freescale.com writes: 

> Hello, 
> 
> I am looking at implementing FXOS8700 driver, which consists of an accelerometer and magnetometer, into the linux kernel 4.0. This device can function independently as accel and magnetometer however it has been recommended to implement it as one driver in order to achieve consistency and synchronized functionality of both modules. 
> 
> Please advice on whether this driver could be implemented as accel_magnetometer combined driver in a separate folder in iio? Or should this be implemented as separate accel and magnetometer modules in their corresponding existing folders in iio?

Hi, Just been reading the datasheet over lunch.  This is a bit more
interesting than the usual approach of simply putting two bits of silicon
into one package, and the two sensors are tightly coupled. 

As such it's similar to the full IMUs such as the ADIS16400 and similar. 

Anyhow, definitely a unified driver. Location wise, I'm tempted to suggest
we rename the IMU directory as 'combined' or something similar and drop
all properly integrated multiple sensor devices in there. 

Note that things like the HID sensors have independent sampling rates and
timing for the different parts (they really are a bunch of sensors shoved
in a box) so there we do the whole separated drivers thing. 


There are certainly a few interesting corners on this chip, such as its
event based fifo filling.  We've seen that before in impact sensors, but
don't yet have it well supported. 

The fact that the fifo only covers the acceleration channels will make
that side of things a little trickier than normal.  We probably want
a means to make this apparent to userspace, but you'll have to disable
the fifo and read directly if the magnetometer channels are enabled. 

Anyhow, looking forward to seeing the driver! 

Jonathan
>  
> 
> Thanks & Regards,
> Utkarsh Gupta - B45806
> Software Apps Engineer
> Freescale Semiconductors 
> 
