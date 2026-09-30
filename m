Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4774EB865;
	Wed, 30 Sep 2026 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780632; cv=none; b=qoCwoscTcz05LJu3I71QWv8TxA+px1Dk2GFq9D0NigknyXsVs6EJl1bdjZxLu+9EUYbNGvDbQ57iiY2ULPLxJiWFQJs3RDZTJUrrmyK0gk6HWnQKMMDQhtllXQ15hOhEz2plvL9sR5wK/xgqa8DaDQhuUp2qaEvaZ5qbNq34p3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780632; c=relaxed/simple;
	bh=s/8kkEZhVd0OJzmCH/hPMWUc0/RQEN7qGKZ6w5ctzp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqiPaz7l5Jd1q5oS9v9qrMsOnZkhgDjZd0l8ufdDlZwnYf7m/PXMdzRSyI4KttpK2cSJi66Rhn4Yi0+5VP6pg1Dto5YQ7yqzc2PTm6lk52lCVfNseDfCIkqcKsSYTKaRO8RoxUPWzBFW/L9Q+LuI7S9vZBxImMk8BK31dXr52VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hORXiz8R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hORXiz8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E061F000FF;
	Wed, 30 Sep 2026 15:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780621;
	bh=Sn5n3WuCVajT+inl+5tBI3yXF1DodX/zSNPkhZCSDKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hORXiz8RPe71t9VBoziOt5QDzrqg5lEvWawkXF1ukt0vtpuLuesk5CGTfFN6gxoXk
	 fFsVpeh+/nHgHYe60kV0V4+rhWWm9xd9EbQPdFNwwexIboeliTNnPNl85eiq/lLon1
	 g+ODgnIpbTCUo59o7/r/CCFH6M6kR4G92FIFeMiiASyE72BKqgVwE20OCJon68MPLm
	 ij04bH17JHvPefJV9rk2S2y0ElCpu1GCm9pizD0hlq9eBFH+4RkvrL98qVFLfYl4oJ
	 lSEgiEzG43X6F36hBs5CmHU4A0mHkuR0G1vON67qYNJQo7/1Rbw3AeftCCZI0Ukn0Z
	 S+F37pvLuEgCg==
Date: Wed, 30 Sep 2026 17:03:36 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: cdcp206@gmail.com, Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Liviu Stan <liviu.stan@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: temperature: ltc2983: avoid string comparison for
 leak detector
Message-ID: <20260930150336.GC3142230@ax162>
References: <20260929-iio-ltc2983-fix-string-compare-v1-1-d67d612d6ddd@gmail.com>
 <arzb0JQxkJAsLsEa@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arzb0JQxkJAsLsEa@ashevche-desk.local>

On Wed, Sep 30, 2026 at 12:52:16PM +0300, Andy Shevchenko wrote:
> Hmm... I consider that the compiler warning is just a noise which we should
> ignore or disable. It's doubtfully useful as if it may prove the always false
> or always true cases, it doesn't mean there won't be other cases in the future.
> Do we have any discussion on that warning before?

I don't think there has been a discussion around -Wstring-compare
before. Unfortunately, it seems like clang's -Wstring-compare is
different from GCC's -Wstring-compare. clang's is basically a subwarning
in GCC's -Waddress and GCC's -Wstring-compare does not really have an
equivalent in clang proper (it seems like it might be a clang-tidy
check IIUC?):

  https://godbolt.org/z/zzT4WsoT8

So if we want to disable -Wstring-compare, we should only do it for GCC
in my opinion.

-- 
Cheers,
Nathan
