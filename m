Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2A270575;
	Mon, 31 Aug 2026 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788135895; cv=none; b=TH/3gF+aS8Sy1/vt4gIeI3Ar3ubgCZOwxuQPqM9nFjXAK4ggKW/JS0Yuiasft6Uz6QLa/7bXaH5D5lcxVcH37YJRSH/+n01bBzHpPQcMQDvz0PESWACNpuiSkNi7zil3e3Ln25Rae97A8EHVksRa9Q43tAE5kXEnzEhFxNNXHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788135895; c=relaxed/simple;
	bh=JJ4viR+8sE8j9SeqHJwMeDiDw/qsbiyvuxpgf+tbfPY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pe+/cqURwQT3HTYkSkoqDEVgUb5hyjd0c4xSNuGtYXY54DabDHCtEUlt2Yh3C3NgtSSl3aiSXMAl44wspflzCSpTYnzHPYiUC2MTu17lYysf2FJTLe6v/58bgQ/iIouAbzioKG0j85ii5oPNZQD78kVqLrukPuh55v2fJBNc5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMy1ZZPd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMy1ZZPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D171F000E9;
	Mon, 31 Aug 2026 00:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788135894;
	bh=vSQursvzetPYZ4NCdCJkz+qxLgUbo3ZJRF9cyMuvvaA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oMy1ZZPdC739C0tEMwcCpOtvMCJdxwvigcvqdgbCTwtjKWTDt8YtKThD25sMH1GDg
	 YHNrvxXs3TExpe5JqR+et/cNYHJf7pJKXnx5ooCYs/0HyVTh7CJgjNe4i8mnOFNL1U
	 15Qvs64jnoRBJk/1p4RJ6M6EdHWV5O1+H2OOWY/DTO6O8zDz0zqQfBfQJAHon7qpO9
	 +Y5bCFenj0dJsPAY+IBPaQVAo63IMEF1dvLVwObE2giAvbMcNW7r8GlA4kevoO/R/c
	 ShsMTGrjw32bKvGly+6HJJ+40WJ7ARc7ucHHjY3yjlrCbVoxQcOLF04onKmkJIamw0
	 lx0xgUoNj8BQQ==
Date: Mon, 31 Aug 2026 01:24:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yash Suthar <yashsuthar983@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, grondon@gmail.com, linusw@kernel.org,
 hexlabsecurity@proton.me, sakari.ailus@linux.intel.com,
 srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: accel: bmc150: use DMA-safe buffers for
 regmap bulk reads
Message-ID: <20260831012450.3382868c@jic23-huawei>
In-Reply-To: <ao_hr-0BelQWI27t@ashevche-desk.local>
References: <20260825085156.212042-1-yashsuthar983@gmail.com>
	<20260825085156.212042-3-yashsuthar983@gmail.com>
	<ao_hr-0BelQWI27t@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2026 10:05:19 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Aug 25, 2026 at 02:21:55PM +0530, Yash Suthar wrote:
> > The FIFO and read_raw buffers are passed to regmap bulk/raw reads,
> > which is not DMA-safe. Moved them into struct bmc150_accel_data
> > after scan, each buffer are protected by mutex, placing them
> > after ensure DMA safety.  
> 
> ...
> 
> >  		j = 0;
> >  		iio_for_each_active_channel(indio_dev, bit)
> > -			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
> > +			memcpy(&data->scan.channels[j++],
> > +			       &data->fifo_buff[i * 3 + bit],
> >  			       sizeof(data->scan.channels[0]));  
> 
> While this works, I find a bit confusing usage of [j++] and [0] together.
> 
> IIUC the below is an equivalent
> 
> 		iio_for_each_active_channel(indio_dev, bit) {
> 			__le16 *val = &data->scan.channels[j++];
> 
> 			memcpy(val, &data->fifo_buff[i * 3 + bit], sizeof(val));
> 		}

This bit I fully agree with. Much more readable.
> 
> and if go further we may use asm/byteorder.h macros instead of plain memcpy().
> 
Here I'm lost.  We are just moving little endian values around.

For that matter if it is a single value, why can't see just assign it?

		iio_for_each_active_channel(indio_dev, bit)
			data->scan.channels[j++] = data->fifo_buf[i * 3 + bit];




> ...
> 
> Maybe this is for a separate change, I dunno. I leave it to others to decide.
> 

