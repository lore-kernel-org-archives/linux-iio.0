Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201BCEACD
	for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771767530; cv=none; b=e4u+S7GDi3LQ+ai1/b25Uz/E3Dq57K9unvKypTi70whKLjJHwHbJT64y6yI//Dx9Gy1GMr3FM8BODvF7ibI7pp9fV3awJlPc/8wLaM4x/S27WUc+jWkQvYc3q0qm3tZMzB4kNzVXHaFpJ8tIECNv5o05wKPocgTpa/19Mn8+/w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771767530; c=relaxed/simple;
	bh=GxMAZi94AnKSqGudzInNd74GulMvvvOmq/tVGSbhNO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRqEA5smxGy0BDu/t5OFhXkPlVlwKSiMDIAOV1xAw2Xt8hvx/fKPEEn/IHwBwqagn5ZEt2ckdzmOGtMgblXJ+qv4nqaKxipBcEBp/E2qP8kVBCQMQF/tv0dzVffGiuDGa3uv9kcTcETf9eBgRAOaKU9Xi+tDtpox7YQODOn+8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asqjtfh9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asqjtfh9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9BAC116D0;
	Sun, 22 Feb 2026 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771767529;
	bh=GxMAZi94AnKSqGudzInNd74GulMvvvOmq/tVGSbhNO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=asqjtfh94rx3zha1BY3njJd6nhjZkjKPwzgLUqz2UIFNzk1MZ6o1EIkDKYUjCIajh
	 6UNX1Rv5DZazUGzYnRkilQ5WJEWtgmtyGZfUub5UjcxGG6Vn2r1XBhS/el2oy9CIXG
	 PK8E5l6Dwl2k9TmfkR3/uZaTS3HrLH5JLKp8bh3BP2ybhlws53QaaFR8eN3EFoOhUH
	 VQYz4GSQy3VswMaPv5bt4F0aGde2BbMk76BcWD/tOFhHF9DpUfTPcd7CTrQ0TaGmOA
	 3QIbaqpqX4dNZxDAyztuOF11OdMh0XsxCIvzWh8cbHqpEzbW09FD/ns+azL/+PuPiL
	 21ExrfB5XfmhA==
Date: Sun, 22 Feb 2026 13:38:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Almeida <gabrielsousa230@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: light: zopt2201: Convert mutex usage to
 lock guards
Message-ID: <20260222133842.075a3899@jic23-huawei>
In-Reply-To: <20260217143157.132799-1-gabrielsousa230@gmail.com>
References: <20260217143157.132799-1-gabrielsousa230@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Feb 2026 11:31:55 -0300
Gabriel Almeida <gabrielsousa230@gmail.com> wrote:

> This series replaces mutex_lock()/mutex_unlock()
> pairs with the guard() and scoped_guard() helpers in the
> zopt2201 driver.
> 
> The first patch reorders the header includes to follow kernel
> style conventions. The second patch converts the remaining
> mutex usage to lock guards and simplifies the control flow
> accordingly.
> 
Series applied with tweaks as mentioned in the replies to each 
patch.

Thanks,

Jonathan

> Changes in v3:
> - Split header reordering into a separate patch
> - Simplified control flow in zopt2201_write_scale_by_idx()
> 
> Changes in v2:
> - Reordered headers
> - Added required <linux/cleanup.h> include
> - Used lock guards in zopt2201_read()
> - Used scoped_guard() in zopt2201_write_resolution()
> 
> Changes in v1:
> - Initial version
> 
> Gabriel Almeida (2):
>   iio: light: zopt2201: Reorder header includes
>   iio: light: zopt2201: use lock guards
> 
>  drivers/iio/light/zopt2201.c | 44 ++++++++++++++----------------------
>  1 file changed, 17 insertions(+), 27 deletions(-)
> 

