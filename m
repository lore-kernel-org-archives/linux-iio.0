Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD62397329
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778595391; cv=none; b=AgQYklDSnviNo+fvmqKWd6rSKruLT+R379KyW5iY5Zajie6+IZN5TPAZ2sk9wA9hE9wLcU+VmZDFGMTMq+BJs0UN1tu7CEvq9Dlgur/oyPBoapSk9rgZvf5rDRXAqS6f+a46PXus1xi7o/fTGScg70yzNHrL2A3AjiX1lR4KzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778595391; c=relaxed/simple;
	bh=9NBEmG70iWMYLecaqNGIPt2lgBXrdrcVzgzjJXy0UxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skxIcdcA2Nv0qRJAVyPVdPqtmpjird9k7P9tD3gYJh9WxWDBVIV/HdQ7FiwqvJcbHuOiaeWENS6v2LrR70zcFT0MQZgW6fUwWF5c5Z1apsLnlY2p6R01qKbsDqRXD6wb+nOKV96ES9SIZfIWFzKExkzlgSLF+dwKZhg9j6xI+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=tDDL9DWc; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="tDDL9DWc"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-694891f8f75so3082163eaf.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 07:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778595388; x=1779200188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oQnrgdg1gVahQ/5LxpQYUhIfSAqiqplYWW6YUhu5COw=;
        b=tDDL9DWceLuRiFDlZYmefWkd0VJIDEuX1icrUn7NPpkImG00kTdM11z4I0CdhsKAnS
         V/by/uLh3LTGcXpN/mSuTfpszIyxR9ZPAlJe1BiNvxRcK4jcVM6tXA9c0dGD1jvtqCtW
         PAtzWb6aIpx7my9z4nCYJBve3eUe44T06K1dKu/Do8FmxfXA+++w51YfDcVBk6m6ogf8
         lkgXuaPRYg690sxsVocNteSSfHCJYflA6mr7trs7w7QFlKVqbGLuGJcweIJmDJv55+EF
         tNiwCnX1mpqh+n8zwU8lWed0LBRK0G6iSZtQaV+VZf+lYVhhujMV+PvA7XFCm1qY4PwU
         Z8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778595388; x=1779200188;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQnrgdg1gVahQ/5LxpQYUhIfSAqiqplYWW6YUhu5COw=;
        b=EPnsHEU61hjA7fNFqMdAn/ema/HaURnWnNc1EZiVozbZlXgVqBFhgEVwRr65orfzc3
         9EBMMwpqqJbOHKVy+vYbrQFeBod/ZTrzBiQxYbjQcQ0/Ca7cEg3B4AGf9XtEtUa8wM/V
         7thLXNnlGW54HSRuAaxKectiMWn04nd8o4GuwAqE4NV4YLI8SM50LHWIZHQvkIG67J11
         46iFEzvrqxNCxqni4lOJZm483atk7ewhHOiQ9iQKz/5yOMQOE/gWfbh+0xceqVbe/k1s
         BkPvpfUt5s6K3Y/v/cmI/a1qxOzOcNzptbTZLJpG/nz+OpWSmN73soePIqLPOfmjlyJM
         FVSA==
X-Forwarded-Encrypted: i=1; AFNElJ/kjehiVxQobHj3y6hOmILJUyESW+lkTVZYccqrtNqFtmvxhlpmdcz+slM6tQmQI5P5Z3BXrYuAXos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4h/Gaslqphj+g8pViTL0zTJRi5q+6AL3WCksGUp0v7C2XMYRO
	TNj7+uwbWQwPJEXRZcxpAtSfQboGyO315SB4y/62Okr4w+fb37BVakPczsxF99rKxXY=
X-Gm-Gg: Acq92OFkAgeDlI4hDAkzs1jrOoDzE6KlN+J8wyWF7s1qzeqGUOL2e+kka3Gusx1kjul
	6GNF7cbIx6N0rlzAwEMbbED8aOr+dazMYqKcclxINutH8J8dg+N/JDLG4F1s5kst8v95nyP4O7I
	jj7H/gMRRsP3y/lrxHETyyxmsPnUsN8yb0B57sCHHlefAgfpZp5hn9TriVvgcE7UaG9XWpCvU+F
	fSiIyNqpJlZ/dZsbCuo5SMBcccFH39GLrsx58vZ+WLsRxqVcaXVDkrT84ltSIqOkz2W9618gY8L
	CKtroZhISQUsaiq9e+hGm3tNRoS80gL6aIlAy2/ha8UCzLPfrK8UQZmjtqo6wo/TSq+HvUgQ05s
	ZxXTyLQUtZejccYS3OFF9/n5PWyVBMWoV7JUMFVq3ay63dCnuAh2BSeqbSmal1J5P+I1ve5o2pZ
	9IlWPXJaNp7eE46B2zX65v/gq69Xp8uEkDCWy2T7jSwmx1WPZgicraCi1Vbc4s/MFmK6S0l99Sj
	2GnOsDItDH4
X-Received: by 2002:a05:6820:a0d:b0:696:6c93:e81f with SMTP id 006d021491bc7-69998cfdb44mr16111351eaf.33.1778595388361;
        Tue, 12 May 2026 07:16:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:baa4:f7fb:528a:2457? ([2600:8803:e7e4:500:baa4:f7fb:528a:2457])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25e0d124sm7192765eaf.12.2026.05.12.07.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 07:16:27 -0700 (PDT)
Message-ID: <db7fc677-56bb-4421-969d-6116a0a57d77@baylibre.com>
Date: Tue, 12 May 2026 09:16:26 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: iio: adc: Convert xilinx-xadc bindings to
 YAML schema
To: Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Pramod Maurya <pramod.nexgen@gmail.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
 <20260510120141.118057-1-pramod.nexgen@gmail.com>
 <20260511171554.6541042b@jic23-huawei>
 <7baf9ca5-50ff-4131-995b-70ee094ed247@baylibre.com>
 <CAL_JsqLxtWLR+jxRXt7Uz6dcF-90NYmfyGWYQk9um9TYHSWbTw@mail.gmail.com>
 <a4ecfb27-5ef4-4682-b87c-24917f81b4f0@baylibre.com>
 <cc26edcf-3218-4294-a522-ffafdaf41070@amd.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <cc26edcf-3218-4294-a522-ffafdaf41070@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/26 9:10 AM, Michal Simek wrote:
> 
> 
> On 5/12/26 15:58, David Lechner wrote:
>> On 5/12/26 7:14 AM, Rob Herring wrote:
>>> On Mon, May 11, 2026 at 11:24 AM David Lechner <dlechner@baylibre.com> wrote:
>>>>
>>>> On 5/11/26 11:15 AM, Jonathan Cameron wrote:
>>>>> On Sun, 10 May 2026 08:01:36 -0400
>>>>> Pramod Maurya <pramod.nexgen@gmail.com> wrote:
>>>>>
>>>>>> Convert the Xilinx XADC and UltraScale System Monitor device tree binding
>>>>>> from the legacy plain-text format to a YAML schema, enabling automated
>>>>>> validation with dt-schema.
>>>>>>
>>>>>> The new binding covers the same hardware and compatible strings:
>>>>>>    - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
>>>>>>    - xlnx,axi-xadc-1.00.a  (AXI softmacro)
>>>>>>    - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
>>>>>>
>>>>>> Signed-off-by: Pramod Maurya <pramod.nexgen@gmail.com>
>>>>> Hi Pramod,
>>>>>
>>>>> Something went wrong with your sending of v3. I have two versions sent
>>>>> half a day apart and no idea how they are related.
>>>>>
>>>>> Anyhow one of them got feedback from Rob's bot so I'll assume we are
>>>>> getting a v4 and wait for that.
>>>>>
>>>>> Jonathan
>>>>
>>>> I think Rob will have to fix the bot to make an exception for the
>>>> legacy bindings. This should have been called out in the commit message
>>>> as requested in a previous revision.
>>>
>>> The bot is not the problem. It just runs validation. The schemas will
>>> have to either drop this check (comma's in nodenames) or exclude just
>>> this property.
>>>
>>>
>>> Rob
>>
>> Even though this is an existing text-based schema that has been around
>> for 12 years with this name already? Changing it could be a breaking
>> change to existing users. Although there aren't any in any .dts in the
>> kernel source.
> 
> Zynq has it described.
> arch/arm/boot/dts/xilinx/zynq-7000.dtsi:111:                       compatible = "xlnx,zynq-xadc-1.00.a";
> 
> And make no sense to describe programmable logic which are that other two.
> 
> Thanks,
> Michal

The issue is with the xlnx,channels property name. Searching only shows
this in the driver and in the examples in the bindings .txt file.

