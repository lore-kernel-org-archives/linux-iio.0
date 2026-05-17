Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036233AD9C;
	Sun, 17 May 2026 12:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779021669; cv=none; b=Hf1EZo2nfZYjvySTyRFgqjDtkWUmw5VMa9QW7QrVI1yqivzoAlAtQ7fMdHvj+tLUBsOQ0SSXoFFYulNSvvKQhcU2e8vuAJ9fB9xdMJ5IqyEKXHXXm+9e7WUK5604usrTktNGyLPFzS9MTFXDZVKxNU0FKC1Nw7wCESMZkKchc+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779021669; c=relaxed/simple;
	bh=MAQuaURMs42xmo4qpDI6JRBzV0YB1pTVEwmF3ZChyUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NbPSIf+FSH5L7rVehTcSQxbmAoGsmo0aqWsQsVNS037HUKz2PkpPzHm6OWY3Mi3bTpXCXIfoNMqVbGeZ9heiVoqeZKXHg49+bdFsR8/hzK+QJ04kbzY7L6jMJKpTJ+WfMnhMDLOjKrTkp+qp5Zhh8v6MM/J6KR96z661bQJMB/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=atu0VhPm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atu0VhPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89316C2BCB0;
	Sun, 17 May 2026 12:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779021668;
	bh=MAQuaURMs42xmo4qpDI6JRBzV0YB1pTVEwmF3ZChyUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=atu0VhPmJTTkWrAtc+/4WD3OzLTpeqZPnFiita/Hhdm0qeHc8taPp9Z8pXM1xCSVn
	 vVj45NVYGJ56dRp2KCfyO9ASghavVOplHtiTCe4rJVtEM9DazogIpoJpuCqLzqDVXD
	 uUF5j4QWLubdihz57rBc1t58qwUZ7BuW+6bRb6obfRm6NLd/5KvIrFqXnnmx9LHojw
	 2LPwNB14PrikxVlm8LPu6hNH/DqGcVNhfP8c2orRhJdDkSLNZaKZKIi5alDf0UIpzw
	 Zpp5A3oSJNS/7Wv+v2Psar5ZqVZTl3HQawOHCH2DdMvtGTVVuxIrsOYUUgoLe/Na6u
	 1puSuEYtQaksg==
Date: Sun, 17 May 2026 13:40:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 tglx@kernel.org, christophe.jaillet@wanadoo.fr, mingo@kernel.org,
 kees@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
 kyungmin.park@samsung.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/12] iio: ssp_sensors: refactor transfer logic into
 helper
Message-ID: <20260517134059.1141a2a0@jic23-huawei>
In-Reply-To: <20260515174017.3962168-4-sanjayembedded@gmail.com>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
	<20260515174017.3962168-4-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 May 2026 23:10:08 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Extract the core transfer logic under comm_lock into a new
> __ssp_do_transfer() helper. The change is preparatory for converting
> mutex usage to guard() helpers in subsequent patches.
> 
> This restructuring simplifies ssp_do_transfer() and makes the
> transfer flow easier to follow.
> 
> No functional change intended.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/common/ssp_sensors/ssp_spi.c | 50 +++++++++++++++---------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> index 3d377a482161..ebcda6de56c4 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -196,20 +196,13 @@ static inline void ssp_pending_del(struct ssp_data *data, struct ssp_msg *msg,
>  	mutex_unlock(&data->pending_lock);
>  }
>  
> -static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
> -			   struct completion *done, int timeout)
> +static int __ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
> +			     bool no_irq)
>  {
>  	int status;
> -	/*
> -	 * check if this is a short one way message or the whole transfer has
> -	 * second part after an interrupt
> -	 */
> -	const bool use_no_irq = msg->length == 0;
>  
> -	if (data->shut_down)
> -		return -EPERM;
> -
> -	msg->done = done;
> +	/* msg->done must be initialized by caller */
> +	WARN_ON(!msg->done);

Generally we avoid WARN_ON unless we don't mind the system going down hard
(which is a common configuration of the kernel)

Is returning an error (and dev_err()) not sufficient?

>  
>  	mutex_lock(&data->comm_lock);
>  


