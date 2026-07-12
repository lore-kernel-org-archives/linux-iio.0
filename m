Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EF325776;
	Sun, 12 Jul 2026 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820148; cv=none; b=mcosPkzcQpuedlQZZZN6U3BQM0MJNDSNMOZuvXLLXqR75+7U0M/jqWBeWlzOIbgeFvBK4GXA0WQwwrtOMhWXemXnUyVX9DOQqvhwrCsp/PAYs2TXyl+LCykPkAyOKVZBnnSWDyHW+fS03EnDthKycPIRWWTGka2hXD0QZoZOCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820148; c=relaxed/simple;
	bh=6UjgPDQJU9g9ocffKn/sWf4wucBgYsn+gSFtxvodp3U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdbxcsikyiNgoG+cAMPG+Zob1VHooZ7+vsKD/26+EKCG1+ueC3M8vnC/0BklqPCqRLqJxZ+6TjXSYVa+mrXhFitrEGkb+PGS5E/28g3kU48i6TB5YEPp2wPJGb4zFUe1Djp2oev4SvczsX6mMRFm49WNongTw/MVAvN8vN4tWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMsfDJ98; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMsfDJ98"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7761F000E9;
	Sun, 12 Jul 2026 01:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783820147;
	bh=cQK2A+OEHOwvC9Tm/hM/Fme/RNbMFN7n9IRppb3sICc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mMsfDJ98wq44aQ/dw8TOuII5801VpB/O+I4mGW/uNn2KIkfBTZsvjro0gRRvx74OE
	 6AaPMweSOw0xnuS2dkJHLjRxD9padlGtq8jwyB60n4JJHlwe2T26yNxkJJjXrfcZHc
	 lDL3pq7VDuiSaY0jIw8yhqmAzeuNlSV+j2Z3kce/RKwcS3c55HqcbNEKy0tCCZIIp+
	 vC6m7zdyj3ufDYwAt8k96GQCeBhhIJ9weCnyN9sLHPMGS+AYbFzsDrcJn1Bmo7NI0Y
	 uouLu7Emp2w+ZG9VEEJyrbkdyFSmeBzJwFeRqnhFwgE5JxppWbDfUjNJlYSxbxLkig
	 hUXGXx2hTzkOA==
Date: Sun, 12 Jul 2026 02:35:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 17/17] docs: iio: add documentation for ad9910 driver
Message-ID: <20260712023540.7d1af91f@jic23-huawei>
In-Reply-To: <20260707-ad9910-iio-driver-v7-17-a4ec30f63700@analog.com>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
	<20260707-ad9910-iio-driver-v7-17-a4ec30f63700@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Jul 2026 15:04:38 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add documentation for the AD9910 DDS IIO driver, which describes channels,
> DDS modes, attributes and ABI usage examples.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Based on my slightly tired Saturday afternoon reading I'm happy with how all this
looks now.  Did find one thing to comment on though ;)
> ---
>  Documentation/iio/ad9910.rst | 792 +++++++++++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  3 files changed, 794 insertions(+)
> 
> diff --git a/Documentation/iio/ad9910.rst b/Documentation/iio/ad9910.rst
> new file mode 100644
> index 000000000000..ab5223c70c01
> --- /dev/null
> +++ b/Documentation/iio/ad9910.rst

> +
> +  echo 1 > /sys/bus/iio/devices/iio\:device0/out_altcurrent100_powerdown
> \ No newline at end of file

Add one.


There were a few really trivial things sashiko called out in earlier
patches such as %lu for long unsigned prints. I'll just assume you'll
tidy any of those up for v8 + the stuff Andy pointed out.

Otherwise I think this is all looking good.  Nice work on such a complex
device.

Thanks,

Jonathan
