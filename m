Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAEE349B15;
	Wed,  1 Jul 2026 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782927606; cv=none; b=CE23TdICb7xtpJsWq11A5wCgzn3ZbDrqGScV2N8sdXkidETnWSk8TpXag2nZElZP/21+jYicpOwIGa36y9UAbiBJKIuLXPYbQXIAOTBkm+mn5/GkiJcVy0Opj52jEvkC4jArvyPTgzo0ecTvX+dDWdZN/Iou2ZjPYxwvH/OUqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782927606; c=relaxed/simple;
	bh=/Xq243s6PJA5huz45aUZJvNgRDiExb+V4TvsQope65g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nE/qV4bj0vtXF/7RNBKIng55LCniqwxoOCcWRcr8YDkl9b99LeBJOekLIxIZ7w5lPbzd4NKNgTEEejcGLqciwVf3hAxKmleuB0EvMUwLWuhhtnwe9RZzTxg8HzdSf8xhdCCekqYWqY2DJ2r/tA3knyFoKn7vjGHDQLDJivtIHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJHg3b+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJHg3b+r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D4F1F000E9;
	Wed,  1 Jul 2026 17:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782927605;
	bh=/Xq243s6PJA5huz45aUZJvNgRDiExb+V4TvsQope65g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oJHg3b+r0lojVxJug4XHIDJGnpieG0uOaEQ+aBljOMfzu+2AClxhwHjarU1yrXt0e
	 ZsDLoeE//VisMKKIAC2MA9ur9slpi+2VymWvunKuwuK0dRajVZzqyZcj9uYEuI08xo
	 9nM5PjoyXyg7Y0mKJTcRAvAbOkaCPt/Q9zdM593vdN1yrsqHc9bjLIM5RKE3vN3bJs
	 h6gY0cAfGeQDpDYOUaiCqepaUXE0jfFm1l7G/mPu5IpK+d08pDXkutkemIot1Mtoc4
	 P9ki8GMndkcb/VUEr3uSWTbUXG1w1ewXT1zmAb9e0W/gGCqbnLD4cnxtv7qoA2Ar1G
	 ZFUzr/fobAW5w==
Date: Wed, 1 Jul 2026 18:40:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: imu: adis16550: Simplify device abstraction
Message-ID: <20260701184003.3a623b85@jic23-huawei>
In-Reply-To: <akUuypU25OtpCFWF@nsa>
References: <cover.1782833415.git.u.kleine-koenig@baylibre.com>
	<f9c18b3c1ee486341704f917e06b91f7a39119ec.1782833415.git.u.kleine-koenig@baylibre.com>
	<akUuypU25OtpCFWF@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Jul 2026 16:14:47 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, Jun 30, 2026 at 05:35:35PM +0200, Uwe Kleine-K=C3=B6nig (The Capa=
ble Hub) wrote:
> > The driver supports a single chip variant only. Simplify the driver by
> > hard-coding the device properties instead of using the id_table's
> > abstraction for a single chip type and a lookup in a table with only one
> > entry.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig=
@baylibre.com>
> > --- =20
>=20
> LGTM
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.
