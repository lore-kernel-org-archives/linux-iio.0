Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA633EBF2D;
	Wed, 27 May 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898765; cv=none; b=BwMP7Rr2wVuXg8xFWjJJpIslZHCBn1Bib3+Rxi9/exci9+6y23GVgW3G2PjlIfw7krNw5eZPtfFrOG+1EZGjBQ3yyncQSLY9d+I2j2M/XctqJ0e1hKBmfobd8qDtII8X5PLNQrPRGSy4N33vUmF4poBYCOsNf7b+8wh8Clc4gCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898765; c=relaxed/simple;
	bh=GEwsQBuZINSMmHYVS2y0ew1Ng939h22lvQ29J4tJE34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBJlBaN7VagpslAHeeeKtL+ILbcwkbE8WXTuvb+mbkb8nhEbcg8fcpkEJGq15V4GQ39DPh2B4MgSis3ZfGupQyjoZUvYDQJaZlRQ2Qr3d2BV0awGUQZ3DJ/DSq1jthzqTVmshYtzpRmZD3QPDdGCRA6dTGloXBlVnGia9v3oYMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeWv8+/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeWv8+/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE3B1F000E9;
	Wed, 27 May 2026 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779898763;
	bh=L64FlUSDU6yeP0Frp8nzz5P0eOa+Mmc/V61eOsAemLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UeWv8+/zyHrNMKDlcWlcMamtXmRjbZsW8y3+xZt0gX8O42m8ynWenSSo//YRHk6Nm
	 SMKHTOnMd9UnBinj4Vk3xN/Ms0ayMhcPEdGqHJAvoMrOGseDwVq/E0yuaSioIjtM9j
	 qrA8O7IoWK6K+sVl/Y75TbApbUwLbOC0WRcwVEDEoTl7KzWxwQw8zdDaEC2pvc//F4
	 sOMEk6eWiVkB0odaUko2pUyhlNkBC6Wmo3KPle6BIIXKCtt4o7NLB9YCTNtXf9X8wR
	 7S+Ul8jX923j948lKYCjeOmNW0rZnexRjxyu319Gef8fzVUi9Q1batmdcg4PFVwpGA
	 ge3qQqGD4bY3w==
Date: Wed, 27 May 2026 17:19:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Antoniu Miclaus" <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v4 5/9] iio: temperature: ltc2983: Fix inconsistent
 channel wording in messages
Message-ID: <20260527171913.603c050f@jic23-huawei>
In-Reply-To: <20260525164013.118614-6-liviu.stan@analog.com>
References: <20260525164013.118614-1-liviu.stan@analog.com>
	<20260525164013.118614-6-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 19:39:32 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> Replace occurrences of the abbreviated 'chann' and 'chan' with
> 'channel' in error and debug messages throughout the driver.
> Also changed the diode invalid channel error message from
> "thermistor" to "diode".
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
Applied,

Thanks,

Jonathan
