Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F36F330D29;
	Thu, 29 Jan 2026 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706473; cv=none; b=KKvJUcyeaE49JjEDi5FUtbm2IftMSO9VQ0edue4t2vuGCwQmxHO+uizw50YoFlCevKSiqG5xK9MsgpCm3v+/BOdoswLcMBdpRYP0EWqwe965gh2kF7ZjFkncPndUhKpRDGgtjG4SdoHyQkgKc8YT5CcuztqYqClD2Vrx1TR8Dpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706473; c=relaxed/simple;
	bh=fNjvEkjxogCglGGUjyoAOVjtOd7Kfspt7SRSGjJ3dS0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaSaXN3ms1Urp2D1O5zgxxHz366Tk9suslg2DyoqECaASztN1HvPPKTMkccecQmyaHAzSRqnIFO2oqPCz7L64T4/tR1wWq1VXBAboYYQ6E3cg8O/MmD/OWX5ZNvXJeeyfC6GdnfUnZ6t1zrx637Vb9Ujr7Fvl0ncpCpMrm+UxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkf9qPNT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkf9qPNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BD8C116D0;
	Thu, 29 Jan 2026 17:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769706472;
	bh=fNjvEkjxogCglGGUjyoAOVjtOd7Kfspt7SRSGjJ3dS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kkf9qPNTI/oPTyKgJy46BZE5OBwJXP2v/hiUYt+3K1MvkRYI+pOB5gr7vO2HE+HdA
	 IlsRdQLS3So5M0YE05/OTlbjxONkxahtlNR9byjTk2qjqSzlgdzUysefH+a2r+B3cT
	 EfinMXuz1PUqnX6dZmNmLryb6/U2VJZhbRgEmE0s3jbRASYLRCb9/9PnAUTYQ6pkiF
	 56BbnpXEBnPmJ3aoA8unmsLkFNUf3O/dq4oyYrxEQfUUBMAuXXdOhFk9D5WYXd7aWs
	 NjO5we0COrCbvTYYNtLkgXnWGtYOnsqapum+K4bCGp7aA3TVVKcLYiAliDxC3qhWTS
	 dn/SAdeIat6yw==
Date: Thu, 29 Jan 2026 17:07:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Petre Rodan <petre.rodan@subdimension.ro>,
 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: itg3200: Fix unchecked return value in
 read_raw
Message-ID: <20260129170744.48f0ce06@jic23-huawei>
In-Reply-To: <aXuCclfJWLYkfF4Y@smile.fi.intel.com>
References: <20260129150151.127713-1-antoniu.miclaus@analog.com>
	<aXuCclfJWLYkfF4Y@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 17:53:22 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jan 29, 2026 at 05:01:45PM +0200, Antoniu Miclaus wrote:
> > The return value from itg3200_read_reg_s16() is stored in ret but
> > never checked. The function unconditionally returns IIO_VAL_INT,
> > ignoring potential I2C read failures. This causes garbage data to
> > be returned to userspace when the read fails, with no error reported.  
> 
> > Add proper error checking to propagate the failure to callers.  
> 
> Yeah, but when it's not a series do not use --thread!
> (P.S. do not resend, it's for the future now)
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
Applied this patch to the togreg branch of iio.git (given nearness
of merge window) and marked for stable.


