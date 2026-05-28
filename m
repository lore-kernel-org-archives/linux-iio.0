Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A346E2D9481;
	Thu, 28 May 2026 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957489; cv=none; b=rmf5W+Np7lWqEYuzjpLL5HZXOnMo6Mqj2+Rw7InDWfBOseKd9GSJuVvpNr1v7tq6QdcQtuwdXMH1i4fWvph8GFW6F9aCr4ASWyoAV7RgFsgzidfAGaj+2az3FHvJsA7PtGpZKKuvzhh41IoEnUtwxemrLhQ9uLyOWxGf0+uQeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957489; c=relaxed/simple;
	bh=qX+gyp7iLQbkhqCAl+ssQYzS2wiXMag3bhDmbPo6AWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXdKyHhuttrIQkmS+ozSDFYLx6x/coCr6hRktCJw1bgTY1ybwjLOntAl7ZCRR+eD6I1GQ0M/GSOk5N7H8HT5Ct2uSbVZk9wOpTuQv0iTvH4TII4hJRhouY0EX3WKEDsHKoq7KGAkA3aA+fEyuB3ZxjTUusfZsWHzCmSkhKlMKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPeOZoMM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPeOZoMM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F67F1F000E9;
	Thu, 28 May 2026 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779957488;
	bh=vKehSL1/3umU8OhujzkI2ikXJ6NcxCQ7iE1W7LsrXho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kPeOZoMMXw5BTIturArwsiZrVn8yBgzLeEEe1jfmLQslAxmY5ehSQrCU2Hy7XarC7
	 PEt/vYHLBW/YdBIrvPUV1Y6Ohp1tEU/WKlHv5S51y4BdIpVJ7dwh+BxLIAigwa+08e
	 HcqrwJgMUkZf/8UCbNAadNnOgsY//5i6YzFq+mj62Bvacu9oc0rCOczvPeieBgDm9m
	 cTkdwLaDCGFUWdZ1kH+4EhsJTW9c42BibYi4wVNF2wsCBDQUAdAHW7LiFjMRRzoZpb
	 RmmVwBZmHMX0IuPIAFFE1mK4ZXmqBmKFP+Ir0LIWIWrYGnu7mL2G9/POBLx7xu2YjY
	 4PosYRMiBu+rA==
Date: Thu, 28 May 2026 10:38:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Conall O'Griofa <conall.ogriofa@amd.com>, 
	Michal Simek <michal.simek@amd.com>, Guenter Roeck <linux@roeck-us.net>, 
	Salih Erim <erimsalih@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: iio: adc: add xlnx,versal-sysmon
 binding
Message-ID: <20260528-illustrious-outrageous-wren-51feef@quoll>
References: <20260527114211.174288-1-salih.erim@amd.com>
 <20260527114211.174288-2-salih.erim@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527114211.174288-2-salih.erim@amd.com>

On Wed, May 27, 2026 at 12:42:07PM +0100, Salih Erim wrote:
> Add devicetree binding for the AMD/Xilinx Versal System Monitor (SysMon).
> 
> The Versal SysMon is the successor to the Zynq UltraScale+ AMS block,
> providing on-chip voltage and temperature monitoring. The hardware
> supports up to 160 supply voltage measurement points and up to 64
> temperature satellites distributed across the SoC, with configurable
> threshold alarms and oversampling. The device can be accessed via
> memory-mapped I/O or via an I2C interface.
> 
> Supply and temperature channels are described as child nodes under
> container nodes, referencing the standard adc.yaml binding for
> channel properties.
> 
> Co-developed-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Salih Erim <salih.erim@amd.com>
> ---
> Changes in v3:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

