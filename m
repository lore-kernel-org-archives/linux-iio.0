Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61C21A6807
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783039025; cv=none; b=u7o4OXBHFsJW9UdMW+PveFCPW7V6X7xfo/mTTfuRMMehcnCRpULqV4XoJig/Ejodha2lHWbbXl0cUp40I3fuSCFkGdvGHuyrmiSNl9R5eNhIkXkFOH0mEwZk5fJCVi782iJcypoLKsb0nAVAFOuCGfU3WnKuj9dIgB4UUNqOvKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783039025; c=relaxed/simple;
	bh=jvnmu+U4vbOyw0CHbL3xbwAwX0XguuDbmq9TuHjgbm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLky8LX7kZTCCoRZoJaetokhdgcQ5K/gdQKBGns2wnfbqP+0VaTQzq5ZDjn1I9beCo8609TfUtI6dZeujc/Sp+eTxlRQOzzQuMeVaMqFBsqy6mYoKKYYqNqFz0cAI08U9ODGpwwytdBB/cYoE84RZ0IuQ9wirnPOaXV2JwXKGio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmWyOtEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmWyOtEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F375A1F000E9;
	Fri,  3 Jul 2026 00:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783039024;
	bh=Mh4dHMF0l997T0BpuOeXCWxruqxwfLCgyav7ACHSTHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DmWyOtExiYcjYHW2Q4dD4aisExm33SiO+qeyhkwcSLBt1+1xxPX3uPZJlRdljd2B2
	 b3Mu+zqq5TUL8wahiAmzTXVqrcthlu9fwkZQj34dL5s1MWHMTG0QEN6BAUw64/PNn5
	 aUr0AaEV6RjdVTxsdT396lVq32Dn3PqdR5JX87alOFK+JQBs/aVgeo6tvsvBcghqxa
	 wrII3xhnkZmcNWjSne0HLGW6osa1+dhCxahUdXd+e0UvVmK0th5t8wd4szM8IoV+VC
	 XnsFXUT+GrjxItcXne22RO/OW1pN791bP1rtZ44d1cuv+rq3rnwpkWdRSxh2tjGJqu
	 KTznXBkqIl42w==
Date: Fri, 3 Jul 2026 01:36:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Prashant Rahul <prashantrahul23@gmail.com>
Cc: linux-iio@vger.kernel.org, Shuah Khan <shuahkhan@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Petr Mladek
 <pmladek@suse.com>, Oleg Nesterov <oleg@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
 linux-kernel@vger.kernel.or
Subject: Re: [PATCH 3/5] iio: adc: ti-adc108s102: log buffer setup failure
 in probe
Message-ID: <20260703013659.12315007@jic23-huawei>
In-Reply-To: <20260618231543.413771-4-prashantrahul23@gmail.com>
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
	<20260618231543.413771-1-prashantrahul23@gmail.com>
	<20260618231543.413771-4-prashantrahul23@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 04:44:36 +0530
Prashant Rahul <prashantrahul23@gmail.com> wrote:

> Errors are logged when enabling the regulator or adding the cleanup
> action fails, but not when buffer setup fails. Log the error returned by
> the buffer setup path as well.
> 
> Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
I'm not going to add more prints to these. So won't pick up rest of
the series.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ti-adc108s102.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
> index 7d615e2bbf39..440afe584f5d 100644
> --- a/drivers/iio/adc/ti-adc108s102.c
> +++ b/drivers/iio/adc/ti-adc108s102.c
> @@ -256,7 +256,7 @@ static int adc108s102_probe(struct spi_device *spi)
>  					      &adc108s102_trigger_handler,
>  					      NULL);
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(&spi->dev, ret, "iio triggered buffer setup failed\n");
>  
>  	ret = devm_iio_device_register(&spi->dev, indio_dev);
>  	if (ret)

