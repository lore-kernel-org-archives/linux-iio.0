Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01031ED80;
	Tue, 19 May 2026 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216164; cv=none; b=NYWzQ+T8UMzPwNpPblS2Q2UMvYsjGEKBRqdrhHwS2NFLkgJlnFiyJRz0MeXTeohe39cg7WkbKGRwx8Zy+GiOy2WxljBePY0VM3+0DPQ7TXEx+o7QUCYJ2pDbl6D5Kt1l+9mgNDaKwKF7KPyygbkcu/0pJv0GmsRIz9cW6TfDAUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216164; c=relaxed/simple;
	bh=QS2VIc6eJtcwkIImUYifaNYbwLMm6qs99e2mwtpE13Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keA+iOBNS0ojSQEOqRRQzDGJLslJXG8Fw54gR28hsu2Jpuh78A+Ua5UfhQoN7injOk9ohWYOO04ScSyMmqlppZ3yFgLBSSva5eSnYEpT4kyU7GwcEU6SwQK18u2OI2jz+cpnQAuEx2NA863nICC7ttC2v0ec29regBqQSMmMZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL5DoEBO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL5DoEBO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11016C2BCB3;
	Tue, 19 May 2026 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779216164;
	bh=QS2VIc6eJtcwkIImUYifaNYbwLMm6qs99e2mwtpE13Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZL5DoEBOXIWGGRbecvEULy/3O126o6z70zB+if36SHLVFQwtfmDHXkJIhe1o4xO6E
	 LN/jsQqXmv34MDHI/Aid7R52C6ppiofiAZYHDRIN3s5jYhHy8e2I/7/omKW3hahR3h
	 mSJHybHfQAnq/0rvdVPjA8GsKEjYW9gWPdv0W6sZ7kTBFvMAwpfqz8iavKi4qw08ol
	 tbN0ybYvKmUJG9IOq58AE+zYOQWUvUID4lnx97JvFKXjZ1GU2YJaNnt1heQk0wGu9Q
	 k3FbiDgVxLu/7m7k4u/NBIDJc/2RcflESfwdXTRHYXecY56tFrQBnwbEysRwbEW+Ti
	 9iYobsbr3Kj/w==
Date: Tue, 19 May 2026 19:42:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] iio: accel: bmc150: Explicitly set .driver_data
Message-ID: <20260519194240.36bd3be0@jic23-huawei>
In-Reply-To: <7ff04e7dd864ed05df875174a29ade662135b683.1779136001.git.u.kleine-koenig@baylibre.com>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
	<7ff04e7dd864ed05df875174a29ade662135b683.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 10:13:04 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> There is one id entry that has an explicit assignment to .driver_data.
> To make the intention clearer, assign BOSCH_UNKNOWN (which is also 0)
> for all previously ids that had .driver_data =3D 0 implicitly before.
>=20
> While touching all entries in this array, convert to named initializers.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Applied.
