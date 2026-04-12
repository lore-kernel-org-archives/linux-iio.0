Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E32D469D;
	Sun, 12 Apr 2026 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019332; cv=none; b=Dq1zmYVNTmdknKJzSs1S/GVSFuXla58KpvIy57ABSqXUarnUl8NnDpCr9Df1+GhDHNEE/mnziwYoA/5mvoaNKNopWhGFZHg8ae1hmLtOyVYpd6Sx4DNBuVAikonQgqn9apsVfJ32h9OYV2wR+2SyGG4+uLtYd2UYZ+1fJ3eunPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019332; c=relaxed/simple;
	bh=qbj7C2qSGrrNMPXr+xiekXxOla9aCb8ohmHN8mIPtZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlSGcQeqsFUBIFQ2rLZ5wU9LpqFPHXji0wsxMFj6ylW3etG872pt1iFd9XxSv3/BI92RaPptysZNCqUc2NQnEaqeWzNnOHF0axIiqE3qOfStnO5IDgjsX18oplBftL7xNOs3ha1DqlbCHKn1PCOqbkooWK3WnZUbGwboYST3IXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtRYNF5I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtRYNF5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FB2C19424;
	Sun, 12 Apr 2026 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019331;
	bh=qbj7C2qSGrrNMPXr+xiekXxOla9aCb8ohmHN8mIPtZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BtRYNF5IlgkyFcv3qh7+Iu1KVfVCULxboa3w81OhwsyS8XlZFaFVqe7lfSw3XT1dd
	 zLDGcHrTOpBRm6L1LRCYDQsNM0ec0lvsRBbcK26JdASgOVfjEmtixldmKNYfTYbEgy
	 8x6kDwI7pk4fjRL+tjj/ldexJaOIc9CqJV4C72AAJ1YdSkVtQqHXZeGZIju7JGnH/B
	 yQbKEM+8U6LsIe8jTOkHV40RPswrwkymAGb5xX+poh3gzYa1BiQxDeiHydSsRDFTLZ
	 OTJHVSvNYbBzQpxfnCpg5IEGZ96jH16RAkjERq5TqbBUWQTASybNHVmoFscNo5ipVw
	 lTQJArmt0qQ3g==
Date: Sun, 12 Apr 2026 19:42:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>,
 lars@metafoo.de, Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adc: ad7816: use sysfs_streq() instead of
 strcmp()
Message-ID: <20260412194206.70ea9781@jic23-huawei>
In-Reply-To: <acpL0OgqPYoVbzb-@ashevche-desk.local>
References: <20260330074850.12638-1-mdmahmudulhasan1511@gmail.com>
	<acpL0OgqPYoVbzb-@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 13:09:20 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Mar 30, 2026 at 01:48:50PM +0600, Md. Mahmudul Hasan Mabud wrote:
> > Use sysfs_streq() to compare the input buffer with the mode strings.
> > This is more robust as it ignores trailing newlines, making it safer
> > for sysfs store functions.  
> 
> ...
> 
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
> >  
> > -	if (strcmp(buf, "full") == 0) {
> > +	if (sysfs_streq(buf, "full")) {
> >  		gpiod_set_value(chip->rdwr_pin, 1);
> >  		chip->mode = AD7816_FULL;  
> 
> I think it might be better to do more work on this.
> First of all, convert to use IIO_DEVICE_ATTR_RW().
> Second, convert to use sysfs_emit() instead of sprintf().
> But with that, switch to use a static array
> 
> static const char * const modes[] = {
> 	[_FULL] = "full";
> 	[_PD] = "power-save";
> };
> 
> This will need redefinition to start from 0 (I don't see why it needs to
> start from 1).
> 
> #define _FULL	0
> #define _PD	1
> 
> This allows to switch to sysfs_match_string() and return an error on
> unrecognized input (which is absent right now).
> 
> So, something like series out of ~3-4 patches is expected.
> 
Hmm. ok I guess to cleaning this up, but worth noting that this
bit of ABI is custom and very very likely to go away in the longer
term if this driver is cleaned up enough to move out of staging,

Jonathan
