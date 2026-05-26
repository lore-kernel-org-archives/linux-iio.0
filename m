Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163138BF7A;
	Tue, 26 May 2026 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813386; cv=none; b=meb9KD6LmrIbXB0+pqjRa3Eh9qojjrwfLDaZHG7XDHcXx9y5i8++akCJQLhmPSQH+v5BAi41BEwyv8NzFNymu4X0PxIvna3LXLu3VZ5Ye+yrHBtL5SRuBW0rPqPa9LJODzkbnq+pK1f0V96wajmIrgEu0iCks0CATTLHSPh5Qh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813386; c=relaxed/simple;
	bh=r4qRP6K3+UCUr75hzk8CSd7lkPf7Z40XNCVfz3lriPk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2VlOccBGghcHvFDhmJ1FyGm261QlHjqJBPxDvgUQRMlJRmPT+RowzJG/DCcMZShtfQIzctT1XdE43Kjt01kt+Q/atIe8wFLiWRNcHr6WRtU9bMiQGYpRrdXQ0bH/D/LgwQt3xmrcmzWT/ZhjtMG5q5WaTdrP3u8zP+ao8ph8To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kduvgOTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kduvgOTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56DB31F000E9;
	Tue, 26 May 2026 16:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779813384;
	bh=SiS9sZShvZL2jB5UhDOwEZ9rL2MhJ41Rs4gaZHmgsrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kduvgOTaPkaxZK2Cz/hcfuKp9SIMdAMhm/L+5KHC5O2d0CziS3S+8Pp4PaRAY2etI
	 LgnFMsOMYSPXF7KUnGtVea9PE8+Kw3e/UvxsOwsUczsalSFcz0NY5KKSvebjXRuERI
	 HsR4YbkbXz8ec8H2Kqi1rfBssVmCkjdIsUp7yvEcaYJtfLEXQeokJ/nNc0Ny4zsYTJ
	 KUw12dmTrcmmvE63CIqK08A7fTf1KXENkXOmoH8DG3CsxZZkrv4IfZyu638AEOxnR1
	 pl0cjIW2doXH6ODLHKkkjyGy1HPjnSN79koPB0HWzAV2ib5XE6hFra5IlAUnj4XZ85
	 QBLyXqN+lUlGg==
Date: Tue, 26 May 2026 17:36:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux@roeck-us.net, jdelvare@suse.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 4/4] MAINTAINERS: add entry for Sensirion SLF3x
 flow sensor driver
Message-ID: <20260526173616.256fd535@jic23-huawei>
In-Reply-To: <20260524205112.26638-5-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
	<20260524205112.26638-5-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 22:49:39 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> From: Wadim Mueller <wadim.mueller@cmblu.de>
> 
> Signed-off-by: Wadim Mueller <wadim.mueller@cmblu.de>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06a8c7457..5cafa8c8f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24187,6 +24187,13 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
>  F:	drivers/iio/chemical/sgp40.c
>  
> +SENSIRION SLF3X LIQUID FLOW SENSOR DRIVER
> +M:	Wadim Mueller <wadim.mueller@cmblu.de>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> +F:	drivers/iio/flow/slf3x.c
No need for separate patch.  Bring it in with the dt entry in the binding
patch then add the .c file in the following one.

thanks,

Jonathan

> +
>  SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>
>  S:	Maintained

