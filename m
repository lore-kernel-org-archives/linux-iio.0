Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19987388E50;
	Thu, 28 May 2026 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969972; cv=none; b=QI/oEw/ar0/CRxYWrjDJW4rDPGoHroN6KV3ZpXCidFPPMMQfrS4mRUjPwR6FIAJhJtOpCy0Jr/+N16uJnjQVEh9PicEiPrsqiMk829nsaQl5XSNJeI18A7elqit7mAh52Socmnz8EjDc2owpDYL43yuVfCzEBqn6J+rQeKCYtgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969972; c=relaxed/simple;
	bh=wO6ShTRMs4p0CGwoiMPQIQNyuGT+yrUs1ByMUOmXqsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dD2HDHPYusCj5c3UfK4RePIysNSDLkOUzHdpn4BLhR/ked7qS3tJjHOda4VzeAV+23QmWNEjLR0wMhsRIfPWZgOTzS1Wu85FlpkIvUn3YgdF9r8O65/PIsOlUhgDoY2/NFipjY8Q72G7DpDmBs1JptarNBe06f4YyaHKIZ2H5h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUQO4mwc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUQO4mwc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E141F000E9;
	Thu, 28 May 2026 12:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779969971;
	bh=uZXqNP2oDdFmWvcjBpVw8LqAgKQ/EeWxQkfMBC2l6wk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CUQO4mwcvwOKe2AMms9/Sbu2jBuw8xphobb7Mq7uLxBe03DbQKjWawq+/sduPLDLr
	 b63aWV2oYDrzQe4HnOsxSPaQmSktdgdzMg7t0vX4wtDRDMARuIDgD7Xe5fBkWg+Aj3
	 lrYDyqvublNlS09bEtZ6zFIHvviSIevm0dHeqbuk6wfBVkH8qRvhNzkW+99PMVvZWd
	 N4beAMzhdbEjCQfCQZ5RwqmS6xyoSsYncLInsedsysfncw4IPz+Y9VTYGwwkV1/jZ6
	 z3MLNEHeS50CB9/WqwYoF0r6p9/5yykHH4O2dIjVHcHtEovUJIGbDoJd/9e+X6wNmG
	 f40u/XEhzAifA==
Date: Thu, 28 May 2026 13:06:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Conall O'Griofa <conall.ogriofa@amd.com>,
 Michal Simek <michal.simek@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Salih Erim <erimsalih@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] iio: adc: add AMD/Xilinx Versal SysMon driver
Message-ID: <20260528130600.25e401a7@jic23-huawei>
In-Reply-To: <20260527114211.174288-1-salih.erim@amd.com>
References: <20260527114211.174288-1-salih.erim@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 12:42:06 +0100
Salih Erim <salih.erim@amd.com> wrote:

> This series adds a new IIO driver for the AMD/Xilinx Versal System
> Monitor (SysMon), providing on-chip voltage and temperature monitoring.
> 
> The Versal SysMon measures up to 160 supply voltages and reads up to
> 64 temperature satellites distributed across the SoC. The hardware
> also provides aggregated device temperature registers: the current
> max and min across all active satellites, and peak/trough values
> recorded since last hardware reset. The device can be accessed via
> memory-mapped I/O or via an I2C interface.
> 
> The driver is split into a bus-agnostic core module using the regmap
> API, an MMIO platform driver, and an I2C driver. This allows the
> same IIO logic to be shared across different bus transports.
> 
> Previous submissions:
>   v2: https://lore.kernel.org/all/cover.1746182670.git.salih.erim@amd.com/
>   v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/
> 
https://sashiko.dev/#/patchset/20260527114211.174288-1-salih.erim%40amd.com
Quite a bit of feedback.  Some of which is clearly garbage, like the
ARCH_VERSAL suggestion, but take a close look as it does tend to pick up on
stuff that humans miss.
