Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4926C1CEEA1;
	Fri,  1 Nov 2024 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488815; cv=none; b=lB3AIaq+PzXctUBj3nhU1E07eqgqFtnXBvjsi6kzPhaxN4S4FIqwOeNyAb20jY/ifXs7QEUgQtpip9DB5AjEkLI5JyV4WAESt8JnR06/+jQB9JSJLZbcdDZLa4hykVYvS3BX0Ga5Kav6UhJl2So4xSHt54xeD0Px00wED8HUWAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488815; c=relaxed/simple;
	bh=JfQadZqGyKfCRqhcNClpBZ1kfu6wd9bo/LpO7Ij7QKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBJWx65ZgIsRm5wcknbq0chGL9REwocWuyVLIgDrDYjRoCDeu9Ak+MyWO6j02GxtlO6SmQ+ZDYad9KZJmD1Oz385GRHz47Hur94JsvvZMb7ExJJSHnXSsXSO89GNmHh9Os6NhziKmPID9rnu9ICpJN0Izs9/O2n2gANHkitFxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaEtV9BQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaEtV9BQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C52C4CECD;
	Fri,  1 Nov 2024 19:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730488813;
	bh=JfQadZqGyKfCRqhcNClpBZ1kfu6wd9bo/LpO7Ij7QKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KaEtV9BQ1ivqTzNIbr4NL0dGSKok/lFYumcnJT4lS2qbEN83Dahxn6wokug+1gyX4
	 gOFwpqEDzXgEpmWDGonOVDrrJf2NIe+CMJuP7Xb40AfYwtmDTAtmmfk8MNx/N44ktq
	 KSuesodhSCbW7Xn+9hM0zX+U7NJpn+5LtcgCKDfQiFBDVYYwlyEdyEUQpw/PQ5qKQM
	 S2OneSv/pSDajEJA73oIKUEgMb5InoCco1Mg4B6cL4Rs4ci2w5eLn2CMltOL/i1P4d
	 SN0qSn4VSmsDCnXDQH1HQ2trDRGFDjMl2auLdfntA8/V0AawZlpIf5cV8hq/mV+cGY
	 /KMt4kvfgmfWg==
Date: Fri, 1 Nov 2024 14:20:12 -0500
From: Rob Herring <robh@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Dumitru Ceclan <dumitru.ceclan@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: adc: adi,ad7124: Allow
 specifications of a gpio for irq line
Message-ID: <20241101192012.GA4052854-robh@kernel.org>
References: <20241028160748.489596-6-u.kleine-koenig@baylibre.com>
 <20241028160748.489596-8-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241028160748.489596-8-u.kleine-koenig@baylibre.com>

On Mon, Oct 28, 2024 at 05:07:51PM +0100, Uwe Kleine-König wrote:
> For the AD7124 chip the logical irq line (̅R̅D̅Y) is physically on the same
> pin as the spi MISO output (DOUT) and so reading a register might
> trigger an interrupt. For correct operation it's critical that the
> actual state of the pin can be read to judge if an interrupt event is a
> real one or just a spurious one triggered by toggling the line in its
> MISO mode.
> 
> Allow specification of an "rdy-gpios" property that references a GPIO
> that can be used for that purpose. While this is typically the same GPIO
> also used (implicitly) as interrupt source, it is still supposed that
> the interrupt is specified as before and usual.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index de49b571bd57..71a40c7ca4bf 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -37,6 +37,12 @@ properties:
>      description: IRQ line for the ADC
>      maxItems: 1
>  
> +  rdy-gpios:
> +    description: |

Don't need '|'.

Otherwise,

Reviewed-by: Rob Hering (Arm) <robh@kernel.org>

> +      GPIO reading the ̅R̅D̅Y line. Useful to reliably detect the interrupt
> +      condition.
