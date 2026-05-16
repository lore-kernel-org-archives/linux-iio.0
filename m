Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D513446C8
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778957741; cv=none; b=D/38oSHS06KwkJUC2sWrYxdow4LMTM/mFma/fFqE65lR7GCrb2ZecoKhECTN2904h61mSNcc1DJb/1ZlhEV5RX5zG5x/tEWG5pOAHB3SZ+txinxwdw1tLswWq07eIdsQx6TzRiIfVNqjsgTi2rtyQe3GoDi4pVx9Oachw+sPjvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778957741; c=relaxed/simple;
	bh=smXl1ACaQHdx8U9FRyQERdVxO1VUUXTtW/E9FaBEaAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8UcR0Ln/JfPyBeZTIVXV3kJyMEHB4bqcEdoCSPfk/DjJPw6af18FxJYaQX1xMUfNUFfT1NXQA/PGxUWfGxvBNjVQ9iCC7tSu3+uRbngGtx/cOg/JOQAAMD9TXv87GG3t67zd/rKVpr91LnntniSOnGgijcKKXtvk6FDd7mKiFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=l2dfTfEX; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="l2dfTfEX"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7de4e6c5a30so1388009a34.0
        for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778957736; x=1779562536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eq1K19iN5oeMgMBNYzXC3DPpQmXlX4CG05SJjOP5vxI=;
        b=l2dfTfEX4Gav4ZtONxQ8r+uwAzyrPuND4jKG4BNcI/miKn0PKiOD58T10MkINQA5lP
         eGlfO43jKrMln1pTPtc1V8gxQ27XL+FhXe4JfALmwZ+ht4mDGGE8kQ+x6Xf5jN/Wmtie
         w6khg3zGZ8f3XWKpWRq3HtIGVWNptQs9XI3rvhTuE9gMPhIm/R8GOGM+vru2QyRuVit9
         fYjwHwdFpz5QngtS41chn8ThIDUUOkC4lDG1GEZFlQ9UJbkGbpztyBs2TkTkSQe6zhSA
         w4K/mOBjSpc5JE2L/lHKV5iTeZpyK5+TPinRG4Z/nY2H4blIFMBSX+WWtdgYq8qCfuwK
         DRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778957736; x=1779562536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eq1K19iN5oeMgMBNYzXC3DPpQmXlX4CG05SJjOP5vxI=;
        b=F5w74CRpcemgBy400MAR+egtEmHTScouKlDRzHZ/i76eupFtjGiw2gy/nRchC0QbLm
         xVHTHO1yp34AiJFYKfq1I8nZQGYb/KK6qg8mN29UPYJcb74AGLAk+T0lhVzBx914NH2m
         66tKQeGGYG5huUuu6b1WNk+lDBVzkGvpv/mW0ISiaitSzUXfS8Jbm7gJRb8n0V4y7qJ7
         zuMXlu7bRQXMl/GAmKo5UCw4Lcru7fr7Wj7oxiEntL21dE/aNOV4M/zVmCj0b/w2DDm0
         7H45NXj5CO+usV/vhEfNB1jrvse/5MUxyJ02MXEkQlY6Q686F85k38LF48givTB5Gbbb
         QShg==
X-Forwarded-Encrypted: i=1; AFNElJ+DMmQFy0awq7ASVoO93H2U0eICWDzmxp7CZWVmDn3G6RLnFiyuWKpKHoKuhT8IE2qvSXtgsI7hYS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Ewe5FTRAcR81e+txJr85/Dg+Q/PA+MfwTvWtxWULAAlh96eK
	0F0agQl6OASplKtVKMRVusEfGGG3dx3RQvEQFW5Qxa7Lw6j3blMXkYUOSHmPXFNFAoc=
X-Gm-Gg: Acq92OEJ+GtRcLaaWWBHW+5Qo1NwPWAGcqNp0ZExOdmn2kttA0LgARE+qGbNF5DHuNE
	Rcw9h8wl9257BO/SJTffxybuSYC/xCJo28d6K51/dW13cgFwcJFgriuVD+oI+dGdn4FtCkARfsB
	BBzLdhXpdw0FoTxWdS+MBMqyQ1/3+mwPJ2r59AaOsOVtBbCVKPH9d0rUi+IB+TgQe4mAW1Xu1vs
	JgcT/SDnH/hh+6yYONrrA5CGyhNjZhu2wpVTTb8fCt1UgsGOHIaMs/zKP/SSGVWVxKuZpuhHrxn
	pfffG2CFwPvEdE1riYUt+wudMs2BjCjm4eDA5S443F80qNjdUqF4mDl1TaLg0pX6ja1EjzX5Wam
	LHOmAvDh6Ljf+WGOUoEsWC30p/VCT8dPv8EGWaqwGordSdNOfOtbFTOM+3w2NRdw5gljER+HSJg
	yLNXgs6EvHY49QEU0eu7BWb9H9YX2pPmF3A2VZb0SPBqeg1JYlQXLZqBdLp4faShcKbsEjDDsla
	5X0jwyA4TNh
X-Received: by 2002:a05:6830:6d18:b0:7dd:91cd:2b19 with SMTP id 46e09a7af769-7e4f2b1d085mr6087518a34.14.1778957736535;
        Sat, 16 May 2026 11:55:36 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b36d:bd18:7c02:29e2? ([2600:8803:e7e4:500:b36d:bd18:7c02:29e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55bc13a0asm4453747a34.21.2026.05.16.11.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 11:55:36 -0700 (PDT)
Message-ID: <54eca584-b749-4417-b37a-40c5513b0442@baylibre.com>
Date: Sat, 16 May 2026 13:55:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] iio: accel: adxl372: Add timestamp to FIFO data
To: Md Shofiqul Islam <shofiqtest@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260510082556.3867-1-shofiqtest@gmail.com>
 <20260510082556.3867-2-shofiqtest@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260510082556.3867-2-shofiqtest@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/26 3:25 AM, Md Shofiqul Islam wrote:
> The driver pushes FIFO samples using iio_push_to_buffers() which does
> not attach a hardware timestamp to the data.  Add a scan buffer struct
> with an aligned_s64 timestamp field to the driver state, capture a
> single timestamp per IRQ with iio_get_time_ns(), and switch the FIFO
> push loop to iio_push_to_buffers_with_timestamp().  The same timestamp
> is reused for the event push call in the same handler, replacing the
> duplicate iio_get_time_ns() invocation there.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  drivers/iio/accel/adxl372.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 545a21e5a3..521e8313b1 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -367,6 +367,10 @@ struct adxl372_state {
>  	u16				watermark;


>  	__be16				fifo_buf[ADXL372_FIFO_SIZE];

I would just change this line to:

	IIO_DECLARE_BUFFER_WITH_TS(__be16, fifo_buf, ADXL372_FIFO_SIZE);

>  	bool				peak_fifo_mode_en;
> +	struct {
> +		__be16 channels[3];
> +		aligned_s64 ts;
> +	} scan;

Then we don't need the extra struct and memcpy().

If we really do need the memcpy() for some reason, this struct
can be declared on the stack instead of here.

>  	struct mutex			threshold_m; /* lock for threshold */
>  };
>  
> @@ -703,13 +707,15 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>  	struct adxl372_state *st = iio_priv(indio_dev);
>  	u8 status1, status2;
>  	u16 fifo_entries;
> +	s64 ts;
>  	int i, ret;
>  
>  	ret = adxl372_get_status(st, &status1, &status2, &fifo_entries);
>  	if (ret < 0)
>  		goto err;
>  
> -	adxl372_push_event(indio_dev, iio_get_time_ns(indio_dev), status2);
> +	ts = iio_get_time_ns(indio_dev);
> +	adxl372_push_event(indio_dev, ts, status2);
>  
>  	if (st->fifo_mode != ADXL372_FIFO_BYPASSED &&
>  	    ADXL372_STATUS_1_FIFO_FULL(status1)) {
> @@ -733,7 +739,10 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
>  			/* filter peak detection data */
>  			if (st->peak_fifo_mode_en)
>  				adxl372_arrange_axis_data(st, &st->fifo_buf[i]);
> -			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> +			memcpy(st->scan.channels, &st->fifo_buf[i],
> +			       st->fifo_set_size * sizeof(__be16));
> +			iio_push_to_buffers_with_timestamp(indio_dev,
> +							   &st->scan, ts);
>  		}
>  	}
>  err:

