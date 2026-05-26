Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8989184524;
	Tue, 26 May 2026 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800654; cv=none; b=fhXheNGWPI3ojF4cv7WsQYneEavkedX/T/n5NFxrA5Kv9HXApS6jw3vcou+ncJAmQJviQ/JBmX09ePG9VeM6/eqYpwjabAwJX8MhyHBZl1Yw6x936Xl1WZlx9Zu0tIMHr4lPLthGQ2W94T+eVacW+QPecUshnWBdUBjaX4ZrKzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800654; c=relaxed/simple;
	bh=WBEp8LXSPyNugQH7lmRKEfqw5gJpmNnb63FAfccMDU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIx7j1taEOYddAKctZ1vOpmSAWRxslcXXkYTunedtzI2ORnB5OPyoherDkYxEJN+MhLww6C8O8oG+uHyRVd65f590KMHhSFv3NXWZaSGKs/5t972EsqJ8lQM7JXqs/m+9Z7xKO2N415qPSmq18c09171px7mMRgKjjAep7B8Hx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzMLb/78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzMLb/78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD311F000E9;
	Tue, 26 May 2026 13:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779800653;
	bh=HovolR/b9wulIU4/hf5bIF1VRrIHVypxv7Gto9pYPKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dzMLb/78kWfwgL57Lur691H/F5e2wlZGKOQod8VO2TPWN7yQQxH+fS7B3N8VAnpqL
	 tGzIae3y/oGQhVFYiyjMoKj7H4L0wq/Yc+qv5ldXSuInOUJDeWjpuSLaOSxWiGpie1
	 Eye3X/Vxe7HhcOy97yrVWz/mASsOrGaGP/1j1H/tZuoWC7jAKaIS+Ca8LxNY+WkcVJ
	 1Aqnjgz5cj3RBujWQQeV2x9IILrpqWs52mDlHedrHcNZ/tR2pwUK00RcKf7am81PD0
	 FAIfmgTU8WQ0Ev3pZCjolY+nnxJkyb1FlYTwb5RVMg0KveF3HR2dDHc2BxbBzAxNIC
	 a6NTeb+WyQwow==
Date: Tue, 26 May 2026 14:04:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, joshua.crofts1@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 6/8] iio: tcs3472: use local struct device * for
 remaining cases
Message-ID: <20260526140404.20bc8e72@jic23-huawei>
In-Reply-To: <20260522123420.45495-7-aldocontelk@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
	<20260522123420.45495-7-aldocontelk@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2026 14:34:17 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

> Use the local 'struct device *dev' variable introduced for the devm
> calls also for the dev_info() calls in tcs3472_probe(), to keep the
> probe function consistent.
> 
> No functional change.
> 
> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
Hmm.  My first instinct was to say drop these prints - because 'obviously'
the name attribute provides this information and doesn't fill up the kernel
log.  Except (sigh) it doesn't.  The driver reports "tcs3472" for all parts
supported.   Fun question of whether we could get away with fixing that.
I think on balance doing so is too risky wrt to possible regression reports
so we are stuck.

That brings us back around to this change and argues in favour of keeping
the prints - so I guess we do that.

Applied to the testing branch of iio.git.

Thanks,

Jonathan

> ---
> v3:
> - New patch
> 
>  drivers/iio/light/tcs3472.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> index 4966abf83c18..f74e6633db45 100644
> --- a/drivers/iio/light/tcs3472.c
> +++ b/drivers/iio/light/tcs3472.c
> @@ -480,9 +480,9 @@ static int tcs3472_probe(struct i2c_client *client)
>  		return ret;
>  
>  	if (ret == 0x44)
> -		dev_info(&client->dev, "TCS34721/34725 found\n");
> +		dev_info(dev, "TCS34721/34725 found\n");
>  	else if (ret == 0x4d)
> -		dev_info(&client->dev, "TCS34723/34727 found\n");
> +		dev_info(dev, "TCS34723/34727 found\n");
>  	else
>  		return -ENODEV;
>  

