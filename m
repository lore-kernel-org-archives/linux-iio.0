Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70837371D1F;
	Sun, 16 Aug 2026 20:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786910662; cv=none; b=gcGiW3rhgbgkXWQElQgMtLO891lcwch41MVFVWl9CEKrdekf9CEySAw+p9QcsT/WdBnYGC9QJx/ITSa6+/IUleGkxxQ6hZzmFjPlRNKapAQQBZTqud7o64o5dWebKQJP57gM+OibvTO77bHXG/25+1UEHEdKeXJOfERI4FywXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786910662; c=relaxed/simple;
	bh=PG7cebm9cQkxk40ZX9sHX3YuAagFzKNjegdXGevJGHM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FlyifdHzQlg9kowKkqg1pH3+Teov4QWrfnUGGKFYtaQnbhGcSIY7L9kIs2bEcOiMl2tuIhAWOqrWzBtJhiDxo8hCEwhgWfP8CD4cka+uJWSK5M4su5L0WHPApH4WysD21PkrVGH4qYrLyPePnCYETRTBY4SStsSeppVgpS8nA6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipvXQ6IQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipvXQ6IQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534CD1F000E9;
	Sun, 16 Aug 2026 20:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786910660;
	bh=0Q+In85KJcx2q9yxNMIL3sT8YnPE2GKRoiwmStkQcPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ipvXQ6IQh+JW23GdsFHHX3LneRHRtIEFO8Xs3ByKgJjFgAk+zUKdMrzR5AcBgDnUw
	 sRKblBLwtcz06ZWwId5nsuWd9vNMF8oykvugaC/EWarfj7qxxecPfA/hu6oxvFWQtU
	 IaMcNXTAfOCRCQieSJUpgMXhx3RWnnCVGOk0hhX+V5OJz91lIWbpM30xo/MeeOYjFq
	 XOTBHFdSnUhD+IECzNjiME2rDJVnGuySKQj9G3aA/xFqB35ewvoL13ycwSnwHhijtH
	 HZbv3UDs7LD8CQ0gDxw5rShtC0bY2qbnHmACrJ0SgC2rV4HhtS4QvuicMwtRFXvHtc
	 GTNdcJfz3utfA==
Date: Sun, 16 Aug 2026 21:04:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Alim
 Akhtar <alim.akhtar@samsung.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Add Sharp GP2AP070S Proximity Driver and enable
 it in Galaxy J6 (j6lte)
Message-ID: <20260816210414.6ce52946@jic23-huawei>
In-Reply-To: <20260807-gp2ap070s-v4-0-74f6a67b6272@disroot.org>
References: <20260807-gp2ap070s-v4-0-74f6a67b6272@disroot.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 07 Aug 2026 01:18:40 +0530
Kaustabh Chakraborty <kauschluss@disroot.org> wrote:

> Sharp GP2AP070S is a promixity sensor (NOT an ambient light sensor) in
> mobile devices. This sensor chip is found in mobile devices, including
> (but perhaps not limited to) Samsung Galaxy J6 (codename: j6lte).
> 
> To the best of my knowledge, there's no public documentation available
> for this device. [1] is a downstream kernel implementation, which has
> been the single source for developing this driver. Some bits have also
> been stolen from existing GP2AP* drivers available in iio/light.
> 
> The last patch in this series touches the device tree sources to add the
> light sensor node in j6lte. This needs to be accepted into next only
> when the former patches are in next.
> 
> [1] https://github.com/Exynos7870/android_kernel_samsung_universal7870/blob/lineage-16.0/drivers/sensors/gp2ap070s.c
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
Make sure to take a look at sashiko feedback.
https://sashiko.dev/#/patchset/20260807-gp2ap070s-v4-0-74f6a67b6272%40disroot.org

regcache flat is very rarely the write option.  maple is fine for even small
sets of registers and avoids some pitfalls (I'm not sure the exact issue
sashiko is calling out is real - I haven't checked)

The timestamp skid thing isn't important (though it is correct) so
I'd ignore that one. However it's point that you might as well
do the work in a non threaded interrupt is valid given the simplicity.


Calling regmap_reinit_cache() seems illogical even if not wrong
on a teardown that is about to wipe out the regmap.

I didn't look at the dtsi comments.



> ---
> Changes in v4:
> - Clarify non-mandatory vled-supply commit message (Krzysztof Kozlowski)
> - Simplify driver probe return paths (David Lechner)
> - Rephrase fsleep() usage to use unit macros (David Lechner)
> - Use regmap_reinit_cache() instead of regcache_mark_dirty() (David Lechner)
> - Use regmap_assign_bits() instead on branch on regmap_{set,clear}_bits()
>   (David Lechner)
> - Drop redundant explicit cast to u16 (David Lechner)
> - Replace (1 << 16) with macrofied BIT(16) (David Lechner)
> - Add max_register to regmap config (David Lechner)
> - Add upper byte register for proximity distance volatile registers (Sashiko)
> - Return 0 instead of IIO_VAL_INT in iio config write calls (Sashiko)
> - Add REGCACHE_FLAT to regmap (Sashiko)
> - Link to v3: https://patch.msgid.link/20260731-gp2ap070s-v3-0-d1f5cecf9fe7@disroot.org
> 
> Changes in v3:
> - Revoke stale patches sent erroneously, v2 changelog applies
> - Link to v2: https://patch.msgid.link/20260731-gp2ap070s-v2-0-1bdfee07d5ea@disroot.org
> 
> Changes in v2:
> - Reshuffle and add missing header inclusions (Joshua Crofts)
> - Add missing regulators in driver and dt-schema
>   (Joshua Crofts, Jonathan Cameron)
> - Rename and rearrange register addresses, masks and values (Jonathan Cameron)
> - Use regmap_get_device() for carrying dev pointer (Jonathan Cameron)
> - Use FIELD_GET() instead of !! (Jonathan Cameron)
> - Drop unused i2c_set_clientdata() (Jonathan Cameron)
> - Use fsleep() instead of usleep_range() (Jonathan Cameron)
> - Check if proximity-near-level is available before reading its value
>   (Jonathan Cameron)
> - Drop redundant dev_err_probe() from devm_request_threaded_irq()
>   (Joshua Crofts)
> - Use mutex guards for guarding concurrent read/write calls (Sashiko)
> - Add reset chip action on removal (Sashiko)
> - Ensure input value in iio_write_event_value() is 16-bit (Sashiko)
> - Use regmap_bulk_*() instead of regmap_raw_*() (Jonathan Cameron)
> - Hint volatile registers for regmap (Jonathan Cameron)
> - Link to v1: https://patch.msgid.link/20260723-gp2ap070s-v1-0-b8ca3a4c10dd@disroot.org
> 
> ---
> Kaustabh Chakraborty (3):
>       dt-bindings: iio: proximity: add Sharp GP2AP070S proximity sensor
>       iio: proximity: add driver for Sharp GP2AP070S proximity sensor
>       arm64: dts: exynos7870-j6lte: add Sharp GP2AP070S proximity sensor
> 
>  .../bindings/iio/proximity/sharp,gp2ap070s.yaml    |  60 +++
>  arch/arm64/boot/dts/exynos/exynos7870-j6lte.dts    |  55 ++-
>  drivers/iio/proximity/Kconfig                      |  11 +
>  drivers/iio/proximity/Makefile                     |   1 +
>  drivers/iio/proximity/gp2ap070s.c                  | 491 +++++++++++++++++++++
>  5 files changed, 616 insertions(+), 2 deletions(-)
> ---
> base-commit: 290aaf24a551d5a0dce037e3fab30820f9113a10
> change-id: 20260723-gp2ap070s-f7e0120970a5
> 
> Best regards,
> --  
> Kaustabh Chakraborty <kauschluss@disroot.org>
> 

