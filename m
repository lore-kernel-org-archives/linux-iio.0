Return-Path: <martink@posteo.de>
Subject: Re: [PATCH] iio: mma8452: add support for oversampling ratio
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1461586105-12919-1-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <5729E5E2.5040705@posteo.de>
Date: Wed, 4 May 2016 14:06:58 +0200
MIME-Version: 1.0
In-Reply-To: <1461586105-12919-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=iso-8859-15
List-ID: <linux-iio@vger.kernel.org>

Am 2016-04-25 um 14:08 schrieb Martin Kepplinger:
> This adds the following sysfs files according to the iio ABI:
> 
> -rw-r--r--    4096 in_accel_oversampling_ratio
> -r--r--r--    4096 in_accel_oversampling_ratio_available
> 
> Internally, the device knows about 4 different power modes that differ
> in oversampling ratio (and power consumption). We just show the user
> what oversampling ratio(s) is/are available, depending on the current
> frequency.
> 
> The referenced table in the datasheets makes it easier to understand.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
> ---
> This is meant to get merged for v4.8 to have time for review and possibly
> testing by others.
> 
> thanks,
>                        martin
> 
> 
>  drivers/iio/accel/mma8452.c | 185 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 160 insertions(+), 25 deletions(-)
> 

In case this has already been forgotten about, I'd be happy about
reviews. Powersaving is always nice to have after all.

thanks
                         martin
