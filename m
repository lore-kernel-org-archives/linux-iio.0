Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C464A38655B;
	Sat, 22 Aug 2026 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787437073; cv=none; b=Lp1LV18UqtRxe/5FTNSfea0P4CcAJkcwd/4MyPrPpbQ6vvjh9JHPy2evlM/nIqvfpZpNOaGxeJEqWZIg7QmPd5VrdQsn1sTmUalXC/nkx+h750uVOveHChQLPsz9pu7hCpBFZjuMhG0s/wXMZYl+8ynlbSIWA5DMX6j4id9Cq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787437073; c=relaxed/simple;
	bh=QdJnP9cETy9XMiJacBakX4iIqpuk68TAPxp/aA/bEDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeUcibuwfOtUIE6SU4QmKbS9ui/dljXizb+dadNW75VTb6Or1bBDQVCVs5w7oHWljJJwDqolvGkQ5+bZzXr9Fq7YlT4WgMR4b99mOfV9DriUgOee7TxPekfNXnzkMOyo6L8ShIQvnhDgnKotqQMhA7L1VRFWYvitpH6Z2RQaCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyE7vHMo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyE7vHMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F181F000E9;
	Sat, 22 Aug 2026 22:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787437070;
	bh=v7v0/1sNraOybEHleoo5x3jgGNNJSzqwXPazpsbPgBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TyE7vHMoiRK2lJWNeNqkGi/d3nSy3qcF52d5+/eDoOKfB9WLC1ySBhAI8FTGg3yD/
	 BTtxeVMlun1jkgKF4iB7avFTWSf3056gBLbzMiyedodyty1SC73RPojQ7VF2xZaNnH
	 sirLmR8VZFvTNDxzW/LVdr4qLESiIlMjoZ9RD300cYnPWcI5yJpnzUkeKJCI+3reIa
	 8fuU5rw8Z5Aa0GdGwv4rQu7Cyv7Ipyn13n7lCQRv7ElWb7MDIvaa5EeCHCYfpr1Ht6
	 6j18AOxY71g+FnsbTmSH8WUkMVbOoGiEzHo1iJ6Yd3nAJm3X+wAgdp1l2e3CPc49le
	 aKW8Av1sKz7DQ==
Date: Sat, 22 Aug 2026 23:17:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ruoyu Wang <ruoyuw560@gmail.com>, Linus Walleij
 <linus.walleij@linaro.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Alexandru Ardelean
 <alexandru.ardelean@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix runtime PM leak on trigger
 errors
Message-ID: <20260822231745.18219605@jic23-huawei>
In-Reply-To: <aoK4VOdjFchVJWn0@ashevche-desk.local>
References: <20260814134111.1387580-1-ruoyuw560@gmail.com>
	<aoK4VOdjFchVJWn0@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 10:29:24 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Aug 14, 2026 at 09:41:11PM +0800, Ruoyu Wang wrote:
> > The first user of the MPU-3050 data-ready trigger takes a runtime PM
> > reference before configuring the FIFO, sample engine and interrupt. If
> > any of those operations fails, iio_trigger_attach_poll_func() tears down
> > its IRQ resources without calling set_trigger_state(false). The buffer
> > error path then releases only its preenable reference, leaving the
> > trigger's reference held and preventing runtime suspend.
> > 
> > Use pm_runtime_resume_and_get() so a resume failure does not leave a
> > usage count behind. Route later setup failures through a common unwind
> > that clears hw_irq_trigger and drops the trigger's reference. Successful
> > enable and disable behavior is unchanged.
> > 
> > This issue was found by a static analysis checker and confirmed by
> > manual source review.  
> 
> Why not using the respective PM_RUNTIME_ACQUIRE*() macros?
> 

That is only applicable in one location.  Nice to have though but
will need combining with a guard(mutex)();


