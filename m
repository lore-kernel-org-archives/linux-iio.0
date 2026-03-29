Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B279E37474A
	for <linux-iio@vger.kernel.org>; Sun, 29 Mar 2026 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790289; cv=none; b=Vh4vSbATucHlc0IbbyWA7UPKDJ3LRMrrxIcX2qHy3YlKpuxQPH+q3AE3bi7f98mEFvI7mU/v1Rz8qU237DX9FQaamnoDSfD2SJxdFkiEGPEqGxku1b5nEXX+RHseXwaxGG8d4zB81dWeJcginEwDIY6bV9VKcFQsGTVwl4ebebA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790289; c=relaxed/simple;
	bh=eApb5MD+5Z+HkOZ00xPQFiTDaP1KOTGq0sr6nsG584U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDQTiIJe7yyJEag/q/Ye3xdS19TmGlJ4Lw1/OfihO/KD9Njsefp0MwWkzuWfsCmbCV0qZdrWD2Efug9oXD+pRWySG7Sn6xev3iIsLlxT/58JVQ911U6rU9jcBYR+YX4mVZd2idZWRJu1Wlm9wFUgPc68F+PmK+Nb55jyF9K4mUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bWprugWn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bWprugWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD0AC116C6;
	Sun, 29 Mar 2026 13:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774790289;
	bh=eApb5MD+5Z+HkOZ00xPQFiTDaP1KOTGq0sr6nsG584U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWprugWnVd+WkggPVgidBwsNbDPNoltPdD6w4JG90ofbWNz6YxZLMX7Xl1NkF+wYk
	 UKyFJ9eAr5WXxAB0Z1pfYmu+QyyjrIEC1gTbsDoUrj+Ton1MHQfkimTz3OCX9Q1gcx
	 2Xx3JAOkJZjkERHEI8+OU45Q9OvuICVWqt820TUE=
Date: Sun, 29 Mar 2026 14:50:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of fixes for 7.0
Message-ID: <2026032900-mastiff-bunkbed-4042@gregkh>
References: <20260314110912.7f512f0a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314110912.7f512f0a@jic23-huawei>

On Sat, Mar 14, 2026 at 11:09:12AM +0000, Jonathan Cameron wrote:
> The following changes since commit a0b9b0f1433c845bda708753db32befef78e0f1f:
> 
>   rust_binder: use lock_vma_under_rcu() in use_page_slow() (2026-02-26 21:34:14 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.0b

Pulled and pushed out, thanks.

greg k-h
