Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3DC3DB328;
	Thu, 23 Jul 2026 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847364; cv=none; b=mqdpFHwlmU/gKyKIRXWZy/nWnYYbZKMS7Q/7LhSIsHt20WM/VLw6+w8hn3al+z+3WVdTTzuh3Hkx+Z84mMevEq8vcF07H2AP+9EJZN3qgcXNhQfnYb39tvmPEBwpprk/htAZk4T/V0Sp4ySsgNaEB2W7YBtI8bqW30nAb/6F3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847364; c=relaxed/simple;
	bh=TCIYHnbEgDha0as0FGMyldFbLq5e7GSi5bYIPrhyuUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7HqJXlkm31KeYYKZejGPR+vGD3aVungGTdrT8EYgvXbwhbSuZXIEi+dm8v1h5L/ebajyEKSS+WB2sgspe+2vCHUZMpgMbz1S+Cw8E/Rl3b3fLFzhQFd3vd1ksZTVECzuat0kWoJrjP0OAnjwj0qAjUUhl3z/ibLpcG8Bv/G8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS8OI/9s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS8OI/9s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F3B1F000E9;
	Thu, 23 Jul 2026 22:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784847362;
	bh=cEcND7cdgvGk3/zKI1sFEcIpIT9+CB9qHHozSiU+uow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nS8OI/9ss4Cnisdzg3XUymvG7BdE1yT0hp6ZGxldiQGm4r2PrHesVj3QePCjr0FA4
	 mJDDiGWAuGIW1lEo0l8bj73pTY3kHCJZo7ykKSsWUyGQ+MiI2PXayascYHjydnhGJB
	 zujIaoeOAnBVsLBAB5c7LJm73elLZb/qrKRJjs1jnd90M7oFRi4/tX5hzUGY/LGPjv
	 2t0AaW78IQuwNF0h6q3GfFCdC8LvI+azNejBRLuQLr05fMpG8GYGsc7iMr7DIFEvxV
	 gIAHyo6YdQfhxXyqxqyZFkhKwURZFhszbQHb5nYgnj0bSWmKEGGAQZj2zc/0bc2BMt
	 kns1PXnsFjcdg==
Date: Thu, 23 Jul 2026 23:55:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] iio: adc: ad4080: add backend data size
 configuration
Message-ID: <20260723235557.59e283c6@jic23-huawei>
In-Reply-To: <20260713084043.10856-1-antoniu.miclaus@analog.com>
References: <20260713084043.10856-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jul 2026 11:40:41 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The AD408X AXI core can pack sample data on the bus using different word
> widths (20-bit, 16-bit and 14-bit), selected through the packet format
> field of the CNTRL_3 register. Until now this was left at its default,
> which only matched the AD4080 20-bit resolution.
> 
> This series exposes the packet format through a new data_size_set backend
> operation and has the ad4080 driver program it during channel setup based
> on the channel resolution, so the bus packing always matches the device
> realbits.
> 
> Patch 1 adds the data_size_set operation to the adi-axi-adc backend.
> Patch 2 calls iio_backend_data_size_set() from the ad4080 channel setup.
> 
> Link: https://analogdevicesinc.github.io/hdl/library/axi_ad408x/index.html

Hi Antoniu

B4 noticed you'd missed David's tag for this version. So all worked out
fine in the end but please make sure to carry those forward.

I've applied this to the fixes-togreg branch of iio.git.

Thanks

Jonathan

> 
> Changes since v1:
>  - Patch 2: expand the commit message to describe which parts were
>    affected by the wrong packet format, and added a Fixes tag.
> 
> Antoniu Miclaus (2):
>   iio: adc: adi-axi-adc: add data size support for AD408X backend
>   iio: adc: ad4080: configure backend data size
> 
>  drivers/iio/adc/ad4080.c      |  5 +++++
>  drivers/iio/adc/adi-axi-adc.c | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 

