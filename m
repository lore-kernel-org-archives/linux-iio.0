Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C679376A0D;
	Sun,  6 Sep 2026 03:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788667176; cv=none; b=uETFo8VBdtyGd4S2A5qyTN3Nl7JD/Jh4xj39UfUzxXgncmoI1LfHl6lZItrQgBZbbFfuHTY6RINgyXcb48a+yijThorh2ZdNaulmwd1OyfQdvrxfBe4jaqFO7cfvGykA99OqDDtKhgHewbNERUnvfX8UAofHSebnXt6AHI3eqNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788667176; c=relaxed/simple;
	bh=tpOBTkgwm34vmaOj6fGADkYGl1oS7L4L14EhHivTxNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3Qa5NukjTqdUob+as9YXCReplMTp25G+33D8XCKksqoSOU24NMME4yOPyr6+b1UGPTLI44npptleRyqT04QkpEfSLSFFuI8iQA8tEw2Ew71MRUci9zNlPj8u4iYdAVEtSpbpWKifs+H1Z70VlnDda2WHmV4GPLvXgV1lrufs1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0R9OhdC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0R9OhdC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9381F00A3D;
	Sun,  6 Sep 2026 03:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788667174;
	bh=nlEbUCH2XBeyiQyt5in7cjrJTml4RuflNdbvr6PEe7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a0R9OhdC9rOwpkBGD1JJFqDUYzFZ5NghcnNMqqdVjV+EJVT8ygv905Mc7ZYnfQE0g
	 rSDZj4xxHxYfVIQDQrBvSBF/gQoD6aYcnbz0Tdv7KOAJuDT0QG+XgyHyTbLxpajJBZ
	 jJgh8HkVOqK97YMezLCr+Pgw8pC8vmYTlmAcfVLomuU3cAvOIz3/5EHTy0+Olv8BcV
	 T1Ai+hLtaHUytYrVgHXcI/7grl8gMF8cewjPbzmvCytF6B8UzKnJCYDkeXPgn7054o
	 P4WNc7VrE5SHO/UuS9rc045XYZs1UyMklYUz/3MtmrddAIl7wiGxAd1qK7EaHJMWz4
	 Y6WeGXIFiQp1g==
Date: Sun, 6 Sep 2026 04:59:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH v3] iio: light: apds9306: fix default sampling frequency
 definition
Message-ID: <20260906045929.0a1c46fd@jic23-huawei>
In-Reply-To: <20260904-apds9306-v3-1-4f668393c2ae@jacques.com.au>
References: <20260904-apds9306-v3-1-4f668393c2ae@jacques.com.au>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Sep 2026 11:19:48 +1000
Tsz Shan Chan <tsz.chan.dev@gmail.com> wrote:

> APDS9306_SAMP_FREQ_10HZ is defined as 0.
> 
> According to the datasheet (Broadcom AV02-4755EN, page 11,
> ALS_MEAS_RATE), bits[2:0] set the measurement rate:
> - 000: 25ms  (40Hz)
> - 001: 20ms  (20Hz)
> - 010: 100ms (10Hz)
> 
> Change APDS9306_SAMP_FREQ_10HZ from 0 to 2 to write the correct value
> for 10Hz.
> 
> Datasheet: https://docs.broadcom.com/doc/AV02-4755EN
> Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Tsz Shan Chan <tchan@jacques.com.au>
Looks correct to me, but as driver is only a few years old, I'll leave 
some time to see if Subhajit is still about to take a look.

Jonathan
> ---
> Changes in v3:
> - Move datasheet URL to datasheet tag in the commit message
> - Link to v2: https://lore.kernel.org/r/20260903-apds9306-v2-1-e8673986ae56@jacques.com.au
> 
> Changes in v2:
> - Add datasheet link to commit message
> - Remove blank line in the tag block
> - Link to v1: https://lore.kernel.org/r/20260903-apds9306-v1-1-3f892aa4f156@jacques.com.au
> ---
>  drivers/iio/light/apds9306.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> index f681b02e4922..7dd41136734f 100644
> --- a/drivers/iio/light/apds9306.c
> +++ b/drivers/iio/light/apds9306.c
> @@ -61,7 +61,7 @@
>  #define APDS9306_NUM_REPEAT_RATES	7
>  #define APDS9306_INT_SRC_CLEAR	0
>  #define APDS9306_INT_SRC_ALS	1
> -#define APDS9306_SAMP_FREQ_10HZ	0
> +#define APDS9306_SAMP_FREQ_10HZ	2
>  
>  /**
>   * struct part_id_gts_multiplier - Part no. and corresponding gts multiplier
> 
> ---
> base-commit: 940de590b839f71d6dc846160534bf202401b8b7
> change-id: 20260903-apds9306-bedba7b74e59
> 
> Best regards,

