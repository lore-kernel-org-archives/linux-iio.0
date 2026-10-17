Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45F940B116;
	Sat, 17 Oct 2026 22:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277944; cv=none; b=b5MgLTSrZG7+fyLHT/yUJ4WMm+XjoLmEBFGEe2xsIVuTc2T1GtrOJq2FI3Bhg1AlEOjPly2wn1JuRT3dxXgcn5jCKnDvixAKkAMwYI8EuhKiHhdCQLrUnC/PEd+m2caXAqBZkMbVEQvbYs5ckXoqEIKHYcBcvHElAtL/bS0kvSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277944; c=relaxed/simple;
	bh=PnI4ruWH1mytnreap7nNUCaJusZ8tx9sTHaE+v3Ijmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owaXKcSFUbkDtXRowqFwR1PePS6uXpkkFukGh/2TNVbvGlDAFJQgGbkYenVea/pZQTn98Ipp2rEXAg82SkJO7ZrojSFdXic2Ierg9FkJYrn4WVsfBI4QlAE+bwVsC3GWK95AZglcnyUPWUt8sk3mgy7DhpPMPMvqsyIP84YsNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd6LQFKc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd6LQFKc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A001F000C4;
	Sat, 17 Oct 2026 22:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792277942;
	bh=/OJcEjyVn4Xd7X+X5YTXDj8kLFxRrBJx9SBxuhYzO2c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fd6LQFKc25ALoZXQawOBDphqiQyLrkuLvPrqnPCU6/Pluh3SJvVCL3zUbWgH7KrJa
	 YYrkHJnZJcsK0Ivjv857ZZH99bdlEobw2X9GgbVQ3cCCVeLqcxAY/criXgyXQa6Amn
	 /yOn6U2vBbkJ6CoiZ50g/OxQG4BpeHjfdy5bA64F6eohlXl2n1KbfVf3VngVMju+WD
	 NGI8j8TYrpa4KTSe6fFKTqboT5lUTNlneCOj/aBCnCdlwk1fW7MmOiOtdMHC1PDCZ1
	 A8pHb8JE3b/5gwqLGIPHasmkVrLWBS6uNqnM2/alFLxGDpbkRSgz40mU1pqVASLT0V
	 53ZYZv5NGRCyw==
Date: Sat, 17 Oct 2026 23:58:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Sean Nyekjaer <sean@geanix.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: imu: inv_icm42600: fix kernel-doc warnings
Message-ID: <20261017235857.0b3800f4@jic23-hlaptop>
In-Reply-To: <20261006045413.14320-1-kapoorarnav43@gmail.com>
References: <20261006045413.14320-1-kapoorarnav43@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Oct 2026 10:24:02 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> Fix the kernel-doc warnings in the inv_icm42600 driver. With this series,
> scripts/kernel-doc -Wall reports no warnings for
> drivers/iio/imu/inv_icm42600/. Comment-only changes.
> 
> Changes in v2:
> - Add patch 2 for the remaining kernel-doc -Wall warnings in the
>   driver (Andy)
> - Collect Andy's Reviewed-by on patch 1
> - Use the Assisted-by format from coding-assistants.rst (Andy)
> 
> v1: https://lore.kernel.org/all/20261003055339.143977-1-kapoorarnav43@gmail.com/
> 
Applied.

Thanks,

Jonathan

> Arnav Kapoor (2):
>   iio: imu: inv_icm42600: drop stale vdd_supply kernel-doc
>   iio: imu: inv_icm42600: fix kernel-doc Return: sections
> 
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h        | 1 -
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 4 ++--
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c   | 4 ++--
>  3 files changed, 4 insertions(+), 5 deletions(-)
> 

