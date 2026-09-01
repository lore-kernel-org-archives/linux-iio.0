Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52EA33D6E6;
	Tue,  1 Sep 2026 01:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226462; cv=none; b=pUCKq/sIK7twEGhKz7RMgdlzaGr7jdfdmXciubJNEb4SZS+SWaVQhvvfpGIeM1317prxsN+mTX+VvCAkX7oHO45sgt3bU/GyRn1YFY1glM4HELw1sNZhLiv9Z+KhY78OvTKN+4/EaFNZtdVRRfy4fEImgP0N/e7nL4cT1uH83EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226462; c=relaxed/simple;
	bh=TyUb1xplzKZ1FsznpNG5r+dh/9iRZphbLsRiYVYuWYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFinZgCTMpT0KUc2ALLRyfs8tJEy44m5B5jo0XZtLHFLwyym8qlYDGf/WnvMdhhySJ0MbzFq/x+xvmOxSGdWxsQ4Jc7kvsxg7NXi6Mb18Qy6aamGvcFW/v1JIoUNLHVKN//mibwB/jRSoeLo+YwG/+ESS9hr5/stx4LylBuboZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jd1cZBsa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd1cZBsa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595901F000E9;
	Tue,  1 Sep 2026 01:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788226461;
	bh=5JKEK5EpIQizghAvKS5qgGz6n+MO//7iusj6VmUcQkU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jd1cZBsa4k5mswUKBXW21LSxVBAzDVTwp+hZHTo8HXXQihveBBG3hqSZpzT4MDr4r
	 ss34ELUE6yraCWQIY87rqf8V12+BvYo8BZI3ItvFCHqz3lc7PEH0SsG4Oea+A/LGPo
	 sNE0Vvjkawaj6tnb+K0tYJ6SrGgyoz/XCZqo7moAxR7aTP2RGg/B+CkEb6jBmn+wWC
	 MjHNF1Wu+eo52BirVXTQ7OyJryRdgKXv2Lvrb4QbYKAxx6YAN2gVRitf1+UAXcibPG
	 9nKc9Ga6g3r04uyi3h4JsToECHBN5XovHyejErk3+VGU59lAPLxeBot6KwjF+wxsoJ
	 MkY3W1ds2+bYQ==
Date: Tue, 1 Sep 2026 02:34:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yash Suthar <yashsuthar983@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, grondon@gmail.com, linusw@kernel.org,
 hexlabsecurity@proton.me, sakari.ailus@linux.intel.com,
 srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: accel: bmc150: use
 iio_push_to_buffers_with_ts()
Message-ID: <20260901023353.1761d741@jic23-huawei>
In-Reply-To: <apUmn2WKlqO1mZXO@ashevche-desk.local>
References: <20260825085156.212042-1-yashsuthar983@gmail.com>
	<20260825085156.212042-4-yashsuthar983@gmail.com>
	<ao_iV2xg-1Oc5Ttb@ashevche-desk.local>
	<20260831012728.0261184b@jic23-huawei>
	<apUmn2WKlqO1mZXO@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Aug 2026 10:00:47 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Aug 31, 2026 at 01:27:28AM +0100, Jonathan Cameron wrote:
> > On Thu, 27 Aug 2026 10:08:07 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Tue, Aug 25, 2026 at 02:21:56PM +0530, Yash Suthar wrote:  
> > > > Replace deprecated iio_push_to_buffers_with_timestamp() with
> > > > iio_push_to_buffers_with_ts() to allow source size runtime checks.    
> > > 
> > > With this you might want to use IIO_DECLARE_DMA_BUFFER_WITH_TS() in the  
> 
> (For the record, I put it as "might".)
> 
> > > definition of the scan buffer.
> > >   
> > Why?  The structure used is: 
> > 	struct {
> >  		__le16 channels[3];
> >  		aligned_s64 ts;
> >  	} scan __aligned(IIO_DMA_MINALIGN);
> > 
> > So given we never let things get enabled with just timestamp, the timestamp
> > and channels always end up in the places the structure describes.  
> 
> OK! I personally consider the macro a bit more robust in the cases when
> we _might_ have new HW to support where it will be the case.

Ah, I kind of get that but doesn't worry me too much.

They will need to modify the structure and then we'll spot it.
It isn't a source of bugs if it does go wrong, just inelegant
as the structure kind of implies the timestamp is in a different
place from where ends up.

Maybe this is one for a maintainers profile that hopefully the
AI bots will then use to monitor this for us ;)

Jonathan


> 
> > Where that is the case, I much prefer this to the magic buffer with enough
> > elements of the channel type on the end.  
> 
> No objections.
> 

