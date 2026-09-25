Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E377714B950;
	Fri, 25 Sep 2026 02:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790304353; cv=none; b=FPr5S4JrQhahAYxUkQFklLvkS6h45EdAoEEy4cOJYOGI+StjqdnIMNZiacANQ5Qz5JZLUlRVVrP2xXUhj1AQ4omdl9stI1t8FjP32Z7Twn6H83LDMJs2yDHI4yq6Yt/WtD9c2OpUdU4EQfVLZPGp6dDWfWpieZ834WYKM3dr1SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790304353; c=relaxed/simple;
	bh=tpkeQ9xiH2j10wNecXXQ9P649vpRm5SBSBR0OS3ASkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K57v5UDXWmZnPcytn9aIWfNudrVTlHgKckM1Z6DbMk8pamq/Z3+e7TBk42NYcCTkk6WJh+w+14fQqhMovdNVGsHyk7/ISQXKfsbjk8d+wuitXsSmz+3AandpvczoRGceXzc6uP0ch4BXyqjIblmlcND6s+Lx4qx76hAz3tJ0Ec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkwHOAcA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkwHOAcA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5908C1F000FF;
	Fri, 25 Sep 2026 02:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790304351;
	bh=GkOiGNQpfd1aL4d5QrgrS/Xr9gr4dzOSCJp2Ldl1+DI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QkwHOAcA/bKoh+9oHzbI5cpy7C9pV9sjoxyHGPvHvtziX3n8eZZ9OojDVnWKHdycx
	 TnPeA7Q/eMMDUhKj7ozkwJmAUh4YTj/5KRY/bqfd/yNNQ2GUU3DTRrVHTWpHJ1RYzx
	 9ZNla/rENxiPiRbp917UaLaJVVOvZ9GIzrnEVKFn0W8ubhZxOQtSNzGrgySQALT4be
	 PgZN5QIdcOqGvDiWNyv3nNKLHqywJCC7jpNrpdrLv6kbDrpLKHC9vyOZNzkn4U8MeN
	 LQSkG4LWs2G7i3PYCPgseubT3i8+5KYcBzCb/B9XE8vxlpq4uBAkz2VQRRHsPZ/AZL
	 lao+ky2r2YBpw==
Date: Fri, 25 Sep 2026 03:45:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Bill Wendling <morbo@google.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 codemender-patching+linux@google.com
Subject: Re: [PATCH] iio: add __counted_by_ptr attribute to channels in
 struct iio_dev
Message-ID: <20260925034548.4a52f3dd@jic23-hlaptop>
In-Reply-To: <63029388-6d24-4fc2-87ac-58c2499a3e14@embeddedor.com>
References: <20260923042825.2558762-1-morbo@google.com>
	<63029388-6d24-4fc2-87ac-58c2499a3e14@embeddedor.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 14:48:24 +0900
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> On 9/23/26 13:28, Bill Wendling wrote:
> > In 'struct iio_dev', the 'channels' pointer refers to an array of IIO
> > channel specifications ('struct iio_chan_spec const'), and the size of
> > this array is tracked by the 'num_channels' field within the same
> > struct.
> > 
> > Applying the '__counted_by_ptr' attribute to 'channels' allows KASAN
> > and compiler-based bounds checkers to verify that accesses to 'channels'
> > remain within bounds at runtime.
> > 
> > Cc: codemender-patching+linux@google.com
> > Assisted-by: LLM
> > Signed-off-by: Bill Wendling <morbo@google.com>  
> 
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks
> -Gustavo
> 
> > ---
> >   include/linux/iio/iio.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 711c00f67371..20505139a61b 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -648,7 +648,7 @@ struct iio_dev {
> >   	struct iio_poll_func		*pollfunc;
> >   	struct iio_poll_func		*pollfunc_event;
> >   
> > -	struct iio_chan_spec const	*channels;
> > +	struct iio_chan_spec const	*channels __counted_by_ptr(num_channels);
> >   	int				num_channels;
> >   
> >   	const char			*name;  
> 

Will be interesting to see if this shakes anything loose.
It's reasonably common for channels to actually point to a larger
array as some variant of a device only has a subset of channels.
Hopefully no driver is using that to be sneaky!

Anyhow, looks good to me.

Applied.

thanks,

Jonathan
