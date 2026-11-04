Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793758630;
	b=zLPyu0CIlOsO23JdpKkoIFWJaqmraNTBfNkA1egWXrmdCtrCRjn/p4hHzRD/zGC4V6nm
	 y7oFTe/MplW3olmGItMWohV1aIkKffDE25DPQGYt4TL6GqMIxtK/ljJvir6E43ti/lSog
	 5jOxb/Rzqn+bLHDYEAtqUC07XNK/sV6BBfi+Inrg41x9aYl5/dEFMuVmQVdocs6sDGP85
	 ApV/BZFNKGDLuFtqJCNLon2AxYCQFsLkw9lL1s5DHdVmHoOugnVysjs11VzAJunU7nauD
	 XcaEqhEPb0CU+EarGQkDj3CpTV1PMJsGwJstbsh2Hx7sfWuTeYaV9iBsruB3XHwBzRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793758630;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=p3YG9kEFm3NPW8ft0/OqsZSKNoyKCRBirPcVbZhJlTk=;
	b=AkbHXM7cB8cl0KV7ljBPKDZrP0U5P7l3d6lQw3CY50hRYxV48LRsg4N0L4G2XxF2x6UI
	 3OvX8VvgTOIq0ICvM7FZ2rxWzi4AUIVOa80FmFD78NZBuQchMVwtcNUiEl8jDbz5R75NV
	 MwDzJt722Ur7TEiXGxQMTWkBIpLbUYpZiA7Ui0XxveYUTYL8C8OZMzdznrzNPu06BT0cy
	 jVUwvbEiuhZKSgvC+GdJxb/IbtcJF5BmwbEqY7mRwaoKgC7d1sXYbfqrzuD13CcJrckT7
	 +iPXeDjOT/Ar/rJW7mZ8tiYWXIhBghZWVs0xW7VchoTDD8eDtKBNUzCMMq6eGDkdyBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LT0e8ddR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D748606A31B;
	Wed,  4 Nov 2026 02:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LT0e8ddR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AEC1F000C1;
	Wed,  4 Nov 2026 02:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793758630;
	bh=p3YG9kEFm3NPW8ft0/OqsZSKNoyKCRBirPcVbZhJlTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LT0e8ddRSNPYY//n/ZxIa18+6C92Lv3ZPkPppabBxkFX+baCn+lA8jhFNGsqMXDNt
	 ruL3I/0VxHkBdR6TbY39mHqumXnaDfy2BnMZCHpHzwd7UYQYKsjMa8CCfhcdCgISrj
	 7Lu4W0Rs9/bSPRZXve4sul+Pdi9l1kUoo6WEzAhNiQ5o22Mmm/e2eFqDCsrTU5hdTT
	 /c7IbWOdQw3YDsWV2XqRaCZH9Y5wZGxsf4ENZFbUnkmCVZ2x2iYV9M38Ml+Ur2DvJO
	 VQpaCfxDH5LBLSuvEzHjMAmLbhkVNFPIC3JCIMGAa5QSjEgs/DFSUCP5nZJMDbCKhG
	 hc4CsyjRjVwpw==
Date: Wed, 4 Nov 2026 02:17:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux@analog.com, Conor Dooley <conor.dooley@microchip.com>, Marius Cristea
 <marius.cristea@microchip.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/3] iio: adc: add support for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20261104021700.14e69abb@jic23-hlaptop>
In-Reply-To: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
References: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 02 Nov 2026 15:49:03 +0100
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> The MAX34417 is a specialized current and voltage monitor used to
> determine power consumption of portable systems. The driver supports
> getting the channels voltage, average power and accumulated average
> power and energy over an I2C/SMBUS serial interface.
https://sashiko.dev/#/patchset/20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c%40linaro.org

Sashiko had views and the dt one at least checks out.
