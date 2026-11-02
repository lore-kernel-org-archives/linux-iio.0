Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585359;
	b=4EphCydEnVSzEPLQ0GSF8Gi8VJfw0jTZ5eOQ0uz+wyXuIEVs4xnEd/QINm9dx00sWErp
	 aqGcjYjyUtrmxX/w2f5Rbjo2NyUx4fJGsN9zK1Zzv6lzNaIHgi0SvZpE3fB20l/BcXvSx
	 XudsqdTbIvIe3cs4FnHLW2RVA9aRlb5WKgHNSL3xREp69XvRLoBFxL5SyKGulzBR3hM4Y
	 S7Hj07Qbr5ZZHFEte1XLVI1XRdMg8mn6S9sN3WILRlI8/uqhAg9dugY0h52aTVmRy5ltM
	 RSC90um5bUkMTOY0P1WEuxBXtc0gc3BXDpFOqu0aphCA5jyTULXulzxmyauj7HK504Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585359;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zKOjOsYjcefBhBhe3QabbfUBi3pBkOs+cUhrMKJ8yr0=;
	b=ioI2JoGAy2EbRnoizZ+RTer3AjQ4zbpR7dGA/TG1/wipHgGyrtf34uaumEWf7fvlFqXA
	 nzVi+q0VKReGolq8oMQw8s266o7/zSgJQ4i1DfwRbfLhoo3CLnNnUNqXpjZmMuqT/ICnM
	 JDvlYQiGM9bdEFglw1Lb8myg1FfWId8zCoKzcqRZ40xzn2OTyMPKE1yltOMsXUZSyTb9o
	 Ra15KoSnTaKZ5n8C/CQx+YhqWoP3b8FXsxu6QsG0GqpRFVaE+OpcUPB0dJHweSBAPK6SV
	 i5XBTrywKdZzMeWyxDXlplvVQvNGQs/PWugM26ewdhguG3e0nCFbvy+6wrhzFPA2T1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixxaDCrs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7699D606A324
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixxaDCrs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179D41F000C1;
	Mon,  2 Nov 2026 02:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585359;
	bh=zKOjOsYjcefBhBhe3QabbfUBi3pBkOs+cUhrMKJ8yr0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ixxaDCrsnh3Pj4xq8sTCyhrj3hFJ+WXcPsz2ChoPDnSptx0Y4SIf/9T8RWJzDHHRv
	 wYOa12Q7LebAFy2oGZ8HlyyQIa1obsDdj2C5eoTG6DUeYPe5+wV6FZIojvtK4/IsIn
	 VLfhzScyaQ2XLyScBoSQvwatWI227XhZLfEzHZw2dXoMW8R8OMdmpqYYLStNloPcyR
	 ibcF4vFpi7KcD14DLRt1DyCZ8VG5WroRZHm8jR23QzCWm+0Upw3sLgZjm/k8FNDjqQ
	 FYzTIrGwJYrBF8Vxsa3mY65v5XYmrbqeoPP+fqQkLUwZPObcX3dr+/SeoQI/HJZo4U
	 64NM8IDA2CUtw==
Date: Mon, 2 Nov 2026 02:09:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: <linux-iio@vger.kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Christian Eggers" <ceggers@arri.de>
Subject: Re: [PATCH 08/39] iio: light: as73211: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261102020915.4a2fa596@jic23-hlaptop>
In-Reply-To: <DMF96N121S91.1V9U9PV9TT2FH@gmail.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-8-8b136778eedf@oss.qualcomm.com>
	<DMF96N121S91.1V9U9PV9TT2FH@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 21:09:05 -0500
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> On Mon Oct 26, 2026 at 6:05 PM EST, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
> > which is on the stack and local to as73211_trigger_handler().
> >
> > Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> > ---
> > Cc:  Christian Eggers <ceggers@arri.de>
> > Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> >  drivers/iio/light/as73211.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> > index 67f33bbe1c13..675866029cd7 100644
> > --- a/drivers/iio/light/as73211.c
> > +++ b/drivers/iio/light/as73211.c
> > @@ -695,7 +695,8 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
> >  		}
> >  	}
> >
> > -	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
> > +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> > +				    iio_get_time_ns(indio_dev));
> >
> >  done:
> >  	mutex_unlock(&data->mutex);  
> 
> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied thanks,

J
> 

