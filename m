Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC138735E;
	Tue,  7 Apr 2026 06:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543366; cv=none; b=HuyCujy3dmpcMVs7SYum2MizQFIIaK4iNq2uOdANpIEU4Qervov3A6Dm+/Xdd4skOWqmB3QciQjQU40HPoQobe2wZHIIxQLvw+lAGcYHUaunMBpstwDiOpf7azuwMuccBFilrkjIqIwa8jICTeDspMyVUE+IvKeDF/KNVl1vAXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543366; c=relaxed/simple;
	bh=eaccoIrG75GSKa0lf4WO8SZqovJMSPcD+5siYU/kEmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9SRYMXWqQrik/m+h0OThlvHbJpTAN6JKo4KX8s7NB/VUBxZnjo//6Zuq9TG3sHwOuy7NeCuGMfqaNkqGrbxMgvZvCtRcbAYvedSqf16cNYaTM11kOlAFUoXpQhMCFMXDYvj80w9FNZevM1kFbS0nRNQju3SrVJF6dwCaBTBLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9+SV/07; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9+SV/07"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2946DC116C6;
	Tue,  7 Apr 2026 06:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775543365;
	bh=eaccoIrG75GSKa0lf4WO8SZqovJMSPcD+5siYU/kEmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9+SV/07PrkwufxeruYvQYp6K2kgD5u1VGuu+sZFbj/0guMzy9nEfyvMz538Uqdoj
	 +/cmA9b/vkzglngTizCc4QBBfRkYCEils7osjtTClPu1XfDkWnnwCjygXDhtH6SGi8
	 lstrjh3O2En/2tFqwEa3d+5bYkHf1egerKc8LL1p/CTUYNFoSnk9mhhhs6AULKbbgA
	 EnbIUs58x23JLyNfbt9Rr4HeZ+JO7w9WkN8bYpYUTcSZAl3QWUR06dc+Y0IKi6Jlcj
	 azPc7IT4Px/8ZZvIQvhmo/hqggjUa9WUiHW1wnSdu8HlKdeRxMSYRUz3OAaajfR5Jp
	 7dVkAi9M2ARCg==
Date: Tue, 7 Apr 2026 08:29:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: dac: Add ADI AD5706R
Message-ID: <20260407-groovy-mauve-goose-dee6e0@quoll>
References: <20260407-dev_ad5706r-v5-0-a4c7737b6ae9@analog.com>
 <20260407-dev_ad5706r-v5-1-a4c7737b6ae9@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260407-dev_ad5706r-v5-1-a4c7737b6ae9@analog.com>

On Tue, Apr 07, 2026 at 11:39:44AM +0800, Alexis Czezar Torreno wrote:
> Add device tree binding documentation for the Analog Devices
> AD5706R 4-channel 16-bit current output digital-to-analog converter.
> 
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> 
> ---
> Changes in v5:
>   - Changed out-en-gpios to enable-gpios.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

