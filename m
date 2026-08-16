Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9363D25AD;
	Sun, 16 Aug 2026 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786911297; cv=none; b=HDtRATXmXvXjdUAdLUFTNz+32U5O+konPggJV2/LfB//hgWfKirXNdNqSe6jHuicHHEceS6tE73b9+NTXuXVjV1Apzl1iIAbHsxX5Zz7xZC51KO+W2qNPaK7DCuylC2S+X6fQl80UtXngKJA3LOkAMMXesFddU0DtzP6xyBJBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786911297; c=relaxed/simple;
	bh=HgMaIbpht4MYOaYEjJ/XGvtjCU10BcYlTnlktmGtyls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhA6JSGfN34as094iG3DbYyg5Im5YGm1YRKXyUW5B9CazRuMt9XonLI68Q/h+r4sEvtcRG3lM6Q7dXfa06+OCgD7buo+IqN30tU0wRJax5fkThJMnvk7KWiYRVra2ho5K/lDmnZcj9kKuf+U+N9XHkh5iI4zouSFnl8DtvtATnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J72o3Nsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J72o3Nsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DDB1F000E9;
	Sun, 16 Aug 2026 20:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786911293;
	bh=jsb4zZCofCT/yvgu+hOAiZPNwDqJ9kEyoKsyyEhqoVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J72o3NshL6uAdbGRJDU01rHzihJm6MiAapcdIkFWFjBY0PaS2G2mzLW4gb11b22qO
	 GUPGlCMPfEaXXf58wAn/rdb/4XegpZfrzpxOsYc3cLTx86XmWIFUjtWyZY6w+KJR5R
	 9YOYNHnEBRVJ8YulXwEJj6BSFRcRYDrulewWn8antZAbanIb/ZXaMBPD2aOpAMRlQM
	 1RrqZaCcPA+U9M7Xq4snNk6M0pmolNXxkPW9WgfxoZTuRqcRqd/C+cup5ZOQO/U2sq
	 /241cBgtunBDMN+AYVDWwg7a5p+rulLfJ8fjditE569kH891wE6dLm4O6riTYaTmOW
	 OeFHMezzRATJQ==
Date: Sun, 16 Aug 2026 21:14:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>,
 <linux-iio@vger.kernel.org>, <linux@analog.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: adc: ade9000: series of probe and channel
 fixes
Message-ID: <20260816211447.209aa35b@jic23-huawei>
In-Reply-To: <20260807085643.5502-1-antoniu.miclaus@analog.com>
References: <20260807085643.5502-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 11:56:40 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> This series fixes three issues in the ade9000 driver, all present since
> the driver was added.
> 
> Patch 1 moves the interrupt requests after the vdd regulator is enabled,
> so an early interrupt no longer runs a handler doing SPI accesses against
> an unpowered chip.
> 
> Patch 2 corrects the overlapping scan_index values for the current and
> voltage channels, which caused the Phase B and C waveform buffers to be
> configured incorrectly.
> 
> Patch 3 fixes the STATUS1 event scan bound so that Phase C dip events
> (bit 25) are actually reported.
Series applied to the fixes-togreg branch of iio.git.
They probably won't go upstream until after rc1 however.

I marked them all for stable

thanks,

Jonathan

> 
> Antoniu Miclaus (3):
>   iio: adc: ade9000: request interrupts after powering the device
>   iio: adc: ade9000: fix overlapping scan_index for current and voltage
>     channels
>   iio: adc: ade9000: handle Phase C dip events in IRQ1 handler
> 
>  drivers/iio/adc/ade9000.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 

