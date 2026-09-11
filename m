Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A8371D11;
	Fri, 11 Sep 2026 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116007; cv=none; b=FLkfwYNlDjpss/6+zqP7thwHlyRLR8UnL1WH2V94TItCI8u4QoK3LCLgfW6ATDqOICGUaoqedDniX4FhBSLoWUtbBaTMuzVWpvy1476f/cI8jov6+iukVXYNIBxKcyBhD+F0UMVarOU6pKIA34YTathQ+vOvpZpqYiC/Z0wg4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116007; c=relaxed/simple;
	bh=Asw33f3GumBAq6FxPBT4oBU8UdfCUgzjqdFqoIg+Zbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLEZnUZYjUGtauj6jAQTaIdhzddKB2nSufBTb6Fh7i53Rtj5zcvZD1Et8+/xTuwn7nd6w6qxrZTNQOVTmF5JtDtIc6FUdyp0buurrmUk56SHnmko7g3Tu4tajsvZgqWoDX1wfjuqAiLWNOG9nONY3tRty1VsYdK91aSrLhYY1MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3/kHqhR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3/kHqhR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB251F000FF;
	Fri, 11 Sep 2026 08:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789116004;
	bh=PDOYUZuwtgUUJzgYfKVjJWmdacaawYw2JsVspJdfnrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i3/kHqhR53owCXIE+AZPwhEvBlH72W/6CygfGPnC/8NOEqwPJAJCXNNt2M7GOG6a5
	 VyjlqVXng/IzsMQO6rweVR0aZd8fRDebl7MANzX4aRt56n10DIn9WeBiuAY1fF6zBi
	 oGM1VCd+pH9l7kdET+iSYXcsiDOhH6LdgtjP/hTknIh/tYbQtcoHQt/8xMNqD8W5/z
	 E/AHM7KdIHAV5NO9WpRFBPijXYpL81NRaP3bdqE8TiiNLJSaiX1UwW0CI0EQp6y4zO
	 Ijy1YO6eApSc8StiN6RIHx5HZqjBitUTmpoiSWx990GZoi0Mdzrd4StmADKXUMPtte
	 vg65tBS3CIsHA==
Date: Fri, 11 Sep 2026 10:40:00 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Shi Hao <i.shihao.999@gmail.com>, 
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: add as7343
Message-ID: <20260911-judicious-pearl-millipede-ee949a@quoll>
References: <20260910063813.56419-1-marcus.yu.56@gmail.com>
 <20260910063813.56419-2-marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910063813.56419-2-marcus.yu.56@gmail.com>

On Wed, Sep 09, 2026 at 11:38:12PM -0700, Chang Yu wrote:
> Add binding for AMS AS7343 which is a 14-channel multi-spectral sensor
> with i2c address of 0x39.
> 
> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
> Changes in v3:
>  - Add missing include for gpio.
>  - Expand GPIO descrption to include hardware synchronization.
>  - Use led-max-microamp instead of led-current-microamp for the LDR pin.
> 
> Changes in v2:
>  - Add the LDR, the interrupt pin, and the GPIO pin to the bindings.
>  - Fix node name and unit address mismatch.
>  - Include MAINTAINERS changes.
> 

You need to address Sashiko review.

Best regards,
Krzysztof

