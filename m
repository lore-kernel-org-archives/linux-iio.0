Return-Path: <jic23@kernel.org>
Message-ID: <50FBDDAC.9050701@kernel.org>
Date: Sun, 20 Jan 2013 12:06:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] iio:kxsd9 basic driver move out of staging
References: <1357485017-27916-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1357485017-27916-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/06/2013 03:10 PM, Jonathan Cameron wrote:
> This is a simple driver I wrote as a proof of concept a long
> time ago.  Whilst it only supports the basics, it might as
> well move out of staging as there is nothing particularly
> interesting or controversial in it!
> 
> The first patch does a bit of trivial cleanup and avoids
> a theoretical race condition.
> 
These have sat on the list on enough.  I guess everyone
who cares is happy ;)

Added to togreg branch of iio.git

> Jonathan Cameron (2):
>   staging:iio:accel:kxsd9
>   iio:accel:kxsd9 move out of staging
> 
>  drivers/iio/accel/Kconfig               |  7 +++++++
>  drivers/iio/accel/Makefile              |  1 +
>  drivers/{staging => }/iio/accel/kxsd9.c | 10 +++++-----
>  drivers/staging/iio/accel/Kconfig       |  7 -------
>  drivers/staging/iio/accel/Makefile      |  2 --
>  5 files changed, 13 insertions(+), 14 deletions(-)
>  rename drivers/{staging => }/iio/accel/kxsd9.c (99%)
> 
