Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D64245031;
	Sat, 16 May 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778936107; cv=none; b=hsHZntkomhGGpEhP3XQKFzOUysFplRDq8gfbtGIuBJf3hD+abrmUoUpnZpn4HSpb+bYeQ67/gYX82PlsTAwN7Vfbn+4PZCQmiEeTNETx+cO6zeXJwK2FPlKpLV/DfQAj1izFmN5AcPe8o+cW1ZkZpEeAvXbEcKnSX738I/BnN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778936107; c=relaxed/simple;
	bh=qcZVZXpIXXwHKr/6J/joxkFHPd1JhrYGvCv9ReOuQTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ir1HWH5xLHkd+vSzuDRcrLyn8e6wgauYjDJTc8svSOAyRaOnSN9aj4/H3aeofH3iH5ay8S8SqT0B/w5b4cFfqluSC8rmWm/RvTkKwVFMGrdxAG+HjJm+lkRB6JAf8cCU6QQZAZHx9NqXX9nydzU9CZLz3HFmcA7m2Aa2rASiRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeaD4KEl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeaD4KEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0156DC19425;
	Sat, 16 May 2026 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778936107;
	bh=qcZVZXpIXXwHKr/6J/joxkFHPd1JhrYGvCv9ReOuQTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LeaD4KElobEd0mlaKNDNPiLb6ul7HlfN8WJzoCdN9cUQ/NIMjWp+HFmiVP5roqSDE
	 KHvbKagusqJOLnEPm5cfI+nViyZpwnKq3vsD4hDXcX+6SymlqPniqLXO87vdQs4oar
	 Vd/FfUhQ4lTtL6TshZH9C4sNOgooYke82js3jUSaJjNLGnkrunr1pXpwtQv5SWV2x/
	 6reCFzVzdfn4RRdr0EHpEIiKaZr439Uc/zer5cRmE4OTEzj0Ki9/vXJ8Hcr8S/F2hb
	 1iHkSk/o/qwdoyuOq0KrN2ujwJo99XDUt+Y7dyvqt2rbzeOGE4sI1/9gH29CvusYP2
	 vFFoO+oT6i9fQ==
Date: Sat, 16 May 2026 13:54:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: sashiko <sashiko-bot@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>,
 linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2] iio: imu: kmx61: Fix potential time-of-check to
 time-of-use race
Message-ID: <20260516135458.7a4c3b8f@jic23-huawei>
In-Reply-To: <20260513013638.147606-1-m32285159@gmail.com>
References: <20260513013638.147606-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 20:36:38 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> A time-of-check to time-of-use race condition exists in
> kmx61_write_event_config(). If two threads enter the function at the
> same time, both threads may pass the check and get to the lock. Thus,
> when the first thread releases the lock allowing the second thread to
> start execution after the first thread modifies data->ev_enable_state to
> force returning from the function, the second thread continues execution
> regardless. Fix this by moving the data->ev_enable_state check inside of
> the critical section.
> 
> Fixes: fd3ae7a9f21c ("iio: imu: kmx61: Add support for any motion trigger")
> Reported-by: sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260507223337.48437-1-m32285159%40gmail.com
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>

Sashiko has more to say.. Please take a look.  I'm rather nervous
about trying to fix the bugs it's finding around reference counting
without anyone testing.  

Maybe we can get enough confidence with emulation or stubbing.

https://sashiko.dev/#/patchset/20260513013638.147606-1-m32285159%40gmail.com

> ---
>  drivers/iio/imu/kmx61.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 3cd91d8a89ee..3afa369de3cf 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -942,11 +942,11 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
>  	struct kmx61_data *data = kmx61_get_data(indio_dev);
>  	int ret = 0;
>  
> -	if (state && data->ev_enable_state)
> -		return 0;
> -
>  	mutex_lock(&data->lock);
>  
> +	if (state && data->ev_enable_state)
> +		goto err_unlock;
> +
>  	if (!state && data->motion_trig_on) {
>  		data->ev_enable_state = false;
>  		goto err_unlock;

