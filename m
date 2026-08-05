Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26975343D80;
	Wed,  5 Aug 2026 00:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888872; cv=none; b=ZSz5MLegNDGHvL3pm6Hy3KK7Syu9Pdfb2/hNh8EwknIgGxB7q14OItDJuGo1fnPdlu+XIOv5lN+bUBomHXUv2+z99FVArNUn4IbnYH9wEH7qqG+6jXjA07aBeTtz+BT7FQZVhm1BPHQTAvpIQsWR7+/oVYaAvjRTlOAQCgIFv/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888872; c=relaxed/simple;
	bh=7KgHhLOEtdJ3O59rIjiiHNzN68stBdXRqIAyKkaBGk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XT+7QVpFq3muD6qPGmPVf/6weeJVt3YWVqXdag+nIh5KTc70ooRbQMH1jWtcMXlDLDgbFDV5M0rJJyN3nB+Hig9rAWh8RBPbWaCu9KKDzqzyM+Jmc2yUktUj76mm5fAk9gMV0wtergpwXgrYkLqA4eSScfZ4fQGALLdhabgDwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVDsSqZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVDsSqZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897CC1F00A3A;
	Wed,  5 Aug 2026 00:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785888871;
	bh=CW7w5X7Kc7OcEIZG2VU37B9p/7O1Pd1V1X1of2ZTIEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oVDsSqZd9vKQYvQg2mhT3Ha3A6Ci6tEF4CjKEZ7TMk/ilf3j+RUZl8ImS4Tm/3CIr
	 acWBjtXkOp13HwQJfuUfexbsLFCINwJGqN9LMWKzyHwkqoXQ+wQ+JsWWD6kKhWvP78
	 nLBvhopqW5+fElzBp+uzG/r1f7rRXUVdLhR/jRzr6WKq3lcb8tXbfC0xLbzsMvtU6p
	 h1yCJ6YwjUoY3H5Hp9gdQzjW9dP2DcswZfpgDZJl5ZW8Jf69ADcEhFBlselRLmbF40
	 Xymvg4IOWZdT+oYuw8Z7PCeFN23Cy1f0wRLCXnoD5rJlINXHfqHVo5dHL5iku61Kpy
	 tD0vK0VuKeDxA==
Date: Wed, 5 Aug 2026 01:14:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Conor Dooley
 <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 0/2] iio: dac: mcp47a1: add support for new device
Message-ID: <20260805011426.30a4b5e1@jic23-huawei>
In-Reply-To: <20260803-mcp47a1-add-support-v3-0-540e71b4fd2e@gmail.com>
References: <20260803-mcp47a1-add-support-v3-0-540e71b4fd2e@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Aug 2026 19:32:24 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> This patch series adds support for the MCP47A1 DAC.
> 
> The Microchip MCP47A1 is a volatile 6-bit Digital-to-Analog converter
> which communicates via I2C. It is a low-power, low-cost DAC commonly
> used in embedded systems.
> 
> Reasons for adding a new driver:
> - Existing Microchip DACs use a more complicated set of commands
>   whereas the MCP47A1 communicates via SMBus using only one command.
> - The closest Microchip DAC already in the tree - the MCP4725 - uses
>   an EEPROM while the MCP47A1 is volatile, meaning that altering
>   the driver of the former would worsen the code flow.
> - The MCP47A1 maps cleanly to a standard regmap.
> 
> The driver was tested on a Raspberry Pi 4 using a breakout board with
> the MCP47A1.
> 
> The datasheet can be viewed here:
> https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/25154A.pdf
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied to the testing branch of iio.git

Thanks,

Jonathan
