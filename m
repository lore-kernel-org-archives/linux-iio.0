Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504CB338931;
	Fri, 27 Feb 2026 07:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176453; cv=none; b=igxSrOHjj4LQJx3wcApKYDvxwJpNx97Qcu9logqczvFQdQdyoDB8WbNRdhr0Mv89Uc7PSQi7H1J1M+m4Tm5+FzV6u6A+Vl0fCWED0MNfnn/DnqaBdMqs9fml8crcsD6x1m0usVUkvsVP5Gfq5mnnsp2HWA/a7Z1L/gts4SfK5cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176453; c=relaxed/simple;
	bh=pEjjLzq6Q+0HuwNab1Yb0GyrjU1GdBjYRJM0THaOOcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvhcXHsK0+QAl6RdXkaRslHYrLXzZDFL+k2hwzzfbH1OfhMSMb7vVjAf+hCMB6FFatkGGwbFuBkPAULnH6dOKtT80DD5eD74IoU/NVXT92MnnOVUADzV5igd9bM1QgEpkaDxULC3VvuelwDn750uP1NWCFVP61LED7UjwGgiJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xfv7M9XQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QSJNKaCb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xfv7M9XQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QSJNKaCb"
Date: Fri, 27 Feb 2026 08:14:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772176450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eF4AKQOtFr8BWWM7124RewZGU+BHn6hKtHtTEejXIKk=;
	b=Xfv7M9XQp4itdG8o3hgnyGV382wQfEztd84cb34VeSjZXNCWeKjBc+aSlc31TTi6NWwPL3
	QAA4/9+lI7XjfLv1p9c9hbbAiiOQ3VGNWBBRPtENpL+EYWMYRSBXCjjJoPmtCQF4/72qZy
	Q2lz/S0oFpiKcsIGtXP2EG7VdrwBLflpcJnb/uEc7BtW+3YRAKrY2kSq8AAcgiOwV2NPIa
	pl6ex7X8wQ14Q95g9xXd5vjKuX5Q1hT30sOd2I/siLnHy3F8od/2YZMpfaWlTHoZlwO/xZ
	43Iz0rqcEq8KSe3cfjx0dx+1Vq93m6kRlkSGKQ2W6bAyAkvaf59MFy4miAUhtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772176450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eF4AKQOtFr8BWWM7124RewZGU+BHn6hKtHtTEejXIKk=;
	b=QSJNKaCbHjWjPnjWp/jRgfcvAFWEgDSEIDQXGD6JN0BcdJLhTowYeA1tAmL/1HFQES+cQx
	QOVOJQrHimcH9wBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: abp2030pa: Replace IRQF_ONESHOT with
 IRQF_NO_THREAD
Message-ID: <20260227071409.aEG-iBFD@linutronix.de>
References: <20260227-abp-v1-1-b6fed0545852@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260227-abp-v1-1-b6fed0545852@gmail.com>

On 2026-02-27 00:43:51 [+0800], Felix Gu wrote:
> Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
> without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
> in IRQ request and gives a warning if there is no threaded handler.
> 
> Replace IRQF_ONESHOT with IRQF_NO_THREAD.
> 
> Fixes: 47d323ce1e89 ("iio: pressure: add Honeywell ABP2 driver")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
