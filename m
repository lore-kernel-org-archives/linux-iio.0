Return-Path: <jic23@cam.ac.uk>
Message-ID: <4C8B9ABA.7090607@cam.ac.uk>
Date: Sat, 11 Sep 2010 16:05:30 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
 Robin.Getz@analog.com, manuel.stahl@iis.fraunhofer.de
Subject: Re: [PATCH 6/6] staging:iio:adis16400 merge into adis16350 driver
References: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk> <1284217100-2469-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284217100-2469-7-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/11/10 15:58, Jonathan Cameron wrote:
> Results in a subtle change to numbering of scan elements on
> the adis16350. This does not technically change the abi as
> these numbers are only guaranteed to be in the correct order,
> not to have particular values.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/imu/Kconfig          |   13 +-
>  drivers/staging/iio/imu/Makefile         |    4 -
>  drivers/staging/iio/imu/adis16350.h      |   18 +-
>  drivers/staging/iio/imu/adis16350_core.c |   69 +++
>  drivers/staging/iio/imu/adis16350_ring.c |   33 ++-
>  drivers/staging/iio/imu/adis16400.h      |  208 --------
>  drivers/staging/iio/imu/adis16400_core.c |  752 ------------------------------
>  drivers/staging/iio/imu/adis16400_ring.c |  231 ---------
>  8 files changed, 116 insertions(+), 1212 deletions(-)
> 
And here I go again.  This one should also delete the adis16400_trigger.c file which is
no longer used.  Doh.  Changes the stats to:

 drivers/staging/iio/imu/Kconfig             |   13 +-
 drivers/staging/iio/imu/Makefile            |    4 -
 drivers/staging/iio/imu/adis16350.h         |   18 +-
 drivers/staging/iio/imu/adis16350_core.c    |   69 +++
 drivers/staging/iio/imu/adis16350_ring.c    |   33 ++-
 drivers/staging/iio/imu/adis16400.h         |  208 --------
 drivers/staging/iio/imu/adis16400_core.c    |  752 ---------------------------
 drivers/staging/iio/imu/adis16400_ring.c    |  231 --------
 drivers/staging/iio/imu/adis16400_trigger.c |  125 -----
 9 files changed, 116 insertions(+), 1337 deletions(-)

Now these are the kind of patch statistics that people like ;)

There is also a subtle difference in here I forgot to mention. Their is no longer a device
id check on probe. I can put this back in if people would like it.  It wasn't ever there in
the adis16350 as far as I know...

Jonathan
