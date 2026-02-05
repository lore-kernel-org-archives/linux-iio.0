Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410232549A;
	Thu,  5 Feb 2026 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770319784; cv=none; b=IfR3LUFyfv/cWUsca/vrhMluwg38aSxF0M7iOduRTkSqBF8xfP+X5gHlUQPj/+ZtG2yLCsyZ6xPWVyN6yRFwTfwil7zYoVMyxMnqIbDABo7eos1/menBMX1+38JBwY6SC72UylTUTUGjhkMW76e3zcC8pyabOFxB3JLf0DTmnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770319784; c=relaxed/simple;
	bh=BfbvNC3OLUalkerPL2Xobz5N81qzXVcDr43E5dRc+0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deYmU8euLRgx23A/RKh0dMwaeGJOxHPX9Ow5bqfsropmR7emNhd3Vwa/NxeRLQuJQ+umwAAf98V4T3EvTKbWRq2OPZAe+vEQg7esz1DatRSycNkxO8oEWM4vlKzZJDNsv8Uxyew+0F6jn8drwvbypN2MTX0Whb5/n13QQuaJdzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jj7EwzGC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jj7EwzGC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D133C4CEF7;
	Thu,  5 Feb 2026 19:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770319784;
	bh=BfbvNC3OLUalkerPL2Xobz5N81qzXVcDr43E5dRc+0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jj7EwzGCCiYnkawIQ8P6cXN/767KoOeyYb5QJr3yCXiCErJvtmLcA7KTXLhlY3yP8
	 t2hdnLopjfWYZRig7mP1y+wap9ZFm9/VwU/d7GEHSNYp4Ujg77MJHQi+yrQAAXjeHi
	 Jf/bB3Zm3wj8lquYO2LWZxGaz6Jjpclh6iQAa4M7v3gBWTl+3YxJ7ELmI7kJzIYY6K
	 44U+ZBPajoY6uFUI0IGw6lm4txjQNIIq/DOSZ3C5h4Nt5yKZXHZguc7j5GTnKt4Lq3
	 xgDQi07ycFp7Biv5HevGytxOpr+HdOA4nY05XrEXj0oEw9AfCNh3549xxNDjcCWdr7
	 yytRHx6olkUBQ==
Date: Thu, 5 Feb 2026 19:29:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
Message-ID: <20260205192935.74bc7d92@jic23-huawei>
In-Reply-To: <aYHaKYWNbrZchDn-@smile.fi.intel.com>
References: <20251109192556.3163077-1-andriy.shevchenko@linux.intel.com>
	<20251115185001.01f2b148@jic23-huawei>
	<aYHaKYWNbrZchDn-@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Feb 2026 13:21:13 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Nov 15, 2025 at 06:50:01PM +0000, Jonathan Cameron wrote:
> > On Sun,  9 Nov 2025 20:24:36 +0100
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > The driver code is full of intXX_t and uintXX_t types which is
> > > not the pattern we use in the IIO subsystem. Switch the driver
> > > to use kernel internal types for that. No functional changes.  
> > No problem with the change but this description made me think
> > that this was going to be a huge patch touching lots of instances.
> > 
> > Probably needs a rewrite to not say 'full of' :)  
> 
> Can you tweak that whilst applying, please?
> 

Ah. I'd accidentally marked this in patch work as handled and
forgotten about it.

Anyhow picked it up now with a tweak to the description.

Note I'll only be pushing that tree at as testing until rc1.
