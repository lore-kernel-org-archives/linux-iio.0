Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8B61E5B70;
	Sun, 18 Oct 2026 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364334; cv=none; b=Y2LUZ05wGILOR4xh62cvyGxEaZ0vzkx+c2d/rhOdJtPQv+J6WCIe0pyaRcQWA89alVJyLdRvDkBLDqw7UlLwez/lrTwFc3i1X5UxgczWEJcUFljUEogxFdCOA3QjuYoPWlp7T2v32azMQ3/eS8Zy1gFSlZyKmlMTUOm1b0+Hfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364334; c=relaxed/simple;
	bh=sKTCM9JO9WnKfRk+OpPOIT8ZzgtwXLle8Ba5a2e+G80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bL7i9gB+NItXccCjBn35yQu7KT0H4IOxGrKTMLPUnnZNutnTcrAop6X2KdEIr7hWXBEmtTxmtu0kUroo5o6INYulzupoHBAeq22zH1FfFtiI3ZFzsgcw40Ae27aj0GPvkWr5qz0xWYdzIWBJcg/YA829jS5k7qM2e+EdgN9eB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXdjsm7+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXdjsm7+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048401F000C4;
	Sun, 18 Oct 2026 22:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792364333;
	bh=P8W0ukGwqq5l3dY+cMADZeErTiTu6wpC8dq2ZxvP/NA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LXdjsm7+lHxbrr87PP5kQaTrDmKmX1ws1/Q4HbrIT9PS/NqIi83s6mnyBTkecH7j0
	 Bz1vo1uv/jdSVIH4KaKTACMcx2gZuOK9bhzqDd+l1n4kxKK/rpBNO/OVHSLh/E5NeG
	 hc+/Mbn4O5MFP9AL5et8Rc/HAX4v/uz+lw20HlruiBx1zlqows0A37MTx1cZz8Dky0
	 m8HKZ9XbdkTogmfWiz5dHxACz/+h5C3OUzp77f7K/9/aN9dc2jg1OdYU7c+C1z98Bg
	 WJDAUV1mc1ythXS2YbkCvm3b/iFPReWXSbpLRv2fTNO1eX21oJC9FNdSOMl5Kua+dN
	 d5aCiO53RTP/A==
Date: Sun, 18 Oct 2026 23:58:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>, Conall
 O'Griofa <conall.ogriofa@amd.com>, <linux-iio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v4 06/15] iio: adc: xilinx-xadc: Use
 guard()/scoped_guard() for spinlock locking
Message-ID: <20261018235845.59228f7d@jic23-hlaptop>
In-Reply-To: <20261005151317.00001df3@gmail.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
	<20261005094205.1045874-7-dileepkumar.nagavarapu@amd.com>
	<20261005151317.00001df3@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 15:13:17 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Mon, 5 Oct 2026 15:11:56 +0530
> Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:
> 
> > Use guard() and scoped_guard() helpers for spinlock handling
> > instead of spin_lock/spin_unlock sequences.
> > 
> > This removes the need for explicit spin_unlock()
> > 
> > No functional change intended.
> > 
> > Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> > Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> > Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> > ---  
> 
> ...
> 
> > @@ -677,15 +670,15 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
> >  		xadc->trigger = NULL;
> >  	}
> >  
> > -	spin_lock_irqsave(&xadc->lock, flags);
> > -	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
> > -	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
> > -	if (state)
> > -		val |= XADC_AXI_INT_EOS;
> > -	else
> > -		val &= ~XADC_AXI_INT_EOS;
> > -	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
> > -	spin_unlock_irqrestore(&xadc->lock, flags);
> > +	scoped_guard(spinlock_irqsave, &xadc->lock) {
> > +		xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
> > +		xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
> > +		if (state)
> > +			val |= XADC_AXI_INT_EOS;
> > +		else
> > +			val &= ~XADC_AXI_INT_EOS;
> > +		xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
> > +	}
> >  
> >  err_out:
> >  	mutex_unlock(&xadc->mutex);  
> 
> Since you've moved the spinlocks to use guard, what about replacing
> mutex_lock/unlock as well?

Absolutely on this. See cleanup.h guidance: mixing goto and anything
from there in a function is not a good idea.

> 
> Otherwise this seems fine.
> 

