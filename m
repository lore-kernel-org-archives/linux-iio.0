Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECAA448BB5;
	Mon, 12 Oct 2026 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795529; cv=none; b=obSz3PgvipBOweZTC9LqKGpXywyWa07++o6uXZGKc+LkeXlwAeRoozTFsFzkxsL9yRCRj3QGfg0J76gLD4y9gga07chcO873RTN913/vjiqTJgTr0sIt/DrCQIdsO3zah11eKVKEfGozmssj9ebissgU+aRB8V5fNdmUGPwJcek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795529; c=relaxed/simple;
	bh=8DoM/RXEOMr0w6SAeoQ8iCMLQlUl3p3BIgxBqbF1d7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIHlO02eCjy3vDk51vCODom120L8LhQJtW1UkTkSjH++MALm/HpJ67ntiGkUBDiaXCM8c45fZ9gePSOJUxmZNIDRnti3AufexWi8nWhr/pnfBjFR9FYFpdWF/bbU+3/bhwaFKWSfAg/dELHmwXXrlTvE4sGMC4o7W5tv2goJWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuFwTklA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuFwTklA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0049B1F0089B;
	Mon, 12 Oct 2026 08:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795528;
	bh=ZRrpXlZVBxlU63mvWOsUagGqRAtWsfWYgXUjUuqdSak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UuFwTklA8D2qBGoRM0a1IjSIVQq9exRRth9ZUWcP0qBtHWq8VnAxUpuSaO21q9ndU
	 DdcC5vHDAXd7xBJ4SX1S3qSepfX74Xe6gj9EphSaHsiYoNsuSY10PR/+zYIRAI9oPZ
	 EI7ZdOzecsXg/0+mk7llmGPidhKiReNlszvI9klIWGQVLLK2jttn26CjkLvoYoRavM
	 IqzEU+MdX3T7x5QiuCsqVI9xV3DPwiivr54S8wzQeLe3aMVbHLqU6bL2M78lw4DPrh
	 8+F9beshSg65Sh6SsTNQxw+gqlRNVhMIncFn97lVkVZqaWnkl3/zQRZbf72nthz4Jw
	 rBQ5qunVbEkeQ==
Date: Mon, 12 Oct 2026 10:58:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts <joshua.crofts1@gmail.com>, 
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
Message-ID: <20261012-adventurous-corgi-of-fury-01219b@quoll>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
 <20261009-b4-inv_icm42370p-v6-1-e53884f185ff@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261009-b4-inv_icm42370p-v6-1-e53884f185ff@axis.com>

On Fri, Oct 09, 2026 at 04:12:06PM +0200, Kanak Shilledar wrote:
>    It has a configurable host interface that supports I3C, I2C and SPI serial
> -  communication, features a 2kB FIFO and 2 programmable interrupts with
> +  communication, features up to 2.25kB FIFO and 2 programmable interrupts with
>    ultra-low-power wake-on-motion support to minimize system power consumption.
>  
>    Other industry-leading features include InvenSense on-chip APEX Motion
> @@ -28,6 +29,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - invensense,icm42370p
>            - invensense,icm42600
>            - invensense,icm42602
>            - invensense,icm42605

Why aren't the interrupts required?

> 
> -- 
> 2.43.0
> 
