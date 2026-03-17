Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0633946C;
	Tue, 17 Mar 2026 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732008; cv=none; b=qCDaKIAmmI1WDUQg2Z1b8KqwpJ8AjVEDg1KSXaXsvUjQrNbYw/BJeIzJJhyIWZq1nNbPE7V3kozICwbfYgR9sDxy/lc2mUVqwuHjMS3SE+v+xsCA6ikswBn34zWCWAOeAYDC1LMNuohrMqT5QcntbWfq+705cAeiDujU1todrV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732008; c=relaxed/simple;
	bh=17I5AKEtPfO6q1JpSx7o444U78m/ylhWetYIHxoJrVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOVvizo2bp28estDQjSSfpDnCha4nqqX/D2kKr6gfOVMmWGApYsjlLDP7YWLGTgm8uLEjdnyQ7lIRqj3uQ9o1dtHySJA1gIjzBoNA70qEF+Dakqa5gScihW/sKkWYoXbBPNlt0x7hU0eXy2Buxr/KtaoknAAjUyj6QEGPpc3AYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLqi2nMA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLqi2nMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC5AC4CEF7;
	Tue, 17 Mar 2026 07:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773732008;
	bh=17I5AKEtPfO6q1JpSx7o444U78m/ylhWetYIHxoJrVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OLqi2nMAr3/yjGI1CEf55AQzxtWZQHBfq3ZtYK6XldbJeRf8M2hdq+OjuOMngmD7e
	 /jRToatryzClCtsvv+26TqQ2XPymbuj+mehC8NM1QShs5FQUVvIrUYubfH1EkdRYS9
	 Afnd30zPqPANGeh2QN7nIcDKsktKCcpSwVhAoHQEPYMCXdD+lWYA4spJTkWtKtQsRC
	 C79sxiDrr8g9QLRL6Hqr1KcEUztxCgT3I0zXSpHjpHeaEJoqvsCtjMlhotf2gfhocS
	 A+WMe+Zm6xb+nFcOR2vJyKa6TTn2M13EDZN4LhYCEabxuD2oe14jj0ETn5FGYa4Zb3
	 6GD1bR0Fjs2wQ==
Date: Tue, 17 Mar 2026 08:20:05 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 1/7] dt-bindings: iio: light: vcnl4000: add regulators
Message-ID: <20260317-tricky-pony-of-assurance-7a8cac@quoll>
References: <20260316-vcnl4000-regulators-v4-0-854fc2eaf54b@gmail.com>
 <20260316-vcnl4000-regulators-v4-1-854fc2eaf54b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260316-vcnl4000-regulators-v4-1-854fc2eaf54b@gmail.com>

On Mon, Mar 16, 2026 at 07:19:45PM +0200, Erikas Bitovtas wrote:
> These sensors can accept 2 supplies - one for the sensor and one for IR
> LED [1]. Add supply properties for the sensor - 2 for the sensors and
> one external, for their I2C bus, to ensure the sensor is powered on
> before proceeding with setup.
> 
> [1] https://www.vishay.com/docs/84274/vcnl4040.pdf
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> index 2ba4d5de4ec4..a1b4c02db246 100644
> --- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
> @@ -33,6 +33,10 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  vdd-supply: true
> +  vddio-supply: true
> +  vled-supply: true

Same comments as before, I do not see improvements.

Best regards,
Krzysztof

