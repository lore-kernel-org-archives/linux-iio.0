Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF98C28030E;
	Sun, 18 Oct 2026 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792289269; cv=none; b=f0LCDhjPrgPM5g2bPhF4LfyaIlBKORoB+ZKf1ecca6PlMPv/p72LwlciwkyVZSkrbbdd44BeYtags+CVjdYGH4Fe9NHm6iO1PTjYhtSwyISPKvUh1DEzNjxff6A9BOzR1qung1ISBpcBLEQybOXAGrcF4RN9fIpEkLN0BB379/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792289269; c=relaxed/simple;
	bh=MYWq5SAv+Ny2R6A2JZ2sUCgj2jxXyi5C6e4oMcfqsX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJ8F6ktfYqXo++RCG5ao8KTdGYnU21fT3YcYj6zQpG0IvX+lD2F8dufBPgFeEazG4rTbp5I2pvc7a02H856rn08PjmM1Ot8OGrX6fX/jiUKAsqgfuC+eZOpu130jyiKk4YrNoMs6Mx4bVtI6cHFwX6I/QPT2Wu36yBOu8oID2iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8az8ogv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8az8ogv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992621F000C4;
	Sun, 18 Oct 2026 02:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792289268;
	bh=qugtnRY4wjYEoZCToKEFf1bLSECrLfdi7CSr1Ph9D4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f8az8ogvMv55eo2KhcCQE4syr9z/LG7l+0gz4Nzy6HqdiKdB9BF3dx6r7fqWyF4PI
	 p2yQS7upmXQx4OR218yhUr+DwBmDxtghlUuGH49QQ/uDB33b3gpZPar8mDd7pwJC0T
	 Nfu01HyYgQ0Ceuo7a2F3p9svt1fYurLGW87J9jNpigSgq9qnW9G3swB+Wjvf35d5G2
	 OwT4vrThgRz1gh1HMRljRv8Ei8C1mRwbzIA60xfeZIdv5/SlhZ0JdUfh03+L6+FiKe
	 u9zrjsl3NyM3zdCutUJVDN/l8ZP8k3O/TWdeOPvJt1hLCYAzp8genbfz6d7+miheo0
	 tpxb5dQ7ATnrg==
Date: Sun, 18 Oct 2026 03:07:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>
Subject: Re: [PATCH] docs: iio: add documentation for ti-ads112c14 driver
Message-ID: <20261018030744.13855d8f@jic23-hlaptop>
In-Reply-To: <20261002-iio-adc-ti-ads112c14-docs-v1-1-d5f3efb27727@baylibre.com>
References: <20261002-iio-adc-ti-ads112c14-docs-v1-1-d5f3efb27727@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 Oct 2026 15:05:13 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Add documentation for the TI ADS112C14 and ADS122C14 ADC driver.
> 
> These chips have several quirks that don't map cleanly to the usual IIO
> ABI, so it is worth documenting them for users. This covers how the
> devicetree channel nodes map to IIO channels, the system monitor
> channels, the order in which the interdependent filter_type,
> oversampling_ratio and sampling_frequency attributes need to be written,
> the settlingtime attribute and when it applies, burnout current, GPIOs,
> debugfs register access and the different behavior of buffered reads
> depending on which trigger is used. Also include some devicetree
> examples of typical sensor configurations.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
Nice doc.
Applied to the testing branch of iio.git

Thanks,

Jonathan
