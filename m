Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7A2E06ED
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125596; cv=none; b=q4jm5RZF/5ujK7qAHCpSU6IyTvmM2+mkrjqwe+0MXw6jDrmIes6GXvxClbSQZRixJfiSEhcK/WhvAaSGqc162XiwckxYhHz4ZevF0gd8p/K/1z35ftAZCOllhjXjdilBJ279lWfFOxaxe479tqDKZJ53QY4vSnZlWv2dODKhVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125596; c=relaxed/simple;
	bh=Y0kkXbx+2mZMPMht5x4+xxdz5JCC3f4mU6oyQNd1tyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5M09JYHw4n/e4udQDWRyWY2S/KHDyVg80Us0sDSQlO5vIXP/nzkvTLVhf6OgEJJc/Otn2Buth/68/y2QkvGofV9VRSVVoOpnHgYE+iyiU45XxOsjEFzukmaEYtddHiMOpgzSFUHHYw81sgmeHUf0bQm2gyObH7C5Rf6e3qXpoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F6RobUH8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F6RobUH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B9A1F000E9;
	Wed, 19 Aug 2026 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125594;
	bh=3/uvODQAnz02VHyPGtt46v1MBxPXw2ZkATE04+Ok0hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F6RobUH8ikP9EUq2d9u6mSzGnVf8yEUSuiqTiWGmNvQVrH/C/xQp730HLZ0Ju7ZJL
	 JhkmadmhTSrHgJcPF0Aq2JS1g2PVuPDgU51q7lnijcNhjJ682suiiFl45DBkVxmPaL
	 vJLMKYSz2WSywp/1B+3UmGGJ474ImK8SU/yDNEhs=
Date: Wed, 19 Aug 2026 09:44:13 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL v2] IIO: Fixes for 7.2 set 2 (probably now for merge
 window)
Message-ID: <2026081904-domelike-suffix-19ef@gregkh>
References: <20260807235501.68268be2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807235501.68268be2@jic23-huawei>

On Fri, Aug 07, 2026 at 11:55:01PM +0100, Jonathan Cameron wrote:
> The following changes since commit 3585cfd4563731a8ae406b32807613c667c2b887:
> 
>   Merge tag 'iio-fixes-for-7.2a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2026-07-09 07:44:06 +0200)

Sorry for the delay, now pulled and pushed out.

greg k-h
