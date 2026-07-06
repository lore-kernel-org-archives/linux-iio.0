Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A33264EF;
	Mon,  6 Jul 2026 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352749; cv=none; b=tHpq+ndzP3DTahVNRJvzNdQT1FIBlA2rChm+4YpSBig0CnKxQ1ROSFZHWJbemy3J5ejKnOkozRmxiCEYLvRdoo0oLOESmK7sl/rPyqDb3KKKRAZiMy2WtGjiZDulmAU0zPfojTV42ZjS13CuhkKe3JMX5eoG2ANU59ibEdVxPSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352749; c=relaxed/simple;
	bh=fGwM89oR2IPy2zVjZ9t88gTDKBi7EO7hQ5vHCiS2LGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hS64Z/HkzE8B/zpGdeBxmKnccAhEbQ8EIK2ZDGK55yVeQFJCf0tA5KKDpBUFEukNyPqQrZslRBu4PUhkSRNtUwJEdT3o5NvNbyRkDeBR0uz0ULHXQKJbjNdRruSbswAiN/7YVxRDr5FpoBCMWM01tV+TC3WMTK2AU2yxEfNf3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cabTvmhf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cabTvmhf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795701F00A3A;
	Mon,  6 Jul 2026 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783352747;
	bh=8T+PyJdMiDWGNQ913FlarMxsihdgsB08w3cx671Y3yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cabTvmhfSiXilHRfI/mUZSLC4Kz1BgXwR7vy4rEW/HO0xMwtZYco7inGv3iuWuprF
	 4kcGszQ9NHtp8YDS9cyVemICkQ6ZLwcghdVokVwqnKm8fvuG+6hGjAnigbSE5bOjIQ
	 i/+Uoygbq978A3JuUs6LmD1OsGpKNgDm9CLx9RIWT0XMTVMzRCM4Q1WtRW+q6JqKoC
	 ixjmK859QIqU+ZL+jIp9YLoKH2uMAiXJHiR7sxqe52ThGkeshSvoRUFHbNG7iK9F4w
	 7wjXZt1g1GfXlFNi/BFkjFf/Gs9sL/cFPa7VwoV9P88lIRDETqZ6aKvLPNBsFDk6iB
	 iAZAUXJ4IaM5g==
Date: Mon, 6 Jul 2026 16:45:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, hcazarim@yahoo.com,
 linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3] iio: adc: qcom-spmi-iadc: balance enable_irq_wake()
 on driver unbind
Message-ID: <20260706164542.0792f20a@jic23-huawei>
In-Reply-To: <b8f7df64-3e1d-457c-9e8e-57e4d2bf7ca1@oss.qualcomm.com>
References: <20260529095649.2452-1-sozdayvek@gmail.com>
	<20260704000415.2446940f@jic23-huawei>
	<b8f7df64-3e1d-457c-9e8e-57e4d2bf7ca1@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Jul 2026 13:25:48 +0200
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com> wrote:

> On 7/4/26 1:04 AM, Jonathan Cameron wrote:
> > On Fri, 29 May 2026 14:56:48 +0500
> > Stepan Ionichev <sozdayvek@gmail.com> wrote:
> >   
> >> iadc_probe() calls enable_irq_wake() after a successful
> >> devm_request_irq(), but the driver has no remove callback or
> >> matching disable_irq_wake(), so the wake reference count on the
> >> IRQ is leaked on module unload or driver unbind.
> >>
> >> Check the IRQ request error first, then register a devm action
> >> that calls disable_irq_wake() so the wake reference is released
> >> in the same scope as the enable. While here, drop the inverted
> >> "if (!ret) ... else return ret" in favour of the standard
> >> "if (ret) return ret;" pattern.
> >>
> >> Fixes: ce0694841ea6 ("iio: iadc: Qualcomm SPMI PMIC current ADC driver")
> >> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>  
> > 
> > +CC Bjorn and Konrad as we don't seem to have a more specific
> > maintainer for this driver.
> > 
> > Seems low risk, but nice to run it past them.  
> 
> The robot pointed out to me that this makes probe fail if the
> irqchip isn't wakeup-capable, but it seems like that's never the
> case for the one that will be used (i.e. the QC SPMI bus arbiter)
> 
> so:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>  
I'm clearly going crazy.  Seems I picked up an earlier version and
failed to track that correctly.  It's already upstream and from a quick
eyeball is the same as this patch (I think I must have picked up v1
after v2 discussion showing that was right option).

Thanks anyway and at least this record will exist of that wakeup-capable
thing.

Jonathan

> Konrad

