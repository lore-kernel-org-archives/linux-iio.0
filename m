Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21DB3EBF11;
	Sat, 14 Feb 2026 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771093861; cv=none; b=XkjWAZgnxEpFUtaD+jMHlrv5yKrokO9pA1MsF8h/6ulLPWL1Bpd5GlIofubFGXnXA4FR1yX8reL73aeindKMydAZVosyT3xrWcSjpxMeh7DKSQmkG6FKI8oOGkBAYxFIQKEn6dIciYzkl9/odFKGoGqoUW00CTaz9sy4nDJ1r10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771093861; c=relaxed/simple;
	bh=Ua4l3xJp7hde7/JLEqCM/G5dmZFB+E+3EMbzDdjE3D0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCarZ34iXoxh4JqKCNuUXVG+2sVDRbeIPwS/4o6jpdnoiOdf0q7VnYVoYFuzzzNfVJPU7wWozYgEDJ5ogn0SmLKSwXxb59UxSNreluCkGi6btRT2oG6LBTtIYDIsH3wTVtjqAGtpof1qKI9j3orMoYLTWOea7NjDTs7h1NRgfQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll6lbfYy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll6lbfYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A43FC16AAE;
	Sat, 14 Feb 2026 18:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771093861;
	bh=Ua4l3xJp7hde7/JLEqCM/G5dmZFB+E+3EMbzDdjE3D0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ll6lbfYy2UIp8Gy+gAdoYbfcgtb+tfYzqwUvUpFXhsu0u4TMG4uuDBcanN2l18T/Q
	 Mw6MWA9BEHfpdUuCeim+U7ur/L1a9apvncBuw9ExeogWFpcI5nycCdBksuQ4dnL/ds
	 tsuKCPvJZQyuIAiy4tX3oYPsYMRShyUyYojwiikPTbDprMfbF2HnEBNKm3ph2OLrO4
	 JMZd242TihpRvNWGMXEKnFfRVErArBGy3fSnWKGMlGjS0ceLWknAm3cEQwi+OTYJ7G
	 /MWk1o6WKsUDK0vTToYveckZxtQLSoOtvGl1DclFbBbnQp0r55lt8d1g6BeRUpmBm7
	 ECdE8zHOkKFxQ==
Date: Sat, 14 Feb 2026 18:30:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 03/11] iio: amplifiers: ad8366: remove unused include
 headers
Message-ID: <20260214183051.712c8c4b@jic23-huawei>
In-Reply-To: <aYyFpFAQcfn7Qifn@smile.fi.intel.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
	<20260210-iio-ad8366-update-v4-3-15505f7b15b4@analog.com>
	<aYuNr8alZt-mjd5x@smile.fi.intel.com>
	<appnjr2asjxadbvcf2fosrkvfwj3dkcnvq7tk74i4xa4ku5zr3@c7qedqneukyn>
	<aYyFpFAQcfn7Qifn@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 15:35:32 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Feb 11, 2026 at 12:55:30PM +0000, Rodrigo Alencar wrote:
> > On 26/02/10 09:57PM, Andy Shevchenko wrote:  
> > > On Tue, Feb 10, 2026 at 07:42:03PM +0000, Rodrigo Alencar via B4 Relay wrote:
> > >   
> > > > Apply IWYU principle, removing the following headers:
> > > > - linux/device.h: no usage of devm_add_action_or_reset, device_attr...
> > > > - linux/kernel.h: no usage of container_of, kasprintf, ...
> > > > - linux/slab.h: memory management handled by iio
> > > > - linux/sysfs.h: sysfs interaction is managed by iio
> > > > - linux/iio/sysfs.h: not using iio device attributes in this driver  
> > > 
> > > Yeah, but it also means to add (a lot of) missed headers...
> > > 
> > > array_size,h
> > > dev_printk.h
> > > mod_devicetable.h
> > > mutex.h
> > > stddef.h  
> > 
> > Are there proper guidelines for IWYU in the kernel?
> > Include headers end up including a bunch of others, so
> > the build finishes successfully anyways.  
> 
> This is global stuff, no need to repeat this in the kernel documentation.
> It's the same as asking documentation for KISS principle.
> 
> > I understand that the concern is build time, so we better
> > include all small parts that are needed rather than a generic
> > header that includes that and much more.  
> 
> > This is the output of the iwyu tool without this patch series:  
> 
> Have you applied the configuration Jonathan made for this tool in relation
> to the Linux kernel project? By default the tool has a lot of noise, indeed.

Worth noting that I'm still evolving my config and suspect there will still
be a bit of 'taste' applied to the output even once I conclude what the
best combinations are.  So to give my view on the following..

> 	#include <stddef.h>                     // for NULL
Not this one.

> 	#include "asm-generic/errno-base.h"     // for EINVAL, ENOMEM
Something to get to errnos is good, but not that one.

> 	#include "linux/array_size.h"           // for ARRAY_SIZE
Yes - this is part of the kernel.h split up work.

> 	#include "linux/compiler_attributes.h"  // for __aligned
Never that one, but I sometimes feel compiler.h is fine.

> 	#include "linux/dev_printk.h"           // for dev_err
Yes if device.h doesn't have to be there for other reasons.

> 	#include "linux/iio/types.h"            // for iio_chan_info_enum, iio_chan_...
No. We always need iio.h which will always include that.

> 	#include "linux/math.h"                 // for abs
yes
> 	#include "linux/minmax.h"               // for __cmp_op_max
yes

> 	#include "linux/mod_devicetable.h"      // for spi_device_id
yes
> 	#include "linux/mutex.h"                // for mutex_lock, mutex_unlock, mut...
yes
> 	#include "linux/mutex_types.h"          // for mutex
no as mutex.h will alays include that.

> 	#include "vdso/bits.h"                  // for BIT

Usually via bitops.h or similar. But if none of those are there anyway linux/bits.h

Jonathan

> 
> And note, tool != principle. The tool is just an implementation of the helper
> to enforce the principle in practice, but it may be not always suitable for
> the certain project "as is".
> 
> In the below output some are valid, but some are just noise as there are
> guarantees for the "proxying".
> 

