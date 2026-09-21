Received: from mail-oo2-f6.google.com (mail-oo2-f6.google.com [74.125.231.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC56247280
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789950136; cv=none; b=MRdxb3dCUCuDMGqyFk2miPKZdGPTZUPxXFKXT/WAXcb0Px7+ewNL/QbIUjym6p4LiMuU324QOGL18SVqi9MR6PQw/wFPgiW3bOTGAMXvc37mJTInZLvQLQZ1jbadYVJqrJqqn8J8xF25OJVxTluhegdULf2mcBMx96Dka6P6L88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789950136; c=relaxed/simple;
	bh=XwsRzJLQL722rDOxKBtIkGBU0anBu6ItURQT6kz124Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gFPB4shLkA8RNb51lXJbLDErJO6ujrDR1sSMGlMgMvdvp3tAEaRsmcnaqlPVoZwAkWnpm1K5YNITEetoJ9K6KGlWA8pCFcaawXzUTTK1rAFM5DPgLvo9X7Rvp1Ra8MJLaAe0wSeNbGKIbkCYnC9cEMfigHqSMpkQH3uPvDFLLXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRx7OgU8; arc=none smtp.client-ip=74.125.231.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRx7OgU8"
Received: by mail-oo2-f6.google.com with SMTP id 006d021491bc7-6aafac56856so1182974eaf.1
        for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 17:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789950134; x=1790554934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bMAwtCxGCGY6D0JArwPVVoRyTsw+poPi/tmNRvMJqUI=;
        b=gRx7OgU8bDTs8tAAAJaQuWCc8DHTk1qHRi4qoJhKM9zAUf7iI5BCIPH6u6cwph9sfl
         zVnIdfFp6zqFTiCVRFUz4Gp+3jX+i65MxWyxLrMfOogNTrWCBhJQVZvloXOoVchLRrnv
         sb5N0lONhD+Lf5xDUDhTQl9Ybq8C1dEGtxCOYsUxi6lLAs7WYqsCBNIDyjEFogpJL5j5
         kPJOiFoksMl28E7DqlFwz6rSrxsNcO+TCXDQNpyZ2T1cE1gCd7xFd1/4T9GcJNt1/Muh
         FQqiMHwIV/3CrDN9HuP7DqsQl7FtXmiUL89kQ2XadcjIrYM45JwyWgPmaNrzd2GYOBuy
         5VTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789950134; x=1790554934;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bMAwtCxGCGY6D0JArwPVVoRyTsw+poPi/tmNRvMJqUI=;
        b=OB3BgL65RbKJ27z4SWFjJLlijYj0ytQZSeClPgjMDEbIP7oNWC4qwCbbvHW5lqyer2
         5W6yIyQ33aiOFT01SY6xJOMwt82dUxBqi4RCLra7jf6EqwI8ctGqG11+/UkR1icC+iGl
         crXfMLw4Qcm0d1RmnNltsqKH/YrjKOjNWEPhm8QCy7vEGwE0dE7M+Sz5DkASZuqD02RD
         3JC/6vSda4zswm5E+2GUGRyKzOAaBove/7s6tTX4VX5XwDACOBSZ5FD9d4Mz8+dx+Uk9
         t/UkS0cvgL4Ivmi0hZShw7/FP2oVnr2obZQwSIdvmB3uVM0VBeXOPZcGEi24uuVnVIQq
         mSrg==
X-Forwarded-Encrypted: i=1; AKwUvBwHP9E4caDd5wgbT0Je/8O4J77WbULLwOwOMTlKOHlUsmS+dbdtgYXR94aKwCk/Do9JyvDZU+KXSo0=@vger.kernel.org
X-Gm-Message-State: AFuF++mZc+e84iWlL4dIU7laV4Zn5ZpDtw2T3LLSk5mAQk5lxuO0QYPB
	NyQxXLr6yAhk9lwa2VkZRLi6ODNQL8N1GaCkL9LU9gvjQIZkRNzrMx58
X-Gm-Gg: AYBFou2NRuNJU4nSBshBwPYfF0hVe0maZt7NmVFXmLn94yZlWNQagAeVzB/V47eia0M
	g/bt+Z1oy5C0C1YVLXDYuXI6lRqhtnWVir+QGq5wWOYnAO2GNqG4Wbr2OqvHMkATpozXhZt+Rvn
	GLvzgxC/ZPbOmOo6t/2lA8xffE22I8adXNwoFfFCrC9B9VHo+1N29bV/AX7JKJY05o9GnkRIk54
	uBD3Yw1KRbutQbBwviA6CsPePvwEVuqWrNWd9px/gsPdMrZI84wStZuqiACOjHAXjl66dOuiQg0
	PpTucKv6CsTwzk/6L4o5/GHteKUtgI9CPooIe+qXYOK1lEyIpe/du7Pijp/UXO4zubsj5UUgEqt
	Exg8TmIUjKAYat22Y8xM+/yQ0Nzpq5meNjCOyaQs5jcoELGVkvkUtTG3bQh6PxPl5PctxocyDpQ
	Rsg1d89PK4b4YxS2RA6d2ahH7eujRF5d5CMJCMK8XRBlw5K/AviP4bm7JUjcY2daEvcN11TnGqv
	WWVpUvteU5wCoc=
X-Received: by 2002:a05:6820:1f04:b0:6c2:1018:3f7 with SMTP id 006d021491bc7-6ca9aa4245emr7824820eaf.23.1789950133885;
        Sun, 20 Sep 2026 17:22:13 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::2620? ([2600:8804:5716:d800::2620])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6cd34b3101esm7471632eaf.6.2026.09.20.17.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 17:22:12 -0700 (PDT)
Message-ID: <41503126-2f2b-4ac9-bb9a-610686be4729@gmail.com>
Date: Sun, 20 Sep 2026 19:22:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] iio: adc: add mt6397 PMIC AUXADC support
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 mfd@lists.linux.dev, Roman Vivchar <rva333@protonmail.com>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com>
 <20260921001702.3a208780@jic23-hlaptop>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20260921001702.3a208780@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/26 6:17 PM, Jonathan Cameron wrote:
> On Sun, 20 Sep 2026 00:31:50 -0500
> Ryan Brue <ryanbrue.dev@gmail.com> wrote:
>
>> The MediaTek mt6397 PMIC has a 10-bit AUXADC that nothing in-tree can
>> reach. On boards built around it that ADC is the only path to the battery:
>> the SoC's AUXADC is wired to board thermistors, and the charger ICs these
>> boards use have no ADC at all, so without it there is no pack voltage and
>> no state of charge.
> Hi Ryan,
>
> Please slow down between new versions.  Unless a maintainer is specifically
> asking for a quick turn around (sometimes happen very late in a series) at
> least a week is typical time to allow multiple reviews to come in
> and hence save on effort all round.
>
> Jonathan
Hi Jonathan,

Got it, thanks for being patient with me while I'm learning the kernel 
workflow. I'm sure you guys get a lot of newcomers not knowing the ins 
and outs. Won't happen again.

Best regards,
Ryan Brue
