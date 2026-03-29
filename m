Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8EA3644D3
	for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790916; cv=none; b=Z8iqvk6CK62RwpnL6jaafNy8ohD0UyJ+nXemz2NzCSHHOfVYW0aqWG3ZE9/a3Zt7ITp8kakKywNxGWocFV3ZEcqQ93OF9g0bdFEMAv4Cd3SIxzF0B6W+aImDarCEaJiSNa32X+dPXMw13Dcrpo+zfjBO+JdIHwpZdORTMpIiWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790916; c=relaxed/simple;
	bh=04CXUzZXYtG55ff1JEgTZdQIxC1FnHWfqxjZyYnD62o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/6TsB3K3979tRwuB+spublhjLAuaaJ12iYJmdGzbw7DXlSzwjiPRN7Y848U1p1pRmpK8Wr0qx+LdBPpPwYSOwTRxmf+9s4rXV07BeRpXpmkt9pDPsU1JdxjGrUZ1lGNH4KTT24gVHBBkNOFEI4Lq9eCA4YVBlFzDErUnlCJ8RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zWZ9/Xr+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zWZ9/Xr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0A4C116C6;
	Sun, 29 Mar 2026 13:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790916;
	bh=04CXUzZXYtG55ff1JEgTZdQIxC1FnHWfqxjZyYnD62o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zWZ9/Xr+Zp97AP/N2LLeEt4YWrh4ribQwSGpOhP/V8QhGvjD9wRRBrLAJm9asgugz
	 bmHSDRx+NIaaw6bIDvcwpz0DebTbyn1bx14l7UdpLgWR5rrSwOywo/mtzPXOTyyvn0
	 6obOaxC9g5dFDCA8wHv2VBQ9Vmq0x3R3PkTam2B0=
Date: Sun, 29 Mar 2026 15:27:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 3rd set of fixes for the 7.0 cycle (or 7.1 merge
 window)
Message-ID: <2026032932-savanna-deport-0bef@gregkh>
References: <20260329141456.0860794e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329141456.0860794e@jic23-huawei>

On Sun, Mar 29, 2026 at 02:14:56PM +0100, Jonathan Cameron wrote:
> The following changes since commit ea7e2e43d768102e2601dbbda42041c78d7a99f9:
> 
>   iio: imu: adis16550: fix swapped gyro/accel filter functions (2026-03-07 14:11:30 +0000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.0c
> 
> for you to fetch changes up to d0b224cf9ab12e86a4d1ca55c760dfaa5c19cbe7:

Pulled and pushed out, thanks.

greg k-h
