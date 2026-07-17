Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE31375F9C;
	Fri, 17 Jul 2026 06:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784269305; cv=none; b=jC+oKSZtkMQhXwybEqXb05M8/2H45yYUk9Kna6D24Twf/fsnCrvpfvZWj9dAALxnY8vRnEi5BGcaM/9Eo7oyQQs3qTXZ1ievN+UqzRueMbNMJFa7UKuw28Hh576zPp+ZH7NSM6eei7TBhO1/vTLvcigmMQygI8yMFE1mF7mB8ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784269305; c=relaxed/simple;
	bh=bLIPj5eO1EQSZlLBdmKHA9x1spsGrTuSjurq1Ca5NAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKOk41Nq0J0Og5FqU4QAclh++U1aahXuHqYaBArXyiqAVYo07+hm9UZcS03KyL6OPioOt5tUAZxpx5evewFD1o8yIy49SmHidSXDvQ+G9lBjrZp6WjXanJ2Secd8CNCMn7RC6GWlcXNruAu2IbSGL78coGWnTo5zASsWbvhZDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6ytgwpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6ytgwpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D319E1F000E9;
	Fri, 17 Jul 2026 06:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784269304;
	bh=x4VEIoTRZpkHj3s/3eMes1CPUJb79OtxXGdGLFjN23g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T6ytgwpGB73dzAI5G/pEsdcE/AGLaw/z4TrbNaOWH8Lv2pH9fpReSPtgG0SUvlWhf
	 gVI4WQvGg6+w15oi3PWaoyrvfj3CQ4+gBNOLZPQeT/jqMFxr+GzKV5s98DETLFkKQx
	 zRn0KWLlkUdt/MRk0H5B/AffCUngsD4l81M+tdDBbAswyS+k00pmPK8dOY7oV7JWBm
	 25wTBe/VzNPkzqM/kFL9ciyNfVx7lFXirHaFw0ttaQW+Ejx+QQPQqUvk6CKGL2MPlX
	 MCPkroTpYcmvVOcO2mEdTSSXAXjyqPoQxI9y02e/BG3RgCEI58zPJU52QoKA7pZnrT
	 0bIXTmnFyPBMQ==
Date: Fri, 17 Jul 2026 08:21:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com, 
	dlechner@baylibre.com, jic23@kernel.org, jean-baptiste.maneyrol@tdk.com, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com, 
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V17 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Message-ID: <20260717-gay-panda-of-authority-e69e54@quoll>
References: <20260716182637.24310-1-macroalpha82@gmail.com>
 <20260716182637.24310-3-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716182637.24310-3-macroalpha82@gmail.com>

On Thu, Jul 16, 2026 at 01:26:29PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the ICM42607 and ICM42607P inertial measurement unit.
> 
> This device is functionally very similar to the icm42600 series with a
> very different register layout. The icm42607 currently does not use an
> interrupt because wake on movement and buffers are not supported, and
> cannot be implemented on my test device which lacks an interrupt line.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../bindings/iio/imu/invensense,icm42600.yaml  | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

