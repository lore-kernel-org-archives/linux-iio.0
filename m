Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1BF18AE2;
	Sat, 14 Feb 2026 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771058310; cv=none; b=RqubMxN45AM0triNf05bT3ZTom5NYJWQHS2Lrrb2Lx5+gQvGwkMQImj6qdq3JxZOCy6LPrAM8r0R+377rIuCmWgHESe5Gd300jTH77Wh1LRiIXZ8pbnbgP+XbWAczQ6PzD5OrR8TbMSG92pQ/5k+ftGUERCFUaxaRlzaR8y6B38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771058310; c=relaxed/simple;
	bh=zfBaNef45jkiUZ2BQ5oLj6pm6YzYupqKFGXgwHihp24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM2N+P4MhXciwPEZ9xglhrclRrJn4I8/XVvjoFWAQjaezG+bWeS7m/3Bxhhf18WGvQFUqDWgO+EiPXjJJWKG2bz16c2bLsukSPrLciDGEoe0IJVRKyY8CqPbd+9LVYGnHdzFpE9CuxXXjcg89UOihTSKur2T10O7oAl9pdhmiEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p1XX9i+V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p1XX9i+V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A122C19421;
	Sat, 14 Feb 2026 08:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771058310;
	bh=zfBaNef45jkiUZ2BQ5oLj6pm6YzYupqKFGXgwHihp24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1XX9i+V31892eDho75rHnKjoadZQjYfR4lEhEqf/UMhPf4CHqnkEis8fxcPUgIU3
	 wtXEJAV4MIBPfGZ4tm4zlsCCYrsfo8Y/ZUzl900TnKgEOzOKakp3afWW3oujlZ2p8s
	 j2LagmY1pnn3IzoNe2AGymxTxKqXW3b0g574q+RroY7EdxIkHvqbFRpkKxBK/GhF2Y
	 w/Wu/FaRGSOe1VG4jK9OHjantICUr8e4s3tjfy6ihuch7XzRspkt9Dmzyv6PTwdHzj
	 yFBdQtqtrmgjN/vKDf+KP/H34H9UItLsi8to+ee7VpFjwqUdtJKGSHNMNkCPWbB1RL
	 exfvqCe0bsrCQ==
Date: Sat, 14 Feb 2026 09:38:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: iio: proximity: hx9023s: support
 firmware-name property
Message-ID: <20260214-nippy-amethyst-corgi-fb9aa9@quoll>
References: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
 <20260213-upstream-20260219-v3-3-df9371d29f5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260213-upstream-20260219-v3-3-df9371d29f5c@gmail.com>

On Fri, Feb 13, 2026 at 11:14:45PM +0800, Yasin Lee wrote:
> The hx9023s requires a firmware blob containing board-specific
> configuration data used to initialize its internal sensing engine.
> 
> Although the silicon is identical across platforms, different products
> may use different electrode layouts, PCB routing, cover materials and
> mechanical stack-ups. These physical differences require distinct
> calibration parameters and register configuration tables in order for
> the sensor to operate correctly.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

