Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810ED237180;
	Sun, 21 Jun 2026 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782065359; cv=none; b=FcuTMF+JfhFnjkXovAmjAOonDUVLN5lWMEeFjY5scwXADF/cYb56YOqJB3O+GHaHNSwS/wnFGi5jQoVg875cP6enlL8ZVD4C1vtJ5W/mE/hYrJU+MOIAPy/aLRgRbLdLyyNirRMOuw9BzkxezO3RasJwfYrXnuDYMLVxGQCqMLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782065359; c=relaxed/simple;
	bh=YO+d+abx4/wg6lbW1kEBNRxmbTBswGTr+/uFi4gttFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEYulUF2ZKK48oCrWMtmH/Ju3ss5VqYcXgUm2gasv25kjrW8AxnmKVQfbipwRDUM8opTsYd/QGaXf6jy8VZtwjONe4TF8Bc5djLw67tIlGEEI/gy2BU3SKDG9bBBS3hBoF4QVP+ykq8WLbiyGkdYzwPH4Ni7u85up4G98wwvcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaLsUoqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaLsUoqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F361F000E9;
	Sun, 21 Jun 2026 18:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782065358;
	bh=nTM3wIcqATUv1drRh+8J+iX3OPQkQMDGvw1Isk2AAI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RaLsUoqYykiXZviJ0q/3L3lt8qEkSJY0faf0Tw6LD5MklpLhErWb8h4yLDpIxXzyE
	 06SxM42u1bp7f3bseJg43qaRmzjN80e+kWJRxBOkBq1Wr4GnQfAG4D+7QnHJHXw9ZM
	 J0UXUsV2G8vYjt32n+Sy89naJ2nYA8QbghkwLCM1F4N3g3nhhJiw6q/BD8daWtSIRb
	 DBdFEHoWv8wPdEDj7BkpKNbQvjjqfNzdT8GkElfJGD8khZXKV4c6rkNN9pGSOF0McD
	 o1OwmJKE3FbJTNm6+VFij00Uv5O/nbGzuAkNrUcak/Yti7ZkXMWWXSrmqtD1z0nT+8
	 SuUCTehpQfQ2A==
Date: Sun, 21 Jun 2026 19:09:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: hexlabsecurity@proton.me, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, linux-iio@vger.kernel.org, Sean Nyekjaer
 <sean@geanix.com>, Andy Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>
Subject: Re: [PATCH v3] iio: accel: fxls8962af: clamp the device-reported
 FIFO sample count
Message-ID: <20260621190913.0d6e05c2@jic23-huawei>
In-Reply-To: <ajJ0LSXQmuOhj8Pr@ashevche-desk.local>
References: <20260616-b4-disp-2e8d94cf-v3-1-c4e092eef3a2@proton.me>
	<ajJ0LSXQmuOhj8Pr@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 13:17:17 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 16, 2026 at 08:56:15PM -0500, Bryam Vargas via B4 Relay wrote:
> > 
> > fxls8962af_fifo_flush() transfers the sample count the device reports in
> > BUF_STATUS into an on-stack buffer sized for FXLS8962AF_FIFO_LENGTH (32)
> > samples, but the count is a 6-bit field (0..63) that is only checked for
> > zero. A device, or an attacker on the I2C/SPI bus, reporting 33..63
> > overflows the buffer by up to 186 bytes: a stack out-of-bounds write.
> > 
> > Clamp the count to FXLS8962AF_FIFO_LENGTH before the transfer, mirroring
> > the clamp already applied in fxls8962af_set_watermark(). Conforming
> > hardware reports at most that many samples and is unaffected.  
> 
> OK!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied to the testing branch of iio.git

Thanks,

Jonathan
