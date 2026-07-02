Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5331625;
	Thu,  2 Jul 2026 00:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950878; cv=none; b=rSCbbYbFoUpQ1Pp+CAg7RaeEgFBgyzkhrwlDCUfodi3HOoAWOH3L4hkAOW32uiJtsWC/xYPJbEDaAgkT513nebrzFCt1cknGr2+PB6+kgKSbZ4GEk/Jr6mWSFqfmDsD0GIb4nOYg1bJ+KOkYssStlu00a4P1068h3B892yZCCZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950878; c=relaxed/simple;
	bh=bzxdzUIS5NV6E9ULD5j6j263CwKQY3bOG6VVfIV1MxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CAnf6Gd6mVEVKWS4QkQmT3nLDH59G1XFxycsz+oJaPh50sY4lFF7cv0xvGoiLi9BNQkJKZsqxcgGApdOpj8XeLuAwnXmqYQ804fEeW2RiG3ctDcdrU+9fziviO4awg5ZSMjzVmCQSqEiV5NUPo0cHSYOilTIIuMu/jL00UTh9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqSQWqrA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqSQWqrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CD21F000E9;
	Thu,  2 Jul 2026 00:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782950877;
	bh=USZvbHL/5lmXp/Rgdix7obUtc+zRhWFoC46JUXvjxEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iqSQWqrAeCMsMASgWXdtxARlmJLI2pDpwhkEGxVE/absAHGMAMee/90yLXywmXNhv
	 feNappUwQMwPf5QBfPFT7fKDtkaaGR2ZD3bSKdd52DyyuNxmr8LFApv/NjQbg7oMnl
	 kzl0+Cssz5sGXAnqsVN8PFghYxQk/rD1ONM1YAivCSq27VjE8OJXetL6UetJUTPEcU
	 Dway0nT0ZS7K7uaRajSa/2M5wfpwMiBoYKg95DwG3VwV3jMDn2zmFC/8lg8ff461VB
	 kIt0MOAfHfSS7szNo46aaWig6Wt5JCK6gtWYi6jpi1FJo/uOqzfxTA3m0dwotXwk0C
	 SNdzRlcfK5yFw==
Date: Thu, 2 Jul 2026 01:07:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <conall.ogriofa@amd.com>, <michal.simek@amd.com>,
 <sai.krishna.potthuri@amd.com>, <linux@roeck-us.net>,
 <erimsalih@gmail.com>, <git@amd.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 0/5] iio: adc: add Versal SysMon driver
Message-ID: <20260702010750.5156f461@jic23-huawei>
In-Reply-To: <20260624143722.4047649-1-salih.erim@amd.com>
References: <20260624143722.4047649-1-salih.erim@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 15:37:17 +0100
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
> Note: Sai Krishna Potthuri is added as co-maintainer and will be
> actively taking over the upstream maintenance of this driver going
> forward. Please direct any future review feedback to him.

Series applied to the testing branch of iio.git.

Thanks,

Jonathan
