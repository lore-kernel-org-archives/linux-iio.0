Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A632459DC;
	Wed,  6 May 2026 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084459; cv=none; b=KEgtuPb5J9gXtT6hXKP5Vrlg6XG9IEIvcWgZhF4YEmmxqpE22BVDEMDq3LYn2tZ/pEEJ5yEijDkUzxGFBBcXm2hp2b+gD8QrLg3kfnNtR0AyvyM+BYG+74grtyO920A4OCLeJtR7zwQ1W+noz5m+/WzTVtYEhRMz/LvBhbl0qGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084459; c=relaxed/simple;
	bh=m3tdzzxmxxS/E4/uW/QqWlCNnsEgb7gxgFSu8w1x4zw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLnyNsiojIYF3XBlrJBR06FRc6im9yXTxc+LVg5yNMlhsbPvw4edXTX/33BaRPBMgUECo86w6pHsPMQmHky+K+xTVMMA7ILzfVsL8EOY4q8OBQkwvV4lo/xXCxEoM0pHt847qcRhetsrTyZ8MihPrEQIXTFxMtSHjScVSIErbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbIQSwM0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbIQSwM0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F706C2BCB0;
	Wed,  6 May 2026 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778084458;
	bh=m3tdzzxmxxS/E4/uW/QqWlCNnsEgb7gxgFSu8w1x4zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VbIQSwM0dmhkDjtT6b+zOwcB8l3VDhRUwYcC826MKfocpp4AGGJnCFJWvi7T/GyZb
	 PVP+izu01hT3fooK2tRCY1Dc1AYAgpCytVCxPxvpS016mSX3nF2TacL7XeqnOJb+ob
	 21VFMd6/OdJjgjrsQ7Xru0Mzn9ZPdUBzbTbl6J7PUhlvtTPhBUhksFRUXuRrDuKNjL
	 c6gNL+AKx/1J5M5NrqPVLMM0pI3SbXsggCGf+7/DFTWsXlMM7GZD+tgUVfhce9lCBV
	 Zc5hIrKQQYHnoZ1UHbP2V4maSrTRqmoIh/1V4tqqdK3hifeB/6Hmv1MuXwBQFmxhde
	 pKvSDWY+fmUpA==
Date: Wed, 6 May 2026 17:20:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Salah Triki <salah.triki@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: humidity: ens210: Fix missing I2C functionality
 checks
Message-ID: <20260506172050.45a7c35b@jic23-huawei>
In-Reply-To: <CALoEA-x9KRBu7=a4m4bxpp2c8o=MVqxr+ZpUNB8uga+XYeYX7g@mail.gmail.com>
References: <20260506095835.10112-1-salah.triki@gmail.com>
	<CALoEA-x9KRBu7=a4m4bxpp2c8o=MVqxr+ZpUNB8uga+XYeYX7g@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 12:17:42 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Wed, 6 May 2026 at 12:13, Salah Triki <salah.triki@gmail.com> wrote:
> >
> > The ENS210 driver uses SMBus transactions (such as byte, word, and block
> > data reads/writes) during the probe and measurement phases. However, the
> > initial functionality check only validated a subset of these capabilities,
> > which could lead to loading failures on adapters requiring SMBus
> > emulation or native-only controllers.
> >
> > To ensure compatibility across a wide range of I2C adapters, modify the
> > functionality check to verify if the adapter supports the required native
> > operations or, failing that, supports the SMBus emulation layer.
> >
> > Fixes: c524fbca672e ("iio: humidity: Add support for ENS210")
> > Signed-off-by: Salah Triki <salah.triki@gmail.com>
> > ---  
> 
> Please slow down, you've sent two versions in the past 30 minutes.
> 
> Alignment is fine, but refrain from sending patches that quickly.
> 
The comments I just sent indeed applied to v2... So good advice
that you should slow down!

J

