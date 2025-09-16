Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C8272E4E
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011433; cv=none; b=Kidx5F/Sac/kQSHwQykzuyjEdcdkhFSXYp7E4kGStlxkJ7OOO9/l2CFycYkHFzPHyHGdPJLl1bzoV3A9mN1gEC73wvPR1p7vz/RNPiuuywZ9HjquNQ5VYy0u2dPRgDFYKSgRk8HM6blAmJOyfK5EAff0VE8jxDJ5oHaSfud5WLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011433; c=relaxed/simple;
	bh=IuyHmQkLMOMCzw4cumyjLyhjiLVvG3GlSkdRuKJsKV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnmMSHwNMXo+gR/82rNek17hsG6vnZ6GgXgS+NpGfvWJkjQOBRI4/LyIVYI+IPwobF1zbne9UaEJ9895SmuU6VSe20AiwRiCiSleSgUZRsUu7ZuPxVSwHbl0Ni0E3GmxelYk/aXWreW35cplYXk/+B32nW7Uky4yLlMh5xaGlAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RHJGhrw0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RHJGhrw0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A670C4CEEB;
	Tue, 16 Sep 2025 08:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011432;
	bh=IuyHmQkLMOMCzw4cumyjLyhjiLVvG3GlSkdRuKJsKV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHJGhrw0oKM6EmE2o+b70vaw1g7FM+58WgSkAJgt6Ci4p1ARQi1RNC0EpnwCDs0h5
	 hlp0/+FayVUkZrAJEXKse1dHytXomgQn3SD2IQCKghhv2Fvl7aa/yl1DbJ2XbHmfM6
	 Gbzex8QtDnM+5Rqg6H+Z90+p6oZAFU3hVf1u3Ve4=
Date: Tue, 16 Sep 2025 10:30:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter updates for 6.18
Message-ID: <2025091606-void-salon-9a84@gregkh>
References: <20250916050056.1399921-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916050056.1399921-1-wbg@kernel.org>

On Tue, Sep 16, 2025 at 02:00:53PM +0900, William Breathitt Gray wrote:
>   Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.18

Pulled and pushed out, thanks,

greg k-h
