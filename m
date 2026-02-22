Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E20310779;
	Sun, 22 Feb 2026 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771766577; cv=none; b=AAzHCLsesbXuogd6DCR6DdLNvQl6yWof6YB4OCpJRohv6tst9XnMzOMzoSHMZuohMK6jMmeWkcIMZbnp/VOTvX/CQ4p448d1l6txPIH58XwnOKy9aKogCVGnE8X2bQ0B6W+y/Hhkqwp6DVESjmG0SScgDLfMTExhFyN/BRAqUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771766577; c=relaxed/simple;
	bh=0mbMX9BtqtnvxjQR8l+kExQENImpF3fn0WEWshLOcIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KPY8E+D/EYo1UOfPK4bMGs5yVzEuq5oJyLRwyxfyif0TtrlptzDd4wJ5jvhrDreGrxPMkoDSiQ3hajRnRjkQelW7JinzHHhw3aBkxnd+noWgQdZxjU5rsqNpPqojnVBAz+7VbznOdbnS5+rRhtTgT9sGuts/7YlJlwBp7V0BkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9sNBa2E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9sNBa2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2030BC116D0;
	Sun, 22 Feb 2026 13:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771766576;
	bh=0mbMX9BtqtnvxjQR8l+kExQENImpF3fn0WEWshLOcIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R9sNBa2Eb8hYLRQ45rCdtDokkK8KLjW5T73Y+pb3o6FmvDoDHEizKjNLnS2kGFWZY
	 zM3bUtxLJv8pEQ9vT7gqfgziiztATqgLxdBU4214XixqfijBhTn5WucaDIM8Vrk/IJ
	 MSM8//AVzV5/CVVaQWpTMlJIS6wKDFBI0eLtmRxAEh95HRNYIYEiEqs8szagf+mJ4k
	 sdN4C1l/1R+b3OXA1IvSx0eNo94nCeaYjQW+65uoZsQtOBqdiLk6wpX1R20DcoG6Uj
	 52G9cS1mhOzpQP6VjIsClI+J+qIxZgWY4nzYpJILsc4NH4WT9/dx52G30ZoG5SBt0n
	 iIuRK0rFua+Rg==
Date: Sun, 22 Feb 2026 13:22:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Harshit
 Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7192: Revert "properly check
 spi_get_device_match_data()"
Message-ID: <20260222132246.6447d539@jic23-huawei>
In-Reply-To: <aZg_4KQ6hDqBeSJw@smile.fi.intel.com>
References: <20260217080514.1288115-1-andriy.shevchenko@linux.intel.com>
	<aebc2f13040d97e6e3b9797d3fa580198125e3f5.camel@gmail.com>
	<aZSD-3WIVwT6XYWX@smile.fi.intel.com>
	<a823c9b72fcc3b1d88ff9dd93580be6241826153.camel@gmail.com>
	<aZWI-80-K7xfuEBY@smile.fi.intel.com>
	<20260218095820.00005750@huawei.com>
	<20260220105507.30a2f7ec@jic23-huawei>
	<aZg_4KQ6hDqBeSJw@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 13:05:04 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Feb 20, 2026 at 10:55:07AM +0000, Jonathan Cameron wrote:
> > On Wed, 18 Feb 2026 09:58:20 +0000
> > Jonathan Cameron <jonathan.cameron@huawei.com> wrote:  
> 
> ...
> 
> > Applied.  I also added a link tag to this thread, to say we had
> > agreed to make it policy in IIO to not have these checks.  
> 
> Thanks!
> 
> Do we still need a process/maintainer-iio.rst?
Yes. Been meaning to start drawing one up for a long time but
there is always something else that takes higher priority :(

If you want to propose something as a straw man that would be great!

Jonathan

> 

