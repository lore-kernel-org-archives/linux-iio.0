Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE925B0AC;
	Thu, 17 Sep 2026 00:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604125; cv=none; b=kbsy2BoWmvnX+dOBHbjCyKv/9ENFVWDdif15AiVb8b8jX2CatnDSjoHpbfR6HcbyY22jsHuxYV+TA+NES8EIsxDQ5EfpN3kAsfcHdcc7H+7FI3s6HrvaJiMic387fx2zASvjkQCJ214iUrRC4+FwwgPURIrSCWC5EC3xGZXKdwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604125; c=relaxed/simple;
	bh=czW/fvrVtqxI4u3KGivAA0dUquI3pNQk2btbCYoYgKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9mpQQdzZjJMiJ+buKYOeNpVDR74xGKYaK30TjzMhTEgeDXwbsva5NVQezA3MU13348YrCkbZbflH0JtRQiw3IKqt9lpvLirg3XEF191cDQjbMIU966EcrF5FSEbcKdNMJI0t8goSeCG61VVBpYvAmA0hUq9bXCpUhTI+31UT+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4hy+MZM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4hy+MZM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDAD11F000FF;
	Thu, 17 Sep 2026 00:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789604123;
	bh=FBD2M7EHU+xk7BgFAzGt5KdnHPiie45TXShxSTbtRCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h4hy+MZMVMNiZP2lByogTdWfeXqlDxT8lNSsQ4Yrfu3+lBwdfakKsyJzfwbV8K20/
	 neyyIC4huCUD78mLtAnGwJ8Wu5oU3jL3tKxRXdltL7GZ44tcIeow/pVHycwv5aONxq
	 zKx+/5R3xdvNL1z0aTQXzjo/Kzx3HSxz47vSdTXVUX2iaiXuziBLu6rD6M+O1eyT1B
	 xwgAUs9zUeASk7XO7XlpvKBEylPa7FkLp6Untf03hNFe+NLDWMAAx0kgrudSH2WZg7
	 35R0pM2hz+Ab0RH4Jm7e4+Gi1bmGypdh59V0tkUsm7r3cvAPekD433zpBdvjR9b6/2
	 78Jq7L3VpdvoA==
Date: Thu, 17 Sep 2026 01:15:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com,
 petre.rodan@subdimension.ro
Subject: Re: [PATCH] iio: accel: bma220: Fix trigger reference leak in
 bma220_common_probe()
Message-ID: <20260917011518.297868ca@jic23-hlaptop>
In-Reply-To: <20260916160823.2082283-1-vulab@iscas.ac.cn>
References: <20260916160823.2082283-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 16:08:23 +0000
Wentao Liang <vulab@iscas.ac.cn> wrote:

> indio_dev->trig holds an extra reference taken by iio_trigger_get(). It is
> only dropped by iio_dev_release() when the device has a triggered mode set,
> and indio_dev->modes is still INDIO_DIRECT_MODE until
> devm_iio_triggered_buffer_setup() runs. Both early error paths return
> before that point, so the reference is leaked.
> 
> Release the trigger reference on the IRQ request and the deinit action
> failure paths.
> 
> Fixes: b7e17ca10793 ("iio: accel: bma220: add interrupt trigger")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

When doing a fix like this send one only and then wait before sending
more.  Also look at the discussions that have already gone on around
this topic on the list.  Sashiko mentions this ever time and there
are numerous replies to why it is a 'fix later' issue.

This is a lot more complex than simply doing a trigger put not because
it is technically wrong but because it leaves us with considerably less
readable and maintainable code.  The solution needs to be proper
devm_ registration and cleanup. However that is complex to actually do.

We have known it was an issue for some time and no fix has been forthcoming
yet.  There are userspace paths to put this trigger at runtime and we need
to distinguish between those registered via the devm path and those that
are not. Only the driver registered ones should be cleaned up.

Mixing and matching between devm calls and manual cleanup is not a solution
to this that I am going to consider.

Jonathan


> ---
>  drivers/iio/accel/bma220_core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> index f32d875b994e..4820d99e214a 100644
> --- a/drivers/iio/accel/bma220_core.c
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -544,14 +544,19 @@ int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
>  		ret = devm_request_threaded_irq(dev, irq, NULL,
>  						&bma220_irq_handler, IRQF_ONESHOT,
>  						indio_dev->name, indio_dev);
> -		if (ret)
> +		if (ret) {
> +			iio_trigger_put(indio_dev->trig);
>  			return dev_err_probe(dev, ret,
>  					     "request irq %d failed\n", irq);
> +		}
>  	}
>  
>  	ret = devm_add_action_or_reset(dev, bma220_deinit, data);
> -	if (ret)
> +	if (ret) {
> +		if (indio_dev->trig)
> +			iio_trigger_put(indio_dev->trig);
>  		return ret;
> +	}
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>  					      bma220_trigger_handler, NULL);

