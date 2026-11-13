Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536720;
	b=1DTianvNdnxZ0rUNPOVDVaA4M/SJt+AiapGCtE10PIOHHQMSYR0m6Tz2rARzGUtfIAWl
	 mcnfGnX+c9Se3Wd7BaHzUfkmHg+Uej8wOjzlK45W9TFdvmeTeXVQrbMr2KoCFn0mcBL53
	 c3+ku4pLEPapGJn94D7Ro0ewZ9yd8aJ1javNk2nsbQD9rschYOrMp58Ko4fxFkXPWJnQm
	 K4hjIuCkHNrCN8270zeO3bqFHWAvH1zKL4e4Coi/AU6iOma01KG2uGHksM7Wq40k1S2+k
	 n/MJOdojd8Hg01KpsChZhiTIlQwN1SE8HI8ukeFSPhF71YQhvuFvIbWXQWH4WlCuZ6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536720;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wiOF/Ak0GRdHGnXPU6Uq/9aKuDoRTBTar9m92mMIOY4=;
	b=fLrv0Do8qLQXrYf4C9Ji6b7jFpv33okNcbYk7DtY9mKs8zHGTaqdjH62e2Aj3o7Ywez9
	 0nf4GhL0BXhBUhy9bdblMLxD0Xb3CooRmfJKk/2Ak22kSwU/8SnTyDV0s9f/Ie4bIaK0J
	 ha5kKBBHmLOITTUZLq1dsQo4rYbwvzIEmnAQ8iaq/tPAGp6+s/aE7wiGO2yoa6caW/3Ag
	 Ih7r1wfA/tNrOgCjTECc5+kf/WowLenEf8GLZW4sh3m2zuhQ2c9ZC2CKDj4JDmNe2BPSy
	 MMma0myw9qwfvL9mnBkVAod086iqxJHXgZh4PXFgMtAVeArd5ZgIQcSTdtnliTGS79Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PidPBlh4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB215606A323;
	Fri, 13 Nov 2026 02:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PidPBlh4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE831F000C9;
	Fri, 13 Nov 2026 02:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794536719;
	bh=wiOF/Ak0GRdHGnXPU6Uq/9aKuDoRTBTar9m92mMIOY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PidPBlh4wYWEwIIeewJCpjEXwYLyZ8jWO0XoKU0HsuLrQaNE5gD4D9seHRtWPFsac
	 AxG0Tff3KUlHc8m+EvKgOnK7EnCgBMmJXDSxpArrlVSlF30nyC+A4NTFIY3vVMD6m9
	 nfZ1GI0DImK+AliGxQHeM+dsDUvi/DzRLXRfOcWTrzNCKOkV3sq3GKKW2kIkI6tZoc
	 pSmlMH7RSISc9LNlK8FmiQf7I+XHVQLQ71TWuWT9VJXQDu7tckDXBGxRZUw7cvrPL2
	 tBqwQk+5JU/mNZuyzGcYtauJdywAw961+tRp4QfF4IRxXgU3jQoYCSdGu2DzpyyMED
	 hwU9O4qRv5FEA==
Date: Fri, 13 Nov 2026 02:25:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mc3230: Leave chip in standby on mount
 matrix probe failure
Message-ID: <20261113022512.0e497ed1@jic23-hlaptop>
In-Reply-To: <20261112201208.476450-1-kapoorarnav43@gmail.com>
References: <20261110070206.1452-1-laixiangwu@cmss.chinamobile.com>
	<20261112201208.476450-1-kapoorarnav43@gmail.com>
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

On Fri, 13 Nov 2026 01:42:08 +0530
Arnav Kapoor <kapoorarnav43@gmail.com> wrote:

> On Tue, Nov 10, 2026 at 03:02:06PM +0800, Xiangwu Lai wrote:
> > The mount matrix is read from firmware only and does not need the
> > chip at all, so move it before the WAKE transition.  That way the
> > chip is only woken up once the remaining steps cannot fail anymore.  
> 
> Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>

Change makes sense but I'm not going to rush it in as it only
matters if mount matrix reading fails which means bad data rather
than no data.

So applied to the testing branch of iio.git.
That will go upstream in the next merge window.

Thanks,

Jonathan
