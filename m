Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD181DF248;
	Sun,  6 Sep 2026 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788655012; cv=none; b=anyreE4ZovyYK0ublIT0jTBn4RcpAlm8y6YnNHtVO33bAMjAm/IojAkpRl6sAdfxB/JH5QudMmgnhQunTZRox8kXhqwPyqW7a0MGaythn2vDf0bQiMXkKbjAvOXDRedO37nMSULgWciV8TY2m+ZIpUuEpZfcYq+nQ+lABW0GU+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788655012; c=relaxed/simple;
	bh=RaLxNpybnbMkQfXQATVTdJJU15X6lJrhbRnTxKgXKbI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPLE4+eWaB5ww8YHgfFqy3F1O84KW6Qk5SjnymcyNz53mSglpbVBTwTgBeDwyGNJoCZp6T9DGrTZq1dZAl5Bv9V6xiNV5EiVt2G9ticquZei7IMQOfUE4mD+qoXKoygpeEMU5aPUD3z42luKY/RMJvrCFKXqIVsV0WURQJN0OG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hX2tTg4u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hX2tTg4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742EF1F00A3A;
	Sun,  6 Sep 2026 00:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788655010;
	bh=b0LljruB38lpsTELuDbt8u+1fE4q0VDd8gdamx+9qVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hX2tTg4uigmpv9pmQjY2XJheavbCM+gWwqr4+zu3zEnhAfiT3FZWCL5Ixnyqpz/4V
	 NUR3C4I2x4qybwm9E1rLkGBIRJYO4xZQmoB7moFfa1Tj2kidhiGk8l6m6NxHQ2hwWU
	 CYejYFTRRxlx3UwTVmdkY987hAuCP75kO8ZKT/doSilsS7rHOCLcGpmDfeNFui8yiy
	 swEtDZMHRc1dZHsCrbDbAIlpBvi3tLOOB9HVZU+k3AHbNdSOpML6xdmsmpTPjP9CbL
	 aOqG/ECJQ+GzXxJDRzsPQ3dNxqcn3hxov7oysmnx5b22gwElWaiTcQ478aq/smY/SH
	 a2gjX3Q68m1Ug==
Date: Sun, 6 Sep 2026 01:36:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] iio: adc: ti-ads112c14: add filter support
Message-ID: <20260906013645.2ed1704c@jic23-huawei>
In-Reply-To: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
References: <20260904-iio-adc-ti-ads112c14-filter-support-v2-0-f86592360658@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 04 Sep 2026 17:09:45 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> I was hoping to avoid this, but until [0] lands, sashiko doesn't know
> how to handle patch series with dependencies. So I have combined my
> three outstanding ti-ads112c14 series into a single one. It's really
> too much all at once, but this seems the best way to speed up the review
> process at the moment.
>=20
> [0]: https://github.com/sashiko-dev/sashiko/pull/389

Nice. I hope that lands.  Not being in a sensible position to cherry-pick
off the start of a series is leading to a lot more patches outstanding
on list than I like.  I was drawing up a list of asks but seems folk
are already on top of them!

As a temporary solution this is fine.

Given my goldfish brain I can't remember if I reviewed much of this
recently so I'll just start at the top again!

Thanks

Jonathan


>=20
> So we now have:
>=20
> * patches 1-3: "iio: adc: ti-ads112c14: continuous mode support", last
>   posted as v5 [1]
> * patches 4-5: "iio: adc: ti-ads112c14: add burnout current support",
>   last posted as v2 [2]
> * patches 6-10: "iio: adc: ti-ads112c14: add filter support", last
>   posted as v1 [3]
>=20
> Apart from the changes listed below, the patches are the same as in
> those postings.
>=20
> [1]: https://patch.msgid.link/20260831-iio-adc-ti-ads112c14-continuous-mo=
de-v5-0-76f80a04b94f@baylibre.com
> [2]: https://patch.msgid.link/20260827-iio-adc-ti-ads112c14-burnout-v2-0-=
00a1fab9e2d1@baylibre.com
> [3]: https://patch.msgid.link/20260807-iio-adc-ti-ads112c14-filter-suppor=
t-v1-0-4d3ba00caf18@baylibre.com
>=20
> The rest of this cover letter describes the filter support portion.
>=20
> TI ADS112C14 has several features related to filtering that are all
> interconnected. And to make things more interesting, not of the register
> fields map directly to IIO attributes. So this is one of those cases
> where we need to bend the rules a bit and just document it (we've
> already discussed this a bit in the previous series for this driver and
> came to this conclusion).
>=20
> Here is the high-level overview:
>=20
> We are adding sampling_frequency, oversampling_ratio, filter_type, and
> a (new to IIO) settlingtime attribute.
>=20
> Since register fields have different meanings depending on filter type
> we have a quirky rule that if the filter type is sinc4 or sinc4+sinc1,
> then you need to set the oversampling ratio first in order to see the
> expected available values for the sampling frequency. For sinc4+sinc1+pf1
> it is the other way around, you have to set sampling frequency first
> in order to see the expected available oversampling ratios.
>=20
> In other drivers, we've opted to store the requested values for dependant
> attributes like this and pick the closest available one when actually
> starting sampling. I opted not to do that here as there is not much
> overlap between settings. And as we will see below, there are other
> reasons for being picky about sampling frequency.
>=20
> We also discussed in another series about a proposed settlingtime
> attribute. The conclusion was that it should be the total settling time
> delay (in seconds) before a chip takes the first sample (after any
> settings have changed). In this chip there is a DELAY field in a
> register that programs some extra delay in addition to an always present
> fixed delay. So the way the attribute will work for this chip is that
> the settlingtime_available attribute will list the range including a
> minimum value. This happens to be the always present fixed delay. So the
> difference between that and the current value of the settlingtime
> attribute will be programed as the DELAY value. It also seems that the
> fixed latency period includes the conversion time. We've just glossed
> over that for now and not subtracted that from the settlingtime
>  attribute.
>=20
> Now, here is where things really get interesting/complicated. There are
> even more settings that affect the settling time. We defined the
> settling time as just a delay before the first sample. However, there
> are a couple of things that trigger the "first" sample. On this chip,
> the first sample only counts in continuous sampling mode. So only works
> as described when using the DRDY trigger in this driver. When using
> a generic trigger, e.g. a hrtimer trigger, single-shot sampling mode
> is used, so every sample is a "first" sample and has the settling delay
> added. This is mostly a non-issue other than it could throw people off
> that they cannot set the hrtimer frequency close to the sampling
> frequency attribute and actually get that sampling rate.
>=20
> And there a few other idiosyncrasies we haven't accounted for. To keep
> things simple, we've implemented settlingtime as tDELAY + tLATENCY
> (datasheet values). But this actually include the conversion time as
> well. Also, tLATENCY is longer if you are coming out of standby mode
> (this doesn't matter at this point since we didn't implement power
> management, but we wouldn't want to change it and break userspace
> later).
>=20
> Then there is also input chopping where the positive and negative input
> channels are swapped in the mux in the ADC on each sample. In these
> cases, every conversion requires the settling time because the mux is
> switched after every conversion. And the actual first sample has
> additional delay (presumably does two conversions). So the first sample
> takes tGC_LATENCY =3D 2 =C3=97 (tDELAY + tLATENCY) =E2=80=93 12 tMOD and =
every sample
> after that takes tGC_DATA =3D tDELAY + tLATENCY =E2=80=93 12 tMOD. For th=
is one,
> I have valued simplicity over accuracy in the implementation, so it is
> the same where settlingtime =3D tDELAY + tLATENCY and not worried about
> the 12 tMOD difference. I think it makes sense to keep settlingtime
> as a single tDELAY + tLATENCY in this case since the when the mux
> changes after each sample, the next sample is now the first sample after
> settings have changed.
>=20
> This sort of breaks the definition of sampling frequency though since
> in IIO, the 1 / sampling frequency is the time between each sample
> being sent over the bus. I don't really want to change how sampling
> frequency is implemented here though because the current values match
> the datasheet which can be used to infer information like where the
> notches in the filter are. The actual observed sampling rate will be
> 1 / tGC_DATA.
>=20
> Having written all of this out now though, I'm tempted to go back and
> change the settlingtime attribute implementation to be more accurate.
> In any case, tDELAY will always be easy to infer because it is the
> current value minus the minimum value (from the _available attribute).
> Then when using input chopping one could get a reasonably accurate
> sample period by taking 1 / sampling_frequency + settlingtime.
>=20
> We will follow this up later with a documentation patch that explains
> all of this too.
>=20
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Combined the continuous mode support and burnout current support
>   series into this series (see above).
> - Rebased on the current iio/testing.
> - Bumped KernelVersion to 7.4 in the settlingtime ABI documentation so
>   that it matches the rest of the new ABI in this series.
> - Patches 1-3 (continuous mode): no changes since v5 [1].
>    - FWIW, I didn't think sashiko's comments on the IRQ were realistic.
>      This could never be used with a level interrupt. And we haven't
>      typically tried to handle spurious interrupts in the past either.
>      Everything it suggested could only happen with broken hardware or
>      excessive noise (which I suppose counts as broken hardware).
> - Patches 4-5 (burnout), changes since v2 [2]:
>   - Pass an integer rather than a boolean to FIELD_PREP() for the global
>     chop enable bit.
>   - Drop the blank line after looking up the measurement.
>   - Return the conversion error in preference to the error from turning
>     the burnout current back off.
>   - Use a local variable for the "burn-out-current-nanoamp" property
>     name.
>   - Compare against ADS112C14_DEVICE_CFG_BOCS_DISABLED explicitly
>     instead of testing for non-zero.
>   - Fix KernelVersion in the ABI docs.
> - Patches 6-10 (filter support), changes since v1 [3]:
>   - Move the driver code that was accidentally squashed into the
>     "iio: ABI: add sinc4+sinc1+pf1 filter_type" patch back to the
>     "iio: adc: ti-ads112c14: add filter support" patch where it belongs.
>   - Fixed typos in the external clock patch commit message.
>   - Added a note to the settlingtime ABI documentation that the settling
>     time can apply to more than just the first conversion.
> - Link to v1: https://patch.msgid.link/20260807-iio-adc-ti-ads112c14-filt=
er-support-v1-0-4d3ba00caf18@baylibre.com
>=20
> ---
> David Lechner (TI) (10):
>       iio: adc: ti-ads112c14: add DRDY interrupt support
>       iio: adc: ti-ads112c14: create data read helper functions
>       iio: adc: ti-ads112c14: add continuous mode support
>       iio: adc: ti-ads112c14: add burnout current support
>       iio: ABI: add sysfs attribute for _burnoutraw
>       iio: adc: ti-ads112c14: support external clock
>       iio: adc: ti-ads112c14: add filter support
>       iio: ABI: add sinc4+sinc1+pf1 filter_type
>       iio: adc: ti-ads112c14: add settlingtime attribute
>       iio: ABI: add settlingtime attributes
>=20
>  Documentation/ABI/testing/sysfs-bus-iio     |   27 +
>  Documentation/ABI/testing/sysfs-bus-iio-adc |    9 +
>  drivers/iio/adc/ti-ads112c14.c              | 1286 +++++++++++++++++++++=
++++--
>  3 files changed, 1263 insertions(+), 59 deletions(-)
> ---
> base-commit: e7c1d459e542bc4a9c57f558e8ca1b14df7a7eef
> change-id: 20260807-iio-adc-ti-ads112c14-filter-support-8a56850f590f
>=20
> Best regards,
> -- =20
> David Lechner (TI) <dlechner@baylibre.com>
>=20

