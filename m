Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168241;
	b=BZzB7sy0J33gH5tgv6W+SY14jNEb6lnz4ReL03hCoEALVE6h1M/2vVi0m68x/YWV1E8h
	 6JNp1uO24KGpT4MtzcDYNMvC9iPr+9tFCqngsy5I+FHk+6J3WHdaeNlEvkYBClpb6m0Fb
	 4n6iBLwSNdeXpJPyTePDsdKQ8SoIGrZeiY+brYX5bQ6DxnpF7/G/MOVfeJebR+vH11KcQ
	 Bj01CC7YBaOWg6PaS7V8U046wgNHXUe1MJt/R4/BrqjC5eZimdUndgdpeqdO4g7YU/QjB
	 sydz7Qp54pWl93u+ht3f6MAVTLMRSzd/8C5bJSQG97E/EhoU+rnn7G2EViZA4/use+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168241;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eGVgvoAbd0rP9dvPCVSuFTpiDOPp5z91oerfHd9UmyU=;
	b=444lwRcfCwYRENscCG215CzcfRIBHqPzZjgNtS7fFSi9NQ/jlvPInBY9Aj1pjtEEpXOr
	 C663SysriMWN+MT3cqMMmT1WQlnDR1kBJNdQrDRMxl5CdE5q493dA/laeC5Cw6/7YVhbz
	 RWevI6aWc/jPS9AjqWBdBRLYJC6qrzifv03mYaXQFbcvm5lFCI8Q5z//7RuD4raAzzY0F
	 dwGuwxcILDwTWoqbZw7xMMcbVrmicgDt/DYQ4uXfFFNvFBV6Yw3xmHRBiQfhxFFM4y3HG
	 qTjZbWQJDf9GWzc3l0oKjOqvYnQomqyvduvWUpNQ3faBXj6ZBbDNWqG+AftLORfEREA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UP2xQ8oU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43026606A31C
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UP2xQ8oU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C40B1F0089F;
	Sun,  8 Nov 2026 20:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794168240;
	bh=eGVgvoAbd0rP9dvPCVSuFTpiDOPp5z91oerfHd9UmyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UP2xQ8oUYBj11yvFTpPNdkt7yeixI03RGygy5DpWimn/6pKsE+mN7VeKog7oHt4BZ
	 71GAKyrHJ72ZrUlgfvm5pVFJjuPpbjdIuu8jbYipcoxqhigGEwJJw48hdsDJu3dpzj
	 Gsx3l5WONLjvUJ/vmallq285dVKSgzKoemHd02FDGiJBZdJU6Br4MtvNpABYQWYZM5
	 WomNVLk5IWLQKdwBtomB7B7Hi7vrrIGQNjRGGUZv1I6Wx2Z/aLMjbaYcXGacgbo02m
	 8W80cI26a5UEmYMCx8uyIjhFuA1U/Z5qx4Ay/M5kc5DVEcWEFRFHBmj6SqgWWhuDHd
	 qUvoYwbck4erw==
Date: Sun, 8 Nov 2026 20:03:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 23/39] iio: adc: cc10001_adc: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108200354.69876019@jic23-hlaptop>
In-Reply-To: <auBhlvhC7YwyaGfd@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-23-8b136778eedf@oss.qualcomm.com>
	<auBhlvhC7YwyaGfd@ashevche-desk.local>
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

On Tue, 27 Oct 2026 10:32:22 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 26, 2026 at 04:05:41PM -0700, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> > 
> > Move the buffer onto the stack, local to cc10001_adc_trigger_h(), and
> > declare it via IIO_DECLARE_BUFFER_WITH_TS(), removing the now unneeded
> > update_scan_mode() callback.  
> 
> ...
> 
> > static irqreturn_t cc10001_adc_trigger_h(int irq, void *p)  
> 
> >  	unsigned int channel;
> >  	unsigned int scan_idx;
> >  	bool sample_invalid;
> > -	u16 *data;
> > +	IIO_DECLARE_BUFFER_WITH_TS(u16, data, CC10001_ADC_NUM_CHANNELS) = { };  
> 
> Move it up?
Tweaked whilst applying

Thanks,

Jonathan

> 
> >  	int i;  
> 

