Return-Path: <randy.dunlap@oracle.com>
Message-ID: <4C51BC8F.30105@oracle.com>
Date: Thu, 29 Jul 2010 10:38:23 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Greg KH <greg@kroah.com>, akpm@linux-foundation.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/6 V2] staging:iio Build issue fixes
References: <1280422251-13572-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1280422251-13572-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/29/10 09:50, Jonathan Cameron wrote:
> Hi All,
> 
> This lot are in response to Randy Dunlap finding a number of build
> issues.  The final patch actually fixes a bug that has been there
> quite some time.
> 
> Sorry again for clearly not testing my previous series properly!
> 

Thanks for the quick update.
Acked-by: Randy Dunlap <randy.dunlap@oracle.com>


> 
> Jonathan Cameron (6):
>   staging:iio: iio_sw_ring_helper_state - add dummy case for no buffer
>     builds.
>   staging:iio:lis3l02dq add a thresh_timestamp field to state for no
>     ring case
>   staging:iio:adis16350 add dummy ring functions for no ring build case
>   staging:iio:ring_sw  Add select of triggers to avoid build issue.
>   staging:iio:ring_sw  remove unnecessary function stub.
>   staging:iio:ring_sw  Fix pointer arithmetic for 64bit arches by using
>     phys_addr_t
> 
>  drivers/staging/iio/Kconfig                |    1 +
>  drivers/staging/iio/accel/lis3l02dq.h      |    2 ++
>  drivers/staging/iio/accel/lis3l02dq_core.c |   14 +++++++-------
>  drivers/staging/iio/imu/adis16350.h        |    8 ++++++++
>  drivers/staging/iio/ring_sw.c              |    2 +-
>  drivers/staging/iio/ring_sw.h              |    5 +++--
>  6 files changed, 22 insertions(+), 10 deletions(-)
> 


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
