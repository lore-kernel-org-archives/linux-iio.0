Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8430567D
	for <linux-iio@vger.kernel.org>; Thu,  1 Oct 2026 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790859489; cv=none; b=Hm/EfO01sFPksZjzSbY7tDYXrNE+pPIIxw35M3KOL6ndp892gOyjzOTiAItTR2ZZ7AgWIdxuAFKz3v0QKWV7lSBI+MvrPSKqJdltjgHKlN54XcP9gVZJQM3tqd8OUpDrrmN83PIM0UNCe1gSmiwFkAkBf2XRWHvs3aB6akysdH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790859489; c=relaxed/simple;
	bh=crHaKTQl4hwBYM9aeE/XJV9vhMdfszhOPp6UiZjdTc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFqmJgS3E7+YxV+wXmDN5EFLbfWJMPI4ZokdQz0a1h/Goc+0YN2x7ooFVrDtovq3fN93kH/LIXpsUHI4l/XS+dnb3JVySKT2EudLMvCGftpAkZ2dgORul5LK/0L7crhNgDD/3Epl0xaY3a9zkpe7T4OFutK8XtjhsadnQodNcvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=in54zZlQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="in54zZlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA9E1F00898;
	Thu,  1 Oct 2026 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790859488;
	bh=SY2TX3o0l2MRYIm5kGzR7XLKaCeZR0LThQQet56bti4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=in54zZlQLunDepT63ewJBCuLFExMhJTNK6vp4+mF56efV5ua5rXMbN9UtLAC2SisW
	 6+SL4AHiLRuunZpfYAj4Ta9NM6Q4dps4DGcCVRZ7WDsNyVQicXbZk70okpcR3FTqLF
	 q0mKZx/M937Z+t7xASD98VqsaiHYX4ycIrMhzPMQ=
Date: Thu, 1 Oct 2026 14:57:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: Fixes for late in the 7.3 cycle - (7.4 merge window
 soon enough)
Message-ID: <2026100122-magician-bungee-73a2@gregkh>
References: <20260930191205.4f6a2664@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930191205.4f6a2664@jic23-hlaptop>

On Wed, Sep 30, 2026 at 07:12:05PM +0100, Jonathan Cameron wrote:
> The following changes since commit 137d6ccf0ec8c48ecf0facc47cc46926df5fd0f3:
> 
>   rust_binderfs: add transaction_report feature entry (2026-09-16 19:33:40 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-late-7.3

Pulled and pushed out, thanks.

greg k-h
