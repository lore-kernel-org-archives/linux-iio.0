Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12987136358;
	Sun, 21 Jun 2026 12:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782045704; cv=none; b=s+bSOsFM51oRiBvwFVA9jjgfjewN1INJD9j9MpNE/sxRjSRdQE8tXoG8A3btHp6WOd4DWJCbdnuh8MQ3revuhjzU33L2ZKrCtpH6SfIxOzVDDKa5o63zZ6d6wLGFThfKfv87tAcZCOl8KeLluOHwd7CXnAl0Q/2wMllscxDeKEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782045704; c=relaxed/simple;
	bh=Iwvz1oB7F4H0M5UzMHPGtQ+J17Oz/OUR4eYiGvGm4BM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GO278e5MzMsgxrFVJh5Sd+PSxHPzHBDxiQIn8aW910WBYTaq2CxGiatkJ2fwLdpqptWmxfjW7ss+5H0ur9lHoUUjB0YDOW4G9ohYR8Nt7LOkFgO22YsPqAFE62UbA8Hd7K87OG/p+xyKtht3BMWLUDL+QX/J+wRNv1ezgdtyDo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2ssSgFH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2ssSgFH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0EC1F000E9;
	Sun, 21 Jun 2026 12:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782045702;
	bh=5arIUg5n+BvsRbfOJFYCG+zJ+abvFikYKOsbm1AbBJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b2ssSgFH1RMS2OSr22xd0r66ptuhnHAFBBgDOUrYoj9Ol1FQ/n/PfsKD6/M2aDju1
	 jeJ+fPQGgehhWagrtbb/m4wjF/1Bcpz9+o7LEdY2Y7pxqqodXTdSNRPzP4EDuC1lRY
	 ENmd6Zxd5di3URzb0sp7YWKwoBtn7RkAReUVmW833oR3Iuqqq4p0VvlQBnc/IV7+b9
	 vV7JHsQOxPdj6eFql9oKy0U1sP62zXj84IbLAtYq79XQQiPUGrBnNKDZFkQmO3gnkO
	 Wx305tjG8cF3U+NtH16zR3qzguqASiBSlBG+KIoUHYqeyhdeh59frCpHpjL0hJn5yl
	 mOdn2p4oOHM0w==
Date: Sun, 21 Jun 2026 13:41:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: me@herrie.org
Cc: github.com@herrie.org, linusw@kernel.org, denis.ciocca@st.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sanjayembeddedse@gmail.com, maudspierings@gocontroll.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: st,st-sensors: add
 st,fullscale-mg
Message-ID: <20260621134131.2341019c@jic23-huawei>
In-Reply-To: <6475e269775789d61ade326190b0d234@herrie.org>
References: <cover.1780652883.git.github.com@herrie.org>
	<e49aba850b1f48ea00089e7142c00584541001eb.1780652883.git.github.com@herrie.org>
	<20260614194442.61191f68@jic23-huawei>
	<6475e269775789d61ade326190b0d234@herrie.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 13:16:52 +0200
me@herrie.org wrote:

> On 2026-06-14 20:44, Jonathan Cameron wrote:
> > On Fri,  5 Jun 2026 12:08:42 +0200
> > Herman van Hazendonk <github.com@herrie.org> wrote:
> >   
> >> Add an optional st,fullscale-mg property that selects the initial
> >> full-scale range of an ST MEMS sensor at probe time, expressed in
> >> milligauss for magnetometers (and analogous engineering units for
> >> other ST sensor families that may grow this property in the future).
> >> 
> >> The property is purely additive: if absent, drivers fall back to
> >> their existing chip default, and if present but unsupported by the
> >> specific sensor the driver warns and falls back. No existing in-tree
> >> DTS is affected.
> >> 
> >> The motivating case is the LSM303DLH magnetometer on the HP TouchPad
> >> (apq8060 / tenderloin) where the kernel's chip-default +/-1.3 G range
> >> saturates the X axis to the chip's 0xF000 overflow sentinel out of
> >> probe, because the chip is mounted close to surrounding power planes
> >> and picks up enough DC bias to exceed the smallest range. The driver
> >> core hardcodes fs_avl[0] as the starting range, so userspace cannot
> >> recover without racing the driver to write the in_magn_x_scale sysfs
> >> attribute after probe. st,fullscale-mg lets the device tree declare
> >> a wider initial range up-front and avoids the race entirely.  
> > 
> > I'm trying to understand what you mean here by racing.
> > 
> > If we get this overflow condition the chip is wedged until reset, or
> > userspace simply has to change the range to recover?
> > 
> > I'm wondering if a UDEV rule is sufficient in theory to fix this.
> > 
> > I'm not necessarily against having the range in DT as it is effectively
> > hardware dependent but just want to make sure I fully understand the 
> > issue.
> > 
> > Jonathan
> > 
> > 
> >   
> >> 
> >> Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> >> ---
> >>  .../devicetree/bindings/iio/st,st-sensors.yaml | 18 
> >> ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >> 
> >> diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml 
> >> b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> >> index a1a958215cdb..335f38e9f78f 100644
> >> --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> >> @@ -126,6 +126,24 @@ properties:
> >>    mount-matrix:
> >>      description: an optional 3x3 mounting rotation matrix.
> >> 
> >> +  st,fullscale-mg:
> >> +    description: |
> >> +      Selects the initial sensor full-scale at probe time, expressed 
> >> in
> >> +      milligauss for magnetometers (or analogous engineering units 
> >> for
> >> +      other sensor families that may grow this property in the 
> >> future).
> >> +      The value must match one of the sensor-specific full-scale 
> >> ranges
> >> +      supported by the chip; if the chip does not support the 
> >> requested
> >> +      range the driver falls back to its built-in default.
> >> +
> >> +      This is intended for boards where the magnetometer chip picks 
> >> up
> >> +      enough DC bias from nearby PCB structures (power planes, 
> >> ferrous
> >> +      shields, etc.) that the kernel's chip-default 
> >> highest-sensitivity
> >> +      range saturates one or more axes to the chip's overflow 
> >> sentinel,
> >> +      and userspace observes that axis as permanently stuck. 
> >> Declaring
> >> +      a wider initial range avoids the saturation at the cost of a
> >> +      slightly coarser quantisation.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +
> >>  allOf:
> >>    - if:
> >>        properties:  
> Hi Jonathan,
> 
> "racing" was loose wording on my part. The chip is not wedged. Once 
> userspace writes a wider range to in_magn_x_scale,
> the next conversion comes back with sensible data and everything works. 
> A UDEV rule on add of the IIO device would, in principle, fix
> the steady-state problem.
> 
> What I was clumsily pointing at is the probe-time window: the IIO 
> consumers in our stack (sensorfw's iio-sensors-adaptor, geomagnetic
> / orientation services) start polling in_magn_x_raw essentially the 
> moment the device node appears, and they treat the saturated
> 0xF000 sentinel as a legitimate sample rather than as overflow. 

Should this perhaps be returning -ERANGE or similar to indicate a failed
read via the return value rather than reading out something
that requires device specific userspace to handle?

Not that this changes the requirements as obviously it still doesn't work
when we want a reading!

> Until 
> the UDEV rule fires and the kernel commits the new range, every
> read returns the stuck sentinel, so orientation/compass features are 
> wrong from boot for some non-trivial number of samples (and on
> slow-boot paths the consumer may have already cached a bogus calibration 
> baseline by the time UDEV catches up).
> 
> So the trade-off as I see it is:
> 
> - UDEV rule: works for steady state, fully out-of-tree, but the 
> per-board configuration ends up split between two places (DTS for
> "this board has an LSM303DLH at i2c@... in this orientation"; UDEV for 
> "and by the way it needs a wider range or its raw readings are
> nonsense"). The wider-range requirement is purely a property of how the 
> magnetometer is mounted on the board, which is what DT is for.

Fair enough to it being board dependent.

> 
> - st,fullscale-mg in DT: keeps all hardware-dependent calibration in one 
> place, available before any IIO consumer can open the device,
> and harmless on boards that don't need it (absent property existing 
> chip-default behaviour, no   DTS in tree changes).
> 
> I'm happy to drop the wording about "racing" in v2 and replace it with a 
> more accurate description of the early-consumer issue if that
> reads better. And of course if you'd rather we ship a UDEV rule 
> downstream instead of adding a binding, I'll yield, but my read is that
> this is hardware-dependent enough to belong in DT.
I'm fine with the DT solution with some of this extra info captured
in the commit message.

Thanks,

Jonathan

> 
> Thanks,
> Herman

