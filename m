Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3B01C5D59;
	Mon, 27 Jul 2026 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785118108; cv=none; b=bP4vgWIzm3z4Mxgd3v//Z9h6OZ9XEGoyiEHB+raHR9hYSw9sXyO59M+oZevornBjPRFeoNUONGUjtV4r9ta7n3brr/KfGvFYXBLEScGGu+C5pR6+td+vMQTZ70pQZu0jOZpQg1HCSv88aC3/hsyWenXx7c6vKayUlshwsDzVWUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785118108; c=relaxed/simple;
	bh=2Gu8xL3bNx/0wAMSsKOukbVPPW73eUM1QgzX4eTDP0c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NGkIFBv4/Xnpn/64gLafee1qzeaYaOZobWo9UXcix95IIpAOU6b2jKX1PBaM/Q9sV/5mj56ZuLO2v1H+dGrHxx32QB2Ssj9kjgZX4OIAMdNIz2mQJPzgDGjtUxyYHWgkauBkibE/ZVd2y1fCoGbhifBgbo9i4u3BHXmijvDwR5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=be81qbCE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="be81qbCE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3781F000E9;
	Mon, 27 Jul 2026 02:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785118107;
	bh=YwEoNGIHBrzw8kveaNvOzD+dDO4m6IbUM9GQUMFRGHk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=be81qbCEhj7BLgeeYkQW47SKeQEFWBkc7PLoGnlTQfOMfg+HQEXbYfLa5NE5QJ9qt
	 0+SMq2K5Ovmm+9Epr9ctNg8cLfwgMRlJWmDDehjnwXIJlMZzefA63QFdcywGzZbnjA
	 BIvZ0l96cpTlxSxQLWwtSKhyse5hAQJ5qIQIhcU3YV4/hAnDc6vz1Bb96PQLYmrxA5
	 YoIntD+4E7aItjGjbAnHCPLQDT2iNeE/lajxx/p2pxOHVL0fWHJCsflX8Duvcps2An
	 0553E17wNEvGVoL32zCGQD6RuiCYDJQhSd7ocvQhTybUPnRm7iPRe8//IMPusbxBO5
	 RPzyljjpiepyQ==
Date: Mon, 27 Jul 2026 03:08:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: ti-ads112c14: add burnout current support
Message-ID: <20260727030822.3766f628@jic23-huawei>
In-Reply-To: <20260724-iio-adc-ti-ads112c14-burnout-v1-0-f0204cecbe3a@baylibre.com>
References: <20260724-iio-adc-ti-ads112c14-burnout-v1-0-f0204cecbe3a@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 15:49:16 -0500
"David Lechner (TI)" <dlechner@baylibre.com> wrote:

> The TI ADS112C14 ADC has a feature to enable a "burnout" current when
> taking a measurement. This can be used to detect open/short circuit
> conditions of a connected sensor. However, enabling this affects the
> accuracy of the reading. So we add a custom "burnoutraw" attribute for
> this. This works like the standard raw attribute to do a direct read
> but does so with the burnout current enabled.
> 
> If this sounds familiar, it is because we discussed this on a similar
> chip recently [1]. And this is why I put the ABI docs in a common ADC
> file rather than one specific to this chip.
> 
> [1]: https://lore.kernel.org/linux-iio/20260622110223.7e854dde@jic23-huawei/
> 
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>

Seems fine to me, but given it is new ABI, I'd like some more eyes on the documentation
patch in particular.

Thanks

Jonathan

> ---
> David Lechner (TI) (2):
>       iio: adc: ti-ads112c14: add burnout current support
>       iio: ABI: add sysfs attribute for _burnoutraw
> 
>  Documentation/ABI/testing/sysfs-bus-iio-adc |   9 ++
>  drivers/iio/adc/ti-ads112c14.c              | 126 ++++++++++++++++++++++++++--
>  2 files changed, 126 insertions(+), 9 deletions(-)
> ---
> base-commit: 0b5e142ced4bcf20532da051934bd694d1bbd470
> change-id: 20260724-iio-adc-ti-ads112c14-burnout-184304669165
> prerequisite-change-id: 20260714-iio-adc-ti-ads112c14-buffered-read-41e5d1ca0dc3:v2
> prerequisite-patch-id: 8723aa599dcf5b836fb81cf1efb6c9096bf60b7a
> prerequisite-patch-id: 12754335ccf210bcdeaa8a5d60b2280618d50993
> prerequisite-change-id: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1580754609:v1
> prerequisite-patch-id: 8723aa599dcf5b836fb81cf1efb6c9096bf60b7a
> prerequisite-patch-id: 12754335ccf210bcdeaa8a5d60b2280618d50993
> prerequisite-patch-id: ed5d4c1628ef60ed542339fe5fb490383ee8074f
> prerequisite-patch-id: b92f5609fcf39e958e78b4dd74c3d323ebb6a161
> 
> Best regards,
> --  
> David Lechner (TI) <dlechner@baylibre.com>
> 

