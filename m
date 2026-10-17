Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C8C134CF;
	Sat, 17 Oct 2026 00:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195786; cv=none; b=Lj/GlUqWN30NvBOBDnWgoNnWIEIjkaiPUcRRugzOp60CB38b3ktl48wLWwqxe57EXE4NSIt+/mqD2yCVogP/SMv3XRp3EpSlWI840H0Ixl4KXPBc2fVGEbt76XQWvkgZm/yCgPUGy3Jp9o4rz4XUHV8O0T2arNR6pJw33eSZRc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195786; c=relaxed/simple;
	bh=B/Vu28PE5aVTgmyZPGkyQTIjPeDIfycDsT/paKjSF20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HI4dgcADsY1CdqULO99yuvudxsskTemZcoB8XzXAbaD21uBb6eNxVDTPX3pD0e7nps3Ti5CspMQNmAWO6Esbk+6bR548ttIbCStadk0x2FAK0aBR2Wrx9Bd+avnfcGPlyAy4vukHJU5EHyyhz66YSse4MpHMRDfK5ya4cCL+5LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8VsQe+T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8VsQe+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E34A1F000C4;
	Sat, 17 Oct 2026 00:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792195784;
	bh=B/Vu28PE5aVTgmyZPGkyQTIjPeDIfycDsT/paKjSF20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h8VsQe+TN5gQABE54EIUy/s9aLnGYz4hl4ceTgWv2hdts2Lm04ImAqQ7RD60RlchQ
	 L00HJSt0EGd44W9qI4YZACQCW8jlkK5MHuXdsly1KMHqDBvq0AtnmGE8+vbbfoXoLx
	 Y5LQ5wBsYeUTJZ3fvBD5GW/TyDFBQmVzmn83hupJanDMVczSXc3vMiK5XFVbk6VKP4
	 RIRFCGmbx50LxXtr8YCH/GitzW3ooNXGVxZUGiI9EEUgj7Y38UNfdfzKh2MgRYCV5+
	 yK/K8J+slu78gEMzvvJ3gHkMzKpwPdNRtqN05uUEKLs5c+bE/WmvYCH4OQmGq6gay7
	 BbZ2Z0prWlE9w==
Date: Sat, 17 Oct 2026 01:09:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: linux-iio@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] iio: adc: ad7606: use
 EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
Message-ID: <20261017010941.491b18e7@jic23-hlaptop>
In-Reply-To: <20261016131334.8029-1-abdelnasserhussein11@gmail.com>
References: <20261016131334.8029-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Oct 2026 16:13:34 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Replace SIMPLE_DEV_PM_OPS() with EXPORT_NS_GPL_SIMPLE_DEV_PM_OPS()
> and use pm_sleep_ptr() to wire up the power management operations.
>=20
> This allows dropping the #ifdef CONFIG_PM_SLEEP guards, simplifying the
> code and improving compile test coverage of the suspend/resume callbacks
> while still allowing the compiler to optimize them out when
> CONFIG_PM_SLEEP is disabled.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Nice.

Applied.

Thanks,

Jonathan
