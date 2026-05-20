Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066D1285061;
	Wed, 20 May 2026 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295349; cv=none; b=WlpbxY2d6hsnqgUvNeNIvLT5ZMtH7qQGdSayPwNbdDVODDWIBVtc+XJnXsf2EqFMtMkYf5AvO+r7ujqd93toV3ErWyTRRYYCGAo3axaWcHRTWZPXCbRvFn4etuBedUZac6+bWaeEV8owA7EBcdYZQXlPJNxLQ0AIYpVA3EqGWDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295349; c=relaxed/simple;
	bh=ChL4BOxkqN74TFi3krExsDxWI2icza5/FfUdO/bCSuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DYiYuDSydG3wEvjKAZV7oS/HV6B9Op+brA2H/pn275yuImKvqf8pQE2J0g78nXpnTZM2FrS8Gg49QvtPU32C0fotJabxyj9QgBWOQDQb85KXZgCShhe+Cb1YFrGqdCgSbmFtCjVfSzT33hO9MDZsavNkzDJw03501rZVdQJZA18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDQv/fWp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDQv/fWp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 738CF1F000E9;
	Wed, 20 May 2026 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779295347;
	bh=GC+j82qSY+zJAwat3LurcWTkfdtSSywc65VonLyYicg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZDQv/fWpSChLPviHjk6cFBB1XDarcIA8D/EPZDe9bX1KzTHR98tkq8imsKYX6rgKY
	 r3Q23lI+akkmk/Le7vQTS9KcDWs4tONw0AgyWipqtaF6NFict6SrzEvjKxtVRew8FP
	 PCkUCUHjBbClAL9EFA0KjO2Ee3qF+UvHaBA3hRObAfJYP6QPDScRCy6C3Vf1y78/JP
	 niq9lXmiJbgavWbiMum7EN0jnwAI/E86hvd2lZK6kk2hHq6SJUw68Qf2JGU8mPHOWB
	 LhgKD8FjzFmk+L93FeySIhOa491xDnbOh5GSXZBjMQhEhJ8R+zRlYMJJ97z0hltvgr
	 oh3zZOiSJ0fLQ==
Date: Wed, 20 May 2026 17:42:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH V8 02/10] dt-bindings: iio: imu: icm42600: Add icm42607
 binding
Message-ID: <20260520174217.6ca98524@jic23-huawei>
In-Reply-To: <20260518200526.458421-3-macroalpha82@gmail.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
	<20260518200526.458421-3-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 15:05:17 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add devicetree binding for the Invensense ICM42607 and Invensense
> ICM42607P inertial measurement unit. This unit is a combined
> accelerometer, gyroscope, and thermometer available via I2C or SPI.
> 
> This device is functionally very similar to the icm42600 series with a
> very different register layout.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Note that Sashiko has highlighted that the binding this being added to
has a potential problem.

interrupts are required but interrupt-names are not.
That would be fine but the binding doesn't say there is a default
ordering for the interrupts - so if we don't have names we have no
idea which interrupt it is.

This needs fixing - probably by adding a default

Jonathan

> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> index 9b2af104f186..b69c6bbb6f6b 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -30,6 +30,8 @@ properties:
>        - invensense,icm42600
>        - invensense,icm42602
>        - invensense,icm42605
> +      - invensense,icm42607
> +      - invensense,icm42607p
>        - invensense,icm42622
>        - invensense,icm42631
>        - invensense,icm42686

