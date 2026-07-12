Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EFC1C69D;
	Sun, 12 Jul 2026 01:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783819207; cv=none; b=coUmi8UjQE/z5xmFxhgtGCoxHRFcRHMKNPNpZ+wjXuQPmvEeHq3K7O/wr8jtfSUlTtztCE7Nx1LJ+WYn2mfLNKWZ4LRK1Jo3gAhvG4hQasZro/SQuw3o5Q5vBJIY17QNC68V68j6b2vw6RS5xWgGuh+h3RSxScV5Co8/vZ5PVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783819207; c=relaxed/simple;
	bh=jI7xr/IF8H7OLfFOf2r+kmGJa4u+QrGHVvgg7cYznNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+p9Em1ET4eosOHq8ApkE1PCAcQq7lYuERA54zUi1p13BoN5R07zJWtKOIFw6xAeqUNiE1NY/kBLQ21d4RTQ8imLv6GgWig/ep81AgG5tTQZ7wQ6Z3LIrMEOyID3ieWRS0mkfb4qWdDmqdWUyQWWkt1rwoHqRfrr5SNo9JAjlo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alUP4Xd+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alUP4Xd+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7B01F000E9;
	Sun, 12 Jul 2026 01:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783819206;
	bh=E395mBRWb0DBElCZZc/dMkKlrQsk+MtKxEnBzoJPRnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=alUP4Xd+JPJh/neaUXKrtRLxxf8eBp3NPUaqS/ib+QuPLMNvD3F7/CTu+tNvOk32w
	 7bsTQ0YGAegNvpuPTb0wJa6TvR1XecOha6iFmFp83hwUzxn883jH4YunnCh3nVwkHL
	 fidPo0tXMKGFZ7Uc3KjR+hbibpP3ZApNcOh77A2ZaVOLb1jj7Wtwo/vi+YFSLzKf3W
	 2QlUUzeP6jmmivaKAWiFPozPXq23abGNNno0H41MRXfDPJdb3t6efOBKRIng9lRzUw
	 rWa+j1Ha5nmr7Dad+1CM8DHal88cdc1VVY1os9rlsPyUr8MC0Shx77HAeY0KuofVAL
	 RL/4npn8sKcYA==
Date: Sun, 12 Jul 2026 02:19:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 16/17] iio: ABI: add docs for ad9910 sysfs and
 debugfs entries
Message-ID: <20260712021959.45e07650@jic23-huawei>
In-Reply-To: <20260707-ad9910-iio-driver-v7-16-a4ec30f63700@analog.com>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
	<20260707-ad9910-iio-driver-v7-16-a4ec30f63700@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 07 Jul 2026 15:04:37 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org=
> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> Add custom ABI documentation files for the DDS AD9910 with sysfs and
> debugfs entries. The sysfs ones control parameters from the Digital Ramp
> Generator and OSK engine. The debugfs attributes are read-only and
> evalutate into source channel labels for each DDS core parameter.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Sashiko called out on earlier patch adding IIO_FREQUENCY that it might
need ABI docs in the main ABI file.   Now we only add that when a driver
first uses, it but I do see some standard stuff being added in patch 11
for offset and scale, so I'd expect to see a patch to
sysfs-bus-iio

Key being to define the units. That may mean adding a _raw entry even
though you don't actually use it in that patch.

> ---
>  Documentation/ABI/testing/debugfs-iio-ad9910       | 60 ++++++++++++++++=
++++++
>  .../ABI/testing/sysfs-bus-iio-frequency-ad9910     | 31 +++++++++++
>  MAINTAINERS                                        |  2 +
>  3 files changed, 93 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/debugfs-iio-ad9910 b/Documentation=
/ABI/testing/debugfs-iio-ad9910
> new file mode 100644
> index 000000000000..b4a125bc1007
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-iio-ad9910
> @@ -0,0 +1,60 @@
> +What:		/sys/kernel/debug/iio/iio:deviceX/frequency_source
> +KernelVersion:	7.3
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read-only. Reports the channel label that corresponds to which of the

Maybe reference label via iio:deviceX/*_label or something like that to
make the point it is in the related per channel label sysfs file.


> +		on-chip signal generators is currently driving the output frequency.
> +
> +		Resolution order (first match wins):
> +

I wonder if this is correct place to provide this info.
Sooner or later I'd expect the attribute to be used in another driver and
annoyingly we can only document them in one place or the docs build goes
wrong.  So maybe just he bit above should be here and this priority stuff
belongs in the per driver main doc?  (I'm wondering if an earlier me
told you to put it here - sorry if so!)

> +		- ``ram`` =E2=80=94 RAM playback is enabled and its destination is
> +		  frequency, phase (polar), amplitude, or polar.
> +		- ``drg_frequency`` =E2=80=94 the Digital Ramp Generator is enabled
> +		  and its destination is frequency.
> +		- ``parallel_frequency`` =E2=80=94 the parallel data port is enabled
> +		  and the frequency scan element is active.
> +		- ``profileN`` (N =3D 0..7) =E2=80=94 none of the above modulation
> +		  sources are driving frequency, so the currently selected
> +		  single-tone profile register is in effect.
> +
