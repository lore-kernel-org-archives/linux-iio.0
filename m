Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B843CB576;
	Thu, 16 Jul 2026 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189233; cv=none; b=u5Rbt5YuUj7TbRC8M2abQhj6YDdIsozeo8FwXiQFM1EoEjCKHTVhiE+1MQcJF2/2Vl+Jq86LyPBDCVb0dgQIQAhcjqJDuKKm1L0vurcujLJmu8T19LaB1JnGe+mLLxSPuN9QB8MMJYweevbnumxmH+XNurpkpCye7hk4hjpArFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189233; c=relaxed/simple;
	bh=3euc3rrcHM9xQjVXaFi71cWWbjNkjKJKf+zAXyuh/5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKGy9S+77XAN+b7kDm5jwLYn3rq4IcwPuulsQw7HQlrwlAt4EtDEDNjXcHIA0cFHJTa9zfHkvL06k49Sm7zroIsxyWebBK+d9fDxdRj2H1ur0sBCvvLcCo710OVwP8TUIyi44cywfeemo6pm2zoR5jZlesE6A+rm4gfags7E1HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqJdjHhr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqJdjHhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D457F1F000E9;
	Thu, 16 Jul 2026 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784189232;
	bh=GLKYSKo6YYBAxpKmRcM7lNEjddv69p1LMtsZA+xP264=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OqJdjHhrWi1wIh+HBif6v0uiBu/TmvTfBka5x3WKar29aQG9VWUHQ58VnPnU2uUWI
	 Ahx6JOTUINoR8/1Z7bpXyBVOVwt52uno+idTS43QBQaluqcQ487QgBgkeeoJaMWBEF
	 VCl+1iTQJ2/TiYbLPcB7KZ0JgIkPMNqKidn54nrH75xFJiabqDYGeVKIFhSU1WAyJy
	 clQMyuj1tjQ24QTfi5IaUL2rEMq8OLSo5NMxfTmZVml/gbDy6/CWIIVO4hciEakVRY
	 TFuAXECIPIff9MZhKYbUeXPvmePTta43WCVqzQGqdf19T5Ecx5M/W/pQwsCqRoZmXS
	 zWrVJlRqjJyaA==
Date: Thu, 16 Jul 2026 10:07:09 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nikita Travkin <nikita@trvn.ru>, Maslov Dmitry <maslovdmitry@seeed.cc>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: light: ltr501: Add ltr329
 compatible
Message-ID: <20260716-adept-kraken-of-calibration-cddebc@quoll>
References: <20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com>
 <20260715-liteon-ltr329-v2-2-d18af55edab5@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260715-liteon-ltr329-v2-2-d18af55edab5@geanix.com>

On Wed, Jul 15, 2026 at 02:27:24PM +0200, Esben Haabendal wrote:
> LTR-329ALS-01 is an ambient light sensor similar to LTR-303ALS-01, but
> without interrupt support.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> index ab9bb68dd736..76e81eba7ea4 100644
> --- a/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltr501.yaml
> @@ -19,6 +19,7 @@ properties:
>        - liteon,ltr559
>        - liteon,ltr301
>        - liteon,ltr303
> +      - liteon,ltr329

Do not grow lists at the end, they are ordered alphanumerically to avoid
conflicts.

Best regards,
Krzysztof

