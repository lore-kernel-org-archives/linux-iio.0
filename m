Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97283F788C
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965292; cv=none; b=BhOjqcGQy9P2AEYt6G5ALfKZxacP+nOhNh509aMk9xwNgBRtaf717pDgixcXSZE9rPyqJsjuQgghJgJZCaUaHCZGbgjYHj1BGAnQB7tO5tbbyDONDnJf1Ea//09NE4e8ayaDVQvBRZib3qOwJt3d8AK7UYmSU0bTREd/XgXHX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965292; c=relaxed/simple;
	bh=7JnI7j3btM4JjILssNBqVijfEDALZr3A206tfX0tMqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1acapi0u+uHbx+vGcpBujfGB7qcgeqDQhm0Cu9Uirm4rsfI0KtnPwud497ElXmnjCX+JOfUbA5oQwLk1KNj1/4RzyCHjHour5wv03ky8JNoCOatapSYaqsjDAiVORr1cUPRM9MYDQol4SBQ54FLE3K8LUBifPkmTp3i8oJWr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tBlXnBhf; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tBlXnBhf"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d7fdb922a5so4748144a34.3
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 06:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774965289; x=1775570089; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oW5w+d0KTtZdAceXADT5c6RAFaYtXidlXlK+uQrRu5c=;
        b=tBlXnBhff+5/bdwDabZzMLgLuRv0Byx97oTlGfU8o9sQI6TBv2+5nESW6n6sD0/ooV
         C87piUIrhBo5KgbuDjGJts9Q2bpTfs/M7bJkmI1oB7frvZ0Hja0SLpURWaTV2tmIu15v
         44RbtcnjoofMsKW5eaX3gh2GZyvbzdVDGEGs7jraiYXoodoeMhb5Jgxhgq65zLnKBWdj
         PkwyzWAAvhx1yuj2xJPsL0gxV3t1mjMEWWd5PLyQhoGAQlkr38pLHaimcoT9a470IOG9
         mypWYqnNX6sr+YryKhvXs+avR+1pGy3c7wwHEOlLICnLY6YWIYz/Qn1a+3KKc3OgSm2R
         Mh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965289; x=1775570089;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oW5w+d0KTtZdAceXADT5c6RAFaYtXidlXlK+uQrRu5c=;
        b=VadUDNRuMOpf2PJjZin0MkeSeqIArQMAx8qrmWsYipqOylINa4BI86X4xxYTcGgqYB
         IK2ShXF7FvrF/x739iGExAeUgoHp3JAYhy+PMyvQacQkiSY3Y2iMx3Pm/zI0NQeubN3x
         tGhlf3A/HW46/sib+xt/BsLBLseIXeYQoxIf4WYYwP/q/pVST3v0ufMQDerkdgpTsAKF
         XOb1X2/G3PYjNBEqfbXUkoPMPk8jhy3I62fGXMHrySNFvOEqT/62WTwibB/2znDYB07B
         LYVE75xppfSuGfsS9FY4fDCDK52lsR00ppX4CJUb03ipMagPYdKrGsFciH9pKFSyt8Jx
         Fftw==
X-Gm-Message-State: AOJu0YwWkY790Bw3x+aKaJJ/xMrWt9ZAvTatKtVay26jWyg8TzocgzvH
	Dpon52R1slkTPvOJqWVsFXH3cSWbm4QST1mnlbjXTXZ9xsb98YZNTxBqYBY5OFFKBJo=
X-Gm-Gg: ATEYQzwDKLNrSGfNMA94QhC90u61CQT8EndmAvMqpsy3Ngz9QrI/gav0am1HbPx0uVS
	pWfdyNXJj9sJKITHHGRvOV201usRdtus6QyFsKsV9I3G3Nf1n8rxT8L1MTGcWPeyXPxiqXbO3Fk
	Xir3eMoQIqw1UDDIwS47cY+2C5/CuJ70mWw9rsy/GTlxvtx29Rw5SsSEB6baqVU951vB75aF/ep
	SmzqEYfGaWkd6611hqhB1AdVJJfb/aHD+BsWHAx6ybforQRPWs4Vj3dOWjc829xvLmQLYHbqrh4
	b6NTVPyDHq7+cZHx5Y1FYRQDGcOqM9k0JnfTI6Ww0UJODTB8EB0T6Z9L3TUhDeUGRoNGekqeyou
	eozcnALRhg5IrPuHNRZOJrgkX5Vd67GCObFUCgQDT3YBNxgXb4yZVN0ZipkTJrXsSUdEwu7HinC
	2pEf7y3s9Sy3Sp2DFGF0a2+qvDZxP2sDTI6rSBJgK/GogHU2Sd/aYn5QtbgSm2q25WQ/Lr4oKg7
	tNa87twQA==
X-Received: by 2002:a05:6830:3c07:b0:7d7:ccd6:3cd4 with SMTP id 46e09a7af769-7d9faf1fdafmr8530865a34.23.1774965288602;
        Tue, 31 Mar 2026 06:54:48 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:732:592e:7567:cf3f? ([2600:8803:e7e4:500:732:592e:7567:cf3f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a821746sm8799902a34.24.2026.03.31.06.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 06:54:48 -0700 (PDT)
Message-ID: <57b99103-e60f-40ce-aea7-ec57f32ec5af@baylibre.com>
Date: Tue, 31 Mar 2026 08:54:47 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad4695: Fix call ordering in offload buffer
 postenable
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "Sa, Nuno" <Nuno.Sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260330-ad4696-fix-v1-1-e841e96451b2@analog.com>
 <cfe07818-e040-4ce8-9407-d951df637af1@baylibre.com>
 <LV9PR03MB84144580E5523DC01542E56FF752A@LV9PR03MB8414.namprd03.prod.outlook.com>
 <ede20708-2575-4761-9876-80df5574cb2f@baylibre.com>
 <LV9PR03MB841477AC17E269713AC58356F753A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <LV9PR03MB841477AC17E269713AC58356F753A@LV9PR03MB8414.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/31/26 5:53 AM, Sabau, Radu bogdan wrote:
> 
> 
>> -----Original Message-----
>> From: David Lechner <dlechner@baylibre.com>
>> Sent: Monday, March 30, 2026 7:46 PM
>> To: Sabau, Radu bogdan <Radu.Sabau@analog.com>; Lars-Peter Clausen
> 
> Hi David, Andy,
> 
>>
>> Which commit is the HDL being built from? It could be that something
>> changed in the FPGA implementation rather than the driver.
>>
> 
> Good call. The bitstream was built from commit 79446d8ee in the ADI HDL
> tree — "library/spi_engine: fix spi engine for SDI backpressure",
> authored by Carlos Souza, merged February 4 2026.
> 
> That commit made two relevant changes to spi_engine_offload.v:
> 
> 1. cmd_valid was decoupled from spi_active. Previously:
> 
>      assign cmd_valid = spi_active;
> 
>    Now cmd_valid is driven by a separate offload_cmd_valid register.
>    The practical effect is cmd_valid is no longer asserted the instant
>    spi_active goes high.
> 
> 2. spi_active now stays asserted until the DMA has consumed all pending
>    SDI data, not just until the last command is accepted. The old
>    deassertion condition was:
> 
>      cmd_ready && (spi_cmd_rd_addr_next == ctrl_cmd_wr_addr)
> 
>    The new condition holds spi_active high while
>    offload_disable_pending && sdi_data_valid. Since interconnect_dir =
>    spi_enable | spi_active, this means the interconnect stays in offload
>    direction for the full duration of the SDI drain phase.
> 
> The February commit also changed the execution module's io_ready1 logic
> (now gated on pending_sdi_data_valid instead of sdi_data_valid directly),
> which shifts when the execution engine signals completion via SYNC relative
> to the last bit being clocked. Together these changes alter the timing of
> the mode boundary between regular SPI and offload. The panic — as shown
> below — is consistent with a race where SPI_ENGINE_INT_CMD_ALMOST_EMPTY
> is left armed in int_enable after host->cur_msg has already been cleared.
> The exact causal chain needs more instrumentation to confirm, but this
> commit is the most significant HDL delta between your test setup and mine.
> 
> So your instinct was right — something changed on the FPGA side,
> specifically the SDI backpressure fix. The driver ordering fix is still
> correct regardless (and I would say is the right thing to do), but
> I wanted to close the loop on the root cause.
> 
> Regarding the race you raised with the new ordering — I tested with
> msleep(100) inserted between ad4695_enter_advanced_sequencer_mode() and
> spi_offload_trigger_enable() to simulate a slow machine. Data came back
> correctly with no index shift. This confirms the expectation: with PWM
> as the CNV source the ADC only converts on an external CNV pulse, and
> the PWM isn't running until spi_offload_trigger_enable() enables the
> trigger, so there is nothing to miss during that gap.

Thanks for clearing this up. I found my notes from when I was working on
this (back in Oct. 2024). It looks like when you aren't using an external
CNV trigger, then ad4695_enter_advanced_sequencer_mode() actually triggers
the first conversion. But it looks like in the end, we ended up only
supporting the case where PWM is connected to CNV.

So the ordering currently in the driver was probably from an earlier
revision that supported more wiring options.

So yes, I'm convinced that changing the ordering for the PWM/CNV case
should be OK.

We'll still want a v2 though with an updated commit message that gives
the reason for the change independent of the AXI SPI Engine changes that
triggered a bug.
