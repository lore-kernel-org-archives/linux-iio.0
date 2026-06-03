Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D93D4108;
	Wed,  3 Jun 2026 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484087; cv=none; b=pJbou3Jm+v1KOUwijbAOwsysG+2ZA8FyZAMWzSOveA4ZX+0ptYbG9wndFckqZnzhjqN3svq96CTtbV3tvGfeAsnxKX19A+3AW2FWYFKvGHsUfud7iVAEyLD9W+gKgb5intkhJu3X07UDrFkO14n7yGbRj9uicixR3JXA+iT0IJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484087; c=relaxed/simple;
	bh=fM3lVMoWRNs3P+Z8HysbOxgd9rT1/qMXGot5Kn+63OU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2g7D1iwhXvEo7MW/VecZcvDBmAih7hl2DTiP9Vfw7d686aGqaTz++DPUMB0XtVkAeIeNMEQ/xiq1sImgVgniZ9NcKYFVRzOQyHDQsWReeVb/wAcOyHbbYA2Ea3sSQd/OXYnUw8zRNb7TTMyKbaoaDb3+3oYyD2TOP6vLQnSkQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQSW2Ldx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQSW2Ldx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1F31F00893;
	Wed,  3 Jun 2026 10:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484086;
	bh=SagKm0C+mLWJRzJo5yiqGPYEzpXXDxrNz+NqSO0sSkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HQSW2Ldx1czdQqiE7HC/gkmWGHkfmTYFYXNaiWQvZ6EjgnO0ie/05RIvQKVxVBJy0
	 XF/4JSGJOLFl7v279nSVV1lNBRsI4f4j8u3chSS8XHnoxuLsK35/E1lOEjkJhNDCOH
	 206TAL/orTdY2J0VL7dDpZ8YKUMz3GNdi85tL15QRjjHMc9oGsiywJiBXM7yd3o4m0
	 00V+BGUJ9KxTn3Y09VHbsE5By6mq0GMNh2QNs8Z6+tigJFmsW2zHf7MA0jEfB9X7D+
	 sH39PUUzBVLq02+W/2mzWZJd/BhK2kNxOQgE8+G6jkn5fUYqIQ5CKfCph+3NOTwoj7
	 xUh0WlhBTPc+Q==
Date: Wed, 3 Jun 2026 11:54:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Taha Narimani <tahanarimani3443@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 RFC v3] dt-bindings: iio: adc: add ad7816/7/8 digital
 temperature sensor / ADC
Message-ID: <20260603115439.4f0a2264@jic23-huawei>
In-Reply-To: <20260602-pork-unsightly-fd091c88e5a3@spud>
References: <20260530165917.55767-1-tahanarimani3443@gmail.com>
	<20260602-pork-unsightly-fd091c88e5a3@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 18:05:44 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sat, May 30, 2026 at 04:59:15PM +0000, Taha Narimani wrote:
> > Document the Analog Devices AD7816, AD7817, and AD7818 digital
> > temperature sensor and ADC bindings in YAML format.
> > 
> > Please note that the driver for this device is currently in drivers/staging.
> > This patch is sent as an RFC to clean up and standardize the device tree
> > bindings prior to any major driver refactoring.
> > 
> > While reviewing the AD7816/7/8 datasheet to correctly document the properties,
> > it was noted that the current staging driver attempts to request a 'busy' GPIO
> > for both AD7816 and AD7817. However, the AD7816 is an 8-pin device and does
> > not possess a BUSY pin (only the 16-pin AD7817 has it). Therefore, in this
> > binding, busy-gpios is strictly limited to adi,ad7817.
> > 
> > This resolves the checkpatch.pl warnings regarding undocumented DT
> > compatible strings.
> > 
> > Signed-off-by: Taha Narimani <tahanarimani3443@gmail.com>  
> 
> This seems probably okay, but I'm not willing to ack it as an RFC.

You will get to see it again in the series moving the driver out of staging
so wait until then.

Looks fine to me as well.
