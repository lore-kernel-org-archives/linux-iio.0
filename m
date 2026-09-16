Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79A9463B89;
	Wed, 16 Sep 2026 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574434; cv=none; b=HRorgyxm0GWXT0wNHRXQPymM2E9EGBZZI6se33lGdHB1lnyg1VWMVXVHXeYlX5mKU1K6w0OeTUe+NZQbvBj56IONbEOOisj9xYp1HBNfo7Yqg3tKzIqpVjILTDTPflmXUBw7EZDfCp5HZv7pchnpU6SkD1JYv94QK8rS8q6Jbes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574434; c=relaxed/simple;
	bh=JSJRxy1ff5Wxo8AgsZLPdjck0U4/HiK7NpCm9ikDttc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTdliBchkftUVNgHwTe7rLCtGP22y8+FW8IXV3wukXbP51Db56vC/zunhR64PZxFBhNo4G55zX5ZMfL6OvhLWb44zJ7WbeFWZNvuGBa0qPQUst7QDwMLY+FvQWcNsttr+KD+fvMpUaJ6BGlVjQS2d3/08FLaKpMNb5CpH5KHf40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I12MTJOT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I12MTJOT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C11E41F000FF;
	Wed, 16 Sep 2026 16:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789574427;
	bh=tXUO3hhV/BcO6ha7fR2Plj/MRzQoCVi1BPi8atnSIQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I12MTJOT66US23SmiJO/WTr6I7ThRFkI8hLhlaahj6gJ6L9WhZk3MDfMGc+1jg0kC
	 WWV7G2wAEngHUTkZsLx/tbAu4Crog7wX7pOvjYxZn6wfnrg9qnIGfoGiPSXAVaUVdK
	 G+gC+3F73J3d+QyILDA3tHpz9VA/26FaVjDt5dfsaRstHAQ3c4zMpLgajgOqnATwoo
	 9RJ/37zvHLA9VL5Gq36Ou2VAMG2QXPT6J86+Ywufd44l/7KAtweIWIK1Io1FNh8Y+U
	 CeCgFEr0ZRCgLtwHKm+OHO3pvOtZc1oTBWvssOUcR6fjUrAENtFIq7FdcZ/V61egvH
	 70Y6H1+NHUeKA==
Date: Wed, 16 Sep 2026 11:00:25 -0500
From: Rob Herring <robh@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 09/15] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <20260916160025.GA382310-robh@kernel.org>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
 <304d10f12a3418fbd5598160609a6eda09ed4100.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <304d10f12a3418fbd5598160609a6eda09ed4100.1789494473.git.marcelo.schmitt@analog.com>

On Tue, Sep 15, 2026 at 04:14:44PM -0300, Marcelo Schmitt wrote:
> Document how AD4134 chips are connected to the host SPI controller
> according to different wiring configurations.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v1 -> v2:
> - Set default for adi,spi-mode property.
> - Added '#daisy-chained-devices' property.
> - Documented constraints for adi,spi-mode + #daisy-chained-devices combinations.
> 
>  .../bindings/iio/adc/adi,ad4134.yaml          | 51 ++++++++++++++++---
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> index ea6d7e026419..012e09decf7a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> @@ -131,6 +131,26 @@ properties:
>      enum: [ free-running, gated ]
>      default: gated
>  
> +  adi,spi-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
> +    default: no-cs
> +    description: |
> +      This property indicates the SPI wiring configuration.
> +      * no-cs: The datasheet calls this "minimum I/O mode". In this mode, the CS
> +        line is not used (tied to GND).
> +      * 4-wire: Specifies a conventional SPI wiring configuration.

Absence of this property should be conventional mode.

> +      * one-channel-chain: In this mode, the DOUT0 line of one chip is connected
> +        to DOUT2 of the next chip upstream in the chain. Only the data interface
> +        of the upmost device in the stream is in direct connection with the
> +        digital host.
> +      * two-channel-chain: In this mode, the DOUT0 and DOUT1 lines of one chip
> +        are respectively connected to DOUT2 and DOUT3 of the next chip upstream
> +        in the chain. Only the data interface of the upmost device in the stream
> +        is in direct connection with the digital host.
