Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8CA3C2762;
	Mon, 11 May 2026 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516021; cv=none; b=hxFHUQA5GWpAbG7uze27oBvuNdXau36YF9+aRUs7pC7Z2UpYPKUMHwp+f3kCQnzNgY+tJirYgJyQs5otOT3CHlqgOaKGLqaUSgXe8K/ibkQsy5Qp57Xmm/fZie610sl44BGoSLhwc846Hui+3uXVwFzHhm9vbnMsTGitkkjSBXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516021; c=relaxed/simple;
	bh=P9QUQGP025cpJJ3L1g9D2dlXRuubUNsjpNqTpACHAk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P9vLfcvXRh0cYv04vb6a0D+x0fL5GbC6BZyTaR6Z5nsK6tO3Ib2maTvQ56tLaTjNNCb2+HArkq9o0dde/flYvpnkzmXiYpSZH8Nxg0opiKFbn9uUDybRRLJ/9GHbgkjwORmDBzZyMD1SmpBbF3Xw88nwp+59tMmyAffbA//wTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aynY4iky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aynY4iky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0ACC2BCC9;
	Mon, 11 May 2026 16:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516020;
	bh=P9QUQGP025cpJJ3L1g9D2dlXRuubUNsjpNqTpACHAk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aynY4ikyNfzIOi5cdoUHoHaytklqpRQ4dFwfufpSAxJGg7i4HXNc4lq5g5xC2RuEv
	 d2/g+Em79qYIGwsAdmPyZUWuARxFFO18p1CE2EDiADSPqOy2aFL11X0WaqZebgGlNi
	 nWvNN9o0gsEkrkilMQEXm4iYk3ToBWEfhuLbubrMx25GLlELKcP8+XnSgExIcA5i5W
	 X+XofqPqNzXCGdimXxYFNEKBzqmV0krs5zSJd4Ab4yMALLFsERNxXeX0CyhcK1WUVb
	 tuIPpNV5BpA8kRPtflCaNAiYuIpqJALvalVo6trI5FvU4csc7UlOZ42tzGOy/3+RDu
	 41JVHQSc8kqqA==
Date: Mon, 11 May 2026 17:13:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, puranjay@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: accel: adxl355: replace usleep_range() with
 fsleep()
Message-ID: <20260511171331.77f3ef39@jic23-huawei>
In-Reply-To: <agGE7F5zm2pN_dBk@ashevche-desk.local>
References: <20260510113853.50019-1-sozdayvek@gmail.com>
	<agGE7F5zm2pN_dBk@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 10:27:40 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, May 10, 2026 at 04:38:52PM +0500, Stepan Ionichev wrote:
> > The "at least 5ms" wait after software reset has no specific upper
> > bound. Use fsleep() with 5 * USEC_PER_MSEC to make the unit
> > explicit at the call site.  
> 
> > No functional change.  
> 
> Strictly speaking the upper limit is not set as 10 milliseconds now,
> but defined by the internals of fsleep(), usually +25%.

I'm not following.  There doesn't seem to be a statement of anything
about the upper limit that is used - just one on it not being specified
for the part.

> 
> Perhaps Jonathan can just drop this sentence from the commit message
> whilst applying.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Given I didn't really get the comment - applied as is.

J

