Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A39C37524F;
	Sat, 28 Feb 2026 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772302515; cv=none; b=VgZJIvbutbHpIdcxD792/KV40Uh3fquyFtfmK5GkGmRmUuxShz6YyPpLvy9+B1Y7ALruQidJbDzkQi3f+q02WfCc3S8w/hb3HOlsmDYlHEdIgVQbx35LNRkGIPsrCa4PLbNJW2+Olj4hCsEEiKe1HG1Jxokp4BELaWxSELHjAcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772302515; c=relaxed/simple;
	bh=R5GfHQchrVW6/nBLfZpNRqKssISUA5x83t19hT4dGqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXpOVMpk3w3QYUelIfJWPE7OUsaV8luJzCvgeJrfsvpNlIfYTytgRHB8UgrDO9PSUnRmeojetZfSIftP7GMnB1c4aWi7cE10HxSuEapXzWvewhtzFtOJhxZyVTkDhjFFQcLh4QnaYIda7M073fUreOtzAgvv1mJH/PfrRim+DH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhFzRNoq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhFzRNoq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BADC2BC87;
	Sat, 28 Feb 2026 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772302515;
	bh=R5GfHQchrVW6/nBLfZpNRqKssISUA5x83t19hT4dGqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JhFzRNoqnO2ULRz0QwMy57vclQZudoW50uZUhr4sdUahsAfv/k2O9RCUwwt9NvwMF
	 OJYznemAMIXMrAf2HdXTHBpQdV+feJv+oIrXDgDKHv0cHqyeEibRwGgNZthOsqbUKP
	 qbWgsn/6Nn25CUs7eSWrPlAjkFb+lUh13MwhVrhmTzd2rvZnTtdvBCXlVONjsDfe5n
	 MWK5NmWrwmXyCNRzbgU6Oji/kqk0mu4fiJiXclVycWWtFolc2jbza8nxNO4RT6reYR
	 7bKrFlzpcQXJZjvY5VjjySOFLCN/q0GgSx1tcYuSdFj7sndNSNKlxjVKAI2xYxP3r5
	 LVjHDzGvWJB9g==
Date: Sat, 28 Feb 2026 18:15:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>, linusw@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: gyro: mpu3050: Fix out-of-sequence
 free_irq()
Message-ID: <20260228181506.348a1a99@jic23-huawei>
In-Reply-To: <aZ7kGJxAy6kj8rWV@smile.fi.intel.com>
References: <20260224224818.2452675-1-ethantidmore06@gmail.com>
	<20260224224818.2452675-5-ethantidmore06@gmail.com>
	<aZ7kGJxAy6kj8rWV@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 13:59:20 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Feb 24, 2026 at 04:48:18PM -0600, Ethan Tidmore wrote:
> > The triggered buffer is initialized before the IRQ is requested. The
> > removal path currently calls  iio_triggered_buffer_cleanup() before 
> > free_irq(). This violates the expected LIFO. 
> > 
> > Place free_irq() in correct location.  
> 
> "Place free_irq() in the correct location."
> 
> 
> > - Clarify patch purpose  
> 
> Still doesn't give me enough clarity.
> 
> The patch as I read it doesn't move free_irq().

I went with
Place free_irq() in the correct location relative to
iio_triggered_buffer_cleanup().

As a Englishman I do always appreciate Andy adding the missing "the" which
I think of as an American thing :)  You really don't want to know how
many editing wars I've had over that in some specifications.

Jonathan

> 
> ...
> 
> But I leave it to native speaker and maintainer to decide. No need to resend.
> 

