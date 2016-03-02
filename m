Return-Path: <lars@metafoo.de>
Subject: Re: [RFC PATCH 1/2] iio: core: implement
 iio_{claim|release}_direct_mode()
To: Alison Schofield <amsfield22@gmail.com>, outreachy-kernel@googlegroups.com
References: <cover.1456794364.git.amsfield22@gmail.com>
 <9a2950402af7277a4928a10eade4cc8b1187d8c8.1456794364.git.amsfield22@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 devel@driverdev.osuosl.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56D6EA82.8090601@metafoo.de>
Date: Wed, 2 Mar 2016 14:28:34 +0100
MIME-Version: 1.0
In-Reply-To: <9a2950402af7277a4928a10eade4cc8b1187d8c8.1456794364.git.amsfield22@gmail.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 03/01/2016 08:02 PM, Alison Schofield wrote:
> It is often the case that the driver wants to be sure a device stays
> in direct mode while it is executing a task or series of tasks.  To
> accomplish this today, the driver performs this sequence: 1) take the
> device state lock, 2)verify it is not in a buffered mode, 3) execute
> some tasks, and 4) release that lock.
> 
> This patch introduces a pair of helper functions that simplify these
> steps and make it more semantically expressive.
> 
> iio_claim_direct_mode()
>         If the device is not in any buffered mode it is guaranteed
>         to stay that way until iio_release_direct_mode() is called.
> 
> iio_release_direct_mode()
>         Release the claim. Device is no longer guaranteed to stay
>         in direct mode.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>

Looks basically good.

> ---
>  drivers/iio/industrialio-core.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h         |  2 ++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 70cb7eb..f6f0c89 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -25,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/anon_inodes.h>
>  #include <linux/debugfs.h>
> +#include <linux/mutex.h>
>  #include <linux/iio/iio.h>
>  #include "iio_core.h"
>  #include "iio_core_trigger.h"
> @@ -1375,6 +1376,44 @@ void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL_GPL(devm_iio_device_unregister);
>  
> +/**
> + * iio_claim_direct_mode - Keep device in direct mode
> + * @indio_dev:	the iio_dev associated with the device
> + *
> + * If the device is in direct mode it is guaranteed to
> + * stay that way until iio_release_direct_mode() is called.
> + *
> + * Use with iio_release_direct_mode()
> + *
> + * Returns: 0 on success, -EINVAL on failure
> + */
> +int iio_claim_direct_mode(struct iio_dev *indio_dev)

To be consistent with the reset of the API I'd use the iio_device_... prefix
here, same for the release function.

> +{
> +	mutex_lock(&indio_dev->mlock);
> +
> +	if (iio_buffer_enabled(indio_dev)) {
> +		mutex_unlock(&indio_dev->mlock);
> +		return -EINVAL;

-EINVAL doesn't make much sense here, -EBUSY is better.

> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_claim_direct_mode);
> 
