Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BEE3F4DD2;
	Wed, 23 Sep 2026 07:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148412; cv=none; b=m9kP5K0hMDhp51LoOyQtuBqLS/45V+jh05LF5KoBu1q7TqxQ4Wvfc71b7XuyliCGMVm3ApmYrd7FG3xJ0qe/kU2bW4LdFNy268Kt20spCF8OUnPYY7eyapSZqup6gzjYDqXZ2/22npYfL4TWuN9i0htbEOtYy8mUNW7a+k0TFf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148412; c=relaxed/simple;
	bh=pRzjB1LOCxIizV5xkXMeCPX5iYJLsnW0lgHcMqXOGE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFseOudXQJyntP10akwBjX4PUO+Fj6PczAnOjK2GB9JvWiLtu/XmSD2Kr3Bi/q1t+ix51po2OBNwmjG4nniCZ7grzj1fKQcTItVVNX+ns0t4np1OurdlEgx6ZZt3ZhjV/6pI1P/cOjwK1C33LG1vROVFX9WKnyIOWb/awG4Yo6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLz1J0yl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLz1J0yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3ABD1F000FF;
	Wed, 23 Sep 2026 07:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148411;
	bh=dYg7BkgTwygh8UCnw5w4rzLiw49BTrb1ReMB7n9kcls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dLz1J0ylCpyy0GYHV6vKCgtAD0zXLcl6SONkhFpW6budbIji+3JYdeRHIGgI7RzuP
	 8p6rUo6QqMoLWsBUL5uufu6QyEGBPk4RlTOKNlI04pq8jxtXcaFOR5z55n5QxYAqQN
	 pT8ySF4Ncazjx/Rh370FUSc7D4w4uyVup6kb1WKe0S9cTBN7Zn8sJfK1ZiIbXK2Gbn
	 NS7uHn+imNW89wFPzH9OTvJcCyQwYCuE9+qEtZ278SUzNBeNddfB23k8phnVi6nsUg
	 KsMgLfWLFqWe5STHUy3m3dJ2Ukuo62s9u1M/375Egndxy67o5izhUjGbYjIB62qshA
	 3PRG9aulZzhNA==
Date: Wed, 23 Sep 2026 00:26:50 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	codemender-patching+linux@google.com
Subject: Re: [PATCH] iio: gts-helper: add __counted_by_ptr to struct iio_gts
Message-ID: <202609230023.C2053303C8@keescook>
References: <20260923041630.2553973-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923041630.2553973-1-morbo@google.com>

On Wed, Sep 23, 2026 at 04:16:30AM +0000, Bill Wendling wrote:
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

"Accessed" yes, "assigned" no. :) Let's not churn on assignment ordering
unless there is some problem I'm not seeing. The only time this should
ever matter is if there is multithread visibility on the object already,
but that would require both counter and pointer be set, so that'd be a
general locking issue, but ordering during initialization doesn't
matter.

-- 
Kees Cook
