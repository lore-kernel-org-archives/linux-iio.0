Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266E38553F;
	Fri, 25 Sep 2026 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790303853; cv=none; b=K3sepwx5WM6d5kzYhcQXiqyIasyKNJknLrSofyuyYkg3mtPtP0et5OSXe850mQMsnbQ0bFEgTdfSUETaPv3qYF5FN5yGjzoPl2XEX4njl1/BD91A/ZrdU97yCweP1VmzxsXKMh7DE+M3m/6sUsHbfZ1oi+c6yfD1IYGGd6qYJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790303853; c=relaxed/simple;
	bh=IyI4o+w7JlujvkuAbTQla0RSW62kL28I+MICoZ579rU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/dTndy8WY34Fp07vpDx0kDSsVWoaCcNQMcZym0qBIQCsmtU7Gnn/4BW5ibXqeQk6J9O8SYUIrIkVtFz45PmPVoPKHKafBnfqo8K8YPctnWFWvEBxiyPsS1tzBQOkBMnj69C3x2ZSD1lfO1YNj3lv4s2p64tTAt0P38LeNKPnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfoVzrwP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfoVzrwP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AFF1F000FF;
	Fri, 25 Sep 2026 02:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790303851;
	bh=sfuy814gd+GoGAQ/1cA7GcN0tn3BPTF1STk5ZVfAWPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UfoVzrwPJneUv6tWV8xIQo4KMeoq2bVImq5G/RBl7WOs0jb+VMceUJYabgDi7Bui/
	 w33q4Wm7UilbHlygTqADydzCPXQVnwbt8e4sbmZAr3gZWM3zRlkZL4wGhjHlpZ5Pp1
	 PCfV1LGFfHGyGCO1DFQASZLmH6SO/e+gFVfKRdrFkJmtnpUTfXPIpYz1Tx/EFTv2pw
	 54Llz2BBJtDZm2r4b7KdFqK1K1hNLaUs7Kn2GAiLmOuGkHgEJhhJ65RQ/sR2bi5Etf
	 HFGf+VPpPFe5qhi6ic1tlid8kYzsOdxdcVWbs8CcYyirG/Ypz5mz9cG9YA6/NZA/DW
	 shsQeT0sfI49Q==
Date: Fri, 25 Sep 2026 03:37:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, David Lechner
 <dlechner@baylibre.com>, "Nuno =?UTF-8?B?U8Oh?=" <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 codemender-patching+linux@google.com
Subject: Re: [PATCH v2] iio: gts-helper: add __counted_by_ptr to struct
 iio_gts
Message-ID: <20260925033727.3d4da22d@jic23-hlaptop>
In-Reply-To: <20260923192450.3008671-1-morbo@google.com>
References: <20260923041630.2553973-1-morbo@google.com>
	<20260923192450.3008671-1-morbo@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 19:24:50 +0000
Bill Wendling <morbo@google.com> wrote:

> The compiler attribute __counted_by_ptr can be used by KASAN and UBSAN
> to detect out-of-bounds accesses to pointer fields in structs where a
> corresponding element count field is available.
> 
> In "struct iio_gts", there are multiple pointer fields associated with
> an element count. This patch annotates these pointer fields with
> "__counted_by_ptr" to improve runtime safety:
> 
> - 'hwgain_table': counted by 'num_hwgain'
> - 'itime_table': counted by 'num_itime'
> - 'per_time_avail_scale_tables': counted by 'num_itime'
> - 'avail_all_scales_table': counted by 'num_avail_all_scales'
> - 'avail_time_tables': counted by 'num_avail_time_tables'
> 
> To ensure that the count is set correctly before any pointer is
> accessed or assigned, we update "iio_init_iio_gts()" to set the counts
> prior to assigning the pointers.
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Applied to the testing branch of iio.git. So effectively queued for 7.4 merge
window.

Thanks,

Jonathan
