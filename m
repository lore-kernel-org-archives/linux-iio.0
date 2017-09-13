Return-Path: <SRS0=0YWM=AO=lip6.fr=julia.lawall@kernel.org>
Date: Wed, 13 Sep 2017 10:46:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Himanshi Jain <himshijain.hj@gmail.com>
cc: outreachy-kernel@googlegroups.com, lars@metafoo.de,
    Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
    pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
    devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
    nick.desaulniers@gmail.com, daniel.baluta@gmail.com
Subject: Re: [Outreachy kernel] [PATCH v2 0/2] Rewrite the IIO_DEVICE_ATTR_NAMED
 API to pass name as string.
In-Reply-To: <cover.1505291907.git.himshijain.hj@gmail.com>
Message-ID: <alpine.DEB.2.20.1709131046240.2850@hadrien>
References: <cover.1505291907.git.himshijain.hj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>



On Wed, 13 Sep 2017, Himanshi Jain wrote:

> This patchset is to rewrite the IIO_DEVICE_ATTR_NAMED API to pass name
> as string.

You need to indicate what has changed in the v2, either here or in the
individual patches.

julia


>
> Himanshi Jain (2):
>   include: linux: sysfs: Add __ATTR_NAMED macro
>   iio: Change to __ATTR_NAMED()
>
>  drivers/iio/adc/ad7793.c          | 2 +-
>  drivers/staging/iio/adc/ad7192.c  | 2 +-
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  include/linux/iio/sysfs.h         | 6 +++++-
>  include/linux/sysfs.h             | 7 +++++++
>  5 files changed, 16 insertions(+), 5 deletions(-)
>
> --
> 1.9.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/cover.1505291907.git.himshijain.hj%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
