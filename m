Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698738;
	b=K8EU4XTv7s2HSFpGi4q1ISpEO5orWr8V23a+m4BjontwUN6OUZvMpPtd22Jt/qvbiVbw
	 puuRmnrP0d7vUN9xbj2G0QcKvaRmCl6XsqGTiJIqnov60zue8LTS4yE2D0or4b7njv6At
	 M9z+fwBqpdt5sqtQlXtihdp/NRtkR2rnyvGeCZ/8EUGNL3lQude37eXrdHjyZbfKm7ld4
	 P2V/rT4VZUgfuU6OruhVrmhiEBiyxfxt2IzOYyloDmH4oGprtcTHk+vwdR2zVmgd0cXaM
	 jAk3nCeGOnWXkLIvFolEdoIfZhXgxGxm/epVTsgHqc+SnTfAvNExVOCQZLh55SQoe9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698738;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=wTPypmvN1HQLM2ZLJ7U0N+rZEcdrlQm/72RHrZPNWlQ=;
	b=mJCAhpccchaJvfPHjKsJemJLT/oF9D04HtR/5fNuSTOzhRD8l3Z3bg4Qa+WOW8bqTOas
	 o6FVRWw7iWhcPJUNmAREpSGpniMs9gKcROgowu48DE2BO515YU9XHjYLNfOaLzFaEscsr
	 9JWi0BHiODClpHlDdD15m8Ns+r9DBzyF/eamFT88pg9CJ9bVWfxqyDi+3JpDh92Oz6eVY
	 Fb3sz/SbLzOB6VHXVrjr+Ara/EbdAK70kzEWoYmFrxgJ7ItsnaaXmOAagTtu606CTDZsa
	 K6smt+Vc5Ra+NYypD2hJXjFt7ZraGJYZqV3rcPenz2dGvLmjSdS6j+1uCbGoQXRUNNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g17i+9Ir;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B90606A31C;
	Thu, 26 Nov 2026 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g17i+9Ir
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B841F000C0;
	Thu, 26 Nov 2026 13:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795698737;
	bh=wTPypmvN1HQLM2ZLJ7U0N+rZEcdrlQm/72RHrZPNWlQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=g17i+9IrQ7GyuvWT/l3DaZIAUvOB86wDi/Pxkk2eQb4/A3QxD9PHgfZMrpXuzIGzh
	 8ooRxwlcX/XoHBu6rMIqy9mpbFidcUS1//ya/WfJDQ74rMB+1MQj8Dwz1ysxHxzA8w
	 NweYGOkawD83SJ+YtMP0mEEccKXmA/iUAntJvBFHE0RbXEUVme6M/5oVIw0spxC/SC
	 M3d8CPReFzmpWwlXa3k1lJU0m3edZf1C1YJMXFOkAVmVw1pYqHKSjLskEn2d/HZ3QF
	 BOF9cDGegovxbfqdLePqbpvdY5P8kZ/r7cj2cmBky24QuBwgfQc5EkcpL+r0z9Lm5a
	 FA6rFkd9sNp+A==
Message-ID: <396b6780-52ca-41ca-bcb3-4cc583979e55@kernel.org>
Date: Thu, 26 Nov 2026 14:12:12 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/7] iio: pressure: dps310: include what the driver
 uses
To: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 u.kleine-koenig@baylibre.com
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
 <20261126121331.10438-8-zoone.rupert@gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261126121331.10438-8-zoone.rupert@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26-Nov-26 13:13, Rupesh Majhi wrote:
> Include the headers for what the driver uses directly and drop
> linux/iio/sysfs.h, which it does not use.
> 
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
> ---
Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
