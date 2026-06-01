Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA963932E2;
	Mon,  1 Jun 2026 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307083; cv=none; b=aOWhIMU22zP8jN3v9WkeMNnbEzd/Rrh56RVmYm6guITZrRkkNOu2ve0FCsVD7R4HEy4N/Ocf06G0eqyz5Th1/X05vvJfyxVouuXjqQNzVUg1tKxFq/XA2TPRVgY99TBMDCUoam/vlNAlw8XXqA4v57kAu72TVzTVeStnqEzUd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307083; c=relaxed/simple;
	bh=tZoJma3MElFIutn9azT4FSlW5wGPlYyrXPZxkBcBLNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPu7XmZqMRqBlHAgZmq+Kl+bFec9zRcWkKfoIUAZRyU69DCUZlww1NpZfryt6mnBZBq8tj6nK4tSgwQgMhJRJ6avx2rikylX+asD+ff32ujGrjCxPoDIQwv/z160hIDxjvJcaqTUPiFM4EOH9Fxcp+jrUNfk+CbhVpRrNCDivZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS6jiN9z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS6jiN9z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAAD1F00898;
	Mon,  1 Jun 2026 09:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780307080;
	bh=pRtcNLHUVksz+24fzpsR6ejp4fnlgIHfZnkaZBtYOfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NS6jiN9z6IRIXp+uHhRlZYvfKDiOeBT1xqNlBQVxhVfy3BC4389ZkNHsZw82zzbvs
	 379stYmLiIfZa9GxW6OSTzt/yxP0wVU8lCwljl1zfYUnTZ757CwuXb0ykN23ix86U7
	 9J2vcAywbMMiIgK3Nk0rsrB7UDchsCZXK0ev8QLXVASYx2AwZr+dS4zV/2gqHHlquy
	 OnGk/mjOGbt+zRYbRuGg5Bt3I/T6dSbcRdYPsnJjq+5x4ZluPsgCxq6A+u/o3v1T7I
	 XbTMLKM80Qr15s4xWWfHMdfBJGzfmhQpkPFzkuXfiaWmeMiNNdO5oGGo7Pp2ctQTpa
	 5TFyChmawWxXw==
Date: Mon, 1 Jun 2026 10:44:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Maxwell Doose <m32285159@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: flow: add Sensirion SLF3S
 liquid flow sensor
Message-ID: <20260601104430.2f5c2f98@jic23-huawei>
In-Reply-To: <20260530205435.37326-3-wafgo01@gmail.com>
References: <20260530205435.37326-1-wafgo01@gmail.com>
	<20260530205435.37326-3-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 22:54:31 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> Document the bindings for the Sensirion SLF3S family of digital
> liquid-flow sensors on I2C.  The family currently covers the
> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.
> 
> The driver auto-detects the variant from the product-information
> register at probe time; the per-variant compatible strings exist
> for documentation and dt_binding_check purposes.
> 
> The active calibration medium (water / IPA) is runtime-switchable
> via the in_volumeflow_medium sysfs attribute and therefore not a
> DT property.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>

> +
> +description:
> +  Family of digital liquid-flow sensors from Sensirion with I2C
> +  interface.  All family members share the same register map; sub-types
> +  differ only in the flow scale factor and the calibrated measurement
> +  range, both of which are detected at probe time via the
> +  product-information register.
Slightly odd line wrap.  Can go to 80 chars. e.g. something like

  Family of digital liquid-flow sensors from Sensirion with I2C interface. All
  family members share the same register map; sub-types differ only in the flow
  scale factor and the calibrated measurement range, both of which are detected
  at probe time via the product-information register.


