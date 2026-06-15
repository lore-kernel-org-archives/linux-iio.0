Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889A3A3E8C;
	Mon, 15 Jun 2026 12:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525557; cv=none; b=GZJ70pxsL6mqsaunnY7rphXw8E3KhGfEPhZU/YQiMLArn8vieA8AbAGh6cwXuY4uLbDqHEyl8N9w6BF20Mt/G38NMKFyLgSTWMezEHwuhGEQhcm9z/b0K3tueuyxwEQLk1NTIfKBL2+d/Pdpd10RbkIZkObkAU6I+16qtW+GA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525557; c=relaxed/simple;
	bh=W/WCRwIQP6sx+CRFodCL09q0Rf0AWaVqiqWYS7Rh9Ck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dgeGm1qZK9pVuBW8VRBqTfEwfjeWSH9t+czENSNSTNWU2Hw+HMoCP9XcPIvrwxNUWpD/cFxgyn5maOWmtg+yl7RolUJ4h4SWRGX/rzAW0ZJMR2/LrGBRm+Jq78fezG2zahYPKMmB9TZu3QRY3Qh9hHJ7cfZcqZxiZPnuGb2f2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C2s4seLC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EpAYfsB4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C2s4seLC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EpAYfsB4"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781525553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/WCRwIQP6sx+CRFodCL09q0Rf0AWaVqiqWYS7Rh9Ck=;
	b=C2s4seLCtZhqN6EWLjrU3S3fvyK5NHy19iKOfAt+tn67TrJHqyNJaicFYqoLYn2RpLUKe4
	CRpXHnqk09bm7oMcNE00y8TXejy6QdBPL2vSFGzQvJGmwTQlMxOUJcKist05Xs/1CpPO/u
	i4vIJrr089l9PWtax4joXaelP7afXF3stxi8x9WF8D3OfTPKZeIM4pZwWiXgqgcHou4WIi
	53AHVdcm1Z6epALdu9Gr4RfJEThF/JbTwlqq/7Swu/TGVGt4Bnq0KarSfr0cqDkAxKTMR/
	/V2dZlcGHJpmWNXvqWZKzcdcSh670FjM/i3sEqaiAW8iW7LtGiXqXXD8wzO40Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781525553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W/WCRwIQP6sx+CRFodCL09q0Rf0AWaVqiqWYS7Rh9Ck=;
	b=EpAYfsB4ewsGmMKi0R5RMnZsEyHbrJEXjQE7mCLnA0qd/LwT7eYJvjyL2XeaNTd1LdzGIR
	tFv5Vh0n7SiD4fCw==
To: Prashant Rahul <prashantrahul23@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Shuah Khan <shuahkhan@gmail.com>, Prashant Rahul
 <prashantrahul23@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Petr Mladek
 <pmladek@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>, Oleg Nesterov
 <oleg@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-adc12138: fail init on calibration timeout
In-Reply-To: <20260615111156.199906-1-prashantrahul23@gmail.com>
References: <20260615111156.199906-1-prashantrahul23@gmail.com>
Date: Mon, 15 Jun 2026 14:18:33 +0206
Message-ID: <87h5n4uhn2.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2026-06-15, Prashant Rahul <prashantrahul23@gmail.com> wrote:
> adc12138_init() starts device calibration and waits for the EOC
> interrupt before checking the calibration status. The wait helper
> returns -ETIMEDOUT if the interrupt does not arrive in time, but the
> init path ignores the error and continues probing the device. This could
> lead to registering the device even tho it may not be properly
> initialized.
>
> Return the wait error so probe fails cleanly when calibration does not
> complete.

After the timeout, the driver checks the status. If the calibration is
not complete, it already returns an error with the appropriate
information. I would expect that error is preferrable to a context-less
"wait eoc timeout".

John Ogness
