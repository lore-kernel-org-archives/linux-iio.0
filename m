Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C073C81A9
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936388; cv=none; b=WdeBRtDYVvXVAnmhh3j301zLJRLcOtrEtOPlLjX+Ivnnaxzn25a9jE/IlR55q68Rjo5PMsAgxvTsvNHgZmSTp7j3VAwSiNt0ARxNudIl/FaIpRaEd5UCGnbEdMVlDq7D1z6G80cSUEf5TL6CD7aG2qSRR1iK06SKnDBm6R5LcpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936388; c=relaxed/simple;
	bh=ij2M2kwiOeKDbVQfgMoEAJNmqYl0Dpypsxx7+TfCsrQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc1CzCcR9BVJWQlRWwMMDwE8vX/8TrJIBlfjoo3wnpd2vcG7ba0qJU16ip6+Cd4BCik4LCt60SHeFpICwai8qMhK+mf6kFBCwJtrMY1Dx5M4UJHG/LkihgJ7evrGWla8vbvC4G0mXM4akE1Zo1R6O+RVW2mYCCOOKuVFzRmiNhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0JFgexU; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0JFgexU"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso4425884a12.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 02:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783936385; x=1784541185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XkoqjiJgvj0fIc6sWXvWxf3IczQwvql9N4c4357BiFs=;
        b=A0JFgexUNYl7pPyM4pRup8Pl7+UFV6eQiII/8P0CfTFVryFg1uQaM7YAnk0kVfem8F
         MnIrHXSo+PovyVwN273k+6K63OQOKPusMb08D0atM593GnFLFrX0Ow1zRci3B50ys/+k
         wb8raIcmrpwdy+enh1nLJ/yAVpDklLevUAbMiUOhb4EBeSF8zTGc2LLtDMaCsowa0aCK
         8ig955ObQ0Rtbm01PvE8ZBoBG9d4rsUnbB78r2Wv7o8BHlNSwsAxRQgDlsuU3acfMXqA
         RbN52ZE6r1BimAIH934w61WK5ehL60mnmhJBb/rrhzMAfzw3Rf3Y9b+lQxVJ2WINAr1p
         Hh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783936385; x=1784541185;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XkoqjiJgvj0fIc6sWXvWxf3IczQwvql9N4c4357BiFs=;
        b=BlQxtVxzzMCk/knkQac9Off09ESL7eZrlaB8GIG6hGsGP4mnsvUzCUv126itn3qvhP
         cjpAxNZCrA9of2boNaDl/G68c/dPHHiRoL28UoMj2i1NyCAZlwfIQZT2YnW4HGVfxc29
         C+g2pDUHpyo2V19ziX6fqbjWH2wsGeheDsEBgUhUqG9mvc3N4BcskG2mAvYhHGxrxaR6
         /avtr4gwlUFourrHBSUDaRe0aUqaKXS97D6JwEBbUEA8Gpi85Gybt8dCS4juEyz0Qfu0
         PIn2FNx4Z7h9h874skBkbDRGcl3NxtuauV6+gqhTtG2szN7KHxpzYRPm0kesdsOyDWlv
         n76A==
X-Gm-Message-State: AOJu0YzISaEgHh1/cUML6rGsPy8UJl+Yxc370Moz/R/0Bs4ktHsA5Oko
	ATly0iOS8lhVkuac14oY5njSTEE0dPgFiVW+cKW7f2LdfQSJj2q3BBoK
X-Gm-Gg: AfdE7cla1Uz9HYcbIkpw1qUzPSpoqJgg65OTicKDeL+ueTXv+GL+LQpPEAWwyx/YFe4
	sdTOoBgr+sAIPh+dEUSu9rEHwk27cFaGdQGtodvhJQymY7WbmlYicWEMvS5BPHulE58SKAh4umN
	Jhhx2zIuP6h0RxS694MxvDltpVNLjnI6uBLGXdnl57XMbQM8QEArCYYYu+UWmzhjW6RKDM0TyTd
	sHOeg56UV2sYU9O3nnrHC28RnUshVFDZTOmgMSGOWntZB2olI3NidkXB0aiLr5JNxsq5SnI8beJ
	j6eMFSRRWlyKH70RgrmQHbIZCoqPP5hR/l6xwmWVRSWEAeKpbjfndsXzmAwa8ass8qhj6NFBzv/
	31LRVWs0LY8e5rwchJCwqpKkyIZud/f4N0Pq3t1gBUe2aUMT3GqDDoU8PZ6r0qBNpUokFLwDNVV
	K3kQ9WNcxGlYrxl9ZAM/WXNyB1zFIE5qZ1hnaHbwvkiwhAKKfzmJiL2OB/amopvNa5fZdEmmHSc
	ocCnd2LOLBJsvtaW8lIzEKVLvo=
X-Received: by 2002:a05:6402:1e8c:b0:698:7485:3f12 with SMTP id 4fb4d7f45d1cf-69c5f0eafb7mr3910232a12.24.1783936385138;
        Mon, 13 Jul 2026 02:53:05 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69ac41d7ceesm7759429a12.23.2026.07.13.02.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 02:53:04 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 13 Jul 2026 10:52:56 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 07/17] iio: test: add kunit tests for channel prefix
 naming generation
Message-ID: <egyms7ulkxsgu4pvfkoruelec3sf6ca4bndcuqkvxljrdluqwu@edlqne7oy3xs>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
 <20260707-ad9910-iio-driver-v7-7-a4ec30f63700@analog.com>
 <20260712020928.2c8d1667@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712020928.2c8d1667@jic23-huawei>

On 12/07/26 02:09, Jonathan Cameron wrote:
> On Tue, 07 Jul 2026 15:04:28 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add a KUnit test suite covering __iio_chan_prefix_emit(), the helper
> > that builds IIO sysfs attribute name prefixes from an iio_chan_spec.
> > The suite groups cases by the enum iio_shared_by mode it exercises:
> > 
> >   - IIO_SHARED_BY_ALL: produces an empty prefix.
> >   - IIO_SHARED_BY_DIR: emits direction only ("in" / "out").
> >   - IIO_SHARED_BY_TYPE: emits "<dir>_<type>" and the differential
> >     "<dir>_<type>-<type>" variant.
> >   - IIO_SEPARATE: covers the full matrix of indexed, differential,
> >     modified, output and extend_name combinations, plus the two
> >     documented error paths (differential without indexed, differential
> >     with modifier).
> > 
> > A final case exercises the seq_buf overflow path by passing an
> > undersized buffer and expects -EOVERFLOW.
> > 
> > Because __iio_chan_prefix_emit() is static, the test translation unit
> > is pulled into industrialio-core.c.
> 
> Isn't there some magic route cases like this that makes it non static
> only when self tests are enabled? 
> Claude tells me to look at include/kunit/visibility.h

There is, Although I think that using

	#if IS_ENABLED(CONFIG_IIO_CHANNEL_PREFIX_KUNIT_TEST)
		#include "test/iio-test-channel-prefix.c"
	#endif

was more straight forward, less invasive and easier to change than..

	/* In "drivers/iio/industrialio-core.c" */

	#include <kunit/visibility.h>
	...
	VISIBLE_IF_KUNIT ssize_t __iio_chan_prefix_emit(...)
	{
	...
	}
	EXPORT_SYMBOL_IF_KUNIT(__iio_chan_prefix_emit);

	/* In "iio_core.h" */

	#if IS_ENABLED(CONFIG_KUNIT)
		ssize_t __iio_chan_prefix_emit(...);
	#endif

	/* In "drivers/iio/test/iio-test-channel-prefix.c" */

	#include <kunit/visibility.h>
	#include <iio_core.h>
	...
	MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
	...
	// Use __iio_chan_prefix_emit() in tests

> 
> Very nice.  A couple of really small additions requested inline.
> I might well have missed where you exercised the corners requested though!
> + I'll need an Ack from Lars for that maintainers entry. I'll guess that
> Lars won't give one as not very active at the moment in this area.
> 
> Jonathan
> 
> > 
> > Also, an entry is created under MAINTAINERS dedicated to tests for IIO
> > core helpers.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > ---
> >  MAINTAINERS                                |   8 +
> >  drivers/iio/industrialio-core.c            |   4 +
> >  drivers/iio/test/Kconfig                   |  14 ++
> >  drivers/iio/test/iio-test-channel-prefix.c | 246 +++++++++++++++++++++++++++++
> >  4 files changed, 272 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 2b1ec46c5919..57ffc0dcfdb6 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12634,6 +12634,14 @@ F:	include/dt-bindings/iio/
> >  F:	include/linux/iio/
> >  F:	tools/iio/
> >  
> > +IIO CORE KUNIT TESTS
> > +M:	Lars-Peter Clausen <lars@metafoo.de>
> 
> I'd need an Ack from Lars for this entry.   If we don't get one are you
> fine looking after this without Lars listed?  

That is fine, will drop his name.

-- 
Kind regards,

Rodrigo Alencar
