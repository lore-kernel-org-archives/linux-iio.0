Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13EA3101A2
	for <linux-iio@vger.kernel.org>; Wed,  8 Apr 2026 15:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663723; cv=none; b=fy3lMUJpY6yVY/FD+iWBDwS0OEIk5bYX4aKgYnbCMW5e7sb7H9Wdf4996UyziTYHX9qDR1ORrSSa1/hlr7SrLe7OzDFZyyry7P4zFaeHOfZ+Dt3qLIsaBRZ2ulVDSC8TVs9JpqqYuIbFSV1ITnC0ae5R7fdkDtRe1RAmQmGozuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663723; c=relaxed/simple;
	bh=WH5gGFBYu/4oZCSaSlQXvcVc6c3vH+AYdW70h66Vt1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrxA6qxwaN1pa08qiaLM8YkD52i3ahgFBnrvyyl462DKB4m+5vMIbmCHg4iiKbK9gMmNNeAl/KfweO7pZ9weH0iLn6TFpTI7CZ1bzXcNRVLLV4WlrSxTuUMZ6Mcc2SVq4YL6OnwbamYChwmu37AkZHOrQNvEJTdPgj15puqk/Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSDCU87h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSDCU87h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317CAC19421;
	Wed,  8 Apr 2026 15:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775663722;
	bh=WH5gGFBYu/4oZCSaSlQXvcVc6c3vH+AYdW70h66Vt1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tSDCU87hnHX8jLxWRENTg7N/DTXJxEasITpjtGJ/p+3sMlY02Mp5XS3Yt9fjK76Oa
	 4FOztsBuGCMVeO4GiCwLG4wijYc5ke1zHFy5wQl1VjtUn91D+edhAaGMzv4MniZVId
	 YF5sKOE336jQ2vTvjInpBig8sHVGzkFgyYeL5RvqyRRvCPdxcLquenDGBCpJT23v7K
	 tiBoHKZbAIwm54gRVRfdrvUyaa7d8v+tejaLevY5+9JPvVmTKThgL8HQpkiW+l6qjI
	 SPV/rPVd7gLRRg1RIOHTOGK0xlxNxMAl537mmwF+qWvdwaMwPnS5dP+/LFPflFUatH
	 3gV2D7Zz5rrkQ==
Date: Wed, 8 Apr 2026 10:55:20 -0500
From: Rob Herring <robh@kernel.org>
To: Chuang Zhu <git@chuang.cz>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Marc Titinger <mtitinger@baylibre.com>,
	Stefan =?iso-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH v3] iio: adc: ina2xx: add INA236 support
Message-ID: <20260408155520.GA2256298-robh@kernel.org>
References: <20260315182304.613783-1-git@chuang.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260315182304.613783-1-git@chuang.cz>

On Mon, Mar 16, 2026 at 02:23:04AM +0800, Chuang Zhu wrote:
> The calibration divisor is not directly specified in the datasheet, but can be calculated:
> 
> I = Current_LSB * Current
> Current = ShuntVoltage * CAL / calibration_divisor
> CAL = 0.00512 / (Current_LSB * Rshunt)
> ShuntVoltage = Vshunt / ShuntVoltage_LSB
> 
> => I = (0.00512 / (calibration_divisor*ShuntVoltage_LSB)) * (Vshunt / Rshunt)
> 
> Ohm's law, I = Vshunt / Rshunt
> => 0.00512 / (calibration_divisor*ShuntVoltage_LSB) = 1
> 
> ShuntVoltage_LSB = 2.5 uV = 0.0000025 V
> => calibration_divisor = 2048
> 
> Signed-off-by: Chuang Zhu <git@chuang.cz>


> @@ -1082,6 +1117,10 @@ static const struct of_device_id ina2xx_of_match[] = {
>  		.compatible = "ti,ina231",
>  		.data = (void *)ina226
>  	},
> +	{
> +		.compatible = "ti,ina236",

This is not documented. Please add/extend a binding for it.

Rob
