Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3FC1FF1DA;
	Thu, 20 Aug 2026 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787190419; cv=none; b=dHgfHGeXQROk3VO+H6vLgg6K8+hCMiO3aMwKV7/TJ4siSLLHUA6Wq+pJL64Y6V2uuqiNvW7B2aCWT6hIDPP6l7HZ0+v03V2u3Wv5Fvt97k6d6n8BCZxMPdGLqY3l6L00lr6eLebEfPZBMBCNWHxQiSOinYvT6c76OamJHW9w5Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787190419; c=relaxed/simple;
	bh=tOFjPtOkcqzt9Nnlfm+HxWwPuxqZEuug/UifjSwF2wo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JpyTJP1YUF/SechLwc8ZwX5ySQgShmUSQ1IbrxfG+AYutM0KjgojM/S1y/B175ly1+qZa2BeZyxfoREJ+cuqVAotJiYUnFmJ3uwocrq+5VgxdBIZRKmT2jGK2kSDwnhpl7dAhK3ldfUQ85JK2ZvFX1TkiFuNuTrMPzmTmTvi1W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwq5PhbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwq5PhbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7231F000E9;
	Thu, 20 Aug 2026 01:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787190418;
	bh=XcG1AqCQ11KqptcNUE/2W51SFKzeTLqu4qkGeInX5V0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kwq5PhbZ9ZFKF6X/xO6wjoepq0xdZylMDP/Qp1TzFet1UP0NDT8x0W3Bsq1S5bT81
	 SW/L89xP4xUkdOrw534cJVc2sKbdPjIX4LAbRwbpsGKOVCu4XsdSpU9+iSf7uo/meA
	 hzRWsYiDnTEb47KtMrd0J6v2yMGPDFxx5xlTtx5ginLSQnMyJv4rveKdHsWpwfdvGx
	 Ja4uigwRtZi1+lDC2RyvaaTAx16S/o6z0XN0ctc6jiqWlEfj4doBgIqJyvgB/mKqPT
	 DPV92tBK72thsggpkjPUv3JXB5qTwk3CQDN5Xqfuh1/7Lce3xhLDu8/eMxJR0/gKE+
	 Ij1UOJ7qer9sA==
Date: Thu, 20 Aug 2026 02:46:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: aw96103: Fix early return in IRQ
 handler loop
Message-ID: <20260820024653.251ac6a9@jic23-huawei>
In-Reply-To: <20260819210826.14395-1-salah.triki@gmail.com>
References: <20260819210826.14395-1-salah.triki@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 22:08:26 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> When an unrecognized proximity status is encountered in aw96103_irq(),
> the default case executes a return IRQ_HANDLED. Because this happens
> inside the loop over the device's channels, any remaining channels are
> left unhandled, causing missed events and stale IRQ status.
> 
> Replace the return IRQ_HANDLED statement in the default case with
> continue to ensure all channels are processed even if one has an
> unexpected status value.
> 
> Fixes: 07b241262dca ("iio: proximity: aw96103: Add support for aw96103/aw96105 proximity sensor")
Hi Salah,

Interesting little find.

So usual question for a fix: Have you seen this in the wild, or is
it code reading / tool found?  I'm not against changing it but it
is useful to know this for attaching different levels of importance
to the bug and hence how fast we merge it. Please add a note on that
to the commit message for v2 (though let it sit for a while for others
to look at)

Is there a path for this to happen short of corruption / broken / 
malicious device?  If not, no fixes tag - it's hardening or a useabilty
improvement rather than a bug fix

Thanks

Jonathan

> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>  drivers/iio/proximity/aw96103.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> index 8fbb755dcae0..b1f36a51d56f 100644
> --- a/drivers/iio/proximity/aw96103.c
> +++ b/drivers/iio/proximity/aw96103.c
> @@ -669,7 +669,7 @@ static irqreturn_t aw96103_irq(int irq, void *data)
>  				       iio_get_time_ns(indio_dev));
>  			break;
>  		default:
> -			return IRQ_HANDLED;
> +			continue;
>  		}
>  		aw96103->channels_arr[i].old_irq_status = curr_status;
>  	}

