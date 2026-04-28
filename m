Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357732720C;
	Tue, 28 Apr 2026 16:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394149; cv=none; b=SmyhfX7M4M/eyDDlprfRPfU++gXiBUD6JVfLHEy6F8GUsWLSDtFBRhq2Ui0/UHIZrSzQeKJEnjjf90KiRZJf6wimrk/NAXsY6D3JAI1cSuCF80uOffV8p4I9fHQU7dwtY+Og1pDgseEprQN3YC9dBYi5SYKfzPk4bUH5cRiGVOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394149; c=relaxed/simple;
	bh=qkKuDvlWuc+DhiSeIMbSch1+jKtHqQkk10ccC3ZpqKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT1E8g6r1YWbbvdh5AhN2a03Vr7pucINN2CNw5XgTjLMg7JRpiDfiL2JaDKZKKKKL6R/8fSM8FXM4TgRxG6Dgwv4G4j+k181SOqjpZqADSYQ0HIc70fsOn8Th3wvdNWA/Ra0dWILyJn/Bn6C3utZbkBBoSxAp8l4LVCbIMcVAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etqfgEKg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etqfgEKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3408C2BCAF;
	Tue, 28 Apr 2026 16:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777394149;
	bh=qkKuDvlWuc+DhiSeIMbSch1+jKtHqQkk10ccC3ZpqKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=etqfgEKgbbA2ORVTQqh0Oxm0+e56A+Z/4VpNNpAI8EbahlkR5JMuLacRkFBu74KCS
	 ahP4M2+QPKth/QHnrjWBwFHpbjaTBFJY9OhE4m6WD/VmzrjnxEGjVAgTerTTW2b/1C
	 Jgu/wNxlN52yM4hHmjjmWNsA04QzD37nUlR5DNvCUOBCDDAZMbd4dMRrYqZZjDz3r5
	 ESC/TQRE6EZrYjYzDxO/V59ts5NjnlQIyutjVeHpoUu+J1UOf1FXKz9dD+Y/5GOLyb
	 mT9ZeATzMT0G0pZ4cHIO9OYEpWj1WoNOK8kXdQLNPmBJxDejXHZjLFUv65EsNz1xs5
	 8dpw7ROjaFyNA==
Date: Tue, 28 Apr 2026 17:35:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes
 to the driver
Message-ID: <20260428173540.28b7913e@jic23-huawei>
In-Reply-To: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 22:09:45 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This series is an attempt to make the driver less a rabbit hole.
> It's a continuation of what Joshua Crofts started doing. Hence
> it is based on his work and first three "patches" here are supposed
> to be folded to his series accordingly.
> 
> I have compile-tested them, but I haven't done full double check of
> the correctness from functional point of view. Joshua, please do that
> before incorporating into your series. Yes, my patches are assumed to
> become the part of Joshua's whatever next version of the series, that's
> why mine is marked as v0.
> 
> Should not be taken directly by the maintainers, but any comments, review
> are highly appreciated.
> 
A few brief comments but mostly looks good in isolation. I'll wait
for the fused set with the fixups applied to take a closer look.

Thanks Andy

J
> Andy Shevchenko (14):
>   drivers/iio/magnetometer/ak8975.c: fixup for the IWYU change
>   drivers/iio/magnetometer/ak8975.c: fixup for the errno fix
>   drivers/iio/magnetometer/ak8975.c: fixup for the iopoll.h conversion
>   iio: magnetometer: ak8975: Inline timeout constants
>   iio: magnetometer: ak8975: Avoid using temporary variable
>   iio: magnetometer: ak8975: Drop duplicate NULL check
>   iio: magnetometer: ak8975: remove duplicate error message
>   iio: magnetometer: ak8975: Reduce usage of magic lengths of the buffer
>   iio: magnetometer: ak8975: Unify return code variable name
>   iio: magnetometer: ak8975: switch to using managed resources
>   iio: magnetometer: ak8975: Consistently use 'data' parameter
>   iio: magnetometer: ak8975: Unify messages with help of dev_err_probe()
>   iio: magnetometer: ak8975: Use temporary variable for struct device
>   iio: magnetometer: ak8975: Make use of the macros from bits.h
> 
>  drivers/iio/magnetometer/ak8975.c | 253 +++++++++++++-----------------
>  1 file changed, 112 insertions(+), 141 deletions(-)
> 

