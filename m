Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424A32B13E;
	Tue,  4 Aug 2026 23:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886501; cv=none; b=EKeUJxmernl5MdZ70er9L0EEq/oJWlB0Js7BGs25Usy8Pc3sdxnBrawK7TG89Fv4HMoiqKxOuiDsxXACw4QNrCTvFpICpf+s5STSpafkHCNdeLbrEakKiKaXJJv82HBCK3VGFDx6+BiUTjWii0/wvRlPHuXTSuFojlGvNM+f9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886501; c=relaxed/simple;
	bh=kvElmkwzxCRVgwGWgU4s3Kk0l4Xq8PKhydG56GD5hbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmRPW8TBW5/55DRfYL9rlHoA1sRkVhyFtqKVeKvLLJXKT2JP5vAVIV4mklUcM8Fe+KPViLUldyJ8hYL4tMRMJMwYj7uGz4ISWKPc/vpsMfccYWjFooQXw+Y4j4YzNqrN4DyJE5slTNO0JTecK6ELae0+e93b1dhwuIOEHof44Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBZnZfsP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBZnZfsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9461F00A3A;
	Tue,  4 Aug 2026 23:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785886500;
	bh=NA2WkXXGTqiDkCn20WpSDatLvyUYtlA/OE3mHfMQFuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VBZnZfsP0AW3s1ycoJLZnCJMv4dycAKK8YfWYkuZKn1kxfWtzhGWUr8h/IPURISS8
	 MOMoB0RYAQK+tF/SbgxRwyRHwQ5lsL4qEU82T2sXeqXsbxoWjOIwKQNu5IlfXnQ71r
	 d+E96eOrq8sI2K+7y6HaoZs4j9ciAmR+pIffaTT0yRnDhy1VcxuyEPoylx9m/tQm9p
	 NHztGRjBd7UhK53Ea+qZgy6fOc2Upr1qcPpObbtZjUDbGeggBn75RXy33vVhXIRT0o
	 CCPVhDGuVmDE7HQuf74DNq+/4PiQJ3t6aC0XrWEnRIyeFxGYYfIiHBUQaYph7FMRiD
	 09YXUvM0aGC2w==
Date: Wed, 5 Aug 2026 00:34:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Cong Nguyen <congnt264@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: pac1921: fix wrong channel used in trigger
 handler read
Message-ID: <20260805003455.61e8a621@jic23-huawei>
In-Reply-To: <5ea928fb5e9370824d62a0c5d5913458@gmail.com>
References: <20260802071246.62046-1-congnt264@gmail.com>
	<5ea928fb5e9370824d62a0c5d5913458@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 04 Aug 2026 08:49:25 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> On Sun,  2 Aug 2026 14:12:46 +0700, Cong Nguyen <congnt264@gmail.com> wrote:
> > pac1921_trigger_handler() walks the enabled channels with
> > iio_for_each_active_channel(), which yields the scan index (bit) of each
> > active channel, while ch is a separate counter used to pack the samples
> > contiguously into the scan buffer.
> > 
> > The register to read was looked up with the packing counter instead of
> > the scan index:
> > 
> > 	ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> > 
> > pac1921_channels[] is ordered by scan index, so channels[bit] is the
> > channel that is actually enabled, whereas channels[ch] is merely the
> > ch-th array entry. These coincide only when the enabled channels form a
> > contiguous prefix (e.g. all channels enabled). With a sparse scan mask -
> > for example when only the power channel (scan index 3) is enabled - the
> > handler reads the wrong register (VBUS instead of VPOWER) and pushes it
> > to userspace as the enabled channel's data.
> > 
> > Index the channel array by the scan index (bit) to read the correct
> > register, keeping ch only for contiguous packing into the scan buffer.
> > 
> > Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-4
> > Signed-off-by: Cong Nguyen <congnt264@gmail.com>
> > ---
> >  drivers/iio/adc/pac1921.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
> > index bce7185953ec..0037509503ed 100644
> > --- a/drivers/iio/adc/pac1921.c
> > +++ b/drivers/iio/adc/pac1921.c
> > @@ -1037,7 +1037,7 @@ static irqreturn_t pac1921_trigger_handler(int irq, void *p)
> >  	iio_for_each_active_channel(idev, bit) {
> >  		u16 val;
> >  
> > -		ret = pac1921_read_res(priv, idev->channels[ch].address, &val);
> > +		ret = pac1921_read_res(priv, idev->channels[bit].address, &val);
> >  		if (ret)
> >  			goto done;
> >  
> > -- 
> > 2.25.1
> >   
> 
> This looks correct to me. I guess I didn't test it properly with a subset of
> enabled channels when I wrote this.
> Thanks for the fix!
> 
> Acked-by: Matteo Martelli <matteomartelli3@gmail.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan


