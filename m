Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532E57260D;
	Sat, 22 Aug 2026 00:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359107; cv=none; b=acEQBiYUT8//P1JWPlCgCLgB4taRDxlK9qIMLt8iPFxE5rfiq0y8gHn1BHoqLkbkdFMAzGKgzqeE1is+JQFNcQ71hm5wdVx/jhVuHj/swasGMRnFQMKqOYQ1ah4MA0nlyeLLfE0c+gffab5MMzyPy+G9eaMgCFW2pdIBk8pQ++Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359107; c=relaxed/simple;
	bh=3UaETsBFsp634QA5VZ+KBBbu8CzzxJLzDMDU0mEVmH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnsQRJyunzD6XIfIusM5aZ5haA6y5BrNK6JnnuXMrqu8xLEQ3VPsciv3r5p0d6SZemvis3PrfbczClKPqfLhkScxUOPG+Bmho1WiWrc1mmRA4Ga/fIuCZ+97Rpt3qGHhEgOA0zqKMLN3niq14iyUIsJq6Y3XdHShumF6DzhXz68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y192+lBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y192+lBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28301F000E9;
	Sat, 22 Aug 2026 00:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359106;
	bh=BgtjeTZgSi0up8YUuZDJ55vv3CYMYTAStQdkwQY7sGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y192+lBuoA2/5b4nM40AmB9MYYi4YOBKhfYga1kSJOJPo00Qqeg72WcJ2vVle71ov
	 Y/MI1Tp3QgZGXIkluIdhLMR4WcYRihfODN1Lqjg0CQs/wx0e22sNPGQC1wrXanlzdC
	 MFkZRPJKH+Kf60Nf3xZAmY6HFjNsGcxC6pr1vLyfDUBs8g2c/9r8KumacTv68YS3Vk
	 8utB1yvsjVqqZ9ImgbXJlrlpPLYL+r9PZAIFJk8Ly/2OW78/Xxe8MHiPvrToJjH5oo
	 KmXUXKqTZYnwSBX5wZbsrfTEPa7NBkc08lvQ8F7MfVuV/NpJi5i/+ct9oIRD5SQTsD
	 BalW/O1aag7wA==
Date: Sat, 22 Aug 2026 01:38:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Archit Anant <architanant5@gmail.com>, dlechner@baylibre.com,
 andy@kernel.org, nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] iio: adc: ti-ads1015: fix PM leak on probe
 failure
Message-ID: <20260822013823.28b0a1e1@jic23-huawei>
In-Reply-To: <an2FkBoJNRCaeAkk@ashevche-desk.local>
References: <20260812164433.23011-1-architanant5@gmail.com>
	<20260812164433.23011-3-architanant5@gmail.com>
	<an2FkBoJNRCaeAkk@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 11:51:28 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Aug 12, 2026 at 10:14:27PM +0530, Archit Anant wrote:
> > If iio_device_register() fails during probe(), the runtime PM
> > subsystem is left enabled. This leads to a resource leak upon failure.
> > 
> > Add the missing pm_runtime_disable() and pm_runtime_set_suspended()
> > calls to the probe() error path to ensure proper cleanup.  
> 
> > Reported-by: Jonathan Cameron <jic23@kernel.org>  
> 
> Was it public email?
> 
> > Link: https://lore.kernel.org/linux-iio/20260718225515.7e49a458@jic23-huawei/  
> 
> Ah, this should be Closes: tag instead of Link.
> 

I never checked but this is already fixed in the iio tree and
the relevant devm rework done.  :(  So much going on at the moment
in IIO I didn't recall this one at all!

https://lore.kernel.org/all/20260529183708.17819-1-sozdayvek@gmail.com/

Please rebase the remainder of the series.

Jonathan

