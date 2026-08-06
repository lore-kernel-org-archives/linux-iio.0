Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8156341DEF3
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786007211; cv=none; b=Gcc6OAp4WbC5/S+XxAJdryGcB4YyGP/3GXgmMRIxFDfRlfk5Wo+68cpgq85kIDino1k90Xz7THkDGM7byeZKB4SHul/SE+8oZQzhzoKqZxMb9l536yTlaQvHZ16aDzOv5D0d4H33cJ+HGCR9KpVqSUFb1UfF34XAtqQx9ziWPIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786007211; c=relaxed/simple;
	bh=0w0WA2rrBe9VG9AnuKjelfdWhidXolD9/SJKXtw7h4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ye2r8bDD3xEyckCl7hPJae2P5V0eNEzK1HBCnTuW8tEtvF1jPJkvqhYAhPc6KQ8umJ21dcMzD0v9TeZbcH7TwIvF7O2k3C6o9nEiW92r+uL6bXlAiIAqTNSFdnPszhTnxDegX5nd01xSErl3L7hkOWofMxrCHAl/3UV/vhJ4hb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s4BAE5pU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s4BAE5pU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806A21F000E9;
	Thu,  6 Aug 2026 09:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786007208;
	bh=ZINjImkkMYzIhvmdoy3OAjtd+MJtku0NlTi4xbvCVqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=s4BAE5pUFip28wRN4oNLyjTn8ZGSOq0O3iXrKld/Unaiu884KAJgd9+at5HJ4Xcs1
	 7JtePrnzugLxq7jozOE2CKPapqsoxwnxx5EITygzhR3OwdD41spyr289RivtNCZHE7
	 bjE//BnXwDIg2gO3YwM5rHXMHuZkNtjPIA3tLhLc=
Date: Thu, 6 Aug 2026 11:06:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter updates for 7.3
Message-ID: <2026080623-tinker-ruby-f052@gregkh>
References: <20260805024420.1501279-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805024420.1501279-1-wbg@kernel.org>

On Wed, Aug 05, 2026 at 11:44:18AM +0900, William Breathitt Gray wrote:
> The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:
> 
>   Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-7.3

Pulled and pushed out, thanks.

greg k-h
