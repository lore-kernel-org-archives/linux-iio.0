Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56436373C0B
	for <linux-iio@vger.kernel.org>; Fri,  3 Apr 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775206442; cv=none; b=KIty7L8whZhn6oIAGjy8CJPaCJ7f9HkEc9SdUdK5Epk2zJV7OALmQkRpYI8jX2JX08uBFrx/HRAvIBVcVybmd9jFjQjW6+6Zmtbz/l4aO+UDEEIvHLHWE1e/dDlRhzSzbKueJdpCgex7dh23fsmoJTlpN4TkioQRokeV1nSOpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775206442; c=relaxed/simple;
	bh=L+cV7GB8Tn0+DZKIdVl+458ZupfgKi1zlpqMKt2hLuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVClCm/e0olKnrv2Cue/6+kW+kpPpqzmNyG/KAZ3lyqvXsXheZxrVqk0hzpH+V4+be+4oY6QIJaGLPtVW1RCqhCAZvRA2GFTeZbeq58+OW0PQskML6zwHZLfAgSx2GUdG4DAZo5+y+wgZSvsaHb/X/etE6l1UHvnXy7GduBpWWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EFYdobxg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EFYdobxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD83C19424;
	Fri,  3 Apr 2026 08:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775206441;
	bh=L+cV7GB8Tn0+DZKIdVl+458ZupfgKi1zlpqMKt2hLuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EFYdobxgvWCstgPaDEAzuTFcOUK3kqDPmvGFoghKYPqlFL7HoGVbTIkKu89jbykwu
	 9vmH8dEW3JUMWW/IhwDDwpg2J1MhuUhGe2WBzdvrVtaduArMH1HPFWtRUAEb5m92k4
	 p38iGW4tWM0Fxm9mQZ7F7W+U237JvichkV/Qgvhs=
Date: Fri, 3 Apr 2026 10:53:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [GIT PULL] Counter updates for 7.1
Message-ID: <2026040352-overdrive-arrange-05bf@gregkh>
References: <20260401122740.2018309-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401122740.2018309-1-wbg@kernel.org>

On Wed, Apr 01, 2026 at 09:27:39PM +0900, William Breathitt Gray wrote:
> The following changes since commit f338e77383789c0cae23ca3d48adcc5e9e137e3c:
> 
>   Linux 7.0-rc4 (2026-03-15 13:52:05 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-7.1
> 
> for you to fetch changes up to cbf8db23fc58db8d516ebc7aa57c4563f36532b9:
> 
>   counter: sysfs: remove double return in counter_sysfs_attr_add() (2026-03-21 22:41:51 +0900)
> 
> ----------------------------------------------------------------
> Counter updates for 7.1
> 
> A cleanup patch for sysfs to remove a superfluous return statement in
> counter_sysfs_attr_add() that was unintentionally left during an earlier
> refactor.
> 
> ----------------------------------------------------------------
> Cosmin Tanislav (1):
>       counter: sysfs: remove double return in counter_sysfs_attr_add()
> 
>  drivers/counter/counter-sysfs.c | 2 --
>  1 file changed, 2 deletions(-)

Pulled and pushed out, thanks.

greg k-h
