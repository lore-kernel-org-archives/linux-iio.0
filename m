Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E035028C;
	Sun,  6 Sep 2026 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717964; cv=none; b=YH4d9GxsFb9TSQKrc6WgA5cgWa7Llf+eKIzKdbKjRlwZ8DwEPoA1JcUI+fCkTQBQT8+AFaxaKjeBJ9wfl6nZmtyd0Mec3U1saVYJhAFLs2KMy4HuB8aLieRdtZgpfdGaVU8qE/Lmc6VxSnlv02Ekv7hGRZwBKGPLi5EmQ2Q8ZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717964; c=relaxed/simple;
	bh=HzsS1xaw7cOngspNPlITimyKOflUXGk6qOxEkyPfIKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYBfC7T1W9fyl8BpaSGnIPyETIUApNO3vxns+3w7sFzNRdZ38bo62Mj2x3bElrL38cza9owG/AB3rNLpDlzdtpTUSzhemmGv1Bl1V9G37xFD1HQ6MzpL8rGe1uzg6YW5KFCgqO+zVq2BiaagRBSZfJr0YJHHHeAY9GQTT/rV8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aStquZO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aStquZO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5347B1F00A3A;
	Sun,  6 Sep 2026 18:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788717962;
	bh=mIeh8YyWTrPT6nFCBHIo5ND4DVX6wkNj8tR+MZbgDB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aStquZO1iT7Q0WXES6RUT2ua+8k4Mi0twf71+2qkln6xKaTm1yMKQ2JP0lF8+H0iC
	 52ywTrnh6pfwS1WrEm+od5NFVNdAFrL+iOMVMw3lspcp5O4eKrd9BSrp1JDMn+cWfG
	 jVLE8PnexMzMdIkNBJ/qoNAT7/wY75t8KJvfMzbpZ94EWlYIibUIkYPx+YL2Tx8tT9
	 kFNvFvWhsGkadhrfpuqLGV6rW+zBGEiA6qwOlBgRvLtEWgGH6szF1fZTcFTIq+OAgq
	 ydqApBatm8gnxMtwmY1qTrmnfQcQH3Vfba64cWjwzOV+0UZbAn4sW9ynX7pSU/jMGd
	 GkZf/so+WYLMA==
Date: Sun, 6 Sep 2026 19:05:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/4] Add support for AD5710R/AD5711R DAC
Message-ID: <20260906190559.7ca260f9@jic23-huawei>
In-Reply-To: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
References: <20260904-iio-ad5710r-upstream-v5-0-76f985b7d0ee@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Sep 2026 16:35:23 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
> configurable current/voltage output DACs with an on-chip 2.5V reference.
> Each channel can be independently configured as a voltage output
> (0V to VREF or 0V to 2xVREF) or a current output (0mA to 50mA).
Series applied to the testing branch of iio.git.  If that all looks
good I'll push out in a few days as togreg and linux-next will pick it
up.

thanks

Jonathan
