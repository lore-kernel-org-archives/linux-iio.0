Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B1385D90;
	Fri, 29 May 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076091; cv=none; b=Ts9WHIXhXc/rsn/15t2ctdxDPRV3zWd+v/TzJ3+epQxMJ4mDw1krYqlPqCtA1y8O5Sn5zg7QKogeE9WtPvsdaNXNDzOLscg+7WwZa/uBq/+HpdbvMOOMQe1inRrlkJsvgA0uganjG/IBcMm21cF2s+xaspCzccneIx2Q6lwI4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076091; c=relaxed/simple;
	bh=CymR6iBs3HpAtIg2+u4eHhfAVrXWyWgXqtZxOVjzr5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXIDrNVom6PnlJGF8id+KCntzi1DN2Js9zJmH6bMr/98syXQIOSmTEUzzBnYWN8rf8KGcs+XVTH+gVH2Rtg4HdSsJrO+7Bp7C+lAggLIvRaR2fWqdYDCIpBTGOVO1OKRHTJhuHGtgZtO0Zzva8Z8qQ0v70nq3S/zvxdck6Rrgxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md7XoMIY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md7XoMIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50DD1F00898;
	Fri, 29 May 2026 17:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780076090;
	bh=QSDqERmV0kE5b4P/SfODYq3e+QDRq2yPDgv7/9QcgIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=md7XoMIYAyZzYEPkHGq8uHrumL6of/ZJTFo8mIpASFr2VfcuLyp8xM4m83y/yQZvp
	 FlU02fFRS/rYoibygfg6cWsWwpoirkcDPvzjXUjkOGeev28/JoQF2kPIB31aWKMx9w
	 ykDw8lLbk0RspLdjUsw1O7nPRMpjHYEgnZScLNpgAAaV3hu97qCLh6j8V/mPZULPE/
	 XAx6TnD+PTGiihatXX+SiiyIfzEiN9b9rxXVBPKek7B8nTBA+0KO43QMgHlBQhdOaW
	 LInCTbFRFNCxOSYZQXHlntJ70eHbrcH2MQz6DJcu309amE73Nk7fFTFWbKIQhaqDj/
	 32mRspAHyvNXA==
Date: Fri, 29 May 2026 18:34:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1015: use devm_pm_runtime_enable() to
 fix probe error path
Message-ID: <20260529183444.3ae7d4e2@jic23-huawei>
In-Reply-To: <20260529101011.3030-1-sozdayvek@gmail.com>
References: <20260529101011.3030-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 15:10:11 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> ads1015_probe() calls pm_runtime_enable() and then iio_device_register().
> If iio_device_register() fails the function returns directly, leaving
> runtime PM enabled and autosuspend in use. On subsequent probe/rebind
> the runtime PM tracking complains about an unbalanced enable.
> 
> Switch to devm_pm_runtime_enable() so the enable (and the matching
> dont_use_autosuspend) are torn down automatically on probe failure and
> on driver unbind. The manual pm_runtime_disable() and
> pm_runtime_set_suspended() calls in ads1015_remove() are no longer
> needed and are dropped; the devm action runs after .remove() and now
> handles the teardown. While here, convert the dev_err() + return to
> dev_err_probe() to follow current style.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index c7ffe47449e2..2331e946c519 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -1037,13 +1037,14 @@ static int ads1015_probe(struct i2c_client *client)
>  		return ret;
>  	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
>  	pm_runtime_use_autosuspend(&client->dev);
> -	pm_runtime_enable(&client->dev);
> +	ret = devm_pm_runtime_enable(&client->dev);
> +	if (ret)
> +		return ret;
>  
>  	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&client->dev, "Failed to register IIO device\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to register IIO device\n");
>  
>  	return 0;
>  }
> @@ -1056,9 +1057,6 @@ static void ads1015_remove(struct i2c_client *client)
>  
>  	iio_device_unregister(indio_dev);
>  
> -	pm_runtime_disable(&client->dev);
> -	pm_runtime_set_suspended(&client->dev);
> -
>  	/* power down single shot mode */
>  	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
Hmm. Looks like this is undoing the setting of continuous mode just above the runtime PM
stuff. That isn't done in the error path but should be.  If it were then there would have
been a goto for that iio_deivce_unregister() and it would have been obvious the change
here would break the ordering.

>  	if (ret)

