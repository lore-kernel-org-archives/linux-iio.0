Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E4426EA0;
	Thu, 11 Jun 2026 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781194982; cv=none; b=u6HnoiqiMqE0AbO3uZuPaIjOqmkPFjGwNQSzvx65XAfDg8w5+No1wbUu+5q1axjNFp5XMkE3fuQiBqPhnaGt/fvqBBDjJfdcVweVje8nM3Ojj8+juxAoc1XTpab1wTzge/l2ow0jmXjzudFFLDfMHZjAa1gND4Uigtj2xP2DO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781194982; c=relaxed/simple;
	bh=muVSDjX53d8TQTWVnBlgJ5/xAs8r+BIhgIpwvV2kOm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWxysPGjaTmm2SkqVEuSRNK1VfLpc/AZ6JASnTkXFyip0J6dtvOXrfQg9i/HURyemd3OU1i2MyaMI3YkGiz2rIDRswuyMS7t5MCTDPVPb2DbopYNzN56bt+9uuemgP9K64MGZimiI+5DrC8O7CInUWTYqmCUhyuUWt5C4BoPrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSY6S5VI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSY6S5VI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2501F00893;
	Thu, 11 Jun 2026 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781194981;
	bh=esMWrLBQ2kLwc0esD2rBwWliAAyfi0GLNns5XwAS/C0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gSY6S5VIqgcXK+cyZKCJ2S+mn5vwvnvQxEmkOhBEQavO24PmXZ3P6lBOcrb59vv1e
	 6vPH5EuDfhB3iPnIs1BLue2lac5EPyhXVBE1zLYgF5NAv4kiDmMIHQos2Wwhod9kOl
	 RM1M+Qi/si4V/5T/W07bg5845iJ+pBsY99Tk9SgLjfCNAd+27kpgqT9i/LehK0UcAU
	 aVnRn5KqplWo4GMP3ylC6QKodq6K5FLRdHd9MVuWF4JZe2Ll5rWdLR/K/tRFGxizum
	 cHp6KtgvxsU9PBJmESZKJKpV3ieJ9z9e0r7xpm3K24DehiZak4QLLAaw4pyRHWwdN+
	 SFZ39mvxpvgXA==
Date: Thu, 11 Jun 2026 17:22:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jaeyoung Chung <jjy600901@snu.ac.kr>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Vladimir Zapolskiy
 <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Sangyun Kim <sangyun.kim@snu.ac.kr>,
 Kyungwook Boo <bookyungwook@gmail.com>
Subject: Re: iio: adc: KASAN wild-memory-access in complete() on early IRQ
Message-ID: <20260611172252.02256652@jic23-huawei>
In-Reply-To: <20260610115700.774689-1-jjy600901@snu.ac.kr>
References: <20260610115700.774689-1-jjy600901@snu.ac.kr>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 20:57:00 +0900
Jaeyoung Chung <jjy600901@snu.ac.kr> wrote:

> Hi,
> 
> lpc32xx_adc_probe() in drivers/iio/adc/lpc32xx_adc.c and
> spear_adc_probe() in drivers/iio/adc/spear_adc.c register their
> interrupt handler with devm_request_irq() before they initialize
> st->completion with init_completion(). If an interrupt arrives after
> devm_request_irq() and before init_completion(), the handler calls
> complete() on an uninitialized completion, causing a kernel panic.
> 
> The probe path, in lpc32xx_adc_probe():
> 
>     iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
>     ...
>     retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
>                               LPC32XXAD_NAME, st);           /* register handler */
>     ...
>     init_completion(&st->completion);                       /* initialize completion */
> 
> spear_adc_probe() has the same ordering: devm_request_irq() for
> spear_adc_isr() before init_completion(&st->completion).
> 
> Both interrupt handlers, lpc32xx_adc_isr() and spear_adc_isr(), call
> complete():
> 
>     complete(&st->completion);
> 
> If the device raises an interrupt before init_completion() runs,
> complete() acquires the uninitialized wait.lock and walks the zeroed
> task_list in swake_up_locked(). The zeroed task_list makes list_empty()
> return false, so swake_up_locked() dereferences a NULL list entry,
> triggering a KASAN wild-memory-access.
> 
> Suggested fix: move init_completion(&st->completion) above
> devm_request_irq(), so the completion is valid before the handler can run.
> 
> Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Reported-by: Kyungwook Boo <bookyungwook@gmail.com>

Hi I think the report is valid, but I'm curious to whether you ran these
drivers given the hardware is pretty obscure!  If not how did KASAN detect
anything (unless there is a static analysis version I'm not aware of)

Given age of drivers and that this only occurs if a spurious IRQ turns
up I'm not going to rush to fix this.  However, I'd certainly welcome
patches.

Thanks,

Jonathan


> 
> Thanks,
> Jaeyoung Chung

