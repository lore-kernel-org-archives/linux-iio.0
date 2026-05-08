Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA23233F4;
	Fri,  8 May 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242947; cv=none; b=lANW3nCw7g13uHrgoWkoTCntmhxN/sShSReSOjd4Ep4u9SnHgpMahmKbe8RKb19o8M5LR+ksSetJildpMud5p/3mUnoGcTjDe2F7+19C+xmPKR6w7rMxaLthCRESiLF2HGHh3QxcslERzSZFTdZQrSuvpWn++tHIFAyXW3h37hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242947; c=relaxed/simple;
	bh=dv1/ywqlZBVFXy+DrFAxaMz7jCZLnY5k8yOKMEgT1wk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvX+4pjzcUsjo3SmI3JSeps4S7bYj+Oits1N9t/JZsAh4R7KWPAIZPcPMc3PHoAFfKRRpJWtrFh71/NbU3AoqDPpkF5ylMTo/FnpQlSP7APhvwDZthbjyCo0eKiKU6GLo7Bb3+2i4eqOJd4LMNwUM3V3bs3K3UHSyZC1VAUPL3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQM3MFty; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQM3MFty"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9069C2BCB0;
	Fri,  8 May 2026 12:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778242946;
	bh=dv1/ywqlZBVFXy+DrFAxaMz7jCZLnY5k8yOKMEgT1wk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jQM3MFtyaURYyFsQ3N4Ut3uE25wOfNwNyq9cXuSscKwG2ZCBTZwGj/faLkzz7pjD2
	 3M9KyQcES8vl2vUxlxC45Cen79BLMR5SYAnEWAAVgcWI9b0ItnbSCpRiXD/maAqW08
	 5Yn9Vtbibwud6PyYg8aK2NSkxxSfDFUSDHDTwbp2fmn6jKL4HdRvgFq1qmGyE83mZ4
	 3lDn53w8dlaY3taubZUe6LVTxjPqdZtWnlOk9VgpnYICPhhv4zEDqCk5OQmyiLnkld
	 tLWJmK5sx+HOKLZf0nrMi1H5bpqSZFBswP0YjHBuKpAIu60c6cI238uAmEgEPyZakP
	 FPbgTSbhdWtLQ==
Date: Fri, 8 May 2026 13:22:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Mark Brown <broonie@kernel.org>,
 driver-core@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-spi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>
Subject: Re: [PATCH v1 0/4] driver core, iio: suppress driver_override
Message-ID: <20260508132214.57e57df0@jic23-huawei>
In-Reply-To: <20260508095224.1275645-1-andriy.shevchenko@linux.intel.com>
References: <20260508095224.1275645-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 May 2026 11:42:38 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Recently Sashiko started reporting the missed NULL check of
> spi_get_device_match_data() or device_get_match_data() in SPI drivers
> in IIO subsystem. It appears that the way to crash can be made by use
> of driver_override sysfs attribute. However, many drivers, that may be
> instantiate via ACPI, OF, or, in some cases, user space won't work
> without necessary driver data. These are, e.g., most of the drivers
> in IIO subsystem. Trying to override the driver for the device that
> has no matching entry makes no sense in such cases and might lead to
> a crash, when the driver is not prepared for that.  Instead of adding
> a NULL check for driver data pointer in each of that drivers, effectively
> meaning a dead code for normal functionality, introduce a special
> attribute in the struct device_driver to allow drivers just to hide
> the attribute for good.
> 
> The last two patches are the examples of use and code simplification
> at the same time.
> 
> I consider getting an Ack from Mark for SPI, and from Jonathan for IIO
> and route this via driver core, while providing an immutable branch/tag
> for the above mentioned stakeholders.

Works for me.

> 
> Note, this doesn't change the state of affairs for some busses that
> do not have driver_override flag set while using custom approach.
> On a brief look it's the s390 crypto case which may not ever need
> the above and hence left untouched.

Excellent!  To me this makes a lot of sense as removing an attribute
that never works for particular drivers is neat and tidy.  I suppose
there is a very small risk that some really strange scripts rely on
that attribute existing but not on it doing anything useful.
If that turns out to be the case we can just make it fail in the callbacks
but definitely not as neat.

One possible concern though based on a typical driver evolution:

1) Driver written - supports only one part, so to match_data involved
   and driver_override is fine.
2) Driver gains support for second device.  match_data added and now
   driver_override is not ok so we set the new flag.  Interface
   disappears and perhaps someone was using it.  Obviously that case
   is broken anyway.

I guess I can make an IIO wide rule that we always set the flag. That
leaves us with a gap though as we have a lot of drivers currently at
step 1 of above that might progress to step 2 over time. I guess we deal
with any reported regressions on a case by case basis.

Ah well - still a step in the right direction even with risks of
regressions.

For all patches
Reviewed-by: Jonathan Cameron <jic23@kernel.org>

Thanks for proposing this Andy

Jonathan

> 
> Andy Shevchenko (4):
>   driver core: allow certain drivers prohibit override via sysfs
>   spi: Support suppress_override_attrs flag
>   iio: imu: inv_mpu6050: Suppress driver_override sysfs attribute
>   iio: imu: inv_icm42600: Suppress driver_override sysfs attribute
> 
>  Documentation/driver-api/driver-model/binding.rst |  4 ++++
>  drivers/base/bus.c                                |  4 ++--
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c   |  8 ++------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c         |  3 +--
>  drivers/spi/spi.c                                 | 11 +++++++++++
>  include/linux/device/driver.h                     |  2 ++
>  6 files changed, 22 insertions(+), 10 deletions(-)
> 

