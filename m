Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792441542;
	b=uCRPIAqxhU+RPjGMPVChhTYm2m1KxKxQ7sQ6Yfoxi1YuD/lz7XQzs0ylKCENYQg888EK
	 feIPgsMSi0rXKCo3IgyJ/ErSaBh0itC6rCofWDn7hdceA8A+eXbFdFUkXQci9iUByAsi8
	 t4gjPxN7Wvth6q5Ceyp6K8W+0f0cccElAOWR/1LSiXxAHE86ATi88Y4e8taCcI8GajUmn
	 /L6tXOcHD87XpI+o7PdN4xOu1fji36AuSARUEFjYox8NsjZspRjpgOhijFMmoPXBmxiHI
	 G+Vsy1fUN2X9H631gP5Rv1tzZMFmQYHSQuc31b2fN9C/sfmvSrj5alnFeRM8sR+jPHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792441542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4CLm7A+8SN3dP9H9Mvo0nl4IugDxpC2FOKJG/azirs8=;
	b=Gi4xXmGNe9RM9z5BH5a5+Z0nr7pFpBuG1le0hWo7gpYvDexidake0cLSRpeswlFQNBWA
	 Tvpa9UDTa40EhGl91o/4qjJi2+Rz22L5W6b5kj3+nv01bUcRrV9wiaKHghbXqvutLIksa
	 NCtTprgqGQPbjSD3ulus4nCiPyskwKH2/bLqeqCeCQy9NW6lyOifSjCckq+d0dJkCpFCi
	 uNNdbeYHZqr+/UtGER/f6yr4IdK8gAZXnjSTXQ/oBywDDlEqxCONUN2+Y0spQIVNIpqnO
	 Q91xmThu2+frErU5EcJqxmKb4tYEN/+qtiw0P0duZLrOZlHZUWQJkSeiSo7p7FsZi3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gy+KoPx4;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11D606A320
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 20:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B11D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gy+KoPx4
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so1469077e0c.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792441541; x=1793046341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4CLm7A+8SN3dP9H9Mvo0nl4IugDxpC2FOKJG/azirs8=;
        b=Gy+KoPx4G2FFUdo1www7Snk9hT07C1qiZ9AooZMC8xWJE5vRvVg6Cu7gkXju03RBpt
         4qGGrrzZXhFlbmXH3wqdO+551iMzjGefOoD6M84fd6Th+y3xQQOcAK4o/HzLv5gy+k+X
         Q2AX+SaXfk0+aJLfCV+AHNH/jPfFZyWx/LV4JiRWOzFT6Gc32TpZ9mZ78JzXztsC/kgc
         yo+gfNgYiHHJUdGcqPGqOlhlyaNqAirqFaiVAWTxc1MFXSzC5Z2Fjxta1bYRq62GVxSp
         cKHrf/LJMt/BEcJJsr4UKVAYDZBiB2Bk1Nypc9+uZQZ8MBEQvLzJwNlQyFyFAQtdD3K/
         pXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792441541; x=1793046341;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4CLm7A+8SN3dP9H9Mvo0nl4IugDxpC2FOKJG/azirs8=;
        b=quSbVJ0o1esU5KPbuvUAF5sw0SDKssB7z22YVq25/ZpeQgkPouqBAdN9dA8L+UnMYN
         HPTtGh28/B+HYsXXeU5MQkT0WGDbSFX4KqI5HWEOumaHJ1I216Vi/8jPOHwcR9Y7TbGv
         7FsOZjOyK/REUzDBCT7Q2IQOIyiN1l/sjRIa7Muom2n3N3C2UaUKAS2NbpzLcKjIoQXO
         IN+BIEqtm0/SQGp+cpUUUEIeo+8V8nqz/sknDURKvF14rUbpLuHn4NJhb4FzUHElhgYD
         8OUAKXLql1ifZOjyEtYCU3FbUoVBmA/G8Ez42MJNhvrbVoU+Da7t2P682NIbS07ijlYJ
         XFVQ==
X-Forwarded-Encrypted: i=1; AKwUvByUpVX+SGQV1/Bw+0KAt+3VStFGre1JZI/pQhIdQ+aquvQ1j357CCAoigNtyi5qDnGblPceDjxI4SA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXWWznq1xkEwzSGIXor8+OHMnfAAn9XDNirAa34irJMVpTUzRv
	KTm0W2Sz6S4r2xPmCaIEz6aFH8sCpQp4JT5QXUAvJ/l2nmVO/bmZ+xL3
X-Gm-Gg: AYBFou1gZv05dGdVfD2epP6Gv5cBaoLLBWAR75lYrmYray2HIXK8PFGpQdxfKAvdaRd
	qcN/gSjksM16b1rQaabn2Une+hiLICHl9pDEHGDqwEK76GIGiU0avo25IU5i+lt88IBG2BBPTTk
	qf/pLxhp8z2tSjpEqgCNRgT5Hdlj83GLXV/JEgdJ1NbZO3xYTB36gNXky5+RKrt9TEjw+FpkAKe
	9L/76Lqi0OuNaSSDYi4ptQIXg4h3NMCJlAGMAUIEinv+PObMRdGkoadavymX9OPcuUBb04XxXl3
	29bKprlzaascirP1Z+JPvHcPExKlpbZSpg8qRDqSEXdi785jKW/mq3kcRj8C3hD6TDvMB8ADHZ6
	qoEEzIGp5WWw0kOjjV3h7c++cxzU2lxsVUvr/Mk7jI24t30fdS0vQPNGeazmduVecd4cK5a/ri/
	Hc2luLZaVKtcGQw5nbq9w9d4GW+RrHhrfYFPoq04ZtRZrQsFwYDpV3sQnXGXiFepjnGjgmdn3tq
	61kmA==
X-Received: by 2002:a05:6122:2093:b0:5ea:c45f:6c4d with SMTP id 71dfb90a1353d-5eac45f78ebmr1323912e0c.22.1792441541185;
        Mon, 19 Oct 2026 13:25:41 -0700 (PDT)
Received: from localhost ([2804:30c:4067:b00:a68b:4892:7af1:b51d])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ea9b536ccdsm10865354e0c.13.2026.10.19.13.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:25:40 -0700 (PDT)
Date: Mon, 19 Oct 2026 17:26:43 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH v5 03/15] iio: adc: ad4134: Apply reset recovery wait time
Message-ID: <atZ9A4IocEYpZ24f@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
 <9f6d78d607b2f9a896513535fefa3329d52c4464.1792200021.git.marcelo.schmitt@analog.com>
 <20261017075513.3a959a6a@systembl0wer>
 <20261017201331.5d835dc4@jic23-hlaptop>
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
In-Reply-To: <20261017201331.5d835dc4@jic23-hlaptop>

On 10/17, Jonathan Cameron wrote:
> On Sat, 17 Oct 2026 07:55:13 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
> > On Fri, 16 Oct 2026 22:57:08 -0300
> > Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:
> > 
> > > Add a reset recovery wait time to avoid any SPI transfer from running too
> > > soon during device probe.
> > > 
> > > Fixes: e0bc6d7e2584 ("iio: adc: Initial support for AD4134")
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > > New patch in v5.
> > > 
> > >  drivers/iio/adc/ad4134.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> > > index 40b27b01f126..d555874b4959 100644
> > > --- a/drivers/iio/adc/ad4134.c
> > > +++ b/drivers/iio/adc/ad4134.c
> > > @@ -442,6 +442,7 @@ static int ad4134_probe(struct spi_device *spi)
> > >  		return dev_err_probe(dev, PTR_ERR(rst),
> > >  				     "failed to get and deassert reset\n");
> > >  
> > > +	fsleep(AD4134_RESET_TIME_US);
> 
> Sashiko calls out that this is currently 10 seconds, which seems unlikely!

It was actually correct. AD4134_RESET_TIME_US was misset. Fixed that for v6.
