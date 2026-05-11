Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4961D3FE642;
	Mon, 11 May 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510515; cv=none; b=HbaGal/hxOGYnO0yym6vDPhSx3R1+uNh6osKQ1r24q0IxF/oHI+pXUT/h7K1tB5lpi+jN0lCc7Nbek35dUwgzfLx9l/IQpxC7XO5TFny97xhGea+nryxw2HwgpJln12znp0A7qbZvQ63qt2Y2xnDD+64XRq3n1Zq0/DUNgTNhus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510515; c=relaxed/simple;
	bh=NJ3PlVPO8kXwBlDv4pTKeo7cVybv6t71NgvvrL3Bl/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqXieEu3yETzaOcJ2UGQ0/ESAN+Ms/7UThG9tW4jWD4x7tp5ju7Qy5rCQpuInhI1wpeBrjIscoCy6/j7+aOPGcFkllzz3IQdFQLDAz+eK4+e+E97Nac/zoeCq+/79hNwRKm9M1ucCXFZDEFZZ5xt34E7sDmrGAcM3bs1Huefl4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRnFfsfW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRnFfsfW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4D6C2BCB0;
	Mon, 11 May 2026 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778510515;
	bh=NJ3PlVPO8kXwBlDv4pTKeo7cVybv6t71NgvvrL3Bl/Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GRnFfsfWmcmC9s+6YMmV+5VdVbRT4v10Ednu3CslLIk8HWKJbfbYPImubzNz9CFAp
	 yS/n9VuKt6t9kKIpg6YkOzGTjLbSSgDrWc4D36EO9igQz/Cg44O6I0qsWrd/TkEPeV
	 TgjQ5C+3NzaTrIkDWEQPcknIv4ogw0euFPGaCSqWKrTiXAYvI2t/d1wiHYObN+Bn2i
	 BEhyUu7DXL1QZb5RdJwCu6vGkzzsH05aDPTjT3TgxMlIU4/uljcwMIsnfn19SFMrGp
	 Uyfrhjz3+JjVamWkc8Oif4ChoKVbgFnJPFqSV+1/V66iGb1xBM75NKYszCi7f1djjj
	 EMxhrfUFxwllg==
Date: Mon, 11 May 2026 15:41:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iio: accel: adxl3xx: Add timestamps to FIFO data
Message-ID: <20260511154145.145a9f3a@jic23-huawei>
In-Reply-To: <CAOTCDVsUF1qaYgSGa4hcDYOqmMpkK2G+HYeQ=ShQ1oEbM8nGJQ@mail.gmail.com>
References: <20260510082556.3867-1-shofiqtest@gmail.com>
	<agCA6HUnN5KMXj8J@ashevche-desk.local>
	<CAOTCDVsUF1qaYgSGa4hcDYOqmMpkK2G+HYeQ=ShQ1oEbM8nGJQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 10 May 2026 23:02:00 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> On the ABI question: none of the five drivers in this series define
> IIO_CHAN_SOFT_TIMESTAMP in their channel arrays, and their
> available_scan_masks do not include a timestamp bit.
> As a result, indio_dev->scan_timestamp is never set for any of them, which
> means iio_push_to_buffers_with_timestamp() writes no timestamp and the ca=
ll
> reduces to iio_push_to_buffers().
> The scan buffer content seen by userspace is byte-for-byte identical befo=
re
> and after this series. No ABI is changed.
>=20
> That said, this also means the series does not actually deliver timestamps
> to userspace. To do that, a follow-on patch adding
> IIO_CHAN_SOFT_TIMESTAMP(N) to each driver's channel array is required.
> That would be an intentional, explicit ABI addition. Should I include that
> in a v2 of this series?
>=20
Yes if you take this forward. However, so far I'm giving this a hard no.

> On hardware testing: I do not have any of the ADXL313/345/367/372/380
> devices. Given that the patches are currently a no-op for userspace the
> risk of a silent regression is low, but real-hardware confirmation is
> needed before this can be considered complete.
> If any maintainer or user of these parts on the list can run a test, I
> would welcome that.
>=20
> I also verified that the scan struct alignment is correct for all five
> drivers: the aligned_s64 ts field sits at offset 8 in each case, satisfyi=
ng
> the 8-byte alignment required by iio_push_to_buffers_with_timestamp().

It's no where near this simple.  Think about how a fifo is working.
You are adding a timestamp based on when the last element that triggered
the fifo watershed was added.  That is wrong for all the other data pulled
off the fifo which should have earlier timestamps.

It is possible to approximate the correct timestamps but it's complex.
See the support form the invensense IMUs which may not even be appropriate
to port to these drivers.

You definitely don't want to try getting timestamps working for a fifo
equipped part without real hardware so you can plot them over time and
verify there are no inconsistencies of bugs in your timestamp approximation
algorithm.

Note the invensense one has been rewritten several times - that should give
you an idea how hard this is to do.

Thanks,

Jonathan

>=20
> Thanks
> Shofiq
>=20
> On Sun, May 10, 2026 at 3:58=E2=80=AFPM Andy Shevchenko <andriy.shevchenk=
o@intel.com>
> wrote:
>=20
> > On Sun, May 10, 2026 at 11:25:51AM +0300, Md Shofiqul Islam wrote: =20
> > > Five ADXL-family accelerometer drivers (ADXL313, ADXL345, ADXL367,
> > > ADXL372, ADXL380) push buffered samples using iio_push_to_buffers(),
> > > which does not attach a hardware timestamp to the scan data.
> > > Userspace consumers therefore receive samples with no timing
> > > information.
> > >
> > > This series adds timestamp support uniformly across the family:
> > >
> > >   - A scan buffer struct with an aligned_s64 ts field is added to each
> > >     driver's state struct.  The struct layout ensures the timestamp
> > >     field sits at an 8-byte aligned offset as required by
> > >     iio_push_to_buffers_with_timestamp().
> > >
> > >   - In the FIFO push loop, FIFO data is copied into scan.channels via
> > >     memcpy(), then iio_push_to_buffers_with_timestamp() is called with
> > >     a single timestamp captured once per interrupt with
> > >     iio_get_time_ns().  Using one timestamp per IRQ is consistent with
> > >     the existing approach in the same handlers for event timestamps.
> > >
> > >   - For ADXL367, the helper adxl367_push_fifo_data() gains a s64 ts
> > >     parameter so the timestamp captured in the IRQ handler is passed
> > >     through instead of calling iio_get_time_ns() a second time.
> > >
> > >   - For ADXL372 and ADXL380, where the IRQ handler already called
> > >     iio_get_time_ns() for the event push, the same captured timestamp
> > >     is now also passed to the FIFO push, removing the duplicate call.
> > >
> > > The ADXL313 and ADXL345 drivers always scan all three axes together
> > > (available_scan_masks contains only the full X|Y|Z mask), so their
> > > scan buffer layout is fixed.  The ADXL367, ADXL372, and ADXL380
> > > drivers support variable scan masks; fifo_set_size tracks the number
> > > of enabled channels per sample set and is used as the memcpy length. =
=20
> >
> > This is sensitive change. Do we have any confirmation that this
> > - does work as expected on real HW and platforms that use these devices
> > - does not break any ABI
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >
> > =20

