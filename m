Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525103;
	b=B8V1Rgg60mzr0b1uCbFwYsGeiuygsusar7PaliTNWe0Tryam85ydpelK1eNZdyN0tXdm
	 jdnRS/dG3aB8yNz/kt+6SnY+VFJ4a5spp2WN9fyrhWraDZlmAHQ3fm1dNBKSiiQwfHiHd
	 GXNEArIsZ83ue8WxvMEHKZ+Z9lF+laYjOiJGhx/iCwVmJXaMYtcTy7vhIWKcpXXglo2di
	 G986/mZyBIJ9yRttTmtSNDT9D0Cvo0BWx0sopcO7WO66x03QMBFpyb3ezhbGGJ42WdsrM
	 J+yCdrMSfQ5AiTE/YZOjWw2EZGR2GJoswrK8SHYjYFobh8Cxv5KuvW0N5ZMUIYkYx0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525103;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+zdR7Z1qxc7S+DYK/X9qo38BjQifDmARK182HdLd/og=;
	b=REdvWeAnPyfI18JMH+RnnC65pJ7gTDWXLP1J1e4PwZzJ/adWyfxiQKO3hO3vrGGIJzcD
	 5WuVPpDxgQXbCsT7U+dfLUslBE+GdZVMX+fRYOpWUQpczHy6HCiaiygcDpqTZBoDgoHYX
	 QNs56Q5F8uKmQKhpyuSnY6Lr2sXureWc3KY/xmeGTm3Jg5ZeBAJRjY9aOhlwftGnJyJeG
	 BbpOkFL+QCnT8CT0asyt82ADn8oqtYO60fN7ONoMUCCZG1/NZdNLxZZLwLL7A3hlzfTwK
	 31i9DgqwgNdyPD7nF0aZbwzRtQ8zcNe741+hQoLkeQr75k1tgr6HSx5qL0e+I/p2hlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9gtbmWZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAA1606A339
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I9gtbmWZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0381F000C6;
	Tue, 24 Nov 2026 12:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795525103;
	bh=+zdR7Z1qxc7S+DYK/X9qo38BjQifDmARK182HdLd/og=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=I9gtbmWZfq7KtZvsaXfW1DODf1qabTQbfL3qcOir6eqQdiV26Ke5WLtUwfsJbM+eH
	 BOmbJM6WBEdeUnsT/C9Bh3oqHknEu0Ff3QxdV48ctv4oL6P1MDVVsT68oPqYvE+OYj
	 kuakyunHhhneOn3xR2oCqSlOC5Mf32XFs2HRTyZBXHPJ4W33M4qe6DJMuQ6L0e1w6c
	 Tev2tj5dvj8OQX9cYAW1jsJSkBRTEkjQSknai6EwIDzuqL2O4+0Gc7I4xDORkwp11A
	 froTuDytyJAD/JWX2xJnC8Irbxd+/fS4EXUuwwS/6UL+DGhB+nKbdYIVm9LQnFERRa
	 O3tX4kWDVxonw==
Message-ID: <8ec5b8de-aaaf-4d99-99e9-d565b77fccf0@kernel.org>
Date: Tue, 24 Nov 2026 13:58:19 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/1] iio: core: Use an API instead of relying on a
 specific error code
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
References: <20261124103842.600399-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <20261124103842.600399-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24-Nov-26 11:38, Andy Shevchenko wrote:
> Use device_property_present() instead of relying on a specific error code
> when parsing mount matrix to reliably detect absence of a property.
> 
> No functional changes intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
