Received: from mail.kernel-space.org (v2202511311555398556.powersrv.de [46.38.245.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E59363099;
	Tue,  5 May 2026 05:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.245.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960495; cv=none; b=aZz1LMUrPvyBosC8YJWj5VPOlLnxYzGywFidNjTF2y4ZvDz2B7Gt7FQcQH9pv75BjTB99WVl/DXZZkOGDtG7t6VKFC2NvlykS3n+fnFLer/TTlQaLCpyWAxY5MuXqNUvXLh3D8pZ6RQdLHIRzTD2Pgm9TIG0wfkbVujQ0u1Q/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960495; c=relaxed/simple;
	bh=RLY645KOSH0N06zPXBMbc5TxsXmS3lPUbHgVnhI4aN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PN9IlqKPMbATHBH2lSlS+3YcZ3rkdRi7UJGLW7uLsg/QdPZH+MUbh+O3bunDls/sWgH7l/XL2dywvqhtWkUzt5Iu/00OK5psVskdlwzmtSj9DBt5bxRtu6A3S9cHR+3gLWmpGwb64UBRZ6ngZKgGIiZLR5O8pUqHEnDYzfIusew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=iGyIV0po; arc=none smtp.client-ip=46.38.245.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="iGyIV0po"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1777960490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JpWMGrla8ujc+yJ0xsFuIV5CslqX+fFHzMu968BtRqs=;
	b=iGyIV0pokGRqOSR6yVS5OD8OgQUH1DfaNQTvqfIAtARXgTj/lyciwqZ7txwOhzCs36wjBW
	CzOy3NZSCXrGBnvWRZPQxNZsamZotkReSv4X+BNBw2wjhYq6GEVyq7f7/A2fZprO2PU6ER
	SUG2FJhrzSqiKnk42VeFQeSg3agl4qw=
Received: from [IPV6:2a07:7e81:7daa:0:62cf:84ff:feee:627] (<unknown> [2a07:7e81:7daa:0:62cf:84ff:feee:627])
	by oreshnik (OpenSMTPD) with ESMTPSA id e45b9491 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 May 2026 05:54:50 +0000 (UTC)
Message-ID: <dcef09cb-3e99-4755-b423-5de1a4404fa1@kernel-space.org>
Date: Tue, 5 May 2026 07:54:49 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] iio: dac: add mcf54415 DAC
To: Greg Ungerer <gerg@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 Angelo Dureghello <adureghello@baylibre.com>
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
 <20260504-wip-stmark2-dac-v1-10-874c36a4910d@baylibre.com>
 <965cb599-37ac-4d69-a8c0-015152037139@app.fastmail.com>
 <31297e73-52a5-42a0-9676-ecf057f7c21e@linux-m68k.org>
Content-Language: en-US, it
From: Angelo Dureghello <angelo@kernel-space.org>
In-Reply-To: <31297e73-52a5-42a0-9676-ecf057f7c21e@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg, Arnd,


On 5/5/26 04:06, Greg Ungerer wrote:
> 
> On 5/5/26 03:27, Arnd Bergmann wrote:
>> On Mon, May 4, 2026, at 19:16, Angelo Dureghello wrote:
>>
>>> +static void mcf54415_dac_exit(void *data)
>>> +{
>>> +    struct mcf54415_dac *info = data;
>>> +    int val;
>>> +
>>> +    val = readw(info->regs + MCF54415_DAC_CR);
>>> +    val |= MCF54415_DAC_CR_PDN;
>>> +    writew(val, info->regs + MCF54415_DAC_CR);
>>> +}
>>
>> We've recently discussed changing the MMIO accessors on coldfire
>> to behave like all the other ones, which makes readw() and writew()
>> have an implicit byteswap. An additional driver means one more
>> place to change during the conversion. Maybe you can use the
>> new mcf_readw()/mcf_writew() helpers that Greg has started
>> introducing? Those will keep using native big-endian register
>> definitions.
> 
> Yes, please :-)
> Those newly introduced mcf_readX/mcf_writeX are in the for-next branch
> of the m68knommu git tree now, they have not hit mainline yet, hopefully
> in the next merge cycle.
> 
> Somewhat related, I will have patches out for the other affected drivers
> over the next few days.

ack,

sure, will do, also understanding properly the thing, since was out from m68k
for some time.> 
> Regards
> Greg
> 
thanks,
regards,
angelo> 



