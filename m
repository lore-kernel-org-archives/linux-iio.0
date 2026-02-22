Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDCF218EB1;
	Sun, 22 Feb 2026 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771779259; cv=none; b=US9BOc1aJvGvg58fVM5iitmUdo2de4eks5WDK8f4OH4uSxkQVW3IfnjNCbp97OIrm/X8fPdNa/cwX16F4S52aofe3ZGhrbaMAS72JlyMyyL5S6/EO9b+mpb/VZxPbN1auZV0NDLVeW24TZ/M138FvLqawz9RhCSoeBVFd9FutRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771779259; c=relaxed/simple;
	bh=JTGp61DdPBMSQJuxhpElAFYbZJABqs0rh0j17ag4Vjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGiG+rAdFjsYrsI/uwapKzAwRo5nNrmk+PdDV0Fr28y8jvpetPUls8uQLOfhAZLPXgTG6usJLq7sYHpnm8OJ3ilxVKxh+7Meolyurat7TqzkW42pgpqrNN+sdiMZmROnKwWQrkdNpJsUMQJjuBIvhlYXQ6Ucpj9EFHlZV4/s4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5Lf2Wjt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5Lf2Wjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE643C19422;
	Sun, 22 Feb 2026 16:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771779259;
	bh=JTGp61DdPBMSQJuxhpElAFYbZJABqs0rh0j17ag4Vjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B5Lf2Wjt8uFGxMdVnf5qOW1xNSAFT+TfmJJlja9cuJsxYvFtatWspNnA3DcAVvBeF
	 qX4hrZz564RLbBXfLR0EmVRK0lwfF3Wboq4DnV02CBnrO8txH6PeQ/WwOWKO0aigA4
	 HSWIG6kVeS+vN9h/Kgb+afTuK9aHaA26wfXL6qT/KCdiliptcrOPra9W4eOIgaNpQC
	 IyejfDJkyUUcv2wdL7zkzAc1XtVqGxSA6PjpWdk41MaBN9CRn3TzQckvHcDNnEqGCT
	 PHzcItvmBAQu4wQDpMD6Yp6+U2BVcB8PSxApudk96rFAkoQuvB/gecnixs2MDHXHtR
	 TyTkwii85slxg==
Date: Sun, 22 Feb 2026 16:54:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 1/1] iio: core: Simplify IIO core managed APIs
Message-ID: <20260222165411.427e6a9c@jic23-huawei>
In-Reply-To: <20260220132912.2392102-1-andriy.shevchenko@linux.intel.com>
References: <20260220132912.2392102-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Feb 2026 14:25:19 +0100
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Use devm_add_action_or_reset() instead of devres_alloc() and
> devres_add(), which works the same. This will simplify the
> code. There is no functional changes.
>=20
> While at it, inline devm_iio_kfifo_allocate() into its only user.
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Nice.  Applied

Thanks,

Jonathan
