Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CF733689D
	for <linux-iio@vger.kernel.org>; Thu,  1 Oct 2026 11:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855132; cv=none; b=JYCEdcY0KM1HQr1D2agzQ6EPf5NLMVHT44nsgyae3UPg4Wt2jn/5AMNJPqVlaROMUw8NbwhZ//8lKo1cDC6jdaR6aPNC85vQNTsRltQ3BC70JySaHSXoX0IJSST1KBrh9gmbYkPrzo1wwvMYpy1GjK28DyiMDa2WcKIz97+P7uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855132; c=relaxed/simple;
	bh=Es/kYM385wicUDrWlqRGmjbK4f3qEAzxIj0HH9bPWYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOxNN/TQIfD/Uob7rF88PmEfrkvTl3mdKphHgERumDH73u5U/2HFBhawntZs+Wfv6Dku3Dp1iNeIKDHzo2IN1QCnwmv37iznBoTVgST5sGQGjpHiZaWsI0tKzoO/EYuw1GUWbR01migxC7hZhrkzznpdzLgNApRUcMkgwD8t8oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uSix6RZL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uSix6RZL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58DD1F00898;
	Thu,  1 Oct 2026 11:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790855117;
	bh=/toOXVkDHHldUDas8/JI0aSIXjNySURlt8VP1LRj45M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uSix6RZL2uaFZikAIMNWI7eOmeoRvNP7VBfGb1d0N+WkicAaUwAPyPSVgrAnYjDjv
	 d0PcW2RqJDJU0oW1xxTgbG+6NOyISkL8qjP8+wi5LTFret+7O0Xd6iO7W5F5ExYQFt
	 GIHBmnnRw4wUv9iWHGUf7Kg15zai6WSua1/cvjos=
Date: Thu, 1 Oct 2026 13:36:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: First set of new device support, features, cleanup
 and fixes for 7.4
Message-ID: <2026100118-creme-gizmo-c4af@gregkh>
References: <20260930184226.723762b9@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930184226.723762b9@jic23-hlaptop>

On Wed, Sep 30, 2026 at 06:42:26PM +0100, Jonathan Cameron wrote:
> The following changes since commit 93f51579e7df248780214094418f205253383cc5:
> 
>   Linux 7.3-rc4 (2026-09-20 13:48:15 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-7.4a

Pulled and pushed out, thanks.

greg k-h
