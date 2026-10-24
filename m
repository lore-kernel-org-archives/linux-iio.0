Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809014;
	b=DKPRTUV27LeoScQkKpXeoGQ3uw5vP2IX6WNtrTh1e5j4m7tcJg1yswE/IXkFrThfSDc3
	 Q67Kady39BlSyg4nQXU2GKuNYS8ZNImrrSrYWUegcLju6n69OWmwP43PZHj//BArzgXbX
	 NIxEb6ET9V7jfpW0UHn03xSR3RTD70k95GFAH+BVfW9aQHTeBA7sYQ1tdmBNQLDxb/L1p
	 DpQXhjavHoNf/Vg8C4er0avbRkGMIcRcdbAq2HGx5ATM6KOZgxJaQULp6qjJQNXdGubbA
	 VEhtCnNCj1rriRgr5283vReSNOZ4Vmt9WWh76TN3WMTC2H2eHlGeiJpoSqseisY8nIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809014;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vJPXbU8wyUyp/ZzSr5Y4VZQZiZQeDT+oLnuWaloc9Z4=;
	b=o1VA6WoswKBTpS9agZWAGg1H8gopYFH3/UPmiHmRZRXET5W5VWpwiyk6JMOO7NlDck9i
	 6mkF73tnaPMVYQ2i1Zk6GhZz+PYgFrGQbixZibeIkX3COQuoc/GhIkgsamM8R/2dmYKAQ
	 NA/COeTwPSFJZ7MgfwRb1BmKbFvwwJwEEufB6v4s0AlW9a8qVNnNfmDrYy0SwqZmH+Caq
	 xevuy2zAzpwliP30Q2iuaGM+4u8syX0QcICoKiiFnW5VGEp3ly5Yua02hOtdMvt2Bxwtp
	 ju8pTJMc6iB54ySef7AQxVaTyZjJF95v4YSSMS1bMjGFcWQMJhVpf/BUvQjoI6IQ0lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtBOyPno;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84F606A31B;
	Sat, 24 Oct 2026 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DtBOyPno
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15381F01825;
	Sat, 24 Oct 2026 02:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792809013;
	bh=vJPXbU8wyUyp/ZzSr5Y4VZQZiZQeDT+oLnuWaloc9Z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DtBOyPnogYcPZsp0TsILJVKNcdnoEZoU49jAPbXRALMX8Mx3YwbvnunpFCw68wUao
	 RvCpukFH79vWINBGrb7G7x1bbKq+sK9pP5obVWENtejV5Kfv864MrfeWBkf1aGlUME
	 f+3roMtLROce6gRmXIWDbKuRCNgyLW9efwjo2yf+8L07u/74DaCBebTVFBwyVVFYw0
	 qOD4RVZV7qPq92Vfad2axbhxFwJB7GyXmgQH3ruwTuFrTed25aqmxFjV6fSLNFvUMW
	 WfJVn42UmKcbO9SofDok544+ZGJv8swjSIYE47XnnVsXO+O4+u63BRxlLoSlGPD/gx
	 HQ1W9njZ/cX4A==
Date: Sat, 24 Oct 2026 03:30:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Marco Elver <elver@google.com>,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations
 on mutex helpers
Message-ID: <20261024033006.35498dec@jic23-hlaptop>
In-Reply-To: <20261023064709.77180-1-zoone.rupert@gmail.com>
References: <20261021052435.112686-1-zoone.rupert@gmail.com>
	<3f41338e-fc47-4306-b68b-5a81c26027fe@acm.org>
	<20261021181944.14272-1-zoone.rupert@gmail.com>
	<20261021202433.0efc7979@jic23-hlaptop>
	<20261023064709.77180-1-zoone.rupert@gmail.com>
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

On Fri, 23 Oct 2026 09:47:09 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> On Wed, Oct 21, 2026 at 08:24:33PM +0100, Jonathan Cameron wrote:
> > I haven't tried yet, but I think you said not much broke?  
> 
> I hadn't tried either, so I did: CONTEXT_ANALYSIS := y in every
> drivers/iio Makefile, on testing, x86_64 allmodconfig, clang 23.
> 255 warnings.
> 
> 240 come from iio_device_claim_direct() and
> iio_device_try_claim_buffer_mode() lacking __cond_acquires(). The rest
> are 4 in industrialio-core.c and 11 in five drivers, none of them real
> bugs. With those annotated it builds clean.
> 
> v3 would be this fix without Fixes tag, core annotations, one patch per
> driver, then enabling it for drivers/iio. Does that work for you?

Yes, though no need to necessarily do it in one go if you
prefer smaller steps.  I don't mind merging fixes like this
without the global enable.  Maybe can do it on a directory first?

J

