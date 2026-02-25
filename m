Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE0344D8F;
	Wed, 25 Feb 2026 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020766; cv=none; b=hBowkw9Mh9qvzf7mnxTxsE/bZlUxOLRxSeYc+gNgBkQ0iC15qCvbhHZQSKnX/EKwh9K4J46UVYNbTywOl8F8y5f0/YPHVjrHJ7PVDd8kElYxJI4dcuGE/RNIZng+ZL9MwebWnzPaimRjaE6GQJhiVNB2sX+df6MS7ogf8uDcsPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020766; c=relaxed/simple;
	bh=JANq9GkmALb9gCdb/l8qUBhh+DVxGkmSlXLaW+Kux3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDAk/U7rzH610VSGc+tWtE1OBYH7NMRYy+L3eQhHI2xiHu6rJs/zUbQT2/y6BTZYOXp51mv+ostaqb0z47gOr9swOAZmYRvMxJzDzhzj8c1DgArL9HcjKI1qX49zG5Px0BWZpGSbDed1VWWmQuV3ukbKsDRBQCd2DmvJp3xZl3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXTxNa81; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXTxNa81"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772020765; x=1803556765;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JANq9GkmALb9gCdb/l8qUBhh+DVxGkmSlXLaW+Kux3E=;
  b=aXTxNa81frKSwC40QMoz3zSyC2fXXBSMrWnFm+EtgDbrdESxAMalt4QM
   mkwS154dRhMgiQVkraFuXANNWhJp5HTD8HDEy+yHZuQKO9fzqXe0JaiZE
   cZqE4bwwENWDFSKz8UyGdC/E0qPDG75Xg0y9VEy/3teGihAQp4+7QsZHB
   GE1ms8myG+DN8YOP46MS+T1frA2OHotVKhQ9O6V7r6rX4eevzAljk4vBR
   VDBSdmL6bhtBcQkXybNJ5JBEVjApeZxmt3eMEejZcUvjzIrO2KLmZBTov
   xd7UQ+KJ+Lw0Rz1QxxdCHMRnNzqSvsiC6j8zr99kLdpSNTV8CMkAElNdO
   w==;
X-CSE-ConnectionGUID: IGcnmvQxS9iL4fm9TwBxIQ==
X-CSE-MsgGUID: qxQ7obIeSROTu/V3inkHlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84419360"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="84419360"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:59:24 -0800
X-CSE-ConnectionGUID: ZbopUOziTeeRAf5Ryx/Uvg==
X-CSE-MsgGUID: cZlJwkzHQ6qFy1h83m3nwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="215317664"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:59:22 -0800
Date: Wed, 25 Feb 2026 13:59:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linusw@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: gyro: mpu3050: Fix out-of-sequence free_irq()
Message-ID: <aZ7kGJxAy6kj8rWV@smile.fi.intel.com>
References: <20260224224818.2452675-1-ethantidmore06@gmail.com>
 <20260224224818.2452675-5-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224224818.2452675-5-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 04:48:18PM -0600, Ethan Tidmore wrote:
> The triggered buffer is initialized before the IRQ is requested. The
> removal path currently calls  iio_triggered_buffer_cleanup() before 
> free_irq(). This violates the expected LIFO. 
> 
> Place free_irq() in correct location.

"Place free_irq() in the correct location."


> - Clarify patch purpose

Still doesn't give me enough clarity.

The patch as I read it doesn't move free_irq().

...

But I leave it to native speaker and maintainer to decide. No need to resend.

-- 
With Best Regards,
Andy Shevchenko


