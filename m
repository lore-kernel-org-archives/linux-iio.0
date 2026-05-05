Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9331878C9C;
	Tue,  5 May 2026 02:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946821; cv=none; b=UfzAH43s52juTRKj+E5j9uK5phnjEpS+mSy7m/s97zk4EcCrO0+pEvycfNnz61s5o4Gtz7I4cRF2S8/HzE5gMLfxRCVe4acI4aXX21BdOiH2VkH0b2fyOfXcVyY93/aGMkO1RQ0+XAAZp0lcDdqKWgbbcgdArYGpJ5uc3tZRX2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946821; c=relaxed/simple;
	bh=doEKF7GKqDJ3ZWwDJXbPBEQvJsPRYlYCLUPfxcCSqBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/4CJF2vWpsaThettP43mHAJBB4pdWh5cKcs52e47NNkK6yBEWJO6mPFSngHYgZalgD1UPCN5g7+AFePV3BHBPiNJhFSlflc9DMI6SUOARM0JM2v2xfQO+5UeygDbeE+MK4QtaSmM6s9p8F2jw7BzVlYkB2UZBi4E00Cug6f7FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BC5C2BCB8;
	Tue,  5 May 2026 02:06:57 +0000 (UTC)
Message-ID: <31297e73-52a5-42a0-9676-ecf057f7c21e@linux-m68k.org>
Date: Tue, 5 May 2026 12:06:54 +1000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] iio: dac: add mcf54415 DAC
To: Arnd Bergmann <arnd@arndb.de>, Angelo Dureghello
 <angelo@kernel-space.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Steven King <sfking@fdwdc.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
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
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <965cb599-37ac-4d69-a8c0-015152037139@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/5/26 03:27, Arnd Bergmann wrote:
> On Mon, May 4, 2026, at 19:16, Angelo Dureghello wrote:
> 
>> +static void mcf54415_dac_exit(void *data)
>> +{
>> +	struct mcf54415_dac *info = data;
>> +	int val;
>> +
>> +	val = readw(info->regs + MCF54415_DAC_CR);
>> +	val |= MCF54415_DAC_CR_PDN;
>> +	writew(val, info->regs + MCF54415_DAC_CR);
>> +}
> 
> We've recently discussed changing the MMIO accessors on coldfire
> to behave like all the other ones, which makes readw() and writew()
> have an implicit byteswap. An additional driver means one more
> place to change during the conversion. Maybe you can use the
> new mcf_readw()/mcf_writew() helpers that Greg has started
> introducing? Those will keep using native big-endian register
> definitions.

Yes, please :-)
Those newly introduced mcf_readX/mcf_writeX are in the for-next branch
of the m68knommu git tree now, they have not hit mainline yet, hopefully
in the next merge cycle.

Somewhat related, I will have patches out for the other affected drivers
over the next few days.

Regards
Greg


