Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455839DBCC;
	Tue, 11 Aug 2026 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433325; cv=none; b=e+QYeLskLAxd69/vRGYf67P3ifkVI+KzPWWTn3Trqsp1xf6PAoFtfsXB3Qixx0cOEOWWVzlQtafZWFDc8yUEKEfgWZF1LBsNMEE+3RiTHN6v9bJ1pYchgT/3N5cZHmJvOcY2WDZcAXb6t4KyJtmsCzMYtI0+Zh8nIUhWw+U/G5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433325; c=relaxed/simple;
	bh=SOY9a1wo0bJQsX5WIVOlvbGkyDSiK7NoBQ2GPrUMV2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo1R7rM4/mJQVNAut6ruS/TnfwE1O+gaBM4S7vhArc94wVadkLyr0SSV+BtKgHFnyLRQz5ywiuevUb+li/FoFx0pVxCQGeUpz6gtlEMoDWfAy2TyaxbGMBIJ8t8spTri7wXxKJCTCJRKaGsetCMQgybc03S3+N+lQlRxDFgIffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3DNhGcg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3DNhGcg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CF01F000E9;
	Tue, 11 Aug 2026 07:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786433323;
	bh=WK8DW4OyZF2KP3dsG/SNl4e+MuJa7x7OcD+vHr2yOsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d3DNhGcg7U1Im50fII+XFIjjF3q2h+gNC7x2TPgX8fdycTZ4iFZe+xMa2+v3DkGxv
	 zhOVgMeEekwxSio1ACyl3PsxGU6O4cE9MQJFeoQ85o+tYMnlp5/BATbxyyzriT7dnN
	 nY66STYGihX6s7hYd3nz8FYVJvB+sETV04qwwQcPe6c8szvfHSfhrBteVlNVWZdzqi
	 xZiFgLtx/iOJFnTsYwJbcOgXnVdhFd3vqA/knOto0YtZbNwn3gJUFo+4mdgwj9p+Jn
	 ZEd91JL70vvt++nDkEnvgFN2jGC37PzUMA/VTFFmXWjX0wj27Fqg2QzTPb4eLPPSfI
	 U0xqn2KXoGZdw==
Date: Tue, 11 Aug 2026 09:28:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mranostay@gmail.com, ~lkcamp/patches@lists.sr.ht, 
	linux-kernel-mentees@lists.linux.dev, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: proximity: move LIDAR-Lite v2
 out of trivial-devices
Message-ID: <20260811-electronic-russet-ermine-ec2fd2@quoll>
References: <20260810192131.153495-1-rodrigo.gobbi.7@gmail.com>
 <20260810192131.153495-2-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260810192131.153495-2-rodrigo.gobbi.7@gmail.com>

On Mon, Aug 10, 2026 at 04:18:40PM -0300, Rodrigo Gobbi wrote:
> The PulsedLight LIDAR-Lite v2 is currently described as a trivial device,
> but it is not one: besides the I2C interface it exposes a power-enable
> pin and a mode-control pin.
> 
> The mode-control pin can trigger acquisitions and report the measured
> distance through a PWM signal, entirely bypassing I2C. That usage is
> bidirectional and non-cyclic, so it doesn't map onto any existing
> binding for describing pin behaviour, and is intentionally left
> undocumented here. The same pin can, however, also be used as a plain
> status output while I2C remains the active interface, which is
> described through the new interrupts property.
> 
> Move the device to a dedicated binding file and document the
> power-enable, power-supply and interrupt properties that
> trivial-devices.yaml has no way to express.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
>  .../proximity/pulsedlight,lidar-lite-v2.yaml  | 64 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 64 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

