Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDE926CE2D
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491677; cv=none; b=jm2kvg4gABF7yn4liQDgC1iH77p9eb1D8gpOJaloHlBSyH2yIMHQu/Pwc7PX9FgZ6tYzP9PT/7jfEWlWBTgY+26BDdINrAoKUhii2umSz8GL5e8a81rfk8/wfxixzD+Pjp60Gv+xRDMc3ePT5jkQBr3fF8f9VrcyABwIPbFSZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491677; c=relaxed/simple;
	bh=zlwO+FpuKWJVktzvoDwSqRpk686HL789y1WeAACkLLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IV99nMhCU01yOUIWAPgH2LPvHkuBsZrWckuXl1Cq/7QssN5TVQcd8owz2Wn+FRyleiUNQSuv6Alv3yIxT05chSbDQJ/+NuIzXbE/PudQxp9rnd/NqM6AEQyndsb2t8MiCTUEU+mCRVaMJHysieS+3bY0Av4DFbtNBcPlfhtYrc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=pir23dDk; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="pir23dDk"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-682baaa9f1aso727251eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775491671; x=1776096471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bb/yPIBaSeKzdMTqZaiYXvUJtywcvVMfoOdb3IXyt2A=;
        b=pir23dDkEa8r5U0Kbrmtgl0HR0Vg8WEL1zrOuKabnPTkW98BwBHNZusiDBBvjQ7T38
         SVkv7CKHdrl4ZLrLaLShjAQSyN0bZWtLbJShDoa8meQYTvqtJdTH4F5wbfYhIx9eelWy
         Nbrx9iCHRusvdeP0Jf/qtZpEhWPocki4AA4wNF72KaBPmptd1XRvw1KQ200Egd0sqSBM
         T6/gmMYPJdGtSTy44EZOprIhIznbyEbJ7WgRjYTWP+gGGh6FoYzPXaWQwBJ7wr4393u1
         YMonQyta1sjyTJpwmEnxNZeJm6EoULCHBEHX+fbg5A9ODE4DkE19PJRxJJ7bSBvOQ4GY
         FspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775491671; x=1776096471;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bb/yPIBaSeKzdMTqZaiYXvUJtywcvVMfoOdb3IXyt2A=;
        b=hIjw8cRgRQMHmwcVEgnGEF4wU0YX6QXO9Lz3RnV5OZNDpeUWBjTEZ/Bnh+Z5A07Wo2
         lNpWX3UWp/NB76sDDezljl+IJRR0M5oLk3s8MljYVytOy7ne6SXaC5O6HrknS/eBmXRu
         MYd9KSVahY5GQElYMCWSmMLnC4RE0qRH/kEVZPOwyoXBYHdHF2AVUr6//wvKakUqJioW
         YQfAxeDZ58iBNcYKKU4Rx7JMxM6VuJoti/CvrFs1iB4X7HZniwwlE041lu9/4K+xsQxV
         fTxMW/t6CAKP2ZPbKqraRGmnl8n6MxjNMEUDfg1xhwv37tkBXNa17Cd4t/utxFB94ldw
         kpPA==
X-Forwarded-Encrypted: i=1; AJvYcCW0vvb4LcqWVi8Yi5OUtPnGaGg+U2mO+t1AHE8m1/KkuUXvdldHI7DAdmGiQmpQ2Bzi46rJB1DZ1b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfWa2Ci5DoQ+/7vZluOdNCkm/Ib3OCqH6/Lv9W2qfiG2HFu06G
	xpfWwY6rDMPe4KxK//VEfwmOxlpdSm/xXN54HAj6Ws+tE8/bVqSVnBv+yJiX1vuJXbk=
X-Gm-Gg: AeBDiesRYhTPkg2O7y4I2djBD9SlmZi1P8kp5syIWgztEoqdNmfv4aV1D/+cGQ3ix/B
	V49h/YudUTGp1XbX0QqmvP4ohfQNnoBq2kRCStIYcOHZz3OQ7Gg1Uwbz4Kq2nSo1NHjKVgOh/Kg
	x9HTltJusw6WFOpeUrHN8ebIb0je0NVTLlxT2wBJVk3D7Q6yUgGWAn7DAZM4P4i5Lr5W4sWSO4A
	AsG96RRf4+FThKn9W9nnOLNqYVsSDE9qIhh9C7Ot2m7KFNO+lsT/nwCBn0y8wlw5IfGH1PEFVIW
	Rvkh3nteCDmVi9lvixMsbiEBesn8DJ+mkmGBmrRoO6wk9fY+FIYxQaktLFQvAIgihLaKX5wkBer
	fJv8xu9KBT2QlqitCLsYpCiOBzerYvpsDevDtomiyHMF0tJp/AFZu8Qn6bi7a4TVc92Y7EKDcyu
	hEHKzFQ4QORxtgn7zGMYTgGvVsbraCFKiqjGNkETRVG5afpdMefdLNksoive4ONEpTIUgbSds=
X-Received: by 2002:a05:6820:3092:b0:67b:b847:f0fa with SMTP id 006d021491bc7-6821f08dcbemr7686820eaf.17.1775491671418;
        Mon, 06 Apr 2026 09:07:51 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:90d7:b13f:c53:8ca3? ([2600:8803:e7e4:500:90d7:b13f:c53:8ca3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-680a882d978sm8724859eaf.10.2026.04.06.09.07.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 09:07:50 -0700 (PDT)
Message-ID: <8c5dfc4c-dff9-46a4-adcc-dbca54f0c125@baylibre.com>
Date: Mon, 6 Apr 2026 11:07:49 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] iio: ssp_sensors: reuse preallocated RX buffer for
 SPI transfers
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org
Cc: kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260406080852.2727453-1-sanjayembedded@gmail.com>
 <20260406080852.2727453-6-sanjayembedded@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260406080852.2727453-6-sanjayembedded@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/6/26 3:08 AM, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Avoid allocating a temporary DMA buffer in the interrupt context when
> handling hub-to-AP and AP-to-hub SPI write messages.
> 
> Preallocate RX buffer during probe and reuse it for SPI receive
> operations. This removes repeated kzalloc() calls from the IRQ
> path, reduces allocation overhead, and avoids potential allocation
> failures under memory pressure.
> 
> The RX buffer size is tracked and allocated using devm_kzalloc(), ensuring
> proper lifetime management tied to the device.
> 
> No functional change intended; this is an internal optimization and
> robustness improvement.

If we are going to claim this is an optimization, we should have
some measurements to back that up.

> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
> Changes in v5:
> - Rebase change on top of latest v5 patch series.
> Changes in v4:
> - Use preallocated buffer and stash a buffer that gets reused each time instead of a fresh allocation.
> - Link to v3: https://lore.kernel.org/all/20260315125509.857195-3-sanjayembedded@gmail.com/
> Changes in v3:
> - prepare series to have all respective cleanup API support for the ssp_sensors following input from Andy Shevchenko
> - Link to v2 https://lore.kernel.org/all/20260311174151.3441429-1-sanjayembedded@gmail.com/
> Changes in v2:
> - split series to individual patch
> - address review comment from Andy Shevchenko
> - Link to v1 https://lore.kernel.org/all/20260310200513.2162018-3-sanjayembedded@gmail.com/
> ---
>  drivers/iio/common/ssp_sensors/ssp.h     |  5 +++++
>  drivers/iio/common/ssp_sensors/ssp_dev.c | 12 ++++++++++++
>  drivers/iio/common/ssp_sensors/ssp_spi.c | 19 +++----------------
>  3 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
> index f649cdecc277..aa125fd1bed5 100644
> --- a/drivers/iio/common/ssp_sensors/ssp.h
> +++ b/drivers/iio/common/ssp_sensors/ssp.h
> @@ -175,6 +175,8 @@ struct ssp_sensorhub_info {
>   * @sensor_devs:	registered IIO devices table
>   * @enable_refcount:	enable reference count for wdt (watchdog timer)
>   * @header_buffer:	cache aligned buffer for packet header
> + * @rx_buf:		buffer to receive SPI data
> + * @rx_buf_size:	allocated size of rx_buf
>   */
>  struct ssp_data {
>  	struct spi_device *spi;
> @@ -222,6 +224,9 @@ struct ssp_data {
>  	atomic_t enable_refcount;
>  
>  	__le16 header_buffer[SSP_HEADER_BUFFER_SIZE / sizeof(__le16)] __aligned(IIO_DMA_MINALIGN);
> +
> +	u8 *rx_buf;
> +	size_t rx_buf_size;

No, these can't be after _aligned(IIO_DMA_MINALIGN); without causing problems.

What would work here though is:

	u8 rx_buf[SSP_DATA_PACKET_SIZE];

>  };
>  
>  void ssp_clean_pending_list(struct ssp_data *data);
> diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
> index aab28f2a0f75..2a8d6f040ae4 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_dev.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
> @@ -516,6 +516,18 @@ static int ssp_probe(struct spi_device *spi)
>  		goto err_setup_spi;
>  	}
>  
> +	data->rx_buf_size = SSP_DATA_PACKET_SIZE;
> +	data->rx_buf = devm_kzalloc(&spi->dev,
> +				    data->rx_buf_size,
> +				    GFP_KERNEL | GFP_DMA);

Since this is a fixed size, we don't need a separate alloc here. We can
just embed the array in the data struct.

> +
> +	if (!data->rx_buf) {
> +		dev_err(&spi->dev,
> +			"Failed to allocate memory for rx_buf\n");
> +		ret = -ENOMEM;
> +		goto err_setup_spi;
> +	}
> +
>  	for (i = 0; i < SSP_SENSOR_MAX; ++i) {
>  		data->delay_buf[i] = SSP_DEFAULT_POLLING_DELAY;
>  		data->batch_latency_buf[i] = 0;
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> index 7c1780e15acf..2f7445e8b4d1 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -383,19 +383,13 @@ int ssp_irq_msg(struct ssp_data *data)
>  			 * but the slave should not send such ones - it is to
>  			 * check but let's handle this
>  			 */
> -			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
> -			if (!buffer) {
> -				ret = -ENOMEM;
> -				goto _unlock;
> -			}
> +			buffer = data->rx_buf;


I don't think it is helpful to keep the buffer local variable.

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
> @@ -428,22 +422,15 @@ int ssp_irq_msg(struct ssp_data *data)
>  		mutex_unlock(&data->pending_lock);
>  		break;
>  	case SSP_HUB2AP_WRITE:
> -		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
> -		if (!buffer)
> -			return -ENOMEM;
> +		buffer = data->rx_buf;
>  
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
>  	default:
>  		dev_err(SSP_DEV, "unknown msg type\n");
>  		return -EPROTO;

