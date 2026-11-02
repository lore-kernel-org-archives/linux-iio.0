Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585472;
	b=DP3rIaJO+JU/N0CqYAKdneYtEi5wLilFdooaK+5M4Jj1NINwzkrLkewxnTdwdtzzwfXY
	 R7AjvIOHcRynxqeVHNij1M8fOhzN872GEA3ti5p782m9J6vpQxSiHg2g9DevYtNLe33IO
	 N6LWKPWEZ2Ah6mP0c/44LLiBmx5FU19UTnJWkOwCcAr5hz/cfx/RllhEgrTQ9SBVM5JVn
	 cQZPKJDtAw+ZPecqrmz254dWtiAccunFUzBBKvf3NugluONSznl8Updc/oPMSMvZbT6AY
	 BS2zCLNsy3ScvfDvgCouLiK5rNDH/kOljWHeuBa+KTPXiIgzOPLnzd8MZFqYJIs4Tbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585472;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cZtylldNQb2bQguQei9fcxCR+BlUPACbAqKaXo1Y9eY=;
	b=y6rNSjBd2SL57VL2wni0YpYSZ3K4TCOgSJXoTSjfdFWyYW31a3la38gMd4Bk1XWL8Gha
	 Ty0GjYSLyan3V2WefDsmori0sgBqbJvosSaGY8GN3OJAXXta4Vg7YqEhXbNkfDMzSaJy7
	 a/JKIJy7ME0CWbuydOrAk0I5oQnvGzEOZB9qVD4w7YrjPVrUIbCCa6gA+1W02c2CDn9RP
	 tGGDgEvPf5j+4z47mrU3ocknCG6nNj1dcwLEqK8Ui6z4CsZiNo/NE2rS41yd6nKJOrAuI
	 aolRjmIdviYql85zLzMaKVU0dhRFXnf7mV9+MB75wt7wDv9np27lJBv0ZZc06CkGKxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A/HpwyMY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BC3606A324
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A/HpwyMY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A941F000C1;
	Mon,  2 Nov 2026 02:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585471;
	bh=cZtylldNQb2bQguQei9fcxCR+BlUPACbAqKaXo1Y9eY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A/HpwyMYZncLZy/Br6ml/UqZ8aCuFQ8zeFIuJXSEwG6DLz+IOZwUSRaMoAg+WNL7O
	 helW2SCIt3kW3+ZKJiOC6jOccVZUjFdoTSL3CvZ4gdoKa+9uOQOPFwD9qEpVnpJTwD
	 AF2XgWkJa1Umalbhf788dF60OQ74N8H9QTqqOp0XrHs2iZEqfdy5DSvRnS5DKvt0sz
	 RvzyO3lHWryHkuFBEJ3DKdHy3UaaxL6Qqgcc0GmCRKajGqjip/RkhF3TgczdDFShFk
	 DUksecEvA28GLjDCrVgj5dV3EWbme9zHV3FkUvOxFDIgexK2HRvvR0v9W6iT/A97cP
	 8IvdpQaEm+L+Q==
Date: Mon, 2 Nov 2026 02:11:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 11/39] iio: pressure: ms5611: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261102021108.42106e23@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-11-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-11-8b136778eedf@oss.qualcomm.com>
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

On Mon, 26 Oct 2026 16:05:29 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
> which is on the stack and local to ms5611_trigger_handler().
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Applied 9-11.  More nibbling away at the set to cut down on what is
outstanding.

My own fault of course for sending a large set :(

Jonathan

> ---
>  drivers/iio/pressure/ms5611_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index bdac27bd5a5d..72c769f9b6ad 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -224,8 +224,8 @@ static irqreturn_t ms5611_trigger_handler(int irq, void *p)
>  	if (ret < 0)
>  		goto err;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> -					   iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +				    iio_get_time_ns(indio_dev));
>  
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
> 

