Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169849;
	b=OPuI7ffwTiiboVziFXNZ5xmlN0urWY9bXuln39BfTRTly+M3FjRGogYOc3aIb1+kEY/1
	 UpjkrtueFcPjcE3e16Nu8Hh8+A7Uotf/DMgDhzcMSSGsTkM+44QFoyhhm4OTcCu5ypDxv
	 icZhegGdI5ZLIkhkjT0+WoJl+g2pi+a02icyeh3V0p6uStegYARZWtj3/zU8HdZIYuohx
	 WTbpSMeiJEfYqKMjHsuTm1sEHkVEYKt4KKi3HimVr8JXckCxepBlVDeW1owtjDhPo53/1
	 P/64tiidRaQ7NVbOolNxviT5sQGU8X3nSv4p/aZ1AEPc4W9SuzoIlqEE2mbXUz33L1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169849;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=U/L8bqmRJvsgcPmWTGdqRpbXnt5j3i3aDLDSgmpwY9A=;
	b=SKuo4wW3iI/qnS/C7nJuKyjgNkJrb5gYRPBdlDbJSTujfZmuOuGiwoDQZRZ3QI030Vtn
	 jQZl/rlGp0rRYq6/USemCVOk+tgXsampCC9R0fqGn+S9onfK51RMc7efQvrfCTtWlhYUE
	 R7JjRWEGTPHvy5mBLUNA0g3STg/nVSrSOKnKVjuE8OP7j3JLegRQ+gK8tuovOQvAw3xbU
	 Zt0bCINblisjhKg9roR28aoNnJA92OKcZpiJAc1xuOYPPUfixntIk0FRiBFmcB973UyJe
	 LaJH9gCGp7ZZaPesf7la7x+yemxuxXp3G41IcwCRwPtHfzWO65S2S/jesol2Ua+NXjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnU5VI1t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D666D606E532
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnU5VI1t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BCB1F008A5;
	Sun,  8 Nov 2026 20:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169848;
	bh=U/L8bqmRJvsgcPmWTGdqRpbXnt5j3i3aDLDSgmpwY9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cnU5VI1tFeys4svB80Opp9B+SdQT4DkNPF3ic1VPyl6PiPQEgTD35p7Xq7rz97Yk3
	 /7JyRoa1j0e4fkbzqnu5brUwpvx15wmn/csd4Rhl/sWFr22qggA9kV4KJ2uCaagygy
	 5MUVU99eu97HurA11SDoS0y3ruOKNRqJiv9UY/9ZifiBk3l2qj0wdHggqhQrpSVXAs
	 UXEnuf/sTeMVHu+HRW5qQkcooQIXLMho1Pt6gmUIUDFt92OMyFJE+Xw9yW8YVnj5Sm
	 piT/iuFbAkSmlsUda8aDCxzj+FIgU1tnhVOyygQ9PjV9Rz4o9fWdGFzOHe6ATi8Lqw
	 25WCiMS6rKo2Q==
Date: Sun, 8 Nov 2026 20:30:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Francesco Lavra <flavra@baylibre.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>
Subject: Re: [PATCH 38/39] iio: imu: st_lsm6dsx: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108203041.2ccd3e40@jic23-hlaptop>
In-Reply-To: <auCDIxUsvEO_gsvY@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-38-8b136778eedf@oss.qualcomm.com>
	<auCDIxUsvEO_gsvY@ashevche-desk.local>
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

On Tue, 27 Oct 2026 12:55:31 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 26, 2026 at 04:05:56PM -0700, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.  
> 
> ...
> 
> >  				if (gyro_sensor->samples_to_discard > 0)
> >  					gyro_sensor->samples_to_discard--;
> >  				else
> > -					iio_push_to_buffers_with_timestamp(
> > +					iio_push_to_buffers_with_ts(
> >  						hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> >  						&hw->scan[ST_LSM6DSX_ID_GYRO],
> > +						sizeof(hw->scan[ST_LSM6DSX_ID_GYRO]),
> >  						gyro_sensor->ts_ref + ts);  
> 
> Seems like a lot of code duplication in all three cases.
> But yeah, it's out of scope of this change.

True.  Maybe worth someone taking a look.

Applied this one.

Thanks,

Jonathan
> 
> >  				gyro_sip--;
> >  			}  
> 

