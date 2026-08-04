Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21059379C32;
	Tue,  4 Aug 2026 23:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785884699; cv=none; b=cefPbgU3Zo2Ma5DUaXJu6LnDrq8lLTG2e+tWfzgNaKnF6Nyy/LUNLOo8lxenW58400baHGSt829nIqug3vN1s4eLKIqnp1wdth5kGlUC+52amU+2P/M72dwVXeKiLVw4nsAUu0js15V4u3lDHrJ8o5QnySnr+YeszsKALuThKCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785884699; c=relaxed/simple;
	bh=tTsSGHsu98FWYOxp4gmLrT5Plss1ApqRmZ7ceLmXLBk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P8H9Ncs3Vgi3pxjtxKlMm5qxV1MyF2C/ShzCkg6sDT5WY3+zsDNCXY9i1dgwuYxqUk6TNC8+6iFgklUMfBFsvMKG8m6BznjT5PaMdKvO6dU39o/82FZhzejUSYab3epn3Do0qN+cZ34ZyUiEUntcQIIwH/q4nDHLs6/9RlT0JFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+6CBQ7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+6CBQ7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52861F000E9;
	Tue,  4 Aug 2026 23:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785884697;
	bh=vkYR+KHg1fGJLtFxgJJQFjzMCP7pY+WvJLwLRCnbLQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R+6CBQ7I/jG5PUtuCDh2H1KyhRIIo6O+BXsWeUb6Zj0ZXdi5FIEUL1TQ9ULjEJ65V
	 GUfq902rK30u283g5cx6Mh7rTQ7gTou5N1mPeny4dGwm6QRU12CGBgnXrHKh2gAwn3
	 FGa/0EkyPOQ4Z1DC9XL82Sa4afqBcwV7+u+btA72pun0cc9NY6NlbI3EGtzWF+kn2c
	 a2u4QehVhz96Dt+r2Kmtl0kQCPcFvqNd9d+eMstgu+/qfBDYjmSvrmJKAGzsqxBdxF
	 9/19PJt1HJfy/BhxMIwSiztA5M7OoIo7+OD7rpkPG9JmeY1NB4ESHh72x3wjwL98zj
	 zG3H8Pm/V7bbQ==
Date: Wed, 5 Aug 2026 00:04:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 maxwell@maxwelld.cc, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com,
 455.rodrigo.alencar@gmail.com
Subject: Re: [PATCH v6 0/4] iio: flow: Sensirion SLF3S liquid flow sensor
Message-ID: <20260805000452.3fd1de5e@jic23-huawei>
In-Reply-To: <20260802005042.2352936e@jic23-huawei>
References: <20260728214943.29820-1-wafgo01@gmail.com>
	<20260802005042.2352936e@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 00:50:42 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 28 Jul 2026 23:49:39 +0200
> Wadim Mueller <wafgo01@gmail.com> wrote:
> 
> > Hi all,
> > 
> > this series adds a driver for the Sensirion SLF3S family of I2C liquid
> > flow sensors (SLF3S-0600F / -1300F / -4000B) and a new IIO_VOLUMEFLOW
> > channel type.  
> 
> I'm going to apply this now, but as it will be in my testing branch (which
> I do rebase) for a few days fully welcome any additional comments or
> tags.
> 
> Applied to the testing branch of iio.git
Tags updated and now pushed out as the togreg branch as well

Thanks,

J
> 
> Thanks,
> 
> Jonathan
> > 
> > First of all: sorry for the noise.  Patch 4/4 of v5 never made it to the
> > list or to patchwork - it got lost on the way out from the machine I sent
> > v5 from, as Jonathan noticed:
> > 
> >   https://lore.kernel.org/linux-iio/20260720032927.14fc4f9f@jic23-huawei/
> > 
> > So this v6 is mostly a resend of v5 with the driver patch actually
> > included, plus the binding change we converged on in the meantime.  The
> > driver changes that were listed in the v5 changelog are repeated below,
> > since nobody got to see them.
> > 
> > The series is based on iio.git testing, which already contains Rodrigo
> > Alencar's IIO_VAL_DECIMAL64_* core formatting work; patch 3/4 adds the
> > IIO_VAL_DECIMAL64_FEMTO format type on top of it.
> > 
> > Changes since v5
> > ----------------
> >   * 4/4 is included this time - v5 only had 1-3 on the list
> >   * dt-bindings: dropped the fallback compatible entirely; each variant
> >     now has its own compatible, per the conclusion of the v4 discussion
> >     between Krzysztof and Jonathan.  Since the driver has to look at the
> >     product-information register anyway, a fallback buys nothing, while
> >     separate compatibles let a future drop-in part claim a known
> >     compatible and work on older kernels
> >   * dt-bindings: dropped Krzysztof's Reviewed-by, since the compatible
> >     schema changed
> >   * dt-bindings: commit message and example updated accordingly
> >   * driver: reworded the slf3s_detect_variant() comment and the commit
> >     message, which referred to the now-gone fallback compatible.  The
> >     behaviour is unchanged: an unknown sub-type still falls back to the
> >     variant named in the device tree / I2C table
> >   * rebased onto current iio.git testing
> > 
> > Changes since v4 (from the v5 posting, repeated because 4/4 was lost)
> > ---------------------------------------------------------------------
> >   * driver: include err.h for PTR_ERR() and math.h for struct s32_fract,
> >     per Andy
> >   * driver: fold the per-variant scale_num/scale_den pair into a
> >     struct s32_fract, per Andy
> >   * driver: add enum slf3s_variant_id and use it for the variant table
> >     and the I2C/OF match tables instead of bare indices, per Andy
> >   * driver: slf3s_send_cmd(): drop the "at_least 2" parameter
> >     annotation, decouple the ret assignment from its declaration and
> >     check errors first, per Andy
> >   * driver: use sizeof() instead of ARRAY_SIZE() for the measurement
> >     byte buffer, per Andy
> >   * driver: parenthesise the (FEMTO / MILLI) factor so it folds into a
> >     single constant multiplication, per Andy
> >   * driver: derive the temperature scale from MILLIDEGREE_PER_DEGREE
> >     instead of a bare 1000, per Andy
> >   * driver: checked the struct slf3s_data layout (re Andy's pahole
> >     question): the non-pointer members total 260 bytes, so one 4-byte
> >     hole remains for any member order; left as is
> >   * driver: drop the inline comment on the mutex that duplicated the
> >     kernel-doc, per Jonathan (checkpatch still moans about it)
> >   * driver: fix the duplicated argument in the DT/sensor variant
> >     mismatch dev_info(), per Jonathan
> >   * driver: reformat the i2c_device_id/of_device_id tables to one
> >     member per line, per Jonathan
> >   * MAINTAINERS: updated Maxwell's address in the R: entry to
> >     maxwell@maxwelld.cc, as he requested on the v4 thread
> > 
> > The signaling-flags word (air-in-line / high-flow / smoothing status) in
> > each measurement frame is intentionally not read; exposing it can be a
> > later follow-up.
> > 
> > v5: https://lore.kernel.org/linux-iio/20260714085358.20842-1-wafgo01@gmail.com/
> > v4: https://lore.kernel.org/linux-iio/20260611132700.671322-1-wafgo01@gmail.com/
> > 
> > Thanks,
> > Wadim
> > 
> > Wadim Mueller (4):
> >   iio: types: add IIO_VOLUMEFLOW channel type
> >   dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
> >   iio: core: add IIO_VAL_DECIMAL64_FEMTO format type
> >   iio: flow: add Sensirion SLF3S liquid flow sensor driver
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio       |  11 +
> >  Documentation/ABI/testing/sysfs-bus-iio-flow  |  21 +
> >  .../bindings/iio/flow/sensirion,slf3s.yaml    |  55 ++
> >  MAINTAINERS                                   |   8 +
> >  drivers/iio/Kconfig                           |   1 +
> >  drivers/iio/Makefile                          |   1 +
> >  drivers/iio/flow/Kconfig                      |  22 +
> >  drivers/iio/flow/Makefile                     |   7 +
> >  drivers/iio/flow/slf3s.c                      | 543 ++++++++++++++++++
> >  drivers/iio/industrialio-core.c               |   3 +
> >  include/linux/iio/types.h                     |   1 +
> >  include/uapi/linux/iio/types.h                |   1 +
> >  tools/iio/iio_event_monitor.c                 |   2 +
> >  13 files changed, 676 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-flow
> >  create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> >  create mode 100644 drivers/iio/flow/Kconfig
> >  create mode 100644 drivers/iio/flow/Makefile
> >  create mode 100644 drivers/iio/flow/slf3s.c
> > 
> > 
> > base-commit: e0484d62e8e1cff75b210938be835ea6221bda59  
> 
> 

