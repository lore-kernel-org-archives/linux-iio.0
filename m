Return-Path: <gregkh@linuxfoundation.org>
Date: Sun, 25 Sep 2016 19:58:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 1/2] include: linux: iio: add IIO_DEVICE_ATTR_{RO, WO,
 RW} macros
Message-ID: <20160925175852.GB13088@kroah.com>
References: <1474824599-30205-1-git-send-email-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474824599-30205-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Sep 25, 2016 at 01:29:58PM -0400, Brian Masney wrote:
> Add three new macros: IIO_DEVICE_ATTR_RO, IIO_DEVICE_ATTR_WO and
> IIO_DEVICE_ATTR_RW to reduce the amount of boiler plate code that
> is needed for creating new attributes. This mimics the *_RO, *_WO,
> and *_RW macros that are found in include/linux/device.h and
> include/linux/sysfs.h.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  include/linux/iio/sysfs.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
> index 9cd8f74..f7c6431 100644
> --- a/include/linux/iio/sysfs.h
> +++ b/include/linux/iio/sysfs.h
> @@ -59,6 +59,19 @@ struct iio_const_attr {
>  	struct iio_dev_attr iio_dev_attr_##_name		\
>  	= IIO_ATTR(_name, _mode, _show, _store, _addr)
>  
> +#define IIO_DEVICE_ATTR_RO(_name, _addr)			\
> +	struct iio_dev_attr iio_dev_attr_##_name		\
> +	= IIO_ATTR(_name, S_IRUGO, _name##_show, NULL, _addr)
> +
> +#define IIO_DEVICE_ATTR_WO(_name, _addr)			\
> +	struct iio_dev_attr iio_dev_attr_##_name		\
> +	= IIO_ATTR(_name, S_IWUSR, NULL, _name##_store, _addr)
> +
> +#define IIO_DEVICE_ATTR_RW(_name, _addr)			            \
> +	struct iio_dev_attr iio_dev_attr_##_name		            \
> +	= IIO_ATTR(_name, (S_IWUSR | S_IRUGO), _name##_show, _name##_store, \
> +		   _addr)
> +
>  #define IIO_DEVICE_ATTR_NAMED(_vname, _name, _mode, _show, _store, _addr) \
>  	struct iio_dev_attr iio_dev_attr_##_vname			\
>  	= IIO_ATTR(_name, _mode, _show, _store, _addr)

Why not make IIO_ATTR_RO, and IIO_ATTR_RW and use DEVICE_ATTR_RO and
DEVICE_ATTR_RW in it, making it a bit more obvious that you got the
settings correct?

Ideally you wouldn't have to manually set a S_* value at all here...

thanks,

greg k-h
