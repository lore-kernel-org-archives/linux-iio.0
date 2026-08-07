Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84327FD43
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786112128; cv=none; b=TD83oaHbCnjrKYciFAvSJ7YBusjYa9MKTZ5Q7G9L0pvA2kspACI7RryEGEYKVO+JwNMaueqPe5Ph+RcazUWZq3N8a4I2RzuwcbS+2u2STkZSyS1ukQAWF3DnzWkEjp3myh7S7+THmDZjiigXleK1KlZ3xYeWcyDsU1yAkOfhom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786112128; c=relaxed/simple;
	bh=Cxma8G0oQPORWGfOt3OzXYJ3RaAXn6tW2FlOsxnAqQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uyk6hJYbRzwibJLYTxVCWQB8yJfLTOyWhioQIFKhjYJaGJmsoyNL+qdoW0QJSoFDWWCE1bnHL6VWTBqulAZG/FfS3K58XSG1EiLXkj9Cwsxl2bQMaCtxZUyGkrRmCciI+IZf2AZu8+5O1+1YqZqhhGSB3pAOEWas/97HIVQ83I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fEiL7Q6q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fEiL7Q6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C55B51F000E9;
	Fri,  7 Aug 2026 14:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786112122;
	bh=u/hUeIbQZriJ/SkDEMzYWkXUYHzBwPxL/Pcgy1o3t1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fEiL7Q6qFth/XfddePOz2PbDyGzGtacSHtfVxAX09VmflSSGtPfbRv/tz+JrOjKOa
	 WA0ABKcR2uyE4zpXzBSVWJ1sTI0zTTifYGG3Z8LW/4I74czxwIQi5lW2xdMU06o3eZ
	 jE7HCqxD3S+ki9yX9PwWGmg9sta3h3HVEFpgjAXo=
Date: Fri, 7 Aug 2026 16:15:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: Fixes for 7.2 set 2 (probably now for merge window)
Message-ID: <2026080756-emphatic-staple-8c6d@gregkh>
References: <20260807011131.7ea4a639@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807011131.7ea4a639@jic23-huawei>

On Fri, Aug 07, 2026 at 01:11:31AM +0100, Jonathan Cameron wrote:
> The following changes since commit 3585cfd4563731a8ae406b32807613c667c2b887:
> 
>   Merge tag 'iio-fixes-for-7.2a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2026-07-09 07:44:06 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.2b

Yeah, let's wait for -rc1 for these, thanks!

greg k-h
