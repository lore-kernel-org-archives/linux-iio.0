Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9C82E7F39;
	Tue, 12 May 2026 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587735; cv=none; b=H39cHmqpDUdaxgUF+1cNOiNXxbMPdPLGE3tF3B1unbRWt2V/44AESveb8XLo6L8k7GlKQYnBSdRIRybiRgsDVkOjgQxaicYELnHYLDnyss5mkdL7BhLi7lRGhZ15VsW0SMNJjlmd2HfvTBNYXMj26goz8trBDdMKtnfgThrp8Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587735; c=relaxed/simple;
	bh=4VEx39AnhihQJ9U9nCbWkONe+7+gNR7uRlZdscnVeTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Id57E5ltq+63z0tXIDjW+j3uFLpctOrW7WI/FPim5by2f0F8XF6p8ITspn+ji/btUxE7j24+fPCXRQeFdx01VNn88i/dClZeMMq7lPgSQulvT1vqYWdQo2THHz6rfUPsp5FgYGpp8QOv9fdKFB5HVsu6Fg8nl20ll2adRaSmwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/fVX7Lu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/fVX7Lu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9EAC2BCB0;
	Tue, 12 May 2026 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778587735;
	bh=4VEx39AnhihQJ9U9nCbWkONe+7+gNR7uRlZdscnVeTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b/fVX7LuntrcToQxb+bChtq/4N1jfXNivu4tnoc+Uu/GXuhe6Ba3qwdKjLLJNznzr
	 WlyajhwE7R5qSo1zPz8PozYYJfWZQWXoQmHflm7yWE4QgKu34y8uzwefPFLPhkKMgD
	 rVMjXFkRRY9Cxl7UslKal5MtJseYMmbRaN5bW927esDfZbb5gEn7ywA3R0UXa48XY6
	 tRPeiXhgZkfZbVT5za0OSKDSFDIGQbiUF/j8AAvw8nqrIWDN3qRuQyqcrHkrKDc39l
	 Yr/Bh+WbjwRJzXgrZfYzcC95w/C9eTjHm0Pu9hk3QVhn7JKUs3ab+R1b/97t+pxqa2
	 G0dmQzIAha+rA==
Date: Tue, 12 May 2026 13:08:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 v8 03/11] dt-bindings: iio: adc: hx711: add RATE GPIO
 property
Message-ID: <20260512130845.2c3ea1c1@jic23-huawei>
In-Reply-To: <20260511174342.123820-4-piyushpatle228@gmail.com>
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
	<20260511174342.123820-4-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 23:13:28 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Document the optional RATE pin GPIO used to select the HX711 output
> data rate.
> 
> Update the example to show the property in use.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
Applied to the testing branch of iio.git

thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> index a8eaa1f18de5..9134bbe41379 100644
> --- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
> @@ -37,6 +37,13 @@ properties:
>      description:
>        Supply voltage for the on-chip regulator (VSUP).
>  
> +  rate-gpios:
> +    description:
> +      GPIO connected to the RATE pin. When driven low the output data
> +      rate is 10 SPS; when driven high it is 80 SPS. If omitted the
> +      RATE pin state is determined by the board wiring.
> +    maxItems: 1
> +
>    clock-frequency:
>      description:
>        Controls the SCK bit-bang timing. The value is used to derive the
> @@ -61,6 +68,7 @@ examples:
>          compatible = "avia,hx711";
>          sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
>          dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
> +        rate-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
>          avdd-supply = <&avdd>;
>          clock-frequency = <100000>;
>      };

