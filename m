Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5537F3B0AD8;
	Wed,  1 Jul 2026 20:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936128; cv=none; b=DHVR2JQrk4+5KHHoUJu2tLXWWZt8Hwc3EKP3Ht8gzKBvcko2NaxQDYDTYjAqqTiCPenjvmk/JFdWq1FXGJnP8tMps+e5vCZ/V+56ya4VN+iwrArjMliFt5UeFx62pud8NOmv1BdDwVBI9+bR0fAAusyTiCR3s5AaqcPDTaWizxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936128; c=relaxed/simple;
	bh=LIerCX0bajA2iEM3D+agDjSHwyT7pLC1SYdZY+cTJMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEwf8vuQH5T+iiOldhdasnQv63db9GVLGjfkPUqeTThoLFMKL09AsNh30YOAxoOB83mbz89fRGConURAtB5dotzs1yqqhlLvQDwxomFA8alHLaMpsU5TpuJ95WlW37mdNodiUvW92g5zMEJ0cS0SjXTroNbipxXls6DpB+7DmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUtw+LYn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUtw+LYn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C651F000E9;
	Wed,  1 Jul 2026 20:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782936127;
	bh=7PZeOdQ+NnWU/S/WQpyhOFjrOBT+d0WRzYVNVG2DGqE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BUtw+LYn126o4FjwmAcFkrq2tL4BzJCQypLpAD8wk6NNfgXQFxtUgtkqvc+sKpuiN
	 ZVyxsb8V8AY6AVV0IJ+YL4qgz2F9xff1YszFKHYBCoYLJvPNJxaDRF5yBvQrRYIQZc
	 KLmTpz7j/eqYyAthqr64eXpnuxARJSiSzLohXCL0LR2wa2A4o8/IThnhP+Pf8Xq/H/
	 7l8DbMoyuK+7DHcjs04NQOTFbSsEvHlmtj2B8wmDzzaEPPpg6+X8TzcZxe8tkhr0nj
	 urfebJ1v2tpLelfZAO/YSY+qj8Stexoe/n6Dw4ScsriRSUkGF868wNKMBJPWdOyeW4
	 4KExDZwC8dqmQ==
Date: Wed, 1 Jul 2026 21:02:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris Hall
 <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] iio: adc: ti-ads112c14: implement gain on
 internal short SYS_MON channel
Message-ID: <20260701210204.068f4aea@jic23-huawei>
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-7-ceb9b0b561cb@baylibre.com>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
	<20260625-iio-adc-ti-ads122c14-v2-7-ceb9b0b561cb@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 16:55:09 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> Implement support for the programmable gain amplifier on the internal
> short SYS_MON channel. This channel is used for calibration, so it is
> useful to be able to set the PGA to the same gain as the external
> channels. The gain setting is implemented via the `_scale` attribute.
> 
> In the future, we may want to support different reference voltages for
> this channel, so the scale_available table is populated during probe
> rather than being a static table.
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
Trivial stuff again.

> ---
> v2 changes:
> * Make some changes to reduce diff in next patch.
> * Add some local variables to reduce line wrap.
> ---
>  drivers/iio/adc/ti-ads112c14.c | 144 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 141 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads112c14.c b/drivers/iio/adc/ti-ads112c14.c
> index c61d47244732..0e775dbc8d50 100644
> --- a/drivers/iio/adc/ti-ads112c14.c
> +++ b/drivers/iio/adc/ti-ads112c14.c
> @@ -124,6 +124,26 @@
>  #define ADS112C14_INT_REF0_mV				1250
>  #define ADS112C14_INT_REF1_mV				2500
>  
> +/* Available gains as tenths (x10) */
> +static const u32 ads112c14_pga_gains_x10[] = {
> +	5, /* 0.5 */
Not sure it is worth commenting all of them!

> +	10, /* 1 */
> +	20, /* 2 */
> +	40, /* 4 */
> +	50, /* 5 */
> +	80, /* 8 */
> +	100, /* 10 */
> +	160, /* 16 */
> +	200, /* 20 */
> +	320, /* 32 */
> +	500, /* 50 */
> +	640, /* 64 */
> +	1000, /* 100 */
> +	1280, /* 128 */
> +	2000, /* 200 */
> +	2560, /* 256 */
> +};
