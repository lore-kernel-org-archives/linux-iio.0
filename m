Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B923507B;
	Sat, 15 Aug 2026 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786827534; cv=none; b=bTN4DMj0R98iNrJGPlWrVfdetk9nmfyHL4SovXe+YQe/QQdLGxvgTH+Nn0oUC6KKAQ4j9cXoj/GS2WrQNiS/GtWk7WR83+qo5oexys0H9+YhcCoaQh+/NbqkJ240xO5GuXUPkACiX826PM6nEq9qGkTuGhfgbewUYd3jSVoihKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786827534; c=relaxed/simple;
	bh=yLynr8D4izFJ0uFP6sqfAF/ovda1uiUdux0FXLOsEMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZACWxxX8hvBK548jg23VIONHfBB9uJtiuSu46nJqDMO1F0WMF/cLiZ5WeMUZ+D/lFjgrUWNiWlK3GQMOSS71E3574okXMTHi4zkoyhJUPQiA5WgRRtyD8wK7Mnjc1VtqAw7IM9S7jGiVzOqwbpyk6rWoFcemdLo7gOLipJyjIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaCUwBvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaCUwBvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037521F00A3A;
	Sat, 15 Aug 2026 20:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786827533;
	bh=IKz5rypUYrd1YVW5HbgFaxYDhRxBpl4okIDZ76arp8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AaCUwBvF15PmAI0gUcklFdfvwtvkq8e2yEDndfn/77Y+fv3dmH60mg9EPT4Mp2JSN
	 ro3vV27RrX5wMfX9yAWQJ8562BOdCm1ADRP9C84zzVhF7npO2BdqTxToEO49zjPRe+
	 eH3nBa/7hG5FdpnXxCnsUNLDTZj1JcQrn4+1Y8G03rO16XMD89pdRRwGbJNwob/2bA
	 qZVmMK5Tk1rvEEkl1OW80SvR2y880ephAuo2QMbh94sfqQnh4HgnCf92uHHzSEZR6Y
	 OsOn629lxixt1SyEVb6qTriDlyZeUvkXbtUPYX4p87dNBM5mRKj6Wn8PIBYmbu5Ffi
	 Zcqe2EgGoK7Fg==
Date: Sat, 15 Aug 2026 21:58:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Chris Morgan
 <macromorgan@hotmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH togreg v3 2/2] iio: imu: inv_icm42607: restore runtime
 PM on system resume errors
Message-ID: <20260815215848.20d5ea79@jic23-huawei>
In-Reply-To: <20260811103301.1157404-3-lilinmao@kylinos.cn>
References: <20260811020345.950137-1-lilinmao@kylinos.cn>
	<20260811103301.1157404-1-lilinmao@kylinos.cn>
	<20260811103301.1157404-3-lilinmao@kylinos.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 18:33:01 +0800
Linmao Li <lilinmao@kylinos.cn> wrote:

> pm_runtime_force_suspend() leaves runtime PM disabled after it succeeds and
> expects pm_runtime_force_resume() to restore runtime PM management during
> system resume.
> 
> The resume callback returns early if enabling the vddio regulator or
> synchronizing the register cache fails, skipping the matching
> pm_runtime_force_resume() call. Runtime PM consequently remains disabled
> after the system has resumed, so runtime autosuspend can no longer turn off
> sensors enabled afterward.
> 
> Call pm_runtime_force_resume() on both error paths. Keep the first error as
> the return value and report a runtime PM restore failure separately.
> 
> Fixes: 3007c1530f96 ("iio: imu: inv_icm42607: Add PM support for icm42607")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Sashiko has some comments on this:
https://sashiko.dev/#/patchset/20260811103301.1157404-1-lilinmao%40kylinos.cn

I would note that in some paths error handling is best effort.
There isn't always a sequence that leaves us in a remotely
useful state.  So maybe what you have here is the best we can do
even though it is a bit crazy to expect the driver to do anything
useful if it can't power the device.

> ---
> Changes since v2:
> - Restructure inv_icm42607_resume() along the lines Andy suggested:
>   handle the error case in its own block and call
>   pm_runtime_force_resume() directly on the success path.  No
>   functional change.
> 
> Changes since v1:
> - Split the device side of inv_icm42607_resume() into a helper so the
>   PM bookkeeping stays in the wrapper.  No functional change.
> 
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 23 +++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 0da362967f63b..f4ef75da22c76 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -664,9 +664,8 @@ static int inv_icm42607_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int inv_icm42607_resume(struct device *dev)
> +static int inv_icm42607_resume_core(struct inv_icm42607_state *st)
>  {
> -	struct inv_icm42607_state *st = dev_get_drvdata(dev);
>  	int ret;
>  
>  	ret = inv_icm42607_enable_vddio_reg(st);
> @@ -675,9 +674,25 @@ static int inv_icm42607_resume(struct device *dev)
>  
>  	/* Sync the regcache again after regulator shutdown. */
>  	regcache_mark_dirty(st->map);
> -	ret = regcache_sync(st->map);
> -	if (ret)
> +
> +	return regcache_sync(st->map);
> +}
> +
> +static int inv_icm42607_resume(struct device *dev)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = inv_icm42607_resume_core(st);
> +	if (ret) {
> +		int rc;
> +
> +		rc = pm_runtime_force_resume(dev);
> +		if (rc)
> +			dev_warn(dev, "Failed to restore runtime PM state: %d\n", rc);
> +

There is a question from sashiko on whether this can be reached. 
Even though that may be the case I'd keep the the error print because
it hardens us against future changes.

>  		return ret;
> +	}
>  
>  	return pm_runtime_force_resume(dev);
>  }

