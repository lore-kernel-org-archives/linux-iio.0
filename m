Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D3C40DFB0;
	Sat, 21 Mar 2026 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774088075; cv=none; b=RzScSM7/3OBvTW1rlaAy9B0w787OJoQG27oDNnH6/2kVawKFAqWdj78DsKUCyrEYmk47HJITXUmjoxqDXXqoq/c3Yzl19PO4dpuSexIpMKeMVe7x8yhRB3XwSdVn67Ja0OjUAvU/9IHDvUXKavsMx3GzvEc1DjZA77tz9ZM+O3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774088075; c=relaxed/simple;
	bh=xCkIiUSVYuAkn1uHQcD+JYggjOG2RNIA8Bfj3bWxCQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l43oPfagL5redloiC3FWOwzLmlU27CrG1shA/hTjVvyQi8zOa6UWha8za98FtzSuWcZ9VHnxSeNSKBForywi0sErnw5xedq6LU7rHRuhFq6x52Z14weuYG6pkg5Y8rpcIoFTUx9bziK0OzhyxNOMBYGNpgVoz0NETGTGDceIE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iyKF1Uj3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iyKF1Uj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA93C19421;
	Sat, 21 Mar 2026 10:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774088075;
	bh=xCkIiUSVYuAkn1uHQcD+JYggjOG2RNIA8Bfj3bWxCQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iyKF1Uj3WcNhaxsclKwDdIjWnEEGkS5Kp4k8PVZHrbUrSDzal0VoHDAfWC2EBoqr9
	 ZOSyTyvLSk9+2PBdzEyHjp9Wf+bGtE4jXe0nPsf2OtmRzobAkTaHzHE/S6Tel20vdU
	 HaiGpftmXIBhpQmkmzDugJAd+55z/e3i78W0cAtxgzus8W80P6F3F+dhd0LRxEJJNN
	 gbjrEizaW91bN00zjnURvWDvgVMwAgv1ujzUweoNypxgNvpaWj+7T6ldx5G72A0o75
	 55Jei2O5H2mh3V2GhLytAgVIsvdsyDkMivUH01so+LETjWNBRcWm6Qy+MKswgR23Kw
	 nRCy9dYrbUs4w==
Date: Sat, 21 Mar 2026 11:14:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v6 1/8] dt-bindings: iio: light: vcnl4000: add regulators
Message-ID: <20260321-inquisitive-wandering-antelope-3d3da7@quoll>
References: <20260320-vcnl4000-regulators-v6-0-0d24d20b1a5b@gmail.com>
 <20260320-vcnl4000-regulators-v6-1-0d24d20b1a5b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260320-vcnl4000-regulators-v6-1-0d24d20b1a5b@gmail.com>

On Fri, Mar 20, 2026 at 06:45:36PM +0200, Erikas Bitovtas wrote:
> These sensors can accept 2 supplies - one for the sensor and one for IR
> LED [1]. Add supply properties for the sensor - 2 for the sensors and
> one external, for their open drain interrupt line, to ensure the sensor
> is powered on before proceeding with setup.
> 
> [1] https://www.vishay.com/docs/84274/vcnl4040.pdf
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
> ---
>  .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml     | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

