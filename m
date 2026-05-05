Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381E7480958
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998317; cv=none; b=OD8THjFiu9HO0ngW2IH8CFiYDxrW2JMgf3u6DNasjiVEE6iSctMOWW4JDK6oeeyrQOCYHTC/B5ZmWo1YqCaLlbu4s/DamaNDmWceuGCzK6//uAnZh2isycZR27CbCnPeMyr4ixr0MX6Kwxknn9n0MwE356UZYieQj+DHlPxlyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998317; c=relaxed/simple;
	bh=v0CL0zB65znq8Rpx7MBpAcaKTWdKY8Bpqk+i9QYvYWI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/zWST4An7e+5D763pSFXjtuwUNKJtFy8CtblVLzuLazN9pg/HhuS0Cgoi4mqLfjmKCA7jRlKiTAZWLGtpY1Gez2ggi2kd6qiptXtyo2+O7mlOLg9qHeD08DnKHXTCqRUE0La75OapSd5ZNUzFWIJu03m3GcB7EBO4Ok8K6Waik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW+mRDXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW+mRDXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD7EC2BCB4;
	Tue,  5 May 2026 16:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998316;
	bh=v0CL0zB65znq8Rpx7MBpAcaKTWdKY8Bpqk+i9QYvYWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dW+mRDXhMtyZrvakdLFX7LPG1sC5M5LPEtFYK8XvAkDm463dcj5LGgRFiQhciYfG0
	 HXeYCkxix8asWKrMB8r3pM5ON2QsF8OzzfEeVqyC0CZtJqYUJFPMcIMjBQP0of/H6J
	 O79g/VXR1iqwv9XWNGQS5FYoAqMzad3e3lhbrMZ6RTOxZHmERlP1wskyxwqo/y81EN
	 SQZPebXW+amcHatbkwQt5EN+nilloDat4fJRhGLxtMeRX5YFtRxLQ6kna1fv96VPoq
	 4j6kx10F/JgdDdXsZ7mL6SdPTR5+MzjEF/irk1qk1R1mX9r1Mk1P0Bz0C1+XXtVC06
	 skxso85huBVdw==
Date: Tue, 5 May 2026 17:25:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Educg550 <educg550@usp.br>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 antoniu.miclaus@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, Lucca Ciriac <luccaciriac@usp.br>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: adf4377: replace mutex_lock/unlock with
 guard and scoped_guard
Message-ID: <20260505172507.71dbf4f7@jic23-huawei>
In-Reply-To: <20260429202304.25308-1-educg550@usp.br>
References: <20260429202304.25308-1-educg550@usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 17:23:04 -0300
Educg550 <educg550@usp.br> wrote:

> From: Eduardo Guedes <educg550@usp.br>
> 
> Replace manual mutex_lock()/mutex_unlock() calls with guard(mutex) and
> scoped_guard(mutex) from cleanup.h.

Why?  The patch description must provide an explanation on why the
change justifies the burden of churn to the driver + reviewer time.


> 
> Signed-off-by: Eduardo Guedes <educg550@usp.br>
> Co-developed-by: Lucca Ciriac <luccaciriac@usp.br>
> Signed-off-by: Lucca Ciriac <luccaciriac@usp.br>
