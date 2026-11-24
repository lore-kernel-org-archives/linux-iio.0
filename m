Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795515426;
	b=wb8qLyocpMId8kYwyRm9Id6O+Z1LnSBt1fEm7sHfbm43LKlY0H7CoEJrnxNaCXe+t79m
	 cJTJbo/+Etr1I3xJg5g/s3v+BWOudENIeoqPEtnj15foVnqqD+J55V8OS4O1Dqml0WTVZ
	 eB4I4pc8Ze6cvID8xMwUm2qqpylpuH6jkfYEQ549bQq6QIRKJS8XTgQ6B20UpSZ3mWt2u
	 qdC2CoMHkcWFl+3IAM5Rxo9prm+hhAf2bjBwlqdDQ6ALDhzsLCyCBwY4KP/H7UzbDshTr
	 iS3+ZhkK7tNjuaE+3ySuzI3c2hxoL8NGEj/xnJhPNnBAJshzarRT/CErz76B8n56/ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795515426;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6o7whnWBHT6EEdD8MwgLN42DHzrsSNosf9fO0rBds7c=;
	b=cpeNQ7/Mx4VwLLOgMYmrVPeky3XpTcJ38uBoqpq810JbvoF2j5O/sOs5GO5GUOqQTS5G
	 lAlwb7esm1jbuz+LDhqzmC8ELvE+JEnPitIrgsGclSqItQxdKYBrbrB0D4vzGJd0NlJWF
	 SPIsWTTXxE5iRhH/AKCDSKTZ9CURbQA2wevKGhpCrKs7LzMkjZ3m5Wh7kIAXJniFBp2Sj
	 wF0dTMZ/k04EEMLqA54Ujuh9yM9AHng8wAZTura2/ngenk1KqaPf90mkaN87c0iNdayFB
	 wUBsoDY1udhKCUs5DyehZCU5QOhfBn5eIlu/j+AgT0X/L58poeFND40sFGsiIQGp9Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMXC5CMu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD4606A339;
	Tue, 24 Nov 2026 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMXC5CMu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47C61F000C6;
	Tue, 24 Nov 2026 10:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795515425;
	bh=6o7whnWBHT6EEdD8MwgLN42DHzrsSNosf9fO0rBds7c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GMXC5CMu0D2TQUbdSZ1+bEcnFSwPTvU2qxkBcEd2oVqiVWTKMRsNsOGFLwzhzchkg
	 ooQ5yVCxzN/QE6oMY+trSjxRORCssuqyKVN3dtGOwYSvPCOe2OQ9w37s+QUr2nuWpV
	 X4fufIyDqP3nrtiU2cUscKBGTlLNZ9HGUCR7WKzBmQrPwEKD30s+EcAOVTe6dK/CUE
	 qWYb4CVl9mKI7WeYZPCH8lO6uLIZlQ8HXSDpogurKxgN+iKyb3JsPJhco+o6W5JVPk
	 AE2+/rkouWtW2bXV711ie94TVdgmydNMV14SmJCu364YFlLlKAjnnqI0Z1ELmPImBB
	 w6Vu0j4MV4yjQ==
Message-ID: <09328c36-a32f-488b-a2c9-76fab784d259@kernel.org>
Date: Tue, 24 Nov 2026 11:17:01 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/1] iio: core: Split debugfs routines
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rupesh Majhi <zoone.rupert@gmail.com>
References: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24-Nov-26 10:44, Andy Shevchenko wrote:
> Split debugfs routines into a separate file for easier maintenance.
> No functional changes intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> Rupesh, feel free to include this patch into your series as the first one.
> 
> Fun fact: This patch was written with zero AI assistance.

:)

> 
>  drivers/iio/Makefile               |   1 +
>  drivers/iio/iio_core.h             |  14 +++
>  drivers/iio/industrialio-core.c    | 152 +-------------------------
>  drivers/iio/industrialio-debugfs.c | 165 +++++++++++++++++++++++++++++
>  4 files changed, 182 insertions(+), 150 deletions(-)
>  create mode 100644 drivers/iio/industrialio-debugfs.c
> 
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index 8a897b6729d2..5fd81b20da22 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -8,6 +8,7 @@ industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>  industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>  industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>  industrialio-$(CONFIG_ACPI) += industrialio-acpi.o
> +industrialio-$(CONFIG_DEBUG_FS) += industrialio-debugfs.o
>  
>  obj-$(CONFIG_IIO_CONFIGFS) += industrialio-configfs.o
>  obj-$(CONFIG_IIO_GTS_HELPER) += industrialio-gts-helper.o
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 59fa1bd9924b..985ac82a37f9 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -16,6 +16,20 @@ struct iio_buffer;
>  struct iio_chan_spec;
>  struct iio_dev;
>  
> +#if defined(CONFIG_DEBUG_FS)

Veeery small nit, but why not #ifdef CONFIG_DEBUG_FS? It's not
as if you're checking for multiple defines.

> +void iio_debugfs_create(void);
> +void iio_debugfs_remove(void);
> +
> +void iio_device_unregister_debugfs(struct iio_dev *indio_dev);
> +void iio_device_register_debugfs(struct iio_dev *indio_dev);
> +#else
> +static inline void iio_debugfs_create(void) {}
> +static inline void iio_debugfs_remove(void) {}
> +
> +static void iio_device_register_debugfs(struct iio_dev *indio_dev) {}
> +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev) {}
> +#endif /* CONFIG_DEBUG_FS */
> +
>  extern const struct device_type iio_device_type;
>  

...

> +static const struct file_operations iio_debugfs_reg_fops = {
> +	.open = simple_open,
> +	.read = iio_debugfs_read_reg,
> +	.write = iio_debugfs_write_reg,
> +};
> +
> +static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)

Static here but not in the header file. Same goes for register_debugfs().

-- 
Kind regards,
Joshua Crofts

