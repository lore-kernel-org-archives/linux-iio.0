Return-Path: <SRS0=UNOS=F4=gmail.com=himanshujha199640@kernel.org>
Date: Wed, 7 Mar 2018 03:55:30 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Shreeya Patel <shreeya.patel23498@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Subject: Re: [PATCH 03/11] Staging: iio: accel: Remove unnecessary comments
Message-ID: <20180306222530.GA2604@himanshu-Vostro-3559>
References: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
 <1520236170-14668-4-git-send-email-himanshujha199640@gmail.com>
 <1520371619.4202.11.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1520371619.4202.11.camel@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Shreeya,

> I was just going through your patch for giving myself 
> a habit of reading patches.

Great!

> I see here that there are many comments which are necessary
> have also been removed.
> Jonathan told that some of the names do not explain
> much about the how registers are related to the orientation.
> So it is necessary for some comments to be there here.
> 
> I saw your next patch too, in which you are changing some of the
> names for betterment, but again, that doesn't cover everything which
> was told by Jonathan.
> 
> Here is the link to the patch where Jonathan had given detailed 
> description
> 
> Just sharing this information so in case if Jonathan agrees with
> this then he will not have to explain it all again :)
> 
> https://lkml.org/lkml/2018/3/3/104

Well, the naming of macros is debatable as Jonathan pointed out[1] and
the unusual/odd naming pointed to you was for rotation registers

#define ADIS16209_ROT_OUT_REG		0x10

I renamed the unusual/odd naming macros for eg
#define ADIS16209_DIAG_STAT_FLASH_UPT_BIT

to

#define ADIS16201_DIAG_STAT_FLASH_UPT_FAIL_BIT

as it didn't look like a failure bit address for which I consulted Jonathan to which
he agreed. Also, *DIAG_STAT* seems like a good name since these status registers
are serving the purpose of diagnosing the device behavior. Again, GLOB_CMD stands
for Global Command register for controlling the deivce operation such as
Fatory Reset, Software Reset, etc.

See, it is difficult to point the perfect names than the suitable ones!
And let's just leave these *bikeshedding* ;-)

-- 
Thanks
Himanshu Jha
