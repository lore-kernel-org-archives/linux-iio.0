Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47977 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755101Ab1KPQQd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2011 11:16:33 -0500
Date: Wed, 16 Nov 2011 16:16:31 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 5/7] regmap: Check if a register is writable instead of
 readable in regcache_read
Message-ID: <20111116161631.GK29986@opensource.wolfsonmicro.com>
References: <1321457302-8724-1-git-send-email-lars@metafoo.de>
 <1321457302-8724-5-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321457302-8724-5-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 16, 2011 at 04:28:20PM +0100, Lars-Peter Clausen wrote:

> Currently regcache checks whether a register is readable when performing a
> cached read and returns an error if not. Change this check to test whether the
> register is writable. This makes more sense, since reading from the cache when
> the register is not readable allows the operation described above, but if the
> register is not writable there shouldn't  be a value for it in the cache anyway.

This logic doesn't entirely follow - one can have registers which are
volatile but could be read once at startup.  Plus...

> @@ -206,7 +206,7 @@ int regcache_read(struct regmap *map,
>  
>  	BUG_ON(!map->cache_ops);
>  
> -	if (!regmap_readable(map, reg))
> +	if (!regmap_writeable(map, reg))
>  		return -EIO;

...the code winds up just looking like an obvious bug.
