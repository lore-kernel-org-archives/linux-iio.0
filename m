Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766EC226CF6;
	Sun, 26 Apr 2026 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777213924; cv=none; b=kBQq4aiwkLwY8eJVJbUwWzHtYdDM6teEUs2hi10pZ71GoHyUEejHkkJPTna6nbC3RakI755Qa292xK8TwrlyzgDF0VgPQn82eaUns+GhLAP7dep6R1d0cWiAWbPGBltPosYcn5bcsamOA8DsNfXh26iPwHicp9FUhG69mUZ6MH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777213924; c=relaxed/simple;
	bh=zeiR9b+rl+cQSN5Y8uSI/E7U63o28Joy59PWGfCEMfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mU0L6ofWkJkuWBXyQxxXDpgJaiyO2yBJ8k1Y/f9zyzloHXFlLXk5m8DIDvmSxhdEFKiKZdQbbyuKNeWYARNnacd5p6YQB/y6m7ybDmKJ6J9M3zyyyJh7bwRKuZz9nZhjYcnF87I6okwcTgcZP5MdzdbzX18uZMFroEP8170DgHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkLUn3RW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkLUn3RW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8B0C2BCAF;
	Sun, 26 Apr 2026 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777213924;
	bh=zeiR9b+rl+cQSN5Y8uSI/E7U63o28Joy59PWGfCEMfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UkLUn3RWhUMlRwUTJrO2S8LNSOOzfmrOH0pX+m2p83yDUBat9s5pL8a9CJ/IpteTa
	 Zq5XZmJjTAsEjK2Dq0XQ3t6qpP6kZCF/hgge4sHH6GAzyvX1L1xZ3C/JL9++dDOq80
	 oSgCIf4Khb5pIvx23CtKtUZqgnjpZCHnmx62bIvHsXWKvFsRMY8m9xtHvqWmZZvJ7y
	 dYGc+YuNlKwEs5rKmbrIsd76iwLvmkwjCHk8YgLxjBdr+ciLR03tsYD8W7kVuP2Wr2
	 u9zW8J54DNnmy6jcUYkG2FFiRQhauxVofiINBfPixUuXogcfZF3drDMNepTRwymmmo
	 0qFX+MlfTw2pg==
Date: Sun, 26 Apr 2026 15:31:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 mingo@kernel.org, christophe.jaillet@wanadoo.fr,
 nabijaczleweli@nabijaczleweli.xyz, kees@kernel.org,
 kyungmin.park@samsung.com, k.wrona@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 9/9] iio: ssp_sensors: reuse embedded RX buffer for
 SPI transfers
Message-ID: <20260426153154.11bb41c9@jic23-huawei>
In-Reply-To: <20260426091710.3722035-10-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
	<20260426091710.3722035-10-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 14:47:10 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Avoid allocating a temporary DMA buffer in the interrupt context when
> handling hub-to-AP and AP-to-hub SPI write messages.
> 
> Replace the dynamically allocated RX buffer with a fixed-size,
> preallocated buffer embedded in the driver structure and reused for all
> SPI receive operations. This removes memory allocation from the
> IRQ path, simplifies lifetime management.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
> Changes in v6:
> - Replace dynamically allocated RX buffer with embedded fixed-size buffer
> - Fix struct layout to satisfy DMA alignment constraints comment from David
> - v5 change: https://lore.kernel.org/all/20260406080852.2727453-6-sanjayembedded@gmail.com/
> Changes in v5:
> - Rebase change on top of latest v5 patch series.
> Changes in v4:
> - Use preallocated buffer and stash a buffer that gets reused each time instead of a fresh allocation.
> - v3 change: https://lore.kernel.org/all/20260315125509.857195-3-sanjayembedded@gmail.com/
> Changes in v3:
> - prepare series to have all respective cleanup API support for the ssp_sensors following input from Andy Shevchenko
> - v2 change: https://lore.kernel.org/all/20260311174151.3441429-1-sanjayembedded@gmail.com/
> Changes in v2:
> - split series to individual patch
> - address review comment from Andy Shevchenko
> - v1 change: https://lore.kernel.org/all/20260310200513.2162018-3-sanjayembedded@gmail.com/
> ---
>  drivers/iio/common/ssp_sensors/ssp.h     |  3 +++
>  drivers/iio/common/ssp_sensors/ssp_spi.c | 20 ++------------------
>  2 files changed, 5 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
> index f649cdecc277..8295bb7062a3 100644
> --- a/drivers/iio/common/ssp_sensors/ssp.h
> +++ b/drivers/iio/common/ssp_sensors/ssp.h
> @@ -174,6 +174,7 @@ struct ssp_sensorhub_info {
>   * @pending_list:	pending list for messages queued to be sent/read
>   * @sensor_devs:	registered IIO devices table
>   * @enable_refcount:	enable reference count for wdt (watchdog timer)
> + * @rx_buf:		buffer to receive SPI data
>   * @header_buffer:	cache aligned buffer for packet header
>   */
>  struct ssp_data {
> @@ -221,6 +222,8 @@ struct ssp_data {
>  	struct iio_dev *sensor_devs[SSP_SENSOR_MAX];
>  	atomic_t enable_refcount;
>  
> +	u8 rx_buf[SSP_DATA_PACKET_SIZE];

Whilst the define exists for this size, do we have anything to confirm it is right?
It wasn't previously used for anything so is a bit high risk.

Also, why doesn't it need to be DMA safe?  I'd expect it either after the following buffer
or with a __aligned(IIO_DMA_MINALIGN) marking in which case the one below isn't used.


> +
>  	__le16 header_buffer[SSP_HEADER_BUFFER_SIZE / sizeof(__le16)] __aligned(IIO_DMA_MINALIGN);
>  };
>  
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> index 870214551f0b..e41da88bf96d 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -339,7 +339,7 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
>  /* threaded irq */
>  int ssp_irq_msg(struct ssp_data *data)
>  {
> -	char *buffer;
> +	char *buffer = data->rx_buf;

Put this in inline. The local variable may reduce code churn but
it also hides the important info that this is not locally allocated.

>  	u8 msg_type;
>  	int ret;
>  	u16 length, msg_options;
> @@ -383,19 +383,12 @@ int ssp_irq_msg(struct ssp_data *data)
>  			 * but the slave should not send such ones - it is to
>  			 * check but let's handle this
>  			 */
> -			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
> -			if (!buffer) {
> -				ret = -ENOMEM;
> -				goto _unlock;
> -			}
>  
>  			/* got dead packet so it is always an error */
>  			ret = spi_read(data->spi, buffer, length);
>  			if (ret >= 0)
>  				ret = -EPROTO;
>  
> -			kfree(buffer);
> -
>  			dev_err(SSP_DEV, "No match error %x\n",
>  				msg_options);
>  
> @@ -428,22 +421,13 @@ int ssp_irq_msg(struct ssp_data *data)
>  		mutex_unlock(&data->pending_lock);
>  		break;
>  	case SSP_HUB2AP_WRITE:
> -		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
> -		if (!buffer)
> -			return -ENOMEM;
> -
>  		ret = spi_read(data->spi, buffer, length);
>  		if (ret < 0) {
>  			dev_err(SSP_DEV, "spi read fail\n");
> -			kfree(buffer);
>  			break;
>  		}
>  
> -		ret = ssp_parse_dataframe(data, buffer, length);
> -
> -		kfree(buffer);
> -		break;
> -
> +		return ssp_parse_dataframe(data, buffer, length);

This now makes this path different from the other switch legs.
I would precede this patch with one doing direct returns from
all the legs in here.  Then this just becomes an obvious update
in this patch.

>  	default:
>  		dev_err(SSP_DEV, "unknown msg type\n");
>  		return -EPROTO;

