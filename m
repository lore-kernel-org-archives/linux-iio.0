Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795841160;
	b=Od03Vx8b8dD2WTz5dLVkQOVM75jaOp0gff94tK+uyvndx/o4YNq4nDFGkvc1ppB/ndxE
	 iPXk4mLbc+k/jjp0a1hXhF2leYiyTkj+T1q22Nl7rk2ADLuZV1EPClgyRatMKoUlgGbWD
	 5oOmIUNvRFxCoLPs0w5APylchek1ktJO1kAEwdwZsH39UZOXTEuye/FT0F2rnt1iOYouI
	 GnOr/4YjwbyXCSPGwcf8FtXBfvjtiO+fRGWIawY/dnVyCHP04v26232leVNyQq38VnAfB
	 Y7BoZdp8oYzUX0W4jKMkTIdqySMSWNea+tZZiYk8nFr8xzz9UVb+HDIuWDFkhCl514w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795841160;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nvQgGmaz+1Yaxt2xBwkGWoCj42B/5xoZDotx73Xgz9Q=;
	b=Milsn/fxKr9o3m3VDSrJ1uVtf1nvNjtQ+kj3IQdbBdGnQVMQ5mt8ljuYnfyULcQ0AFj5
	 7cYQF/Mi1D2tWwUJOvrZqsSURAfsvY1h8L4RrMPMmtGYqNACBGq9t6j9BgR0MYaWqk45t
	 SrTWF3dN+aqBwCoaMH0vjFLmFrdG4j+cDtUhTJEiw0PzLvxz/SC7VPKDN2dvHWoyy8vlm
	 mZNuokx3glCjyb5ms2hBm8Z1U0JZrWTm27OUwmknuIE1giBiTKa97/jmSeQTVDVV++4T1
	 ovNUC+cbCnvEmQxr/wcDTkVJaKpy2FY0CkPl7IWrsAUE1AId2g2c+GJUP1snCSvGDsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZX+z8A4H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB59606A31C;
	Sat, 28 Nov 2026 04:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZX+z8A4H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68AB1F00897;
	Sat, 28 Nov 2026 04:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795841160;
	bh=nvQgGmaz+1Yaxt2xBwkGWoCj42B/5xoZDotx73Xgz9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZX+z8A4HWRYZWy3zyIf9EW5i57eN0XDBUjdW2jCUAA0MefstOB4JXLwhqHttM3ZnR
	 9Vz3DnBhV+zmMfBsbk/O4FgcAj/ThcVMy5DU+ysx/DCZCpKcCkEHYXNEcv1KG+cdBV
	 5ixYJy2aZgegia0JAEmDL4yNRHyhdM2bMTxIgT+cRY+HLmqb8SwmUPUeALSsxzKonC
	 A4+ob8byJdcSoWb177uTwfec0JOhbh4O7yeFlOi5Zl7T4D2h1nRmTs9i5Dpw+c/yei
	 0RmkFfw0eN533C3E2NIZtKKh7olVhgyabK2PfLaBy7XTVngjb8bBlNnTwsfEeZXdqt
	 mYE3Jg22TItBw==
Date: Sat, 28 Nov 2026 04:45:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michal Simek
 <michal.simek@amd.com>, Conall O'Griofa <conall.ogriofa@amd.com>,
 <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <git@amd.com>, Sai Krishna Potthuri
 <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v6 14/16] iio: adc: xilinx-xadc: Split driver into core
 and platform files
Message-ID: <20261128044552.6bf275be@jic23-hlaptop>
In-Reply-To: <20261125171045.1246381-15-dileepkumar.nagavarapu@amd.com>
References: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
	<20261125171045.1246381-15-dileepkumar.nagavarapu@amd.com>
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

On Wed, 25 Nov 2026 22:40:28 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Split the xilinx-xadc-core.c into separate core and platform specific
> files to prepare for I2C interface support.
> 
> xilinx-xadc-core.c is reorganized as follows:
> xilinx-xadc-core.c:
>   - Platform-independent IIO/ADC operations
>   - Channel definitions and management
>   - Buffer and trigger management
>   - Device tree parsing
> 
> xilinx-xadc-platform.c:
>   - ZYNQ platform (FIFO-based) register access and interrupt handling
>   - AXI platform (memory-mapped) register access and interrupt handling
>   - Platform-specific setup and configuration
>   - Platform device probe function
> 
> Update Kconfig to introduce XILINX_XADC_CORE as a helper module selected
> by XILINX_XADC and update Makefile to build the split modules:
>   - xilinx-xadc-common.o (core + events)
>   - xilinx-xadc-platform.o (platform-specific)
> 
> Reorganize the code with no behavioral changes.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Sashiko calls out that the module name changes and even if that is fine
for userspace on these devices, the help text in Kconfig need an update.

https://sashiko.dev/#/patchset/20261125171045.1246381-1-dileepkumar.nagavarapu%40amd.com
A few other comments apply to this patch.

There is stuff on patch 16 as well.

There is also something strange about the patch split up.
This should be moving code but a lot more is removed than added. 
I think that's because this is treating xilinx-xadc-core.c in two
ways, both as the basis for itself (lots of code removed) and
as the base for xilinx-xadc-platform.c (lots of code removed there
as well).  This has the odd result of seeing like lots of code
is being remove whereas it is just moving around.  Probably easiest
solution to make this revieweable is to turn move detection off
for the git format-patch.



> ---
>  drivers/iio/adc/Kconfig                       |   8 +-
>  drivers/iio/adc/Makefile                      |   5 +-
>  drivers/iio/adc/xilinx-xadc-core.c            | 688 +--------------
>  drivers/iio/adc/xilinx-xadc-events.c          |   1 +
>  ...inx-xadc-core.c => xilinx-xadc-platform.c} | 805 +-----------------
>  drivers/iio/adc/xilinx-xadc.h                 |  28 +
>  6 files changed, 67 insertions(+), 1468 deletions(-)
>  copy drivers/iio/adc/{xilinx-xadc-core.c => xilinx-xadc-platform.c} (44%)

