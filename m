Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3A285050;
	Sat, 28 Feb 2026 12:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772280638; cv=none; b=Disnvztj0g9YrdLYQ05BO6b8YSl8fIX1nsjJvi1PBUFBvJG/FlL8IDO+QYgugyG2sbjtDI/irBaLjCowCCQKspBbjytXflF3UV1LFiQ1asb3OJNHcyxA6e7gb/rUzIeNrNAmtD7sn0Ewm0O+xUTrRS0TrrgbDlA21huOuGZLXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772280638; c=relaxed/simple;
	bh=0glJCrjYcpgWePd3HGl3ozU5wxj+0Lxorhw19OTGxg8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oFvAhDMU2aPbAKeovY07L+wH4bFHN0XistjhLP7iv32hwPrcUjnPhdJ9RoFka8BfulBsJCY4mMObf3uhYVC7ISfLWVfSXZu4zUedoJ10W5coTqXHPYYMD/hVd0HGWrTobpXeUklCJs2vVOikFhqR9Qo65NeBQbwiq/QW6kf9wJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p16kngZI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p16kngZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20DBC116D0;
	Sat, 28 Feb 2026 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772280638;
	bh=0glJCrjYcpgWePd3HGl3ozU5wxj+0Lxorhw19OTGxg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p16kngZIpp12U+FI/9rIZ80RlIqn7DyqmFJgs4tD0E+w9FSJ3e80daeKZ7Csw+MJ0
	 lZeL+duZbnHL3C1/gCvaSkvhXxl9lUSwTEjudX2YkMLElMP0whaGXRlyRTP5c+b7//
	 ZhBJfkMqje4TcdePT/Hc96Fv4hSq3zkTWbS+E/KKgr/T5RpTBo73wqjQ1Vj8XKdtj5
	 BEa4o9eK+EoPaSJJMgEfDNXx4WTjG6ZsE3Ejl9Qcv7qr85zRryTriATEsdA/HdfhyN
	 aljc9+JDzS3hBLGz+CNhSDDBvRyWKaEN7rbGOG/+zjCHKzTgKVTSiyL2APREYdj3qI
	 bCv0dbrXfu6ew==
Date: Sat, 28 Feb 2026 12:10:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ade9000: remove unused
 AD9000_CHANNELS_PER_PHASE macro
Message-ID: <20260228121029.731b5791@jic23-huawei>
In-Reply-To: <aaFe3oFDGFr4gGze@smile.fi.intel.com>
References: <20260227085813.46417-2-giorgitchankvetadze1997@gmail.com>
	<aaFe3oFDGFr4gGze@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Feb 2026 11:07:42 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 27, 2026 at 12:58:13PM +0400, Giorgi Tchankvetadze wrote:
> > Remove the AD9000_CHANNELS_PER_PHASE macro which is unused, has a
> > misspelled prefix (AD9000 instead of ADE9000), and has an incorrect
> > value (10 instead of 11, there are 33 total channels and 3 phases, so 11
> > for each).  
> 
> for --> per

Hmm. per each is weird.  per phase makes more sense so I'll change it to that.

Applied with that commit message tweak.
Thanks

Jonathan

> 

