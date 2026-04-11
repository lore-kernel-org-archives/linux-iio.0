Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315A51D5151
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935693; cv=none; b=d4rgIOsJ3PLqhxCB+6IlodaoFfSeAP0Tic8qyIxvynZHimb1D9h3ZMN6TxSxp58asGvQMzLWCU/9PQ+vquSFeZFF0iUyLbspmZVSLgVrKpc6aUQqXRBskbtz9A6VpgAFFRmQSR36RARs1jQoIszmi+vEMa7iaxMDhGfWhgObchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935693; c=relaxed/simple;
	bh=2sNIdWrd945IOGQtxtsSGClheuILfCTJ1X0VSYffb3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+eaAUiDppho0HGVuwPpAK6Hq/kDBG7c7o/A2WRTbcFWVvNIQfZsjLekw0KBO6jkZ8rc+bPGEXEnOT2VruvC8J4PUEFioJuWLX0F9+DjX/ldknqe27+3ULNYOA5mF/C7qXKYYz8T25kBn+t7qF0aYNdpVErBimnJD1EDZr8tDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=OfD8PSMf; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="OfD8PSMf"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40ef10ec84cso2111850fac.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775935689; x=1776540489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AyJL0kUnDxM6166F9pMjNO09u6R1nYa0DYiABdU9bA4=;
        b=OfD8PSMf+n1pf8O8cg9Kh/rmckbNCsJsvUXIwXeNuTYMSND320timfkaRKr1pBEX79
         cyBF0GEeq6ZPp0hSQHV9legUtafhj77bJbm+2HTqOkW7FstqKtnftaprc+B+LSJH8NOv
         S88FC9fq7CwGaPTiy+vcGjnZfvDy7zZYkGhC2JvFpddwWbbhwLMLvPaBh7BiNUNAi4vr
         GeFerurGSYvi0FyfHzE+dBYxEPhh1u74ov/D42y1VmSlxDDIcToBc8HT/QBxd8c9niLw
         4N2afyGQ+FeF6dwE+WWtbWJTn2osJ7Td/GtSrtUl+N0u6lIGF+4oL7unASXbQzQWZ4DQ
         cgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775935689; x=1776540489;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AyJL0kUnDxM6166F9pMjNO09u6R1nYa0DYiABdU9bA4=;
        b=KITtfZnWx/feAkKDSghOmCnIT+P5Dc6FjiJc0u0BynQZgADWizEKL5IiVjlFlkZewD
         Eu0itnfx2/wyStlbUBKmg5aErvJSWd98GZK0E3pPINymP99sGqj3BB8wNyISaidpmEbH
         G+1hhbHSG5hrPAm4LEQiz3G3oQ/daLRynLC18lHQeB+MU4/+E1CMMKzEWyDQ7KDg51PO
         4zCIoJUXgxRbNL0fNt+eK4xlQ8xBWvZ3xUM+x5cJH4XqMzRZzDNL/4itryjK/myy0LdF
         fFNs+dee3MfOGPkkVHQae+amwAFjqykETss7tfKn3gOk7oNyDiAuLlEApbvlvCf22sDP
         mvWA==
X-Forwarded-Encrypted: i=1; AJvYcCV5oS5VMQ4xbkAwXU5I/5O406/MhWDUQR5IP+siUDkPPm9d1RuSPL4qYr3V4LpyphV+KzpOCpDYEfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJEBl8rCJENkPBCbGIMfPlL7K1n3IMIpy9JbLKsDDKrXqLwwaE
	kqNypKHACkCe6q5sm2ii0MF+ddgRLsYhTBr0b3TVmYP6wtLBaVoht+cjVwrQAiwNjAE=
X-Gm-Gg: AeBDiev6k++NgNXCHuYjrTTCkclNVzF7eNzmkpPnkDRcuIn/3abZitMn0PxOW7pUwhO
	hj4e9a/0EKrqPfy5RJJ6ZFVjIph/lYzQfN0k8C5KUjTrCrIjoTW9RgU6TkyziP1ivgLssAfOuiq
	UcWWYrPYGLAYpme9Ano2Q0C3IJItI6mePzDDrxuOVODhFgjprJW3FhfNhMJchvhDagUqtGCzlba
	QELOxYro6bFyDuwU/9xdTZv2VcvsIlp5sZ1ImKa6Arvza0BHLs+/pFdDzdX1LwlfO5ff6c3SN25
	9AYTxLMe9tUosX+jlRUbtK2y7x772VcM7YufOBJvhBDXKhP1Xm/WFzjzQa5qAicammUJlb9zcim
	2NbCnETonLRACq6Ggb0gzSI/2D0O3v8t524WEPCsYZfHo6NjCwURjn1tiAbyJXQLkWhim8g1E4x
	5PSF6iQEC9/0RYnURH2lHPW/PUQqtkDjv5zrW7guR9Lxay3qmiRNeCNlxrUhXjFqLjAN2PgT6yq
	6pl8UQWCTb3
X-Received: by 2002:a05:6870:d06:b0:422:f606:1420 with SMTP id 586e51a60fabf-423e113c410mr4250749fac.34.1775935689020;
        Sat, 11 Apr 2026 12:28:09 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d2e5:c81c:5b23:fe55? ([2600:8803:e7e4:500:d2e5:c81c:5b23:fe55])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423dd420bd2sm4761399fac.6.2026.04.11.12.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 12:28:08 -0700 (PDT)
Message-ID: <ceb7a191-2e6d-4711-b108-e91a2fcaf2d7@baylibre.com>
Date: Sat, 11 Apr 2026 14:28:07 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: imu: bmi323: Fix potential out-of-bounds access of
 bmi323_hw[]
To: gerben@altlinux.org, jagathjog1996@gmail.com
Cc: jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20260327103202.459143-1-gerben@altlinux.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260327103202.459143-1-gerben@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/26 5:32 AM, gerben@altlinux.org wrote:
> From: Denis Rastyogin <gerben@altlinux.org>
> 
> The bmi323_channels[] array defines a channel with chan->type =
> IIO_TEMP and enables the IIO_CHAN_INFO_SCALE mask. As a result,
> bmi323_write_raw() may be called for this channel. However,
> bmi323_iio_to_sensor() returns -EINVAL for IIO_TEMP, and if this
> value is not validated, it can lead to an out-of-bounds access
> when used as an array index.
> 
> A similar case is properly handled in bmi323_read_raw() and does
> not result in an error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 8a636db3aa57 ("iio: imu: Add driver for BMI323 IMU")
> Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
> ---
>  drivers/iio/imu/bmi323/bmi323_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_core.c b/drivers/iio/imu/bmi323/bmi323_core.c
> index 6bcb9a436581..64ead4f667e0 100644
> --- a/drivers/iio/imu/bmi323/bmi323_core.c
> +++ b/drivers/iio/imu/bmi323/bmi323_core.c
> @@ -1713,6 +1713,8 @@ static int bmi323_write_raw(struct iio_dev *indio_dev,
>  		iio_device_release_direct(indio_dev);
>  		return ret;
>  	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_TEMP)
> +			return -EINVAL;
>  		if (!iio_device_claim_direct(indio_dev))
>  			return -EBUSY;
>  		ret = bmi323_set_scale(data, bmi323_iio_to_sensor(chan->type),

This is OK, but why not check and propagate the error return?

 	case IIO_CHAN_INFO_SCALE:
		ret = bmi323_iio_to_sensor(chan->type);
		if (ret < 0)
			return ret;

  		if (!iio_device_claim_direct(indio_dev))
  			return -EBUSY;
  		ret = bmi323_set_scale(data, ret, val, val2);
		...

And even if we shouldn't hit the error in other case statements,
it seems like it would be good practice to still check for error
there too.

