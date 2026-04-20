Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124093750BC;
	Mon, 20 Apr 2026 13:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690378; cv=none; b=Q55gzLNgtH9jRQFYqJRqQlt5+vhwWfT8f6k5jODMBi+P876LPfzwMnabSwWBjedIsCVYzwo6+SvLyF0uzAOIheJy1dJvmDTxJNQWAmPHezIhtvl8VL5jX7Y7Z/i3gjT7Sf0kTtIpmFLnIaMTAZCnWhbw6RYGch5qPMTTcycTof0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690378; c=relaxed/simple;
	bh=aVygnoZzWXaB/Bd3/LxS0wJNIpS4jAsA7pC9S52E1dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=thz3Mf14SjiDqvkZ6rUIVWk597V5/hDiKG9ynNVpPjlvkVirMrX7NamBxu96SnOK18UR2/LUGa18/euY+Ft0JZOE4UNCR7BaHW5up2Ei+U53ZmnnHitNbMPDFi8fXeXVfgWM79Sk70epVHM2i/lp2YKWDOrWGx1puNhqPOdrtjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vmdt7GNe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vmdt7GNe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C64C19425;
	Mon, 20 Apr 2026 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690377;
	bh=aVygnoZzWXaB/Bd3/LxS0wJNIpS4jAsA7pC9S52E1dQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vmdt7GNe2/k+1/pm1+R/ple7nW0QeEZRqhM4GKHXGKO6q1cB5T1m6gXP+9weF84fv
	 1DAJS54ggsW96PNAMMQyVS/UNMa7pzwGQ9j/3uAhKZJ7dGy07vRzO701E0JtPMvJdF
	 n++8mV7OnmcvCKEXurKr2OnFMIBq8M0aGaswjeW04mPovED0HW1bKowWrWarodtMvB
	 2LGDSXa3rJy1LVELDMsMr1o91tZHyvF1/7tKjiQfC9ooKCHWe20iG1eMWq971RN9rn
	 mUfioHgiJhDS30lsPm2s2Yh8Wcx6rGlmxAjNDhUHPFnTFJTZsAR8NDXFwrZDz3AJdf
	 3syWXjYcmiE8Q==
Date: Mon, 20 Apr 2026 14:06:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Advaith Neelacantan <advaith.neelacantan@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: frequency: ad9832:  use guard(mutex) for
 locking
Message-ID: <20260420140609.62887df7@jic23-huawei>
In-Reply-To: <20260411072503.106621-2-advaith.neelacantan@gmail.com>
References: <20260411072503.106621-2-advaith.neelacantan@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Apr 2026 12:55:04 +0530
Advaith Neelacantan <advaith.neelacantan@gmail.com> wrote:

> Replace mutex lock/unlock pairs with
> 
> guard(mutex) for automatic scope-based locking.
> 
> Simplifies code by removing need to manually unlock.
> 
> Signed-off-by: Advaith Neelacantan <advaith.neelacantan@gmail.com>

What everyone else has stated indeed applies, though I'm more flexible
if you are doing this part of driver cleanup that is more substantial
and touches nearby code.

However, it's buggy. Read the guidance in cleanup.h and make sure
you understand why.  Note that LLVM will warn about the problem,
GCC currently does not.

> ---
>  drivers/staging/iio/frequency/ad9832.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index b87ea1781..73c47a049 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -181,7 +181,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  	if (ret)
>  		goto error_ret;
>  
> -	mutex_lock(&st->lock);
> +	guard(mutex)(&st->lock);
>  	switch ((u32)this_attr->address) {
>  	case AD9832_FREQ0HM:
>  	case AD9832_FREQ1HM:
> @@ -239,7 +239,6 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
>  	default:
>  		ret = -ENODEV;
>  	}
> -	mutex_unlock(&st->lock);
>  
>  error_ret:
>  	return ret ? ret : len;

