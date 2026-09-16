Received: from mta0.migadu.com (out-154.mta0.migadu.com [91.218.175.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006E03BCD3D
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789536388; cv=none; b=NaD9CSiREE0Ech3IOwes8XtByxFyzHVN4Miz7y++JivO+m43nVF0b+szXmyM5ofoNARYsCIkMcSF0qb/FtxBGTNfuc+g75pdQOLCFinzAzsN8GjHOkRSXdutR+2lCEznAWoH6snfJ35arRn4bsIYVHcCs6SnPTTIdV2kl7rLE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789536388; c=relaxed/simple;
	bh=nX59McT1tSV4udr0cFvFpmaLCOFZkJiL5qt7ZC90zG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gcMFRA1ih5zBYkQ9Cr29Sk1skX8CZZrmlGOPXh3Eug/w2H1T3G26fChgKw66bh9RecCUZRR6eeORcV7340lcryZN72d/0LXS6uNA8mqpxCv8J7JGL3k0RyvwUxuHbRBEMfTIYZGDFpU89LwuHLLIxmCHlu4d4Vrh/ebZiktH0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jOVtXpGM; arc=none smtp.client-ip=91.218.175.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jOVtXpGM"
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nX59McT1tSV4udr0cFvFpmaLCOFZkJiL5qt7ZC90zG4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789536384; v=1; x=1790141184;
 b=jOVtXpGM9SOEhrY1n47AM+T/7DAWy8/TF2kYL/Y5BsyIh53QKgXNrQz5iHIAFDI57jvEqO9B
 CNACyfYiafcDRvBaC9NVvjAY2HoumsX8TbU1Bg7kk5xrcMcJU+MpFeUW7Eb29V43+LDmYZISexz
 QimUzi3Oj60z/qPfSdXxeGJA=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e60f27ed6bc2f662;
	Wed, 16 Sep 2026 05:26:23 +0000
X-Mizu-Trace-ID: e60f27ed6bc2f662
X-Migadu-Flow: FLOW_OUT
Message-ID: <ed05f764-2be6-44a7-a13b-795954d8eb35@linux.dev>
Date: Wed, 16 Sep 2026 08:26:21 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: mazziesaccount@gmail.com
Subject: Re: [PATCH 07/12] iio: pressure: rohm-bm1390: Fix AVE_NUM
 initialization
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
 Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
 =?UTF-8?Q?Topi_Sonkaj=C3=A4rvi?= <sonkajarvi@hotmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
 <7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
 <anovRGxtsyJZ8cO9@ashevche-desk.local>
 <247b0e35-f49e-4bec-abd4-4a2c3dd49a2d@gmail.com>
 <anr0jtvYorFKaEXY@ashevche-desk.local> <20260817021549.29522111@jic23-huawei>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <matti.vaittinen@linux.dev>
In-Reply-To: <20260817021549.29522111@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/08/2026 04:15, Jonathan Cameron wrote:
> On Tue, 11 Aug 2026 13:08:14 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
>> On Tue, Aug 11, 2026 at 12:05:47PM +0300, Matti Vaittinen wrote:
>>> On 10/08/2026 23:06, Andy Shevchenko wrote:
>>>> On Mon, Aug 10, 2026 at 10:53:07AM +0300, Matti Vaittinen wrote:
>>
>> ...
>>
>>>>> Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.
>>>>
>>>> Can it be FIELD_PREP_CONST()?
>>>
>>> Can you please elaborate why it should in this case?
>>
>> I'm not sure why it's not obvious, but the parameters are constants, why would
>> we need an additional check or even checks?
>>
> Hmm.  I went and had a look as this macro turns up a fair bit.
> I'm fairly sure in the case of a pair of compile time constants
> FIELD_PREP() both performs additional checks at compile time and
> probably collapses to a constant.
> The docs for FIELD_PREP_CONST() observe it is for when
> you need it to be a constant rather than when it might be
> (even if you know it is)
> 
> So I think it's not necessarily appropriate here.

Thanks for digging deeper into this. :) Sounds like you confirm what I 
understood from the docs.

Yours,
   -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
