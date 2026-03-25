Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BFF352C54
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466309; cv=none; b=NM7Vmzdfij4c7jo+sv9ZIsl5WwqkYLqsSTJWq2SZ7J98rw9gWCI/zvNs+aMSd+oau1wog+9t7rcTn8hCs2Y8szvMNyQ4CLeYIDdqrxbwGGXv0kj0AEVncaNXHSu4a4JSuBdq4HPjTdnJm0yLeQj1YSHKIZrnzAE/yrFVORc1Qtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466309; c=relaxed/simple;
	bh=82pPNmUcaBNt99gaClBOpkwFwxKRaVcm90OINPFYrno=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQR9jhiFHW312wiv5NcN2mtCh9SsExlEzr4ZEz7DlckkUcgfxvEiUEObrIB4pOWPRY0TPt9+jCPrTlCPti/fZuSl97yRlIZ58HAio8Ag2T2MKFEvwojtimM1WxYu7lMLAUO0Hz+Fntj6bH889XG4Bb6/740BEMOgj5e+ujkbPwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzJIQAgW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzJIQAgW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5985C4CEF7;
	Wed, 25 Mar 2026 19:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774466309;
	bh=82pPNmUcaBNt99gaClBOpkwFwxKRaVcm90OINPFYrno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dzJIQAgWggKIbvc89Ye2FolDGLwF2fCMRFDZ79AKsH5ZvwXS+U+z5mCPA7DrrCxjw
	 MMACcRDddMon7a+ZwLbKFrpZZBEowlK9sboj7WGurN39cmhMMGTPPGXGKcOkK46U+T
	 0f1DXuV8aHYCtWJomTfO2WZvhiWNW02ds/lfL08xX47HA9kgriWpaob6tX3A1vkhuy
	 IUikZZyhuWLxUXn/W8JqutxzHBd9oG22+WY7ffXGUitu9nIYz5fPQuyk20dw+zSCTz
	 MxoRwB/DEIW8jHo9V9V2g6vOiet828Jc3AGqkPFryPmJhfQCUxxYvcKdXtrYr6UCzx
	 x7TIUvY2CoM0Q==
Date: Wed, 25 Mar 2026 19:18:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of fixes for 7.0
Message-ID: <20260325191822.16bf4bd8@jic23-huawei>
In-Reply-To: <2026032550-rimless-dreamily-56ab@gregkh>
References: <20260314110912.7f512f0a@jic23-huawei>
	<20260325163655.1d86e429@jic23-huawei>
	<2026032550-rimless-dreamily-56ab@gregkh>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 17:55:07 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Mar 25, 2026 at 04:36:55PM +0000, Jonathan Cameron wrote:
> > On Sat, 14 Mar 2026 11:09:12 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >   
> > > The following changes since commit a0b9b0f1433c845bda708753db32befef78e0f1f:
> > > 
> > >   rust_binder: use lock_vma_under_rcu() in use_page_slow() (2026-02-26 21:34:14 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.0b
> > > 
> > > for you to fetch changes up to ea7e2e43d768102e2601dbbda42041c78d7a99f9:
> > > 
> > >   iio: imu: adis16550: fix swapped gyro/accel filter functions (2026-03-07 14:11:30 +0000)
> > >   
> > Hi Greg
> > 
> > I think this pull is still outstanding.
> > 
> > Given I'm travelling next week I'll probably send a final fixes series
> > out at the weekend (in addition to this one).  
> 
> Ugh, yes, sorry, I'm traveling this week, will catch up "soon"...

No problem.  I'll just stack them up!

Safe travels.

J
