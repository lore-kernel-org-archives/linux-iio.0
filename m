Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533166;
	b=mZdReb547LSWV80B9t4i4dKPOC20l1p8PoNRpgAYrmFcAVV8oJ2mnHXd9BAjeJfOxSIp
	 o1JvRMfYsnGUYPMpH3OxOhmHM1Q2SQOrMglk7Mlv3wf52ZNt1XUdPzCr44gU9gNmU3Wl2
	 h2qtjjjz3IBZGk1qiy3bYztArX8dH9sbVoW9WO7kR7vkwYfgIdQSxEBtWRfFw3WyYwwfu
	 Vh31mQxyPtgwWT1weo8YL9T8yHK4ekt5yVkjyDHd03v1pgXqYAKlWA1/OOEZ7CZfUGB4F
	 FRGctDpbKzx4JmEQqml0EyXbqaP9ounaTP7xIQ4Tvk0guubPzTxTpWNXSp7IpHVcFXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533166;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hn4/JimcjLWSomeENzWQ26kW3zxyIacdt8yyhBA+LZ4=;
	b=UKMsRyohjicoruVC0HgqycroqWwTMTRk1PFjmTACwqjQ9KBTg/o9E3xk2jrknLK4vG1x
	 iWRvL/SyaZCEmPInCiJqgzDHk49TqZKYmyCPjw6lu4VdKMqzmWX3ZTZpH/JlM9LaTcCaZ
	 4SBQ9p2Y+mA4eMAzBsQivojEfYgDtrA938jJlvTWs1dGxnvlShpbvAVb+Z8jdq8FRYKMS
	 uASbvD3Zf9iT/99qfStTa4OWqwGDg+z4iMOOqYAsjUoZdKRbHcBJIQ6jn5UZ/xaqobDZo
	 40bXHxyeLV18hPSIyIR4RmWdUnuUyE/yPZ1+99RQPO9cGtNmh9wWB4vmRngRmkh1bBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BfkdJxfF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB7606A321;
	Fri, 13 Nov 2026 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BfkdJxfF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942CA1F000C4;
	Fri, 13 Nov 2026 01:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794533165;
	bh=hn4/JimcjLWSomeENzWQ26kW3zxyIacdt8yyhBA+LZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BfkdJxfF7XAGqqVR1I/JBZnDT6HYfYly0snwkGUTlXl5oLy0Y1kO7oz/FnO0Lfnh9
	 kxLZ7+rpCNP6pvklcLhgiFkk2jalYh6+Nx3JA+9uDdobh8YkjQi+zpFmsJFg4xdewA
	 hC+s6G1QyRBRd8Ki4ZK53V2Equlo81pgoYsAcYnjcJa7ZE2DV1uk4S245znJi0/hxk
	 CRPP75sTzc96+bw+gnR0bfoj4T75tByR1HYe+tgHuZewWUyfQ9NrvnEStGf+A63lx5
	 a1POXoZMGbHX/sAbxk3OA/uKHt/ahIOy3xviwxIWt3Z/HaRyWV2ckplQGS2JaJhM2M
	 mYkEQOLqwgGHQ==
Date: Fri, 13 Nov 2026 01:25:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
 paul@crapouillou.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: buffer: hold a reference while DMA-BUF is
 attached
Message-ID: <20261113012559.103d333a@jic23-hlaptop>
In-Reply-To: <20261112070940.2527455-1-shunsheng1218@gmail.com>
References: <20261112070940.2527455-1-shunsheng1218@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Nov 2026 15:09:40 +0800
Yaohan Li <shunsheng1218@gmail.com> wrote:

> iio_buffer_attach_dmabuf() stores an IIO buffer pointer in the DMA-BUF
> attachment without taking a buffer reference.  A delayed DMA fence
> completion can release the attachment after the IIO device has been
> unbound and its buffer freed.  The release callback then dereferences
> the stale buffer while detaching the DMA-BUF.
>=20
> Take a reference when storing the buffer in the attachment, and drop
> it after the final detach or when the attach operation fails.  This
> keeps the buffer alive for the asynchronous completion path.
>=20
> A KASAN-enabled test with a DMA-BUF-capable IIO test device reproduced
> the use-after-free on the unmodified kernel.  The same delayed
> completion sequence produced no report with the change applied.
>=20
> Fixes: 3e26d9f08fbe0 ("iio: core: Add new DMABUF interface infrastructure=
")
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
