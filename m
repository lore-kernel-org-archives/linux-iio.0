Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9FF26AE5;
	Fri, 31 Jul 2026 07:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785481497; cv=none; b=Z6D6Rdc5GZAZw/QXuay5RLLrndtGcfLfRGGILj1GRw1bmwx04qPVWzSgtJwLDuKodRO80TPDk+ih9tQPvwaaZlXmLuXT0U8hV/6BUiQpuJB8PpZ1qMP+dlK3U8X6gtaF8/km/g2rt4nU14gXYfY/Z36HpRAWoGqi/cGg+DgdYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785481497; c=relaxed/simple;
	bh=uhNtV3JEPdKGrw2UTmPhfkW0Reb7N3XXWJFmYmwcW6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nA2pGo7jZYlGywH7wcZ+h3VKlQ3gqLSC+0jpo/MG+h/LN3fqqjZvz0Iz2Z++pO8Me9rQkXxLmJ4KTV8yzxX36iFQPRUbzGRYjwn6bvLlinMYJ2o/TpYH1jc8o7NFkWaAFJdeos8RbpttXQYy4l5Lb4zokeWWi5rxyPE5W5ff5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O21qK+kJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O21qK+kJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2691F1F000E9;
	Fri, 31 Jul 2026 07:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785481496;
	bh=XnxsLw3OL+eDkGCoxFjvciBlYVqPb7DmdtXm7fc3L3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O21qK+kJlYWjNPH9Av430CCdW+oyJF6KN0AEa3JSc2ti7r5GB11C+WbcqYeFa9shF
	 yHz8kcFol97UHigCpxqv7CVN62QObn47dCBbyy9lMGd+9rq8Q94oSU3XY+HPa7HfKw
	 M8Gfvja0VR/TPCNzG0fDNeM7Z0stiMeFi3DHiVM5XyM8t8rvmmtTDWPDXWEzFHBd2f
	 pjTQWH67xRfwuugZO9eMq3r1fA7O3F+QMwrxrzrHN6VnUIHLd1heTgW3SywZXIku0f
	 1rWvWaaUNZw+bwi3qb/UQK/KGxEL7MMnopTztXKIzLlzN7cwxW2FWGDsAbzpgelVRx
	 71d+f8EWe+v+A==
Date: Fri, 31 Jul 2026 09:04:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, andy@kernel.org, 
	nuno.sa@analog.com, linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, ciprian.hegbeli@analog.com, 
	siratul.islam@linux.dev, u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: adc: add adi,max40080
Message-ID: <20260731-steadfast-peculiar-bee-33fec4@quoll>
References: <20260730131738.822405-1-stefan.popa@analog.com>
 <20260730131738.822405-2-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260730131738.822405-2-stefan.popa@analog.com>

On Thu, Jul 30, 2026 at 04:17:37PM +0300, Stefan Popa wrote:
> +  vdd-supply:
> +    description: Power supply for the device.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: ALERT output for overcurrent/undervoltage threshold events.
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Value of the current-sense shunt resistor connected between the IN+ and
> +      IN- inputs. Used to scale the reported current.
> +
> +required:
> +  - compatible
> +  - reg
> +  - shunt-resistor-micro-ohms

Supply is required

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@20 {
> +            compatible = "adi,max40080";
> +            reg = <0x20>;
> +            #io-channel-cells = <1>;
> +            shunt-resistor-micro-ohms = <100000>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e087673237636..e1170230c4bb2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -28893,3 +28893,11 @@ S:	Buried alive in reporters
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>  F:	*
>  F:	*/
> +
> +MAXIM MAX40080 CURRENT SENSE AMPLIFIER DRIVER

Honestly, how did it appear at the end? Do you see any other
commit/patchset adding it there? No, so this should raise questions on
your side.

Best regards,
Krzysztof

