Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11B934A795;
	Thu, 29 Jan 2026 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769707536; cv=none; b=TqRm7MRytpY0EyhDPLgdFrGaAuIHJxUE/ma1TRYDyQhcdgtgvGu9ZCL6SwKD3V0QXC8YPO2GeTyYM2MT/1WmFhSJVwfWZumH1MJy0SAuetEK6OJk5E8yssgztB0uoylUTHNqADBZ/8DCc8JPhCj77tzvMHBji/i7gIpLnqwEZ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769707536; c=relaxed/simple;
	bh=u33iJL9iX9oqrECl7tJt0WsDnVX3vqArStViff41WRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX4MgEYAgKpNC6jjaxB/12Mkf9Ts54O/qZqKo10axo6PpDAx3sikFU2lUO1DtGZ89pnYZzbowj5zXCXNF2Ajqr51Ft2DJMUqwGMtiOaEet/CI3LqjdV95zKfUYsmWKGMO44DFse4g4duDHOoyLql4m4bkc/fsrpngJ0pN0hSMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKFXwlsA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKFXwlsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74209C4CEF7;
	Thu, 29 Jan 2026 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769707535;
	bh=u33iJL9iX9oqrECl7tJt0WsDnVX3vqArStViff41WRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKFXwlsA+PedrrKplcNJQXP83LWlW13zb9s2++yNBmMeDOkH3eQwBg2mhLQv/v46N
	 z1gGh2AbRCkpYL7X3XATn4NHsrzV3L+M6fEjen7kypC9Fc1ou1XBzS9KECku52uRme
	 9ToncubP0cl19peuWdCn6M41pYglqw1gEZODiyAyuyBF//8adwCmnE9pC+3/+ZRPm9
	 mjCQhc8QvO9U4MNSMxyhZj5/GpfXHqqOxpfV2VFckUtrT+AIB6+48HYGN1hsmxyAtl
	 yOzSRvmLn8BsfLTjjs3sjRICpFe4vptCqu1E8mZviUx8ZS8yRGy5bYJ29cNp9pCa2T
	 SJjDM4msB0rUw==
Date: Thu, 29 Jan 2026 11:25:34 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Liam Beguin <liambeguin@gmail.com>,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: adc: ltc2497: add support for ltc2305
Message-ID: <176970753412.1308819.6793816713940702479.robh@kernel.org>
References: <20260126-add_ltc2305_driver-v3-0-951349a87f97@gmail.com>
 <20260126-add_ltc2305_driver-v3-1-951349a87f97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-add_ltc2305_driver-v3-1-951349a87f97@gmail.com>


On Mon, 26 Jan 2026 09:29:41 +0800, Kyle Hsieh wrote:
> Add documentation for the 2-channel LTC2305 ADC in the
> existing ltc2497 binding.
> This enables automatic device tree matching for LTC2305
> while using the LTC2309 driver (drivers/iio/adc/ltc2309.c),
> since both ADCs share the same I2C interface and 12-bit SAR architecture.
> The main difference is the number of channels (LTC2305: 2, LTC2309: 8).
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

