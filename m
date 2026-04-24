Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFE733F583
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049761; cv=none; b=rVt9KcnBCZegTR1uukB+lXXPECEG3NI5Zg3urHMEsxrD2YfUSb7ETSMpDejf8HmYzIk5A7y12OAI3Xg8Ht01MRDm8h7/hmBtRxUgC2G8CAhSqM6Kh23aEw3HkUvmh1uqbqPN5aXZp3nxAOfXPrZ7YXFPawTNH3ZFm460VqHJs8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049761; c=relaxed/simple;
	bh=4lRy/mI46E2p0zTcVKbha+zNAG7RQSh8FSr4YKjKCtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWQT9NFns67e35P2Qp7qtJexFuA3VDPSBSSrW4ostCPjM/Jzhm/E1IygWBoewXzunXXKivCYBPJA7dNEyzMjkbg+C+GX26SD+y1QEX4yp5Pqk9USyu3n2YIb38hHIJB4zwFMu8KXpIeXJNHMhJNRiink9ACFkNW8mVWmcdlCc+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMKwSo0g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMKwSo0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05173C19425;
	Fri, 24 Apr 2026 16:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777049760;
	bh=4lRy/mI46E2p0zTcVKbha+zNAG7RQSh8FSr4YKjKCtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MMKwSo0g3wy0tZ2qHauG3HptdCrWSlVj3KnsDVUT08+Hngkm+zmeXAcTBoFDEmqLj
	 9O+fdHsNTsRlRI7wnWHYV+zC9hd24dYQOqkSA69OdxcAtHgt/iA5ZQbf0mDadHCK5j
	 RjCfZkuQvKDLfxLHTFIquFRMsOH9JFK1ijlDmverLIUzLC5H8FmwEVMBG8zZi/zlqO
	 jeL0jEASFyw8GI449Oop0JTmjWvA0bFjzf42EA2jvYEkoeBnlJUf+7IAdNEFglFCBX
	 DLjnK05wLsYlxENdHaiINLReyVJGSwobvKdKRaRQRrdSwJWXuhzPp/boXm4Kz793kT
	 XXCM5AN2iKbYg==
Date: Fri, 24 Apr 2026 17:55:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>, andy@kernel.org,
 dlechner@baylibre.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, Matheus Giarola <matheusgiarola@usp.br>, Felipe Ribeiro
 de Souza <felipers@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: ad7280a: use cleanup helpers guard()
 and scoped_guard() for mutex locking
Message-ID: <20260424175551.071b25ba@jic23-huawei>
In-Reply-To: <aeuP9Jn0Gd-nhdBZ@ashevche-desk.local>
References: <20260424125001.17822-1-lucas@ciziks.com>
	<20260424125001.17822-3-lucas@ciziks.com>
	<aeuP9Jn0Gd-nhdBZ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Apr 2026 18:44:52 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Apr 24, 2026 at 09:43:40AM -0300, Lucas Ivars Cadima Ciziks wrote:
> > Replace open-coded mutex_lock/unlock pairs with the cleanup-based
> > guard() and scoped_guard() helpers in ad7280a_write_thresh(),
> > ad7280_show_balance_timer(), ad7280_store_balance_sw(),
> > ad7280_store_balance_timer() and ad7280_read_raw().
> > 
> > This removes the need for the err_unlock label and explicit
> > mutex_unlock() calls, as the lock is now automatically released
> > when the function returns or the guarded scope exits, regardless
> > of the exit path.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> >  	unsigned int msecs;
> >  	int ret;
> >  
> > -	mutex_lock(&st->lock);
> > -	ret = ad7280_read_reg(st, devaddr, ch + AD7280A_CB1_TIMER_REG);
> > -	mutex_unlock(&st->lock);
> > +	scoped_guard(mutex, &st->lock)
> > +		ret = ad7280_read_reg(st, devaddr, ch + AD7280A_CB1_TIMER_REG);  
> 
> >    
> 
> Now this blank line may be removed.
Tweaked.

Series applied to the testing branch of iio.git which I'll rebase
on rc1 once it is available.

Thanks,

Jonathan

> 
> >  	if (ret < 0)
> >  		return ret;  
> 

