Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38344825BB
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206006; cv=none; b=VoVo2LVZ2SPmpEIVZIQUh+4arjbbuThrJwDjIx3UYilR0bdt9dzCUB9Gx5FPBAULbKP+86gxda120iNSmlnF01y2hGaDzYFj+pyRy8INLqaqHVNQwHj4NS85/97d0BAmf3WxU+z0wPc5um7J2ZatKFV5DmWmAG/Cv9D9r8K2FRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206006; c=relaxed/simple;
	bh=oDmJt3EJtsL6dISeusSh5puteEMhnMpuxIlCFWUAi3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHOdtsc1GFZnKEjzoxRS84GE85iiyL4K2iZh4s7bMQJf4BAbFaQLn4deo6DMUFzASvoB96Vw5ZkrVVmWKQt5VzFMwaOLtvcZZL6/Nk8e7y5LcQGV4WzGPem/nAudYxeHNE3khdWFPfKoNwjv004456pjF3a+zVVv/OROhkYGuI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca7fatL3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca7fatL3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49ff680331aso17599375e9.3
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791206003; x=1791810803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lUlOSe5A8lNERyF+m/EbmOxMTZ4XiY1F/mU41HusoYs=;
        b=ca7fatL35Cv054jFVqHdX1rQg57LW1v7nUCXKuhv2EHFSylCL9WYk9ARoTF7T3xWS2
         HcbLsRkEqmw9ixsjN9K9+TbQ54fAJ8rSU5e4GVoOPrq0aEy5xNKqbeMZKkYoI6hDiWqy
         f4EVyMH7LTBHQxpthc3YrT7FSLrZKAkFKVLlsyJvyQztBuMKOAemu7AQYShLyfswRzkl
         HPtWvjNfC35DhOL2jaJRbPIvWqZ6tKveUrDOIeWzxx5vPiwit7UgqzZhB2895TBqI9rA
         /mAAfB28J29y92RNNPwiiKGVIJ1j1tMb2rzMFqyBTg3rMFY+jI7BjIAzYcuyv+ZmZBWO
         ipwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791206003; x=1791810803;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lUlOSe5A8lNERyF+m/EbmOxMTZ4XiY1F/mU41HusoYs=;
        b=GHq3AiQ471+EI5NrKYeWN/85XxaF7Usb4AleKE3ozCj1y3DxjochvS7YAvs1t/nJL1
         ySq1xjVCoc3ulu1pqQl3y68vnZtdIbuIZQnGcS0Wnc5HjjesVqcOjhrzreJho3/qSthb
         oDzhLblXbasshMYLY/HoNjXZyBNlWxJIvUfq/LLIRE3cycWmyYGpjgQdsSJG5QFgpcRs
         wbDWLlsmuRt6CT8gBEHO1I0Y4jK4xRVZswx0coM5A31zmGmQ9kFLeN6G7Fp/SEuU9taC
         SI1VbT9bv5Xj/bIiYWv7hFcLz3wMLe+I7I/mP5xMA2ZYbx1g/T07YgpOVw2SxW3jBohA
         172g==
X-Forwarded-Encrypted: i=1; AKwUvBztzrxwDfgRsUdTnmAyvcP4Z0jH/aPqF/iePojmdszo8XgZDzKnHaoDcAiUD7YRMDS4oJC5ViLdfGY=@vger.kernel.org
X-Gm-Message-State: AFuF++myUKGRM4gaXNOHhV0flUynrLDfOipqhzypewU7hUdwPsiH2XUl
	f5fkX8PGk53coXNpJ8WXmGf3FRcRSp6p6UaYXOpCZGsJdqkUZujkj7IG
X-Gm-Gg: AYBFou3DbWzIvYVdZCM4/fOvi/gy3BO1+wiKFRZiWEEFbKHWZbrwCUbYGKo1KlZlqnX
	tfREgt0s68uBx5QqLcCL/mpNYT9jlsypCq49NM9gwj0HBMfkkCIgbOmYFeE01HTTRo9g+QSskr6
	PUqsbOuNz1id0sAfuXBNZN2IQwJzbqePR68EDRIKAuzhhAHPxVS8+hzHcCtbj8nI7X7cvaA1Og1
	lkpgZO57PkzgaAKWsTBZGPfIlwSmPfcnrQk8Mp6nrPuWwFOHvoyuRjUfF1+l9svByCBfX/O6mra
	Svy0xoTHgATSxVXm0c0W2Jy9rnti9msZbGq9WWBPbra1qSCKfOZtO4b+gldtuLnJvzkpIPtJMc9
	qaC1Km/mvx/jXeFd1RZqtNUAR47z0rVQLDm8hCewqrUEEvBdqOaQ5e7DRx72r379+TOTw/StQaG
	Fqo58znuqqCUEsELRtaj/rN51Zn6IlSz1O4jWyMnTuKBa3LtxDkyIk61s5hnxIm3WYhVQZCP3qs
	XS4UTj5HutvXZ0DIFBz54D0lPtzlNykxJiflIxxdArJMw5NBFe3BKIVEeXC3zsHYqetgGW0WJge
	kuT0sKVJSa0U3jQjcIXqpTE1fSYI4upydAVS0dsVApMf42AGagx7zOiHOn2W/iwiPh5nLLdOfH8
	wUIo+5pKep0DbBx/P0VxRyUF8c4QGocWZYXzFyLpVbqJmbt6tEDwAyPWBPEsH79ZHTRggSRf0Ku
	86MlUk2w==
X-Received: by 2002:a05:600c:4705:b0:49c:fc6e:a3da with SMTP id 5b1f17b1804b1-4a1680ffb88mr122325845e9.25.1791206003215;
        Mon, 05 Oct 2026 06:13:23 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027734b49sm343621165e9.10.2026.10.05.06.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 06:13:23 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:13:17 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>, <linux-iio@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v4 06/15] iio: adc: xilinx-xadc: Use
 guard()/scoped_guard() for spinlock locking
Message-ID: <20261005151317.00001df3@gmail.com>
In-Reply-To: <20261005094205.1045874-7-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
	<20261005094205.1045874-7-dileepkumar.nagavarapu@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Oct 2026 15:11:56 +0530
Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com> wrote:

> Use guard() and scoped_guard() helpers for spinlock handling
> instead of spin_lock/spin_unlock sequences.
> 
> This removes the need for explicit spin_unlock()
> 
> No functional change intended.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
> ---

...

> @@ -677,15 +670,15 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
>  		xadc->trigger = NULL;
>  	}
>  
> -	spin_lock_irqsave(&xadc->lock, flags);
> -	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
> -	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
> -	if (state)
> -		val |= XADC_AXI_INT_EOS;
> -	else
> -		val &= ~XADC_AXI_INT_EOS;
> -	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
> -	spin_unlock_irqrestore(&xadc->lock, flags);
> +	scoped_guard(spinlock_irqsave, &xadc->lock) {
> +		xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
> +		xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
> +		if (state)
> +			val |= XADC_AXI_INT_EOS;
> +		else
> +			val &= ~XADC_AXI_INT_EOS;
> +		xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
> +	}
>  
>  err_out:
>  	mutex_unlock(&xadc->mutex);

Since you've moved the spinlocks to use guard, what about replacing
mutex_lock/unlock as well?

Otherwise this seems fine.

-- 
Kind regards,
Joshua Crofts
