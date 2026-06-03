Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544CF44BC82
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 11:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484500; cv=none; b=UHo1+kqqTF0c9bTMgZpO0jZbh8rQ70oFlD8kEQt2LiSTTN8jFFU8x0e9vE0+/uai/HtHK69AXkg6ZCwA4aLYWVN5rrXdTEMk0UrS8PcYJDgusnLkYnFt9ctdalaaXmcKNF2ez39Oqixtfw9vRUNxuLVmd6r3mrikALKkuc0x4cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484500; c=relaxed/simple;
	bh=9BUoylVSJ+EytrkV5kQ9YZ/1owWTTBb5hR1zXaKfB2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jw4/mK4lIvXbL5j9zttlZZiskKg5gyoVz88eRKfRKUg9MyrEzLX19SwHPJWvk7yRstG1qDqQC2/0A8isNUuLWczbGKY5lzV6EDApagMG0x52IWY/WiL9jQC+VkhbETeXFNCiEyVaknk4ojcDAVDgBT/P+DrHwOiBPeOaPczi8ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZXrTrBo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZXrTrBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088E01F00898;
	Wed,  3 Jun 2026 11:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780484498;
	bh=h4qy3hp/zw5OnsYgRXDxheDOAuRZUNKS2NKP0ioDcSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EZXrTrBouQRfIkRmZxctT5yqTDRnDIcdw6qu+No8JYTSzyVTfZHjoh+DgFY0q9nBo
	 ILjKy19nnXmeJzU+kJGQkcgLs9Gn7jDB80ArFzGUnmKaawSsPqo5qcOjZkOhjyuJSM
	 zZ7f59E6JkXdkWdsDXdDeRnwjXDNcxdSLmBCKLyoRkZf0gxd495nCqa4H02KxBU4Nr
	 poJSBFh0Awpxj4v2wHHn1vtISpHgTQADKn+ln4LAmzOBkzJk6RFHy57If1QULM6FDd
	 9aGd+CNw8NJRwMgoUeRqw+kB4u5KX9dXLQXrXTTqNZ2pRDF3MS3qIhMJ4stmZtKB14
	 GLFvdRZxbI2fg==
Date: Wed, 3 Jun 2026 12:01:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sam Moelius <sam.moelius@trailofbits.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Jonathan Santos <Jonathan.Santos@analog.com>, Jorge Marques
 <jorge.marques@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, Duje =?UTF-8?B?TWloYW5vdmnEhw==?=
 <duje@dujemihanovic.xyz>, Stefan Popa <stefan.popa@analog.com>, Julien
 Stephan <jstephan@baylibre.com>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, Samuel Moelius
 <samuel.moelius@trailofbits.com>
Subject: Re: [PATCH v2] iio: adc: ad7380: select REGMAP
Message-ID: <20260603120127.03f9172c@jic23-huawei>
In-Reply-To: <ah-ADnSU_VhacXqI@ashevche-desk.local>
References: <20260602164539.1541685-1-sam.moelius@trailofbits.com>
	<ah-ADnSU_VhacXqI@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jun 2026 04:14:54 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 02, 2026 at 04:45:39PM +0000, Sam Moelius wrote:
> 
> > The AD7380 driver uses generic regmap types and APIs. However, its
> > Kconfig entry does not select REGMAP.
> > 
> > As a result, AD7380 can be enabled from an allnoconfig-derived config
> > with SPI_MASTER=y while REGMAP remains unset, causing ad7380.o to fail
> > to build.  
> 
> Okay,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
I replied late to v1.  Unless I'm missing something makes more sense
to select REGMAP_SPI

Jonathan

