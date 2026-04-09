Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAF3E0C54
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748568; cv=none; b=HO44+BgPmXdyiK/24IgSmJ5C+SXRzhDxncNVHDR96vVX6Bj1f+UVKQ4DuAAAH3qGp1pnp2YLNW7CSsW7XDKiw8NsTLxigDdFaDE6ywaVTR9wNfMlU/c8SqRPh5X99ddPhJu8Nif3DKiRuC5QXwIubNbFiy1kkwoko4lZgB2WCfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748568; c=relaxed/simple;
	bh=rN57gqNIl1lCQ4WAcP+5GExP0BrjisgvFbCMe5WTICE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5nTbHgC9mwh77No1xyHNHuv/4Ze6SuzM/fVi5s3ZM3iqRfNctyhnG5hzEbgtU9WP/EPyLCBMHxznLxQPx+Npe660WSogSGgEgEQlIQl5qz4Nk09LmsU+g5mSzNGiTwy75gxStbMmQdZ5a4O4QSwJcg/4B2gH/ranxdNs3xZoqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Zq5fuLSA; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Zq5fuLSA"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dbd08144deso824746a34.0
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2026 08:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775748565; x=1776353365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LrxDBR/P8udeDZw0IqOvxH81ckD91iEnMnTUgIAccVU=;
        b=Zq5fuLSAVhlIE7krWgdRSaWf+mUEU0+LJyHprPAx8eCdX6tD/l0GTaiYOree0zQQ1V
         EyGFmVNhx7glTpPJiR+J4C+4YajdRUdGKCG3MfrZ54R5IHZn9uvY83HowqqPcA5Y8VfJ
         oa40ZTKixEkzXJlqdf701RNwGwbm4hzK7+rtlDrzDKHtHidFKsjOzktvgSeaRUr0a8nj
         xCxCCtkGdNfx+KFoIKOod4PtdIG+bJ+snKhYssOw++D5Q+ZE5iSjbJJJg9nWSLu//mnZ
         aevnILAV5bToireCwx5187MUR9YnzAbGosWvtZ2hRX5fnxGWtnTNOCdAixqtNenLHIKL
         hEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775748565; x=1776353365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrxDBR/P8udeDZw0IqOvxH81ckD91iEnMnTUgIAccVU=;
        b=Bf1AdYPoRwrBH+AYdkemJUB+9jxI7NgnIkuG2H/PAwuWgh3kP83+3FiIaOsMKqfOxh
         0L68Rt+bANwc/SoPoqVf2WElxzjPHVFUsrFgeZWF/knuRLq9BS3eRBgh5JncfGFGOOXu
         Js71KEtXfvHbvjTw5H6m97JPSO9Cy0aXpqC5YVhSfUzCwG09MIFkDQWCplPRKnkCNi6V
         Wi/+TuN1WVe9zrRh8/m6+X7xzDP8UpkwE4P5zrBRoWG/jsA+uno8U5LMeGgiH5yURZmY
         qDypXIBr7P7vyS20ntcVdfkB7qGVQj4F+9zfpfAgdW6o8NwKSuG5ebAAB7UptmzrB/MV
         jD9A==
X-Forwarded-Encrypted: i=1; AJvYcCVfX23v9ljPhDUsFDVPyJWY3FvDWmVZeYBZUNVruOAeKRWU3lnrk8U4lv/RJxtQ/XBiOe1JURJ/eGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqsSHrexfWy7C0I/eEHOtLnq81eBsptvYHHbLsch858EU1CoS
	FppC92FokgPFjBsot8DzMgJph4PwzOdiftWkaAayziobeCaxBa25KAOO3c+1iLpeYIg=
X-Gm-Gg: AeBDiesu3dKmuSRciRCVan2pRN/Vs3RTVWe23S+7zxp5hQHv0cDiAuzL1hbAscTFQ7R
	f6+A9rwwNokBnFQMCeic8lsn8JPsXPEyF2o3aCZPpdfUuASSfEd0XXNb2Rry8UcNXv+CgYEXM6r
	8nllHqaRgaGazavo0IRNhH+c1FgXcqfKefP9HcYIaQkcVtZ2SsFUJMlLIH2X5RE+r1ZEFxp/Rv5
	Igz9SX6mGtcqtxWR7/qFHAinLbe3SfBDHqdcte30ovnBoeDspdGm6sLHrE184gCGe0jMPTgwtEr
	iCtAmWJNBN2ZWE6zYskBOzLI5DEGtrZJqpAzUxnn+6z8Rtadl9N76LR6rUhZPbuZ2H9oQnSE6Dl
	uaG2WQO5fqngQhgxJvIw+jmODr4sls+BbdwRW5M+Udrc9o5EhLnRMkxZ83d7PHHmfIaOBR+1rhH
	WDJoZ9J4Uq1naXZq1KuNICHDlh0ca+5hi22PLwZwaLA2Xn+ZPoMbB5PdNDOqhKtT+ghsNcXdf/r
	g==
X-Received: by 2002:a05:6820:222a:b0:67e:1be4:d8c6 with SMTP id 006d021491bc7-68220646af6mr12882122eaf.58.1775748565288;
        Thu, 09 Apr 2026 08:29:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a548:cf0c:d054:fd01? ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68791a61c56sm4602955eaf.2.2026.04.09.08.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:29:24 -0700 (PDT)
Message-ID: <76474ad8-3f12-488a-9092-8aff8bfa0936@baylibre.com>
Date: Thu, 9 Apr 2026 10:29:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: imu: adis16550: fix stack leak in trigger
 handler
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 stable <stable@kernel.org>
References: <2026040947-overhang-fax-02d0@gregkh>
 <2026040949-canopy-thirsty-362d@gregkh>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2026040949-canopy-thirsty-362d@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/26 8:40 AM, Greg Kroah-Hartman wrote:
> adis16550_trigger_handler() declares the scan data array on the stack
> without initializing it.  The memcpy() at the bottom fills only the
> first 28 bytes (TEMP + 6 channels of GYRO/ACCEL data), and
> iio_push_to_buffers_with_timestamp() writes the s64 timestamp at the
> 8-byte-aligned offset 32.  Bytes 28-31 remain uninitialized stack data
> which leaks to userspace on ever trigger.
> 
> Fix this all by just zero-initializing the structure on the stack.
> 

Reviewed-by: David Lechner <dlechner@baylibre.com>

> 
> diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> index 1f2af506f4bd..75679612052f 100644
> --- a/drivers/iio/imu/adis16550.c
> +++ b/drivers/iio/imu/adis16550.c
> @@ -836,7 +836,7 @@ static irqreturn_t adis16550_trigger_handler(int irq, void *p)
>  	u16 dummy;
>  	bool valid;
>  	struct iio_poll_func *pf = p;
> -	__be32 data[ADIS16550_MAX_SCAN_DATA] __aligned(8);
> +	__be32 data[ADIS16550_MAX_SCAN_DATA] __aligned(8) = { };

And another case where a followup patch to use IIO_DECLARE_BUFFER_WITH_TS()
would be appropriate.

>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct adis16550 *st = iio_priv(indio_dev);
>  	struct adis *adis = iio_device_get_drvdata(indio_dev);

