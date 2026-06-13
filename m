Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5730D40F
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 14:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781360083; cv=none; b=JaDNzkaRVj0KKf00s0WW8C12vdNifJzF3u99xn3iIV2BfidsTo7QZQUAwyAKzGEGGDbyFf3XcT1S5XS+WmXHY1zUEQeeVZPjvsOGre7dfD78AXBjj9j4abSDeWjuk0w1ETLUxjO8Oe1d3To+Wry2z7iUAAbCAp1Jc/CWgCgpLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781360083; c=relaxed/simple;
	bh=M1hjX1i4YyyGNJA93VHLJ7AY2mFDMpU6PlQU0/s911Q=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g/pXj4CqBK19Yv4nqvKDulCspaQgDF737/x9G9rpNBWTdheXP2TRwbmSPJb/JVuo1fLRk43NF1Nt2r1Vj45Q3y+rl9VWy8v9PM51udPoUW8FCC1wIn4BbB0oegsZ/bqfqiuG3g319sh5EywuH1EVbI55DfXbKyk1/Y2w7aWShXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7TbwTZm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7TbwTZm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BE11F000E9;
	Sat, 13 Jun 2026 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781360081;
	bh=JBNZeMbNZHU+3nlS1hbjb2kWmviadtq6h4Jw97wuw4I=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=b7TbwTZmz8btY4g+tj7IfXutnrIG1u/twcb7MPzlychg0xp6uIdsefmOB0E7BS8gJ
	 Sy2UdTKMoxmJbnZ+bOd7QXDQt1YpODuX8BOAB5qEXLsVatGHdlzE9exG6Fv81zEN85
	 vjWBB6Q62M14y8/BdsX7hcYSBYXsHTBYHeiSeP3TTi95piYPoYFIggETJNBwvmOcuV
	 RLeq3h527bio0F9s3HUz6nmlcedebdBF8RouExSPu2lthczizORhg1YxMIuBjtEem5
	 850nr+Qkm4VbrSeaUOAOsF4EW+xii6snV6B2KilE51siDa1c32RGL6uTiDZfOU/jv5
	 ydrtdxZjlA6AA==
Date: Sat, 13 Jun 2026 15:14:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of fixes for the 7.1 cycle
Message-ID: <20260613151436.4ed833ef@jic23-huawei>
In-Reply-To: <20260602151415.1c17664b@jic23-huawei>
References: <20260602151415.1c17664b@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jun 2026 15:14:15 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> The following changes since commit 329db447f8f02e82ff3acf130c892e1a4063d493:
> 
>   Merge tag 'iio-fixes-for-7.1a' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-linus (2026-05-15 13:45:33 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-7.1b
> 
> for you to fetch changes up to 91bc6767a4f55dc470d8a56b55b9f2ea09094efe:
> 
>   iio: adc: ad_sigma_delta: fix clear_pending_event for registerless devices (2026-05-29 09:57:23 +0100)
> 
Hi Greg,

I think this pull request is outstanding.  No problem with queuing it for the merge
window and if we are too late for that I don't mind if it waits for rc1.

Thanks,

Jonathan

> ----------------------------------------------------------------
> IIO: 2nd set of fixes for the 7.1 cycle.
> 
> Usual mixed bag of ancient issues and the recently introduced.
> 
> Various drivers
> - Ensure use of simple_write_to_buffer() in debugfs callbacks doesn't
>   result in reading off   the end of intended data by checking the
>   position is always 0.
> buffer/hw-consumer
> - Ensure scan_mask is freed on buffer release.
> acpi-als
> - Check ACPI_COMPANION() against NULL to close corner case where a
>   driver is overridden.
> adi,ad4062
> - Add GPIOLIB dependency to avoid undefined ref to gpiochip_get_data()
> adi.ad7768-1
> - Add GPIOLIB dependency to avoid several undefined functions.
> adi,ad2s1210
> - Ensure possible recovery path if a read fails in the interrupt handler.
> bosch,bmg160
> - Increase sleep on startup to ensure device is ready.
> bosch,bmp280
> - Ensure buffer pushed to kfifo is zeroed to avoid leaking uninitialized
>   stack data to userspace.
> dyna-image,al3010
> - Fix refactor that stopped reading one of the two measurement registers.
> dyna-image,al3320a
> - Fix refactor that stopped reading one of the two measurement registers.
> qcom,spmi-iadc
> - Ensure disable_irq_wake() is called on remove path.
> sensiron,scd30
> - Fix a sign extension bug.
> st,vl5310x
> - Ensure possible recovery path if a read fails in the interrupt handler.
> ti,adc1298
> - Bounds check for pga_settings index. Hardening against device returning
>   unexpected values.
> ti,tmp006
> - Ensure trigger correctly released on remove path.
> vishay,veml6030
> - Fix incorrect channel type in events.
> vishay,veml6074
> - Bounds check for veml6075_it_ms. Hardening against device returning
>   unexpected values.
> 
> ----------------------------------------------------------------
> Alexander A. Klimov (2):
>       iio: light: al3010: read both ALS ADC registers again
>       iio: light: al3320a: read both ALS ADC registers again
> 
> Arnd Bergmann (1):
>       iio: adc: ad4062: add GPIOLIB dependency
> 
> Dan Carpenter (3):
>       iio: dac: ad3552r-hs: fix uninitialized data ni ad3552r_hs_write_data_source()
>       iio: backend: fix uninitialized data in debugfs
>       iio: core: fix uninitialized data in debugfs
> 
> David Carlier (1):
>       iio: pressure: bmp280: zero-init bmp580 trigger handler buffer
> 
> Felix Gu (1):
>       iio: buffer: hw-consumer: free scan_mask on buffer release
> 
> Javier Carrasco (1):
>       iio: light: veml6030: fix channel type when pushing events
> 
> Jonathan Cameron (1):
>       iio: adc: ad7768-1: Select GPIOLIB
> 
> Joshua Crofts (1):
>       iio: light: opt3001: fix missing state reset on timeout
> 
> Maxwell Doose (1):
>       iio: chemical: scd30: Cleanup initializations and fix sign-extension bug
> 
> Radu Sabau (2):
>       iio: adc: ad_sigma_delta: fix CS held asserted and state leaks
>       iio: adc: ad_sigma_delta: fix clear_pending_event for registerless devices
> 
> Rafael J. Wysocki (1):
>       iio: light: acpi-als: Check ACPI_COMPANION() against NULL
> 
> Sam Daly (2):
>       iio: light: veml6075: add bounds check to veml6075_it_ms index
>       iio: adc: ti-ads1298: add bounds check to pga_settings index
> 
> Stepan Ionichev (6):
>       iio: gyro: bmg160: bail out when bandwidth/filter is not in table
>       iio: gyro: bmg160: wait full startup time after mode change at probe
>       iio: proximity: vl53l0x: notify trigger and clear IRQ on error paths
>       iio: resolver: ad2s1210: notify trigger and clear state on fault read error
>       iio: temperature: tmp006: use devm_iio_trigger_register
>       iio: adc: qcom-spmi-iadc: balance enable_irq_wake() on driver unbind
> 
>  drivers/iio/adc/Kconfig                       |  2 ++
>  drivers/iio/adc/ad_sigma_delta.c              | 39 +++++++++++++++++++++++----
>  drivers/iio/adc/qcom-spmi-iadc.c              | 18 ++++++++++---
>  drivers/iio/adc/ti-ads1298.c                  |  7 ++++-
>  drivers/iio/buffer/industrialio-hw-consumer.c |  2 ++
>  drivers/iio/chemical/scd30_core.c             | 19 ++++++++++---
>  drivers/iio/dac/ad3552r-hs.c                  |  2 +-
>  drivers/iio/gyro/bmg160_core.c                | 16 +++++++++--
>  drivers/iio/industrialio-backend.c            |  2 +-
>  drivers/iio/industrialio-core.c               |  2 +-
>  drivers/iio/light/acpi-als.c                  |  6 ++++-
>  drivers/iio/light/al3010.c                    |  8 +++---
>  drivers/iio/light/al3320a.c                   |  8 +++---
>  drivers/iio/light/opt3001.c                   |  6 +++--
>  drivers/iio/light/veml6030.c                  |  8 +++---
>  drivers/iio/light/veml6075.c                  |  8 ++++--
>  drivers/iio/pressure/bmp280-core.c            |  2 +-
>  drivers/iio/proximity/vl53l0x-i2c.c           |  7 +++--
>  drivers/iio/resolver/ad2s1210.c               |  2 +-
>  drivers/iio/temperature/tmp006.c              |  2 +-
>  20 files changed, 127 insertions(+), 39 deletions(-)
> 

