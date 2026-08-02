Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088CB3C07A;
	Sun,  2 Aug 2026 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785690297; cv=none; b=KSLltNuTekyU+uN+K+m4DUTOZ83Ua/uJAbqaEXINf5SKhHigBn2ed/xOzfafD65U9XY6O5PrZPh479qebo6imHtZ2IUgSB7cYuxZBxoxtihArD011Ma7VE6LfiecQWY6wIvi+rkyDPy0r6M6DNHmp8CFKRqcXWIB1zSPOJ357Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785690297; c=relaxed/simple;
	bh=5sJ9hl7U6NywExSKlQaosS2jKxVTyc77DMhD3po5/Co=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsuRtBIkD8/lIW2FMyOvIgoK0rvZHIFpSYzc17vgHicXQlIbdnIK9nn43PsNketgVgCJgL7OgxlER8EGf42uz/MnUa1SklJHdff+Nt+PuAgvzdJpfZzhTJNeMqLk9uZYyFuwc/8JGB3LDodIev7fXX0y2La2M1DW+b3gri808mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVRnb7Ba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVRnb7Ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C391F000E9;
	Sun,  2 Aug 2026 17:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785690295;
	bh=whlOKJ2KJDioAOiaCFJ2U5Y05ke+K0Fn4fxnzeBTT+o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fVRnb7BavLzQAt+CGdw3RYQ2sBqdURjBu12SJ4iFhvt+7Gq38xe38i9RR2yujH1vP
	 Y5BoVY986mI6Y2D6BD/8xcwYKwGAXZ1bVHYc03Js+/z+c4dIOvjvu85ePsGsMjs0bo
	 9EWYwzOCc7Chy3cTbjx/EahQ36npidecjXXCUEiYE7X5D3uWw5Kz04Gn9/8n+8UaWY
	 ZibbGHtlZdO4RP075A3pYpN+z//MQ82/bX1o31+KazSdnII3+jjdixjn2IMbeFOIE7
	 6cuZcVz7XOfmORrp17Rrc/Z//1NfvjLeYAI+bMcYya2Si2KkxXhwlwktjeIHMJU/g9
	 UxNWCFfaWR/Kg==
Date: Sun, 2 Aug 2026 18:04:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 u.kleine-koenig@baylibre.com, dakr@kernel.org, bhelgaas@google.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: humidity: htu21: Fix checkpatch tabstop warn
Message-ID: <20260802180450.33fbab86@jic23-huawei>
In-Reply-To: <20260802013333.12689-1-adinata.softwareengineer@gmail.com>
References: <20260802013333.12689-1-adinata.softwareengineer@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Aug 2026 09:33:31 +0800
Adi Nata <adinata.softwareengineer@gmail.com> wrote:

> Checkpatch warning:
> 
> WARNING:TABSTOP: Statements should start on a tabstop
> +        }
> 
> WARNING:TABSTOP: Statements should start on a tabstop
> +        }
That's an amusingly uninformative set of warnings.  I'm guessing
you cropped out the bit that says 'where' those are?  

Anyhow, I'd not bother with what checkpatch printed for this.
Instead just say what the change is and that checkpatch suggested it.

Thanks

Jonathan

> 
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> ---
>  drivers/iio/humidity/htu21.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
> index a9dbf08b4f1a..908661c64eb9 100644
> --- a/drivers/iio/humidity/htu21.c
> +++ b/drivers/iio/humidity/htu21.c
> @@ -105,12 +105,12 @@ static const struct iio_chan_spec htu21_channels[] = {
>  		.type = IIO_TEMP,
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_PROCESSED),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -	 },
> +	},
>  	{
>  		.type = IIO_HUMIDITYRELATIVE,
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_PROCESSED),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -	 }
> +	}
>  };
>  
>  /*
> @@ -122,7 +122,7 @@ static const struct iio_chan_spec ms8607_channels[] = {
>  		.type = IIO_HUMIDITYRELATIVE,
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_PROCESSED),
>  		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -	 }
> +	}
>  };
>  
>  static ssize_t htu21_show_battery_low(struct device *dev,

