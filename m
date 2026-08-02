Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA15393DDB;
	Sun,  2 Aug 2026 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785689341; cv=none; b=m+7bhoYga2maXvdQoz0GWsGc08wb3mpS/2E/CXwmL30krKppj3KH1BC6kEZSkf0cwdySzK6gd1WOMoZZuqnVLq7I4Y5EzmBHrRh49q86wRgoaC4jLix4rD6kpelVOfMnArzdZK2bzUael5Gp3r1HTBG2G2DnF1s655CWyTzGPAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785689341; c=relaxed/simple;
	bh=Cr1ZFxOMRtgz1RCCnrhEvGb2ANQ2dvbN4+WoRSTjFOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTWmMI07nD0lzSzwd0ZFBHuLJT1/Me2qdGbHdJ+IK5qCdK+Br0vUInD/Uqaz+RacUcwzU/c6othQXnnDsrIaeTkHQrG4sgd4OPRkT5n5Xg8Kz41Sulp9idtrLr5AfRl9SGoyQXXO4M0EAt7W+bcgey4RRx3PInbzxT+5E+BJKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epVjggDw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epVjggDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626231F000E9;
	Sun,  2 Aug 2026 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785689340;
	bh=0Y1fcC92OPzO6IGbx2YFqC4KQawf2hE/SYYvDe/4ll0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=epVjggDwWTOZiFua7b2xCJzGhieerv/lpOgbQwLbe8kqQJP5pA1AUT89OVauOIniu
	 EHWJX+S+ZNmm8fkv9tjtprF+vKksPlZwe74FNo0C0DBKgtEVf9N5DwvIpZFv+dLTA1
	 z3bwXNQE15Jv4NgIZkyCfPv4mMhIwe9TO7EnKOzfVG+NM2Nh6S8SC+TUF/uu6/HDuc
	 Sb7UiEyRUU5i9R7KfXTXQvF0mArMSMoTDk3V1jJN+oZAPk4eNkdJoHCLvykzdpzrYa
	 MfR4pQDBy38fCFHOjpww301uJatj18VBKnwy6OzE7nEADS9X0QG16t876yrwXNIsvl
	 tXPFMK3T5UoAg==
Date: Sun, 2 Aug 2026 17:48:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: joshua.crofts1@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, u.kleine-koenig@baylibre.com, email@sirat.me,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] iio: chemical: ccs811: cleanup checkpatch __packed
 warning
Message-ID: <20260802174857.3118d263@jic23-huawei>
In-Reply-To: <20260802022559.23138-1-adinata.softwareengineer@gmail.com>
References: <20260723235312.432a895c@systembl0wer>
	<20260802022559.23138-1-adinata.softwareengineer@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  2 Aug 2026 10:25:56 +0800
Adi Nata <adinata.softwareengineer@gmail.com> wrote:

> Change instance of __attribute__((__packed__)) to __packed per
> checkpatch.pl warning.
> 
> Reported by checkpatch:
> FILE: drivers/iio/chemical/ccs811.c
> 
> WARNING: Prefer __packed over __attribute__((__packed__))
> +} __attribute__((__packed__));
> 
> Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
> 
> v2:

This needs to be below the ---

Also please do not send a new version of a series in reply to
an earlier one.  

1. Leads to very confusing threads if there is much discussion.
2. Means your patch is way back in any reviewers inbox as sorting
   is typically be date of first mail in thread.


Thanks,

Jonathan


> - Rename commit message to include driver name
> 
> ---
>  drivers/iio/chemical/ccs811.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
> index ce7187ccd706..0e5c79b775a2 100644
> --- a/drivers/iio/chemical/ccs811.c
> +++ b/drivers/iio/chemical/ccs811.c
> @@ -70,7 +70,7 @@ struct ccs811_reading {
>  	u8 status;
>  	u8 error;
>  	__be16 raw_data;
> -} __attribute__((__packed__));
> +} __packed;
>  
>  struct ccs811_data {
>  	struct i2c_client *client;

