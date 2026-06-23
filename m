Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7668E36F8EF;
	Tue, 23 Jun 2026 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243108; cv=none; b=KF/U/PA8Vo/tzmM4kg/CEZahPTPwosj/1aaw2lC3RPCwgPu4MsnzuJHd1j3xwRUm8q1ReaoG5li0gqPkMQLfRhLns3cpCw+3Zju36zfk02i5YOLZlfwsdzUBv48dhn56r2JVj8HnnjXs1d9eBLW8dvMoXOsPpZkRq2I8ublb/mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243108; c=relaxed/simple;
	bh=LY7dhwdrqnVvNOB8KPzVFeFGt5AG7YDFwGQzIpVpNjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dt3LB/1L7MIz2PcJgPmP67GBF/OuwNX3FxVAkYAlydmBPf4Q1oPIwNGSPFKSJ4BKxUr1uIv7wbAWAT8Gr7gCVXNEJb/cDR3qjH/cAHODPznrg10YYpxWg94Z7Tp9Xg3s4eTDPyWVLzytcskjGVoj+yT9BeI7yfB4ffkCdpyVFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzL7NrTh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzL7NrTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FCF1F000E9;
	Tue, 23 Jun 2026 19:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782243107;
	bh=4MuljlbrWHxmV3Y7+Mr+HSaJEkHTkcteykvDN9BD0bM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QzL7NrThrmpFrXVzrJM2tvBUWPz8UFx0OS0WbzbzqTHYyQKVJoIsoioPggsDsQKmq
	 9SqTsby/4zdzLEoA/bpDloI7lWjUbvOijq2AkrysQN560oruyzkrHDzfQWh1wSjRNf
	 xI99Fv7RVeSUQcv0X6IWwVwGAuxnkja3nincHVLP1xQ00lp4BmpQXxSZpcjzA/CHtz
	 mId10hCqdB/w29pi1YQv/LVcmF84bwTwDGMgH4b1KRU96pkTCJRpKFtOk64NMo/tJM
	 n4Y+mymO8wufpA/ToE7WNw9akkXGfS3lxCyDW+/G4Iqm1UTvDgbYqHoXc4eA8BHUfH
	 8CNq3FKiD5N7A==
Date: Tue, 23 Jun 2026 20:31:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Prashant Rahul" <prashantrahul23@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
 "Shuah Khan" <shuahkhan@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, "Matti
 Vaittinen" <mazziesaccount@gmail.com>, "Petr Mladek" <pmladek@suse.com>,
 "Oleg Nesterov" <oleg@redhat.com>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable
 Hub)" <u.kleine-koenig@baylibre.com>, "John Ogness"
 <john.ogness@linutronix.de>, "Dixit Parmar" <dixitparmar19@gmail.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ti-adc*: use dev_err_probe for probe time
 errors
Message-ID: <20260623203137.7c4aae1e@jic23-huawei>
In-Reply-To: <DJCBXHCM2VTQ.1DBAHMPJHA9HP@gmail.com>
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
	<f3165ebd-c359-49dc-a46a-0edacedf52d7@baylibre.com>
	<DJCBXHCM2VTQ.1DBAHMPJHA9HP@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jun 2026 22:22:15 +0530
"Prashant Rahul" <prashantrahul23@gmail.com> wrote:

> On Tue Jun 16, 2026 at 7:33 PM IST, David Lechner wrote:
> > Please make one patch per file.  
> 
> will do
> 
> > Please don't add new error messages. If there is a really good
> > reason to, please do that in a separate patch with a justification
> > as to why it is needed.
> > In this particular case, the only error is -ENOMEM, which we never
> > have an error message for.  
> 
> I understand. I will remove the additional logs, except the ones after
> `devm_iio_triggered_buffer_setup` for -ENOMEM.

This jumped out at me.  We very rarely do special prints for anything
that returns -ENOMEM as that tends to be very noisy on the rare occasion
it happens.  Note that dev_err_probe() doesn't print anything in this
case. 

J
