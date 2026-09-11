Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2303C416A
	for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 09:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120613; cv=none; b=hj5lS1Wi1yjyqK2+0B0YPYO03lSDrjePmCSLYRgiyxVzzGQ8vScYr/y8hxMXSrJA6v4TSsGxPD3xOxJpLGhLZD+bqaLFDrhQoj79scew/4EEfvZMb+HAlasc2zPDKdN6DKbHfV74nO1CM/O+AUdjgHA+N/idfasxHZFjjRuwap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120613; c=relaxed/simple;
	bh=Czx9oEb760JSxRyNu7G/CFsC4fiSipyb78chppyka9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlCeBToQLVxyjsf9zewIlaBmvl2KG2kSn408Td1JHouaV8kjftw4iermJMuBos2bvPprXTbWLcHRF0Qe3CjvDiFwsc4ianTuzIYpk25ECr5l+ZkRZZdAOSDab7JlNHJZaN4nEPxBsf/hhXy4WdvQ1bNBg34JuAsz4/TSbBNfbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j2a5cBpR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j2a5cBpR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDCF1F000FF;
	Fri, 11 Sep 2026 09:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120611;
	bh=c1g0Z+PwJfXNsYM1sJvpEvpY7XkpY/viAxpR/p8isGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j2a5cBpRj7XH9yzZOhcKBeQcIbO3O270CvC5LkznZH16hPT8hGHiDleqG3bwOJFpe
	 lZNRSxNQql7/wUgquvgXDPyaSh5HaJTEo3MEpcMceCzIL+pDrG27bVHYu8DFfepxGb
	 T9z+mIL9Q4DrVY54EfxwdxRoJgYXOUVlt/RsDSxo=
Date: Fri, 11 Sep 2026 11:55:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for the 7.3 cycle
Message-ID: <2026091128-manhunt-wrongness-6b0a@gregkh>
References: <20260910235336.6673c019@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910235336.6673c019@jic23-hlaptop>

On Thu, Sep 10, 2026 at 11:53:36PM +0100, Jonathan Cameron wrote:
> The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:
> 
>   Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.3a

Pulled and pushed out, thanks.

greg k-h
