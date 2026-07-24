Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A95F4A0C;
	Fri, 24 Jul 2026 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784852075; cv=none; b=Wxwyw/bRT+0CRCChPX51bKuNojeEwMRWEJiFn4LA/xEFPq7Mxte3IW6CeSDg5qMOWtg4HkiCozkE6HlS1Xxk/6v2+y/fkowISelfr5bU4zMLKNvPs+lV71aHVX+l/2I//CeeGy2F0h8rgUOfKJIJLWYbPSsE98Pk6sWY83+gJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784852075; c=relaxed/simple;
	bh=ewKgC1mi7sPLVZc3T9LRQ3O5b+LQEMQZxIUvnKn2qgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yo2ajbNWrcU3dnGyaK3vQUMcqYxyaX9zVhO1hCgp+n5kDXBrt6yunVEHmW+yFGT391FTYEQnHiyCe1i5AX0qHhcFI4Q8mwlAv/Pd8EWL0wPUHR83oX+f9TIvWlDw4bue7yYi3Ryt+ez1FXUNVEa0fEqE69PAvCuo/7qaWtR8p7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/MBevB4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/MBevB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B3E1F000E9;
	Fri, 24 Jul 2026 00:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784852074;
	bh=RhMTF1TfbQCgk6LPiSH3r69ZRNtCudLJ7aMR+uabaHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z/MBevB4fSTqPcSosT1yMKO7hkjLJYI0M5/PvFyAhK6JAYtSVPeWnkceegUBMfM8v
	 66ucVOrmkHUgpEZkDH91cGlKVtPWbuMwj1w83LTItufK8Cu4SYMRmPbc7Rp/Y9qLiM
	 WiYqJDexurMmQjoxazqorMlpKAd29KstbMtf7pymCF9euXK5sbkwj1/bgrwmpnVakd
	 Atpcr+yFe8h+zudaxcPyUjmwF/FYPVUyUFQamQpqQa43EZ/ZVQfilY234VW4iZUf/5
	 356FTQIo95SPdvoo8rQplfdgL0B2gdfAW7NjJKxsymFyWbB2y0vltA1SIwJAV08GYq
	 9MfPfRiILAxXg==
Date: Fri, 24 Jul 2026 01:14:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pan Chuang <panchuang@vivo.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux@analog.com (open list:ANALOG DEVICES
 INC IIO DRIVERS), linux-iio@vger.kernel.org (open list:STAGING - INDUSTRIAL
 IO), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 4/7] staging: iio: adt7316: Remove redundant dev_err()
Message-ID: <20260724011429.7b2f1546@jic23-huawei>
In-Reply-To: <20260720134324.239391-5-panchuang@vivo.com>
References: <20260720134324.239391-1-panchuang@vivo.com>
	<20260720134324.239391-5-panchuang@vivo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 21:43:10 +0800
Pan Chuang <panchuang@vivo.com> wrote:

> Since commit
> 55b48e23f5c4 ("genirq/devres: Add error handling in devm_request_*_irq()"),
> devm_request_threaded_irq() automatically logs detailed error messages
> on failure. Remove the now-redundant driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
Applied to the testing branch of iio.git

Thanks,

Jonathan

> ---
>  drivers/staging/iio/addac/adt7316.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 59fb3bd26bc1..20f6052cc7fb 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -1814,11 +1814,8 @@ static int adt7316_setup_irq(struct iio_dev *indio_dev)
>  					NULL, adt7316_event_handler,
>  					irq_type | IRQF_ONESHOT,
>  					indio_dev->name, indio_dev);
> -	if (ret) {
> -		dev_err(&indio_dev->dev, "failed to request irq %d\n",
> -			chip->bus.irq);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	if (irq_type & IRQF_TRIGGER_HIGH)
>  		chip->config1 |= ADT7316_INT_POLARITY;

