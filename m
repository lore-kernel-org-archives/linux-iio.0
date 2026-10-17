Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422E4CF48F;
	Sat, 17 Oct 2026 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792270027; cv=none; b=HseaObrvjVFv0z7aGkvLJRw3duhzSoujskpt+MCRnjB4Xq14U4wbt4nqstpnRLhdw4oBtdsA0SmCZuv8k+dR6AG1rTGw6vNeu+voh5VfJbic3cvo9x90Cwi4d2Tnxb3bMNfwMH8cZLC5p+yZ8fQLxCPnACQEUn8SYGBAabftvYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792270027; c=relaxed/simple;
	bh=wUoqZdb2r+2sTvZX6x20usYJBzFuwGv+cIphSSS+MDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzRrTXFzjp5LzEnKVzuAipqihFfzgRPre3VPN+JjZKcV6XvnyWZN8kA+0RnJAlgI6kfEsH3kHJFXK3jjwi8iChAiJ8Vjm9v2WVHoemCdytL1TftfPalUPbqtgxyYko0sqWuT2WwVKYtu1BBVy1upRZBp21YfWmj5UP14CjUnlKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJZ2tVmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJZ2tVmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549ED1F000C5;
	Sat, 17 Oct 2026 20:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792270025;
	bh=I5BZvUZg/QfJ8IxO+tSKA4C8RblY0tRzvt1GZI4LJOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aJZ2tVmV2F1kyM8jrDpt06qS5sc4c2PcS7bMAoyZPeHJExMVY05g8CMhIpNFo5IYs
	 865C1hGzjN9hpQI4wPTFxJyY1WG59xwcnOss+03oWob09BehcR1kw4q6AVyjmghHf/
	 BzjuP27ChiyeoQmuPI/PtCAEVz6GHeCKC9aLCRGJG/hjYJDGPMeIOP2FaKJZdBotoH
	 vpHAAxta9EiY2RbB+QOFrkrirGq+o+JKDxRQ2dpXzoTppajuI2mZDiSSZaus3ZuES2
	 Epvvxszg/sF02vD1i+yx7eXYDixSTTuPf/hsH0tK+/UFUONyLxkFMRui+Rsuv4Nb0m
	 9w8ztSTmfQGDw==
Date: Sat, 17 Oct 2026 21:46:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Joshua Crofts
 <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v2] iio: ccs811: Deassert WAKE GPIO on error paths
Message-ID: <20261017214659.5bbebc38@jic23-hlaptop>
In-Reply-To: <20261015123023.3417-1-nikhilgtr@gmail.com>
References: <20261015123023.3417-1-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 18:00:23 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Ensure the WAKE GPIO is deasserted when status polling fails or
> the data-ready timeout expires. Early returns could leave WAKE asserted,
> preventing the sensor from returning to its low-power state and
> potentially disrupting subsequent I2C transactions.

I need more on this point to know whether we care if an error
means we don't deassert the wake pin.

Why would failing to go to sleep break future transactions?
I'd kind of assume we'd awaken an already awake device (which sounds
idempotent but maybe not?) and carry on from there?

Jonathan

> 
> Route error paths through a common cleanup label to ensure WAKE is
> deasserted before returning.
> 
> Fixes: c6644f7201f3 ("iio: chemical: Add support for external Reset and Wakeup in CCS811")
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/chemical/ccs811.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index 998c9239c4c7..dad54f66ebb3 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -198,18 +198,21 @@ static int ccs811_get_measurement(struct ccs811_data *data)
>  	while (tries-- > 0) {
>  		ret = i2c_smbus_read_byte_data(data->client, CCS811_STATUS);
>  		if (ret < 0)
> -			return ret;
> +			goto out;
>  
>  		if ((ret & CCS811_STATUS_DATA_READY) || tries == 0)
>  			break;
>  		msleep(100);
>  	}
> -	if (!(ret & CCS811_STATUS_DATA_READY))
> -		return -EIO;
> +	if (!(ret & CCS811_STATUS_DATA_READY)) {
> +		ret = -EIO;
> +		goto out;
> +	}
>  
>  	ret = i2c_smbus_read_i2c_block_data(data->client,
>  					    CCS811_ALG_RESULT_DATA, 8,
>  					    (char *)&data->buffer);
> +out:
>  	ccs811_set_wakeup(data, false);
>  
>  	return ret;

