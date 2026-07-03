Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2022E06D2;
	Fri,  3 Jul 2026 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783103921; cv=none; b=c72rcKd9sOd448BNlkwCNBqvGaj20TJRpdIjAWRZDG3SghD8QjACAd2fCei7ZRJj/36ri5/WEf1/h8fXAH4bmlLF3wOBW4oVULvw22zkk0NzGaM6zabylY7TaLrB8jByJ1wKy2cp/f14Rd9Rlb6X9NZhoaahh3ARtj4H2CRc6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783103921; c=relaxed/simple;
	bh=r65TkPmzJI71rh8jd/eMdKqwanLjr8ZXh2eIspz98Pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvN6rQiP8pOxD0Ay0U68kSKQxIMWGZ2K9qYIgCVTr6eoAof9FFFVSR7ygQNqdHUiLcZVISUfQRlL+WRccA1wuy1fp5M+wjJVJbzRVHFatEiHmTQ9tg2hF1DcITNPAFnODPiTbgS0+2ySGeR7/jjesUiUTBakm3nXm1HUnESAqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfMybtlB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfMybtlB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67811F000E9;
	Fri,  3 Jul 2026 18:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783103918;
	bh=xrMtGTjXsNcxGsRda3bDpUtp9aSrsjBjfG/iScECbM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YfMybtlBkLnm/4pUbI23m1hDT0Od3uwt7WBpUNXhQMPnpzQGIa0fHdzgeQoSidTWg
	 gLTaXjLqjYv9hyuoKJQ8DGDRjOb4KOvvODynWurWlJJz5Q7h/WD9KW+TOW1GeIlZ0/
	 rnSrpuE2942/nXvqgeaSYLMPEztZetwfwWWBf98mju/GyJH83ST2viJ4NNXT2wdymY
	 4vSoFg9XzhS7/CtLh8k7ItBBnLJoB/CucuqrmV1830yCy460EIxKyd06Ebr48kzWT0
	 kqV/Db0t3ddZfOoRm0WuIYwo4xh/susZUvag8WPBuzIvT4kWuC40z2JdN9bLk4oHSW
	 ueGzM2/cGDHcw==
Date: Fri, 3 Jul 2026 19:38:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 m32285159@gmail.com, nuno.sa@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mailmap: add email mapping
Message-ID: <20260703193832.1b8d4d52@jic23-huawei>
In-Reply-To: <20260702191744.118898-2-tduszyns@gmail.com>
References: <20260702191744.118898-1-tduszyns@gmail.com>
	<20260702191744.118898-2-tduszyns@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Jul 2026 21:17:41 +0200
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Old email is no longer valid hence add mapping to avoid bounces.
Applied with subject tweaked to mention it was your mapping that was
being added.

Thanks,

Jonathan

> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Acked-by: Maxwell Doose <m32285159@gmail.com>
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index a009f73d7ea5..10a2e4f8fba7 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -861,6 +861,7 @@ Tobias Klauser <tklauser@distanz.ch> <klto@zhaw.ch>
>  Tobias Klauser <tklauser@distanz.ch> <tklauser@nuerscht.ch>
>  Tobias Klauser <tklauser@distanz.ch> <tklauser@xenon.tklauser.home>
>  Todor Tomov <todor.too@gmail.com> <todor.tomov@linaro.org>
> +Tomasz Duszynski <tduszyns@gmail.com> <tomasz.duszynski@octakon.com>
>  Tomasz Jeznach <tomasz.jeznach@linux.dev> <tjeznach@rivosinc.com>
>  Tony Luck <tony.luck@intel.com>
>  Trilok Soni <quic_tsoni@quicinc.com> <tsoni@codeaurora.org>
> --
> 2.55.0
> 

