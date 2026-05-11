Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5558243C05F;
	Mon, 11 May 2026 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519352; cv=none; b=Df0xYaBpcruXs6MVd6mTbt2G43puIU+nYJnBMn4VHbM2nDKSQlMC+gjECN5UG5F+qfjTfHQVSTS7oW3hMABM3uAjlvQyvBwvT1F97kVsGsROqQbEYq0ipNf2+5b+q1M3x5dqXagKDsW7WM6/BXoVyH4D4Gbi7yhCUhHwfzGvt2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519352; c=relaxed/simple;
	bh=dxI4TSbNCrtrTKJ9zPwIMkZ4j8EIKt9koapqaPpKKM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZJrH14dAjPICrFnr//tWJqkohskAif1twA+78suTwD5fvtOrij0ujm97CxI8TESzWq+1lAgc5t/GQsGN9Dn0Vn+tPAZx73WAkSR2stKP1flOLc8ZIQZhd/9RP1r4xWP/lyIIhYh3QHxoM6ppRu4gDUe6kFe1oXgAIEzrC0t2j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOITzj/r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOITzj/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E29EC2BCB0;
	Mon, 11 May 2026 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778519352;
	bh=dxI4TSbNCrtrTKJ9zPwIMkZ4j8EIKt9koapqaPpKKM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QOITzj/rbvMKsAQzmcrw8oqPMQBNoTDiKwhgrPKwuS/e43fioXCHz8JEeYPKM9pmQ
	 mBxvXeHbj8M51zL40bXDE2zPHAVAW+H3OpMkrjMx/pGs3oQ1rWE9aU8LcHjU8gY1Ma
	 fFIQy+fFLA0MlDeEVl8sn01XG4lKx3haBWY4SsFIFbettBK/zql/lmbYhjblDqSCMB
	 kgJd2EJA9cUxtnGPmJZPE3wA6f6UC8fDx8n0A3llG0V5W2YdFyVRW2iz3QaM3Q7wNT
	 fmpFfw870H+RlAwSgnax1CJxnyLIl3oEiXx5t0ZC+hVGvS6yDKHoDZWP7MjE2KeIRC
	 222R1gXrTD9QA==
Date: Mon, 11 May 2026 18:09:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Salah Triki <salah.triki@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joshua Crofts <joshua.crofts1@gmail.com>,
 Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v2] iio: adc: viperboard: Fix error handling in
 vprbrd_iio_read_raw
Message-ID: <20260511180858.12cad4f2@jic23-huawei>
In-Reply-To: <af7oqt-TDLympDIj@ashevche-desk.local>
References: <20260507190751.28352-1-salah.triki@gmail.com>
	<af7oqt-TDLympDIj@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 May 2026 10:56:26 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, May 07, 2026 at 08:07:51PM +0100, Salah Triki wrote:
> > The driver proceeds to the reception phase even if the preceding
> > transmission fails.
> > 
> > This uses a goto error label for an early bail out and ensures the mutex is
> > properly unlocked in case of failure.  
> 
> ...
> 
> >  		if (ret != sizeof(struct vprbrd_adc_msg)) {
> > -			dev_err(&iio_dev->dev, "usb send error on adc read\n");
> >  			error = -EREMOTEIO;  
> 
> This also a local variable that doesn't need to be in the critical section,
> right?
Tweaked and applied to the fixes-togreg branch of iio.git + marked for stable.

> 
> > +			mutex_unlock(&vb->lock);
> > +			dev_err(&iio_dev->dev, "usb send error on adc read\n");
> > +			goto error;
> >  		}  
> 

