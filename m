Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1F1406267;
	Fri, 22 May 2026 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779458643; cv=none; b=pOHfoWY27VXiWzTS2X2KQd1lgr2tjdH5LX+ptvnjVNXQla5gES3U3gXRjWO6y6yuM4K+sB6MMzu+zmexNTVPIgkbKmxeyn/IyApWqGk5/QSHQ8IjlBxv+ycpiXCtcnKXQREAYPoNjLJzdn8pU3QxtRhmxO5z9ADDzIf5cCIP/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779458643; c=relaxed/simple;
	bh=A/iMiA2XzmEgbeCVruf28eJhabprwCFkP4UnzTLvfY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrxIBTg/ZyHG2cm1Xb7YslKYA1flO+i0Gnpf7J2DFBILi32pXhcH/sgWXDhd4Y+S/n8OZzrFz3A77wsSEtgUGmVlgOje6+H1I/CA7oMmNtKcafxJEGsEYEW1E/lFIhEhVMQcQE9Edlb42QkVrWqiqKfJ8U80phb2tycWQ2XxgN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPcESFTy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPcESFTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D76C1F000E9;
	Fri, 22 May 2026 14:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779458639;
	bh=axRX1ZK0L4VEIfC2UR5Zr0qpsUT4bGBtBH6miQcuvDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DPcESFTyUn8ojzGpscJnSu+ouLZ0eW4mSs7KTCOim6G6AOkHX9WY8BpXDn3twyXN9
	 xoV9cS09/ytJrsu3Ofg0Ibn+LAPj98017LIEpBQd7dNInXdSWJpxq5Tdz/v45+ll++
	 SHqvYT6JyzCgMkha1pKQHF2vt5yLpYfPQNbymO6ddi0N/vowkgaiZtyChsdScImytg
	 wtKhwqpUcZH0Kb8BLdKTrYrMDPh5ORz3hK3CBY2IfYHda0mGd0Ibnvz86KWrm7gWb4
	 FX1blDoWN7YCPaD/z5irLOz8Njzp0PrZ200hqFkhpd2jxBo/19D5AOZWMB1MT6wv9B
	 tZsLJV92/EAYg==
Date: Fri, 22 May 2026 15:03:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Alexander Koch <mail@alexanderkoch.net>, Michael Hornung
 <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/7] iio: light: opt3001: move device registration to
 end of probe()
Message-ID: <20260522150350.331f390e@jic23-huawei>
In-Reply-To: <20260521-opt3001-cleanup-v3-1-820169dec8c3@gmail.com>
References: <20260521-opt3001-cleanup-v3-0-820169dec8c3@gmail.com>
	<20260521-opt3001-cleanup-v3-1-820169dec8c3@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 11:55:38 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Move IIO device registration to the end of the probe() function to
> prevent a potential race where userspace can interact with the device
> before IRQ is configured properly.

For this one, we really need a specific problem path rather than
generality that userspace interfaces aren't up yet so a spurious interrupt
causes us trouble.  

The intent is that the IIO core should drop anything it gets sent.
Might not be true in some corner case. If so we need to identify what
that is and whether we should add some more defense.

An example is iio_push_event().  That's guarded on iio_dev_opaque->ev_int
which is initialised in iio_device_register_eventset()
There might be problems in there but it will take more analysis.
The Kfifo looks suspicious as it's initialized a few lines too late
(for no obvious reason - ideally we'd look at whether we can
harden that!)

So question becomes is the kfifo used.  That's a driver question
and depends on a few register values. So chase that through to decide
if there is a bug here.

Otherwise it's just a logic improvement, not a fix.



> Additionally, switch
> devm_iio_device_register() to its unmanaged counterpart as current
> driver implementation mixes managed and unmanaged resources, causing
> potential resource leaks.

> 
> Also, add iio_device_unregister() to remove() function to correctly
> handle teardown.
> 
> Fixes: ac663db3678a ("iio: light: opt3001: enable operation w/o IRQ")
> Reported-by: Jonathan Cameron <jic23@kernel.org>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260511-opt3001-cleanup-v1-0-f7879dc3455c%40gmail.com?part=7
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/light/opt3001.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index dac3d3818d0a01b4ca53106fa38bb54b8c5373d4..fe53a072b21ddaa26a23c76e82897fdbc1e4d846 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -874,12 +874,6 @@ static int	(struct i2c_client *client)
>  	iio->modes = INDIO_DIRECT_MODE;
>  	iio->info = &opt3001_info;
>  
> -	ret = devm_iio_device_register(dev, iio);
> -	if (ret) {
> -		dev_err(dev, "failed to register IIO device\n");
> -		return ret;
> -	}
> -
>  	/* Make use of INT pin only if valid IRQ no. is given */
>  	if (irq > 0) {
>  		ret = request_threaded_irq(irq, NULL, opt3001_irq,
> @@ -894,7 +888,7 @@ static int opt3001_probe(struct i2c_client *client)
>  		dev_dbg(opt->dev, "enabling interrupt-less operation\n");
>  	}
>  
> -	return 0;
> +	return iio_device_register(iio);
>  }
>  
>  static void opt3001_remove(struct i2c_client *client)
> @@ -904,6 +898,8 @@ static void opt3001_remove(struct i2c_client *client)
>  	int ret;
>  	u16 reg;
>  
> +	iio_device_unregister(iio);
> +
>  	if (opt->use_irq)
>  		free_irq(client->irq, iio);
>  
> 

