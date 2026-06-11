Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F952741A0
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 16:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194541; cv=none; b=tY0lYeLnTagPgFUl3p2BRezN2IabfvnnS+F5rA/ZpXg/JXNKNjpQ4wMA2n2GJ+KcSViC1Lv3KKKDgOr/qdIc5j6DKx9DR00ciDNC7VE0RRTbepKHy/ui2XkmG2dZum4WZVV9tFF+NgCAlRdpGXbhU1f4qMD96jDx47L6sTK9k/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194541; c=relaxed/simple;
	bh=KQzns9aukJkEzMmkcmdElHHYXNiMxnkjW+YlDum2wRo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FE1mXlPbgeNBN4zDe9agnuFqqFdRBBVhqW0ivvDdjZsT7xKpXw7WaL1Bq5ES/qMTF4Guj5meHSqJnbPA4avHnJ3He86S+gfHZHbo0xRJJCMKAceUa3XxvAmN1A3KUPmGY9/duJ/5EQEVzWyN6CXAlBlp9qS6O9m0fmzLZ9iq2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCfD8Q2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCfD8Q2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD40D1F00893;
	Thu, 11 Jun 2026 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781194539;
	bh=fEwvNd3TUA+KcbsUG7xgyNoZt21mi5iq4LM/waq7gbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CCfD8Q2duICunyXj3ulvHuYXLg9oOOC0A1RYS/M5gbUkBHu+qi3rdCMBYYT28bKrN
	 cxFv9U7Ozx0kXI1KsRmkNRr7wfvgtynML7duW8VCPzphJ4Eqv8133W+RFctPuDEZoQ
	 8Dci2WxpOqhz+ejCot80OTEmXezImP9GgIhSjlRUGgU8RonSXnaN75Q9FRoadYLkyp
	 lyomYh9JwblhX3I40NuPsmfzrpxnUdNbcJSMTEIJRX4KAwb6FME9X4DNMU3A74BaTA
	 N8b+pEqc3cLtckAZwGESTkH2zgaBISTEBCjLt4cVwEp4QU8QvwpWaaemo8YaLMIu6V
	 4J1kyFwepVbUg==
Date: Thu, 11 Jun 2026 17:15:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Educg550 <educg550@usp.br>, lars@metafoo.de,
 Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Lucca Ciriac
 <luccaciriac@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: frequency: adf4377: replace mutex_lock/unlock
 with guard(mutex)()
Message-ID: <20260611171530.70753ba7@jic23-huawei>
In-Reply-To: <aipeEEERBMljxQcN@ashevche-desk.local>
References: <20260610132337.229687-1-educg550@usp.br>
	<aipeEEERBMljxQcN@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 10:04:48 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jun 10, 2026 at 10:23:37AM -0300, Educg550 wrote:
> 
> > Replace manual mutex_lock()/mutex_unlock() calls with guard(mutex)() from
> > cleanup.h.
> > 
> > Using guard(mutex)() from cleanup.h allows the compiler to enforce lock
> > release on every exit path, eliminating the error-prone manual lock/unlock
> > pattern and the goto-based exit labels that existed in adf4377_get_freq()
> > and adf4377_set_freq(). This reduces the chance of lock imbalance bugs.  
> 
> LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied to the testing branch of iio.git

Thanks,

Jonathan


