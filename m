Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA43D19E7F7;
	Sun, 22 Feb 2026 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771768266; cv=none; b=a2rVWBWj2Inw7plRBQYf02F63XbZrAOseBC2zgKyzwUq+InXt06RVoHSTGIQu9ogtJV8LKsFIrxJUO/kxx/K71iBUgG51NthbWqqMdfQ4gkrnsdqtIDUqjr5yJiCa8hArKjTJsfeUlG/o5u+SLAn2MArwBlDv5oS79baGs8VZGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771768266; c=relaxed/simple;
	bh=0r0ITLCkI48n18/3yLRb0z5fXGS1b+xMzZIIq3jWdy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adEmbcriqwuoS30hDHOp0mWcs0+4VSYcADCWHNRsLMYpZzVhDitBfLN4NirBJ+Gys2clE6bQ55zzJOKX6WQ27JjMzAX5IE9ipscwPds4y/Xf7BTjjPp6DnPushJ9efFixtpsQ5l+9WPF1Q5Bjkdfq8XTFEWMzRla1hXOY/K+vVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diTPENKZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diTPENKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2408C116D0;
	Sun, 22 Feb 2026 13:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771768265;
	bh=0r0ITLCkI48n18/3yLRb0z5fXGS1b+xMzZIIq3jWdy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=diTPENKZIAKJeDsrhvSIl34AurqdPuoX+9Fjnk8ZWdV4TpAtepAwnQIu8X0+ZLyvk
	 ebJ0ZW5B2usLV5zRobOMQyZ8HQOjHaQmTjDPgyIGIilRAxzJq15VloxrWC10eFyUlN
	 mfQbNJeS4IcWbumGc4TV0B6t+kCzrVz47K18LVl0FYYseO+GpBy2nXfzHkd5ls0xcD
	 AfCwIyzsYrB595P+E6+Uft36VwqFCKWnIzvO6LPITRXrzhk4ejR8fMX6p0E3apIVeB
	 rE+idbdfxzId8+ULhzBf/UX8bkXYy4hMElpwBCDJgyEgOm3QlSjuqoXpCCFUSD2Tt3
	 S9ntFdqnM6KDg==
Date: Sun, 22 Feb 2026 13:50:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: bhargav <rougueprince47@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] iio: frequency: ad9523: fix checkpatch warnings
Message-ID: <20260222135054.2e2012aa@jic23-huawei>
In-Reply-To: <aZgLutMih65WdesN@smile.fi.intel.com>
References: <aZd2jAVnTIuz2o7h@smile.fi.intel.com>
	<20260219213549.59645-1-rougueprince47@gmail.com>
	<aZgLutMih65WdesN@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 09:22:34 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 20, 2026 at 03:05:46AM +0530, bhargav wrote:
> > Changes in v3:
> > -Patch 1: updated macros to use '(x)' instead of 'x'.
> > -Patch 2: collected reviewed-by (no code changes).
> > -Patch 3: fixed vertical spacing and broken indentation.
> > 
> > These patches address several checkpatch warnings in the ad9523 driver.  
> 
> Do a new email thread for each new version of the series.
> Do not send a new version more often than a couple of days.
> (The very bare minimum is 24h.)
> 

Series is simple enough I'm not going to wait on Michael
giving it a quick look (as the driver maintainer).  Still
time for more feedback though given I'll be rebasing the tree
anyway on rc1 later this week.

Applied to the testing branch of iio.git.

Thanks,

Jonathan

> 

