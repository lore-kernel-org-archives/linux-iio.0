Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902ED3264FD;
	Tue, 28 Apr 2026 17:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397347; cv=none; b=uzbwHSaC4fXhfAyibpoq5k4PliDbkr+q0ZaSCxKPjWhMLLKbWuQnQmlDs5K5Im+Y7pCC8824IBOe22LGvnIPaZON+r8HJDUidZPr6t44jm2AD8YaQBOAAp4hhETLRqSACYpLlmBSWWq8t55ar88RjJkdE6ObViQecXIVR5+cq20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397347; c=relaxed/simple;
	bh=u2SfhU2VXddbbYvgy//Mc//xtrla6iJo/l4JSpMqhhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoNCHXET9TAXeY1QS4JSZsHwkomPLhW2FHpf9/HTGD0jxU93s3Pqb/Bfc+QDgiNk1VL/iFCvj37Hk0/8l/DtMPuwE/rkEf7f7OG3yhXTvN4zw9dIGO3L/qebw6jEgabVviY8Sd33PY8yM5MEnDx+LJUS3wDmkL5Ml+U+j288wxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbBnB43c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbBnB43c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF15C2BCAF;
	Tue, 28 Apr 2026 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777397347;
	bh=u2SfhU2VXddbbYvgy//Mc//xtrla6iJo/l4JSpMqhhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IbBnB43cQRXSKs9caFUbq4yFgjbkEXfGY/QDQIWnyVVnjreOmAMw/Xuq4PrgOPjSF
	 Hj+TfZuqLdqjhXSLkLOc52PGjSJxLjpsrvX/wiRo8pdXvZFzIh3hpAjdDqIVI/AnE2
	 xFD7AUoROB6s+s5sgn+xqiMvhSxW8ZycdytgYrO38aWlm+QzWELiYBNGVHFpPysGxc
	 9ieyk2+6VSg4E8Z0BKuag8pCH3ZPG/Gi2LmvL+RFn6g5z7KtEVI6B4Pqpn6uKd8KHf
	 UID+ynSrPFVVr3wuIiZM4tKMCzZMgVb5d4IpAP4MIQ5yufrP0OsMJ3rs8dbeei3NPk
	 JVet7iWnYvoZQ==
Date: Tue, 28 Apr 2026 18:28:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hw-consumer: free scan_mask on buffer
 release
Message-ID: <20260428182858.7d7e1034@jic23-huawei>
In-Reply-To: <20260427-iio_buf-v1-1-2bbdac844647@gmail.com>
References: <20260427-iio_buf-v1-1-2bbdac844647@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 19:11:39 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

> The scan_mask lifetime changed in commit 9a2e1233d38c ("iio: buffer:
> hw-consumer: remove redundant scan_mask flexible array").
> 
> Before that change, the scan mask storage was embedded in struct
> hw_consumer_buffer, so iio_hw_buf_release() could free the whole
> allocation with a single kfree(hw_buf).

> 
> That commit moved the scan mask to a separate bitmap_zalloc() allocation

> stored in buffer.scan_mask, but left iio_hw_buf_release() unchanged.

Hmm. This reuse of a pointer that is otherwise set via very different
paths sent me down a wild goose chase.

Patch seems fine, but I'd like Nuno to take a quick look before I pick it up.

Jonathan

> 
> Free the scan mask in iio_hw_buf_release() before freeing the buffer
> wrapper.
> 
> Fixes: 9a2e1233d38c ("iio: buffer: hw-consumer: remove redundant scan_mask flexible array")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/iio/buffer/industrialio-hw-consumer.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
> index 24d7df603760..d1ab2cbf8c88 100644
> --- a/drivers/iio/buffer/industrialio-hw-consumer.c
> +++ b/drivers/iio/buffer/industrialio-hw-consumer.c
> @@ -40,6 +40,8 @@ static void iio_hw_buf_release(struct iio_buffer *buffer)
>  {
>  	struct hw_consumer_buffer *hw_buf =
>  		iio_buffer_to_hw_consumer_buffer(buffer);
> +
> +	bitmap_free(buffer->scan_mask);
>  	kfree(hw_buf);
>  }
>  
> 
> ---
> base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
> change-id: 20260427-iio_buf-0459b3fa3de8
> 
> Best regards,

