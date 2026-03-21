Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFE32C08AD;
	Sat, 21 Mar 2026 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098196; cv=none; b=LX9hNw7s51dTngGCM/gwLu3kjg3FlKKzfVD38ElAJFvROUJz4dKgtiGWmr7dUZivI7a4LxUe2omHqL+O1ZweyLzfpKnYsDrETsUuE8BG1ycX6B7YKy7LXYpuKAFmMr8K5NE78LFw/OqtmJy5TsRLZ0IXa/1SBqongBPxaPM+0fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098196; c=relaxed/simple;
	bh=v0HlKOL70eEvzYpwG94+hsrdqXuojNsCEC0yiDx4fdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pm9SMzIuCi6pFuIivZci7f2YgKHdSDrdBIq2SKIVg9thKRvEQSPvuSCNruHtAQELdIFEOOXVq7xNd0bC5Rqgn7b9DZVeRW1NpppfDGABC1lwAY5jtRwb2tZJq42ejKZ7E+fEHZ9l3metCKXHkb4Dfcm6b5PlxsCyb+G4vwmndjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEG9BtrE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEG9BtrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3637CC2BC9E;
	Sat, 21 Mar 2026 13:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774098196;
	bh=v0HlKOL70eEvzYpwG94+hsrdqXuojNsCEC0yiDx4fdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UEG9BtrEupTXtny1tR2DPqkio16fyITfRg2ndJF1xo2Tn4QaP2JOAoVfwljVB6v2q
	 GZoPQhAk46YcDWjnEKCEfrXkR47R8KASQ+VaFjSCqLvYY8SRQwJZxeLmN0PDMWtIvs
	 uccHm94kPGrinbo337ItNo4ruant04l0RsBNRUQbUyrKQuZZUSpdclB5WR4o8yjBhV
	 lA8MGOLs4U1iVbLKa5uV/WuFIXacIfGZdn8IZwRyEZV50INX2rrWanQbbPQqVYnDaA
	 lVUEqfQUQpHtxlUlg2gA7iMvGT8/+7265tBU0Y8nJpoCG7ZGSqeBCVDny/4lcCzdCy
	 7iVzptcqXq0JQ==
Date: Sat, 21 Mar 2026 13:03:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Rondon <grondon@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, andriy.shevchenko@intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] staging: iio: replace sprintf() with
 sysfs_emit()
Message-ID: <20260321130307.7992dfb8@jic23-huawei>
In-Reply-To: <20260320222424.53294-1-grondon@gmail.com>
References: <20260319225719.73587-1-grondon@gmail.com>
	<20260320222424.53294-1-grondon@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 22:24:21 +0000
Gabriel Rondon <grondon@gmail.com> wrote:

> Replace the remaining sprintf() calls with sysfs_emit() in sysfs
> show functions across three staging IIO drivers: ad7816, ad5933, and
> ad9834.
> 
> sysfs_emit() is the preferred API for sysfs callbacks as it is aware
> of the PAGE_SIZE buffer limit. Build tested with gcc 13.3.
> 
Firstly a process thing. Don't send a v2 in reply to a v1. It should
be a new email thread.  I'm not sure where this style is coming from
as I've never encountered any kernel subsystem who ask for it.

The basic reason is threads get very confusing if they mix versions +
a more practical one is that your email appears a bunch of screens up
in the email client and many reviewers (who don't have time to look at
everything) start with most recent emails when looking for things to
review.  Thus you get ignored.

Jonathan

> Changes since v1:
> - ad5933: remove unnecessary (int) cast in ad5933_show_frequency()
>   and use %llu format specifier for unsigned long long (Andy Shevchenko)
> - ad9834: simplify wavetype_available show functions by removing
>   intermediate string variable and returning directly (Andy Shevchenko)
> 
> Gabriel Rondon (3):
>   staging: iio: ad7816: use sysfs_emit() in show functions
>   staging: iio: ad5933: use sysfs_emit() in show functions
>   staging: iio: ad9834: use sysfs_emit() and simplify show functions
> 
>  drivers/staging/iio/adc/ad7816.c              | 16 ++++++-------
>  drivers/staging/iio/frequency/ad9834.c        | 20 +++++-----------
>  .../staging/iio/impedance-analyzer/ad5933.c   | 24 +++++++++----------
>  3 files changed, 26 insertions(+), 34 deletions(-)
> 

