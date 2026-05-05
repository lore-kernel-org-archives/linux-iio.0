Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274AF78C9C
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 16:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998926; cv=none; b=WP5v4fIa0sw25KtRYYhT4VDXa9TB41wEJ4QhFjLGVc4vFGSLkv6GrO2J5iR55h7K1qvGG176UdxYzmYjzd2yuQp/yg7sSBv1D6tcQgVRJTLo/4gM8rCiuKSxn4oafbtxMpy8RdXFkY1Lzg8qmJAjrJkKEc17vmiRdIA3UitDidE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998926; c=relaxed/simple;
	bh=eg4gP7+p+7M0rQktNbakH3+HwTCAhBoEtQjmeNGaV6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmrMZgeazzF5RFJwj2LjRSnaNBCl2M1s3qkoUnlsFX4GGmhEX7JY327BIopLQ20dKU25I6HoMBFm27b9HhGlJoZfIryDQvMMolpesCA5pj/LJ4oOz7sPCahOvthhCItQ/DoWUjzcMtaZmmHYG+uQO0sI9O54O4qM8agC1IPiJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFioOefG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFioOefG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B947C2BCB4;
	Tue,  5 May 2026 16:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998925;
	bh=eg4gP7+p+7M0rQktNbakH3+HwTCAhBoEtQjmeNGaV6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XFioOefGvZXDMHST0D+hFl/SaYAW019Y34hEoRAW5WnYyfvd42EMtdUpFFUtROkMS
	 bqMVRKN8LpDihMWLmogq0JTRuDgohE6e6f8UwNdTA58bYIyNjEMQ4qnID1T0pJZYEB
	 bpvJKIR4kUxMnKxXGkQPQOdfivPKKkkhKNJIyhdXLbvp+RZNrcIPxEPX63ejWgx1B0
	 RQrlOZFE9glM3pJKLJx/Wr1IPtfcJ24/9RF/t9cnS478Pabw2tUAIjLDs42/rTsaGn
	 noWVU7tRnYLWxxrtlz6u6RSBIRftlR/SaQ7p9ufK8akMs6nWRi+kHzHBY0YIXEFpLa
	 2E0IRCgLld1Pg==
Date: Tue, 5 May 2026 17:35:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Pedro Barletta Gennari <pedro.pbg@usp.br>, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: light: iqs621-als: use lock guards and
 prefer early error handling
Message-ID: <20260505173518.249f9b0b@jic23-huawei>
In-Reply-To: <afJjnq4z76XFaEBF@ashevche-desk.local>
References: <20260429013640.26870-1-pedro.pbg@usp.br>
	<afJjnq4z76XFaEBF@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 23:01:34 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Apr 28, 2026 at 10:29:53PM -0300, Pedro Barletta Gennari wrote:
> > Use guard(mutex)() for handling mutex lock instead of manually
> > locking and unlocking the mutex and flip 'if (!ret)' to 'if (ret)'
> > to handle errors early in drivers/iio/light/iqs621-als.c
> > 
> > Patch 2 depends on patch 1  
> 
> Both LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied to the testing branch of iio.git.

I'll push that out as togreg once I've caught up with the
backlog and the bots have finished poking at it.

Thanks,

Jonathan


