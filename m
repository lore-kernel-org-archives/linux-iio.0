Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E523A7D82;
	Sat, 17 Oct 2026 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792270285; cv=none; b=ul7zU7yS8W+pc8u6o3k3pWw3fjUoLKeMVLKs5fZRLB57qr0BWbSgpVZfEZBOZsj7J2zvrDQGpBKgyAuzkplkoaPv5w/XS6no74pJ7vFhXbMsDDWpKNA8Drs006SyB8R5LS4C6Olsp9kP7wznNxE98/WyIUHPJWE/DnzTfFq+D0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792270285; c=relaxed/simple;
	bh=f/2H68jyAXF/ZWGlq4jQZmINjqhRrwiilOtA63DlJ7g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l+3BjA99es1QElEwuPcxsNzYlc1BjhMOWhQ0uwzgnVVHDXsRTx/bSTejti3bbhjWw6f9SMWeE2H7b0gXK8DIwxa9OB2cFp95X9w6wDg8PmiC8PjVfZ6vD6Cd4Too202ydyjm5pvsOGH/aphDIr2kKp29F30ZBEc8rF4DCc+oGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqN6iZpg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqN6iZpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3F51F000C4;
	Sat, 17 Oct 2026 20:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792270284;
	bh=7CRXe0R1sqRRc088500Ygp7wvqRKIksgHaSrDu77SwI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZqN6iZpgOxIJ4xTzOxwOp/qpO5YpG/ryTakacM/wvlMev7MbEiR98mhTlotCvTU1k
	 YL2OnnjXAQyWv2ziEx7VyEetHVwo/aI7ShWe0s+yZeNWND6x4O/qwFj3PcxS0C0Hj/
	 r4tt0FRJpSZQGrTFA296NEmd4YmvWsYfPmySv0mepbfHGh7a1TVPnMamXDV0s7HiIq
	 nbuIgH4wfZmI9QIq6j37taJrsuoz9GzQLkRAuJZqrk0ReNABFLKlj4g51fb9RgOTuX
	 tEYJRO9ejB++APU8xY6JHX5TOEkp+3jCly2wpGrnBpyrzeCG0m2AzWI0eDrn5Cnm+t
	 L5fCJqOhbmn+A==
Date: Sat, 17 Oct 2026 21:51:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <krzk+dt@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add support for Analog Devices MAX30210
Message-ID: <20261017215117.56980dc4@jic23-hlaptop>
In-Reply-To: <20261015012159.44-1-johnerasmusmari.geronimo@analog.com>
References: <20261015012159.44-1-johnerasmusmari.geronimo@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 09:21:57 +0800
John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com> wrote:

> This series adds support for the Analog Devices MAX30210 I2C
> temperature sensor.
> 
> The device provides a 16-bit temperature output and includes
> features such as a hardware FIFO, programmable sampling rate,
> threshold alarms, and interrupt support. These capabilities map
> naturally to the IIO subsystem, particularly the buffered interface
> and event framework -- hwmon has no equivalent buffered-capture
> framework, and its alarm attributes are polled rather than
> interrupt-driven, so there is no path to supporting the FIFO or the
> autonomous threshold comparators there.
> 

Thanks for the explanation.  Just to make sure
+CC Guenter and hwmon list.


> Although the MAX30210 belongs to the same device family as the
> MAX30208, it is implemented as a separate driver. The MAX30210 has
> a significantly different feature set, including a 64-sample hardware
> FIFO with configurable watermark interrupts, programmable sampling
> rates, and event support. These features require buffered operation
> and IRQ-driven data handling which are not present in the MAX30208
> driver (which talks to the device directly via i2c_smbus_*() calls
> with no regmap, and has no IIO buffer or event interface at all).
> 
> In addition, the MAX30210 uses a different register map and a more
> flexible I2C address selection scheme. Supporting both devices in a
> single driver would introduce substantial conditional logic, so a
> separate driver keeps the implementation simpler and easier to
> maintain.
> 
> Patch 1 adds the devicetree binding.
> Patch 2 adds the IIO driver implementation.
> 
> Changes since v3:
> https://lore.kernel.org/all/cover.1789032019.git.johnerasmusmari.geronimo@analog.com/
> - regmap_noinc_read() for FIFO reads instead of regmap_bulk_read(),
>   which (combined with regmap caching) could silently return stale
>   cached values of unrelated registers instead of real FIFO data.
> - Mark both bytes of TEMP_DATA_REG volatile for the same reason.
> - Decouple threshold events from the buffer via a refcounted
>   autoconv_get()/autoconv_put() pair, so either can be used
>   independently or concurrently.
> - Don't let a single-shot direct-mode read race with/clobber
>   autonomous conversion mode if a threshold event or the buffer is
>   already using it -- return -EBUSY instead.
> - Don't hard-fail probe when there is no interrupt; fall back to
>   direct-mode-only operation.
> - Fix devm teardown ordering so an in-flight interrupt can't use a
>   freed event interface on removal.
> - Re-assert the powerdown GPIO on removal so the device reaches
>   standby instead of staying powered indefinitely.
> - Style/API fixes from review (register/field grouping, _MASK
>   naming, FIELD_PREP/regmap_assign_bits usage, C99 initializers,
>   dropped redundant i2c_check_functionality() check, comment
>   cleanup).
> 
> All of the above have been verified on real MAX30210 hardware
> (Raspberry Pi 4 test rig), including the no-IRQ fallback, buffer and
> event refcounting (independently and concurrently), rmmod/insmod
> under live interrupts, powerdown GPIO assertion on removal, and FIFO
> flush correctness.
> 
> Changes since v2:
> https://lore.kernel.org/all/20260304122509.67931-1-johnerasmusmari.geronimo@analog.com/
> - Fix FIFO byte-count handling and sample decoding.
> - Fix IIO debug register read/write access.
> - Validate event threshold values and sampling-frequency register values.
> - Return the correct sampling-frequency format and reject direct reads
>   while buffered capture is enabled.
> - Clean up the Kconfig entry and device-tree supply declaration.
> 
> John Erasmus Mari Geronimo (2):
>   dt-bindings: iio: temperature: add ADI MAX30210
>   iio: temperature: add support for Analog Devices MAX30210
> 
>  .../iio/temperature/adi,max30210.yaml         |  61 ++
>  MAINTAINERS                                   |   8 +
>  drivers/iio/temperature/Kconfig               |  13 +
>  drivers/iio/temperature/Makefile              |   1 +
>  drivers/iio/temperature/max30210.c            | 788 ++++++++++++++++++
>  5 files changed, 871 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/adi,max30210.yaml
>  create mode 100644 drivers/iio/temperature/max30210.c
> 

