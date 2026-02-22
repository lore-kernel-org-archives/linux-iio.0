Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39E0285CA8;
	Sun, 22 Feb 2026 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771766480; cv=none; b=KsFH1iIDs8x3qg0LrP0ixQEnu6eGll456Vxxu8oRIrGROuoNxFEKf/YPPL8oqfpiVXhZ8P2ZjEQLjG+UdMXtJI6pPqa7Zmlsm/MP0oTT7RyX8n2qdacQPC/mJ77LHTxIVGPUWmUnuj6seZuAnQNSqdS6YzdEYq5/xhhvaYXmV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771766480; c=relaxed/simple;
	bh=KFsynBqHuB07p7jNPw48AxaZX0kF6H91GgBdVVwyLQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZopT2xL4V7jIggddiP2HPOrOQa+DFSd5dniCYnTC5kWhZGL8J9+31fEBGlE9agQ04QVglQEQy5x8dY/fi9O0/EMVs5RDu43Ol+MtJMSyTLmBIPC9UzRj3iAWA/fyaXUccrr5smgho++eibLK/Jfeca6BHfalQcntwEl2/DD4Psk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKfd7XnE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKfd7XnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD65DC116D0;
	Sun, 22 Feb 2026 13:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771766479;
	bh=KFsynBqHuB07p7jNPw48AxaZX0kF6H91GgBdVVwyLQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KKfd7XnEV4OtcbGY4lyhjn1jvNP3XF3p0NNWTZYvI8H5HxF1jXg1cgVZJ+Ra/6kCS
	 DiNpWTbvIUJmwiC9wsW7esWAtgf3bNXAhLdsF5XBz+97TnWmMDMjtEtibm4JfhOmI8
	 TWOK5YcuH37Je1j2k0Nbm+c9EsbkTNtqIesUFjjySYVSegVzg54Bn0Sg7aLT4yqUVV
	 G9XyZFyREeN1dgKTKYx7+trW+2ebqhi2dQnTNU3HcnIk/EZctSAuVCdLRtluXWJIKA
	 YVNjhUaycpBaoQrkAhPriXGjEFpjqUZmNjXSJF0MlmRkyhF2uROcEK9rDHzKArvcsT
	 4BA/dE7NkYarQ==
Date: Sun, 22 Feb 2026 13:21:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] iio: adc: ad4080: add support for AD4082, AD4085
 and AD4088
Message-ID: <20260222132111.5807de20@jic23-huawei>
In-Reply-To: <20260216151112.139359-1-antoniu.miclaus@analog.com>
References: <20260216151112.139359-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 17:11:09 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for AD4082, AD4085 and AD4088 SAR ADCs to the existing
> ad4080 driver:
> 
> - AD4082: 20-bit SAR ADC with LVDS CNV clock count max of 8
> - AD4085: 16-bit SAR ADC with LVDS CNV clock count max of 8
> - AD4088: 14-bit SAR ADC with LVDS CNV clock count max of 8
> 
> These devices share the same register map as AD4080 but differ in
> resolution and LVDS CNV clock count maximum values.
> 
> Changes in v3:
>   - Merged individual per-device dt-bindings patches into a single
>     patch.
>   - Merged individual per-device driver patches into a single patch.
>   - Collected Acked-by tag.
> 
> Antoniu Miclaus (2):
>   dt-bindings: iio: adc: adi,ad4080: add support for AD4082, AD4085 and
>     AD4088
>   iio: adc: ad4080: add support for AD4082, AD4085 and AD4088
> 
>  .../bindings/iio/adc/adi,ad4080.yaml          |  3 ++
>  drivers/iio/adc/ad4080.c                      | 45 +++++++++++++++++++
>  2 files changed, 48 insertions(+)
> 

Applied to the testing branch of iio.git. I'll be rebasing on rc1 in the next
few days then pushing out for linux-next to pick up

Thanks,

Jonathan
