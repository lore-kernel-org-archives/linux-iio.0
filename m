Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E936B076;
	Tue, 23 Jun 2026 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243408; cv=none; b=m2/dECdRpQ9YhB0SpBnq3aQf3BbBria5wsGJD3Te4PhvCdtzI8Hk8ty4XhzUJHSjOYFSUwQruoCQObHfqN7fFR4CnccyhLGLxOrHW1/utG/sGgtBZx3FGtSw/P97Rr+yxp6weuc7o7qf6WzqF8JnxpLJZXwSTGYa+mqAudJZhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243408; c=relaxed/simple;
	bh=o99lNoeq67T+PN0IQjMHqbZv06TDU79DuA0zM3SPKyY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJ8AshVAVZwLueWQ0UxEeO8ivTLJbq30VJzsMusS5Mq+o4SdYyhnR5HJozOZdupSkCtkiQvdtL9LKadTyvCFSjfTPtjVWpK8tumSvArnJiD6c6zn4VIr8iqtxTOAIBcEBMC9eVyiSE9zbGVk09j611xNLHVUUKSDqjVAYn/y5N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqGEAgKA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqGEAgKA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB4B1F000E9;
	Tue, 23 Jun 2026 19:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782243406;
	bh=EhCW8tZAni4aO52kW8j7XN2AU8nb2c1mBa53dgtSd6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gqGEAgKABiBSED4o4jgHzvwHroAOWMUhpKpyjI6JHa/P/bVbOmBp+0JEuW06KSzoM
	 6K+azRZA/WgQ4NLsXo4c+5H5MBFcTNbs1eipDenxXkvEaNr4+G9amqyTJ8R5+348wq
	 Q8J89BnR9WfOnga7ZM33k9JcNvFUF+gS24nViOY3LWrS3nNeg9067mrd0MgffRp2Z9
	 rmU1hoEm7D+ZYD1zzKyVV8lbhiXX4wkJtx8+q7xnVo49tMmnMCYCejhsyJOJ/UDmgs
	 Ysve7rz2oJ09A85l02l2ZKseA8gtj6vjUnuVoTWVJr8xJOMsg0eUtWew+PXcVvhnMG
	 Bxd76xEwIEwOA==
Date: Tue, 23 Jun 2026 20:36:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Prashant Rahul <prashantrahul23@gmail.com>
Cc: linux-iio@vger.kernel.org, Shuah Khan <shuahkhan@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Petr Mladek
 <pmladek@suse.com>, Oleg Nesterov <oleg@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: adc: ti-adc161s626: log buffer setup
 failure in probe
Message-ID: <20260623203636.69a7429a@jic23-huawei>
In-Reply-To: <20260620174708.111470-5-prashantrahul23@gmail.com>
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
	<20260620174708.111470-5-prashantrahul23@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 23:10:56 +0530
Prashant Rahul <prashantrahul23@gmail.com> wrote:

> Errors are logged when enabling the regulator or adding the cleanup
> action fails, but not when buffer setup fails. Log the error returned by
> the buffer setup path as well.
Why this particular one but not the devm_iio_device_register() below it?
Both pretty much only fail on driver bugs.  Or out of memory for
which dev_err_probe() doesn't print anything anyway (on basis that
is normally pretty noisy).


> 
> Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
> ---
>  drivers/iio/adc/ti-adc161s626.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
> index be1cc2e77862..f83073280c9c 100644
> --- a/drivers/iio/adc/ti-adc161s626.c
> +++ b/drivers/iio/adc/ti-adc161s626.c
> @@ -217,7 +217,7 @@ static int ti_adc_probe(struct spi_device *spi)
>  	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
>  					      ti_adc_trigger_handler, NULL);
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(&spi->dev, ret, "iio triggered buffer setup failed\n");
>  
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }

