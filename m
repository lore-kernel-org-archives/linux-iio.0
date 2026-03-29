Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD65375AC2
	for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790279; cv=none; b=D3Hd898YNArl8lomoFz+yZAXmg/C43xEAQJwEeE5Zt9lgAJY/uudHwZ9LC4bjxNfVKuFpV/27d1eJ452xU+ZiJB0tMeVoSa/RFSMdqaATKXhc5Kie0rFWn0MOgSzAY+Y4Z2640rx5v83mVlCi6UM2sfM4Y8l0ZwzfN9EG4Cg7VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790279; c=relaxed/simple;
	bh=seobenN/DLh4xzZN94TUK+v2EQngrnXjUfcaRiUvgx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orGTja6nngmtBVUwN2ikVmlAkPv2pyHYwV5logIIP8+hAXdF+Ksjrz9Ey0XUhHclUkSMBIKLd9KcpgdcqRc/S35mQA0PRQ+MuHfALSy0GHMO819rX70knEdqYQmkLc28ivc1ebspAUW/XktXOzqgru+v08M9oIgATZ3YAC6oV1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hn0o3s1n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hn0o3s1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8EDC116C6;
	Sun, 29 Mar 2026 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790279;
	bh=seobenN/DLh4xzZN94TUK+v2EQngrnXjUfcaRiUvgx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hn0o3s1nvASeSACo+xFhfc8vv59JDdrBDWHpeXFOCtGqqmNvvz623VEbloOdspxQO
	 hEh9ZqG9aHU2uQnsyemxribAqksNuuoF2TMlndKKKAUnqzlrbv4/UfKCKzWb5LyUwg
	 Q/wdejd1dNm1fHXehacPoGPEaXRT67GpbDNsDGkg=
Date: Sun, 29 Mar 2026 14:49:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: new device support, features and cleanup for the 7.1
 cycle.
Message-ID: <2026032953-untimely-dimmed-c746@gregkh>
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

Pulled and pushed out, thanks.,

greg k-h
