Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169929;
	b=EMYy1c1C3bYqA00VFPFZYQhEL/vuB7qeCZedWuphv8XxzqmTxxWRDLDOAI4vdIMc2tqw
	 d9FpQjEA2NMPIG4rS/OOQQxz+t9xqsfzuKPfW7LH9GU1+wIg100o2bp01C+VWXm1tjwtb
	 4x7Gy7kqEVy7/eH6qoZFji2t0OCRXTO8koNX+XaBX4+gD+JmEryL9kxEb6STUb5H+03ZZ
	 g4/t95Kjix8n34Kcg7dlFm5bPUIfIXcHWRkxii87pNOz+lHF9tf2oN6uVAKJ23oVOQL4J
	 U7fkysjeXl6we7eSGTxEpPKbbUjdEJAIBwjenEK/8OcW0VLPJc8bR8ybihhfXPyhb3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169929;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z66HgjyTS2ykufguqu0Nzx/yhVKxLUWq4LbWEQ7MTrc=;
	b=18qJJRWJLEn704F0X7+8UEVHcQvR/JB3ei69TiR3TB9v+cn8WA3DIHkPdcU8EfXC8HLj
	 Hf2Iw3SEKBx/LsYyu4IE52cWF0MGCM4ai/O2NI6PfKET4fOQlyih4MJouTf9M2+fRElVu
	 twisLL17nUgB8BOJOnqF6TT4BVSfeg0vGChQQEeHHwwCZC/gKYFZC3g/fi46FbF5z5WNt
	 K1gZtGLtXA91rHe5IN/pfwRjJ6OzQrXSeXC+nVUhzzDsKtP3fo3DZyYsTzcCkYKJmgf77
	 DdZ04w0p9iZ0MGmT+/QXvaRWYQmIGDSAiIG4mtx2B03CTkfVWj0J9LLOYQH8IQ06GqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e//oDGxo";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BCA606A33B
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 20:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e//oDGxo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251D51F008A1;
	Sun,  8 Nov 2026 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794169928;
	bh=Z66HgjyTS2ykufguqu0Nzx/yhVKxLUWq4LbWEQ7MTrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=e//oDGxoL2y+CBCfVd0+3zxa9CCgzpdqxF84A9e6ViDsf/Ps70h3G0T8clyGc82oq
	 bh5j6FH3kzrlGRZOz1U4eyHrd9DJg68wfLNEiiETTI1O3eroIAsLNMRYzPNgF2JpZr
	 WL0aGr0XGWHPaAjUoWXq/4MBSJG7XkRZ7aykQYricEYYGhwdTOMOmipVxQyXEe/8ls
	 37a9O93bLayUpRaJsZp+vNqdyWS9Krx1/ylHSLlPlcQzmU8Ns9JTTeO1MVSqy4dFpS
	 LHjt7CStBCbxeZ4WfqwwGonscXQfBl9kiJsnt2jPAfxGwF6wijTA3vappttjoZKOpK
	 vit2aWCQJpoHQ==
Date: Sun, 8 Nov 2026 20:32:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 39/39] iio: imu: bmi160: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108203201.676f98bb@jic23-hlaptop>
In-Reply-To: <auCDSmJXFjSNTLQn@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-39-8b136778eedf@oss.qualcomm.com>
	<auCDSmJXFjSNTLQn@ashevche-desk.local>
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

On Tue, 27 Oct 2026 12:56:10 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 26, 2026 at 04:05:57PM -0700, Jonathan Cameron wrote:
> > Replace the deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> > 
> > Move the scan buffer off struct bmi160_data and onto the stack of
> > bmi160_trigger_handler() as a zero-initialized IIO_DECLARE_BUFFER_WITH_TS()
> > array, since it is only ever used locally within that function.  
> 
> ...
> 
> > -	iio_push_to_buffers_with_timestamp(indio_dev, data->buf, pf->timestamp);
> > +	iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan),
> > +				    pf->timestamp);  
> 
> One line?
> 

Tweaked and applied.

Thanks for casting your eagle eyes over these!

Jonathan
