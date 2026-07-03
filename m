Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE823191F98
	for <linux-iio@vger.kernel.org>; Fri,  3 Jul 2026 00:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783038778; cv=none; b=u4fn3ytl1fuf55qIs4H8A5UE7XwD6x3S97iPemeLGW9AeO7emyetc7RT0ouI0sm78R2g5oH70On2Gu5v3Bl1ouQu6vWjjf/9WmYosXsmpiiLLnZi/bX0QuEl8yEE01ZwjNyEv0ndlpRw+r6yFsMlTR5gkKigayM6hG0SP+a0hY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783038778; c=relaxed/simple;
	bh=iaCjrZOZ9Czr4LlaYMgXADkAt9QdzuQVAc7ZCGeM3DI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AmUG9rYtf6c1ZiX8bGh+QyOLghN3KvNzi7/jnkkmT4xMatvV0/vwuru8mkKTQsbFz3rVjCQWVRSu7Zsxe1azsgNmV9iprk0W7pKyKWiCBwVtSWtlXabD/v/uxHjhdXU4iVR2186KRUgF2QkeJ3ojHCvet9PnTtnxo0SyxchBskY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3iJC1i7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3iJC1i7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3CD1F000E9;
	Fri,  3 Jul 2026 00:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783038777;
	bh=oTZfjkXNZYBBtKhi1nfegzoK3dnYJSSkq+2QPa+9XAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R3iJC1i7MpVuBb5mYTBgJlQR94S3ClVPUxtOgoUI8qLoUz9OdM3LYlHPOAsUIzY5+
	 GR3xLyDMS5ib5P4PrxdBsucTHjjD6QXs39TpkU5gS2ch803KwKnl2JwaAxy5rjtwgX
	 xkDySRw3SE9WxWpdc+oelaTGv/QCrkK/mOx9bMMVmfeyKZFVV1yLNxY3AQ9Oq99y1U
	 HD+5i+FW81FRIp8y8Wk3Ek3PPMA5k8uDwdtZpsuznbEFKStODpd7RipM4b9SRauVKf
	 fPQ4l88i1Yi3K+EumvEMC2qlLrN4qufuPK1rzWY5ZFtEvEycdGbvtaKIZAK57sCLJW
	 BDPBHVIAd2BGg==
Date: Fri, 3 Jul 2026 01:32:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Prashant Rahul <prashantrahul23@gmail.com>
Cc: linux-iio@vger.kernel.org, Shuah Khan <shuahkhan@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Petr Mladek
 <pmladek@suse.com>, Oleg Nesterov <oleg@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
 linux-kernel@vger.kernel.or
Subject: Re: [PATCH 1/5] iio: adc: ti-adc081c: use dev_err_probe for probe
 time error
Message-ID: <20260703013252.76d0c8bf@jic23-huawei>
In-Reply-To: <20260618231543.413771-2-prashantrahul23@gmail.com>
References: <20260616130612.73122-1-prashantrahul23@gmail.com>
	<20260618231543.413771-1-prashantrahul23@gmail.com>
	<20260618231543.413771-2-prashantrahul23@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 04:44:34 +0530
Prashant Rahul <prashantrahul23@gmail.com> wrote:

> This simplifies error handling and ensures consistent error reporting.
Applied with patch description amended to include () after dev_err_probe.

Thanks,

Jonathan

> 
> Signed-off-by: Prashant Rahul <prashantrahul23@gmail.com>
> ---
>  drivers/iio/adc/ti-adc081c.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 33f82bdfeb94..29dd7cf25f79 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -190,10 +190,8 @@ static int adc081c_probe(struct i2c_client *client)
>  
>  	err = devm_iio_triggered_buffer_setup(&client->dev, iio, NULL,
>  					      adc081c_trigger_handler, NULL);
> -	if (err < 0) {
> -		dev_err(&client->dev, "iio triggered buffer setup failed\n");
> -		return err;
> -	}
> +	if (err < 0)
> +		return dev_err_probe(&client->dev, err, "iio triggered buffer setup failed\n");
>  
>  	return devm_iio_device_register(&client->dev, iio);
>  }

