Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018091A3166;
	Thu,  2 Jul 2026 01:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782956471; cv=none; b=hc3bcf1PBZBhyayK46F+d4OKDnkRi6VXPUYqhODKqCi2gOyxErOcvDTZZDDedEsT0eVcZXJfYanxmZkmxqSk0G8jJ5Egzm/YoICTMfu/rxRU2ZP+PxzZXYPkcxfppHq4liaJIi4UD5AHEwm+I79rP8Ipcjh1u1Gw+6xzbNh6lRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782956471; c=relaxed/simple;
	bh=xkyTQNx53c2kqIPgF+Tp+YLtqPClyFjkpnftKI8Wr+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcu9iqnLFXGRhnrfNoXx9E5+UbBFLIL6R9mpx3QGSsiox2h2v+NzWrHnPw9DcvboM9ale6cO3k7GRCwUoHE9qshFBGfeisnKH3ub1gfsHjXYbD1RDYkhzVdYmIcXZEhMzoNTE9advvosZTKiq2tULN12Ma0mEwNbcPsLVvDdMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWO3LUdI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWO3LUdI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5618C1F000E9;
	Thu,  2 Jul 2026 01:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782956469;
	bh=dMBVQ8s3xRBbc6iQec9kH23ss/jNpirGQuSnTLSUTHQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZWO3LUdIB3zoQRipfDfkoxEYw6zcHoBBzyG8e2g7rm5UML04Z7ffInl65CaGf0lz2
	 olGvPEXmqfcsFKJhCXTfE9petGdpnXJwFlt01TNV2lUc3HLhaligkF8p37QHqyzInG
	 LmMAdDfMd59dAeVCM+YF37A1fc6aFN5ZbDt5XAuaGKuuXev3rqFRYHfJMQsOLKqahm
	 wiND1QyEsHeXLmb3osYXb2EFBTGwadxfr0MufM74plb7rjDV+tyG/4Rmy2IfQ2Warl
	 7iuT8q3RKyTT9IV7kHdomYyx//IfBpUAMLecCc4c/JyHDIU3n6SYL/WgQFSNUkInrL
	 yUSfcF8Iq0vHg==
Date: Thu, 2 Jul 2026 02:41:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, conor@kernel.org,
 conor+dt@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] iio: health: add MAX86150 ECG and PPG biosensor
 driver
Message-ID: <20260702024104.206181f3@jic23-huawei>
In-Reply-To: <20260623201124.18271-1-shofiqtest@gmail.com>
References: <20260623174600.17100-1-shofiqtest@gmail.com>
	<20260623201124.18271-1-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 23:11:20 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> Changes in v5 (addressing Conor Dooley and Sashiko review of v4):

No idea if someone else has commented on it in the nested threads
I'm seeing but never send a new patch version in reply to another.
It leads to really tricky to follow threads in a threading email
client + also ensures your whole series is pages up in the maintainers
backlog.

New version, new email thread.

Thanks,

Jonathan

> 
> DT binding (Conor Dooley):
> - Rename binding file and compatible to adi,max86150 per ADI policy for
>   former Maxim products.
> - Add missing power supply properties: avdd-supply (analog core),
>   vref-supply (ECG reference); make all four supplies required.
> - Fix vdd-supply description: remove voltage tolerances; say "1.8 V".
> - Fix leds-supply description: say "typically 3.3 V" (datasheet max
>   is 5.0 V, not 5.5 V as previously stated).
> - Rename example node to heart-rate@5e per prior DT art.
> 
> Driver (Sashiko):
> - [High] Re-assign indio_dev->trig after trigger registration so the
>   hardware trigger is the default and iio_trigger_validate_own_device
>   accepts writes to current_trigger without a manual sysfs step.
>   iio_device_unregister() releases the reference via iio_trigger_put().
> - [High] Switch from devm_request_irq() to devm_request_threaded_irq()
>   with IRQF_ONESHOT. A hard handler returning IRQ_HANDLED on a
>   level-triggered line unmasks the still-asserted INT pin and causes an
>   immediate re-fire loop. IRQF_ONESHOT keeps the line masked until
>   max86150_trigger_handler reads INT_STATUS1 and de-asserts the source.
> - [Medium] Fix overflow timestamps: when OVF_COUNTER > 0, pf->timestamp
>   reflects an earlier A_FULL event and is no longer a valid anchor.
>   Capture ktime_get_ns() at drain time and reconstruct timestamps
>   relative to the newest surviving sample instead.
> - [Medium] Pad fifo_raw to ARCH_DMA_MINALIGN bytes so that buf starts
>   in the next cacheline. Previously the 9-byte fifo_raw (DMA target)
>   and buf (CPU push buffer) shared a cacheline, violating DMA API
>   constraints flagged by CONFIG_DMA_API_DEBUG.
> - [Medium] Replace blind usleep_range() in read_raw() with
>   regmap_read_poll_timeout() on the PPG_RDY bit. A fixed 11 ms sleep
>   risks reading an empty FIFO if the internal oscillator starts slower
>   than nominal; polling with a 25 ms timeout is robust.
> 
> Link: https://lore.kernel.org/linux-iio/20260623174600.17100-1-shofiqtest@gmail.com/
>   v4 cover letter
> 
> Md Shofiqul Islam (3):
>   dt-bindings: iio: health: add adi,max86150
>   iio: health: add MAX86150 ECG and PPG biosensor driver
>   MAINTAINERS: add entry for MAX86150 IIO health driver
> 
>  .../bindings/iio/health/adi,max86150.yaml     |  78 ++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/health/Kconfig                    |  23 +
>  drivers/iio/health/Makefile                   |   1 +
>  drivers/iio/health/max86150.c                 | 730 ++++++++++++++++++
>  5 files changed, 839 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
>  create mode 100644 drivers/iio/health/max86150.c
> 

