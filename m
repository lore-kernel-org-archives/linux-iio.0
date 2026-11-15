Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794701018;
	b=Y64u2MTmncLsEVrY9OMNtit8eYZQ50bOorqJl1dIE8yoCfF3ZWmsgVL8sxo5zWJ/5tOx
	 /scdp6zayjrpgm3Nndjf4y8LW68sYsysBP9xYIEv6DxqltrREInhAX1r9DDhUXc5UvEl2
	 rag62n0XrW6AIWYgzCnlE3wC4F6yfuCWkxknmuva79crov66idBvDDeCS9rlESdyxaK46
	 t27GGnDz/kpLvsnay0g4tsml9Eu1H84vB5RGLwizrs1b69wd6XV1aDt8nDi1naqOJ4X2e
	 66DUvOXKSBuOFRqL/B0PqcCynr+XEhMQdZ6OAaZSeyYsmKBOyG+DMxn6f2f8sijjK3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794701018;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AoS9IxBx+LlzwzmBEk/xBLg8sOv3s2W03U4hrlihHlk=;
	b=FQAk29sAis+HWB8E7f+CuirQTfTPnhhBwozalExdiwIAI0Zi9Y1Ke/5AUBjxgSWRnfVq
	 YcSy7YOhBe+zEI0CKOEmHXmN6BXqdOwlxw2iqkbFsqrvIacSWPlFfCgA90bW7WWpQEyvc
	 0gaJ0BszFxC8n9VhaC5Si42uPuv6eODD6D9CnghVeHH6eg2CL7/l29t+bnWrSoAFzFiCG
	 kvkx2SvWLGWYvUmTSUsjD8sEsIoAFfIKZ1M+K1ghuUyslARNRRP0XrgV4uUdlj8LdLB2S
	 Sl40HoUkJEOKbyZkhjbtTZJL8qq7OAsHwQRW3jtY45sjuFNmVayz1SczI+oORs/2RXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MzEhF1a1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5B5606A327;
	Sun, 15 Nov 2026 00:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MzEhF1a1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8046A1F000C4;
	Sun, 15 Nov 2026 00:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794701018;
	bh=AoS9IxBx+LlzwzmBEk/xBLg8sOv3s2W03U4hrlihHlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MzEhF1a1hgM/F/o2TXXcz3t162jyrVVAEDit62gLRV3ApktbDGkMV3pxkvAVVYjCl
	 5Ema3SFZKQHWPq/B1s8xmOKUsy6kan1tekswfLqsRCXlOjaCuuTHRysXk0xlNMTAHz
	 jW16u0gVsw5Xlrmw4mSieQ9O3Bx6UzOfd6G7oYFFJUi1Wsd4F+xrooh6HB5e2Fd2DZ
	 42v4rRX4OydrJSZVQNKWWtOIihqQx5YsDsiQYhf4ewta0SmHoh1kb0zojtPom3nlNG
	 /3eRRsHVSopxhK9QPu/TS2VpQTld2WJAbmqX4AD5rQFr1NEmaGcfdzYoH+ZBpqV8Jv
	 dKVQhBnowrhgQ==
Date: Sun, 15 Nov 2026 00:03:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Raffaele Tranfaglia via B4 Relay
 <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Cc: raffaele.tranfaglia@gmail.com, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, linux@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: adux1020: extract the FIFO byte count
 with FIELD_GET()
Message-ID: <20261115000330.02910414@jic23-hlaptop>
In-Reply-To: <20261109-adux1020-measure-fixes-v1-2-fe1ba63f28bc@gmail.com>
References: <20261109-adux1020-measure-fixes-v1-0-fe1ba63f28bc@gmail.com>
	<20261109-adux1020-measure-fixes-v1-2-fe1ba63f28bc@gmail.com>
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

On Mon, 09 Nov 2026 11:39:03 +0000
Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org> wrote:

> From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
> 
> adux1020_measure() masks INT_STATUS with ADUX1020_FIFO_STATUS_MASK but
> does not shift the result down, so it compares 256 times the FIFO byte
> count against the packet size. A count of 1 would thus be treated as a
> complete 2-byte proximity packet.
> 
> This does not happen on a correctly working device, because the FIFO
> only stores complete packets and the driver always reads complete
> packets, so the count is always a multiple of the packet size. Still,
> use FIELD_GET() so the comparison matches the datasheet's polling
> procedure and does not depend on that.
> 
> Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Applied this one to the testing branch of iio.git

Thanks

Jonathan

> ---
>  drivers/iio/light/adux1020.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/adux1020.c b/drivers/iio/light/adux1020.c
> index cccd509dd18a..dd5230c6dceb 100644
> --- a/drivers/iio/light/adux1020.c
> +++ b/drivers/iio/light/adux1020.c
> @@ -331,7 +331,7 @@ static int adux1020_measure(struct adux1020_data *data,
>  		if (ret < 0)
>  			return ret;
>  
> -		status &= ADUX1020_FIFO_STATUS_MASK;
> +		status = FIELD_GET(ADUX1020_FIFO_STATUS_MASK, status);
>  		if (status >= adux1020_modes[mode].bytes)
>  			break;
>  		msleep(20);
> 

