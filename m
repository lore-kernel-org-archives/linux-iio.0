Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BE93A59BC
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616186; cv=none; b=asZLtgIApQUr3mdqeD0jUfxJGyiQOavgWUatfHVg9yO3/Kxj19rTwIufoPL1NRkYMx0GZe9xb5x6N1yk/JM+D1forCC0CDC6RwSW07Sarr2mnjBdEp6wG9kU0FdHV2jGhtBTyeveyKfl1i5uXXnB8DNMrUGg9LK72i6AXuw+MR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616186; c=relaxed/simple;
	bh=y8Y7QAcPr16lrU60VtqcD8/BXn/lr6VALKm3ss5QBSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzw3BypRJs6eRHlwrSP1u5v4ab5FpuCdB8divEtks/OxkRMOaThZ+hksx9BLplgxxgbh8LkxMkAjVy5fvNvfqYclWhw+uzcWDltcgnFIyWLmbU1jIg/5x1BKPyd/4apGBahkRwXm+RlIWg+OeZvIyxxYwsBKo+FO93rW+l9PP1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=E8OmaWn2; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="E8OmaWn2"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d1872504cbso5452196a34.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778616183; x=1779220983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZhYXroNL93BmY8U8wCRELS3jGajq5aeu0CEhns52as=;
        b=E8OmaWn2OzwaYvdXFp2lWQYdoEK/DenmdZ5jNQlyvNqG2FUKoCgIvZnodjgo0d3E6T
         r4OJ2P0DC5VCzTs+LJRFG4iWoEDNEBUQ+Sk41cVweoY6Ifj0NwClCmkGgUmcGcmk3TNK
         1+x0hcMO6MklSDMiAahktSDHb915+PksYbwz+qe9SyHVUst6Kih7VOx2CtcqEMKEvGYI
         eldJO+6dq0haMj3e4QkSVmYGNcM22RzM491ippK4cWKcN7IB4E/chafyAsTUFoQZKeCD
         0X0N20m3o7ZlLHv7SvxpAwtbaeU6SK75b7Ag7NeuKCihit/nJHT0XjEcV2D0ZE4x5Vhk
         QhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778616183; x=1779220983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kZhYXroNL93BmY8U8wCRELS3jGajq5aeu0CEhns52as=;
        b=Jp4gndKU82sXfBgmlpzd3w1xfhHHJ1kIklPlJpEVDZG06F2o5DmtDdbLXpRD68wvkK
         arpYD4CWA6VLisXBrIyqo6VucSfEUxlsTmUuBFZ3L/d26u1tHsMJrTEvdSGXBPqXAMVg
         5XuevfOERtySO9JjpFjk6vFfByGmjborcxVnLRiP6hJnlMrj+sq+JO9+Gj/6dkOU4VIS
         T5lTODR1wJfhiJvMnlTLFITI/TaiB4U4j6Nymnkbn1CQtwHPN7EOr73YI6zAIQ8BlA9B
         S2DaLnldVAeh7rc1TPCCQkuwSmPD/f1YJfbVQVZl2uoP/Dlg6bq+WQhthy/mR5RRnd3b
         thzQ==
X-Forwarded-Encrypted: i=1; AFNElJ99qdOc7p6mAY8TBBXxsYyIgrZrlsLpmzD1nub26SMBzo/6tZI4Tmn//pbXCkY9h1hj4SnCkWYFJrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmV8dXH7UrOgOIUfVQ3gS6pdoFObNGWt9P4dLrT27UrWGkKmK
	p6ne5KCjd2zWKEFN1WqMywvHu27B3aiMWKGhfjXZ5zS5uNh7xYpfpuPGaBDQ5/5ioH0=
X-Gm-Gg: Acq92OHPGjQWYenh94DyHmfSZhb3Cspxu0+NibWARMfbbFwL/8SWtYmFVSJCispYPHC
	GzYXHG+dX043rysfIM/xzRcfBksyJztS1fiXyFUSF///wUfMW7m23HybcuYtSeWE0cHceEOEOEI
	3BhV++9cWiH0e1zo4no4CjbqohEMM9RYIojWzXu3gsqNd25BXjlRvhsK56OlusialhcdpPLf4+/
	fGStl+TN0kDjzmu/HUMMSVP6zWuEQtP3E8xl4bbYszaMoFVdNYtwwKcEyMW0C5bOGPH7qeIpBdT
	YtYM1eVzFIdSxHQZZyQIaJJTFEF5kBz1T0q0bBmx3h0rk/fwfT5TgLJw5xsJy/BWQuIm99ZDyXi
	QWA2cDLNa+MFoWB9AViRbsOtm9bG2LZ47aYKDlbiPyFqxowhwRPxu5j6TVfZUYi3ZgyEGsuHZ3K
	T7qyH6nTretKE3h/m6Tlkuc+hjXGE68UDBoEuPRzUQJj9SEjS9jRZQzbRnDvy7wEuP0XvkwS22Z
	w==
X-Received: by 2002:a05:6830:350a:b0:7dc:e78b:158 with SMTP id 46e09a7af769-7e3d87a6729mr310526a34.4.1778616183074;
        Tue, 12 May 2026 13:03:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:baa4:f7fb:528a:2457? ([2600:8803:e7e4:500:baa4:f7fb:528a:2457])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367df2fc5sm9557334a34.25.2026.05.12.13.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 13:03:02 -0700 (PDT)
Message-ID: <5a02550a-a578-4c0b-a8b0-2056f0248478@baylibre.com>
Date: Tue, 12 May 2026 15:03:01 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: iio: adc: Convert xilinx-xadc bindings to
 YAML schema
To: Rob Herring <robh@kernel.org>, Pramod Maurya <pramod.nexgen@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260510083219.70224-1-pramod.nexgen@gmail.com>
 <20260510120141.118057-1-pramod.nexgen@gmail.com>
 <20260511171554.6541042b@jic23-huawei>
 <7baf9ca5-50ff-4131-995b-70ee094ed247@baylibre.com>
 <CAL_JsqLxtWLR+jxRXt7Uz6dcF-90NYmfyGWYQk9um9TYHSWbTw@mail.gmail.com>
 <a4ecfb27-5ef4-4682-b87c-24917f81b4f0@baylibre.com>
 <CAL_JsqKP-C-rA6_19vtMzevVxQiD7bH=k5ObEZZDM3-Zmr_vtg@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAL_JsqKP-C-rA6_19vtMzevVxQiD7bH=k5ObEZZDM3-Zmr_vtg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/12/26 2:42 PM, Rob Herring wrote:
> On Tue, May 12, 2026 at 8:58 AM David Lechner <dlechner@baylibre.com> wrote:
>>
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
>>>>>>   - xlnx,zynq-xadc-1.00.a (ZYNQ hardmacro)
>>>>>>   - xlnx,axi-xadc-1.00.a  (AXI softmacro)
>>>>>>   - xlnx,system-management-wiz-1.3 (UltraScale System Management Wizard)
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
> I'm absolutely not suggesting changing the node name.
> 
> The common schemas globally disallow commas in nodenames. We can relax
> that and allow commas in any nodename. That check is largely from
> QCom's amazingly consistent use of 'qcom' prefix in nodenames. We've
> finally beat that practice out of them. So maybe it's not needed
> anymore.
> 
> The other approach is to exclude this nodename and any other we have
> to keep. I don't like dtschema having to know about some random name,
> but we already have that in a few cases and I don't expect that list
> to be too long given this is the first case we've seen.
> 
> Rob

Got it. So when I said "fix the bot" earlier, I should have said
"fix dtschema". We went through this before with adi,channels, but
I didn't remember exactly what you did.

I created a pull request for dt-schema [1] for this since it was
easier than trying to explain it for someone else to do.

[1]: https://github.com/devicetree-org/dt-schema/pull/195



