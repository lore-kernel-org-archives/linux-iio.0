Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846523;
	b=bYBJaaojfXO1HvqEo+NVDHfYJjn9FV9GAXNjaYwugGszh2HXHA+7rlXYD+jtttaEehE/
	 Bf13kXVc14g2KmS4GR6JU5meq8sDKKQIjo1sjNUT7LrAzI9s5PPiV086Bqxfj+E5J3Mb7
	 C/Nj5HcAwjXzijlsqkV3iXjhv115y8jkySwUmiFmMxa+rNQqCf8YHvM4h1odYhaHXLo3V
	 +jGQ3WmugeQh5icouV+LRC25egV2wGUFTntnR4UwdnkP9m+sLXsRDfhUj/epkaQAciM+9
	 hhHNtiVVVnAvLm7vTx+2M4S/+pcsF8kvAoaMWjvSCITLdyLHB7pDpeqe1/JkFVnYPbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2+nzMcVP/+P9vG+E1zkKZ9XZsaAgRds940lbNhNpcpI=;
	b=38Poct3mdCkv2TDB9NM5bExrBfuvzMqagtI1OEIvHwCOxsfoUtHqcx2MdZlCYdF9ZvdZ
	 Ip2NupNoCeqgZ57hCNaES4wXHLRK4CUrPi6SAsd1Nm6cZ2WNbE/lg4dnBqehyq3cs8KgA
	 Oolynk7CF89VPqd0YQEkf3PSEURtgVsVPLwQvLWS3mrzvCpu4OQzMkj/qBXVFKFeV7G08
	 XOIkePG4qIgVRQotnBppbuRNPyFiu5P5Su6xmjpgadUf6QWOWMPIfV0VXSD61QSTw4Hq8
	 qjpe6Oi6iJlEc0kV/SDeq1CCOC7pB5Miq2S/Vgpppx0jkUtcLou5ZDewEg7IfeoO3vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DgGsa1h5;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58EF606A32C
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 16:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D58EF606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DgGsa1h5
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a210470b49so30337615e9.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 08:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794846521; x=1795451321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2+nzMcVP/+P9vG+E1zkKZ9XZsaAgRds940lbNhNpcpI=;
        b=DgGsa1h52Rts8iMQsAM4EJfolE1WumuJFMv+MANoxbtXJXUOJKjkXxqF7F52ddwi4B
         igJl8Rh2ip7GVy8wPhlLKhruAujaQotXx1zhJlK/t1l3kKd7ciRnftPamiLQwevK64Bt
         k8APXM+6MHR6p9gPx61Vp76+p/B521PwanYfwN3htVEnEoonaZ23QL33BIDUw3R+yf4d
         h4IbGGGBRAapLvL8Rlc4TNDPbcyxFICIxnJoPuMIWyJ/Ovt2fCzL+Zl6ikJ+w7CHqluQ
         Ayy4mBCMc8Z7wwVKi76I1WC/0L03NnAnS2aMKpMAIs0mwzZilY4SpSvU/4y2CBxtQROJ
         IW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794846521; x=1795451321;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+nzMcVP/+P9vG+E1zkKZ9XZsaAgRds940lbNhNpcpI=;
        b=dJBxL7UN6LNtR9ZKr9xAQuMN65xvvmzA+ohX59HQrIr6UbQZFHtvGerAfQloyaBZ0T
         wl8YwzP0m7e/bAEDKuPinEGJHzyMxCOfToxFQ9/j8I6fjOFDguiiHmctvXKw2p3ns2Kt
         7m8sSYWe+n/B3CXa1hlLfcgQMX+RAREEXjnPgpjJH8Ur0ckLGTcrIDgkpZVoFvyE3WQz
         U/NmvoVRLhrot5XmzVpaYPMpzsgS3WasdJiNNLSa0NuCZdVjDUvvXGAq3EMJQ8S06TG7
         DZEvTs0qFYnLU3Q8LNZwvXVOyTp9dVixw5/Ss7dpP2SOblLJCRVBZ8xEpEdnEANCXWWf
         7vlw==
X-Gm-Message-State: APuU4Z/8XW3EdIZnaGpmkt6YnohzG7GWP6Q6WBnh7/YDfRKFm64+fTDT
	h7p6TIdFLwoCtqC7hcPsBitgZhO1Al0MI8j9kpLx2Bc3LKi1ToDB7V4X
X-Gm-Gg: AYBFou1X2LVOuH5JDNz1yULDRIn6QWlhB0PHHdZo6CiUsKUAUVPIMrgxQH4HiDLrMy5
	a5mgOWFgu+LwzNGUYYrRQJNu86kmNEfQwxDQ8ioFoLwbebf3xe4pyJNvFvS9drqQBTuLuc8TSbu
	vUrLC4k1+zQxpWk7w2jciyQjWvQboLFFrX8z4h0uN9/brz7JJPbdjdhxO0yESzsDl66RlTkAqxJ
	/BHIAeWaBwMPJAaN4Ck8ymLkpo9aaR8kDu45qJxkHjjZsa91VvktXKZqG4GVLyyaBbonQd+McRd
	KPn3b+/PGMP6UHytG70vsxPKyGgUY8kQAJKmgI9eSkXeBPen+Nn0riSgifyTT47ktqiv3/O7YvF
	yGEPLi43pC+cm+idxb9hQZkUfa5GAxWNi3U99qIWlFjCIEeHD6eUhnpsr4/D35NnxHxBrb2XN/6
	cCu1f9TtGFy7igYNrb+xa1t9VSrncM8Sx9hCvsnFJvJod4zDAa7WfjFPoRQu6f0ixv1HjQa8/6g
	edH9XwHXk5LUgfFqSFhdpejrYRzHhQmaohzYqq88qJm6Uqlzr137qTwbRJshMmTg+yI9FtUrTnu
	9GsGVNpjnU7RoxhjohXAF34tlmP/zxXDX84jgFuOYNdmU0HyG672mVP84gTcJJHlHT2a+aC5Je/
	pQCyTX3emV7utcoeBNXrLiKu8p7qIT1ctZVSsDgNXpGiWO2ojy+g=
X-Received: by 2002:a05:600c:3e06:b0:4bb:6947:3e1d with SMTP id 5b1f17b1804b1-4bb6947426bmr119351755e9.20.1794846521012;
        Mon, 16 Nov 2026 08:28:41 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm412165885e9.15.2026.11.16.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 08:28:39 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 16 Nov 2026 16:28:32 +0000
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-doc@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 08/10] iio: frequency: ad9910: support iio backend
Message-ID: <ika7dmfhhue7il5xgbgx434vjxdwj57dz6kebaossw32vym7nt@gmpxjkkqirgz>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
 <20261103-ad9910-backend-support-v3-8-0e9224ddf7b7@analog.com>
 <auoRUS-tsK4X0KoU@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auoRUS-tsK4X0KoU@ashevche-desk.local>

On 03/11/26 18:52, Andy Shevchenko wrote:
> On Tue, Nov 03, 2026 at 11:53:04AM -0300, Rodrigo Alencar via B4 Relay wrote:
> > 
> > The AD9910 parallel data port allows modulation of the DDS core parameters
> > at up to the PDCLK rate, which requires a high-speed data source. Add
> > support for an optional IIO backend that provides such interface, with
> > data streamed into the device through an output buffer.
> > 
> > The parallel port channels get scan indexes and scan types according to
> > the data destination: 14-bit amplitude, 16-bit phase, 16-bit frequency,
> > or the 8-bit amplitude and phase pair for polar modulation. As only one
> > destination can be active at a time, this is enforced by the available
> > scan masks. On buffer enable, the destination is configured in the
> > backend and the parallel data port is enabled. The sampling_frequency
> > attribute of the parallel port channels controls the backend data rate.
> > 
> > The backend is also notified about profile changes, as it may drive the
> > PROFILE[2:0] pins, and the debugfs source attributes now consider the
> > parallel data port when reporting which channel controls each DDS core
> > parameter.

...

> > +static u32 ad9910_buffer_chan_idx(struct iio_dev *indio_dev)
> > +{
> > +	unsigned int scan_idx = find_first_bit(indio_dev->active_scan_mask,
> > +					       iio_get_masklength(indio_dev));
> 
> Split assignment.
> 
> > +	return ad9910_scan_chan_idx[scan_idx];
> 
> Who guarantees the scan_idx to be in the boundaries?

ad9910_available_scan_masks constraints the possible values here.
will add a comment.

-- 
Kind regards,

Rodrigo Alencar
