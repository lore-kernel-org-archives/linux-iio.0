Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793579490;
	b=cdFVMnNZM/oxV0Baq1y0zudw4YWLnroJ0G7b1qdxMj/gMpONLKJ7mdy8Hgpx3Jn8+y2p
	 Xj672/F7KV6SntJDkbyaBriSOATMGlJ4mlbJVDchvi7J+hUUxspJvME9hvXOlbWOopBgI
	 rxrn7480FTwWpp6uOSV8Le1Q7ahqGuDlDgvHxA/cXy5NdZ1eVjbozHK8hDSsn6SwHaX9E
	 zFOvQWzuQwWsyjDpB6ZGlrDIFOrZ+5WYpEnw2VAMxsa4y+OOWCQqkEWw+tOM9Enq6IhlO
	 n7GIu1F4BuFzkRHkE1wIIorfjd1gdbqjsUw6tmSbeb3TkXqDuJJroTdWhX4ROjk62Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793579490;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ygXTNyt/uVyVzYDRnnvac/ELVjEyy9y50yB/VXax2og=;
	b=h5x7/NCIFCysdoNr7XGTFtnfdg7SGglA21GuNsC3xUSm7FFRVf1NOQduMZnjjNrx/ua0
	 34LN9MKg9U/WxShdquLJBohUC6mZYEF6uCR386hdlDOTlJp9vH7yzbdZR5YNGaJ6d5nK9
	 wFJDzBd42CmmwYcbS+oCODNJ12f5FzI9ce7I+1qxkTSzJ8ADlp+KcIC6PtPuL3n/RTkop
	 JUqikvFRx26a+13w2JdDOvkHLbGHXCzSOpebjExmdeWZVNCNmiE8zPOqhPax6Xa2xaf53
	 4KMv5/QsEeyBX93quiSZXEP66R8aCB0csONPISqzDmhUeB6x/60c7dYXSRG8tNg0mgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlGsxnkS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DA9606A324;
	Mon,  2 Nov 2026 00:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mlGsxnkS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EB21F000C1;
	Mon,  2 Nov 2026 00:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793579490;
	bh=ygXTNyt/uVyVzYDRnnvac/ELVjEyy9y50yB/VXax2og=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mlGsxnkSbJy86oW1NxMLMHmLzC82sSzyhdsKl4I24Rey0JcLkd9qgS0Gl0ZweANIT
	 JN3lwskG+yeD+LlswLWrr3gzHCumxIV3dy/xKjsIbKaFh/droAQYPLLG/Qb/z47o52
	 cjqLU0vPvprxXTpYdHMysUn0bMAt6aYJHBQiumBIiY40/h+nlgGRHROvJSiLzNuDTb
	 LtpqUWCZruMjz6oEjWmj51+F9vbIm8ir6JqFU5LB0lQQMkbD2dRTQE/NqaSD7FjcdR
	 eKPCler5YE0Rxg2qvWs4CbDCz4luJYn8rOr6nI7/5q7ombUPStwK3wOo1omMt5Yywt
	 OB/Q3DwHpFpPA==
Date: Mon, 2 Nov 2026 00:31:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxsd9: Fix potential use-after-free on
 removal
Message-ID: <20261102003123.0cc4f89d@jic23-hlaptop>
In-Reply-To: <47d9e9120165e819d706f922c798517701019bf1.1793377431.git.liguangshuo@mail.sdu.edu.cn>
References: <47d9e9120165e819d706f922c798517701019bf1.1793377431.git.liguangshuo@mail.sdu.edu.cn>
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

On Sat, 31 Oct 2026 21:05:38 +0800
Guangshuo Li <liguangshuo@mail.sdu.edu.cn> wrote:

> Unregistering an IIO device with an active triggered buffer detaches its
> poll function. Freeing the poll function first can therefore make
> iio_device_unregister() access freed memory.
> 
> Unregister the device before cleaning up the triggered buffer.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: 0427a106a98a ("iio: accel: kxsd9: Add triggered buffer handling")
> Assisted-by: OpenAI:gpt-6-astra
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Applied with tag dropped as Joshua pointed out and with stable added.

Thanks,

Jonathan

> ---
> Build-tested the changed object with x86_64 allmodconfig (W=1,
> CONFIG_WERROR=n).
> No runtime or fault-injection testing was performed.
> 
>  drivers/iio/accel/kxsd9.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
> index 7ac885d94d7f..27adcdd31201 100644
> --- a/drivers/iio/accel/kxsd9.c
> +++ b/drivers/iio/accel/kxsd9.c
> @@ -478,8 +478,8 @@ void kxsd9_common_remove(struct device *dev)
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct kxsd9_state *st = iio_priv(indio_dev);
>  
> -	iio_triggered_buffer_cleanup(indio_dev);
>  	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
>  	pm_runtime_get_sync(dev);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> 
> base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
> 

