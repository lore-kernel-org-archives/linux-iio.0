Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E610321.3000902@cam.ac.uk>
Date: Fri, 02 Sep 2011 17:24:01 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 00/16] staging:iio: CDC and other driver updates.
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

I've sent these and all Michaels more recent fixes on to Greg
(weird operating without hera) - if anyone needs the current tree
I can do a full patch set.
> Hi All,
> 
> Straight forward series - as you can see I've rolled in Michael's
> recent posting so you can see where they fit.
> 
> This lot sits on top of
> staging:iio: New stuff and reworks.
> 
> Nothing terribly interesting.  Mostly bringing a few drivers into
> line with the abi.  Thanks particularly to Michael for testing my
> hardware free changes and chasing down all the bugs!
> 
> Jonathan
> 
> Jonathan Cameron (7):
>   staging:iio:dac:ad5791 chan spec conversion.
>   staging:iio:adc:ad7150: chan_spec conv + i2c_smbus commands + drop
>     unused poweroff timeout control.
>   staging:iio:adc:ad7152 use smbus read / write functions + checkpatch
>     fixes
>   staging:iio:adc:ad7152 set correct number of channels for ad7153.
>   staging:iio:adc:ad7152 bring more into line with abi.
>   staging:iio:adc:ad7291 bring into line with current abi + chan_spec
>     conversion.
>   staging:iio:imu:adis16400 cleanups
> 
> Michael Hennerich (9):
>   staging:iio:adc:ad7150: remove conversion mode handling.
>   staging:iio:adc:ad7150: Add support for the second interrupt strobe.
>   staging:iio:adc:ad7152: increase readability by introducing proper
>     bit defines
>   staging:iio:adc:ad7152: Miscellaneous fixes and touch-up
>   staging:iio:adc:ad7152: update scale handling
>   staging:iio:adc:ad7152: Add proper locking
>   staging:iio:adc:ad7152: Update sample rate, conversion time, digital
>     filter handling
>   staging:iio:adc:ad7152: Fix differential channel return value and
>     increase delay.
>   iio: imu: adis16400: Avoid using printk facility
> 
>  drivers/staging/iio/adc/ad7150.c            |  930 +++++++++++----------------
>  drivers/staging/iio/adc/ad7152.c            |  783 +++++++++++------------
>  drivers/staging/iio/adc/ad7291.c            |  892 +++++++++-----------------
>  drivers/staging/iio/dac/ad5791.c            |  158 ++---
>  drivers/staging/iio/dac/ad5791.h            |    4 -
>  drivers/staging/iio/imu/adis16400_core.c    |  607 ++++++++++++------
>  drivers/staging/iio/imu/adis16400_trigger.c |    2 +-
>  7 files changed, 1560 insertions(+), 1816 deletions(-)
> 
