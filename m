Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44596 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbcJANrQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Oct 2016 09:47:16 -0400
Subject: Re: [PATCH v3 1/5] include: linux: iio: add IIO_ATTR_{RO, WO, RW} and
 IIO_DEVICE_ATTR_{RO, WO, RW} macros
To: Brian Masney <masneyb@onstation.org>
References: <20160926075935.GA25938@kroah.com>
 <1474935620-13151-1-git-send-email-masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6f274697-3091-85c2-a118-f50c9d4cd560@kernel.org>
Date: Sat, 1 Oct 2016 14:47:13 +0100
MIME-Version: 1.0
In-Reply-To: <1474935620-13151-1-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/09/16 01:20, Brian Masney wrote:
> Add new macros: IIO_ATTR_RO, IIO_ATTR_WO, IIO_ATTR_RW,
> IIO_DEVICE_ATTR_RO, IIO_DEVICE_ATTR_WO and IIO_DEVICE_ATTR_RW to reduce
> the amount of boiler plate code that is needed for creating new
> attributes. This mimics the *_RO, *_WO, and *_RW macros that are found
> in include/linux/device.h and include/linux/sysfs.h.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Would have been good if you'd picked up Greg's Ack and added it here.

Anyhow, can't say I can summon much enthusiasm for this patch.
To my mind the careful matching of names it requires is all a bit
backwards.

Ah well, there is plenty of precedence and in the long run the intent
is to get rid of pretty much all the custom attrs in drivers (as they
can't easily be used by in kernel consumers).

I'll take it but I don't particularly want to see lots of patches
manically converting drivers over to this.  It's absolutely fine
if (like you are!) they come as part of a series working on a driver
more generally.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> This is the same version of this patch that I sent out on Sunday. I am
> resending the patch set since my the second patch in that series would
> not apply cleanly to iio.git/testing.
> 
>  include/linux/iio/sysfs.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
> index 9cd8f74..ce9426c 100644
> --- a/include/linux/iio/sysfs.h
> +++ b/include/linux/iio/sysfs.h
> @@ -55,10 +55,34 @@ struct iio_const_attr {
>  	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
>  	  .address = _addr }
>  
> +#define IIO_ATTR_RO(_name, _addr)       \
> +	{ .dev_attr = __ATTR_RO(_name), \
> +	  .address = _addr }
> +
> +#define IIO_ATTR_WO(_name, _addr)       \
> +	{ .dev_attr = __ATTR_WO(_name), \
> +	  .address = _addr }
> +
> +#define IIO_ATTR_RW(_name, _addr)       \
> +	{ .dev_attr = __ATTR_RW(_name), \
> +	  .address = _addr }
> +
>  #define IIO_DEVICE_ATTR(_name, _mode, _show, _store, _addr)	\
>  	struct iio_dev_attr iio_dev_attr_##_name		\
>  	= IIO_ATTR(_name, _mode, _show, _store, _addr)
>  
> +#define IIO_DEVICE_ATTR_RO(_name, _addr)                       \
> +	struct iio_dev_attr iio_dev_attr_##_name                \
> +	= IIO_ATTR_RO(_name, _addr)
> +
> +#define IIO_DEVICE_ATTR_WO(_name, _addr)                       \
> +	struct iio_dev_attr iio_dev_attr_##_name                \
> +	= IIO_ATTR_WO(_name, _addr)
> +
> +#define IIO_DEVICE_ATTR_RW(_name, _addr)                                   \
> +	struct iio_dev_attr iio_dev_attr_##_name                            \
> +	= IIO_ATTR_RW(_name, _addr)
> +
>  #define IIO_DEVICE_ATTR_NAMED(_vname, _name, _mode, _show, _store, _addr) \
>  	struct iio_dev_attr iio_dev_attr_##_vname			\
>  	= IIO_ATTR(_name, _mode, _show, _store, _addr)
> 

