Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A881BC46
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769861902; cv=none; b=gZfHKcgJWNubhpNFdENO7KeXz9W2dT/ss22pq5cXQyQGTmY8jg+pt9W+ESsrs+hJf4ekOD46YeqXgp31S+N79ZrV0DHNFmasCwUt37CnICj10buezRRp2+dIAt98rxCLh2RdR0L3rd/hNZrePhXOLVMvkT7Two3aBCD7DVK19IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769861902; c=relaxed/simple;
	bh=cI01ZbZH134NotJBiPatGjD3fijthJYEQrMxiC5aD7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcCDAG8xor2axvQiLIsWzKnE+MAXB5gTD2qjtZePBiEsOjTr7Ttp5SQs7exDuEbYVKHkodF219/tHrgm5ujk3K5AE4ZFOVcwuLKYHiY813jfWfYRdtXvSjn0X9rSP1IkdMf91EmieyAPiJk2mSkBae1hi2PKi1ySDb5wExOXKoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYNnUxVi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYNnUxVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1157C4CEF1;
	Sat, 31 Jan 2026 12:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769861902;
	bh=cI01ZbZH134NotJBiPatGjD3fijthJYEQrMxiC5aD7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mYNnUxViHc9b1NzOj3unyRX4tgAypgSmVEyXtGDSgZCGw99emT3sELrwECKFofXWC
	 dA9S62seuWROqtYiqqgjZPwR4z2WxKcOq3HaUA00CGMIFqI799M2rU1OEQTELJQ1yL
	 zgAedR0Dg4fE7KyoOdJzNWoZYE5IUBL1wk/WueTLMCl7RHVrONmzM+ZnGCO8KXM6Kv
	 38+lwihLhFByeRVgH9PgCsFlw9RLRRjDNvOy7Ss2WNDr0WZGrGUUCsdk6n0QkyMjF0
	 iRJl05DfSZMuA//7zfYUAbTaogtP6mk+9imjgwEpjI/s3RNtfU4guJeAfqIo9AIxHM
	 QCRkqIRZ45Gzw==
Date: Sat, 31 Jan 2026 12:18:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] iio: magn: mmc5633: Ensure REGMAP_I2C / I3C not
 build if I2C / I3C is not.
Message-ID: <20260131121815.249b04b2@jic23-huawei>
In-Reply-To: <aW8td75ZhKd1mIMW@smile.fi.intel.com>
References: <20260119221736.804825-1-jic23@kernel.org>
	<20260119221736.804825-2-jic23@kernel.org>
	<aW8td75ZhKd1mIMW@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 09:23:35 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jan 19, 2026 at 10:17:35PM +0000, Jonathan Cameron wrote:
> 
> > Fixes the following build warning (and equivalent I2C one)
> > WARNING: unmet direct dependencies detected for REGMAP_I3C
> >   Depends on [n]: I3C [=n]
> >   Selected by [m]:
> >   - MMC5633 [=m] && IIO [=y] && (I2C [=y] || I3C [=n])  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Unfotunately this isn't sufficient because we get issues
if MMC5633 is built in and I3C is a module.

Not sure why the didn't turn up in 0-day tests until this hit next
(and due to some forgetfulness that was rather late).

Seems this is a common problem as there are some unusual constructs
in tree. I'm going to switch this to

depends on I2C
select REGMAP_I2C
select REGMAP_I3C if I3C
depends on I3C || !I3C

Similar to Guenter did for:
83b645ee43f7 ("hwmon: tmp108: fix I3C dependency)

It is ugly but I'm going to do this as a fix on top of the current tree
as I don't want to rebase just before sending out the pull request.

Jonathan



