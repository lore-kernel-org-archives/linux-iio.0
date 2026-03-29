Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535953C07A
	for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774788903; cv=none; b=FlcB+Kt2fRAQEqzY5h5bpQzX9Evzu+q6ex94gv/icFUZ2+6cNh42bXtbjK01cv0ho8aSaG861i5E+FEyrNJtf3xrKUqahPvMHLnTKD30KHPQBDuIsZCbWLpoNK3tOahv2FMZHJRbjM5v3ndfni51ym+nmHeZyLHG8Vfja2cDP8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774788903; c=relaxed/simple;
	bh=H7cJnvExK6wXa2gDD8xmtwqb3/GWV7OBu6vFii/4yDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRLRGHFmnvnoPaNVUnouGsLe1m8bGMhijElPWbgGJOH5NhRZCwBVbzMqj9Y5/6mWO/nyvpyXPPgUsvURIH7m/9YDPOWa5puKjMJR7J5smuP33WExuoeCXITMMvK1EOknQEinHe0JArwtYn1HjB4wq0mFE5Cw2xvtDSdxfFAzCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kodUgOSg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kodUgOSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B088C116C6;
	Sun, 29 Mar 2026 12:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774788902;
	bh=H7cJnvExK6wXa2gDD8xmtwqb3/GWV7OBu6vFii/4yDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kodUgOSgZkBoutLShEGf2SJ0f6YsW5aCSowUmnHQ5dSVx11026fYgvAm8n7PYqoNk
	 2lnguRxiN+G8Mey4cqI+czKpqLvlvCrl2x8L8iKC2SGdMT/25eyQISQUkQ7WxgYHbS
	 Dx7QUv5rnM1u/K+SYNOaaDcwwE8QN6OYGZ3+dtW8=
Date: Sun, 29 Mar 2026 14:41:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: new device support, features and cleanup for the 7.1
 cycle.
Message-ID: <2026032924-unquote-mummify-aa06@gregkh>
References: <20260329130422.7f8481ee@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329130422.7f8481ee@jic23-huawei>

On Sun, Mar 29, 2026 at 01:04:22PM +0100, Jonathan Cameron wrote:
> The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:
> 
>   Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-7.1a
> 

Pulled and pushed out, thanks.

greg k-h
