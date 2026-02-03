Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FF03ACF1A;
	Tue,  3 Feb 2026 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770130741; cv=none; b=Fs18hjh6O43jyDkoJ7OLNBqn1RWe3KfAZrOF40hnT8htl4DbXjYU1u2CMTEE/wJ03zpu+hW+LpcG+yU9Y07PwRMGQRtDrLWqocXOn4k65xcgMcoVyVLuiwtH/3tV2JdGj91XcvrCQRRzGQ7pbFolgZQzftq1eFeVnf80I31NaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770130741; c=relaxed/simple;
	bh=/CgpkCXqi2BgPRKjvNA75HLNpJNWrR0w9uHDx+7PG/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxAcQZw7tcpBn7YRwcVrljngSzUQuTn4HWbI5ZmZi9CwCOr0WuIuxQe4s5y9RpZweoJB/TyxVW2qEO690z/KCzatZhP3YkF6ljc41xCbaczqBbtYQpE/Pnuuf1Zunq1fMb+/E/+mt3A//LwGrudlUl0yXjYUbRTSdswQ7ohM03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YPa/FZ0D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i0Ye+I3V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YPa/FZ0D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i0Ye+I3V"
Date: Tue, 3 Feb 2026 15:58:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770130738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/CgpkCXqi2BgPRKjvNA75HLNpJNWrR0w9uHDx+7PG/A=;
	b=YPa/FZ0DI8HsxyXlsnSiZkBK9HNZm+U3fBm2trLdRfDhfOB32JvwTrzwlYfwct+fCtH3j+
	F7uBs4CKpSxKbCwVKbkJTu/72CEyoSbVX4zliUpaIe/5mjdEGwqvVsnh8lVWB6ioEHAcEJ
	EC4JgitGVAIc8zyv6i6PGY409UcTwnMjZCZxl+J1O5mfQnhr3+Yf06SaVi6+7UTEBwSvUn
	zQcKmet8rjHb42vuugwS6jthB7Ps+fTeF74m6QoNO+A0hlBrMXzVGoAhUHPOeTk4oFn4rD
	tylv8byCiIu23MQyZ3droFQ4RsJbN6+ccfRJimH2URTiYxx6auHSAhU8OWivMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770130738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/CgpkCXqi2BgPRKjvNA75HLNpJNWrR0w9uHDx+7PG/A=;
	b=i0Ye+I3VHWffMfLsIKIM+teFIXjUoBHHnmbhUV/umXPrGAD3fo2sYu79fk25bC0VUsyShV
	YhGw+EzfCDc6xrDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [tip: irq/core] genirq: Warn about using IRQF_ONESHOT without a
 threaded handler
Message-ID: <20260203145856.Rc52LIS5@linutronix.de>
References: <20260113120541.YVf2vRA3@linutronix.de>
 <20260202232741.13380-1-spasswolf@web.de>
 <20260203083826.1gOzxrwt@linutronix.de>
 <476cf5e072259332676c431c19ca3188705a86f1.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <476cf5e072259332676c431c19ca3188705a86f1.camel@web.de>

On 2026-02-03 11:43:53 [+0100], Bert Karwatzki wrote:
> Yes, this should call warn_no_thread() when the interrupt is triggered, b=
ut
> I don't know if these sensors are actually functional on my laptop (I've =
never
> tried to use them).
>=20
> So I installed libiio-utils from debian and this is the output from
> iio_info:
=E2=80=A6
>=20
> The iio:device* sensors all report 0 for the "offset value", so these
> sensors are maybe non-fuctional.
>=20
>=20
> > What did I miss?
>=20
> I don't think you missed something, but the thread function being NULL he=
re
> could a problem on devices where these sensors actually work. (Or perhaps=
 these sensors
> need to be polled and the interrupts never trigger (?))

I only found one handler where the thread handler was NULL and it
returned WAKE_THREAD. So this _is_ broken.
Was it one of the driver I mentioned? If so I suggest to fix those
first. I have no idea how this should work=E2=80=A6

> Bert Karwatzki

Sebastian
