Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D98128030E;
	Sun,  2 Aug 2026 02:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785636379; cv=none; b=UiMLd5N6RpK1Z2OzgkKjOK1il8oB6oAwXQgEsu+ggqASYCOYucgepGeAxFU1oXErpso3uvU0MZCeb7PvGvh7ggeryjWDjg77n55jddlrSPpJh1ZvIxj6QFDwY/fmLi11z8Le4FUl7l6/TbhHdp2L6fY9k9fWMsY5H6RGvZ8S7Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785636379; c=relaxed/simple;
	bh=3e41xfqffCnZ8UWpLqUgGI9WJBRF2IsAXh0LAzMW4eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPbjdPniBdVg0faQcfbWV8FY3WzFCA/FwmPAMzNIODGZUbzuFGMoDGsXZV7sIHobOtHKxGpFngbE3qiMeBRKUhyNhuqc6qOjdMoSced2nqA69GWRMZrMHCPmTGDJh8tg22PLAxEkUqsiKG/byHf33dW9g4VhVxNy+a3kwmAV3DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBrorHX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBrorHX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE731F00AC4;
	Sun,  2 Aug 2026 02:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785636377;
	bh=yP//XZWU/wam33jmY64c/D2Purb8/lgGfb2RqvHbImk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NBrorHX6yC0XB9s4ldhhiPekP+dmM6FpcmAsvJ9WC2+QgobXirBV19XRbK9YUWqYv
	 QTRNcN/iUB2YIUiwz4RxWx2z1wq1QPFc8wySSWloanb4idmiqkuy2Wadzt+rRIrgIn
	 U++90KXMtyVRHNueIneB+FC2QHvFSbTWliEthLHtCrZrO2K1b82NJ1+l6vv3tJwj4K
	 rfnqKpvb7empFEYeTTtUsrYwscCeQ3luhA3v10HIb2BY9KQNyThYmR7zkZZ1VAIBF5
	 22VWT+yQCpD57cZn/eGDInOC/JdM15VMFzPJbyz4AJPZWiXoFVaM24dWAFuEHJGQp4
	 tbVA+TVDwgHJA==
Date: Sun, 2 Aug 2026 03:06:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: mdshahid03@gmail.com
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Joshua Crofts
 <joshua.crofts@broadcom.com>, Broadcom internal kernel list
 <bcm-kernel-feedback-list@broadcom.com>, David Lechner
 <dlechner@baylibre.com>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>
Subject: Re: [PATCH v4 0/3] iio: adc: bcm_iproc_adc: Simplify probe error
 handling
Message-ID: <20260802030611.363c6aee@jic23-huawei>
In-Reply-To: <20260801090953.61603-1-mdshahid03@gmail.com>
References: <20260801090953.61603-1-mdshahid03@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Aug 2026 14:39:50 +0530
mdshahid03@gmail.com wrote:

> From: Mohammad Shahid <mdshahid03@gmail.com>
> 
> Hi,
> 
> This series simplifies the probe error handling in bcm_iproc_adc.
Hi Mohammad

See comments on v3 + slow down. It wastes your time and that of reviewers
if you post new versions too quickly.

Jonathan

> 
> Changes in v4:
> - Move the redundant iproc_adc_enable() error message removal into the
>   cleanup patch as suggested by Joshua Crofts.
> 
> Mohammad Shahid (3):
>   iio: adc: bcm_iproc_adc: Remove redundant probe error messages
>   iio: adc: bcm_iproc_adc: Introduce local device pointer
>   iio: adc: bcm_iproc_adc: Convert probe error handling to
>     dev_err_probe()
> 
>  drivers/iio/adc/bcm_iproc_adc.c | 54 +++++++++++++++------------------
>  1 file changed, 24 insertions(+), 30 deletions(-)
> 

