Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE632F84F;
	Sun, 19 Apr 2026 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776618298; cv=none; b=Tb9lUP7Sg7Esx90cKlR9+gBDhAwSBpAxgIRbCxKDRExwpTv9xmgQQGQo+YWA2z5TDrlTBcDHJ1b/iBrmAYqToAtYqUSnA7hFPrOqMNC3U3VRwN9kXZU0+Xoi3mMdLsmbSBLqKRk16JDko/SZQJk5go/8724HqscO2tMfPb9ymik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776618298; c=relaxed/simple;
	bh=KVxmh4mQrT8XilsoQtrNfXlhzWx5teGttB+pIJpxXIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ET0429Rd+6Ap8u+lA9KD0LIkso7iOLAPcTVMbTaeSTX2v38CfiFdsROjCERAWb8TECwiCO0h1yFeTjF6txl3hqOeG0+DpZ7Mclq1Ycg3Gy5aA8sR70lqhhHyutcba0TIqF/JwAmEfLtHkg2IJeUv+VPpxPr9AyI5cEQZ0Dmtctw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dkp3YdCV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dkp3YdCV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147A0C2BCAF;
	Sun, 19 Apr 2026 17:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776618298;
	bh=KVxmh4mQrT8XilsoQtrNfXlhzWx5teGttB+pIJpxXIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dkp3YdCV/QbN34z3wUqQZPAjdfDGG78jiNZ0FvT8hZrdnze/Ar7lgMfyv8FQ1Vr8F
	 CutxQsiiGVS3qoaR1KIQ/3KLXCtKV0drF1CmskA74rIc8t4VrS3gHSd7Cjngro371d
	 Hh5j0qSpoKGd1uEpgiMCZ/rzPHAZTmItrfLBM8Jd5O2f7KLZwSJkIPJqTxADIzLkbo
	 u7ZzHwtWogdBMAXyhPQTdBiYG+q3jkEPhm7naFF5TvEItMcP5B4Acz5z0VLZaIK53G
	 /gOoJbDyM4ZA5ZXP9PkvpA1h33ZTcyy86nvhPNESj42dxbXHQHxlFIEUBhBFCeAl4m
	 1qEvY9xCJDIQg==
Date: Sun, 19 Apr 2026 18:04:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hansg@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iio: Fix iio_multiply_value use in
 iio_read_channel_processed_scale
Message-ID: <20260419180449.4f4df9ed@jic23-huawei>
In-Reply-To: <533baaf1-4ae8-4401-b5b0-67e495a426ba@kernel.org>
References: <20260416111442.61932-1-clamor95@gmail.com>
	<20260416111442.61932-2-clamor95@gmail.com>
	<533baaf1-4ae8-4401-b5b0-67e495a426ba@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Apr 2026 14:31:00 +0200
Hans de Goede <hansg@kernel.org> wrote:

> Hi,
> 
> On 16-Apr-26 13:14, Svyatoslav Ryhel wrote:
> > The function iio_multiply_value returns IIO_VAL_INT (1) on success or a
> > negative error number on failure, while iio_read_channel_processed_scale
> > should return an error code or 0. This creates a situation where the
> > expected result is treated as an error. Fix this by checking the
> > iio_multiply_value result separately, instead of passing it as a return
> > value.
> > 
> > Fixes: 05f958d003c9 ("iio: Improve iio_read_channel_processed_scale() precision")
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>  
> 
> Thank you, good catch:
Indeed and 'ouch'.

Anyhow, applied to the fixes-togreg branch of iio.git and marked
for stable.

Thanks,

Jonathan

> 
> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> 
> Regards,
> 
> Hans
> 
> 
> 
> > ---
> >  drivers/iio/inkern.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> > index 0df0ab3de270..9ce20cb05a9b 100644
> > --- a/drivers/iio/inkern.c
> > +++ b/drivers/iio/inkern.c
> > @@ -738,7 +738,11 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
> >  		if (ret < 0)
> >  			return ret;
> >  
> > -		return iio_multiply_value(val, scale, ret, pval, pval2);
> > +		ret = iio_multiply_value(val, scale, ret, pval, pval2);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		return 0;
> >  	} else {
> >  		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
> >  		if (ret < 0)  
> 
> 

