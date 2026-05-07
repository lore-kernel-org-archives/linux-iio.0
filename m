Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DBD3AF672;
	Thu,  7 May 2026 14:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778162852; cv=none; b=IorjQi7SgRT4J6rHVJROqHYNBHoAtnODLJDfluteTozy8i7Hvnka0JENJ8P2g+MqnsDD5fbSGiroRMu7iMrDeS914PDSyjjfYfFQz1fia0004mFYB7NzozGJ/9L9EMJx0ZCVUcxoEAHt6HERNhf/hwVBV5r3jCd+ssTd/5mU4a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778162852; c=relaxed/simple;
	bh=l04xFz3qjUvvFhThYFTAaGZJ/bj3RB1pt+KMn4lMP3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTBNugyLlUuJjHfe9AF+2QI4S4UTPtRvOyveNmEryZAO43nTOQg5jq2Tejcjy1FBGKo7NdbNqJERrRSsDad6SkmYSbbyKzAunadou7K8rqYNOeBb/+plRe4oWve6wV/2N7aH3AtRHpkH9jOeVwEb7nhRQoZeBBHrCMgS1ulfMzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re/NnGX/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re/NnGX/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F94C2BCB2;
	Thu,  7 May 2026 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778162851;
	bh=l04xFz3qjUvvFhThYFTAaGZJ/bj3RB1pt+KMn4lMP3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=re/NnGX/hd7uW/bO4cYyMiTKKCzuwncRxtk6wFG1LIeK2gzO9PLd9pK2kUCZN9DR0
	 vqiCgCc/wd8gqXTLCiJn2bDBxeYa0j8ir4l6zA0AGPVsaJs4/I7of+sYz4GTV5lI9K
	 33TFc9qCG9Rj8eaH9g9RWqA1HRCBs+iUVTh6ib+GAazQYl2yoF/09YGLqUjFhemoZV
	 UlPjzJ6cldNZWXgy/Q6SwZf3qnMimi6glTtaGAmCYm+7JWobz+lWunMWfBVm7pxwrb
	 SzhHWZRFE0XI0rxKYLnw2RcVRYsXJE46jfH2EnaMrbP2MktGBFHkd4YVRFCfwEjTqF
	 bh4TI1B9Y0jNg==
Date: Thu, 7 May 2026 15:07:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Uwe Kleine
 =?UTF-8?B?S8O2bmln?= <u.kleine-koenig@baylibre.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: fix CS held asserted after
 single conversion
Message-ID: <20260507150722.2121398a@jic23-huawei>
In-Reply-To: <LV9PR03MB84144C0FF2FC2197AAFED941F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260428-ad_sigma_delta-fix-v1-1-8e3f925ee8d2@analog.com>
	<LV9PR03MB84144C0FF2FC2197AAFED941F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 May 2026 12:17:25 +0000
"Sabau, Radu bogdan" <Radu.Sabau@analog.com> wrote:

> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -442,10 +442,10 @@ int ad_sigma_delta_single_conversion(struct
> > iio_dev *indio_dev,
> >  	ad_sd_disable_irq(sigma_delta);
> > 
> >  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> > -	ad_sigma_delta_disable_one(sigma_delta, chan->address);
> > 
> >  out_unlock:
> >  	sigma_delta->keep_cs_asserted = false;
> > +	ad_sigma_delta_disable_one(sigma_delta, chan->address);
> >  	sigma_delta->bus_locked = false;
> >  	spi_bus_unlock(sigma_delta->spi->controller);
> >  out_release:
> > 
> > ---
> > base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
> > change-id: 20260428-ad_sigma_delta-fix-bb65d56ccbb0
> > 
> > Best regards,
> > --
> > Radu Sabau <radu.sabau@analog.com>
> >   
> 
> Hi everyone,
> 
> Uhmm..., why was this fix marked as Changes Requested? Is it something I am
> missing?
Looks like I missed in patchwork. It has been applied.
> 
> Best Regards,
> Radu

