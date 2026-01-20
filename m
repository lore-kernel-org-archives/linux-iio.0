Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571DC407575;
	Tue, 20 Jan 2026 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905330; cv=none; b=tzUkWWzEoJwHvUTN2OMJkCggTMNQTz+iPUM1GInIK1Yo8SgtIw60DjZEXyNbcyCy972YEeQcBwPrZcFSrcrtb9RR7EFApeRLYCqiJEGmcEua7fRYW3Yq2MmjipXFJTSDa88d12e1V6qKQqzN7ZuP6pP/9kQnU2tC1Eu4Rzwa6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905330; c=relaxed/simple;
	bh=5PktTW4zo41M4vhv4w23EC44QaZQS2ofRjvUn4WFQfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsMukKIp6voWtRnDRqjF+Srzhd8/fXBtMXIc8zLft0rlbKEUCJ4nlqzNkS+qHTEaqpZfn1ylVB7WbaEotYMhjBpDqpD5p4yEJ0kUlwUduHotBBJ0PnZBSq3ewy9WHUSm9c5EfyReqDPze9ydZtDqWx0TOlbIy3dD1j1saDx/f1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/wYit4G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/wYit4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523ACC16AAE;
	Tue, 20 Jan 2026 10:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768905329;
	bh=5PktTW4zo41M4vhv4w23EC44QaZQS2ofRjvUn4WFQfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/wYit4GX0TUsUoTQZ2ZfR9e96PyHV0sPv9LoTpYGZAkt2xvp0+eZgcAs9os9z2yh
	 UO+2DrJbX7CazT3+aJz637MKYxGzDT762ENKPKl+ZRDPGvIdsZHGWWFn022u3mEZ+9
	 LtQDbRxyPNfkgAlulaBeNEKyR097jZZfQMxKfBVxMrKR/xyRgqB6MSzBInrxWl8U1T
	 N4qbBUBbRvk8yh7ucNqZCjsXC090AS70yPVslKuFvX+XCZZ3O04xeWuCS1+whZeo3x
	 68Jujf4ohW0itxw6Ikm/GOaXczirMreZNmq3yo78hWUiL+RUyb9jVa0BQQs2VXQrDm
	 DSte588J2iyMQ==
Date: Tue, 20 Jan 2026 11:35:27 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Petr Hodina <petr.hodina@protonmail.com>
Cc: Song Qiang <songqiang1304521@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: proximity: vl53l0x-i2c: Add optional vddio
 regulator
Message-ID: <20260120-daring-amethyst-shark-50ebcc@quoll>
References: <20260119-vl53l0x-v1-0-cf71715a1353@protonmail.com>
 <20260119-vl53l0x-v1-1-cf71715a1353@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119-vl53l0x-v1-1-cf71715a1353@protonmail.com>

On Mon, Jan 19, 2026 at 06:19:55PM +0100, Petr Hodina wrote:
> The VL53L0X can be powered using separate core (VDD) and I/O (VDDIO)

There is no VDDIO pin. I checked on datasheet.

> supplies. Add support for an optional vio regulator and enable/disable
> it during power on/off when present.

Last sentence is incorrect in this context. This patch is not doing that
and anyway, whatever your driver is doing is not here really that
relevant.


Best regards,
Krzysztof

