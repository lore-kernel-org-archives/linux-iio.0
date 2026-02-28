Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8847B439017;
	Sat, 28 Feb 2026 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772278644; cv=none; b=GRuy9AtA3A2oIvGn/ddgNE+tSBT/Iwfg9NsfzXYBRgS8Xq5TKNgT8vASDfAcEECrFPzWyzhphnugvZcIfjrziivaEqqfpY2A+dVMB8Fu0muof+Q/a3KBaBhZa5TNoI1Huj6dFu/cKr7gnS3ifglp0Um1qgxxTexgOxslubD/Ris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772278644; c=relaxed/simple;
	bh=9sWvJC0+fOb9ZYtVGgMquRobScvbX951h0D/TFjuU14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eC3KY4tDzJ9O2+IlqyxMTw0ffmlW6F9SwapU3PtOiCt2JfQ0rmfe+G+/WH+5feWFRr5fYKd0WQSYiG0fkKvlJ17fzCQm6PZuQL8L3DnB8q65wXNfAxA6hAu2whMx6i95GYWDPp4jYES4Bz8jMGwR6FwnntFXz2Dt0O6wRBkEhdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr15pQXi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr15pQXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231B3C116D0;
	Sat, 28 Feb 2026 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772278644;
	bh=9sWvJC0+fOb9ZYtVGgMquRobScvbX951h0D/TFjuU14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xr15pQXinlAZDaGpGJrjdRML4Y+ri9kNtrmEOWkcL2RUJbGjg1zeBmoMw8vVmYRWS
	 chIGhSbKQvcpom+vjTu0WAV/c8YT3uH26f2iWcdllS1AtJPH2Y7S5Odh03LiKFeQAT
	 Rrz6kaQtTHjiW4Lad9G4QeVKM16z6x/RR1A6qoIoochXSqpzXXEJS2r4vHW3bUusw9
	 mwugybYq+uTIG5oPJc9cRpm5SQ1/kAo+0oktictu+PgdZIbOz0NhAcmkZGx3Q4IaWM
	 Q64j0rl2HAwxB9L2ZrW1ryWa3J//xn92KvmTnURKxFqebSowrq1d9QLx/qScVHebhi
	 FeRf699bRqxjw==
Date: Sat, 28 Feb 2026 11:37:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/12] iio: use dev_err_probe in probe path for ADI
 drivers
Message-ID: <20260228113715.3d0c4312@jic23-huawei>
In-Reply-To: <aaGyUMNzk9cNC5LG@ashevche-desk.local>
References: <20260227140152.77529-1-antoniu.miclaus@analog.com>
	<aaGyUMNzk9cNC5LG@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 17:03:44 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 27, 2026 at 04:01:29PM +0200, Antoniu Miclaus wrote:
> > Use dev_err_probe() consistently in the probe path of several ADI IIO
> > drivers. This simplifies error handling and ensures proper logging of
> > deferred probes.
> > 
> > Each driver is updated in two patches: first introducing a local
> > struct device *dev variable alongside the existing spi variable to
> > replace &spi->dev references in non-error paths, then converting
> > dev_err() error paths to use dev_err_probe().
> > 
> > Drivers updated:
> >  - adrf6780
> >  - admv1014
> >  - admv1013
> >  - adf4377
> >  - ad7293
> >  - admv8818  
> 
> > Changes in v4:
> >  - Split each driver update back into two separate patches: one for
> >    introducing the struct device variable and one for the dev_err_probe()
> >    conversion. No lines are edited twice cross patch pairs, error-only
> >    functions get dev introduced in the "use dev_err_probe" commit.  
> 
> Thanks, I briefly looked and it looks fine to me,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Applied with a minor tweak to add () after dev_err_probe in the
the patch titles.

I like to encourage that way of indicating functions and don't want too many
patches not doing that in the tree.  You had the () in the more detailed
descriptions so this is a really minor thing.

Thanks,

Jonathan

> 

