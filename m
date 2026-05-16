Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A4C2512C8;
	Sat, 16 May 2026 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778933146; cv=none; b=AdgfZ3WuHOk66v10+jgmAEGSUikujkguT3SaE55lQjm7VNiwiEAec2hmg76vLTbYqkegKbe4eKxALFRn1d9Y5zLOOuuURTKaiLiyg+i4zW6QPBJkhJ4TictQN+Z3QCU/w6+ky+w+DfcdJuUbV8/2+EjzOM8xtyWHQpRjEPNeUTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778933146; c=relaxed/simple;
	bh=01E93VuwcKtZ7E+/DAQx7k9fej8i4Dune44yON6LYSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mmxT0nI64in1GOUMTdANRMkNwsfqPRlUK2MD1pDzzd5nEH9D6EhhyyeHmtZwXQQ5TO1Up4fhraBrAG8r7z+v/kxelcNOhXZ7GretgGgV+VgcB9ldpGYgDJgpGp9b26Hly6EzppLdLjMCgaroBkBYj+eRbWvomtP4jqJw4TPF5Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sXzm/2BP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sXzm/2BP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6039EC19425;
	Sat, 16 May 2026 12:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778933146;
	bh=01E93VuwcKtZ7E+/DAQx7k9fej8i4Dune44yON6LYSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sXzm/2BP8IXIc7Zrx1HgpUOh/uxSSkJNYB7BR5Ejyi+kG6S8/gd3TiAXQB+vVbiuQ
	 Dn88YD5ZYf3LlaRRTTfGzaoD6sK6NXkPPilCtJ4KN2Xg6AB62QYotE92rxi/od7Iez
	 gKYZ0dheWWl+DpCoMJObRioMG+MjVL/dpOH7UWiYSYhkINVIYk8dkGxMC08TRWtz0h
	 LPYlKW2tUfI+KhMwhLXrxuRPVT1uXeiAg6X38WUs2wV6i+luQtp74S5HkhCLwSclYH
	 lZFK/JDLFDodYKLEDv+4jPGjeLX/bR5ZykYxClSzij3k5u3NmShtGoNQ4LBcvAJOpO
	 3TR3tDijwkBnA==
Date: Sat, 16 May 2026 13:05:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Alexander Koch <mail@alexanderkoch.net>, Michael Hornung
 <mhornung.linux@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2 08/10] iio: light: opt3001: move driver to
 guard(mutex)() use
Message-ID: <20260516130537.78255297@jic23-huawei>
In-Reply-To: <20260512-opt3001-cleanup-v2-8-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
	<20260512-opt3001-cleanup-v2-8-8018cf3a8a0a@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 12:57:28 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> Move driver to use guard(mutex)() macro, to facilitate automatic
> locking/unlocking of resources. This modernizes the driver and
> improves code style.
> 
> While at it, remove unnecessary gotos and return variables.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
A couple of very trivial things where I'd have done it differently.
I don't mind much however if you want to keep it as is.

> @@ -615,18 +601,12 @@ static int opt3001_write_event_value(struct iio_dev *iio,
>  		opt->low_thresh_exp = exponent;
>  		break;
>  	default:
> -		ret = -EINVAL;
> -		goto err;
> +		return -EINVAL;
>  	}
>  
>  	ret = i2c_smbus_write_word_swapped(client, reg, value);
> -	if (ret < 0) {
> +	if (ret < 0)
>  		dev_err(dev, "failed to write register %02x\n", reg);
> -		goto err;
Similar to below.  Though very much a matter of personal taste - I'd
definitely not have asked for a respin for this alone!
> -	}
> -
> -err:
> -	mutex_unlock(&opt->lock);
>  
>  	return ret;
>  }
> @@ -660,7 +640,7 @@ static int opt3001_write_event_config(struct iio_dev *iio,
>  	if (!state && opt->mode == OPT3001_CONFIGURATION_M_SHUTDOWN)
>  		return 0;
>  
> -	mutex_lock(&opt->lock);
> +	guard(mutex)(&opt->lock);
>  
>  	mode = state ? OPT3001_CONFIGURATION_M_CONTINUOUS
>  		: OPT3001_CONFIGURATION_M_SHUTDOWN;
> @@ -669,21 +649,16 @@ static int opt3001_write_event_config(struct iio_dev *iio,
>  	if (ret < 0) {
>  		dev_err(dev, "failed to read register %02x\n",
>  			OPT3001_CONFIGURATION);
> -		goto err;
> +		return ret;
>  	}
>  
>  	reg = ret;
>  	opt3001_set_mode(opt, &reg, mode);
>  
>  	ret = i2c_smbus_write_word_swapped(client, OPT3001_CONFIGURATION, reg);
> -	if (ret < 0) {
> +	if (ret < 0)
>  		dev_err(dev, "failed to write register %02x\n",
>  			OPT3001_CONFIGURATION);
> -		goto err;

I'd return ret here

> -	}
> -

Then return 0; here

Makes it a little easier to spot the good path.


> -err:
> -	mutex_unlock(&opt->lock);
>  
>  	return ret;
>  }
> 

