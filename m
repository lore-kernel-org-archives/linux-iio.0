Return-Path: <randy.dunlap@oracle.com>
Message-ID: <4C508EB8.7020404@oracle.com>
Date: Wed, 28 Jul 2010 13:10:32 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Greg KH <greg@kroah.com>, akpm@linux-foundation.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] staging:iio Build issue fixes
References: <4C5077A0.7090701@cam.ac.uk> <1280344057-18786-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1280344057-18786-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/28/10 12:07, Jonathan Cameron wrote:
> Hi Greg,
> 
> Sorry about this lot.  I clearly missed one big case when build testing
> the last series of patches I sent you. Evidently never built them without
> buffering enabled.
> 
> Randy Dunlap found these 3 (posted to lkml in the thread,
> 
> mmotm 2010-07-27-14-56 uploaded (staging/iio)
> 
> I know of one remaining issue to do with some pointer arithmetic that won't
> work on 64 bit machines that I will try and get fixed shortly.

Thanks.  With these 3 patches applied, I still have this build warning:

In file included from linux-next-20100728/drivers/staging/iio/accel/lis3l02dq_core.c:31:
linux-next-20100728/drivers/staging/iio/accel/../ring_sw.h:223: warning: 'struct iio_ring_access_funcs' declared inside parameter list
linux-next-20100728/drivers/staging/iio/accel/../ring_sw.h:223: warning: its scope is only this definition or declaration, which is probably not what you want


> Jonathan Cameron (3):
>   staging:iio: iio_sw_ring_helper_state - add dummy case for no buffer
>     builds.
>   staging:iio:lis3l02dq add a thresh_timestamp field to state for no
>     ring case
>   staging:iio:adis1350 add dummy ring functions for no ring build case
> 
>  drivers/staging/iio/accel/lis3l02dq.h      |    2 ++
>  drivers/staging/iio/accel/lis3l02dq_core.c |   14 +++++++-------
>  drivers/staging/iio/imu/adis16350.h        |    8 ++++++++
>  drivers/staging/iio/ring_sw.h              |    3 +++
>  4 files changed, 20 insertions(+), 7 deletions(-)
> 


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
