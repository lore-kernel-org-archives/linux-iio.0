Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E9E3A8384
	for <linux-iio@vger.kernel.org>; Thu,  9 Jul 2026 05:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575954; cv=none; b=O4NaO3w99rvsC0Wq32R4eG3G1It44A2jl5UpVhcF7SUKmv5kLVn5eZAEQaYsywuWpWYe/MkmrzHu9AeWZZyktNfOiL4l+9C/kyC5FCHPV4m0qGMzoyN8Uq6cJZRmIbBgRmh45utHXkFvt5LdVht3nBLBEAuW6rLZ6eoRATJm5kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575954; c=relaxed/simple;
	bh=VAqOGIMrCgde88MTVPjCylyiWezGIAf3dji2E+vN1fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Runrf6ePqLY2xInL4G4x6nGi2x7JXWpLIFBGwoEGzgSWJDl/snlKZIXEgmBLZTDHuuhsRYJAcIK/JCVD0L1veN606gtaUjrU3mqYEE5dTnDZPRMr7zeTm8cWaD1w0rqDU8AwmxvXst58divhYStjg6N8BQOEG27KIed7qatEIIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fqkRb9Si; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fqkRb9Si"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5108B1F000E9;
	Thu,  9 Jul 2026 05:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575952;
	bh=nkoCy/6M4Gx52d1wqroaryyGmaKDviuEYvN5UyvnGKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fqkRb9SicGkW8R7/mQNfxB+ZgdGDeV2BL6xIr2LKg+pbFp0mskT344ljuSobo5W9x
	 Qt2q4NX3tkoMgXK3doER/JOOnOKHVFxkLUtSJ/cLNLumqCeSP1vZ1170uzusfzHZ21
	 i1yFDhvHEAkyDgf7/jRY5TpsUMqYJAwUD+H0wfiw=
Date: Thu, 9 Jul 2026 07:44:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for the 7.2 cycle.
Message-ID: <2026070946-calm-convent-8937@gregkh>
References: <20260709031127.39661e79@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709031127.39661e79@jic23-huawei>

On Thu, Jul 09, 2026 at 03:11:27AM +0100, Jonathan Cameron wrote:
> The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:
> 
>   Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.2a

Pulled and pushed out, thanks.

greg k-h
