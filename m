Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2F5329C78;
	Sat, 31 Jan 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879902; cv=none; b=mjp/XbYvU6QAttbHiwb7hmGoKn1oc7lKwP+cYO5HsP22zKN1Ux/VxcsVP5jAiL0szy3waeEnjtR23oWYnr0TuOiDhyTmW3EPqxbI+C1RAx5t1ElPtJBZMp4v9HytRSJHP16XoRennTeQFvjzZlq8Nk67s0sR4gsCGbWOwc8c6j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879902; c=relaxed/simple;
	bh=WExFJwBK0i3+1nziIsVcgTeePaq98ff+XnRCJzmxl6M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9vTABwSOBXXK4qdjiwLCpxwuSxJk7hHZqUKpBtMxbeTwSVwPJt02hzKuh7eI0g2jdK2I20g/vK7XPyYWvHfUM2JY75RcEr5ok9tgTa0nM3gYsbnxcTsqvP38bXPAQx2zaxn19iDzE8Cx4o1cRIwlzvtaRAh8e4kwGOeHDhPkiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4wp78+c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4wp78+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C47CC4CEF1;
	Sat, 31 Jan 2026 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769879901;
	bh=WExFJwBK0i3+1nziIsVcgTeePaq98ff+XnRCJzmxl6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F4wp78+cD2T6Bm8iRcJM+k28/XWiUyVzIcsRQHhf6JnYgeGuvVHfLEfKCRqK91VWY
	 OMV3RWSm7XwYfi8A7jRzCTQ4PLywRrU6PL3qUwo+b9YqmCFdGwCx4qZb7cmIZEUfv0
	 zu88oznc+rDLeD3HCLEHFxd1A5oJbGiyPL5cI5wPQhNzVhC4oRNUD7eCjqkm+TJYlB
	 LjdNJ3spYf45FDIH1FzPhkORfEMkYX18EVwdSvNl8Waf+rHiMPZb/qKIxug90oGsOI
	 B9kPL6kacUUFtBtpmhXTLd7fjsSjsHRyvAgl4cbyUFoeSrE36cT5w9eX7jvvlqL4ez
	 85w7vqY9tV+9Q==
Date: Sat, 31 Jan 2026 17:18:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: SAJJA EASWAR SAI <eshwarsajja20@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, iryuken@duck.com
Subject: Re: [PATCH] iio: light: apds9306: remove redundant explicit pointer
 cast
Message-ID: <20260131171814.4147bc46@jic23-huawei>
In-Reply-To: <531a0877-53a3-46b0-b365-93e0511bbe2e@tweaklogic.com>
References: <20260129210431.654266-1-eshwarsajja20@gmail.com>
	<531a0877-53a3-46b0-b365-93e0511bbe2e@tweaklogic.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2026 09:14:41 +1030
Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:

> On 30/1/26 07:34, SAJJA EASWAR SAI wrote:
> > C allows implicit conversion from void * to struct apds9306_data *, so the
> > explicit cast on 'ptr' is unnecessary. Removing it improves readability.
> > 
> > Signed-off-by: SAJJA EASWAR SAI <eshwarsajja20@gmail.com>
Applied to the testing branch of iio.git.

Thanks,

Jonathan

> > ---
> >   drivers/iio/light/apds9306.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> > index 7e68cca0e..5d18eabd9 100644
> > --- a/drivers/iio/light/apds9306.c
> > +++ b/drivers/iio/light/apds9306.c
> > @@ -1176,7 +1176,7 @@ static int apds9306_init_iio_gts(struct apds9306_data *data)
> >   
> >   static void apds9306_powerdown(void *ptr)
> >   {
> > -	struct apds9306_data *data = (struct apds9306_data *)ptr;
> > +	struct apds9306_data *data = ptr;
> >   	struct apds9306_regfields *rf = &data->rf;
> >   	int ret;
> >  
> Looks good. Thank you.
> 
> Acked-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> 
> Regards,
> Subhajit Ghosh

