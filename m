Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6482379C2F;
	Fri, 15 May 2026 14:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854814; cv=none; b=AMKxP5vuuFO0AvFyzbNpuTY986bvlAaazaYK6J7bz/JKqv6Mm1VHp8K9hB8Yd6AfeI0B2C/ou/lv6xQY9vtqT0ZYErXVnYnb5UfU/Asup0w9VZZBTSuJA+fn0QYnz7xuXr6vBTX5iSW/KsGkHsrrKk7YGHo+sG/31SoK4aNbOEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854814; c=relaxed/simple;
	bh=+FjzTY1a2PXcqS7HPQ7lDJVZs4ZsJlmosw9TupILsLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNTLvyzMOSm1MdBVpRx2qg7IgcxfmL54x0VsYIKgKZXisrJMvcCy2kMA3+dMP5fDtyo94i+6y76HhN6pNfBu8d9bhLI5VhpZmwZ02pQesIuMAZnWY+Jf/WARCOGp0IisOYjjz06hifGHs1FcvJl9XIjKcT3JLrIkwBjpuYn7Vok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSjqgTPi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSjqgTPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91438C2BCC7;
	Fri, 15 May 2026 14:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778854814;
	bh=+FjzTY1a2PXcqS7HPQ7lDJVZs4ZsJlmosw9TupILsLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WSjqgTPiuDS0JViSJqGHBCLaE79ZfwWH/t48yLH/lXzAwVeYnuz/fWYEDpsLdHr6Y
	 vkpCET9TzitH1akn+Z7ZQ4IfLbPU3rrP9iM5DkzrkcCrSvY9w8YBNW4/kaNpDY5zLx
	 v8e0uU9bTvEGoFhKlm0f4xGTzwqzfKOsCYxRigb+czKH5CsgLLVzkXs+z5jQGODjGW
	 BlHzDBzCPw+eT82pb9P6NS3mGCLyoecxIvkADjIeygOod9G5DoH91GyKyAVOXF8AQY
	 JJ4nClpRW9MRGst1xDrnUFyGYPiChvHISWGdZugxyIwBnFNmVnMO+kM06k5f649ksx
	 ciDwA9jwiXiig==
Date: Fri, 15 May 2026 15:20:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?UTF-8?B?0JTQsNC80ZjQsNC9INCT0LXQviDRgNCz0LjQtdCy0YHQutC4?=
 <gdamjan@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: only set IRQF_ONESHOT when thread handler
 is provided
Message-ID: <20260515152005.355fffaf@jic23-huawei>
In-Reply-To: <agb5hiF6GhNwGa6c@ashevche-desk.local>
References: <20260515-patch-iio-buffer-v1-1-667dac4e55e5@gmail.com>
	<agb5hiF6GhNwGa6c@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2026 13:46:30 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, May 15, 2026 at 12:46:00AM +0200, =D0=94=D0=B0=D0=BC=D1=98=D0=B0=
=D0=BD =D0=93=D0=B5=D0=BE =D1=80=D0=B3=D0=B8=D0=B5=D0=B2=D1=81=D0=BA=D0=B8 =
wrote:
> > iio_triggered_buffer_setup_ext() unconditionally passes IRQF_ONESHOT to
> > iio_alloc_pollfunc(), even when the caller provides no thread function.
> > This causes a warning in __setup_irq() when the trigger is later
> > attached:
> >=20
> >   WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x4ee/0x700
> >=20
> > IRQF_ONESHOT keeps the IRQ masked until the threaded handler completes,
> > but with no threaded handler this is semantically wrong. Only set the
> > flag when a thread function is actually provided. =20
>=20
> Yes, please read the mailing list archive and find the previous attempt t=
o fix
> this and the associated discussions.
>=20


Just to check - what is the driver in use?  The fixes so far all belong in =
the
drivers, not papering over it in the core (note this is maybe the 3rd time
this same patch has been posted and rejected!)=20

Jonathan
