Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793486148;
	b=frWS6XP9/D+XU+S1eAo/DxVlWeldqwPRNfeTWVf3BlaJ7fZda9JP6HqqF+XtBATb9YY5
	 vokEzmB0mk/XX3ADxwHFrYBWYvMEgitkqeDIoFSl4FImOK1BDAEaSYzJCTv5KgQQ7L/ti
	 ybRUVF0RRJzRYl4LuMZpkKzYdl5ap4LrA/6IDh4fCyB89LhzRnGle9mIapvRZYGfwlH9t
	 COY1ulpli9jmisT8xOyheiLLtLtGCXASiSAS0OYc2vxZIt747bevNf8fjQbE/g/0vbEQY
	 gMjuj1zvOGrcR51UnLD/yMBeju/nwk4ofUc93w+JaknbhPFdtUSu2QH+lQqKIlDPKBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793486148;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nzQRvCwaYXmtasavKNUZak9W/WcvebGkCSju9XOd+Dk=;
	b=mswjbR9GpD8obRgyeRMZCRuHsUUPB4l+jmgTQQ6ITF0ij7udfPbshHyqa92GCXl5Rn54
	 Vo3YAjV/rE2zLhCXLuqS/aPREr2nwaQWmoJmxr4A/iL+u09rw+9s/+3+IhdiCBYQJh3uQ
	 GYNRewDoWR6KpsUJsh+WH3Y8zAW1N94g6Ga5JEVj4r88G74MDpJRsmNV96Lj0PJlYvurF
	 3FAaZIkz15Ly1oPqRNkiNu3MW3vv7TmKG0/HTXzRLDhLW9o9hyso28vTxuAOMRv0QsDe6
	 2+cfDca9GGOMjtEFt/VJ1/c6X50AcUB+RseP9qTdwIgDcYTMZBlIdAG511p4nf9G2Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4X7Q7N+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C32606A31A;
	Sat, 31 Oct 2026 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K4X7Q7N+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F4B1F000C1;
	Sat, 31 Oct 2026 22:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793486147;
	bh=nzQRvCwaYXmtasavKNUZak9W/WcvebGkCSju9XOd+Dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K4X7Q7N+2GrsDpipIbbihb9skWxgDHXW7LjI7/ryzpj50cqC2lv8Gxo487TdmeH6c
	 9i1RGrSHAc+96kcRxwPRnHL6oRrmpx0vdbI1O1c7GSSzq1zoOeHMqdAafdsSFriJ9a
	 +fZmXrJ7LQ1lYPALpEOdXOS0pPqquUgDpkBA/ZR+xgQTMPfCaqDvTDPHEVa1tZCBHo
	 ZTUvZdoMXq05ic41AAJL63ns1nv1zfjGKr1gptVSoV5VnP4S9zqBEYKu88uwCAufu/
	 yOfyaCi9MoVC/1vlT+pkUF+hsaugr8UwjmJnf2/4pNJ78SypTuqnFLxQqkAHzDaf2p
	 lAbt3CrFhcxXQ==
Date: Sat, 31 Oct 2026 22:35:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Rupesh Majhi
 <zoone.rupert@gmail.com>, Alex Lanzano <lanzano.alex@gmail.com>, Andy
 Shevchenko <andy@kernel.org>, Benson Leung <bleung@chromium.org>, David
 Lechner <dlechner@baylibre.com>, Guenter Roeck <groeck@chromium.org>,
 Jagath Jog J <jagathjog1996@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Jinseob Kim <kimjinseob88@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Remi Buisson
 <remi.buisson@tdk.com>, chrome-platform@lists.linux.dev,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v4 9/9] iio: enable context analysis for all drivers
Message-ID: <20261031223537.1e1c5ad2@jic23-hlaptop>
In-Reply-To: <CANpmjNNNw3Ont87-Uqo_j4YrPbamHLue=EAMkc+B66Q_yywQ9A@mail.gmail.com>
References: <20261027124954.110697-1-zoone.rupert@gmail.com>
	<20261027124954.110697-10-zoone.rupert@gmail.com>
	<auDNzWMPy0VQcazt@ashevche-desk.local>
	<CANpmjNNNw3Ont87-Uqo_j4YrPbamHLue=EAMkc+B66Q_yywQ9A@mail.gmail.com>
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

On Tue, 27 Oct 2026 18:21:29 +0100
Marco Elver <elver@google.com> wrote:

> On Tue, 27 Oct 2026 at 17:14, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Tue, Oct 27, 2026 at 02:49:54PM +0200, Rupesh Majhi wrote:  
> > > All of drivers/iio now builds without context analysis warnings, so
> > > enable it in every Makefile that builds objects, replacing the entry
> > > for dps310 alone.  
> >
> > ...
> >  
> > > +++ b/drivers/iio/Makefile  
> >  
> > > +CONTEXT_ANALYSIS := y  
> >
> > Can we reduce the churn to only adding it here and do some magic to propagate
> > this recursively, please? I truly believe it's feasible to achieve.  
> 
> Should be:
> 
> subdir-ccflags-y += $(CFLAGS_CONTEXT_ANALYSIS)

Nice. If nothing else comes up requiring a v5. I'll tweak the
last patch to just do this whilst applying.

Will leave these on the list for a few more days but I
just gave them a spin and they seem to be working well.

Thanks,

Jonathan
