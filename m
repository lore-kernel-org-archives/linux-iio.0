Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199883B8BDB;
	Sun, 14 Jun 2026 13:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443880; cv=none; b=MGGxlXFHRh43q5ptof+/uAKE0DG4mU8LDngkWD0Q5on1/EMbx7gFBVU3yCaQYvITW7tWAwFefHDjQL/6G4P2b66AVaEPX8lUW0PwrA4xgThFEkH4lY7KOub/5BxpnFhv0jE74KrUSFfgHiq+GKowOHYNQEE9ACXJfQ3F1wQMsVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443880; c=relaxed/simple;
	bh=DoNeHstU8O3NtsGhyeR1GNm0ZSxyXMOktmpbBXSdtXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUK3ceJDb/T9HVqwHuFQ8R89i4W/uN7JCvMoJd/mgr/lE+aq1fzISORgtIchQE1gc5aFuUdZCLc/lSt0am8nff4bgGOrwEXy4P0yZ4xmXBi3BEyCTOrzzzxG7Tu3BRR1zirrTTRsKJl/gGUSXGKMNb6BIv/E1sj0Gu2kUEUTOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvDpvlgm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvDpvlgm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2C01F000E9;
	Sun, 14 Jun 2026 13:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781443876;
	bh=EXhAK74MaJQM5jfZiIjWWORtJxtGWBEuOXFDNmV2Jc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NvDpvlgm8oOyTC6cZS/xMeckru1eU8MkaZxFn4Aw+pZ0KERQfp7YLLd6NQLeLClk2
	 N/IGVVt3YioNCPeIIC25DSJVLXWaC06jKnDJg7NIEh5xYt8GrRlxKETbO+8SXG0+x2
	 xuxXHRNIPWHfqWqscQ03mojQ/1ALWfrIMmP+PJxpI6nwFZsLq5Vr8WJhlRbe+IV71G
	 nrAe1m5tBHEOX7px3V/wURbt1SbvSDt8dW0RY2arMye6vDTrnOoKZbg+WnaOSct7sB
	 IhBRoOnmqBkFUw97NxUUmV1rrUI2/pJxQismNeY9GufhBptrEL0HLohBrSdA/ImAdL
	 O3rrkKlakGPNQ==
Date: Sun, 14 Jun 2026 14:31:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biren Pandya <birenpandya@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] iio: Fix runtime PM leaks across multiple
 drivers
Message-ID: <20260614143109.7e2ba4df@jic23-huawei>
In-Reply-To: <20260614071549.81920-1-birenpandya@gmail.com>
References: <20260614071549.81920-1-birenpandya@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 12:45:45 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> Hi Jonathan,
> 
> While auditing the IIO subsystem, I noticed a recurring pattern in 
> several drivers where early returns or error paths fail to drop their 
> pm_runtime_get_sync() references. This permanently leaves the device 
> active and prevents autosuspension.
> 
> This series provides four independent fixes for these imbalances across 
> the kxsd9, mpu3050, mpl115, and gp2ap002 drivers.
> 
> Because these drivers are independent, these patches do not depend on 
> each other and can be merged individually.

Oops. Too me until just after I'd replied to patch 4 to notice
that these don't have the necessary Fixes tags.

I've added them, but keep that in mind for next time you send a fix.

Thanks,

Jonathan



> 
> Best regards,
> Biren Pandya
> 
> 
>  drivers/iio/accel/kxsd9.c       |  5 +++--
>  drivers/iio/gyro/mpu3050-core.c | 16 +++++++++++-----
>  drivers/iio/light/gp2ap002.c    |  2 +-
>  drivers/iio/pressure/mpl115.c   |  4 ++--
>  4 files changed, 17 insertions(+), 10 deletions(-)
> 

