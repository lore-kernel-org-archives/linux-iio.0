Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923E2FFDFC;
	Sat, 13 Jun 2026 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781360191; cv=none; b=bNOqCv8HOtxvZ7fbDown4wahfHC2Pi8vU2FIFFYWvR6ucyqFduLc8qEye6HyCI1FHrMtDBX0lOAMpYqhAvCvVAohWNyIvkIdPSY2kHo3Y/SceP/1ASE1znJ/UkluvvOI7bfYbOIYjetTnCZ9csWaOqwzQhl2FFA+MXm0hGu5IRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781360191; c=relaxed/simple;
	bh=nJEf/PVju9BJUcv3WQewqpqPsYiR7+jZhjeshr22ngY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bsJ6+tPZkN4YMoTaLAHzdlcFTOe4Ev0JGBoHa3x3Kpv4rIncTGYBQDDjLgrQn6MbS9khJKKTUbnPKAcsp8U/r/rJKoqK43q3AnS3wMedlN2Bp/SDePvCdlHJoOS0/bANrbUp3mx2Z+HCh3mPvllKs9hCyc/O2avNgaOmvlCU9n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFJd+jQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFJd+jQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B6B1F000E9;
	Sat, 13 Jun 2026 14:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781360189;
	bh=pQtn5f7iLC4ZtnLhKVkgbus84+UVWgzgLM21pj5SHaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LFJd+jQ/Il/0iplm938Kx4vGnNzr3Z3H8rsW8r6RD+z0g4cbDye95bQPufkLvxhjk
	 ED0CgyZm7u0NBAC5FUqXKzaNJKCHwP4Btz+7/dkykfFaI7ULGZ4Q0DUT7lQdKU/NKs
	 RLuxP+9Q3bs7v1mpRIlXHFH0QHVwYx4yV+WlBDwzUMe21Iaph6xdfECFm94crOIvdR
	 D+dLAdEbSAEAdJ6P3WWFtFgXKcgWlY+4Xu2vAfFXKZDNBP8fu+HgSY3g/uFGTktRfP
	 bVbp3LvUAz1Gkc/Vl/SevjxJA6WSSsIrYD09jgboOXunVB0PTm/mgqAYpFZJVewpFv
	 JAvnkaEbKB8fg==
Date: Sat, 13 Jun 2026 15:16:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: todo: fix typo and refine resource management
 items
Message-ID: <20260613151621.67ef84d8@jic23-huawei>
In-Reply-To: <ai1XsFfGi8_dVkRv@ashevche-desk.local>
References: <20260613033132.2344644-1-sanjayembedded@gmail.com>
	<ai1XsFfGi8_dVkRv@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 16:14:24 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Jun 13, 2026 at 09:01:32AM +0530, Sanjay Chitroda wrote:
> > 
> > Fix a typo in the staging documentation path and adjust formatting of
> > existing entries for readability.
> > 
> > Add TODO items to track conversion of selected drivers to device managed
> > resource APIs and evaluate usage of cleanup.h helpers for simplifying
> > resource management.
> > 
> > These updates aim to better reflect ongoing cleanup efforts within the
> > IIO subsystem.  
> 
> No objection from me.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied to the testing branch of iio.git

Thanks,

Jonathan
