Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2392239E9B;
	Sun,  9 Aug 2026 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786316379; cv=none; b=ZjabdSP7tbK0OKupup1zNBr+tJtBwLzmuzWMGU2/MPArJ0Vm7a8wKws5/aA0eUOgADxEuKOjzETnXIjlqNTKIxLIh18WkM97NkNp1q69NjuhqtCxissXm/xtQmpPaW/6+rRofNc0r3ZOXRBYm811eMCQYKcxdXvbgPMcMANowqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786316379; c=relaxed/simple;
	bh=qe731VEef+9q41mK6vzyjmoVqvvHINqjFmnU8wltFYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diV9O4dbnfRPGkjl4WxL8econxa6uVa2suWYwabeP8iZvWXJAs4eiQqPcJCrbwX29TXA/TgWoC53ewltAToZDOhtZN2IQJoOeI9e6NzXBvP7NlMoJvmx57GgeuHVlJEN02KwzPxQBDZgg4Ef335PHtjB+STM95n1niRHzAdp5lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7j59aZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7j59aZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC8E1F000E9;
	Sun,  9 Aug 2026 22:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786316378;
	bh=6C/EKqBE6q5MHInujdJLh68Cp8pCSgZT6Voc+UlmHG8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e7j59aZSkx/viqqHsbhTtYA7Ncu9Olzq26uvo9H12XE14MOgfGEp/9wucI8j+0BFW
	 ev9cZnxW+kOYwZqHXOShwLZ7e3wt8rOkw3oZY3ctm61CxfjJ0Dg8KWG6PbNLxvbY+C
	 KVY+ZJhrVE7rA8Hzj4WGxyUlpUfWObCxVHXGXVCJSsPmTBO75Ob854yRgNvCvVmaBS
	 vS+JG5mnaRJ5qtTe/Y70aNPpn/0EFd2JkICysBjl5VOudFeQcDLRxtg3zGlqATs1j9
	 i6XWPdAmVEbyPAh+qr+N/+eQVOVmpZ9PPg19yIntYJz1ZxnZ7EJT451JH8lWcvNTCS
	 0mVnyzDlOovYA==
Date: Sun, 9 Aug 2026 23:59:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: use IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <20260809235934.6045eab8@jic23-huawei>
In-Reply-To: <20260809055442.434972-1-yashsuthar983@gmail.com>
References: <20260808220236.421832-1-yashsuthar983@gmail.com>
	<20260809055442.434972-1-yashsuthar983@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Aug 2026 11:24:42 +0530
Yash Suthar <yashsuthar983@gmail.com> wrote:

> Replace bmc150_accel_data plain buffer with IIO_DECLARE_BUFFER_WITH_TS()
> that also keep timestamp aligned.
> 
> Fixes: bd7fe5b71918 ("iio: accel: BMC150 accel support")
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>

For future reference, please never reply to an existing thread with 
a new version of a patch.  I'm a bit confused why this one keeps
coming up as I'm not aware of any part of the kernel that requests
doing it this way.  Reasons not to do this:
1) Confusing threads once they get sufficient numbers of replies, including
   making it harder for tooling to work out what is going on.
2) Reviewers and maintainers tend to use mail clients that put replies
   to old threads, somewhere back in history, so the chances of getting
   a review is reduced.

Anyhow, don't resend existing patches to 'fix this' but make sure
to do new threads, if you send out any new versions.

This looks fine to me so applied to the fixes-togreg branch of iio.git
Note that branch will be rebased on rc1 once it is available.

Thanks,

Jonathan



> ---
> v2:
> - Rewrap commit message.
> - Add Fixes tag.
> 
>  drivers/iio/accel/bmc150-accel.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> index e8f26198359f..e0773533efeb 100644
> --- a/drivers/iio/accel/bmc150-accel.h
> +++ b/drivers/iio/accel/bmc150-accel.h
> @@ -64,7 +64,7 @@ struct bmc150_accel_data {
>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
>  	struct mutex mutex;
>  	u8 fifo_mode, watermark;
> -	s16 buffer[8];
> +	IIO_DECLARE_BUFFER_WITH_TS(s16, buffer, 3);
>  	/*
>  	 * Ensure there is sufficient space and correct alignment for
>  	 * the timestamp if enabled

