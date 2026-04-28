Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8545349F;
	Tue, 28 Apr 2026 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777399474; cv=none; b=MNBYcTzSVieR62ihUh0qSqsqtYkOiYKmkYjtdPp0HQ2Z99YVFxEcL5Fg7W6EYhNzsqEqwEgp7SYVe4Q2iq/SDudJ3Xkw3YiuheUch9AcSj49XGtgCL8pvdv/cwRAuqC9lDh5muQx0TBQgd3Tlbvl5dx0SgvTuqF9K+QyLQ+w9lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777399474; c=relaxed/simple;
	bh=3toZe1BeqaZjisyXMu4GaVn64VWvorkIVDHkZqcxNJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBrmzi8sJ4y4e+fiGpdUj+Je3OrRtoQjOUr6Cls92IhsXg+HvxIvLM2t3PI1yt7LDaDXRV2a0GStFWdajirQl8/4080dC9R5iOoa97SAPpPJBKUE3al5tLH92dZdHUHTzSpwAZalB/gfYfFVT75GrWmelFr7vyApecBd83K0hV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RR8hz3H0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RR8hz3H0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE22C2BCAF;
	Tue, 28 Apr 2026 18:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777399474;
	bh=3toZe1BeqaZjisyXMu4GaVn64VWvorkIVDHkZqcxNJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RR8hz3H0ib76a4oBVl4DXK84+cX9JMWcGqlxYKkpnlBNzu3FmsA32tTZrHHgOrSlq
	 kIbCKkfMAo2RRgmNCH9zICncU9uQcAOJ1Ss93QYXrJcCYurGAY7IjuNupvtFSrU+70
	 4ec3+arpi0VnsepcyBWJ3f90so9lGqFTp7ZUr9lpbvKXq8w9+JCDe0oQYekK7EGi/E
	 ramawBFum8zjLv2sEiWX7zu+Iut4dTxz+214FHLLTGdPiTNgFWsHV2uTg5Y+wjbBXc
	 HOv8h2/u1zMv4f8NN7+wPPidnJ/J8YY2JNHjYvZR2+VdzLB5M9ZpvvxQpJuCMSzvk6
	 bRo2RyhQUTtlg==
Date: Tue, 28 Apr 2026 19:04:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7] iio: frequency: ad9832: simplify bitwise math
Message-ID: <20260428190422.5d430430@jic23-huawei>
In-Reply-To: <CALoEA-wOZTTC3byrcOjhFORQbmJQFWiROtsnxScpfuA8PYMVig@mail.gmail.com>
References: <20260419183623.86587-1-joshua.crofts1@gmail.com>
	<CALoEA-wOZTTC3byrcOjhFORQbmJQFWiROtsnxScpfuA8PYMVig@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 08:40:03 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 19 Apr 2026 at 20:36, Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> >
> > Refactor the ad9832_calc_freqreg by removing the redundant u64 casts
> > and 1L bitwise left shift and replacing the multiplication by a bit
> > shift, as multiplying integers by a power of two is identical to a
> > bitwise left shift.  
> 
> FYI.
> 

I was letting this one sit a while as we had a lot of discussion on earlier
versions.  Ah well, I guess everyone is happy now.
Applied!
J
