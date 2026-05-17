Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098611A3157;
	Sun, 17 May 2026 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017665; cv=none; b=uHYsP22R3XcPMh+gQAii+jSIOy+lY1yYVa5K/UdkGjel8zi4iGW/umb6VId5h+yb3kieozS55ihtX5aE+VDJiBmAjXn7+AbiHQBJbQR1qCSFUK+Dpa+p4A10lTidO247a0TVg92RajNxoNAscV6W6bU+KjCJT46Rd8MQLMUUgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017665; c=relaxed/simple;
	bh=wfMJVcoTZNVlRjuHf5b/mEOjJp6wntkIQeuLhzP1m0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zhwhj2sxbL1dbVk0pXRGzGyo6epUzfbJshe7H2boaP1GEA+1g8gyHQtvSJ3F1rAyImtwf3F9N24jYOLZKMpiTQxJZYVMCuhDYqybefWkpv1cqLApFMBWQx9AcnoGsFFIgLiokWJO3j+cgdz3fqqEcMzxkIcyDOULvmu4m9p/DyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEdxs4ct; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEdxs4ct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6A7C2BCB0;
	Sun, 17 May 2026 11:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779017664;
	bh=wfMJVcoTZNVlRjuHf5b/mEOjJp6wntkIQeuLhzP1m0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JEdxs4ctVDEvHnT8+bI0xXDYXkjtH/5VJ+qLdauQFC2Ya3zsz0hFOeqMdekIHeKHp
	 Sp/+RJh2lLHBixz9YIg9WFBFbSwKT9LRymqzhy0/vi3SsotdxEp2/c3NNrmxtOgqnE
	 CMtVyMLZz7+aCcfMGX+RvCtlCMkGSPFcYaQX4NCpqxR2Q3FdiO9xzuT/VyZ3BFP4qk
	 dGlD1aQxQkNbJuY88LQdwf5EpImf46wIJNm6TMpuQn+mb35uuXSI/dokEXw6ARaSUH
	 3y/lXnBQ76EuVd+cQLLl0bKDvA1ALtGqIQdhyl0Hzbo3Xu72wYPdDhFtcXs/pJrN38
	 CLkCiAjkXAIYg==
Date: Sun, 17 May 2026 12:34:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Vladislav Kulikov <vlad.kulikov.c@gmail.com>, krzk+dt@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: magnetometer: add driver for MEMSIC
 MMC5983MA
Message-ID: <20260517123415.6bf8d020@jic23-huawei>
In-Reply-To: <aglecY6YjWccJTza@ashevche-desk.local>
References: <20260511191135.36691-1-vlad.kulikov.c@gmail.com>
	<20260511191135.36691-3-vlad.kulikov.c@gmail.com>
	<aglecY6YjWccJTza@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 09:21:37 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 11, 2026 at 07:11:35PM +0000, Vladislav Kulikov wrote:
> > Add support for the MEMSIC MMC5983MA 3-axis magnetometer. The driver
> > provides raw magnetic field readings via IIO sysfs with SET/RESET
> > offset cancellation for each measurement.  
> 
> Good driver, something to improve, though. Jonathan, can you tweak these in
> tree? But perhaps wait a bit for the answer on "why no cache?".
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
I tweaked the headers.  If we do enable caching can be a follow up patch.

Jonathan

> ...
> 
> + arrray_size.h
> 
> > +#include <linux/bits.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/delay.h>  
> 
> + dev_printk.h
> + err.h
> 
> > +#include <linux/i2c.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/time.h>
> > +#include <linux/types.h>  
> 
> ...
> 
> > +static const struct regmap_config mmc5983_regmap_config = {
> > +	.name = "mmc5983_regmap",
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = MMC5983_REG_ID,
> > +	.writeable_reg = mmc5983_is_writeable_reg,
> > +	.readable_reg = mmc5983_is_readable_reg,
> > +	.volatile_reg = mmc5983_is_volatile_reg,
> > +};  
> 
> Why no cache?
> 

