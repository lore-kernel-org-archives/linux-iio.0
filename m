Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420AD2D73B6;
	Mon, 31 Aug 2026 01:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788139675; cv=none; b=BmAvur2u3QoUKkkOhg+3q87ilJzXDcQAYT64iWBqgdlxx9iAfrpq8I8I027deb/CNkU4FgvDUMXGhhcJl6N7aDSovOvSoUO2L+8qRwxZjnolmIMfw/0bvG0kSGhL1lVvZC8iKkSUjkbF93j6lCCJlXeHIHEnMgkdJutetD6I7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788139675; c=relaxed/simple;
	bh=wpVhZ9dfQc6zN+U+o3HTprq9GFbXabEfjOSo9wdLW7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTZbkt6zQ4Fb2PQI2e2Qzr3HmNMocPweyXxrpMJYNjo7VAVpD5zdxf6pFFMFmBAeOmGZG7t+V538qV/I20nH8f17cQiKnB4cHHAEcL963QY6lgE26XeS1Zqg9iGwC/CPcaTJNA6GJQn5X06ycBoszkfS1JwnBxfTK4k/Z1/MpdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enVYugWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enVYugWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1831A1F000E9;
	Mon, 31 Aug 2026 01:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788139673;
	bh=CsMF/MwrXn5D+z4CCMhvyxIpj7dLU68Gxw0tmBoqPjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=enVYugWQlH+lv8TPvhH/LIHVCuLVyzhYCrJhW+bQiorUX/qfdA2j4Zv1aRDnKOvIn
	 42tgYzGe/jyub+iczkOJOEoQbqadqyC21EnE8isVg5J0ZLJjJxEO94tbpVhsof0L43
	 YleWvshJW2mscntBaFV4GF11I0A4xAvvhVhAhOIQ1sCWUL5M2TraQ5j+XIOAhVQ5RW
	 H9HaMTsoXrBZfSitROi3Zs/i410j+XRZ2JUjPVKL418sfltmbXNaOo025ccVwnF1zH
	 J/50++i4CHyol0vZ5XU+m0EyA/1Xy7JjrKfqOxQMgYETxRPwG/CfMol49nYor9HM83
	 zUS+b7d4t/P4Q==
Date: Mon, 31 Aug 2026 02:27:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH v2 0/4] inv_icm42600 driver enhancements
Message-ID: <20260831022748.5b02e7b3@jic23-huawei>
In-Reply-To: <20260824-inv-icm42600-enhacements-v2-0-0040837fde12@tdk.com>
References: <20260824-inv-icm42600-enhacements-v2-0-0040837fde12@tdk.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Aug 2026 14:30:06 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com=
@kernel.org> wrote:

> This series add enhancements patches to inv_icm42600 driver.
>=20
> It includes:
> 1. Move of MEMS stabilization sleep before FIFO configuration to avoid
>    pushing incorrect data.
> 2. Use a fixed FIFO frame of 16 bits to avoid a bug of dynamic FIFO
>    configuration changed triggered by the sleep move.
> 3. Simplify watermark computation using gcd.
> 4. Enhance support of high frequency streaming by avoiding read of FIFO
>    count for watermark interrupt.
>=20
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Whilst sashiko did have quite a lot to say I 'think' they are all fine.
However, please do take a look and if you disagree then shout.

https://sashiko.dev/#/patchset/20260824-inv-icm42600-enhacements-v2-0-00408=
37fde12%40tdk.com

It may well be there are things in there that should be patches on top anyw=
ay.
I think all but 1 were things it even thought were preexisting issues.

Anyhow applied to the testing branch of iio.git which i just rebased
on rc1.

Thanks,

Jonathan


> ---
> Changes in v2:
> - Add commentaries for easing understanding of changes.
> - Reword commit messages with better explanations.
> - Link to v1: https://patch.msgid.link/20260820-inv-icm42600-enhacements-=
v1-0-075a881db557@tdk.com
>=20
> To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> ---
> Jean-Baptiste Maneyrol (4):
>       iio: imu: inv_icm42600: sleep before enabling FIFO data
>       iio: imu: inv_icm42600: use 2 sensors fixed packet size of 16 bytes
>       iio: imu: inv_icm42600: simplify watermark computation by using GCD
>       iio: imu: inv_icm42600: do not read FIFO count for watermark it
>=20
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h        |   4 +-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c  |  16 ++-
>  drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c | 112 +++++++++------=
------
>  drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c   |  16 ++-
>  4 files changed, 73 insertions(+), 75 deletions(-)
> ---
> base-commit: 53c022f51fbe540fffee2121ce9ed3e15266c9a4
> change-id: 20260709-inv-icm42600-enhacements-1e0e18e6f868
>=20
> Best regards,
> -- =20
> Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
>=20
>=20

