Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792809183;
	b=v9WExjP68I5jytuOIDeLOD1UfpeMXR2D6sRQ1j7DkMTipweP2wWrTRODq4VDhajGpmPa
	 FB4ad+UdQQsyZXhaUO7qJG4Q+s+zGa30HTTFdBBQHCpZq1uA0RQox2mEKJ1WolLkWKlhU
	 SE9jCGWeBRKX29UbQ7YrswZQ1p9LqiN2IU73qL85k4mBgbf53T4ILN5o93kvHoG2aA6mh
	 KSHXobmq8xbtM7wk8+f9qon28C6mxCu2bxrjm8Y7AEhnnwijrmdlBcrbbLJNNMPz/WkhI
	 Epv80gAQdPDpYWgUw89KEVqx3MdOIDQVPrhvqQo9QANkalKrVhk5kDm6kfPMg9KjCew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792809183;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fNC7aJRSmo+TLMfEPiM4H6baR0OIPTSBFJN8CjNJnt4=;
	b=BJ1I9h67FHozWvWs+yLG7NtO5eg9odb6esIRKmI2KQcx+LJlkby9+V9fCdVsKIBVvwhO
	 w52haQY9EESrbIbqAdxHQg53I3t7aWA7acO2bWqTsEvfeZ6cFZitJ/Rq83gU3yjO4cccA
	 oV/E9ZO6eYMCV9wleE5sl+tcnitlhIwrnqLlD2rz+q1la+Z3CdYQPWUbxoob1ivvegCRt
	 XueNJazKuyTi+LP+wUL7XIUmi1uWZt1Yo5IAi5Qfgd2hPoTn/7NF3tFKacMAgI4qYQblB
	 /kz1PtD+gYiD3oYvI0LrXtKhzJsXnuW1zskXGm0mIpgK4V818ip37yb+QxQpVf4Ie1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIThB0Xg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82330606A31A;
	Sat, 24 Oct 2026 02:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DIThB0Xg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF111F01828;
	Sat, 24 Oct 2026 02:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792809183;
	bh=fNC7aJRSmo+TLMfEPiM4H6baR0OIPTSBFJN8CjNJnt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DIThB0XgXNlQnHYhsM+W9BUFpApej6+QBy4M6ZI+C2ZDvGFu+6iip0NjT0STMnIxt
	 MTa7pluQm7x9CMXJxl0p7EcQh1J4YpzQdOv4h9DzA57/O6iZc5OYkumiyvJ3GI5dgu
	 KGx43YgS3CxoFWkn+lsfWpmx4zzRNWS6mgTCgiIh/LFK+sqyIS4c7U65moXCwLC0H4
	 SEWWn0O0Z+NXdt5364Bmfy07UJxCfUte6XQC2ndOoI2yAoi13CmwHIkoCkXFnC8pbT
	 w+EXhaK62arrmdVy5DOrZSm3Y0kagzAudDZ9y/vTC6bz2MpwfemOCgLTdzGBdvJ2Yu
	 F8GM4zgS+yGlQ==
Date: Sat, 24 Oct 2026 03:32:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: amiratefabdallah1122@gmail.com, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: frequency: ad9834: use guard(mutex)
Message-ID: <20261024033257.53192e12@jic23-hlaptop>
In-Reply-To: <atZpjGgTBcdVMtQJ@ashevche-desk.local>
References: <179241934543.347.7026859519510388428.20261019-ad9834-guard-mutex-v3@gmail.com>
	<atZpjGgTBcdVMtQJ@ashevche-desk.local>
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

On Mon, 19 Oct 2026 22:03:40 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 19, 2026 at 05:15:45PM +0300, Amir Atef via B4 Relay wrote:
> 
> > Use guard(mutex) to manage the state lock in ad9834_write() and
> > ad9834_store_wavetype(). This simplifies error handling by allowing
> > early returns instead of setting the return code and breaking out of the
> > switch statement to manually unlock the mutex.  
> 
> If you want to continue improving the code, you can research the use of
> sysfs_match_string() and rather use it as an outer check.
> 
> static const char * const wavetypes[] = { "sine", "triangle", "square" };
> 
> 	int wavetype;
> 	...
> 	wavetype = sysfs_match_string(wavetypes);
> 	if (wavetype < 0)
> 		return wavetype;
> 
> but it might be actually worse than existing. Again, it needs a research to be
> conducted.
> 
> As for this change, it's good enough.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied
