Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F0221D3C9;
	Thu, 30 Oct 2025 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761812620; cv=none; b=ei+II+lFRs27dAkIEzkB2jguVM8BwNoB2i4B19gi21BGsXbTqARbc7XJyOBax71qVCSeFow5aIjSRu4rVJ70M6SO8OpVmThvL3f5MXkPRLJwlgixo8+uzqveXYZi1NUFFYJOQID1ddIBs07b+mvIpGs0aoJ+ylW5ibZsKEfWjS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761812620; c=relaxed/simple;
	bh=gBVwjjZuRmmTBdFscwrvsDCkSft7hllufmJNPbvi1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ykz1aA6nQEbkJcvXzevDh2hLOsMudvc5S4pLyJ861EE4oHZOqSl5a1FGnw5q6OKmzeblJHJVm6m+N0gF4lXBnP8Cyxh3fxHtyZfcrkXqwfvhBG2G/8dgcPOv37XDY1rZV7HqEsiZGfSiywvWqjJmmgyr+egmj5Wl4SO4O14R0To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8twPJGw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8twPJGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58805C4CEFB;
	Thu, 30 Oct 2025 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761812619;
	bh=gBVwjjZuRmmTBdFscwrvsDCkSft7hllufmJNPbvi1Dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8twPJGwfECe8D22djcRL2xzNGe9HJW9Ge8u5E2dw24wTEfxKv6mU/uiurjI7AU9d
	 V6VzYsBCtbofa8uG1H3Z1oQ4Cs7BVeb2BOoVZ6rpIR+kHfC9PTgYlfwjBXC81XAw+W
	 3iRFppajzVYbF4rwhwQqgDVGFMRa2CMPbjZRAs3H+uiD7LzOB0TtDgl647yoiKyp+W
	 ycYiQ9Lx1cnAPvJ9ojkj74AQIaMwGFjJmU0N0YFLHXD59mV2KuO8eHX3vyqOdL3NQj
	 eSs+oeRfUl1yVb0qge6YM9TecNr4wJw0Pfy9o6BPASBVoKKCrV0OLeEdXGRTxShWMQ
	 zA4kcqHOB+Ykw==
Date: Thu, 30 Oct 2025 09:23:37 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: mpu6050: remove interrupts
 from required list
Message-ID: <20251030-glorious-nano-muskox-e37d49@kuoka>
References: <20251029-qxp_sensor-v1-0-e97ee1de96d8@nxp.com>
 <20251029-qxp_sensor-v1-1-e97ee1de96d8@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251029-qxp_sensor-v1-1-e97ee1de96d8@nxp.com>

On Wed, Oct 29, 2025 at 03:27:18PM -0400, Frank Li wrote:
> Irq is optional signal to make sensor work. Not all boards connect this
> signals, so remove it from required list.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

