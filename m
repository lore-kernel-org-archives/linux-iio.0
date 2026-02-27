Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5724643E9E8;
	Fri, 27 Feb 2026 15:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206451; cv=none; b=pPFUgZnJnrlx7mi6ApQsHeE8mdy1slR+Ngg84OMbYfXB6hUQVBN6dlnG2hN3Ax/9sh82pBEmr1pZM0no1IcJo9YKfjRzReLv7nYK4lXUuzpTSQlBpa5FupZaeDZyS0DSMKDCGN4JqukBHtcXMpQTqmZt23nmp+2ywnUvSgtAGH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206451; c=relaxed/simple;
	bh=Q5M7jajGD8mocuB5vbEVGa2RaWXjdo/7DN4Gts8cvcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiic6QkPM9MQQMQFiRePzlbG937E33caY6Z5xO+Z3sTE9NlWLnuDBiGo3TS5Q+99i3CY0i2lVfypPl704CXHUm1ne30U/ikt0Ht9Y/L1MGuFJ4wSNUoaP1G3jag8NELKMd4IfcWqq1iaB8hC8NxB+YEqYMn0+6+B2IUK8EnjrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xe3dZhFN; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xe3dZhFN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 68CB4C49F49;
	Fri, 27 Feb 2026 15:34:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CD0F5FE46;
	Fri, 27 Feb 2026 15:34:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 71B41103682F4;
	Fri, 27 Feb 2026 16:33:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772206444; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=om+ILXLhJC6eYOYq4v80L5Ebke/E4rCiLTomLCU79aU=;
	b=xe3dZhFNZPJfK/ipyEgL/hl+RZ6s6mu2jfTK+6HdWISCrUVTjenydvYCx/gIm3pNL3CzRk
	CA20q+EDUMY3NHtb4jXUgZ8JLkOxZ4CRylK6BuHcj/WLLF84RPvPXLFgdMamlhqwA3ct0M
	wIpr9Hutk5Jhdfxa8lytUOedg+cg/ygaDVjamStXMOrdpzVwJgABOB2bQILoIl+Hi0fXNl
	dUcxKndFAS5eQ2pAazT0PVihh7qP5ZxKmjoRiKPwSNyrF3zA2WFIj2A//epCj1JfXr8siX
	hECAYH3tCX7sJUFg/dari92jFbrRHm8O7fSMMa5fIeeX7Y12oTNzE/LONKeUQQ==
Date: Fri, 27 Feb 2026 16:33:58 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i3c@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] [v3, apply after -rc1] i3c: simplify combined i3c/i2c
 dependencies
Message-ID: <177220641632.201056.5029746753419046340.b4-ty@bootlin.com>
References: <20260204164216.544409-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204164216.544409-1-arnd@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On Wed, 04 Feb 2026 17:41:58 +0100, Arnd Bergmann wrote:
> All combined i2c/i3c drivers appear to suffer from the same link
> time problem when CONFIG_I3C is set to 'm':
> 
> arm-linux-gnueabi-ld: drivers/iio/magnetometer/mmc5633.o: in function `mmc5633_i3c_driver_init':
> mmc5633.c:(.init.text+0x30): undefined reference to `i3c_driver_register_with_owner'
> 
> This was previously fixed every time by marking individual
> drivers as 'depends on I2C; depends on I3C || !I3C', but this gets
> tedious and is somewhat confusing.
> 
> [...]

Applied, thanks!

[1/1] i3c: simplify combined i3c/i2c dependencies
      https://git.kernel.org/abelloni/c/663eb8763c25

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
