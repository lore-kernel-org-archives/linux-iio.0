Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1D528C5B1;
	Sun, 30 Aug 2026 23:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788134005; cv=none; b=htX0qpZyWMcFiOMTwkIztnZZaDVJldtbiUXZaXu0goQOthTDxotSgn9GfcEP49kEjBqovrzXxyTCnU4CirmrA8zCHVFxXsVYAYbqQAitc6dbN0XfX4h3Ucn1PlxxHVtOg9urhJGt5n2/NtPjS27flzprEB/upO7Ya7uVDNTAxH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788134005; c=relaxed/simple;
	bh=AgjI3O4F+GubT2JSQCY8Tpl0l3FNASSfQaXUdw4rbuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=heHEaPNQq5ImooiyZVOmAlqgXGMx1QyCTglwyn+SrwIviR7eKL9EnVvmEJrXYCq2WHAwPVJOu+Foc9bzMeP3f85yFLWZqz90UANP7AAHY3XyCaOk3k+e1m5ME+zRjlYPtANyK87VIra2xjrOWBH7Q+sY9I5vct2TAPy03/n5rAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy1bWdma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy1bWdma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED00E1F000E9;
	Sun, 30 Aug 2026 23:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788134004;
	bh=ldpcUbAWpGoUTXYsH8TqTNY0l9FCJaJkj70LvsUK7wM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cy1bWdmaNA1Z0aY0ArkK40kYsap+W135sn35yRmmBcCLq98pm4LUeEHfEeVUzCvhZ
	 WoJjPrpZZnOygPq9GjjuEW/D3zq/3U14mlbURSXxuAYhYymmGmTaPVXedbsT8Y9rVP
	 1fB0irasgk9moHOYu5MtX32VLo8+d0+AdrampQXaeO8Xq7Y3MpHkt8CNIlFF6RBlYB
	 hh9Uax+2aaPkGEmhnXgCec12xCQ7g41E8K51g0l8Wjg1UKjPNSXxf/MA9/qoTSVtzQ
	 WUqchdGPx7YyKR50+Iv38JGayCohdKy8HNE2dI1hF2eAWkLus4BZgYBWG09vEP/pv+
	 oQy9m0ItxGZVA==
Date: Mon, 31 Aug 2026 00:53:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad4080: allow debugfs register access to both
 channels
Message-ID: <20260831005317.41cf75a1@jic23-huawei>
In-Reply-To: <20260826111613.14218-1-antoniu.miclaus@analog.com>
References: <20260826111613.14218-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 14:16:13 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The dual-channel parts (AD4880/AD4883/AD4884) are built from two
> independent ADC dies, each with its own SPI chip select and register
> map. They are presented as a single IIO device because the FPGA
> interleaves both dies into one DMA stream, so only one direct_reg_access
> debugfs file is created and it can only reach channel A's regmap. Channel
> B's registers are therefore inaccessible, which blocks bring-up and
> debugging of the second die.
> 
> Select the target die through the debugfs register address: the low 8
> bits are the register offset and the upper bits are the channel index
> (0x0nn selects channel A, 0x1nn channel B). A read returns the real
> register value of the selected die and each die is addressed
> independently; single-channel parts only accept channel 0.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied to the testing branch of iio.git

thanks,

Jonathan
