Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079722848BA;
	Sun, 14 Jun 2026 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781465305; cv=none; b=gPM9Bo2A8azIvWuViTYfzwzBxUSMTcFC6YhuBhswg52uGJeO5TcybF3UDIpuz7aMtriTB0HQSUzTycYRVYQjuU1mX8MfT8GXmiu0OjBDtPagejBpc6Kr0ClJwVrWCRh7V43aK1DXy8WGYTX2+ahyNyR6OXxOzHsbeH6IGViYXKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781465305; c=relaxed/simple;
	bh=DuHU0W+I7Q0zIttDUkxf5VKqykFgDFqT1/PREiCGvaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyGMW7bWciHMlL0MN+ONsGZnRn6qEveLlaCyDZ8pvV6h1RDHfc1Pkw6+maYBcYEAqJcEAUeDSKyVcU94rh8JtVEo29SpY06odH6HHZOy1NlsdmXsO6yDc5tEW+eEkb0b5irYYn+C1jF/bJP22elnk4DHqVgkvd2tkllZ2C8lcxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab5xNooA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab5xNooA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A961F000E9;
	Sun, 14 Jun 2026 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781465303;
	bh=AqkXQhg4DIPdFfl1AP7SfTKxKcCnu+ok9f1PnQjA/Jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ab5xNooApYYZ9Rrsf22AP6FPtJ1mjFAKT0gHWbrwdWIrZJcTCIOJMj1TWL7E9aSbe
	 dOe3bKbYntDObC9WYTVle2KnqOJpfpkNBuYrgUowIeUXtpqDLPGGYL/4sxCdThssfB
	 9FGRMIj/YyqR3Bl5ZXl+ttLl8HR4KzPjLJhPTvgBXbNWsNancX4i7d6WNgdIBvJSwb
	 m87aUIDvUzjDl7YtiRFwfRAKitIQ8Rnfs0KLWxgYGcqn6/wCGGGayGzaw3aF9eTx/6
	 yUlK1EHhlIEN4W0hmZXbBGPXw2CCKd6i+HY3QFSgYPw6k2LbeLvUX03swqm25R/fvT
	 GnpHJ/o8OjWLg==
Date: Sun, 14 Jun 2026 20:28:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 andy@kernel.org, dlechner@baylibre.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com
Subject: Re: [PATCH v2 0/2] iio: add IRQF_NO_THREAD to hardirq-only trigger
 helpers
Message-ID: <20260614202815.2a4df6b1@jic23-huawei>
In-Reply-To: <20260604014247.124724-1-runyu.xiao@seu.edu.cn>
References: <20260604014247.124724-1-runyu.xiao@seu.edu.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 09:42:45 +0800
Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> This series fixes two IIO trigger registration sites that pass
> iio_trigger_generic_data_rdy_poll() to request_irq() without
> IRQF_NO_THREAD.
> 
> Both sites are intended to drive iio_trigger_poll() from hardirq
> context, but under forced IRQ threading they can otherwise run through
> irq/... thread context instead.
> 
> This issue was first flagged by our static analysis tool while scanning
> request_irq() sites that register iio_trigger_generic_data_rdy_poll(),
> then manually audited on Linux v6.18.21.
> 
> It was further validated with a no-device QEMU selftest using irq_sim
> to model a parent IRQ and a child IIO trigger IRQ under threadirqs. The
> same trigger path ran from irq/... thread context without IRQF_NO_THREAD
> and stayed in hardirq context after adding IRQF_NO_THREAD. The selftest
> logged:
> 
>   3395 selftest: phase=bad current=irq/30-patchpar in_hardirq=0
>   3395 selftest: phase=fixed current=swapper/0 in_hardirq=1
>   3395 selftest: validation succeeded
> 
> Patch 1 fixes the ADIS non-FIFO managed trigger path.
> Patch 2 fixes the BMI160 data-ready trigger path.
> 
> Build-tested by compiling adis_trigger.o and bmi160_core.o.
> 
> No ADIS or BMI160 hardware was available for end-to-end runtime testing
> on this submission branch.
> 
> Changes in v2:
> - move build/runtime validation notes out of the per-patch commit
>   messages
> 
I forgot to say - there was something corrupted in the 1st patch so
I made the same edit by hand.  That is probably what stopped Sashiko
from looking at these.

Jonathan

> Runyu Xiao (2):
>   iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
>   iio: imu: bmi160: add IRQF_NO_THREAD to data-ready trigger IRQ
> 
>  drivers/iio/imu/adis_trigger.c       | 3 +--
>  drivers/iio/imu/bmi160/bmi160_core.c | 3 ++-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

