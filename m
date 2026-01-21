Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8483EDAB1
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 20:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025671; cv=none; b=OXfqsyfVrP512yscrJVoUjn46CseK6z+OGHCSDRnR8JmWU5vxgJ7ZB/HIOqJIUmr93KdqEpMcgIvDt3RnEv6zRSljWtFCjrY6PVwtN0QduVbrw38M3e+0lLAs8MVJBliFDODsIhPaOC8oSuv2bexuzYQt9wsqBcoeJ9oVlDn0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025671; c=relaxed/simple;
	bh=li8HtJW6b7I2ovEM/SnpMklHwQYRCf0hBaNiMsIiBbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MtGWB/asw/8Y/u7VmS9EEv210BZqXrmDP3O68ClJ1FvSHYJBVGFYmb7UJMP7H19NLq3yPSDALufdv307uR3Qf7OiuIxugZ+Uu6+v/m3Uw+Tt5NXK/Yei3g9bIDBFn40+8kusVwc/kJst4hYBF5g63sf8wAbQwB8JoDK9lQ7Qh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9hW4pMK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9hW4pMK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A06C4CEF1;
	Wed, 21 Jan 2026 20:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025670;
	bh=li8HtJW6b7I2ovEM/SnpMklHwQYRCf0hBaNiMsIiBbM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G9hW4pMK2758LWErT3aF4PWgYo8o+aUiATZteIsOCndN/I2ejwKbhIL2A0HJ1p8jZ
	 uYqDOBQhyeh8EhPCm8g/3lO5k1KccDaZtRDGQEKwIFq/O1YC3TPW63GhajswAjn719
	 mjy1Mq4a0kFnos1YVaIMuKo9frebFyt/oUha74b6y8BXlewBrQabT1XTSKZ4lmbAGP
	 fP2Nf2pJroXQDLQPJ1AXlbeCSs1hFRI2EeHipnvE9e6vz5ZZqQ7V3ZyCBdQsmrkVD0
	 sHbyBqCQvt0j+yHoVN2lT4V/Dq9AfNDDrBHXnb6CiHSyL5/anoqslFQF2EDSPHo2oG
	 w3zF2ugS0t2Bw==
Date: Wed, 21 Jan 2026 20:01:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] iio: magn: mmc5633: Add some ifdef / __maybe_unused
 until stubs available
Message-ID: <20260121200102.2ef0cf00@jic23-huawei>
In-Reply-To: <20260120220328.771b2589@jic23-huawei>
References: <20260119221736.804825-1-jic23@kernel.org>
	<20260119221736.804825-3-jic23@kernel.org>
	<aW8tWECNSvLTTKU8@smile.fi.intel.com>
	<20260120215627.371741a7@jic23-huawei>
	<20260120220328.771b2589@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 22:03:28 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 20 Jan 2026 21:56:27 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Tue, 20 Jan 2026 09:23:04 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> >   
> > > On Mon, Jan 19, 2026 at 10:17:36PM +0000, Jonathan Cameron wrote:
> > >     
> > > > The I3C tree has Frank Li's fix for the case of I3C not being built      
> > >     
> > > > https://lore.kernel.org/all/20251230145718.4088694-1-Frank.Li@nxp.com/      
> > > 
> > > Make it a Link tag
> > >     
> > > > Given those will only be available upstream at the next merge window
> > > > and the ordering of merge of I3C vs IIO is uncertain, apply some temporary
> > > > stubs in the driver to avoid build issues.
> > > > 
> > > > This can be reverted next cycle.      
Dropped this patch in favour of the immutable branch Alexandre pushed out.

Much nicer than this hack.

Jonathan
