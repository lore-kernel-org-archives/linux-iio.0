Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795822194;
	b=w877nUOY82Db8f61BrBxLTzmS+gKWVy2QhB4wW7Vhs39VInRoYdtYQmPy1LS0r/FIFF7
	 ydwYgb5olNk0PAdt5NwDd6Y836DVbij+X2w3znYJXuTQg4RPReerOaBR2of4Jd3ZRpOBr
	 oIe3qNLZVKrBGtjznSXPrgY1deOM1BmTFdQcFvp/mFzPJmrE65FDTj9YVmTPvwbZaMZh0
	 t5R+ylRMtFndA6jNwBYyv+ExtAuoHNXnESnI3ue95TZSt2wJNiV8MIIvFt62tIGW1gce7
	 peQVV5sygz0lz1MK8ruSbAj4MCv/2yDJOffrk/GsVH8Gjib3pxjC4b4aDlLxFN57/Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795822194;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=URZrRWfIDRm/L8OsjNhME2KLtAFnJsvN29jPq76Um1U=;
	b=fwZ07wpE9Y6W5lu1dtPk9jy2ecpBCKJ4idLdYO/rbMufvLR5r7fgEzYHtI0L/ziDsu/Q
	 8QHEtvfaHFkrDRQJ6oqwxRayVPbagYfusbqMVXFKm5JMIQH+2wX3BjOdt8f2suLgISzGs
	 2/G3R5Uv4kyD3/UyMwoPt7XOJkUceZCITw7XEknmjOzUOHzh5RVRo19piyIN7+vv646Z3
	 9DS0Jaw6+2VXI4MduE19N+fVPJnMAt3WyQmRWjbqt1dBJW0IuL6z/uos7lzo3zGTNvVLP
	 GQPMFj4/HWhuiYa52OKFk0ntF4tzq7QB8JSUljdgoYeYd53hFtDscTiruRWOAvvuO7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JefxqNln;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19410606A329;
	Fri, 27 Nov 2026 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JefxqNln
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBA81F00893;
	Fri, 27 Nov 2026 23:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795822193;
	bh=URZrRWfIDRm/L8OsjNhME2KLtAFnJsvN29jPq76Um1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JefxqNlnRnDXlizpQhbz2J6CbkPYOoUNb4jHzXpC52YALTau9reqXb4K6ZNsF+G4z
	 HbKwTRdo3rUJDtirDuMx9EduIyYff6RxBvGuA2e9g9g/AZDWkdQw//3R9q2jYD9pP8
	 XI63g93G1GPA0rkl4aUzz3o5oWA+sgBBrAmcCHKCRYfBtynEQltvUsiqGNrPml2bSu
	 md2iFZaZDZDfUDQ48PCFRqbky/kFhq5Hw47IupwZr/hDgDVfYAdtk5DK2pawsYtcil
	 gELlIdTInFr0f/ysQlHHKBILVIhuG5CPtLDzn7AXQu3yrD9DvcbFM+MBOcwYJl0jic
	 FJI8YZDiZvWZg==
Date: Fri, 27 Nov 2026 23:29:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Joshua Crofts
 <crofts@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rupesh
 Majhi <zoone.rupert@gmail.com>
Subject: Re: [PATCH v3 1/1] iio: core: Split debugfs routines
Message-ID: <20261127232924.7fa62483@jic23-hlaptop>
In-Reply-To: <20261127113635.1691512-1-andriy.shevchenko@linux.intel.com>
References: <20261127113635.1691512-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Nov 2026 12:34:59 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Split debugfs routines into a separate file for easier maintenance.
> No functional changes intended.
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Reviewed-by: Joshua Crofts <crofts@kernel.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied,

Thanks,

Jonathan

> ---
>=20
> v3: fixed another portion of compilation errors (LKP, Joshua)
> v2: fixed compilation errors (LKP, Joshua)
>=20
> Cc: Rupesh Majhi <zoone.rupert@gmail.com>
> Rupesh, feel free to include this patch into your series as the first one.
>=20
> Fun fact: This patch was written with zero AI assistance.
>=20
>  drivers/iio/Makefile               |   1 +
>  drivers/iio/iio_core.h             |  14 +++
>  drivers/iio/industrialio-core.c    | 152 +-------------------------
>  drivers/iio/industrialio-debugfs.c | 165 +++++++++++++++++++++++++++++
>  4 files changed, 182 insertions(+), 150 deletions(-)
>  create mode 100644 drivers/iio/industrialio-debugfs.c
>=20
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 8a897b6729d2..5fd81b20da22 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -8,6 +8,7 @@ industrialio-y :=3D industrialio-core.o industrialio-even=
t.o inkern.o
>  industrialio-$(CONFIG_IIO_BUFFER) +=3D industrialio-buffer.o
>  industrialio-$(CONFIG_IIO_TRIGGER) +=3D industrialio-trigger.o
>  industrialio-$(CONFIG_ACPI) +=3D industrialio-acpi.o
> +industrialio-$(CONFIG_DEBUG_FS) +=3D industrialio-debugfs.o
> =20
>  obj-$(CONFIG_IIO_CONFIGFS) +=3D industrialio-configfs.o
>  obj-$(CONFIG_IIO_GTS_HELPER) +=3D industrialio-gts-helper.o
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 59fa1bd9924b..be0d7d984284 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -16,6 +16,20 @@ struct iio_buffer;
>  struct iio_chan_spec;
>  struct iio_dev;
> =20
> +#if defined(CONFIG_DEBUG_FS)
> +void iio_debugfs_create(void);
> +void iio_debugfs_remove(void);
> +
> +void iio_device_unregister_debugfs(struct iio_dev *indio_dev);
> +void iio_device_register_debugfs(struct iio_dev *indio_dev);
> +#else
> +static inline void iio_debugfs_create(void) {}
> +static inline void iio_debugfs_remove(void) {}
> +
> +static inline void iio_device_register_debugfs(struct iio_dev *indio_dev=
) {}
> +static inline void iio_device_unregister_debugfs(struct iio_dev *indio_d=
ev) {}
> +#endif /* CONFIG_DEBUG_FS */
> +
>  extern const struct device_type iio_device_type;
> =20
>  struct iio_dev_buffer_pair {
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-c=
ore.c
> index 8c4a4e765834..5f9d6e852286 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -14,7 +14,6 @@
>  #include <linux/anon_inodes.h>
>  #include <linux/cdev.h>
>  #include <linux/cleanup.h>
> -#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
> @@ -54,8 +53,6 @@ const struct bus_type iio_bus_type =3D {
>  };
>  EXPORT_SYMBOL(iio_bus_type);
> =20
> -static struct dentry *iio_debugfs_dentry;
> -
>  static const char * const iio_direction[] =3D {
>  	[0] =3D "in",
>  	[1] =3D "out",
> @@ -293,20 +290,6 @@ bool iio_buffer_enabled(struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL_GPL(iio_buffer_enabled);
> =20
> -#if defined(CONFIG_DEBUG_FS)
> -/*
> - * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
> - * iio_get_debugfs_dentry() to make it inline if CONFIG_DEBUG_FS is unde=
fined
> - */
> -struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
> -{
> -	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> -
> -	return iio_dev_opaque->debugfs_dentry;
> -}
> -EXPORT_SYMBOL_GPL(iio_get_debugfs_dentry);
> -#endif
> -
>  /**
>   * iio_find_channel_from_si() - get channel from its scan index
>   * @indio_dev:		device
> @@ -427,7 +410,7 @@ static int __init iio_init(void)
>  		goto error_unregister_bus_type;
>  	}
> =20
> -	iio_debugfs_dentry =3D debugfs_create_dir("iio", NULL);
> +	iio_debugfs_create();
> =20
>  	return 0;
> =20
> @@ -442,140 +425,9 @@ static void __exit iio_exit(void)
>  	if (iio_devt)
>  		unregister_chrdev_region(iio_devt, IIO_DEV_MAX);
>  	bus_unregister(&iio_bus_type);
> -	debugfs_remove(iio_debugfs_dentry);
> +	iio_debugfs_remove();
>  }
> =20
> -#if defined(CONFIG_DEBUG_FS)
> -static ssize_t iio_debugfs_read_reg(struct file *file, char __user *user=
buf,
> -			      size_t count, loff_t *ppos)
> -{
> -	struct iio_dev *indio_dev =3D file->private_data;
> -	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> -	unsigned int val =3D 0;
> -	u64 val64 =3D 0;
> -	int ret;
> -
> -	if (*ppos > 0)
> -		return simple_read_from_buffer(userbuf, count, ppos,
> -					       iio_dev_opaque->read_buf,
> -					       iio_dev_opaque->read_buf_len);
> -
> -	if (indio_dev->info->debugfs_reg64_access) {
> -		ret =3D indio_dev->info->debugfs_reg64_access(indio_dev,
> -							    iio_dev_opaque->cached_reg_addr,
> -							    0, &val64);
> -	} else {
> -		ret =3D indio_dev->info->debugfs_reg_access(indio_dev,
> -							  iio_dev_opaque->cached_reg_addr,
> -							  0, &val);
> -		val64 =3D val;
> -	}
> -
> -	if (ret) {
> -		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
> -		return ret;
> -	}
> -
> -	iio_dev_opaque->read_buf_len =3D snprintf(iio_dev_opaque->read_buf,
> -						sizeof(iio_dev_opaque->read_buf),
> -						"0x%llX\n", val64);
> -
> -	return simple_read_from_buffer(userbuf, count, ppos,
> -				       iio_dev_opaque->read_buf,
> -				       iio_dev_opaque->read_buf_len);
> -}
> -
> -static ssize_t iio_debugfs_write_reg(struct file *file,
> -		     const char __user *userbuf, size_t count, loff_t *ppos)
> -{
> -	struct iio_dev *indio_dev =3D file->private_data;
> -	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> -	unsigned int reg;
> -	char buf[80];
> -	u64 val64;
> -	int ret;
> -
> -	if (*ppos !=3D 0 || count >=3D sizeof(buf))
> -		return -EINVAL;
> -
> -	ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> -				     count);
> -	if (ret < 0)
> -		return ret;
> -
> -	buf[ret] =3D '\0';
> -
> -	ret =3D sscanf(buf, "%i %lli", &reg, &val64);
> -
> -	switch (ret) {
> -	case 1:
> -		iio_dev_opaque->cached_reg_addr =3D reg;
> -		break;
> -	case 2:
> -		iio_dev_opaque->cached_reg_addr =3D reg;
> -		if (indio_dev->info->debugfs_reg64_access)
> -			ret =3D indio_dev->info->debugfs_reg64_access(indio_dev, reg,
> -								    val64, NULL);
> -		else
> -			ret =3D indio_dev->info->debugfs_reg_access(indio_dev, reg,
> -								  val64, NULL);
> -		if (ret) {
> -			dev_err(indio_dev->dev.parent, "%s: write failed\n",
> -				__func__);
> -			return ret;
> -		}
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -
> -	return count;
> -}
> -
> -static const struct file_operations iio_debugfs_reg_fops =3D {
> -	.open =3D simple_open,
> -	.read =3D iio_debugfs_read_reg,
> -	.write =3D iio_debugfs_write_reg,
> -};
> -
> -static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
> -{
> -	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> -
> -	debugfs_remove_recursive(iio_dev_opaque->debugfs_dentry);
> -}
> -
> -static void iio_device_register_debugfs(struct iio_dev *indio_dev)
> -{
> -	struct iio_dev_opaque *iio_dev_opaque;
> -
> -	if (!indio_dev->info->debugfs_reg_access &&
> -	    !indio_dev->info->debugfs_reg64_access)
> -		return;
> -
> -	if (!iio_debugfs_dentry)
> -		return;
> -
> -	iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> -
> -	iio_dev_opaque->debugfs_dentry =3D
> -		debugfs_create_dir(dev_name(&indio_dev->dev),
> -				   iio_debugfs_dentry);
> -
> -	debugfs_create_file("direct_reg_access", 0644,
> -			    iio_dev_opaque->debugfs_dentry, indio_dev,
> -			    &iio_debugfs_reg_fops);
> -}
> -#else
> -static void iio_device_register_debugfs(struct iio_dev *indio_dev)
> -{
> -}
> -
> -static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
> -{
> -}
> -#endif /* CONFIG_DEBUG_FS */
> -
>  static ssize_t iio_read_channel_ext_info(struct device *dev,
>  				     struct device_attribute *attr,
>  				     char *buf)
> diff --git a/drivers/iio/industrialio-debugfs.c b/drivers/iio/industriali=
o-debugfs.c
> new file mode 100644
> index 000000000000..a8a3c7a3e85d
> --- /dev/null
> +++ b/drivers/iio/industrialio-debugfs.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Industrial I/O debugfs bits
> + */
> +
> +#include <linux/cdev.h>
> +#include <linux/debugfs.h>
> +#include <linux/dev_printk.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
> +#include <linux/fs.h>
> +#include <linux/init.h>
> +#include <linux/sprintf.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/iio-opaque.h>
> +
> +#include "iio_core.h"
> +
> +static struct dentry *iio_debugfs_dentry;
> +
> +/*
> + * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
> + * iio_get_debugfs_dentry() to make it inline if CONFIG_DEBUG_FS is unde=
fined
> + */
> +struct dentry *iio_get_debugfs_dentry(struct iio_dev *indio_dev)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> +
> +	return iio_dev_opaque->debugfs_dentry;
> +}
> +EXPORT_SYMBOL_GPL(iio_get_debugfs_dentry);
> +
> +void __init iio_debugfs_create(void)
> +{
> +	iio_debugfs_dentry =3D debugfs_create_dir("iio", NULL);
> +}
> +
> +void __exit iio_debugfs_remove(void)
> +{
> +	debugfs_remove(iio_debugfs_dentry);
> +}
> +
> +static ssize_t iio_debugfs_read_reg(struct file *file, char __user *user=
buf,
> +			      size_t count, loff_t *ppos)
> +{
> +	struct iio_dev *indio_dev =3D file->private_data;
> +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> +	unsigned int val =3D 0;
> +	u64 val64 =3D 0;
> +	int ret;
> +
> +	if (*ppos > 0)
> +		return simple_read_from_buffer(userbuf, count, ppos,
> +					       iio_dev_opaque->read_buf,
> +					       iio_dev_opaque->read_buf_len);
> +
> +	if (indio_dev->info->debugfs_reg64_access) {
> +		ret =3D indio_dev->info->debugfs_reg64_access(indio_dev,
> +							    iio_dev_opaque->cached_reg_addr,
> +							    0, &val64);
> +	} else {
> +		ret =3D indio_dev->info->debugfs_reg_access(indio_dev,
> +							  iio_dev_opaque->cached_reg_addr,
> +							  0, &val);
> +		val64 =3D val;
> +	}
> +
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent, "%s: read failed\n", __func__);
> +		return ret;
> +	}
> +
> +	iio_dev_opaque->read_buf_len =3D snprintf(iio_dev_opaque->read_buf,
> +						sizeof(iio_dev_opaque->read_buf),
> +						"0x%llX\n", val64);
> +
> +	return simple_read_from_buffer(userbuf, count, ppos,
> +				       iio_dev_opaque->read_buf,
> +				       iio_dev_opaque->read_buf_len);
> +}
> +
> +static ssize_t iio_debugfs_write_reg(struct file *file,
> +		     const char __user *userbuf, size_t count, loff_t *ppos)
> +{
> +	struct iio_dev *indio_dev =3D file->private_data;
> +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> +	unsigned int reg;
> +	char buf[80];
> +	u64 val64;
> +	int ret;
> +
> +	if (*ppos !=3D 0 || count >=3D sizeof(buf))
> +		return -EINVAL;
> +
> +	ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> +				     count);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf[ret] =3D '\0';
> +
> +	ret =3D sscanf(buf, "%i %lli", &reg, &val64);
> +
> +	switch (ret) {
> +	case 1:
> +		iio_dev_opaque->cached_reg_addr =3D reg;
> +		break;
> +	case 2:
> +		iio_dev_opaque->cached_reg_addr =3D reg;
> +		if (indio_dev->info->debugfs_reg64_access)
> +			ret =3D indio_dev->info->debugfs_reg64_access(indio_dev, reg,
> +								    val64, NULL);
> +		else
> +			ret =3D indio_dev->info->debugfs_reg_access(indio_dev, reg,
> +								  val64, NULL);
> +		if (ret) {
> +			dev_err(indio_dev->dev.parent, "%s: write failed\n",
> +				__func__);
> +			return ret;
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return count;
> +}
> +
> +static const struct file_operations iio_debugfs_reg_fops =3D {
> +	.open =3D simple_open,
> +	.read =3D iio_debugfs_read_reg,
> +	.write =3D iio_debugfs_write_reg,
> +};
> +
> +void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> +
> +	debugfs_remove_recursive(iio_dev_opaque->debugfs_dentry);
> +}
> +
> +void iio_device_register_debugfs(struct iio_dev *indio_dev)
> +{
> +	struct iio_dev_opaque *iio_dev_opaque;
> +
> +	if (!indio_dev->info->debugfs_reg_access &&
> +	    !indio_dev->info->debugfs_reg64_access)
> +		return;
> +
> +	if (!iio_debugfs_dentry)
> +		return;
> +
> +	iio_dev_opaque =3D to_iio_dev_opaque(indio_dev);
> +
> +	iio_dev_opaque->debugfs_dentry =3D
> +		debugfs_create_dir(dev_name(&indio_dev->dev),
> +				   iio_debugfs_dentry);
> +
> +	debugfs_create_file("direct_reg_access", 0644,
> +			    iio_dev_opaque->debugfs_dentry, indio_dev,
> +			    &iio_debugfs_reg_fops);
> +}

