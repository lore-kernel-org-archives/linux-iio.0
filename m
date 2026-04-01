Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC03019D9
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051208; cv=none; b=mIzBZDVPV53BGQVqAvOdnk443zNVJvc7q3SEBo8+bHMkk3ecDaXKw+whq1cbyfUZp3XjNZ4GYrw8JeCqKOMYZvJV9HuIsKsI/oBg+hPF8eChlUHJqdf5VKS9ScjCHP6n0t7ZHKAMYrs9t8hOfUt4+w/sOuMx+ThKav7PBGu/li4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051208; c=relaxed/simple;
	bh=Yi3CZTmqbNaoLwTU6lf0U7FQ8FALvuXYRiIPBERBTI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oc/aVXZrlNegGbBU49KXCZ+CL35F7oiSm0/13FQ3kfeHEZGfeJHTb9E0hmGj2f+x7bV89keCSfZuwEcbTcmrif6qEqeiVqCf/Ia2mlD00CZ/rZrcF6JJ9eAROjUhebEjCqigvSgeL8AF+OINZkIvzLJCb1NL4dm6dsm+FBAsZ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vrWt+DEl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vrWt+DEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88519C2BCB0;
	Wed,  1 Apr 2026 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775051207;
	bh=Yi3CZTmqbNaoLwTU6lf0U7FQ8FALvuXYRiIPBERBTI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vrWt+DElq9+CmJlY4elmqogDjkaRyDQtaL3D9TjVBG0KNtErBRMSt5wGR8xL3N5MK
	 CJDAcT05Nv3sf4fT/uors62xKXFxzdSzFl6C9My37o0wvZoQ3vqsNwcNxBjdWCyMEw
	 CQZux0AL30pxsH/5fv1XNt3Je15az6awdWeXn04M=
Date: Wed, 1 Apr 2026 15:46:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter fixes for 7.0
Message-ID: <2026040126-amicably-countable-2785@gregkh>
References: <20260401121926.2017351-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401121926.2017351-1-wbg@kernel.org>

On Wed, Apr 01, 2026 at 09:19:21PM +0900, William Breathitt Gray wrote:
> The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:
> 
>   Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-7.0

Pulled and pushed out, thanks.

greg k-h
