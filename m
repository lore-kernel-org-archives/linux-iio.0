Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EABC10F1;
	Sun, 17 May 2026 12:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779021276; cv=none; b=JqdXtXcGwzCYb6A13do6aqRsiOBmz7AyAlOZChgrfcyBZF2UIYtvVgikYYzXuNC+JE2qrEKHbKotXlsBU+a5AGQmttOfPjolf44hRl0Q9K2qPGKxQvpsB0pURTPQaoJYrCNOL/jEUAiX3xCik64fa8mnusiANf+B4NLC5cGJ/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779021276; c=relaxed/simple;
	bh=467zNBhp0wwvchBBLXT/nHFLuEP/DfWTXQJbcmE+Ysw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDX7uG28Fzld0rujwGaOjobG7PLXiKd+etcq+xpwnvH/INyXBnnzvJxydKQmKUp2LdfvBZnY6cOTxnO1XlPiMHlFnRMYWT3I9v53oMG6Xn7NgWe3CTVSjcFjfj89fHncCR1XP6ZDiKM+b0V9sija3GydbfPcdGv1XJtkXIHCZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WhkdwF+t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WhkdwF+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BEDC2BCB0;
	Sun, 17 May 2026 12:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779021275;
	bh=467zNBhp0wwvchBBLXT/nHFLuEP/DfWTXQJbcmE+Ysw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WhkdwF+t24Z4s9JRG8o6Lq30RUbHIJSwRfwnl6ZVMmZ/ymlpuZnO3dNVv8d0z5Oed
	 UqRB3rq5JTo1qI0989Zacpzd0dYrGEY58HB72kWOxyWA3RZ9nurgMD3hxImObO7EH7
	 KwrimK3h2mjq4vY+rzeROTtBobKCVdI9nnqrxgENoEZIePFVEt3Ettjn/n3SEk1HBV
	 QGVQ5+IHvXVIxD54CiJcuSa1uzEeujGqv+S7N5GwQvjd2CRrlbikQE7I/PxOvBw9nB
	 bhKeTNMTNdU51bxSjelAW36m6aeIs7pjDQPQ0wp5ukgDTI01RTgAVdVX4jkskV+kTk
	 EoNWKm700jU5Q==
Date: Sun, 17 May 2026 13:34:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, tglx@kernel.org,
 christophe.jaillet@wanadoo.fr, mingo@kernel.org, kees@kernel.org,
 nabijaczleweli@nabijaczleweli.xyz, kyungmin.park@samsung.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/12] iio: ssp_sensors: cancel delayed work_refresh
 on remove
Message-ID: <20260517133426.7e4bab96@jic23-huawei>
In-Reply-To: <agmY-jPxZvopmfuq@ashevche-desk.local>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
	<20260515174017.3962168-2-sanjayembedded@gmail.com>
	<agmY-jPxZvopmfuq@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 13:31:22 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, May 15, 2026 at 11:10:06PM +0530, Sanjay Chitroda wrote:
> 
> > The work_refresh may still be pending or running when the device is
> > removed, cancel the delayed work_refresh in remove path.  
> 
> ...
> 
> >  	free_irq(data->spi->irq, data);
> > +	cancel_delayed_work_sync(&data->work_refresh);  
> 
> In another thread it was (is) a discussion about cancel_ vs. disable_.
> I.o.w. the Q is can anything trigger (schedule) a new work after this point?
> For example, some user space sysfs node or other means of ABI.
> 
Or maybe avoid us having to think about that and use disable_  on tear
down paths :)


> >  	timer_delete_sync(&data->wdt_timer);
> >  	cancel_work_sync(&data->work_wdt);  
> 

