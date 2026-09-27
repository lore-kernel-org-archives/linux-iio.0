Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB2041A92A;
	Sun, 27 Sep 2026 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534661; cv=none; b=QXpclFSv2QuJQqa8qmJbT2R391fBjwOf/xMHhWKueS8BCdY3XioOGsWFEmJkUfUFy0hrAwTIkRiUp9ID2oAY6HNbojVAPBF9nxN7FmTMl53qJanQ7dn7PIb+GIPxaoEYsjmEh/W+dLjVEIymieHd6KnGiQh5mJ5YUwGrS5urY3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534661; c=relaxed/simple;
	bh=ljYmVK8Yt7p6SpfNSpe1kw+xcwFeJ3OwvshzUP5wELk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHM9GXmIp0Yqxj4932KxC+b+oBZFqjp7jTpbrWAW1tyNQ6Er+JxQI6jQ+MFuUzrUCnrQEA0EXOCUaPpxhQHUgI2cPTVEze7mV6s8VAH5S6mRamVILtYrZ6S4G/gMFYiYaf+VJlpmCTWmk5N7TsqOe/Sy1Plj7/zqNujbQRy/S84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDxWoO8u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDxWoO8u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EA41F000FF;
	Sun, 27 Sep 2026 18:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790534660;
	bh=SWr5QE6Ryda5brnKpvYSqxagQCIO389FzNkg8IXhHOw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EDxWoO8uIwXFq/OZsWgI5rn2LUQTnzBCW3TyjIcMf1DvtooSRQb8YqK1yJUDoDOUb
	 JJFSGwEevturbPmXljxLk7mc4wCM8rhqO4wy8f5ZM/AcP7+gYZYBaN2d6t0Qp/vMHg
	 9eBPexPFedVn/e4RFxqy41GAYVwULdV36xMlDRezjgxIGxR0vfeU3kStw7zrJU2+cW
	 WXgUo3TghR1rkeSpb8hDHVrBLYwKzsei6nbC7vWW8ODkVjfriGUN30HcaCsF7+mfZk
	 PHqQtuKYLbzu45u0gnF4XMPO3OLPLRfNOee/aVxnr0WpIq732agJ0s1uI0jX2XVR56
	 CfS3+m6K78F4g==
Date: Sun, 27 Sep 2026 19:44:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: veml6031x00: Enable internal calibration
Message-ID: <20260927194416.37f84da9@jic23-hlaptop>
In-Reply-To: <20260924-veml6031x00_als_cal-v1-1-c046a5e4e998@gmail.com>
References: <20260924-veml6031x00_als_cal-v1-1-c046a5e4e998@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 12:59:57 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Enable the device's factory internal calibration before entering normal
> operation to improve ambient light measurements.
> 
> Set ALS_CAL during hardware initialization.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Applied.

Thanks,

Jonathan
