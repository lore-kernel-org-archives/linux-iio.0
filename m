Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884587;
	b=KcobqpXwgBVFFkJU+8PQQzH2E4PLmV74MZsk+8CMG+paX9qffY63CthlEivzPt5oUPta
	 IO6Hg9pxNVRqb7GbAknCvkMOVi97sSeAcY0cWlQwQi6XvB+R4twimM/W2+1cnj+NJLURM
	 3KkfIqtq1HLIb3B5fPvR7KW5VYDubqzsz+H77LIgutYKvKyfkfUTA8vDYfLTI75aIxpvQ
	 QOIa9CBlqE0Jtp10mo/lucsFpeinEbW7Gw9pKrcSqQSbhVnmTTsRKbIKujCQVmCGOvYcu
	 IjzO+Bn+JPwdzRCIAF0PNsK8dc6F5Ad77gI3XZ3yzMAvLEuZp68j3QdWFitOrjAtLgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884587;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=v86ECrw4hTZS+oi6SL4n7LCSWP3uQBdnZrQC4d8hSfE=;
	b=MVKG/3v9MxVKiz7oa48EjinJbnqj2dDWmbvS2z87Gf2POmZlLKEDcRhIhAZyrourSBZi
	 akGa2NuOl2AampstTnjsWNkqnI+27qy9TGvRkDuQcW2Xa1YM6qzSU4dLHRa4cMNv6UOpj
	 zGMcC5d0uOQOyc4lTmfsWF43igY4tSxre7Ee4h6xudcAGF8Lzm3goyWSIeVdbwe4sLbIm
	 Uj9IR5w+VhPnlwazRm7iw2qQeeKFvKO5IRsCYoSQ1ywe1o3St9VYIlJHgnyeHpLo6TbQT
	 HMfqpPTt5fir/qoO8vVGHDkAEz3IUlElJYgDmaVJblLZvbwXlUpgBL7WbhLxwYTnlXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EAF/911a";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F5606A31C;
	Tue, 17 Nov 2026 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EAF/911a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA6D1F000C4;
	Tue, 17 Nov 2026 03:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794884587;
	bh=v86ECrw4hTZS+oi6SL4n7LCSWP3uQBdnZrQC4d8hSfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EAF/911aT3K/HgLF7Z/UTT8qhiixqrvj+5cC5G9mJXdj9Bm4icfnFSRvuognvA+4d
	 TJC6Ir5HtYyI1539/i7VyL30DbqZ8gLppaMkDoYfqpMINGAwQMbwpzGXKRBgXQ/7We
	 hpjy2c1Sj0KRpWS9HwAQbT3fp8dDy1KTMloD2IjIthAFnnGBNUwtjTexfF091/gwSL
	 NB8/UB5kZUf0j5qea6V6f+owdNjBu/Voqmlb8s0Ht9ZKtKOvQ0JvRzOO33JEtSUT1a
	 n/7EZFowKNUWhsz8t0owOk0tI6hK1K5YJ7qc3OOSrQylSoq4ws4ZejpfONouuwKlzD
	 rN6VzJv88KSAQ==
Date: Tue, 17 Nov 2026 03:02:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: linux-iio@vger.kernel.org, Eugen Hristev <ehristev@kernel.org>, Nicolas
 Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: pl022: handle clk_prepare_enable() failure on
 runtime resume
Message-ID: <20261117030258.364ba429@jic23-hlaptop>
In-Reply-To: <20261117020711.20158-1-luoyifan@cmss.chinamobile.com>
References: <20261117020711.20158-1-luoyifan@cmss.chinamobile.com>
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

On Tue, 17 Nov 2026 10:07:11 +0800
Luo Yifan <luoyifan@cmss.chinamobile.com> wrote:

> pl022_runtime_resume() ignores the return value of clk_prepare_enable()
> and always returns 0.  A failed runtime resume is therefore reported as
> success and the controller is used with its clock off.
> 
> Return the error from clk_prepare_enable().
> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>

You should probably resend including linux-spi and appropriate maintainers
and dropping IIO folk.

> ---
>  drivers/spi/spi-pl022.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index f52130465a..64bf9c4b0a 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -2067,9 +2067,8 @@ static int pl022_runtime_resume(struct device *dev)
>  	struct pl022 *pl022 = dev_get_drvdata(dev);
>  
>  	pinctrl_pm_select_default_state(dev);
> -	clk_prepare_enable(pl022->clk);
>  
> -	return 0;
> +	return clk_prepare_enable(pl022->clk);
>  }
>  
>  static const struct dev_pm_ops pl022_dev_pm_ops = {

