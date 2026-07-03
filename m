Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34B25A359;
	Fri,  3 Jul 2026 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783119627; cv=none; b=CRvSd94Q7wpHsMT+UshO7+2TH5DU7pGY931aM112zcX8vV8oNfq+V3Uuznk32nBoixk8eDQyb4WNHgcsQ6jZU+XTpAgEJSKWIERzA/632Ie2Vd07hM/+3MRiz+/9KEKJw3hmwpg4pT853F9tSqUmOBsG+nvYD1kyjHah3Omzcps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783119627; c=relaxed/simple;
	bh=UsLYZv5OuoNMNQIIy3ouCVeBiDz5w4sKyyRoS0mYMNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ot6Ou0lgL3WdaONbS6O0BpLjbOEwcapdt7b2/xAUQJn/ZMZMPvHEClT9jLfcvuJJ7Yf5f+WZxD0UQX5koFCUBPxuOpG0Sb6NyfW1vtI3mke21CrClEv/DzINyarmdgsFBrJqKa1+VzFPE9TFO1NUGIGHkZ/Xe93TbjOJEzbXJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMTIV0WW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMTIV0WW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D8A1F000E9;
	Fri,  3 Jul 2026 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783119626;
	bh=p5VEAPd93/sQ8rBcWEYJg6kDDIHbxHjc4jXitqCb6r8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dMTIV0WWsigp/VdgWh6NkMeSVKBC5oWLbFGw5gXf9SqVY4X6zeG5Clv44EdTjX9QS
	 tWVCCksr2OxFW02Wh7BgVe26ajfOLi8yv0EdUMyETLSJN8HhIm0gbSPzw7d7xHfOtE
	 uuTCdTZ6JvPgzjLmJzq9JSLqxtjsqrqSMvQ1zniAYy0DEY/KNcxLfvwF+J7c5GEpcB
	 odMEJd630rBjTNOEVLtyCte+8ovU4kEBIYHENFD61vv6GdcSgk/Z797l8j863/YVKv
	 jwogmqCF0+W7MddJQy1Ghrx9oCdRIPfe6WeAczAxyKGZInrtY65MK1XwuqDfVuYpcg
	 qgECK3EN5KaKg==
Date: Sat, 4 Jul 2026 00:00:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: pressure: rohm-bm1390: harden trigger handler
 against transient errors
Message-ID: <20260704000020.7f32aa28@jic23-huawei>
In-Reply-To: <01292abd-0f16-4ec4-9f48-36267973eb7a@gmail.com>
References: <20260518181110.1467-1-sozdayvek@gmail.com>
	<01292abd-0f16-4ec4-9f48-36267973eb7a@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 09:19:55 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 18/05/2026 21:11, Stepan Ionichev wrote:
> > bm1390_trigger_handler() returns from three error paths without calling
> > iio_trigger_notify_done(). The success path at the end does, so on a
> > transient regmap or read failure the trigger's use_count is never
> > decremented and iio_trigger_poll_chained() drops subsequent dispatches
> > until the trigger is reattached.
> > 
> > This is not a fix for a reported bug, only hardening against hardware
> > or bus glitches; if a glitch is persistent the device is wedged and
> > needs an unbind anyway, which is left to the user.
> > 
> > Split the function so the inner helper returns bool with the data-read
> > outcome, and the outer IRQ handler calls iio_trigger_notify_done()
> > once and reports the result via IRQ_RETVAL().
> > 
> > Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>  
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
Applied to the testing branch of iio.git. 

Thanks

Jonathan


