Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A71A683E;
	Sat, 11 Jul 2026 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783812118; cv=none; b=adtSN2c6u6nIxWn7rz8mz7pLr/oV1NNtlyooNHU+fa4bSjfdDetplQ8UthdOc/ljrhQ7dsCdOupSMl6QClacyoqJTMS+cLZqQeLq1tZAza2vS0UKQ3cmjrulTLa/O+p2xUzE/wllz5bvZ9wk1T/7FFAHV4T4Zon8MpAReDAtT4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783812118; c=relaxed/simple;
	bh=wrBhNe5zK0DGMn7FyQjVcAvQ3NJ88J7HmOq0zGsvg+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B2vyjahJuEgoftfyjTUHTikbOMTrUEZ45VzsGAVNcTAlUgv7piB6BIntKPb2skBdKuipeBMxA01+2WBf0hDiQCe0mqnNohR12p2T+cP3krLbeQfS9DbzhjkKvFlbZ6uEJsOLXmTkYhn6vQDU0e3pLVpSq65gTaH/SLPWnv4FRLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+DoL4Gd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+DoL4Gd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B5D1F000E9;
	Sat, 11 Jul 2026 23:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783812116;
	bh=4y9mlAUzU//euoDavSm/IXRBmm37qV/V+UKa3QkyCl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A+DoL4GdlEdrpLLCFGAJcil/OFWRkKPS3OFEddPROmPpUN57FTjRPjxsiDyr+z40G
	 c2eBuuiobD59QttBH7Jc5BzhVzYV/pzhzCr269p3bhvG1pDBHA1xZVPDZdj2OW6lPD
	 zCbdhXu5z6EMJ8WQxnY0+rrEZbdyYpPficmBL3A83up/wEkmWps2vSRUQg1jABqHou
	 bAEYCX+OeNGMo2OW5Th7GyEYPzyYsO/9oMoyLWnGGqwQ2RSKVSVIfRU480GFfYnCnE
	 WBDds4ule/T1S+sLdaCpT9GjEk//DBBnHTcfv311ALoyJ8uf8MAOT6pE2if2EYlUjm
	 CW7dJTJAhBJxQ==
Date: Sun, 12 Jul 2026 00:21:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
 linux-kernel@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ti,ads1298: add ADS1299
 EEG ADC variants
Message-ID: <20260712002151.2bd22d0c@jic23-huawei>
In-Reply-To: <20260706112614.1262241-2-shofiqtest@gmail.com>
References: <20260706112614.1262241-1-shofiqtest@gmail.com>
	<20260706112614.1262241-2-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jul 2026 14:26:13 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> The ADS1299, ADS1299-4, and ADS1299-6 share the same SPI interface

Given mention of 3 parts, this description should say why only
one compatible is needed.

> and register map as the ADS1298 ECG ADC family but are designed for
> EEG and biopotential measurement.  Key differences from ADS1298:
> - PGA gain up to 24x (vs 12x for ADS1298)
> - Internal reference is always 2.4V (no 4V option)
> 
> Add compatible strings and update the vref-supply description to
> document the ADS1299 reference voltage behaviour.
That comment needs an update seeing as now it is removing description

rather than documenting the ADS1299 description.

Note Sashiko identified something was wrong around both of these -
glad it reads patch descriptions more closely than I do!

> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads1298.yaml   | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> index 71f9f9b745cbc..202776cee73ff 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1298.yaml
> @@ -4,11 +4,15 @@
>  $id: http://devicetree.org/schemas/iio/adc/ti,ads1298.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Texas Instruments' ads1298 medical ADC chips
> +title: Texas Instruments ADS1298/ADS1299 biopotential ADC chips
>  
>  description: |
> -  Datasheet at: https://www.ti.com/product/ADS1298
> -  Bindings for this chip aren't complete.
> +  ADS1298/ADS1298R: 8-channel, 24-bit ECG ADC. Max 12x PGA gain.
> +  Datasheet: https://www.ti.com/product/ADS1298
> +
> +  ADS1299: 4/6/8-channel, 24-bit EEG/biopotential ADC. Max 24x PGA gain.
> +  Channel count is discoverable from the ID register at runtime.
> +  Datasheet: https://www.ti.com/product/ADS1299
>  
>  maintainers:
>    - Mike Looijmans <mike.looijmans@topic.nl>
Make sure to +CC Mike (added)

> @@ -17,6 +21,7 @@ properties:
>    compatible:
>      enum:
>        - ti,ads1298
> +      - ti,ads1299
>  
>    reg:
>      maxItems: 1
> @@ -33,8 +38,7 @@ properties:
>  
>    vref-supply:
>      description:
> -      Optional reference voltage. If omitted, internal reference is used,
> -      which is 2.4V when analog supply is below 4.4V, 4V otherwise.
> +      Optional reference voltage. If omitted, internal reference is used.
>  
>    clocks:
>      description: Optional 2.048 MHz external source clock on CLK pin
> @@ -75,5 +79,6 @@ examples:
>            spi-max-frequency = <20000000>;
>            spi-cpha;
>          };
> +
Unrelated change.  Make sure to clean these out before sending a series.

Jonathan

>      };
>  ...

