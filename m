Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF121A681C
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789952883; cv=none; b=iKBxMWVJjttLdsMhVIebQbTYvtq4FyddrfdByXOFmyZerFlOkXENl1CEu7MAaM5UmP9iqlHXhFdz8tn6sHoW3Oh7vm59XDOwKtippd8gJZFJvPY5rlKk1mdmNGDGKxm2dTJ8WASw2id1aetP/RZd+8EJ+CHHI2dorHMxzy8NvfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789952883; c=relaxed/simple;
	bh=Vi6/hOsj3a64qELxEcXYaB2B1elAyu5So769mwqydhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7zF6+10ZWLLNyhnIRfoT7gRZc9/MSg4DCUvByyqN/cg7ZBUgm9aLg67D1TAW5wOYEgkNZtEiCSiBEZuIV3q+J/9u6s7VdBgzqVEM3ecjledz2DPEA3znyyro+jRp2c6snF3cvHpG9qRoCf3EMhMLEAeC2BxnqOLGbcBWYo0NbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7HzCba3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7HzCba3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C994C1F00893;
	Mon, 21 Sep 2026 01:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789952882;
	bh=FDdpuHwv4HLpZwmegaHiMnloY4paSrMwgJe4vSQllEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L7HzCba30UsdZtN5EDkflHCiSHiswIsqBYVRkOZBV7p6iQ4aWfbQjz+AkvauXQu+b
	 JEOuPOVMt8SzLQJXmO/Zjts6ZkSwOxTaeLnA6hk7FaqHfjLdz2kbEbOIhRn7er+uB/
	 zea1Doex01rFyT3p+WHV6GV0dAmqaqX53z12e0by6K5UiDpW8+xgBujhahMehBaI6X
	 KcHhHc/UuTwTu1NjWnNJ6Dgy/MwlX9py00sab0bILJTXwEb4E7U+e9yTtlURjJ5csF
	 pmUvNAz8ywbCZdGBKPAmLSoL2tk7QX8qm8ekF3QmvmowhMathMzsmzy9XqlKKKCU/i
	 zf7m3dFXx+ccA==
Date: Mon, 21 Sep 2026 02:07:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 0/7] iio: accel: merge adis16203 into mainline
 adis16201 and remove from staging
Message-ID: <20260921020759.4aad9a31@jic23-hlaptop>
In-Reply-To: <20260916055547.15206-1-shehryar.amd@gmail.com>
References: <20260916055547.15206-1-shehryar.amd@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 10:55:30 +0500
Shehryar Ahmad <shehryar.amd@gmail.com> wrote:

> This v3 series addresses review feedback on the previous attempt to move
> ADIS16203 from staging into the mainline ADIS16201 driver [1].
> 
> Key changes from v2:
> - Fixed channel order for buffer mode in precursor patch (patch 1)
> - Updated matching tables to modern conventions
> - Moved adis_data into chip_info
> - Added separate adis16203_data instance and dropped runtime copy in
>   probe
> - Fixed Kconfig help text format 
> 
> Patches 6 and 7 carry Reviewed-by tags from prior review.
> 
> [1] https://lore.kernel.org/all/20260913085307.13846-1-shehryar.amd@gmail.com/

Cover letter should have the same to and cc list as the patches.
Anyhow, hopefully that didn't really mean anyone missed much.

Series applied to the testing branch of iio.git. That will get
pushed out for linux-next to pick up once the bots have had a little
time to poke at it.

Thanks,

Jonathan

> 
> Shehryar Ahmad (7):
>   iio: accel: adis16201: fix channel order for buffer mode
>   iio: accel: adis16201: add SPI device ID table
>   iio: accel: adis16201: add OF device ID table
>   iio: accel: adis16201: prepare driver to support additional parts
>   iio: accel: adis16201: add ADIS16203 support
>   staging: iio: accel: remove adis16203, merged into mainline adis16201
>     driver
>   dt-bindings: iio: accel: adi,adis16201: add adis16203 compatible
> 
>  .../bindings/iio/accel/adi,adis16201.yaml     |   6 +-
>  drivers/iio/accel/Kconfig                     |   8 +-
>  drivers/iio/accel/adis16201.c                 | 133 ++++++--
>  drivers/staging/iio/Kconfig                   |   1 -
>  drivers/staging/iio/Makefile                  |   1 -
>  drivers/staging/iio/accel/Kconfig             |  19 --
>  drivers/staging/iio/accel/Makefile            |   6 -
>  drivers/staging/iio/accel/adis16203.c         | 315 ------------------
>  8 files changed, 117 insertions(+), 372 deletions(-)
>  delete mode 100644 drivers/staging/iio/accel/Kconfig
>  delete mode 100644 drivers/staging/iio/accel/Makefile
>  delete mode 100644 drivers/staging/iio/accel/adis16203.c
> 

