Return-Path: <a.zummo@towertech.it>
Date: Sun, 16 Dec 2012 23:15:52 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Alexander Holler
 <holler@ahsoftware.de>, Jonathan Cameron <jic23@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Cameron
 <jic23@cam.ac.uk>, rtc-linux@googlegroups.com, srinivas pandruvada
 <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 3/3 v2] iio: add rtc-driver for HID sensors of type time
Message-ID: <20121216231552.4ced4d25@linux.lan.towertech.it>
In-Reply-To: <50C6FF71.1010504@metafoo.de>
References: <50C5DFCC.60203@ahsoftware.de>
	<1355151119-2489-1-git-send-email-holler@ahsoftware.de>
	<50C61675.2000407@metafoo.de>
	<50C63BBD.3080202@ahsoftware.de>
	<50C64484.4060306@metafoo.de>
	<50C65381.8010609@ahsoftware.de>
	<50C6567D.7080303@metafoo.de>
	<50C65746.8030609@kernel.org>
	<50C6674D.1000901@ahsoftware.de>
	<50C6FD60.7080300@jic23.retrosnub.co.uk>
	<50C6FF71.1010504@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Tue, 11 Dec 2012 10:40:01 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:
  
> > Yes, move the header or merge into existing one as makes sense.
> > I'm not pulling this driver into the IIO tree (unless for some
> > reason Alessandro wants me to and I can't think why he would...).
> >   
> 
> Alessandro has been pretty quiet for quite some time now. Luckily Andrew
> Morton usually picks up the stuff for orphaned subsystems. So put him on Cc
> for v4.

 Still reading e-mails ;) Andrew monitors the rtc mailing list and picks up
 the patches that do not need to go in any arch's main tree, which is the suggested
 way as, with modern chipsets, the RTCs shares hw with many other drivers.
 

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
