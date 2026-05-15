Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFB47DFA3
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778845626; cv=none; b=F0APptMmrSxlqBsjWE5zNYEqaUcGZviUVEaSNYLzHmbAwAXz8BciqpugoV7rTQCw/C5fT0IdIXsQDFdiLh+ziP0WEFTHFNW8rZ9/Jti80DNzSdr9KsaJBR5lMEWyXcmXuqV5Mt1PsRkuD2L24ojWAFUi/DS1TbYQgYwLwtgweDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778845626; c=relaxed/simple;
	bh=h6GT7AJzlvA8qhterXWX2XQ1tOHBI8GdL3Qw8FIEojI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkD/x/f9eTzEMKMIGxiE6O+/7xWShX6lspM1eO8JZ3HuzNG7apXfv0gD+K0JfuOqGs3MDLhYN4qMleOcLEtJLmEjz0dY1sv3gLpirLqeVWc0nFvXid8oXHRBZCsZ1avf+VRlAqLACpvENM5HNkau8fZD+8tccka4c9Lq7QWZItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gkAC93fP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gkAC93fP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD10EC2BCB0;
	Fri, 15 May 2026 11:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778845626;
	bh=h6GT7AJzlvA8qhterXWX2XQ1tOHBI8GdL3Qw8FIEojI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkAC93fPRQufxquqJgyZGFw61fgpY9v0N8itQrW63Xz58UFsFY0eW6MYmwMt2qO7N
	 FiQIhslYiBlpFe6EOcJgiby47gKgAda4pVE/vZLjfL9bXJ3hczjKJNU0+6qxDFlQld
	 wlsj3ovryeWTnhcHRgUVa+uKwnMiM9tiSIJYv6MA=
Date: Fri, 15 May 2026 13:46:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of fixes for the 7.1 cycle.
Message-ID: <2026051554-guts-dental-fab5@gregkh>
References: <20260515121157.4bfc1195@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515121157.4bfc1195@jic23-huawei>

On Fri, May 15, 2026 at 12:11:57PM +0100, Jonathan Cameron wrote:
> The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:
> 
>   Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.1a

Pulled and pushed out, thanks.

greg k-h
