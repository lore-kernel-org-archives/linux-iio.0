Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704680;
	b=poTYMdKn1foXpAMDDJVs96j/kVT/8vY6KK/2WXd2XrFEGjhfBbhLmAuRBVZ40V+FPmgm
	 zzGLWMfLyII9nun0fDMClYDEMetRzaFaj82E6SS6Oue6oqRyPzh6HI7mBVR4w8gEGSR4M
	 wW5Nj0k6r3Fdtzr5dCrEZKRcaMEvkvIa1TfPJE1eFqU7FGuQ8DLeC8AZe5CkbycCh8TY8
	 ZENVSU8aINOxPaRwCteSJFjdruWE2FQWrh/HdePX+fIUmdXQ+Bd6vqGavz3bRCdnXBuz9
	 dPMG2B59WlYX8RvO88D8eIBZMWgn0aJIoYTiHcTHQKWxh268AVrB5hsnVxsWzdkRccQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704680;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HnyOtoGbIdsMHcvfxedNuN3t/UhzRek1o6FJLK+Mj10=;
	b=JmJ02va7uXe+bWznXbB26JMtS1u5BrN+dRt5pFGj97XQzCsJoFI5vVXjiwAl6mHS4rvM
	 WHIMzHVISQfbo4rtvCurDF+ZxAYzzxv0A9YtV7qjazpXmBdoOF6iegZEFcDr8OHt3Brhk
	 N41kseCsK3WoKiaJy4AY44S0y38YX/+Cr/PDo5chKEJZuqRb69jE7iK6kcwqPMLw1buSs
	 Z5NT03HoEXlUhdKW9eYcO2rRSdfI2EXaLZbCqrpjx64G1Tcy5BxLpV/TR7kUah+MqGB4n
	 gZOElcLoQDJL4kbYc2kunjGCsnL/vIdm8U1qfV5Q/nj84FppU4cSbaGq2+CGJubjskA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fdX6L/+N";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F77F606A323;
	Sun, 15 Nov 2026 01:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdX6L/+N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612CA1F000C4;
	Sun, 15 Nov 2026 01:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794704679;
	bh=HnyOtoGbIdsMHcvfxedNuN3t/UhzRek1o6FJLK+Mj10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fdX6L/+NS45OPHNpewhftWjh5Ts0+oER/MuBnaDZvYoy5+6Dz37swt2NkIjQC/Dwg
	 Y8sS4P4BWLX548ohO3Dt1+6khFbWO5QI29FrKj4cuyL/eFDvLZ+M45AVzNV9pLq6e8
	 w2wsBGvnVfA5NHiuEXIygvkJklRRRpO0CXGyKp+oX8pSOemGiQYny65x+67sOLZoJ9
	 qnihgDfAqhXulvDEMtVabgk3RY9VY5DjwBspjF9KERqet69zQczfwuwtDmKf9nma3T
	 SDyKDOiExIFASAZLL7g6nuiBDEEVurM5KwtCfGRVhNGXELF+1HCF7dC+l0bUR2H0j9
	 Ftk632XuzIkLQ==
Date: Sun, 15 Nov 2026 01:04:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Niloy Meharchandani <niloymeharchandani@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9834: use devm_mutex_init()
Message-ID: <20261115010431.0b1e7971@jic23-hlaptop>
In-Reply-To: <20261114072719.21558-1-kapoorarnav43@gmail.com>
References: <20261114062021.142296-1-niloymeharchandani@gmail.com>
	<20261114072719.21558-1-kapoorarnav43@gmail.com>
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Nov 2026 12:57:19 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> On Fri, Nov 13, 2026 at 10:20:21PM -0800, Niloy Meharchandani wrote:
> > Initialize st->lock via devm_mutex_init() instead of mutex_init() in
> > ad9834_probe() and propagate any initialization error. Since ad9834
> > already manages its remaining resources with devm_* helpers and defines
> > no remove() callback, using devm_mutex_init() ensures proper mutex
> > cleanup on probe failure or device removal when CONFIG_DEBUG_MUTEXES is
> > enabled.  
> 
> Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> 

Applied to the testing branch of iio.git.

Thanks,

Jonathan
