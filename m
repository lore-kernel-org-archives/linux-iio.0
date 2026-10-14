Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F294EDCB4;
	Wed, 14 Oct 2026 11:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976944; cv=none; b=nvsnAxUR5i3JoQ7kVBDU771brQkHJSCLawwn/Zk8xJe1Zv1gg9WNEmjhXXVbTU3Was8hG3AC9XgSB5cUkQSiQecWY9ghswjD8UUtsL0UbN9Mc5q74/UyzbXQ86zOiheqt/i6iI9frad1OJfHHBDeXYTJa8J7lHIjUzN3PZrR1ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976944; c=relaxed/simple;
	bh=2N5PSE9hWuYg/wsB+vFoTdX6GXpcjs25nIYVouzXelY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/dU+0Z7fnna65ecmGbKHuc8Ga8srG/upazDQ0KZVPY4gJ7D8PhFSH5z65jLJcNDpfONqSlWKfQK/MVxjTTTWJssyVD4uQ0N8xKa5UOMpdPCyMtGFTFig1xgqARkvaDPMPFkJ0e2EikBoCiOZzJRJpMGaM7sEXmLYowFjVpj208=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWmPpIMb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWmPpIMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E2B1F000FF;
	Wed, 14 Oct 2026 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791976943;
	bh=KKQkUfZi/VTPdfLs3C+sLtwMk0vQtF5GEAW8t2hN4TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gWmPpIMbeLUo8+qpnrWjgp9HcOuHJr/Nn+IBASKIzUE05O1wsCEwadlajrzk3EbeZ
	 lipG9sTuwaUQzIqlj7tU9uZQqa109NRSi4V1pJufg1gBJZOUOPdvaq5D0OJHpkLfA5
	 POrNtvbv6wg57FTDmdM8YWF7zO6S0GK3ToZ90qaCR4lYRwkMlsDldOpkibByIQuOrt
	 kSoPTxHMsJCOluiLZtf+fX6MAHs5VmOv9RKdybHwFSCYYn4aVzoxEsxzRSa9V7fGAp
	 3p7QlzLOSL4sdxP3/SFv7y1BvxIv8Qx85XR1fK/HWK6Ghdq2Y6CL78m8Vngdsn7E3F
	 qS/xPCRksrnBg==
Date: Wed, 14 Oct 2026 13:22:18 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joshua Crofts <joshua.crofts1@gmail.com>, Shi Hao <i.shihao.999@gmail.com>, 
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: light: add as7343
Message-ID: <20261014-competent-generous-robin-22772b@quoll>
References: <20261013115639.167433-1-marcus.yu.56@gmail.com>
 <20261013115639.167433-2-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261013115639.167433-2-marcus.yu.56@gmail.com>

On Tue, Oct 13, 2026 at 07:56:38PM +0800, Chang Yu wrote:
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false

This goes after allOf: block, see example schema.

> +
> +allOf:
> +  - $ref: /schemas/leds/common.yaml#

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

