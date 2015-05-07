Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1431040617.2450.23.camel@spandruv-DESK3.jf.intel.com>
Subject: Re: [PATCH v2] iio: light: hid-sensor-prox: Fix memory leak in
 probe()/remove()
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Jonathan Cameron
	 <jic23@kernel.org>, LinuxTesting Org <khoroshilov@ispras.ru>,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org
Date: Thu, 07 May 2015 16:16:57 -0700
In-Reply-To: <CAOMZO5AxpV_dYU0g9SPHBpsK6ri6eB6tXdSOo10dsLyfUdUJTw@mail.gmail.com>
References: <1431007798-20807-1-git-send-email-fabio.estevam@freescale.com>
	 <1431035479.2450.9.camel@spandruv-DESK3.jf.intel.com>
	 <CAOMZO5DQCeXVRCT2bz=pGFk-kdyxiyydX6jYkL_9NX9tx9j-rQ@mail.gmail.com>
	 <CAOMZO5CaMMNXcG5qKrU10wZRrowGhUPon9oXJ2HXWtO-izMF7A@mail.gmail.com>
	 <1431039561.2450.14.camel@spandruv-DESK3.jf.intel.com>
	 <CAOMZO5AxpV_dYU0g9SPHBpsK6ri6eB6tXdSOo10dsLyfUdUJTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2015-05-07 at 20:05 -0300, Fabio Estevam wrote:
> On Thu, May 7, 2015 at 7:59 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> 
> >> I think it is better if we go with the v1 instead.
> > What is v1?
> 
> Sorry, I forgot to Cc in the first version of the patch:
> http://www.spinics.net/lists/linux-iio/msg18321.html

For that I will prefer, just remove channels declaration and
change 
channel = kememdup(..

to 
indio_dev->channels = kememdup(..

 
