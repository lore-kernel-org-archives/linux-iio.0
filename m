Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC6038F929;
	Thu, 14 May 2026 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741341; cv=none; b=lZ8bcDIbXYK4KgE6zjb+t0qXPcAWynUTXT6P8jwe54/ueKS5cLioSNqZvNAHsr/JOBwMAG35O5wNwY2Bp4x7p88beYsWGMV+/qbAy2TKo5i0huINZJV2C+HyUTtnp8R1epAAykTUI9Z5NeSxXNs/Hb8hnN00M+KI3IDVyzHOluc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741341; c=relaxed/simple;
	bh=kV2o7etbiZ1xCvqmtMuywQhhRRr9HS66gjhYQJ3K4ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbP/FrTIHFwXO2dqo+25jvmLyhCFY8UtimZxZFBzuRhoR37qa9V+6/zD7aX+/D8+CpPF3cjbPqCCSXZT/OtsI5JOxG4CcU1tZpfpoBV7dq/k3mgHvSZ7GveDwhFKfMVVlN+iFINxWhAJq21r4c1ENO4RF/Q9scRyKtIvCPeBEy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Btuh47Gb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Btuh47Gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B6DC2BCC6;
	Thu, 14 May 2026 06:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778741341;
	bh=kV2o7etbiZ1xCvqmtMuywQhhRRr9HS66gjhYQJ3K4ZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Btuh47GbvI3I1oCGW2UgyyI/bokQrBi1bCH27SWwJgV6o30DAmiXr666HA6hBjKpU
	 osqSwAGpNim0btT5qrBPlOO9dzx6pygFnEDrxIWjaBKxJhwcPrG0+RLI0EcmBzHk7v
	 JLl/rucGHc50nC7YZBH/WQLK73sA7Oo6xjUMREuEYLOxyV+KRSGSn8aMiO6BKjp/3w
	 nhZl/D45kayoeUz4bG+taqd3Llf0OCoBkplKgK+Q4hTzDjiCcHRiJnanEjWsaWNBmT
	 Bv3rzRnyVaS/qR3rW8eXZZrS+oa+fv7s0+WK9Uxb1WMpYZHBkf/OYvqKxdfunTpI7I
	 EGc29mH0DQNRA==
Date: Thu, 14 May 2026 08:48:59 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, jic23@kernel.org, jean-baptiste.maneyrol@tdk.com, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V6 02/11] dt-bindings: iio: imu: icm42600: Add icm42607
 binding
Message-ID: <20260514-optimal-warping-donkey-fbf24c@quoll>
References: <20260512221634.256747-1-macroalpha82@gmail.com>
 <20260512221634.256747-3-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512221634.256747-3-macroalpha82@gmail.com>

On Tue, May 12, 2026 at 05:16:23PM -0500, Chris Morgan wrote:
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
> ---
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

