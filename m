Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F2BC43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 18:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA9521841
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 18:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550687495;
	bh=VNZ4Z1Ktj7YoCNLfO05RpEyZdcPIDz3Ph5T1OZeiChU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FUzjQ5RzghimUQKDLVG8JrdJ2kUeSflJsviOj2IGLeNx/wEx0JtNallc8DM6MGcs+
	 HERyA5LDlOwIef5639LdUG+vZBBLM10ePDo2tZ4wdawhtvuik0oPWqMDlkNG3RmqR1
	 vUTbqm4zh1bDL9jBaeCx00zPG7yxmPZifarQ9NYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfBTSbf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:31:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfBTSbf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 13:31:35 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 629BD2146E;
        Wed, 20 Feb 2019 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550687493;
        bh=VNZ4Z1Ktj7YoCNLfO05RpEyZdcPIDz3Ph5T1OZeiChU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vhe7uL/+9hNBPGPE20SEGelE5GmYMtDAVcNFTXJj7qPsR9oKkNANojUnEuPoKkPCf
         lvNaCSYh1sxEVu1LWY3raEke5Xw+xn533z25ME+3xEo0RPceVDssPJzd23AOCcbTGH
         /pAbGjbQQSxIXgCH6WH+snheDST/LVnfMUWsxwJk=
Date:   Wed, 20 Feb 2019 18:31:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2] iio: Allow to read mount matrix from ACPI
Message-ID: <20190220183128.4ff6f950@archlinux>
In-Reply-To: <20190220175441.31455-1-andriy.shevchenko@linux.intel.com>
References: <20190220175441.31455-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 20 Feb 2019 20:54:41 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Currently mount matrix is allowed in Device Tree, though there is
> no technical issue to extend it to support ACPI.
> 
> Convert the function to use device_property_read_string_array() and
> thus allow to read mount matrix from ACPI if available.
> 
> Example of use in _DSD method:
> 
>   Name (_DSD, Package ()
>   {
>      ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>      Package ()
>      {
>         Package () { "mount-matrix", Package() {
>                 "1", "0",     "0",
>                 "0", "0.866", "0.5",
>                 "0", "-0.5",  "0.866",
>         } },
>      }
>   })
> 
> At the same time drop the "of" prefix from its name and
> convert current users.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
You got a stray white space. I'll fix up.

Would like this to sit for a few days though before I take it.
We have missed this merge window anyway so no rush.

Jonathan


> ---
> 
> - added _DSD example
> - fixed indentation
> 
>  drivers/iio/accel/kxsd9.c                  |  4 +-
>  drivers/iio/gyro/mpu3050-core.c            |  3 +-
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  4 +-
>  drivers/iio/industrialio-core.c            | 46 +++++++++-------------
>  drivers/iio/magnetometer/ak8974.c          |  5 +--
>  drivers/iio/magnetometer/ak8975.c          |  5 +--
>  include/linux/iio/iio.h                    |  4 +-
>  7 files changed, 28 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 0c0df4fce420..70c60db62247 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -420,9 +420,7 @@ int kxsd9_common_probe(struct device *dev,
>  	indio_dev->available_scan_masks = kxsd9_scan_masks;
>  
>  	/* Read the mounting matrix, if present */
> -	ret = of_iio_read_mount_matrix(dev,
> -				       "mount-matrix",
> -				       &st->orientation);
> +	ret = iio_read_mount_matrix(dev, "mount-matrix", &st->orientation);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 77fac81a3adc..8200e48f561b 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -1149,8 +1149,7 @@ int mpu3050_common_probe(struct device *dev,
>  	mpu3050->divisor = 99;
>  
>  	/* Read the mounting matrix, if present */
> -	ret = of_iio_read_mount_matrix(dev, "mount-matrix",
> -				       &mpu3050->orientation);
> +	ret = iio_read_mount_matrix(dev, "mount-matrix", &mpu3050->orientation);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 1e428c196a82..533d1f8321ac 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -990,8 +990,8 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  
>  	pdata = dev_get_platdata(dev);
>  	if (!pdata) {
> -		result = of_iio_read_mount_matrix(dev, "mount-matrix",
> -						  &st->orientation);
> +		result = iio_read_mount_matrix(dev, "mount-matrix",
> +					       &st->orientation);
>  		if (result) {
>  			dev_err(dev, "Failed to retrieve mounting matrix %d\n",
>  				result);
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4f5cd9f60870..3baede140d69 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -19,6 +19,7 @@
>  #include <linux/device.h>
>  #include <linux/fs.h>
>  #include <linux/poll.h>
> +#include <linux/property.h>
>  #include <linux/sched.h>
>  #include <linux/wait.h>
>  #include <linux/cdev.h>
> @@ -525,8 +526,8 @@ ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
>  EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
>  
>  /**
> - * of_iio_read_mount_matrix() - retrieve iio device mounting matrix from
> - *                              device-tree "mount-matrix" property
> + * iio_read_mount_matrix() - retrieve iio device mounting matrix from
> + *                           device "mount-matrix" property
>   * @dev:	device the mounting matrix property is assigned to
>   * @propname:	device specific mounting matrix property name
>   * @matrix:	where to store retrieved matrix
> @@ -536,40 +537,29 @@ EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
>   *
>   * Return: 0 if success, or a negative error code on failure.
>   */
> -#ifdef CONFIG_OF
> -int of_iio_read_mount_matrix(const struct device *dev,
> -			     const char *propname,
> -			     struct iio_mount_matrix *matrix)
> +int iio_read_mount_matrix(struct device *dev, const char *propname,
> +			  struct iio_mount_matrix *matrix)
>  {
> -	if (dev->of_node) {
> -		int err = of_property_read_string_array(dev->of_node,
> -				propname, matrix->rotation,
> -				ARRAY_SIZE(iio_mount_idmatrix.rotation));
> +	size_t len = ARRAY_SIZE(iio_mount_idmatrix.rotation); 
Space at end of line above.

> +	int err;
>  
> -		if (err == ARRAY_SIZE(iio_mount_idmatrix.rotation))
> -			return 0;
> +	err = device_property_read_string_array(dev, propname,
> +						matrix->rotation, len);
> +	if (err == len)
> +		return 0;
>  
> -		if (err >= 0)
> -			/* Invalid number of matrix entries. */
> -			return -EINVAL;
> +	if (err >= 0)
> +		/* Invalid number of matrix entries. */
> +		return -EINVAL;
>  
> -		if (err != -EINVAL)
> -			/* Invalid matrix declaration format. */
> -			return err;
> -	}
> +	if (err != -EINVAL)
> +		/* Invalid matrix declaration format. */
> +		return err;
>  
>  	/* Matrix was not declared at all: fallback to identity. */
>  	return iio_setup_mount_idmatrix(dev, matrix);
>  }
> -#else
> -int of_iio_read_mount_matrix(const struct device *dev,
> -			     const char *propname,
> -			     struct iio_mount_matrix *matrix)
> -{
> -	return iio_setup_mount_idmatrix(dev, matrix);
> -}
> -#endif
> -EXPORT_SYMBOL(of_iio_read_mount_matrix);
> +EXPORT_SYMBOL(iio_read_mount_matrix);
>  
>  static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
>  				  int size, const int *vals)
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index 93be1f4c0f27..f4d0a6c0fde7 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -733,9 +733,8 @@ static int ak8974_probe(struct i2c_client *i2c,
>  	ak8974->i2c = i2c;
>  	mutex_init(&ak8974->lock);
>  
> -	ret = of_iio_read_mount_matrix(&i2c->dev,
> -				       "mount-matrix",
> -				       &ak8974->orientation);
> +	ret = iio_read_mount_matrix(&i2c->dev, "mount-matrix",
> +				    &ak8974->orientation);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index d430b80808ef..db7214ac514c 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -911,9 +911,8 @@ static int ak8975_probe(struct i2c_client *client,
>  	data->eoc_irq = 0;
>  
>  	if (!pdata) {
> -		err = of_iio_read_mount_matrix(&client->dev,
> -					       "mount-matrix",
> -					       &data->orientation);
> +		err = iio_read_mount_matrix(&client->dev, "mount-matrix",
> +					    &data->orientation);
>  		if (err)
>  			return err;
>  	} else
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index a74cb177dc6f..bb10c1bee301 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -130,8 +130,8 @@ struct iio_mount_matrix {
>  
>  ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
>  			      const struct iio_chan_spec *chan, char *buf);
> -int of_iio_read_mount_matrix(const struct device *dev, const char *propname,
> -			     struct iio_mount_matrix *matrix);
> +int iio_read_mount_matrix(struct device *dev, const char *propname,
> +			  struct iio_mount_matrix *matrix);
>  
>  typedef const struct iio_mount_matrix *
>  	(iio_get_mount_matrix_t)(const struct iio_dev *indio_dev,

