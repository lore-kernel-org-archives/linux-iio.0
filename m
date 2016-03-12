Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43740 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbcCLLSY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2016 06:18:24 -0500
Subject: Re: [RFC PATCH v2 1/2] iio: core: implement
 iio_device_{claim|release}_direct_mode()
To: Alison Schofield <amsfield22@gmail.com>,
	outreachy-kernel@googlegroups.com
References: <cover.1457549841.git.amsfield22@gmail.com>
 <a9ed1d7bec5e0692bfd6b0e897d408fc265d4be8.1457549841.git.amsfield22@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E3FAFE.2040108@kernel.org>
Date: Sat, 12 Mar 2016 11:18:22 +0000
MIME-Version: 1.0
In-Reply-To: <a9ed1d7bec5e0692bfd6b0e897d408fc265d4be8.1457549841.git.amsfield22@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/16 19:30, Alison Schofield wrote:
> It is often the case that the driver wants to be sure a device stays
> in direct mode while it is executing a task or series of tasks.  To
> accomplish this today, the driver performs this sequence: 1) take the
> device state lock, 2) verify it is not in a buffered mode, 3) execute
> some tasks, and 4) release that lock.
> 
> This patch introduces a pair of helper functions that simplify these
> steps and make it more semantically expressive.
> 
> iio_device_claim_direct_mode()
>         If the device is not in any buffered mode it is guaranteed
>         to stay that way until iio_release_direct_mode() is called.
> 
> iio_device_release_direct_mode()
>         Release the claim. Device is no longer guaranteed to stay
>         in direct mode.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
I like change.  Nice and clean and should help reduce 'misuse' of this
lock by making it more focused in the long run.

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.
> ---
>  drivers/iio/industrialio-core.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h         |  2 ++
>  2 files changed, 41 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 70cb7eb..2e768bc 100644
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
> + * iio_device_claim_direct_mode - Keep device in direct mode
> + * @indio_dev:	the iio_dev associated with the device
> + *
> + * If the device is in direct mode it is guaranteed to stay
> + * that way until iio_device_release_direct_mode() is called.
> + *
> + * Use with iio_device_release_direct_mode()
> + *
> + * Returns: 0 on success, -EBUSY on failure
> + */
> +int iio_device_claim_direct_mode(struct iio_dev *indio_dev)
> +{
> +	mutex_lock(&indio_dev->mlock);
> +
> +	if (iio_buffer_enabled(indio_dev)) {
> +		mutex_unlock(&indio_dev->mlock);
> +		return -EBUSY;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_device_claim_direct_mode);
> +
> +/**
> + * iio_device_release_direct_mode - releases claim on direct mode
> + * @indio_dev:	the iio_dev associated with the device
> + *
> + * Release the claim. Device is no longer guaranteed to stay
> + * in direct mode.
> + *
> + * Use with iio_device_claim_direct_mode()
> + */
> +void iio_device_release_direct_mode(struct iio_dev *indio_dev)
> +{
> +	mutex_unlock(&indio_dev->mlock);
> +}
> +EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> +
>  subsys_initcall(iio_init);
>  module_exit(iio_exit);
>  
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index b2b1677..0b2773a 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -527,6 +527,8 @@ void iio_device_unregister(struct iio_dev *indio_dev);
>  int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev);
>  void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);
>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
> +int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
> +void iio_device_release_direct_mode(struct iio_dev *indio_dev);
>  
>  extern struct bus_type iio_bus_type;
>  
> 

