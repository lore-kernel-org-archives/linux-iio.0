Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816362906
	for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2023 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gNxtDh7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53CFCC433C8;
	Sun, 31 Dec 2023 10:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704017610;
	bh=OPy9hCf1ZYjQzsVJkSNU83ONm6wqHAMMfHK3raBdIa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNxtDh7ZRUGmGCIboSPbMO3TxI1VeX6xgaGxDRbfYDdqYg6/H7Kf5DZxP8d9eKLWx
	 hhVnjaNgXz+j/2Vn9nXmVi4amk35jCNcMbNvToC1frR9zYFaF4mgGJOXcA/qlrn7Iy
	 Mf34OLz6nvk2ApVzHF9tgtOrrnzbohVzfoZYqgso=
Date: Sun, 31 Dec 2023 10:13:27 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of new device support and cleanup for 6.8
Message-ID: <2023123119-glory-bodacious-f5af@gregkh>
References: <20231230122338.3b303a57@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231230122338.3b303a57@jic23-huawei>

On Sat, Dec 30, 2023 at 12:23:38PM +0000, Jonathan Cameron wrote:
> The following changes since commit e9215fcca2561b208c78359110ee4009b454f761:
> 
>   Merge tag 'w1-drv-6.8' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1 into char-misc-next (2023-12-21 11:23:10 +0100)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.8b

Pulled and pushed out, thanks.

greg k-h
