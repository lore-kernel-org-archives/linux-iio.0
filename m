Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE637DEA0;
	Sun, 12 Apr 2026 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007773; cv=none; b=SEgUP3q+y0w65xtJB55uYhW3VfyDf949ltrOmSTJ9H0SjpfdecFIrxtDfCEul4A46WvNM+gDQqwdcp7RQCDKTSDULYtYPQz/3FU+NO+2e20u/vB5w0wDa18IawsLjOke+f/KvQyQ51JVy7vfTLjEWWDfxf8zCpJ6NEuJ7+Ec9Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007773; c=relaxed/simple;
	bh=JeSXEAZiOxVYxO1i9V3uEPh79EOVLeFPfgMwh7IRXo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muwxQLUTikLo8D0cXL9HvDsZtg4MRiTGOtXE9prFmWBdB4W4AGQpvyQaTDRP/7BVEAnoHuHazaMW0pFmSVl8HPRB3BGtTg7eYlZerUGC35UuKazr4+YT5lUf1elK3dDg4oBE2W8v9HKaw+BQ7/43U/0J4JjvM/TzMdmjczggOTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQkie8cS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQkie8cS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A251C19424;
	Sun, 12 Apr 2026 15:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776007773;
	bh=JeSXEAZiOxVYxO1i9V3uEPh79EOVLeFPfgMwh7IRXo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AQkie8cSzcd7LEyunBifrkvrY4I5014mxY8NG22Dt3FxAJrAQsgICCvFQJicSobCZ
	 FSOJYnQrUtGMg7lGe+dlu9Tgry/YxC4wJrxtBm7s1D8XnuJaistzvW+kvoclrDZVP2
	 eGCBsx0Cm8gbl5dgAQ8CaWOq/rZGzidbGHSCqRhun2Or1FgNXL1KBLkStn5Aso2hW4
	 iO0xAhqLuNYQpdscQVVJnUQ7UHYJS/4euTOSeqmILwU0aGPY0E4Wa61GjiWa/Sq/b7
	 qOP7YCRVK8AiMi5Ruv3qGPaujujBbMv27oLi2ngIIeAdPBSkyW2TPehH6ny5Oq6mo1
	 olxONySWHGbRA==
Date: Sun, 12 Apr 2026 16:29:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/6] imu: st_lsm6dsx: Add support for rotation sensor
Message-ID: <20260412162925.4226ea26@jic23-huawei>
In-Reply-To: <20260324084655.653781-1-flavra@baylibre.com>
References: <20260324084655.653781-1-flavra@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 09:46:55 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> This series adds support for the rotation sensor functionality present in
> some chips from the ST LSM6DSX IMU family.
> The IIO ABI has been amended to allow the use of floating-point data and
> a "quaternion axis" channel modifier in IIO buffers.
> 
> The use of the new modifier depends on [0] to get the correct sizing of the
> buffer in userspace.

Applied to the testing branch of iio.git with minor tweaks to fix up
that stray label in patch 6 and the code alignment suggestion Andy made
in patch 1.  Note this is next cycle material, so I'll be rebasing
the tree on rc1 once available and only then will it go out as togreg
and show up in linux-next.

Thanks,

Jonathan

> 
> Tested on LSM6DSV16X.
> 
> Changes from v8 [8]:
> - changed comments for IIO_SCAN_FORMAT_* macros to use proper kernel doc
>   format with one comment per macro (David)
> - in tools/iio, added error print if 1-byte floats are encountered and if
>   2-byte floats are encountered when unsupported (David)
> - in tools/iio, renamed signchar variable to formatchar (David)
> - added David's Reviewed-by tag to patch 5
> - in st_lsm6dsx_fusion.c, avoided mixing cleanup and gotos by adding a
>   helper function (Jonathan)
> - in st_lsm6dsx_fusion.c, removed leading double spaces in comment
>   (Jonathan)
> - in ST_LSM6DSX_CHANNEL_ROT macro, replaced literal 'f' with
>   IIO_SCAN_FORMAT_FLOAT
> 
> Changes from v7 [7]:
> - added Lorenzo's Acked-by tag to patch 1
> - in st_lsm6dsx_buffer.c, added st_lsm6dsx_check_data() helper function
>   (Lorenzo)
> - added definition of IIO_SCAN_FORMAT_* symbolic constants to restrict
>   flexibility of what can go in .format (Jonathan)
> - re-added @sign description in kernel.doc comment for
>   struct iio_scan_type, mentioning that @format should be used in new code
>   (Jonathan)
> - in tools/iio/iio_generic_buffer, replaced legacy __fp16 type with
>   standard-compliant _Float16 (David)
> - in tools/iio/iio_generic_buffer, added check for compiler support
>   (David), so that compilation does not fail with compilers that don't
>   support _Float16: tested with gcc for x86-64 (supported), for aarch64
>   (supported), for riscv-64 (not supported), clang for x86-64 (not
>   supported)
> - in tols/iio/iio_utils.h, replaced unsigned with char type for `format`
>   field in struct iio_channel_info (David)
> - renamed "partial quaternion" modifier to "quaternion axis"
> - moved new modifier value at the end of enum iio_modifier (David)
> - squashed the two words together in the modifier name (Jonathan)
> - in ABI doc for new modifier, fixed typo and angle units (David)
> - in ABI doc for new modifier, fixed kernel-doc warning (kernel test robot)
> - in st_lsm6dsx_fusion.c, added missing header includes (Andy)
> 
> Changes from v6 [6]:
> - dropped patches 1 and 2 (already picked up by Jonathan)
> - added floating-point support to iio-tools (Andy)
> - replaced `sign` field in struct iio_scan_type with union instead of
>   `format` field (David, Jonathan)
> - changed [s|u|f] to [f|s|u] in ABI and driver documentation files (Andy)
> - removed IIO_CUSTOM channel type in favor of IIO_MOD_PARTIAL_QUATERNION
>   modifier (David, Andy)
> - replaced "sf" with "fusion" in type, variable and function names (David)
> - added copyright statement in st_lsm6dsx_fusion.c (David)
> - added `ret` variable in st_lsm6dsx_fusion_probe() for better readability
>   (Andy)
> - modified data structure holding the list of available frequencies in
>   order to replace device attribute with .read_avail callback (David)
> 
> Changes from v5 [5]:
> - cleaned up FIFO data representation in st_lsm6dsx_read_tagged_fifo() to
>   avoid casting (Andy, Jonathan)
> - renamed 'sign' field to `format` in struct iio_scan_type
> - added support for IEEE 754 floating-point format in buffer scan elements
> - added custom data type in the ABI (IIO_CUSTOM in enum iio_chan_type)
>   (Jonathan)
> - added driver document in Documentation/iio/ (Jonathan)
> 
> Changes from v4 [4]:
> - changed data parameter in st_lsm6dsx_push_tagged_data() to __le16 *
>   (Andy)
> 
> Changes from v3 [3]:
> - added patch 3 (Andy)
> - removed unneeded checks for negative return values in st_lsm6dsx_fusion.c
>   (Andy)
> - replaced st_lsm6dsx_sf_set_page function with
>   st_lsm6dsx_sf_page_enable/disable (Andy)
> - used reversed xmas tree ordering for local variables (Andy)
> - added parentheses to MILLI / MICRO in st_lsm6dsx_sf_write_raw (Andy)
> - added check for string truncation in st_lsm6dsx_sf_probe (Andy)
> 
> Changes from v2 [2]:
> - amended description of patch 2 to point out that there are no supported
>   gyro events (Jonathan)
> - removed superfluous parentheses in st_lsm6dsx_fifo_setup (Lorenzo)
> - added Lorenzo's acked-by tag to patch 3
> - added missing checks of st_lsm6dsx_sf_set_page() return value (Jonathan)
> - added comment in st_lsm6dsx_sf_write_raw (Jonathan)
> 
> Changes from v1 [1]:
> - swapped patches 1 and 2 (Jonathan)
> - miscellaneous stylistic changes (Andy)
> - fixed usage of MICRO and MILLI constants in st_lsm6dsx_sf_read_raw and
>   st_lsm6dsx_sf_write_raw (Andy)
> - replaced scnprintf() with sysfs_emit_at() in
>   st_lsm6dsx_sf_sampling_freq_avail (Andy)
> - replaced scnprintf() with snprintf() in st_lsm6dsx_sf_probe (Andy)
> - clarified in a comment in st_lsm6dsx_set_fifo_odr() that only internal
>   sensors have a FIFO ODR configuration register (Jonathan)
> - modified patch 3 description to explain justification for the extra IIO
>   device (Jonathan)
> - moved page lock from st_lsm6dsx_sf_set_page() to the callers (Jonathan)
> - s/magnetometer/gyroscope/ in patch 2 description
> 
> [0]: https://lore.kernel.org/linux-iio/20260307-iio-fix-timestamp-alignment-v2-4-d1d48fbadbbf@baylibre.com/
> [1] https://lore.kernel.org/linux-iio/20260109181528.154127-1-flavra@baylibre.com/T/
> [2] https://lore.kernel.org/linux-iio/20260115122431.1014630-1-flavra@baylibre.com/T/
> [3] https://lore.kernel.org/linux-iio/20260119100449.1559624-1-flavra@baylibre.com/T/
> [4] https://lore.kernel.org/linux-iio/20260121112758.1831077-1-flavra@baylibre.com/T/
> [5] https://lore.kernel.org/linux-iio/20260122162335.2020006-1-flavra@baylibre.com/T/
> [6] https://lore.kernel.org/linux-iio/20260225100421.2366864-1-flavra@baylibre.com/T/
> [7] https://lore.kernel.org/linux-iio/20260304080519.2844101-1-flavra@baylibre.com/T/
> [8] https://lore.kernel.org/linux-iio/20260317150316.3878107-1-flavra@baylibre.com/T/
> 
> Francesco Lavra (6):
>   iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
>   iio: Replace 'sign' field with union in struct iio_scan_type
>   iio: tools: Add support for floating-point types in buffer scan
>     elements
>   iio: ABI: Add support for floating-point numbers in buffer scan
>     elements
>   iio: ABI: Add quaternion axis modifier
>   iio: imu: st_lsm6dsx: Add support for rotation sensor
> 
>  Documentation/ABI/testing/sysfs-bus-iio       |  48 ++--
>  Documentation/driver-api/iio/buffers.rst      |   7 +-
>  Documentation/iio/iio_devbuf.rst              |   3 +-
>  drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  28 +-
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  40 ++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 243 ++++++++++++++++++
>  drivers/iio/industrialio-core.c               |   1 +
>  include/linux/iio/iio.h                       |  30 ++-
>  include/uapi/linux/iio/types.h                |   1 +
>  tools/iio/iio_event_monitor.c                 |   1 +
>  tools/iio/iio_generic_buffer.c                |  70 ++++-
>  tools/iio/iio_utils.c                         |  12 +-
>  tools/iio/iio_utils.h                         |   4 +-
>  15 files changed, 495 insertions(+), 53 deletions(-)
>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> 

