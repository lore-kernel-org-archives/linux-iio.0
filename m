Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B72313E24;
	Sun, 12 Apr 2026 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776006740; cv=none; b=ZSwc3D/aGruG13afvUVvheSG2UWL6rXlJKlUSnmA6Tumk2LjOzdNB/qf+vw+1EMUfIU8mwpfV9I00wg3zjcxuTYJgQNVYxr+ylNIBmX/cjTKdDVll31QnEWtd1SPIYx075mb3/L+m4/F+2/ux2ANjHdscWiV/feorTTVas9CGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776006740; c=relaxed/simple;
	bh=yNxjtNBMRJIlc17pgiUYYiOp5Ofx8ypvvY3pLXk4msI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRnYaT5QLIXX/Q9ew76lB7VOGepYeMtAePal5EvytwSyQ9UPRQoWQVzU9Aai4khTEU2n8IeXnQaZdh6ebrjgS7hOLssnuQF5xn5uzyW3N9VaWGL1f8F60G/4oaxEOTBOR+2jadyIUNVS4qQjW+EFtUPE0iwKgHBMbiaea2r9r1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0aonE/D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0aonE/D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432A6C19424;
	Sun, 12 Apr 2026 15:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776006739;
	bh=yNxjtNBMRJIlc17pgiUYYiOp5Ofx8ypvvY3pLXk4msI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D0aonE/Dh1zOK6AM48HbJw1Qq3lP87X7BG1PYoHbZ0GbeIv7flAcB3KX2vWc3P1sH
	 w9x26M1icSktosfpabla5b+gUb4oFeyC7mdY603186G6cOWfqi8Ig4er/Jtb8Y6pll
	 DrtX31CbBgPb5tnFKWQJagVwwHVwSQzqtKyDfjEztGKdJTwqeyQuhFU30JgpsAl0RS
	 03NzFuVGqd3rGaL2rrAjK3vO6/iqKByZitJSgG+6Sefj6nMdXlp0CSgXhMxdk90f8+
	 VgAgI8siwa/sUc0p2VbiI25w5LWuw81ovldwpLXSZj22/KX7GV2LoWg1/uiowIO2ie
	 jj5nw5g35iL/g==
Date: Sun, 12 Apr 2026 16:12:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-iio@vger.kernel.org, Gyeyoung Baek <gye976@gmail.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: mhz19b: bound receive buffer copy
Message-ID: <20260412161212.0f0e24c1@jic23-huawei>
In-Reply-To: <20260322134807.16217-1-pengpeng@iscas.ac.cn>
References: <20260322031923.58031-1-pengpeng@iscas.ac.cn>
	<20260322134807.16217-1-pengpeng@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Mar 2026 21:48:07 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> `mhz19b_receive_buf()` appends bytes to the fixed 9-byte command buffer
> without first checking that the new chunk fits in the remaining space.
> A single receive callback can therefore write past the end of `st->buf`
> before the driver sees that the command is complete.
> 
> Drop overlong chunks and reset the partial command state before the
> copy.

This 'before the copy' part of this implies the copy still happens.
I don't think that is true.

> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/iio/chemical/mhz19b.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
> index 3c64154918b1..fbd7f14483b3 100644
> --- a/drivers/iio/chemical/mhz19b.c
> +++ b/drivers/iio/chemical/mhz19b.c
> @@ -240,6 +240,12 @@ static size_t mhz19b_receive_buf(struct serdev_device *serdev,
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
>  	struct mhz19b_state *st = iio_priv(indio_dev);
> +	size_t remaining = sizeof(st->buf) - st->buf_idx;
> +
> +	if (unlikely(len > remaining)) {
> +		st->buf_idx = 0;
> +		return len;
Given this doesn't complete we will see a timeout error if this is hit?
That is rather misleading. I think I'd at least print a message in this
path to provide a hint of what happened.

Jonathan


> +	}
>  
>  	memcpy(st->buf + st->buf_idx, data, len);
>  	st->buf_idx += len;

