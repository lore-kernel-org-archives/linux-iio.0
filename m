Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DC6282F17;
	Mon, 27 Jul 2026 02:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785118453; cv=none; b=QY4m60U7SBJws3eDdJxauKQTAdummU+TcmlyJDxTxjwdQNHqWbBYAJH/2tGv2XCdSkujQTh3zkPU6ROPJ2w09AhtarPo0ZcOtUdAi8DyCZQnPQIObLWGnfQe+AFlam8/z7GOPvP83Fc1ihCgpSXtgwfU+e2nsLuePadSmSaXOlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785118453; c=relaxed/simple;
	bh=Cqjvct62b9Ub6Zu0jL6OuMtZ5Ox8L9JYGcESS1WAZUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVcrQVja2R+yuHfQ4+0H28DkCq0usC+sjheLMfKjDaFX/aAoZU4Tr8lpsZw6XDdib5jQ/7HWaWY4lpm56jbJKSHNMninXaeQ4BrMh4sLTdsIh0Jm1tf8I//ftsaZa9sMy9GMb0xmr0wYRwWR4hBjWkcud+JrorYovYtQSaOWN20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fgb0zXXY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fgb0zXXY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A9F1F000E9;
	Mon, 27 Jul 2026 02:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785118452;
	bh=g3iPqKix+EBR6wFQdC0ZIAEzmOczeHf+n3ZWm93/cxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Fgb0zXXYdwl6lr0+DIqPTrDYIbiPnxGdmPeaMv6eP7GkPZLDy2eVwB3cFvAE+Grwn
	 x/gLBN5119192E5N65G3wtyCS26J5em72xvvZ5VqMxGvVRklbuAl7WkXgz6fIdqJxz
	 WR9xdvpCPHY2XkdnfjtnDJBJR+mbOdT3SdBJKwCLmWJOx7c+Wc6CSlikPqF90c/Hk3
	 FZ4n5aheWZCJYkewz3lFAUBhmv6qactsF8aRLdpKnC0y5v+Sn5HcHlzinDZwYsqXmi
	 C62a3YwxVS0IolnBi7vSi5Ro3gFjEp8uSz1hx3llDiLmhrrb7Zu8uP2a0QKwIAaxII
	 8NOLtPqYWkjOA==
Date: Mon, 27 Jul 2026 03:14:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yuanshen Cao <alex.caoys@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: tsl2772: fix ALS calibscale readback
Message-ID: <20260727031407.44a6d201@jic23-huawei>
In-Reply-To: <20260724-tsl2772-calibscale-fix-v1-1-00a7789f4deb@gmail.com>
References: <20260724-tsl2772-calibscale-fix-v1-1-00a7789f4deb@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 23:46:01 +0000
Yuanshen Cao <alex.caoys@gmail.com> wrote:

> The read_raw() implementation uses IIO_LIGHT to distinguish between the
> ambient light and proximity channels when handling
> IIO_CHAN_INFO_CALIBSCALE.
> 
> However, the ALS channel is registered as IIO_INTENSITY, while
> write_raw() correctly writes to IIO_INTENSITY. As a result, reading
> in_intensity0_calibscale incorrectly returns the proximity gain instead
> of the ALS gain.
> 
> This causes the following user-visible behavior:
> - Writing in_intensity0_calibscale appears to have no effect because the
>   readback reports the proximity gain.
> - Writing in_proximity0_calibscale causes both in_proximity0_calibscale
>   and in_intensity0_calibscale to report the same value.
> 
> Fix this by checking for IIO_INTENSITY in read_raw(), matching the
> channel definition and the existing write_raw() implementation.
> 
> Signed-off-by: Yuanshen Cao <alex.caoys@gmail.com>
Hi,

Fix looks good and the explanation correct.  Was this an AI found
one, or did you either spot this whilst reading the code or best
of all saw it in practice and went looking for what is wrong?

Give it is fix, what is missing is a suitable Fixes tag.
Please see if you can figure out what that should be.
No need to send a v2 unless anything else comes up in review.
Just reply to this thread with the Fixes tag so I'll get it
when I use b4 to pick up the patch

Thanks,

Jonathan

> ---
>  drivers/iio/light/tsl2772.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
> index 244f44379c36..2287585711c6 100644
> --- a/drivers/iio/light/tsl2772.c
> +++ b/drivers/iio/light/tsl2772.c
> @@ -1274,7 +1274,7 @@ static int tsl2772_read_raw(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
> -		if (chan->type == IIO_LIGHT)
> +		if (chan->type == IIO_INTENSITY)
>  			*val = tsl2772_als_gain[chip->settings.als_gain];
>  		else
>  			*val = tsl2772_prox_gain[chip->settings.prox_gain];
> 
> ---
> base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
> change-id: 20260724-tsl2772-calibscale-fix-0cc42518d5fc
> 
> Best regards,
> --  
> Yuanshen Cao <alex.caoys@gmail.com>
> 

