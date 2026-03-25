Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6BF1CAB3
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457731; cv=none; b=duQ8KO5ee/HLPl7mVKRSQuFo6IACQ9VQ6xsTiLfFoaz33T/usZo8Z2cfU50Z6YeJcT4sRCe+rcBOCdsVvSyWZode3yOd77bFwIJ6QWXM9S3iWaY8acXrhC4OGlj7qZK6PytMPBz5XeDIBWjE0cqvI7bq4Yb6vYDBByrmrmxaK7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457731; c=relaxed/simple;
	bh=jqfF1+DXXtVUJib8uSS3mfYbmBpfGbPi1+2rMLPuhTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9MiRv68VBBBvBSNuTvGFI56IkPIfDNMCsiCM9sjxqYUhVXHf6WIIJfOAq74TBjipzN/UwPR3UKILqtYCpppzjUW5eXhYRykuK47umZxofszAanq9OT6+AYy/I8s91ufhb5tIRG5mf9nbULjd2HWV1Z7LpvAkb7nonlWIoBC+c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GxscmjEO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GxscmjEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA9AC4CEF7;
	Wed, 25 Mar 2026 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774457730;
	bh=jqfF1+DXXtVUJib8uSS3mfYbmBpfGbPi1+2rMLPuhTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GxscmjEOsRD/CzZQ4m0kdscwl/HyXXSxxAc3VclypN9U0EFXsO1tawGDio4FDPoK0
	 VDTJicBJ78CdNW3pWpe9GD3InF4FNda+K8fQDFx3I+8IoezCD64k3KeorpfPkD+YeL
	 9z0zrOnI5yriD4pJlbOA5Y1ePhqI3Vn4Rf2kVZOU=
Date: Wed, 25 Mar 2026 17:55:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of fixes for 7.0
Message-ID: <2026032550-rimless-dreamily-56ab@gregkh>
References: <20260314110912.7f512f0a@jic23-huawei>
 <20260325163655.1d86e429@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325163655.1d86e429@jic23-huawei>

On Wed, Mar 25, 2026 at 04:36:55PM +0000, Jonathan Cameron wrote:
> On Sat, 14 Mar 2026 11:09:12 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > The following changes since commit a0b9b0f1433c845bda708753db32befef78e0f1f:
> > 
> >   rust_binder: use lock_vma_under_rcu() in use_page_slow() (2026-02-26 21:34:14 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.0b
> > 
> > for you to fetch changes up to ea7e2e43d768102e2601dbbda42041c78d7a99f9:
> > 
> >   iio: imu: adis16550: fix swapped gyro/accel filter functions (2026-03-07 14:11:30 +0000)
> > 
> Hi Greg
> 
> I think this pull is still outstanding.
> 
> Given I'm travelling next week I'll probably send a final fixes series
> out at the weekend (in addition to this one).

Ugh, yes, sorry, I'm traveling this week, will catch up "soon"...
