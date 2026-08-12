Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126B242D72;
	Wed, 12 Aug 2026 04:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507284; cv=none; b=KJTi8QR1uljl+6CHJRlhSIeb9/U773Q3aGUHi0QJdr0y295NRn3wImox9TP0PNaqk7zcIiOMpMaVlMJQ90Ln2gB/ej1jseHSO2cVyi1kBq1cqilMyPNE1fwSBRfW0weC+i8WI1nmaUmWKP+kPgKeSjzQRjiKZvpadioOsfaM5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507284; c=relaxed/simple;
	bh=gyFHQ7RkqpLO3uoC/RHuLEvHuORuJUbi6EUFqmIfMRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nv3onr1yE6B7pX4AW7Hh2n3X5+Ny8SqlORcwJ9f6B+0D9Ww6mD7dV5d1eZaER7gDEMJXYvgbBqko++8vyyccmB8emNo+YBSHHrqmvVyVYqmw7h9bwM36FzfUMrwV1EdC2LHyPA0Up2xYX/gUI4z5YcC41rbGMDM2kC81AaO6sP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYXhD39D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYXhD39D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431A01F000E9;
	Wed, 12 Aug 2026 04:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786507282;
	bh=8loUbOgpdbZAD5QuidLnlgQtjCYEDMJ2eIcTOC291q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FYXhD39DO9ccZ9/KtRHKF1dy6v/faXWj21beE7XTaDr7JbddRF0iWnqCkC8OKYWUc
	 k+ZEmzOwfJh1PvCIxCu9B7iIMQ3NlwTCfavvvSVK41StIb47wzljj0ojPq+TnB80fK
	 l8QMxw34Jlgl/1RVzFI1jaOTBA7EI/bi06rdD+MzB+I+0rLu7kdHwGcT0B/P1RsooE
	 aeFJ82n30yRxoMNgDH99rJJd4BG2MzKFdT2OITMKrs75lpiLt2SEyG376cSSvcvHrA
	 IMqWjQ/ijdrEkQ0iub2E6Qt3WSoFXqhlqVSaAFpI58gCfBkgFt/mNSvGsOm4OZa4vb
	 Lhxh2yfsEti0Q==
Date: Wed, 12 Aug 2026 05:01:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <julianbraha@gmail.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v9 6/6] iio: ABI: Encourage differential voltage ABI
 usage
Message-ID: <20260812050051.4313cd91@jic23-huawei>
In-Reply-To: <959734dd1111f76c5928515b82dd17f3a9dff5c8.1785186980.git.marcelo.schmitt@analog.com>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
	<959734dd1111f76c5928515b82dd17f3a9dff5c8.1785186980.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 18:32:18 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> So far, parts that could only do differential voltage measurements were
> only required to have a consistent labeling of their channels by complying
> either to voltageY or to voltageY-voltageZ ABI. Over time, code maintainers
> came to the conclusion that the voltageY-voltageZ ABI is better suited for
> differential-only chips as it provides a simple indication to users that
> the channels measure the difference of two inputs.
> 
> Adjust the ABI documentation to recommend using the voltageY-voltageZ ABI
> for chips that do only differential voltage measurements.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo

Whilst looking at another series, I noticed we did something different
again in the devicetree bindings for those devices that have
restrictive muxes that means the positive and negative lines
always change together.  For those we let

diff-channels = <1 1> 
which tends to map to

in_voltageX-voltageX_raw

I'm not sure if we want to explicitly call that out as an option.
There is nothing in your new text saying we can't do that.

Worth also noting there are short circuit parts where you
really do connect both ends of the differential ADC to the
same input pin. I think it can be useful for testing / calibration?

Jonathan


> ---
> No changes in v9.
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5cc2e82c4997..7446e07b9ab2 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -162,10 +162,11 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled) differential voltage measurement equivalent to
>  		channel Y - channel Z where these channel numbers apply to the
> -		physically equivalent inputs when non differential readings are
> -		separately available. In differential only parts, then all that
> -		is required is a consistent labeling.  Units after application
> -		of scale and offset are millivolts.
> +		physically equivalent inputs when non-differential readings are
> +		separately available. Even though differential-only parts had
> +		been merely required to have consistent channel labeling, this
> +		ABI is preferred over the non-differential one for those chips.
> +		Units after application of scale and offset are millivolts.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_rms_raw
>  KernelVersion:	6.18

