Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913371;
	b=zvr7NJKjnxIlFNtfapWDWLt+f8DoIbD6PY9ouHWe58jl0jaC9f0BYKTZDkaEPZnL0rZO
	 q2zU2+ij4etDME+bmeDceMmg+NaPIXcIgG4IG/heQVchmJLI9j2C6UdAEy0YjR6Cak0m9
	 TnPYx6bCA9sQkXVGJhRTPTuoSLNOEewKTMq3SRAHo1lY21NdIXCAHcKiPUKuBse4lSX2z
	 DeWKd3/7kfLMVKh/1cVL5zXAomKmLC33dgnttur+qqlFhd+OmgKfgFjVn9CyyC2cyY8Ze
	 mAXwjv5PnFXMxtcoY72EaoBmMsE7yrP4US0yq8rZsodhwkbD4ddKci3Mfq86NaYkTPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913371;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=4/Fvf7E+Un4aLup2xhf6vcvvyKFWGICv9YQQYKVltHc=;
	b=fSVcg/yob4jaWXPPsOovh5+xFvALllonXICm7qTOGLkVTyOTnhqWDuSPYzaCB1MZpP9e
	 PiEfXe5AfkwS/707ueONlw7wVEnL6BH5BK03qAzs04yfkMvvUbGLPHYzvXZstPge1QDDu
	 LIErhewxVcUmvhBTrEgZJlJQjqoVGoojb+/fSw8gFIQ4s0AVwOjSh/eNcj4pLOgCmUvjI
	 Gnocie8xSIV5KwVUauUHXbdkD/+yfmuT2//IY681U8dzEwivvsR1lgFReWamQ/uXrM8y1
	 THCYrVB+TpQFzcMWOqDDexlv99I3PLt5bf91dtOVHKN59Nk1QxLr5ptozL+/V95yHkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fyr8mDax;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A461606A323;
	Tue, 17 Nov 2026 11:02:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A461606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fyr8mDax
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794913368;
	bh=zNPAVFB5OHAo9dWfi5NdM3L/flQEMCi7yaBTq7F5x6E=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fyr8mDaxrdN0nrHbklcFLZg6yKwey9bhue9l4WbPrR6jDlIQgZ45r6nBBnxtZ8rSY
	 zuaa9r/ZAFY1gNs6+lYMz5HQ5Vq9aqNXlj9kG29lLNLau5v7CRAt/iinEFH8J/UDZ9
	 kW/cPJIPqGZH6+C2taBZ3eOM3PRQEOcN0nmCqz1EtFLTp2/M3o+P84zwV6D7LTNNad
	 RKeJPDRR43Y+F23gG4+GWe/dioQcLzlHpnN/oPEx7oMRkU4PKLW/AI0x6Q7Gw+/YKf
	 7we3Jrflsk3UsV0m+bEMt9fRIF498b/DrLPIKnwlyU/kk+SVDggCR6cuH92H6+D9bi
	 zmlQ6mYCWJ1zA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 17EC717E05D6;
	Tue, 17 Nov 2026 12:02:48 +0100 (CET)
Message-ID: <60eeaaf9-57db-4ca7-b4f5-bdec111dcdbb@collabora.com>
Date: Tue, 17 Nov 2026 12:02:47 +0100
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] iio: adc: add mt6397 PMIC AUXADC support
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Ryan Brue <ryanbrue.dev@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Roman Vivchar <rva333@protonmail.com>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-0-5c3c7a5a1851@gmail.com>
 <89c8cadb-0ccb-4aac-9b95-89f355beb24a@collabora.com>
Content-Language: en-US
In-Reply-To: <89c8cadb-0ccb-4aac-9b95-89f355beb24a@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/17/26 11:56, AngeloGioacchino Del Regno wrote:
> On 10/25/26 06:18, Ryan Brue wrote:
>> The MediaTek mt6397 PMIC has a 10-bit AUXADC that nothing in-tree can
>> reach. On boards built around it that ADC is the only path to the battery:
>> the SoC's AUXADC is wired to board thermistors, and the charger ICs these
>> boards use have no ADC at all, so without it there is no pack voltage and
>> no state of charge.
>>
> 
> I picked the Amazon Fire HD 10 series, confident that this series will also
> be picked for this cycle by the IIO maintainers, as this was fully reviewed.
> 
> So please-please-please pick this one ASAP so that we don't get dt warnings.
> 

I reiterate - I couldn't pick the series because, of course, that one depends
on the binding being merged, otherwise the header won't be there and the build
fails.

So I can't pick the DTS until the next cycle (granted that this series lands).

Cheers,
Angelo

> Cheers,
> Angelo
> 
>> Patch 1 adds the compatible to the existing MediaTek PMIC AUXADC schema and
>> the header naming the channels, patch 2 the driver. The MFD cell that
>> instantiates it was patch 3 of v4, which Lee has applied [1].
>>
>> The mt6397 is not given mediatek,mt6359-auxadc as a fallback because the
>> two are not register compatible; patch 1 has the detail.
>>
>> Only the two channels a board needs for its pack are described, so patch 1
>> ships a header naming them: a channel ID is an index into the driver's
>> array and not the PMIC's channel number, as in mt6323-auxadc. The register
>> sequences are the ones the vendor kernel's pmic_auxadc.c programs.
>>
>> Tested on an Amazon Fire HD 10 (2017), an mt8173 with an mt6397. Both
>> channels are exercised: the battery channel by a fuel gauge, which reads
>> 817 counts, 3830 mV with the pack at rest, and the thermistor channel by an
>> ntc-thermistor consuming it. The error paths are driven by injecting a
>> regmap failure into each helper in turn. The read returns the injected
>> error, and every bit is cleared again. The teardown writes were also made
>> to fail, one at a time. When one write fails, the others still run, and
>> only the failed write's bits are left set. The next read clears them
>> anyway. Run the same way, v3 stopped at the first failed write and left the
>> later bits set. v5 gives the same results as v4 in all of these. Loading
>> the two modules alternately on the board, their readings differ by 0.3 LSB
>> on the battery channel and 0.1 LSB on the thermistor, both inside the
>> comparison's own noise.
>>
>> A new driver was created here, instead of modifying an existing driver such
>> as mt6323-auxadc or mt6359-auxadc, for the following reasons:
>>
>>   - Both mt6323-auxadc and mt6359-auxadc select channels through a request
>>     register (1 bit per channel), while mt6397 uses a 4-bit numeric field
>>     CHSEL in CON1 (10:7), and then pulses a START bit (CON1 bit 0).
>>
>>   - For mt6323-auxadc, which is the closest I could find to the mt6397
>>     (CON0..CON27), it has 13 more registers than the mt6397 (CON0..CON14).
>>     It uses CON22 for its request register, and reads the result value
>>     from the same register as the ready bit. We don't do that - the mt6397
>>     has a factory-calibrated value for each channel at 0x16 higher than the
>>     raw value. mt6323 also has a 1800 mV / 15 bit scale / resolution while
>>     we have 1200 mV / 10 bits. We also have some per-channel preparation
>>     that we have to do before the burst, that the mt6323 doesn't have to
>>     do.
>>
>>   - For mt6359-auxadc, it has a more generic framework for describing the
>>     AUXADC, but it assumes requests are channel-per-bit, and so we would
>>     have to basically ignore req_idx, req_mask, rdy_idx, and rdy_mask.
>>
>>   - We also have our own software sampling, which the vendor does too
>>     (Amazon Fire OS based on Linux 3.18). We'd have to have our own
>>     sampling callback to do it.
>>
>> I have two things in the driver different from the vendor (Amazon
>> Fire OS based on a 3.18 kernel). Verified with over 150 interleaved reads
>> per setting:
>>
>>   - Leaving the ISENSE input enabled between reads, as the vendor does,
>>     makes no difference to the value, so the driver switches it off again.
>>     Both ADC input enables are clear when idle, unless a teardown write
>>     itself fails: the rest of the teardown still runs, and the next read of
>>     the channel clears whatever was left set.
>>
>>   - The chip's sample accumulator makes no difference at 4, 8, 16 or 31
>>     samples and costs no measurable time, so it is left at one. Software
>>     averaging helps, but only by about a quarter: in one interleaved run,
>>     0.92 LSB standard deviation for one conversion against 0.67 for sixteen,
>>     where independent samples would have given 0.23. Conversions in a burst
>>     are correlated.
>>
>> The reading was checked against the charger, which regulates the pack to
>> a programmed voltage in constant-voltage mode. Over twelve such voltages
>> from 3904 to 4080 mV, and charge currents from 111 to 778 mA, the driver's
>> reading is a mean of 0.9 mV from the regulated value, well inside
>> the charger's regulation tolerance. That also settles reading the chip's
>> trimmed result register rather than the raw one - the raw register is
>> 20.7 mV low at every one of the twelve points.
>>
>> This series was developed with the help of an LLM coding assistant.
>>
>> [1] https://lore.kernel.org/all/179206667779.1910726.5341177428334836457.b4-ty@b4/
>>
>> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
>> ---
>> Changes in v5:
>> - Split the read into one helper per channel, each doing its own setup,
>>    burst and teardown, and a caller that takes the lock and dispatches on
>>    the channel. mt6397_auxadc_release() is gone. The register sequence is
>>    unchanged on every path, including every failure path, and retested on
>>    hardware. (Jonathan)
>> - Keep Andy's Reviewed-by on patch 2, since the change is a restructure
>>    that does not change behavior. If that's incorrect let me know.
>> - Drop the MFD cell patch, applied by Lee from v4.
>> - Rebase onto iio/testing. The MAINTAINERS entry now follows the MT6323
>>    PMIC NVMEM one.
>> - Drop the Assisted-by trailers per the new kernel guidance, and put the
>>    disclosure in the cover letter.
>> - Link to v4: https://patch.msgid.link/20260928-rbrue-suez-upstreaming-mt6397- 
>> auxadc-v4-0-23533a0d30e3@gmail.com
>>
>> Changes in v4:
>> - Attempt every teardown write even if a previous one fails, so a failed
>>    write doesn't leave the buffer, bias, or input powered. Reverses the v3
>>    change. The teardown neither checks nor logs errors for failed writes,
>>    similar to mt6358_stop_imp_conv(). The next read will rewrite those bits
>>    anyway. (Angelo, sashiko-bot, Andy)
>> - Move teardown into mt6397_auxadc_release(), keep error paths out of line
>>    with goto, and use mutex_lock() / mutex_unlock() rather than guard().
>>    (Jonathan)
>> - Reword the comment above the BATSNS disable prior to ISENSE enable.
>>    (Jonathan)
>> - Collect tags.
>> - Link to v3: https://patch.msgid.link/20260920-rbrue-suez-upstreaming-mt6397- 
>> auxadc-v3-0-c00edacbee64@gmail.com
>>
>> Changes in v3:
>> - Move the sample loop into its own function, so read_channel() is setup,
>>    then a conditional burst, then an unconditional teardown, with no goto
>>    mixed with guard(). (Andy, sashiko-bot)
>> - battemp_bias_off() and isense_disable() now return on the first failed
>>    write, as mt6323_auxadc_release() does, and twelve other teardowns in
>>    drivers/iio that I could find. A failed write can leave the later bits
>>    set; the teardown runs at the end of every read, so the next read of that
>>    channel clears them. (Andy)
>> - Drop the "if (!ret) ret = err;" accumulators with it. A teardown failure
>>    now goes to dev_err() rather than being returned, since the caller cannot
>>    act on it, and read_channel() takes the iio_dev so no struct device * is
>>    stored. (Andy)
>> - Split battemp_bias(adc, bool on) into battemp_bias_on() and
>>    battemp_bias_off(), and drop the bool. (Andy)
>> - Make the SCALE case an if-else. (Andy)
>> - Move the "why a new driver" rationale below the --- marker in patch 2,
>>    out of the commit message. (Andy)
>> - Reduce the CHSEL regmap_update_bits() call from four lines to two. (Andy)
>> - Drop the comment above guard(mutex). (Andy)
>> - Say in a comment why lowering START needs no settling delay. The ready
>>    bit survives the fall and is cleared by the rise before the next
>>    transaction on the PMIC wrapper can observe it. I measured this, and the
>>    details are in the reply on 2/3. (Andy)
>> - Cc Luca Leonardo Scorcia with a trailer rather than in prose. (Andy)
>> - Link to v2: https://patch.msgid.link/20260917-rbrue-suez-upstreaming-mt6397- 
>> auxadc-v2-0-db35882a6080@gmail.com
>>
>> Changes in v2:
>> - Add justification for this being a new driver rather than folded into
>>    mt6323-auxadc.c or mt6359-auxadc.c, in the cover letter and patch 2.
>> - Drop the "ret = ret ?: ..." chains, and let teardown fall through on
>>    errors, allowing the chance for all bits to be properly torn down. The
>>    errors are now held rather than discarded. (Andy and sashiko-bot)
>> - Run teardown even when per-channel setup fails part-way through, so we
>>    don't leave bits enabled that would have been cleared. (sashiko-bot)
>> - Set ISENSE settle time to (1 * USEC_PER_MSEC). (Andy)
>> - Write the two channel descriptors out instead of using a macro. Also
>>    gets rid of the padded column. (Andy, Jonathan)
>> - Move the MAINTAINERS entry for the dt-bindings header into patch 1, as
>>    the mt6323 series does.
>> - Declare the sample loop counter in the loop, instead of with sum, and
>>    split the declaration of sample and ret. (Andy)
>> - Keep the two CHR_CON16 ADCIN bits as BIT()s rather than turning them
>>    into values of a GENMASK field. Fix OR operator on the bits, treat them
>>    as mutually exclusive. (Jonathan)
>> - The rest of Jonathan's v1 review: two-space indent separating a register's
>>    fields from the register, a blank line before the settle times, a lock
>>    comment that says why the lock is held, the two CON1 START writes on one
>>    line each, the single-call init helper inlined into probe, and { } for the
>>    of_device_id sentinel.
>> - Add the additional three CHR_CON16 ADCIN defines that make up the 5
>>    single-bit enables. These are currently unused.
>> - Link to v1: https://patch.msgid.link/20260915-rbrue-suez-upstreaming-mt6397- 
>> auxadc-v1-0-d35d2ac3d6f0@gmail.com
>>
>> ---
>> Ryan Brue (2):
>>        dt-bindings: iio: adc: mediatek,mt6359-auxadc: add mt6397 PMIC AUXADC
>>        iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC driver
>>
>>   .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |   1 +
>>   MAINTAINERS                                        |   7 +
>>   drivers/iio/adc/Kconfig                            |  11 +
>>   drivers/iio/adc/Makefile                           |   1 +
>>   drivers/iio/adc/mt6397-auxadc.c                    | 394 +++++++++++++++++++++
>>   .../dt-bindings/iio/adc/mediatek,mt6397-auxadc.h   |   9 +
>>   6 files changed, 423 insertions(+)
>> ---
>> base-commit: c9dbe2a47f635465c9985b7af74d2ae310e98125
>> change-id: 20260914-rbrue-suez-upstreaming-mt6397-auxadc-5e1228025c50
>>
>> Best regards,
