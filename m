Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D22652B0;
	Sat, 28 Feb 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772279555; cv=none; b=VeQQC9kPRl9YGua64FeaIR6s458D5xCxxhjKeEFPWsNtvH/5PyLV14LbhqaLM512/qjD7wzR8oQNmsX8CzT1MNLAFeNBIL6eYENN/Hz5IKBsD/aHtFXGKrlAH3nFnGDWpfV5pi5upe+BeGNbwb4VtVdwys92X2yovDdVNfNWec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772279555; c=relaxed/simple;
	bh=NjyuuXTpFRxJscwldgWE+EOYpV+VijGhauvYAgpR+xA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+Hw89QVF1zh3yI0d9iNdmsSx6cFde2G59Xi6wH+fDobhIg0bk2EFEwghy/bh/bPmXcRV8o/scnybAcWBgtXnbDtEv9eUP4o6hPjWCBaOMCIb880W6KYUdJzPyzVH0FAJWQth24MLMRcDrAZBh10fg2PEGcoI1GmxRPT5jXK0yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BludWgXo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BludWgXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A548AC116D0;
	Sat, 28 Feb 2026 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772279555;
	bh=NjyuuXTpFRxJscwldgWE+EOYpV+VijGhauvYAgpR+xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BludWgXo8o8aoDZCL3BduQwvhvEW4b/wCTabQD7Nru4LbUlhXkN9AYSTw8g2EYl5Y
	 JyC4MUlCUHJS2gBWG3ByHMmexfL9CzIcSfQNznB48187F1LLXRKR5+YNw523OZXg5a
	 sq/e1zTP/+kYQ4olW9uyYQxWG4nip+1OTAf8sxZ0MbpD6QhOW9eiihuNUfxY2kwQGC
	 z41I0QptZUN0lI25+zOcmrrN+jczYoJWapO6qzM0GcgvNttLxCrbf4n6zaoaFtLgNC
	 XM/cKf4qiOqGnTzBuiDNtCmeWpQ2sV0nbveyiYFEnatF9ODKK47WRoBjZuz5VaDGwz
	 3X7zvZEf7M+LQ==
Date: Sat, 28 Feb 2026 11:52:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ade9000: move mutex init before IRQ
 registration
Message-ID: <20260228115226.1199526d@jic23-huawei>
In-Reply-To: <aaLL7qHSQWMzwadp@ashevche-desk.local>
References: <20260227133331.66968-1-antoniu.miclaus@analog.com>
	<aaLL7qHSQWMzwadp@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 13:05:18 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 27, 2026 at 03:33:30PM +0200, Antoniu Miclaus wrote:
> > Move devm_mutex_init() before ade9000_request_irq() calls so that
> > st->lock is initialized before any handler that depends on it can run.  
> 
> Sounds good. The technique to reproduce this (in case you have a HWr
> to make sure probe runs) the kernel configuration should have
> CONFIG_DEBUG_SHIRQ=y (and in some cases a tweak in the code to flag
> IRQ as shared).
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied as a fix, so I added a Fixes tag and +CC stable.

Whilst hard to hit it is is always good to ensure we are safe against
spurious interrupts.

thanks,

Jonathan


