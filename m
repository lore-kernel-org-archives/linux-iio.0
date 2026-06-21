Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11869235BE2;
	Sun, 21 Jun 2026 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782053417; cv=none; b=XXgkQ6fO0A/5ZiA4rAUmWycHQkWQiVXEaB1R7On+MOLZQLC3aElo3k4Nt5Q2c/dp/u6HB9LsFJx82zNGo8SBcom1zGJa0Y35mBzPJxcdWr7/3BIi77RC19ORKQLcYhPUpms73qijMDLIWKVDZWVSNC/autTC7nv4WgWsRtkc1hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782053417; c=relaxed/simple;
	bh=V+TKz5UPqPOxUy+9RTc5fkUkO2eWpLHiXa+wCZrsSZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1NRoqqvJtJQGqxv+LT8DIoGlzfyXtOlmsxLsYNYqIMU4U7ucET5Gkw50/H18HQAT7BL4Wc5fLDjcQCV3u+Adxou2Hei4yG73m1NlKCTI5iRcwITj4Lj7Sw5uFwexbjOaLb0rggGSILR4Pw8s0/jIPpCrvggaap7I/RLzRkBXtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJJeDQTm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJJeDQTm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD241F000E9;
	Sun, 21 Jun 2026 14:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782053415;
	bh=qCNQLBaqS0M478oZzNzgqhvxe361mP/Hou6I99gUgew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TJJeDQTmoSGG9dnnHZbJuNQNQH8/KL4I2spXsuZVSbZqu/NcHOBrnhS2lqBrmF5CI
	 yA9poWw9yNdSeNPgP4Bye+rS6bdhtFa9o6KtIAgSlHK808GlOOoynZU341/MEz/bFy
	 CTqTLAGJ6EUZZyPtZ88bBp2Ljfye5EhkqlSHbFttwofRMVbJd05UVv9CL7x/RktvUw
	 8SY1h4O4phSYdj86W/tNsHzx4Pui3yJ+hrGN+8ET42zjHcGPT4U3fD2kBKPZTZVI0M
	 Zzj8UbrflDdeu5SKtRRYjWCtVqRn5ayWZ89+JQubcBC9B0nDUb6E4jrwQh3V5ndqQI
	 SXyePXWBQrQRw==
Date: Sun, 21 Jun 2026 15:50:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Maxwell Doose <m32285159@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v6 0/8] iio: light: opt3001: driver cleanup
Message-ID: <20260621155006.65c98a29@jic23-huawei>
In-Reply-To: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
References: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 14 Jun 2026 15:19:02 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> This series deals with cleaning up the TI OPT3001 sensor driver,
> moving it to more modern kernel practices and improving the code style.
>=20
> While reviewing, Jonathan Cameron (and eventually Sashiko) found a race
> condition where userspace could start interacting with the device
> before the hardware IRQ was set up.
>=20
> Changes include:
> - moving the driver to use devm_* functions
> - IWYU cleanups
> - removal of unnecessary macros and comments
> - using dev_err_probe() in probe and probe path functions
> - checkpatch.pl warning cleanups
> - fixing a race condition found in opt3001_probe() function
>=20
Series applied to the testing branch of iio.git. I'll be rebasing
that on rc1 once it is available

Thanks,

Jonathan

> ---
> Changes in v6:
> - Pull review tags
> - PATCH 2: reduce code churn
> - Reorder patches to reduce churn
> - Rebase on updated testing branch
> - Link to v5: https://lore.kernel.org/r/20260603-opt3001-cleanup-v5-0-3ef=
7b926d555@gmail.com
>=20
> Changes in v5:
> - PATCH 7: remove dead code oneliner
> - Pull new review trailers
> - Link to v4: https://lore.kernel.org/r/20260525-opt3001-cleanup-v4-0-65b=
36a174f78@gmail.com/
>=20
> Changes in v4:
> - Fix bad merge
> - Edit commit messages
> - PATCH 1: add free_irq on iio_device_register error
> - PATCH 8: change comments
> - Link to v3: https://lore.kernel.org/r/20260521-opt3001-cleanup-v3-0-820=
169dec8c3@gmail.com
>=20
> Changes in v3:
> - PATCH 1: fix build error
> - PATCH 2: remove struct device member from struct opt3001
> - PATCH 6: edit return statements
> - Pull additional trailers from previous version's reviews
> - Edit commit messages
> - Link to v2: https://lore.kernel.org/r/20260512-opt3001-cleanup-v2-0-801=
8cf3a8a0a@gmail.com
>=20
> Changes in v2:
> - PATCH 1: added patch that fixes race condition
> - PATCH 3: remove wrong usage of GENMASK()
> - PATCH 4: add patch that moves driver to use local structs
> - PATCH 5: add patch that ensures correct parenthesis alignment
> - PATCH 6: change int to unsigned int
> - PATCH 7: moved opt3001_read_id() function to use dev_err_probe()
> - PATCH 9: removed unnecessary dev_err_probe() calls, reordering
> - PATCH 10: added patch that adds a comment to mutex declaration
> - Link to v1: https://lore.kernel.org/r/20260511-opt3001-cleanup-v1-0-f78=
79dc3455c@gmail.com
>=20
> ---
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
>=20
> ---
> Joshua Crofts (8):
>       iio: light: opt3001: move device registration to end of probe()
>       iio: light: opt3001: use local struct device and i2c_client variabl=
es
>       iio: light: opt3001: prefer dev_err_probe()
>       iio: light: opt3001: ensure correct parenthesis alignment
>       iio: light: opt3001: localize for loop iterator
>       iio: light: opt3001: move driver to guard(mutex)() use
>       iio: light: opt3001: switch driver to managed resources
>       iio: light: opt3001: add comment to mutex
>=20
>  drivers/iio/light/opt3001.c | 381 +++++++++++++++++++++-----------------=
------
>  1 file changed, 181 insertions(+), 200 deletions(-)
> ---
> base-commit: 5eff1cd0d0156240c0839921b537599ae77a2ce2
> change-id: 20260603-opt3001-cleanup-149be05f699b
>=20
> Best regards,

