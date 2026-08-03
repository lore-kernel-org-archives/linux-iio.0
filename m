Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83535377AB4;
	Mon,  3 Aug 2026 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770965; cv=none; b=ccKIS5AbKmCfvbJlXVXOH7oE3ZrLkNBYhArkCxl31Z8ZfPNomNtLk8NU2fRSEFDzgqLv7D00WR3Me7DM79tZO4oSTPzW54Q10b4Ic4hReN5UwZcd1jPVUuBU5P8sJQYP5aWCnalV3L5TDaqmdZmH0AGnlnsDVMKA0FlFX9PuQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770965; c=relaxed/simple;
	bh=m4lhw/Jv2cOGVKtxwDMFYaL3S9AWYvh2eqbd0iICxjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVCToO66Hja+HPlKcWtu3qfaMKFqJ7b9VTwhhJmQLAgpkXxW11tmRyQXJxUlfIgvjvlW7hE2b3PBU+xnyd6OQ53NnHABtHL0Cmh+Zk34xUFmon93xF0pQ2j49Fsv87HT71i8ap3Ap6uOzyEhIKHlQjWWByTV+WtRfLTa+wsRAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g3gghL9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g3gghL9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF541F000E9;
	Mon,  3 Aug 2026 15:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785770964;
	bh=vrm66Ol1+5+Gj10RQNk/dwLlIabIRjgIc07UDVejGWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g3gghL9Rp3pK7blXfGt+soMLcNc21lC9ExNTfbmZw6UHw2bjygZufu1tk6t7B0EhZ
	 yblyxb4a3LwFIjHx79v1rzkWk+uP471LIlEqGVrL21iYZAH5U2M13YKRz6hrSeQpGK
	 x98mrqCE+7E1Ed9ZgptCBhbgQquNRTZRier7WOPA=
Date: Mon, 3 Aug 2026 17:29:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 1/2] staging: greybus: audio_codec: fix sscanf return
 value check
Message-ID: <2026080313-dubbed-palace-d33e@gregkh>
References: <20260803134346.6733-1-abdelnasserhussein11@gmail.com>
 <20260803134346.6733-2-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803134346.6733-2-abdelnasserhussein11@gmail.com>

On Mon, Aug 03, 2026 at 04:43:43PM +0300, Abdelnasser Hussein wrote:
> Smatch static checker warns:
> drivers/staging/greybus/audio_codec.c:335 gbaudio_module_update()
> warn: sscanf doesn't return error codes
> 
> The sscanf() function returns the number of successfully matched input
> items, not a negative error code. Compare the return value directly
> with the expected number of conversions (3) instead of storing it in
> 'ret' and returning it as an error code, which leads to returning
> a positive value on failure.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Closes: https://lore.kernel.org/all/YoOLnDkHgVltyXK7@kili/
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
> Changes in v3:
> - Split from the previous v2 patch into a separate patch.
> - Updated tags to properly credit Dan Carpenter for the smatch warning.
> 
>  drivers/staging/greybus/audio_codec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
> index 720aa752e17e..295222ec0f1a 100644
> --- a/drivers/staging/greybus/audio_codec.c
> +++ b/drivers/staging/greybus/audio_codec.c
> @@ -311,8 +311,7 @@ int gbaudio_module_update(struct gbaudio_codec_info *codec,
>  	}
>  
>  	/* parse dai_id from AIF widget's stream_name */
> -	ret = sscanf(w->sname, "%s %d %s", intf_name, &dai_id, dir);
> -	if (ret < 3) {
> +	if (sscanf(w->sname, "%s %d %s", intf_name, &dai_id, dir) != 3) {
>  		dev_err(codec->dev, "Error while parsing dai_id for %s\n", w->name);
>  		return -EINVAL;
>  	}
> -- 
> 2.54.0
> 

You didn't cc: the staging list?  And the blank line above your
signed-off-by isn't going to work well.  Please, when you split patches
up, be mindful of what tree they are going to.

thanks,

greg k-h
