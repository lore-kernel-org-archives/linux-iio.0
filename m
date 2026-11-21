Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795291914;
	b=uXWrh6Ji3TpB0i4TQNeVk7OICr8GHtJx0Woe607e3S7vK2xiUZHAODNOTB4IjN6m5oTt
	 MGOWfn6mYP+eAA5bsflhuyUYbBVjOyyv0rkKhsCdQyo9MWuerja62pYfNzfclK823RRG9
	 gex7wAWzBIq4Qp6Ox64yeMN0Lwly4M89kWMQIiOuAryRLI+5C918kf8tO3VPsICXwaTi1
	 syxIPS3SrtsnMnaF1RZ7kD5CEAKfLA1jBTs1j6ZiiZOmEtUWueOAfqA/TQGSjzQyiUfke
	 27v7/eXNp+0iodsTv+cxZdvuS2JKdqL7zYZyGBmi1FcPODWdyhCp1pikj7a8+gsDAyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795291914;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HN6jJa27Dz9lWia+OU4nnhgScVgZYKW99e29Sa0KgJs=;
	b=pCA2pyH7f9LU6eN3u/jCZKaw64LEp5i2Gv1S6GEC81+EHirG+1r4dSWhzRN1BgkmHhbS
	 pqpXOk9r2IDAKV/Era+Y5ilRTqFfiJca9T9XnuwSXVfEpGRg0XGEHv4eFyu73NBUIV78G
	 OgFTaX/tv5J2bR7Ve+m1a9U3MfGLr8IYHc2O3gVxGHvWxGScOqD+LK/6KlSWZLj5g0PmW
	 6HydGdZ7M9lKY7/LB+EZd9039leo2crDQ5IQ6uCX6Vom6IDl/Yoe7R12iJs8lJvpivg/r
	 F9Iol7VjC5mt/4nY7URE68dL/vXj0DBu2Rf5exRqREVMcqVK2wcpFXjWje0Apd5kWtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enVu4zKl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84E9606A320
	for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enVu4zKl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78A31F000C0;
	Sat, 21 Nov 2026 20:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795291914;
	bh=HN6jJa27Dz9lWia+OU4nnhgScVgZYKW99e29Sa0KgJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=enVu4zKlfZB9Shx8Dd0dBmGPcMQxAs7+ypLLER/GxfW4szGFKkCi0OID8384tPTvA
	 Owu+TP1qJf9hQGcNbY86P8yp2k2PDtlpeMAXIeyna4qwLCryQqMgdClra09mhODO1X
	 dsmoLjgcIFk7yPRNSP4ziGBquHjEQwWZ0xN/P6QFX33DgSXY036QzYsUugJSnAdRFs
	 M14C371K7qvPCIql/o4wctMML/1MOK47gRWu/SBK6ivVWYie+6FCV5zBrQcf9u+pmc
	 tQlWUJihW6mPSfBidaiB27jF0JZDhkmJecAPJLOVBtKk57jJh25yCCoDqPSISH9CWc
	 bC/mkBez87y9A==
Date: Sat, 21 Nov 2026 20:11:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>, Song Qiang
 <songqiang1304521@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: rm3100: check TMRC in
 rm3100_get_samp_freq()
Message-ID: <20261121201148.2a2c3edb@jic23-hlaptop>
In-Reply-To: <awA49qGkg-F2m3HJ@ashevche-desk.local>
References: <20261120102848.3198371-1-maoyixie.tju@gmail.com>
	<awA49qGkg-F2m3HJ@ashevche-desk.local>
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

On Fri, 20 Nov 2026 14:11:34 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Nov 20, 2026 at 06:28:48PM +0800, Maoyi Xie wrote:
> > rm3100_get_samp_freq() reads TMRC from the sensor and uses the value
> > minus RM3100_TMRC_OFFSET as an index into rm3100_samp_rates[] without a
> > check. A value outside 0x92 to 0x9f reads outside the table. The driver
> > only writes values in that range, so this needs a chip or bus that
> > misbehaves after probe.
> > 
> > Commit 792595bab492 ("iio: magnetometer: rm3100: add boundary check for
> > the value read from RM3100_REG_TMRC") added the check to
> > rm3100_common_probe() after a crash on failing hardware. Check the
> > value here as well and return -ERANGE.  
> 
> > Found with a CodeQL-based static analysis tool that we are developing.
> > Reproduced in a userspace harness under ASan and UBSan, which report
> > nothing with this patch. Not tested on hardware, only compile-tested
> > with W=1 on next-20261116.  
> 
> This paragraph should go after '---' line below.
> 
> > Fixes: 121354b2eceb ("iio: magnetometer: Add driver support for PNI RM3100")  
> 
> Not sure. It sounds like hardening against malicious / broken HW.

Agreed.  My approximate rule on these is that I'm fine taking hardening
against hardware returning values that it shouldn't as long as it is simple
to understand.  General hardening of a driver against malicious hardware
is a whole different thing and I'm not sure appropriate for IIO.

So this one is simple so I'm fine taking it, but not considering it
a fix.

Dropped the paragraph Andy highlights above and the fixes tag.
Applied like that the testing branch of iio.git which means it is
heading towards the next merge window.

Thanks

Jonathan

> 
> ...
> 
> Code wise looks good now.
> 

