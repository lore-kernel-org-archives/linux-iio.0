Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC8A175A68;
	Tue, 12 May 2026 18:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610701; cv=none; b=oodCen8ZZzFJlSA+qTW7s1tz+k87/WIYPGV1TgKwTxGOSBGHGcpNtJHr7lacgs26R83Aw7psAbXt9vQiY0WkMByQFzCEo7elN+D8QVZopd2gnFNIsf7BCi9448Un3+onvv8Pt8B6nZuWgNcEcdfylQzKGbtrqR1ld5zvI7gw+oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610701; c=relaxed/simple;
	bh=9l9QZTn3VGCPwjw6uCXUYbXBEV1oYKl//ROhoakHyKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLI5QAhLUTfZPep/XpJ69XS534K1BjCFnGY2f90aXwrATB+tIxFCiR51U+okJ92U/AMUpgmFwW+8oF3v2BdasIHlTYn5I5L0Mwy22hQpWq/yKXEwXcRwycWa6+K6NoyWxy49aejVxOSYU+nx1d4TligpZVKq43rHSrIIgKfkuoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaOIArJ7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaOIArJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B236C2BCB0;
	Tue, 12 May 2026 18:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778610701;
	bh=9l9QZTn3VGCPwjw6uCXUYbXBEV1oYKl//ROhoakHyKw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oaOIArJ7NjzNm1c4UpAV7daAETkQnGLe7Y9AuriJATPRHn1hjrUuA9+CH0WTqGbEL
	 q80I1TkMlCiOetx+H7eQOY/wt3LWoqbjPx0Mg+Rwbmmky1lMu+TEuwkqAwCuCal/5+
	 jkucbA0KQYWXDUkimt6kf4qfIRus9n3E+ZAC9HQ3aI43boEI14XiRBDf13FoR5WIXv
	 pasFsE5bk75a0fU4HhLhu/ZANtgRDPQRZwkDMluZW0sLlqlj7FzQnZ/4RgaQBu8/1K
	 g97zcC0KVUd/xXujkNbhxPbLEvyI0qP3Ew+Bvu3l5g/5iJVGH6ZRH7Tl29tSjvqQqf
	 60i/nnf9zHzQw==
Date: Tue, 12 May 2026 19:31:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 01/10] dt-bindings: iio: frequency: add ad9910
Message-ID: <20260512193129.777d62a8@jic23-huawei>
In-Reply-To: <20260508-ad9910-iio-driver-v4-1-d26bfd20ee3d@analog.com>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
	<20260508-ad9910-iio-driver-v4-1-d26bfd20ee3d@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 May 2026 18:00:17 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> DT-bindings for AD9910, a 1 GSPS DDS with 14-bit DAC. It includes
> configurations for clocks, DAC current, reset and basic GPIO control.

I think this is getting close enough now that for next version you should
drop the RFC (which is probably gating DT binding folk giving it
a detailed review!)

> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

> +
> +  adi,dac-output-current-microamp:
> +    minimum: 8640
> +    maximum: 31590
> +    default: 20070
> +    description:
> +      DAC full-scale output current in microamps.
> +
Can we use generic dac.yaml defined output-range-microamp? The base will be 0 always but
that shouldn't matter.

