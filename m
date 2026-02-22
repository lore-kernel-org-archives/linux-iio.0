Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28A1DDC1B
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771763888; cv=none; b=ox7sK1VgY3BTAkrIquw3rf9OoX6B3Wb4qfuETev0cud5Hwm92tq/GbG2SbnJV/CfOizHr5e7Aipxxom3zywzfpkDyuvlpqbNUkckSxK/js0C8Up94rOVwMYcfUzMAwT2UwIhOoeFFVT3Gax7RThBN+xpYEleMTv/0bF4f5HbCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771763888; c=relaxed/simple;
	bh=hqCFZlB+ez6slMPuD1THeNbVEZ6ahIBSkqNhaoFMQRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8olCHLnzg2eh/PkcxLQvkuObXN8mFvdMVLAE0zNo2570+sT2occa+J5Re7Kdis56/mHDY4Fm+Sd1c8Vj3jh8CCNlmyl66aCnoEA0v4Tz/qmH5ZAuaZS6bw6jEU1KcIy0p/Ah/lE63mTTFrsT6V+bjs06RnBZVMDFQwCVT0Tgf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIZWceKC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIZWceKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC9BC116D0;
	Sun, 22 Feb 2026 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771763888;
	bh=hqCFZlB+ez6slMPuD1THeNbVEZ6ahIBSkqNhaoFMQRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iIZWceKC1rKVzjYjWwdEXopvqFiv46aAnFnTbIIbCIL5F0Cn0ewspqD4zlge2338r
	 MO1LPEbOCOlT99E1w886JvXfpE490BUicDju9YGOUwf00Vw2b8p6ldlad6yGaSdFRP
	 Qjg9PclT2QHCi1J/hClxYopP3uieuJIpEAkfRAz4qj9e62v9cvT0elCgUNbJH7siBf
	 MGxGeVIfw0fJ44YK+4RwECrXvL+z3EpYQFMqr5ObH5T/3b/wjEfX3HsuOOFkAJfuYc
	 lNnq70avHg9JhxQ76Oqq1FP1ah1QFgkeMQWVs4C3aTWQYctAiBTcqX4g4Ie0Ev9n/u
	 UcZPoztluSqrA==
Date: Sun, 22 Feb 2026 12:37:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer: Fix wait_queue not being removed
Message-ID: <20260222123756.59273a33@jic23-huawei>
In-Reply-To: <6f5158e3-84e1-4159-9c61-789c2b198af2@baylibre.com>
References: <20260216-iio-buffer-write-fix-v1-1-bc08b239f37a@analog.com>
	<6f5158e3-84e1-4159-9c61-789c2b198af2@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Feb 2026 15:27:42 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/16/26 7:24 AM, Nuno S=C3=A1 via B4 Relay wrote:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > In the edge case where the IIO device is unregistered while we're
> > buffering, we were directly returning an error without removing the wait
> > queue. Instead, set 'ret' and break out of the loop.
> >=20
> > Fixes: 9eeee3b0bf19 ("iio: Add output buffer support")
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > --- =20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
>=20
This brings the code inline with the near identical
flow in the read path.

It's been a while since I last looked at the locking / tear
down (what that ->info check is all about).  I'll add actually
documenting all the corner cases to the todo list as IIRC
there are some non obvious ordering constraints.  IIRC,
in the buffer paths, it is fairly straight forward
as it's just an optimization to avoid queuing or draining
data when the device is going down - nothing about the buffers
themselves involves interacting directly with the hardware.

Applied to the fixes-togreg branch of iio.git and marked
for stable.

Thanks,

Jonathan




