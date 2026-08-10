Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB928F5;
	Mon, 10 Aug 2026 00:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786320210; cv=none; b=TKM899aarMgrjRhC4Wq7SexWpha5VWFHZnU7lYxoOR3TDjCg/OXEw5STtTBEVfRc9IAZGlWj5Mv17rp9vhmNuhYP+Ev6GTfrUEmeXE0ez4a2/kz/g8rdiDymZVicZrXy2mh9nbyJRegcEN7ryf/9nmVBhQ8tqkzkN9iI2UlLx60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786320210; c=relaxed/simple;
	bh=aj0hwP2BqYi4Sq1br4wTom8OaK1FgTQfNehPDsaeo4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u90AX2hVjyfJaeg8jgr8e2HwePgNxiT6ykwhvAhidBBCcYihUVD/5EsFrbP45rBx0hdjajpAOUNlVtA5pONf6dFDBSLrZHNIspzLnJJA1npwqsnnNz6AJwmMaUHqQJk+H3FgWuTZXOmQ6dmaeNVSA9Y2lZs7m0XYtgCGFi+a6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjZlTn64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjZlTn64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8438C1F000E9;
	Mon, 10 Aug 2026 00:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786320208;
	bh=Wj2/kCKMRQMn+Rij6u8iF/sXzy5G2Li7kT00oBRfI0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UjZlTn64A1/JorU186Y3LU3twyC5vy8nZa5/QwCuR0YPNYwz+5AzrBGncQLzVN6kB
	 V1SMSF4UB+xPqwiKBeR7CkHH9zO6YkckSu5cq8VEovfFlbauy+h+UaBO0uIDFs3Ji+
	 EWauhtlUpHXq4+mmQkJ61wxSsbx5slVniwFivSpYo/WtDbmsfkkQOqNJJE+eNMc9Ns
	 z30YFF4T2Jbyb5ZHqM1EGT8oGUqMkKqGom7ZSx0rCOZff01OKV5D/fka1JVP10NO+h
	 Ws1lxcBdM4uYcTtdKFxLINLoA6MEF4uRiZiGIHgLoY3dN618npISdScimtc0h99ziN
	 +CYS+yguBebKw==
Date: Mon, 10 Aug 2026 01:03:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda via B4 Relay
 <devnull+sanjayembeddedse.gmail.com@kernel.org>
Cc: sanjayembeddedse@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/4] iio: accel: mma8452: use modern coding style and
 resource cleanup
Message-ID: <20260810010326.3135992c@jic23-huawei>
In-Reply-To: <20260808-15-apr-pm-iio-mma8452-v4-temp-v5-0-d177e93ce3f8@gmail.com>
References: <20260808-15-apr-pm-iio-mma8452-v4-temp-v5-0-d177e93ce3f8@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 08 Aug 2026 22:28:12 +0530
Sanjay Chitroda via B4 Relay <devnull+sanjayembeddedse.gmail.com@kernel.org> wrote:

> Hi all,
> 
> This series contains a nuber of small fixes, cleanup and improvements
> for the mma8452 accelerometer driver.
> 
> The changes modernize macro like mutex with guard(), bulk regulator,
> IIO_DEV_ACQUIRE_DIRECT_MODE() and etc.
> 
Applied to the testing branch of iio.git. Note that branch will be
rebased on rc1 once available in about 3 weeks time (and maybe
I'll rebase on intermediate baselines in between).

Thanks,

Jonathan


> Changes in v5:
> - Drop the PM runtime handling patch, as suitable hardware is not
>   available to properly validate the PM state transitions.
> - Apply reviewed tags.
> - Rebase series onto the latest iio/testing branch.
> - Link to v4: https://patch.msgid.link/20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com
> Changes in v4:
> - Part of the series already merged into the IIO tree; rebase the
>   remaining patches onto the latest iio/testing branch.
> - Link to v3: https://lore.kernel.org/all/20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com
> Changes in v3:
> - Following input from Andy and Jonathan added new changes as following
>   0001: handle return value to have proper error propagation
>   0002: use non-devm API to maintain resource management LIFO order
>   0006: convert individual regulator using bulk regulator API
>   0009: use IIO cleanup helper for DIRECT_MODE
> - Address kernel coding stype specific review comment
> - Reorder local struct device and dev_err_probe change
> v2 series -> https://lore.kernel.org/all/20260422165643.2148195-1-sanjayembedded@gmail.com/
> Changes in v2:
> - 0005: address review comment from Andy and Geert
>   and use DEFINE_RUNTIME_DEV_PM_OPS macro
> - Added new cleanup channges in mma8452 driver
> 
> No functional behavior changes are intended.
> 
> Testing:
>   - Compiled with W=1
>   - Build-tested on QEMU x86_64
> 
> Feedback and reviews are very welcome.
> 
> ---
> Sanjay Chitroda (4):
>       iio: accel: mma8452: convert to bulk regulator usage
>       iio: accel: mma8452: use local struct device
>       iio: accel: mma8452: Use IIO cleanup helpers
>       iio: accel: mma8452: use guard() to release mutexes
> 
>  drivers/iio/accel/mma8452.c | 145 +++++++++++++++++---------------------------
>  1 file changed, 54 insertions(+), 91 deletions(-)
> ---
> base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
> change-id: 20260601-15-apr-pm-iio-mma8452-v4-temp-e040489abec3
> 
> Best regards,
> --  
> Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> 

