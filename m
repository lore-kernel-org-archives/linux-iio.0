Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B13DA7E5;
	Fri, 24 Apr 2026 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052151; cv=none; b=oGXInT8ggFgyG5OO3A6+r7sN6CiN8B32001Jdi474xYuJ4LX+2FLo/lf9P08SL8VVYVuLUbcbt+pIfDVIiY04FOlaOOGPLprDX3NyxoFh60FJd6zRLdWKToHdCZOA6cFf+tzgU6pT+SrXLC901qSdu7x0vyBOc+F55izXOWnU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052151; c=relaxed/simple;
	bh=7KiWMM9xOv1PM9y96Q+W0qq4NTP162/NkOiTHi+CnZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YI5NJ5QkaVv79n8J2zg/27Axh+og+e7xkc0jkAmEFjh2pD94y3Jhv3M81ekLcmDUYifmSuV1bEnJx9Zia42c4e2AcGzMmpvZlQtQmx3NEdm/stax8wXUYga49ifY+iLIIa370X98Vb6bBwsgrWcC/UkAAbCVJqQ4+ojJmuNxXfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMtRnAs2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMtRnAs2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A3BC19425;
	Fri, 24 Apr 2026 17:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052150;
	bh=7KiWMM9xOv1PM9y96Q+W0qq4NTP162/NkOiTHi+CnZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KMtRnAs2APTD9Lpj3PMc+u6/p+QWpg2juTrZOinYQEQZ/T8wuYH3MnZzWfWwfL8G6
	 ZSubmVwx1O2HVtRhf1guM4s4FK/B9bZo7YzZ2U5PPnasBt9eNd0ZHrDhTzJdQ8v8+x
	 GDBwPtm0il3olnJ65DA0EEpxyQ2E9F7njrqTqw0HrpSNn5EAGZyGLOi/Wpb828gRXk
	 /FORRCfoPrwdzkrO7g0yBi7dWymrDHtY/H5ftPhqMkk6D5mQbdqHhreT+j2n1Xq2eA
	 BTOfoSdRqL1w8OrWAw1WWcND9zAc3pz8LBHz9VT8R5X+ku9zEnhKY7I3YYSbJaKU+K
	 zz1zzQxsJswpg==
Date: Fri, 24 Apr 2026 18:35:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] iio: accel: mma8452: improve coding style, pm
 and resource cleanup
Message-ID: <20260424183546.0cbaf1e1@jic23-huawei>
In-Reply-To: <20260422165643.2148195-1-sanjayembedded@gmail.com>
References: <20260422165643.2148195-1-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 22:26:37 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Hi all,
> 
> This series contains a small cleanup and improvements to use modern kernel
> helper API and coding style for mma8452 accelarator driver.
> 
> The changes modernize mutex with guard(), dev_err_probe usage,
> resolve checkpatch CHECKS and pm_ptr macro usage.

Take a look at what the sashiko checker came up with.
Some other issues in the driver beyond the ones humans reviewers
have pointed out.
https://sashiko.dev/#/patchset/20260422165643.2148195-1-sanjayembedded%40gmail.com

Be careful though - there are false positives in the output
of this tool so check everything carefully. 

Jonathan

> 
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
> Thanks,
> Sanjay Chitroda
> 
> Sanjay Chitroda (6):
>   iio: accel: mma8452: cleanup codestyle warning
>   iio: accel: mma8452: sort headers alphabetically
>   iio: accel: mma8452: use local struct device
>   iio: accel: mma8452: Use dev_err_probe()
>   iio: accel: mma8452: use pm_ptr() for dev_pm_ops
>   iio: accel: mma8452: use guard() to release mutexes
> 
>  drivers/iio/accel/mma8452.c | 161 +++++++++++++++++-------------------
>  1 file changed, 76 insertions(+), 85 deletions(-)
> 
> 
> base-commit: eade2b843d9b1f668fc1775f15611bb0a1999cd9

