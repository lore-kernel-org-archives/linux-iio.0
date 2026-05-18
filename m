Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C28A481245;
	Mon, 18 May 2026 13:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111091; cv=none; b=QI7TgMwEYI/lHy5bvSxAcHJW4JdTTvCERLFXanLxLPSREHoyftf2wODf1qBut8T/VRDQ1qBBf9S+L6qMji9Yn8OvCbZS9sFzYpZzDdGf45JfaOVfTJekAusFl8uAfJ6fxS1SminRWXzRaJp9yiMoHpp7OPnbv84U89J8DJDU9is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111091; c=relaxed/simple;
	bh=3q5/4LWnI2GI6Z+3nxsERJ1+C9/vAj/hSo2XrlUaSK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mV7r8jXsMrJiKnZoGqYEBFpL5h8sl7KiOey5SrUMfuM32GBF/thsXpaIzm/W3toVOTS73Gxom59WGxbcD2xM7BYNEjWhQYi6ufwKWjiREK1B1HReVUKMQjKi/hgeJ9RS5q4PLaqFjYEqJZf2536aDvEKJ6M4+lNIc25FwvYhs14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFcKE+PQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFcKE+PQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320B9C2BCB7;
	Mon, 18 May 2026 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111090;
	bh=3q5/4LWnI2GI6Z+3nxsERJ1+C9/vAj/hSo2XrlUaSK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OFcKE+PQNmnPrN5UapDPsP27Kw82TheEF7f/KWhD4E+31aKtugLtQwoIaD84vQFgw
	 aA4P/xjWGRTa4POcmsw1IjQnn9DVKe+nDIxQkeJW6huUJVFQ7hej8eSmOzot5N2NmP
	 nHsFpLv+fJofyguMiQPdSM/q+Fo8laohQbJDstbOMcsb9hD1QXrmeJfe2E3qwU7nNq
	 SYl0rzTiTWoN56m6CSsoYHYXZQ51CT5rMth2UuA7qjR6arQRsakwzdlaWIP7xMXPp7
	 BbRcFE1ti9ryNdQgvASJ0vmPdGQn/9hb9m6qSAtgJlAdHh7Gx2vfDnw9lnN+t+YcRo
	 tf73PnbzMXm7g==
Date: Mon, 18 May 2026 14:31:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, christoph.muellner@theobroma-systems.com,
 martink@posteo.de, mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] iio: accel: mma8452: switch to non-devm
 request_threaded_irq()
Message-ID: <20260518143122.10797b5c@jic23-huawei>
In-Reply-To: <20260506184749.5b69d86f@jic23-huawei>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
	<20260505174640.3998281-3-sanjayembedded@gmail.com>
	<20260506184749.5b69d86f@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 18:47:49 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue,  5 May 2026 23:16:32 +0530
> Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> 
> > From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> > 
> > Avoid using devm_request_threaded_irq() as the driver requires explicit
> > error-handling path(s). Using devm_* API together with goto-based
> > unwinding breaks the expected LIFO resource release model.
> > 
> > Add explicit IRQ cleanup in the driver teardown paths to follow kernel
> > resource management conventions.
> > 
> > Fixes: 28e3427824cc ("iio: mma8452: Basic support for transient events.")  
> For a fixes tag we need to have an explicit issue rather than
> it not following best practice.  Patch itself is correct, and if all
> else is good and you don't have a specific ordering problem in mind
> I'll just drop the fixes tag whilst applying.
Applied to testing with the fixes tag dropped.

Thanks,

J

