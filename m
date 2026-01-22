Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5499C37AA8C;
	Thu, 22 Jan 2026 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769109916; cv=none; b=ajcDpPrxsoWcJKlt6uScmt5lz6gfu0lUtgRkpKAr0ChW0c6ViEAS9yrsatEZiz15x6GJwfpV5ESVzqKLPjREkxbUDnAP9DTn6Ugw568U9bZwTdE+uQ+QkQZ9nu3vz/GwQQMuh1AZNvnk62baQOzrt3+3z/Upt28J63UFQt7jhaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769109916; c=relaxed/simple;
	bh=UJu3K3bF88v0FaUNuJcWEqAzwX7bWZHeFfViNYORMJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFaxiF6u4wAYTKHp8W1PAmQ6+Y9sTURL0mEfQQKRhPkmgkz2EvnfRCQYQeriWt4mHCGHICRNviTwMY7Pwn+tIVwxQakBPlUz7/Yp9AhsuIYEeW9ZUTcVBSG97sMwV5lDcf7dlMp6PlnYPYry/mESFl9JD5iUrAHB2Ky69n4b7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DalGajo2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DalGajo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4454DC116D0;
	Thu, 22 Jan 2026 19:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769109915;
	bh=UJu3K3bF88v0FaUNuJcWEqAzwX7bWZHeFfViNYORMJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DalGajo2TIxThMlDYyguXTzvEfVuPWe4O8IHdoXLsbOVmMgSIyKtYXz26kmCpvzR1
	 x7VHlDvRVqGvfJHioDc8qIBs8PAdvJP6R29JGXzwKJMyrE8bk5grSh83Zc6xevTugB
	 Y2EA9PCr03Doknf1mVhRUl3jWoh4DRctFMPuHeiKAj3uC/2z1CpLGd4OH8elFOGmRL
	 ZkDdshViBfPhlwBORHNhw2Bed8B8GJi3oicC4TOlDI8fbK57pDF+2afGxQIRZ39S7Z
	 xBCOd0TJ7fVJrlZHc3JdlI2qty7vrfB1+Ta78TF/3hidWL9q4RdsXFBeHgvbI1mJRj
	 949daoarO5lZw==
Date: Thu, 22 Jan 2026 19:25:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jonath4nns@gmail.com>
Subject: Re: [PATCH v6 0/5] Add support for ADAQ776x-1 ADC Family
Message-ID: <20260122192506.06ca7a4f@jic23-huawei>
In-Reply-To: <cover.1768350772.git.Jonathan.Santos@analog.com>
References: <cover.1768350772.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Jan 2026 06:26:22 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> This adds support for the ADAQ7767-1, ADAQ7768-1 and ADAQ7769-1 devices. 
> 
> The ADAQ7768-1 and ADAQ7769-1 integrate a programmable gain amplifier (PGA)
> with 7 and 8 gain options, respectively. The ADAQ7767-1 and ADAQ7769-1 
> also feature a 3-pin selectable Anti-aliasing filter (AAF) gain.
> 
> ---
> Changes in v6:
> * Use Pattern PER* for all percentage-related macros and include macros 
>   for Per mille and per cent mille units.
> * Refactored ad7768_parse_aaf_gain() to improve cleanliness and readability.
> * Link to v5: https://lore.kernel.org/linux-iio/cover.1765900411.git.Jonathan.Santos@analog.com/T/#t/
> 
> Changes in v5:
> * Added PERCENT macro along with BASIS_POINTS in units.h.
> * Added new patch to allow writing attributes without direct mode claim.
> * Write scale attribute without direct mode claim to avoid deadlock
>   when using GPIOs from the device's own controller.
> * Link to v4: https://lore.kernel.org/linux-iio/cover.1764101647.git.Jonathan.Santos@analog.com/T/#t
> 
> 
> Changes in v4:
> * Removed u64_fract type patch, as it is not used. u32_fract is sufficient
>   for the PGA gain calculations.
> * Added new patch adding BASIS_POINTS macro to units.h.
> * Included pga-gpios property for parts that support PGA gain.
>   Before we were using the internal gpio controller to manage the PGA pins,
>   but still exposing the controller for external use (causing possible conflicts).
> * Addressed other review comments, see individual patches.
> * Link to v3: https://lore.kernel.org/linux-iio/cover.1757001160.git.Jonathan.Santos@analog.com/T/#t
> 
> Changes in v3:
> * Renamed adi,gain-milli to adi,aaf-gain-bp. Now it represents basis points
>   (one hundredth of a percent).
> * ad7768_channel_masks removed along with available_masks element in
>   ad7768_chip_info struct. It does not add anything for single channels,
>   so not needed, at least for now.
> * New patch adding 64-bit fractional number types to math.h.
> * Moved aaf gain parsing to its own function, and now returning after
>   warning to avoid setting a variable when it shouldn't (avoid confusion).
> * ad7768_set_pga_gain(): removed the pgia enable check, relying on the
>   regmap cache.
> * Addressed other review comments, see individual patches.
> 
> Changes in v2:
> * adi,aaf-gain property renamed to adi,gain-milli. Default value added.
> * fixed some commit messages. 
> * Added 'select RATIONAL' to Kconfig.
> * Added lock to protect PGA value access.
> * rewrote AAF gain check and replaced error returns with warnings.
> * Addressed other review comments, see individual patches.
> * Link to v1: https://lore.kernel.org/linux-iio/cover.1754617360.git.Jonathan.Santos@analog.com/T/#t
> 
> Jonathan Santos (5):
>   dt-bindings: iio: adc: ad7768-1: add new supported parts
>   iio: adc: ad7768-1: introduce chip info for future multidevice support
>   units: add conversion macros for percentage related units
>   iio: adc: ad7768-1: refactor ad7768_write_raw()
>   iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family
Applied with this diff to last patch.  Will first push out as testing to
let 0-day take a look.

Shout if the change is a problem.

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 980c079ab41a..dc5be3d14664 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -535,9 +535,10 @@ static void ad7768_fill_scale_tbl(struct iio_dev *dev)
 {
        struct ad7768_state *st = iio_priv(dev);
        const struct iio_scan_type *scan_type;
-       int val, val2, tmp0, tmp1, i;
+       int val, val2, tmp0, i;
        struct u32_fract fract;
        unsigned long n, d;
+       u32 tmp1;
        u64 tmp2;
 
        scan_type = iio_get_current_scan_type(dev, &dev->channels[0]);
@@ -563,7 +564,7 @@ static void ad7768_fill_scale_tbl(struct iio_dev *dev)
                tmp2 = ((u64)val * MICRO) >> val2;
                tmp0 = div_u64_rem(tmp2, NANO, &tmp1);
                st->scale_tbl[i][0] = tmp0; /* Integer part */
-               st->scale_tbl[i][1] = abs(tmp1); /* Fractional part */
+               st->scale_tbl[i][1] = tmp1; /* Fractional part */
        }
 }
 

> 
>  .../bindings/iio/adc/adi,ad7768-1.yaml        |  64 ++-
>  drivers/iio/adc/Kconfig                       |   1 +
>  drivers/iio/adc/ad7768-1.c                    | 423 +++++++++++++++---
>  include/linux/units.h                         |  19 +
>  4 files changed, 453 insertions(+), 54 deletions(-)
> 
> 
> base-commit: e0bc6d7e258486c10bb11e31fd4421c134063b1d

