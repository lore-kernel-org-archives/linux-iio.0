Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D121E091;
	Sun, 15 Feb 2026 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771171051; cv=none; b=n/q/SjaQTqwugpMAGqJ/oBF87hqP4RJ8pRt/X6wSU7b1R6pZV8zNxuP+CaHY7jI2eBpRQB9ZUACqIAgmg05hXT05ZH0ULDronW+DBKEOCTV69Z5QISFEsEGsN4gUSb99CBRKMK6SkbCWJzW5E1tA0beK1kQUlZF04reEM18U8ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771171051; c=relaxed/simple;
	bh=s7dFpX/9gYrhjJMvmJ+UXJYrqqyMjb7fOU7KUeEkJ3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbJlMdWJL/Lpw1hrLhv4Kupu0wX+xvz23/KdnD0OGVNkmljvB/SXzhOkQV/bAfJx5jzyWF2XtSt+diS/3+DtdC9zGSOKfkmlz+T13Vj4bV/j9DJZnlO2mV4kL1Ce0A2yZtW/6cssDkQ0niWWSzlm8aV0OqQHSJnYRG4if/Ohpms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAdjaAMD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAdjaAMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61049C4CEF7;
	Sun, 15 Feb 2026 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771171051;
	bh=s7dFpX/9gYrhjJMvmJ+UXJYrqqyMjb7fOU7KUeEkJ3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FAdjaAMDwSk3E9I1GA+g+2MUUrIcsTpJfij86BnehyZuZU8v+0X2mqnvr4A2W5n9C
	 rpb4LOFAuOgbTVClTeoR4mUaBL50u8iSyL5CttxKUCYYhawJUWZirUUUnb/yrqQUVE
	 m5Icmcz+1iA5vyvENdPUoaOBAGtA+z4F8h0JJY3uwgCpGd4niM+YlQfHoHt7Rx36jg
	 72vZJ8O63BmAL3C4TfScWNjAvmMTjVwd3U7wzG8BdcPdwGxUzifI6wzzvhKtedfTK2
	 7ehafkxsGdz0fqUToslHGJv4Mhs6LcViNdKaexLPK6oQTRU4f+Qmz3MzY1Y5u4v0UC
	 tokAJUo72j/GQ==
Date: Sun, 15 Feb 2026 15:57:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: dlechner@baylibre.com, rdunlap@infradead.org, skhan@linuxfoundation.org,
 linux-kernel-mentees-archive@lists.linuxfoundation.org, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: accel: adxl345: Add event scaling and doc
 fixes
Message-ID: <20260215155720.361c797b@jic23-huawei>
In-Reply-To: <20260214172145.69cab531@jic23-huawei>
References: <20260208150515.14798-1-0rayn.dev@gmail.com>
	<20260214172145.69cab531@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Feb 2026 17:21:45 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun,  8 Feb 2026 10:05:01 -0500
> Taha Ed-Dafili <0rayn.dev@gmail.com> wrote:
> 
> > This series addresses ADXL345 driver non-compliance with the IIO ABI
> > for event thresholds.
> > 
> > Currently, the driver exposes raw values for thresholds (e.g., tap,
> > activity) without providing the necessary scale factor to convert them
> > to SI units (m/s^2), as mandated by the ABI.
> > 
> > This series implements `IIO_EV_INFO_SCALE` in the IIO core and applies
> > it to the ADXL345 driver, ensuring that userspace can correctly
> > interpret threshold values. It also cleans up existing documentation
> > errors and typos.  
> 
> Nice series thanks!
> 
> Applied to the testing branch of iio.git which I'll rebase once rc1 is available.
Ah. Raced with other feedback. Dropped again for now.

Jonathan

> 
> Jonathan
> 
> > 
> > Changes in v3:
> > - Patch 1: Reverted "axis" -> "axes" change in documentation as it is
> >   used as an adjective (Randy Dunlap).
> > - Patch 2: Reworded commit message to "Implement support for..." instead
> >   of "missing from..." (David Lechner).
> > - Patch 4: Simplified documentation table by removing repetitive scale
> >   values from every row. Added explicit table entries for the new
> >   `in_accel_gesture_scale` and `in_accel_mag_scale` attributes instead
> >   (Jonathan Cameron).
> > - Patch 4: Fixed "inscale" typo in commit message.
> > 
> > Changes in v2:
> > - Added core infrastructure for IIO_EV_INFO_SCALE.
> > - Implemented event scaling (0.612915 m/s^2) for ADXL345.
> > - Fixed technical math/decimal errors in existing documentation.
> > - Cleaned up grammar and pluralization issues in .rst file.
> > 
> > Taha Ed-Dafili (4):
> >   docs: iio: adxl345: fix typos and grammar
> >   iio: core: Add IIO_EV_INFO_SCALE to event info
> >   iio: accel: adxl345: Implement event scaling for ABI compliance
> >   docs: iio: adxl345: update math and examples for scaling
> > 
> >  Documentation/iio/adxl345.rst    | 65 +++++++++++++++++++-------------
> >  drivers/iio/accel/adxl345_core.c | 28 +++++++++++---
> >  drivers/iio/industrialio-event.c |  1 +
> >  include/linux/iio/types.h        |  1 +
> >  4 files changed, 63 insertions(+), 32 deletions(-)
> >   
> 
> 

