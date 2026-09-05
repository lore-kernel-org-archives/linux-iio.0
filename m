Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86174DF59;
	Sat,  5 Sep 2026 23:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788650198; cv=none; b=Ko3pFhpHyLZIMjxQsmr36NV8zKOjMfMhSJgL/yxCjBHgbHdvjopMSm4tDkxOwWLYphq4chP+l1y7NPMRY3dA72HblU+Go+dP9KFIhmQqkU7f0xEM2KW2BDIuUKPkj5+6Ngp+Ww2digdJQ5ipAHqTIxoqbyT2/r8SOAtadJmPMh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788650198; c=relaxed/simple;
	bh=HmZbG7JW7gKXJhVn4VEZFs6dZNy28cQKYgB9AV6ZT7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDwOnTQ2jnUsv2UdLPb0uPUc7oS+G0Q0dKxudtSa0m8aNUA75QVeI5zQJXk0xVwGeRvhmcnMe7IDTC72e3JjO2DenUZVIrS8RYdmaPEbhoV7EaG1lIEzNk8+iwfgH0/T3wJNTvWq1oRvAQzAMSiKt8YCDgS0vK6Cf6+x3NZb1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4ms5D6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4ms5D6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA211F00A3A;
	Sat,  5 Sep 2026 23:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788650196;
	bh=Wpf11T6Giu5XollLLrXUyCg/uxAa/DjAXxuZ3yG+gcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k4ms5D6QfXgapwjt8lV2+kNcMTTYEyZv0vnr0vP5FeZ+VUjjBu7bKoIXHICxwxY0+
	 V6QJ6OfRb8d0UivE6CrEN8du3+3uoVgx11QrEA5pFFCVTxqv4QpOsxh8LV4poUdps8
	 vIuGWluneFHCztqYeD7L81UWWW4WaBDzz2qhBQbiRJNrGuWNepdH/ShsdH0MUfZs6l
	 0azPc2ua3SHflYRsUQtMgN1VI+XlyEU6D/IFB8aN68bRDGpdNRnR8+Yiym59J4W6sV
	 TTn6ygqmtKWJLoL9eU7TLh5v1oCGNZZIzz115c7soMSUhRkTj3cZdQPEhizmlFUgfW
	 sZh6Adsz+aFcQ==
Date: Sun, 6 Sep 2026 00:16:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "hpp.iscas" <hppiscas@163.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: Re: [PATCH] iio: accel: bma220: Publish the SPI driver's ACPI alias
Message-ID: <20260906001630.392bb533@jic23-huawei>
In-Reply-To: <20260905133901.66016-1-hppiscas@163.com>
References: <20260905133901.66016-1-hppiscas@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Sep 2026 21:39:01 +0800
"hpp.iscas" <hppiscas@163.com> wrote:

> The BMA220 SPI driver registers an ACPI match table containing BMA0220,
> but exports only its SPI and OF tables. SPI devices with an ACPI
> companion emit an ACPI modalias, which neither existing table covers.
> 
> Publish the ACPI table without changing either of the other matches.
> 
> Fixes: bf2a5600a3eb ("iio: accel: Add support for Bosch BMA220")
> Signed-off-by: hpp.iscas <hppiscas@163.com>
Same issue. I see Guenter also replied with similar. We need something
more 'known' as an identity.  I see you sent quite a few patches out on
similar issues.  I'd suggest perhaps focusing on just getting one or two
through the process as it will save time on duplicated feedback like this.
You can scale up later!

one other thing inline.
> ---
>  drivers/iio/accel/bma220_spi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index d6c1087..13b156b 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -33,6 +33,7 @@ static const struct acpi_device_id bma220_acpi_id[] = {
>  	{ "BMA0220", 0 },

This line has changed suggesting you are working on on old tree.  Give
7.3-rc1 is out, that is a good base for new pathes at this point.

>  	{ }
>  };
> +MODULE_DEVICE_TABLE(acpi, bma220_acpi_id);
>  MODULE_DEVICE_TABLE(spi, bma220_spi_id);
This line should be under the spi_device_id table, so please move it in this
patch as well as adding the acpi one.


>  
>  static const struct of_device_id bma220_of_spi_match[] = {
> 

