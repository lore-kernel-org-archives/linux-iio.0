Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF900301472;
	Wed, 25 Mar 2026 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468508; cv=none; b=H7Drwkk2/2FAm8KM08TLma0C5BFT89BoJgICXEUEB8VduEYkgsqnlNzjAqXW0uprK2Upzqgvx9FgHVyle/o1U1/PRmW2+GC9agaXePadtHboumVbRBaXaglabRtVpy507W2kmq7wCjlk1SuvJHX1okSNudz3pqLXZNanlYy1JiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468508; c=relaxed/simple;
	bh=nk5rzCWBHsVFdw1bbI5wtmkuA9oMDHkpof20vU7+TjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1f4LZUzanScWCGMk87r0wFoEHHnVWEmOVgpYZNaR5tWSNfLhskAkghomX6fXRA/2K5iVgd13n/PzXTmkQWkMUG1DX8VmcaMKY3mRTWoGlq9pPyKxxhAA40Jr8kRKVJYU8IuvTzPrrAQipSoQoYomHyXTfwy3EOWzTgU91QEjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNoQ9buw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNoQ9buw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18650C2BC9E;
	Wed, 25 Mar 2026 19:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774468508;
	bh=nk5rzCWBHsVFdw1bbI5wtmkuA9oMDHkpof20vU7+TjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MNoQ9buwJ0NPgoDDLsCvF16rriLx52O/uKNUBsuKStvzh0xdRWRk4nMOUtIkp+DdU
	 jH2zzt2MZtsoFxEkURYF2tWBdEbSWEf8mOuTFZ0KyEACKxkDi0YyovoFNq9sBfW/1C
	 5VEAeKiad2989c+zNbtiegocUNZX6UkJZY+nG+KSBepaqMZt6Qqv2eZEccigZGNOXy
	 5WFUYk4iDgLnVQp2dT1M9is+98lTwFhtTNAyGB1UcHcsrFXCexfqHzM+3YgpMhdMz/
	 /SpmY6FLviwtyTwVkneDERImrt+03QKzvp9PpUnJL2yfr2rJM/JsdDg+kUyDePgSBz
	 3vDd2PhovM3Ig==
Date: Wed, 25 Mar 2026 19:55:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Francesco Lavra <flavra@baylibre.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/6] iio: imu: st_lsm6dsx: Fix check for invalid
 samples from FIFO
Message-ID: <20260325195500.56f01bc2@jic23-huawei>
In-Reply-To: <acKAx34s1MStfy3G@ashevche-desk.local>
References: <20260324084655.653781-1-flavra@baylibre.com>
	<20260324084733.653906-1-flavra@baylibre.com>
	<acKAx34s1MStfy3G@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 14:17:11 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Mar 24, 2026 at 09:47:33AM +0100, Francesco Lavra wrote:
> > The DRDY_MASK feature implemented in sensor chips marks gyroscope and
> > accelerometer invalid samples (i.e. samples that have been acquired during
> > the settling time of sensor filters) with the special values 0x7FFFh,
> > 0x7FFE, and 0x7FFD.
> > The driver checks FIFO samples against these special values in order to
> > discard invalid samples; however, it does the check regardless of the type
> > of samples being processed, whereas this feature is specific to gyroscope
> > and accelerometer data. This could cause valid samples to be discarded.
> > 
> > Fix the above check so that it takes into account the type of samples being
> > processed. To avoid casting to __le16 * when checking sample values, clean
> > up the type representation for data read from the FIFO.  
> 
> ...
> 
> >  static int
> >  st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> > -			    u8 *data, s64 ts)
> > +			    __le16 *data, s64 ts)  
> 
> Dunno why this indentation, but if you need to send a new version, consider
> 
> static int st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
> 				       __le16 *data, s64 ts)
> 
Tweaked to this one.
> OR
> 
> static int
> st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag, __le16 *data, s64 ts)
> 
> (yes, the second one goes to 83 characters).
> 

