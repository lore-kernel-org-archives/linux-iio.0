Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423283BED7D
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 17:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559170; cv=none; b=YCHvjeECq+YpCUc+EHhZ7FRDkQAZxwEBHWbp49lKLJ4xBEm5ZuP0udClmnjog1n3u0ITVZ3MJqXXxAhbxSCnXNvaXl8RvmyY3tYx7fKn4VZI6t4A3JtUbMCX8od6eLAGbsuDsklM0fkDWw2bfZRNuWW4c4wJTMnj9HNz4xOmj9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559170; c=relaxed/simple;
	bh=Uv+o3nt24VubCi5V74qWOzNcGTqTlP471f1shfVhHpY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z0BuVCIA7gCNNXdrdOMYW5tSchz434XIG3QFY+MUxcqLfZyViFC4ULmUnWnnviEUcYx/SMpSXec1O+BVYZ3fMZtoltS053Po9xpPor0+sARbAL5unQI073Wz+Q70CL2vS1cxNX5XE5LPRPgKSzxFRUqN5nRVSDAgbYiCRJsUV9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj/nG3x/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj/nG3x/"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439c56e822eso321213f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 09:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772559168; x=1773163968; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+43wN2GkmwxjptarzmeXzSaDAouW4OQGUiQFosj4E50=;
        b=dj/nG3x/91hBIarAD6Y1FWlnUlA2ovWaZzYT3pmNcWPPgFayqv6ojDeZ6PLEciQv9T
         hIDOvAuFP1gpfMAglEg0yRk8NS/c+d3XEOkeYuOPq7emGwz6YYUWWOCUb3ugEnb3BcNS
         9yGom0y0POETKE0oEVhNMPlBrm+nx7kt++vTzcLdC1y6qhV3Gp2x5qHfejFTfMd97TrN
         PNne+oloIQzl5i8CYeni3x5CBOLRnz1D7DbINoGhCYLtJwEjK+Chxziz3aedNF1Z2p4d
         i7lZDzVaOJ/SKgR2M0Mz0TNgUd0g+IU5jkFeZJT9sxzzIypYr8VPSQY80YaidglqoJco
         fozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559168; x=1773163968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+43wN2GkmwxjptarzmeXzSaDAouW4OQGUiQFosj4E50=;
        b=BEBPb6X19v6qOz0z//PBLxhlofWcAs2TxlvOdNj8JgJ0x3nmG7fb6cVsn/J5cWf25o
         /B/iJKROanCQrFgd3uKhyFediPjUJsaY8uEtiQcOPaha3a8EmbSGJLp0sfQySgvsbXf1
         RRHemeJ1MABMw+TvS0C3xg+MyLSOfB+WrQd6rtLVXUtgNEE17BOHTZZB96tLrwAGBGp6
         gZG4jogzZlc7ROFDAyOUfCo9kTIXuuQxbgFSzRJIfGIF8R5sEAhzmwJx44Ar3EMAi5Iq
         0d8z7PALfCWKe9EiiJhoz49JjQOHQKymfrtsKz+bxIpW+FJ6v2+T3DSE8zbr52myE0uX
         kk/A==
X-Forwarded-Encrypted: i=1; AJvYcCXGAdQRuYZTt2FPZy8EixPVbWxQ8PiZCXsIgvlQRhyuv8T38zwaDyxe7TFeFUwUrPgpbneWvSHM09k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUXhzPRS9i6S+xW75mUeXBMv614pQOOlh6/SsPjf6Jnr2wQhl2
	rdO8ciMSRtr6phtfKkBcIZFtBqspaf1VwuHrZh27cz/6+ae4jhfut26s
X-Gm-Gg: ATEYQzyxWeLfcTP0nwa7Wug2EJ4hfeOjAS1ab8DCXKAHPt1TNnjgSiqO/o7l9kbC+jT
	oN8Qh3A6OJIG9nhioVrFXh2MQie9dTdiJbI283mjcH7EzDZuvAgpQF2oqfpQs2TxQOHHCiIQ7Ep
	NzX3oqd3aiwYx0YlVZZDIEKfP9ZT/lq4dufrZocwPBAcekTHBKLoSjy+7A0qUB+tkV1K7KLle6c
	yZk2SAAfY0d331sTLvogXdI4SerRREbCF9DhKFVC7ZwkJS2Tm0EpyJUzE1BjuiNVhHykz1WqIdg
	Hb4JCZQrLuuvjqcMEIwmPEYXobLQ4+qJxHjJQJhWY43B4xJT6NbMejJ6OK+YaBS7A5M+nG9gtUG
	o9pqdMVBUV/csdxIo4owofYlP30xK7SbGgUZQ7AGzIm3og+pQ+FyWt4DhJ1cISc2NGsW0QN8m+B
	MQuAwsxsEA3crW37l7L24B49FCln8hDzHRTS+q0MWomLS8lpYLYFWXfpeDmAjezES7PQMGqysoq
	COR8AyJvsTmNGSVlTM3QgG24lCm+oUlDYpLMwNAO4fVl8KaUDY=
X-Received: by 2002:a05:6000:2005:b0:439:bddb:cc77 with SMTP id ffacd0b85a97d-439bddbcd0dmr9732037f8f.37.1772559167203;
        Tue, 03 Mar 2026 09:32:47 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ac9f3e5bsm27475071f8f.37.2026.03.03.09.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:32:46 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 3 Mar 2026 17:32:44 +0000
To: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 6/8] iio: frequency: ad9910: add RAM mode support
Message-ID: <cb55v4gbaqp2n2jmstq3lhrrqoybxbwfa3oek32xstzwwn4uw5@ilhclierj3wo>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <20260220-ad9910-iio-driver-v1-6-3b264aa48a10@analog.com>
 <20260301133153.7f2f8501@jic23-huawei>
 <4rzqg6gax4r3symyoimekikz7p4pfwjzhfamjudk64f32675oj@nlrz53u56p55>
 <59c3c6324ca971dc081624e0c31131b9e7dc9c63.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59c3c6324ca971dc081624e0c31131b9e7dc9c63.camel@gmail.com>

On 26/03/03 05:16PM, Nuno Sá wrote:
> On Tue, 2026-03-03 at 15:32 +0000, Rodrigo Alencar wrote:
> > On 26/03/01 01:31PM, Jonathan Cameron wrote:
> > > On Fri, 20 Feb 2026 16:46:10 +0000
> > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > 
> > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > 
> > > > Add RAM channel with support for profile-based control. This includes:
> > > > - RAM data loading via binary sysfs attribute (ram_data);
> > > 
> > > I'm not sure that's a long term viable path.  We either need
> > > to figure out how to do it as firmware file load, or via an output buffer.
> > 
> > Could you develop on this? it is not viable because iio would drop that
> > support? using sysfs_create_bin_file() directly would be better?
> > 
> > > Firmware load would probably be too static and I'm not sure quite
> > > how we map these to IIO output buffers.
> > 
> > will investigate this buffer route. At this point, we can have multiple
> > buffers, right? I have the DMA engine buffer working with the parallel port.
> > 
> > ... 
> 
> In theory yes but we do have some issues with the implementation. I have some
> fixes but for code that, unfortunately, cannot land upstream anytime soon and with
> no users, these fixes can be an hard sell. So if we go the multi buffer support it
> could be a great opportunity for these.
> 
> That said, the fixes are only meaningful if we do need to restrict channels to a specific
> buffer. Not sure if that will be the case here.

Without design changes, that is exactly the case. A triggered buffer
for the RAM control channel, and a DMA engine buffer for the parallel port
channel.

-- 
Kind regards,

Rodrigo Alencar
