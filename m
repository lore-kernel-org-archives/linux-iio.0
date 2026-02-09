Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59766332EB7;
	Mon,  9 Feb 2026 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770624169; cv=none; b=SNn3aPYDM3s9u1R9Sezv3xRTqJkq1Io29htBbuWrYEYB7tKhcB4FAkT8SsQol/XuS48Zn/sPvn5/FUH0kyTYExJ4Pe0/ZYj8c5BFwsygq1mtk2Y5oy40PT1b+weBeVi/1TqBdIPRbwo8MUi9RjJYLR6sLdtBFJI5uksiek0yPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770624169; c=relaxed/simple;
	bh=5IltqV2phVSHgfzKUFG56gdUorRF6ZM81UajNODgFDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upH0kWx2HkSOju6hkCkygO0pPlqrRLB/JNfiHtelriM8c7bOn3Vp8HVdrvk7RgStOPx4sPCtobz2fLPuWjhwVQ8kCVKlyOthR2rAC6blxh6cX5skKZnwQC7EIWp3XTV7NyQyszAk250uvP0UF1V5y+9xKYviIbwra3JB/To1p/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaVkQmw+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaVkQmw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6994EC19422;
	Mon,  9 Feb 2026 08:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770624169;
	bh=5IltqV2phVSHgfzKUFG56gdUorRF6ZM81UajNODgFDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UaVkQmw+c7CFGaVoTWBoLL2MY8vwNspF3DtSJynNxwf9hXsedC7IOwofpYoY9Nnu+
	 X4aVErUB9UrlAuHsjvWQszs6phX2a7XSh7Q+6qTD09iEAF5ttiLEHMCHVv0NPruohg
	 LMBgOtFvCxR7tAHolhIPPr1yG+Yei0nxszSfsTvvsinFhJe/k2fekhF27npCHzfQbE
	 8K6VqPNv2v22Yyi9RiI1N3dFiYGKW61zbF2O53R8Dcsr//dCErf0NiWwGE/cN1hOVc
	 4TgR1FaagMteO9b7soG08aLdIWK277Y262eFh1OGgNEOabdbj2E1As2sjv+DyWGlou
	 cDsaQMPR2Op7w==
Date: Mon, 9 Feb 2026 09:02:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: proximity: hx9023s: support firmware-name
 property
Message-ID: <20260209-masterful-fluffy-pegasus-bcc0de@quoll>
References: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
 <20260209-upstream-20260219-v1-3-2b4d74e309d1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209-upstream-20260219-v1-3-2b4d74e309d1@gmail.com>

On Mon, Feb 09, 2026 at 11:37:04AM +0800, Yasin Lee wrote:
> Add an optional firmware-name property to specify the firmware file.
> If not provided, the driver falls back to the default firmware name.
> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
> ---
>  drivers/iio/proximity/hx9023s.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> index eb4902d18d74..b680b89956bd 100644
> --- a/drivers/iio/proximity/hx9023s.c
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -1089,6 +1089,7 @@ static int hx9023s_probe(struct i2c_client *client)
>  	struct device *dev = &client->dev;
>  	struct iio_dev *indio_dev;
>  	struct hx9023s_data *data;
> +	const char *fw_name = "hx9023s.bin";
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -1111,6 +1112,10 @@ static int hx9023s_probe(struct i2c_client *client)
>  	if (ret)
>  		return dev_err_probe(dev, ret, "regulator get failed\n");
>  
> +	ret = device_property_read_string(dev, "firmware-name", &fw_name);

Incorrect order of patches, see submitting patches in DT dir about the
order - documentation always comes first. This is here an undocumented ABI.

Best regards,
Krzysztof

