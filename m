Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A71F312829
	for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770814541; cv=none; b=bI68PwKiE7bYRp+OO7snbUcm9kTisEs7rwtExfg015k0ySLEvEaBE+cbvosYJ/rAJGho2RZ0C9JLUSkZU2Fof5AA8LxyReIBezSgkDUjdP7EQSHl7RriFWaTjZDBz3jOnUSgRXrYt/zv4+5WgtQnLaUULNolC3F0uNMLgkEdzyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770814541; c=relaxed/simple;
	bh=k+O0u2IvmIFydDBBwWEsNoG5Tp1feCaI/uirjw/tQC4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g35HyGbnDOLHhDGgXqd/Z4IbC718iO1YJ28jggGaxgQ4/ptMobwj/+grHtCg9zXJNiSTuADAXEbxyDGRtn68N633ACWSO8QFUdl/5EhALQv7rPQRul5RyjCSpc0R/q6W+HF7yGsa8pyz75ydviajLM7iPGgNvPB/QIVnwZahg4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlSWecOS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlSWecOS"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43284ed32a0so4621547f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Feb 2026 04:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770814538; x=1771419338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WLxvZJWNuqx2yQv6dj6BjPk+z7QDTup71k3RLa8ucFw=;
        b=hlSWecOSR6VHDXUd+8R6+wb8om5Hkhct+xSrbsCVCUpaguRyWZLfq9WtTUO6cmXrz0
         5SJnyY+SWSfbITsuiwxgj97ZoY6k/r71a1Po03UWp/jhxckuCYqN2kr00ksqxVtQ6lza
         9U35VjGz+MaJZcohbkIvuZSRBPcAYkjVXxveKUb6RYrHplohkgEZMCR1p2Y5RwWk+5os
         EGOf+EpxpCzHXqKrFyZqmFEY1BsBqDIrXjtczkZJLKVXUnao+sCYr+24y5GLKZG0U5qd
         gEbvGC6xX4Wd3b/06PjDny+GlZ5aKchpbV1LopPPPJJdXa2kJD6meAPYtNx/f0xhk1G5
         EJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770814538; x=1771419338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLxvZJWNuqx2yQv6dj6BjPk+z7QDTup71k3RLa8ucFw=;
        b=Ep3oAaaoJG/3HNzGW7kvkmR6VJZnRdFWm+liBI1pi0crOmIbtupMKaArvgTEr4tafV
         cRH//v+UACrRNoj0bX5gi97qb027nYL9inCmFh5DgEUvMHM8zD1qPi5omFgeyYr/F3Na
         RhLENSbZ2L7H7BhKWzJcWnDq1SLL2evTjCDuphtge82K/7B7clezPbxoyJyGqcF9R3BM
         Rnpk0NohDbtrU7BiL6qFbqzpJcJ5wds10REt+CdA1n0E8jhmIH9ULTfgE3FuuAKdcvWy
         EoJgK+maxegbc+EfhZiL9MeDYydY6npougVMBRDASZxuqAfLmngsJJrwcDxZ4syPPSzv
         Lw/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJSaCHC3uSdqfLjRDI4rk8GbgMPwgXZ5PDtVT1L6Botreadu1AYEvg/eyg+OlaWJ3I0XRmDI3mGV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZPKUiTHmeuqFoMNuxt1fa+pJEZlgEvqAM4MDAaBrPcaeAkOxC
	quXoOi7ElhW7dmyQRut4dvhSt8kgQtpTPyQgNh4KPhNctPax3JOuYP9N
X-Gm-Gg: AZuq6aLRE6C2e8UpavJpNv5ZQgI3/vl7t1OPu9xSbWaneZEVFxaKGR0M5+nzQg7x0Mw
	a7ivrUKQQ9ZnkfF0La6hwC2cMAFQTYVt2iQmj81eRMpkZVGMyfVHOh5Koe+pjs9yuqz5aOfVmKm
	ltthwp/bxnFeq6s1l851nSqczsMc8KyBMDH3HRS9QVN4iaAoKQRcZDQkUxDm0D9OnKreqGmF10F
	Z3v7T7O5hCsJ2ZZFB6wDPcIpDNHur2Pp9CldczQ7DjFAZSRPKfiUxm/QpYqECKxnyv9h2uyuP0R
	PIZRMGVmCRRYjBzv/Fkts8/FelU/NZi7bo4K2w/2xx7pKKCHJdH0pozX7EyhRPCGVr9qHaC49lf
	hckBhSTEgiwJAn66BYkERoSK3mLPYP2M5vjPUh34ALGwPVaNVYW0y4DwaKX74UfT6hkkCdcRMr9
	ny6+pR7Itdi0fi+m432qG1ps7Fj1yGkuzPPW7MICya3w7ljmix+c1BZ/e5F3LCFxbSJKjvcsUaV
	V1MHI7gpFuiXOZv
X-Received: by 2002:a05:6000:1ac9:b0:436:369f:39fa with SMTP id ffacd0b85a97d-437845ac452mr3104573f8f.44.1770814538395;
        Wed, 11 Feb 2026 04:55:38 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d3464csm5434698f8f.5.2026.02.11.04.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 04:55:37 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 11 Feb 2026 12:55:30 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 03/11] iio: amplifiers: ad8366: remove unused include
 headers
Message-ID: <appnjr2asjxadbvcf2fosrkvfwj3dkcnvq7tk74i4xa4ku5zr3@c7qedqneukyn>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
 <20260210-iio-ad8366-update-v4-3-15505f7b15b4@analog.com>
 <aYuNr8alZt-mjd5x@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYuNr8alZt-mjd5x@smile.fi.intel.com>

On 26/02/10 09:57PM, Andy Shevchenko wrote:
> On Tue, Feb 10, 2026 at 07:42:03PM +0000, Rodrigo Alencar via B4 Relay wrote:
> 
> > Apply IWYU principle, removing the following headers:
> > - linux/device.h: no usage of devm_add_action_or_reset, device_attr...
> > - linux/kernel.h: no usage of container_of, kasprintf, ...
> > - linux/slab.h: memory management handled by iio
> > - linux/sysfs.h: sysfs interaction is managed by iio
> > - linux/iio/sysfs.h: not using iio device attributes in this driver
> 
> Yeah, but it also means to add (a lot of) missed headers...
> 
> array_size,h
> dev_printk.h
> mod_devicetable.h
> mutex.h
> stddef.h

Are there proper guidelines for IWYU in the kernel?
Include headers end up including a bunch of others, so
the build finishes successfully anyways.
I understand that the concern is build time, so we better
include all small parts that are needed rather than a generic
header that includes that and much more.

This is the output of the iwyu tool without this patch series:

	drivers/iio/amplifiers/ad8366.c should add these lines:
	#include <stddef.h>                     // for NULL
	#include "asm-generic/errno-base.h"     // for EINVAL, ENOMEM
	#include "linux/array_size.h"           // for ARRAY_SIZE
	#include "linux/compiler_attributes.h"  // for __aligned
	#include "linux/dev_printk.h"           // for dev_err
	#include "linux/iio/types.h"            // for iio_chan_info_enum, iio_chan_...
	#include "linux/math.h"                 // for abs
	#include "linux/minmax.h"               // for __cmp_op_max
	#include "linux/mod_devicetable.h"      // for spi_device_id
	#include "linux/mutex.h"                // for mutex_lock, mutex_unlock, mut...
	#include "linux/mutex_types.h"          // for mutex
	#include "vdso/bits.h"                  // for BIT

	drivers/iio/amplifiers/ad8366.c should remove these lines:
	- #include <linux/device.h>  // lines 14-14
	- #include <linux/iio/sysfs.h>  // lines 26-26
	- #include <linux/kernel.h>  // lines 15-15
	- #include <linux/slab.h>  // lines 16-16
	- #include <linux/sysfs.h>  // lines 17-17

	The full include-list for drivers/iio/amplifiers/ad8366.c:
	#include <linux/bitrev.h>               // for bitrev8
	#include <linux/err.h>                  // for IS_ERR, PTR_ERR
	#include <linux/gpio/consumer.h>        // for devm_gpiod_get_optional, gpio...
	#include <linux/iio/iio.h>              // for iio_priv, iio_dev, iio_chan_spec
	#include <linux/module.h>               // for MODULE_AUTHOR, MODULE_DESCRIP...
	#include <linux/regulator/consumer.h>   // for regulator_disable, devm_regul...
	#include <linux/spi/spi.h>              // for spi_device, spi_get_device_id
	#include <stddef.h>                     // for NULL
	#include "asm-generic/errno-base.h"     // for EINVAL, ENOMEM
	#include "linux/array_size.h"           // for ARRAY_SIZE
	#include "linux/compiler_attributes.h"  // for __aligned
	#include "linux/dev_printk.h"           // for dev_err
	#include "linux/iio/types.h"            // for iio_chan_info_enum, iio_chan_...
	#include "linux/math.h"                 // for abs
	#include "linux/minmax.h"               // for __cmp_op_max
	#include "linux/mod_devicetable.h"      // for spi_device_id
	#include "linux/mutex.h"                // for mutex_lock, mutex_unlock, mut...
	#include "linux/mutex_types.h"          // for mutex
	#include "vdso/bits.h"                  // for BIT

After all the patches are applied the output is slightly different:

	drivers/iio/amplifiers/ad8366.c should add these lines:
	#include <stddef.h>                     // for size_t, NULL
	#include "asm-generic/errno-base.h"     // for EINVAL, ENOMEM
	#include "asm-generic/int-ll64.h"       // for u8
	#include "linux/compiler_attributes.h"  // for __aligned
	#include "linux/dev_printk.h"           // for dev_err_probe
	#include "linux/iio/types.h"            // for iio_chan_info_enum, iio_chan_...
	#include "linux/math.h"                 // for DIV_ROUND_CLOSEST
	#include "linux/minmax.h"               // for __cmp_op_max
	#include "linux/mutex_types.h"          // for mutex
	#include "linux/types.h"                // for __be16
	#include "vdso/bits.h"                  // for BIT

	The full include-list for drivers/iio/amplifiers/ad8366.c:
	#include <linux/bitrev.h>               // for bitrev8
	#include <linux/err.h>                  // for IS_ERR, PTR_ERR
	#include <linux/gpio/consumer.h>        // for devm_gpiod_get_optional, gpio...
	#include <linux/iio/iio.h>              // for iio_priv, iio_dev, iio_chan_spec
	#include <linux/mod_devicetable.h>      // for kernel_ulong_t, spi_device_id
	#include <linux/module.h>               // for MODULE_DEVICE_TABLE, MODULE_A...
	#include <linux/mutex.h>                // for mutex_lock, mutex_unlock, dev...
	#include <linux/regulator/consumer.h>   // for devm_regulator_get_enable
	#include <linux/reset.h>                // for devm_reset_control_get_option...
	#include <linux/spi/spi.h>              // for spi_write, spi_get_device_id
	#include <linux/unaligned.h>            // for put_unaligned_be16
	#include <stddef.h>                     // for size_t, NULL
	#include "asm-generic/errno-base.h"     // for EINVAL, ENOMEM
	#include "asm-generic/int-ll64.h"       // for u8
	#include "linux/compiler_attributes.h"  // for __aligned
	#include "linux/dev_printk.h"           // for dev_err_probe
	#include "linux/iio/types.h"            // for iio_chan_info_enum, iio_chan_...
	#include "linux/math.h"                 // for DIV_ROUND_CLOSEST
	#include "linux/minmax.h"               // for __cmp_op_max
	#include "linux/mutex_types.h"          // for mutex
	#include "linux/types.h"                // for __be16
	#include "vdso/bits.h"                  // for BIT

-- 
Kind regards,

Rodrigo Alencar
