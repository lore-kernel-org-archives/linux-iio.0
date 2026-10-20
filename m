Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485360;
	b=1XgNipt0JpVyuP69ApP3JMRy225ezbmSSn+gy6prp9nylJRGFc6roYCHINeYEZHxf961
	 5Y7hwFpXudxk0JiYltQ9j9hDZvEo5ye/0mcQXLcSJY0hY1nV7JntwVGxYfc9WXaZNL+Km
	 gB3nA73KumJmrf/QNDFuEHmZxsxrQ720FiyyviV62/h6e6sdyWHRdSDlMs6+MI88jEwie
	 Z4wSIRYofu8CZEHQMqiW2ptNgyhre9SU4PLjBft019sAzVQI3yTCKV14ka4YS/KE6SwX4
	 raUX/WVdRH4FlbuqGNHO+57itfyxZj+tOrM9EpYSTFnfW9LLX9YzEzSaA7RPC/AvPpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485360;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O9kQxxiMQXZgZt4jc5gh6sq1UOiM8uvtGuGsxDoj0/A=;
	b=nPPFsh7J8+UgcV6WvbySTXoHkTxA5CaMWYba8O7+KZS4P7oFnYFzYjNpxf4urIZFU4Bv
	 m1chNlNGpa+33WUfhiS7UhHiwEZgapOQRS3CdwoGo4KnvfMVlqjSW0iw9ESUU5PYUD0ad
	 Ktd3XOe1PPWfmVvLBMuGjNN9k2lspXC/nwVedmOCs1bUvTfxSX4jzFy06W1YT/AOGWqg+
	 oSpVOF6LJpMDjeD6vsztpjBWH+AWD0s/5WEJ5PCJ2AF1sWTifGUt0VebfNSBQVWFSY7pO
	 iaQHHAD47rNbzc97+A2XbShj9KafrixOPp32cP8VkekeAwQ1KelJBQPOa+EoujMhxUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W0olC9/h";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5AD606A319;
	Tue, 20 Oct 2026 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0olC9/h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A201F000C4;
	Tue, 20 Oct 2026 08:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792485359;
	bh=O9kQxxiMQXZgZt4jc5gh6sq1UOiM8uvtGuGsxDoj0/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W0olC9/hO8H/xx6JNxQkjW5kqi13uKVIo87jifdOkUid/mmVit95os+yZqIOiXyZY
	 OPnnT+7dEu4lmf9fCgCMM3bvIYYlrX6ec6wb1PVoybqurnC/SPzxouGZ6c8VHuAvOw
	 2y2OBbsYOi4zJQ/rzybqfxp2DI7R5jJtexsHV7OY/eGpUfN0ILD4AHbMtTW0jaiNhc
	 hmr1092yK0ohG2jSLBlNq45cL18Szw8UFmCNnSMcP5+asFk6nMUsv2HEae0uxUkusi
	 /2nTDAe2aq8+CfdNIdFuUysyU6RDIbKAa2/etcYc7lNvGxSnD9glJt5xAHc6DsTnbk
	 Qb15s2vvOotoQ==
Date: Tue, 20 Oct 2026 10:35:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Benewake
Message-ID: <20261020-impetuous-native-leopard-baf6da@quoll>
References: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com>
 <20261020-tf-luna-v1-1-53a88f93db24@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261020-tf-luna-v1-1-53a88f93db24@gmail.com>

On Tue, Oct 20, 2026 at 12:03:41AM +0530, Vidhu Sarwal wrote:
> Add vendor prefix for Benewake (Beijing) Co., Ltd., a manufacturer of
> LiDAR distance sensors.
> https://en.benewake.com/
> 
> Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

