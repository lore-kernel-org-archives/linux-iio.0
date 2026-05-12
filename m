Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A0244685;
	Tue, 12 May 2026 15:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598277; cv=none; b=UTDJX/iwzbIHT9DA9UjXDI02i51cnyrwA9ffGQ+N+430vD6dSQxSaXMi6HwalVJ3f511CuHbP2fa6sllmKfY3t9HyJxdU8bErAveH9ex5sLEnb57c19zp6YALC9PPhH7H3kOY/frKhlGK5UevRQ2FCuIS7P2WqUkH4hrvaD3dYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598277; c=relaxed/simple;
	bh=Jh8wB++nRMfksvgJFGNw/6TDIGfcr7pUEu394XbV1bk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDYfsd5zcZ8nDRSJa6xUv+mgwGGWXHAoXVXMFiJYC7Evo3QllTBBhVgPBWz3DGAB2AgQN+ymVHy3ycNLETlja5indJLXlCDjqRTxqy8Ll+pUW1tL4WpKFobQ5sE5nijp8s9oin/9Cc8+ckQEpXVjeYI2lKjVVr50qVvqrRLhk2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6VGoOc+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6VGoOc+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA00C2BCB0;
	Tue, 12 May 2026 15:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778598277;
	bh=Jh8wB++nRMfksvgJFGNw/6TDIGfcr7pUEu394XbV1bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t6VGoOc+J7TDv95MHjr5sFqF3z02wNhrGLykWBhtkom7pEGcPBg/zvMCSL1Tc09WX
	 DvD20azI6Xdd4+hjbLq1UTkAhgkyXqWa3rKgMpVv5y9xi3ZARgJbqIWGqoheSpCc64
	 2CxU0qOcntGCjPodTKMcquficYdPG3bIB/nqmDNXfF5nQeZo6vouCRbEvzBMsShNtY
	 IUu4+UUangZ40KrAzi37BvspuG3/peelYSzly5rTDjyiuQ4EFl/gREI64JJXRY6gi4
	 EF9xiReLsvvg0a5D4HVnqUXVKB+NsEJzuQMWh9NY2UwEldieZAY2YuNnCGKUkLPvJ1
	 2aCsw++WAmaYw==
Date: Tue, 12 May 2026 16:04:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 5/8] iio: magnetometer: ak8975: unify messages with
 help of dev_err_probe()
Message-ID: <20260512160428.51c1e1f4@jic23-huawei>
In-Reply-To: <20260511-magnetometer-fixes-post-pickup-v7-5-9d910faa28b6@gmail.com>
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
	<20260511-magnetometer-fixes-post-pickup-v7-5-9d910faa28b6@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 13:26:14 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wr=
ote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Unify error messages that might appear during probe phase by
> switching to use dev_err_probe().
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
At this point things have become non trivial enough that I won't pick up
any more today and will wait for a reorder with any fixes etc.

Thanks

Jonathan
