Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F53C187346;
	Mon, 27 Jul 2026 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117041; cv=none; b=Y49N5nqmBzvR0HEqO8sdLXCUt8vcmgOOZ0rym7gs4TvwSmsCtBfFgIhNf8YRWDwAFaTfBTp3BIsKMZmWEt/yVtUe97QPJLDdoIx+86FDJ1sg5WBinng8yohmjBuUVUFb4hLQtVkDOFTMS9sDrTRvT5R7uvS36QCl8TDOiqse45A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117041; c=relaxed/simple;
	bh=N6J9ILevN9yV3tNpWE6S1GwT1Sy2YygSDWl6/WQf7Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rt+QcJr2N+f5oeV58zd67FZI8Du7I+Ik5f6KS+Zkc6IeTSQ14vdlklS8ewR4KqfKhGeB4gsO2WQAhRy7EVnEvoNlBrQ/2gtPoxLtrB30Nsuk8oJR5yEGgl1Qi95FNzNuvL2QrZQMwhKz0IOtbPJSy30xkkdIhRcBW5FdkJiLNM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQKtuthc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQKtuthc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23AA1F000E9;
	Mon, 27 Jul 2026 01:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785117039;
	bh=Rie3vjA23bz6asaZR0s/blH3eu2M3Lgb1/sOd7Cv9b4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OQKtuthcHGq9IRWWqASATPBWrPBYUpePP9V76q1n4rIcNMdEJJo0lBuypVNpbhHhR
	 m5b4NzCEeDK1XiKXm1aS1svPDcanTR1oXv/YnhqEYsQ4jjVAm2xy17YgD3yV+ud+sW
	 d+/zDMIm1h38gWrnbPYxvE0OHkJHl5w9MAYCOhuj2q0YtydDtj5Y+wAWHlDryO52Yd
	 PLg0QteDdlJOZ3iFJkb2Dms7MWF+YBddy7CM/n744VozGioA4jI/iM7HVGbNTZEqll
	 Pa/uGIwdsFoluGXfhraSNwYYhmQwsMPPqs6yViIO5YHDwqk/EaaqcQRNrt6w0JJBZz
	 2zn04EtZLJ24w==
Date: Mon, 27 Jul 2026 02:50:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] iio: imu: inv_icm42600: add support for icm42630
Message-ID: <20260727025035.7a310e36@jic23-huawei>
In-Reply-To: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
References: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 22:27:04 +0200
Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net> wrote:

> The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
> used in the Fairphone 6. The existing inv_icm42600 driver drives it
> unmodified.

Looks good to me. Given Jean-Baptiste already gave a tag for the
main patch, I'm kust looking for a dt binding reviewer ack once
they get to reviewing this one. 

Thanks,

Jonathan

> 
> v2 restructures the series per the v1 review: the binding documents the
> new compatible with an invensense,icm42631 fallback, and the driver's
> WHOAMI hard check becomes a warning so that a fallback-matched part can
> probe at all (on older kernels via a backport of that one patch). The
> id tables are sorted numerically in a precursor patch and the new
> entries slot into numeric position.
> 
> Both resulting paths were tested on the Fairphone 6 with the fallback
> pair in the devicetree, via backports to its 7.1-based kernel: matched
> as icm42631 through the fallback (patch 2 alone, dedicated entries
> removed), the part warns once, probes, and accelerometer, gyroscope
> and temperature reads work; with the dedicated entries present it
> binds as icm42630 without a warning. The fuller v1 test set (all
> full-scale ranges, several sampling frequencies, watermark-paced FIFO
> reads via INT1) ran with the dedicated compatible and is unchanged by
> this revision.
> 
> Chris Morgan's icm42607 series [1] touches the same binding enum, so
> whichever lands second has a trivial merge conflict. Its conditional
> interrupts requirement covers the ICM-42630 automatically through the
> fallback compatible.
> 
> Changes in v2:
> - new patch 1: sort the device id tables numerically (Jonathan)
> - new patch 2: warn on whoami mismatch instead of failing probe
>   (Conor, Jonathan)
> - patch 3 (v1 patch 1): compatible now documented with the icm42631
>   fallback (Jonathan); commit message rewritten; dropped Jean-Baptiste's
>   Acked-by because of the rework
> - patch 4 (v1 patch 2): match entries placed in numeric position
>   (Jonathan); kept Jean-Baptiste's Acked-by - the only code change is
>   the entry placement; its commit message gains a sentence on the
>   fallback and a more precise note on the tested backport
> 
> [1] https://lore.kernel.org/all/20260722153942.144387-1-macroalpha82@gmail.com/
> 
> v1: https://lore.kernel.org/all/20260720173411.82979-1-jorijnvdgraaf@catcrafts.net/
> 
> Jorijn van der Graaf (4):
>   iio: imu: inv_icm42600: sort device id tables numerically
>   iio: imu: inv_icm42600: warn on whoami mismatch instead of failing
>     probe
>   dt-bindings: iio: imu: icm42600: add icm42630
>   iio: imu: inv_icm42600: add support for icm42630
> 
>  .../bindings/iio/imu/invensense,icm42600.yaml | 20 +++++++++++--------
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  2 ++
>  .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 13 +++++++-----
>  .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   | 18 ++++++++++-------
>  .../iio/imu/inv_icm42600/inv_icm42600_spi.c   | 18 ++++++++++-------
>  5 files changed, 44 insertions(+), 27 deletions(-)
> 
> 
> base-commit: 036d96ceec6d966339aea34d034420991e24cfac

