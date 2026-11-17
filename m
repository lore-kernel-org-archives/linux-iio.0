Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936924;
	b=A1MEjGODrMXczPxYkXDt2EBBA1mULn98CQXu1YPW+aipcyln1Zc1oHldGEhUr3qpAS6c
	 LLjAms/+k04u3YRuriDsVD1seAKigzUKtGsnGzaMLKJfDI/4VOy6VHSMbeL4Cy2qxfDZ/
	 idsAmidoZoyksMTFvh4YVNvpxy87JKnBlgsLgPHJ8B0m5fs876YpJhE8wgN1Xi+coW3AK
	 gDaaOYXv8PkGuamHb2J5KkljOcxYp7kUDgBkMt5OHCm0AQ5nGfRf0NZ75P96+AsGD/U8m
	 mZQDYzfF2IgxaaRpxHoYW69nMt7MVitgrop1zuK7ZdWwOd9FnAmWLKoSRdatwXkPxdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=kaDKA5hattAHds8mPaKS6kzZBkSpzp9jS+jIHno12Zk=;
	b=SFrOeDipJ7KMzkWd/ZHnfVxPOJdXxOzvyk86pJqdLRIxxcRXigKS1qQ6FK1naEBkksYQ
	 IjSZLxTus257Zv9R/THHs/Gb4sSoSoCpSud+hGBnf3vgcUm6Fg7Ugybsxr9u9U+d6RhgL
	 Lw/tPvxSce0WQB4QIBbXDKLOurkFY7hSExH64Uu6vlTzyCPpz2jmgp6xLi/FnFTVtdLQo
	 4xEirD09e5d2Gp7blTNg7RUhZsfcbh9Eq9p6nBsJoYCYBo93DfV2fsa8H8t330PxHm1fz
	 xZpk+SZpkFbI6kQrm2lj2mR6Vom+8kVvEL5ddZnLJmweRbWym6lEsmuiLLsq/Fw77pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NYwZY+rj;
	arc=none smtp.remote-ip=74.125.231.131
Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCDA606A89C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 17:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFCDA606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NYwZY+rj
Received: by mail-oo2-f3.google.com with SMTP id 46e09a7af769-8459f7bc7c0so505a34.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936922; x=1795541722; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kaDKA5hattAHds8mPaKS6kzZBkSpzp9jS+jIHno12Zk=;
        b=NYwZY+rjroQjkCW+S+pwjlaO1RVFDDHzNFUYWfiPpc2ZZOOV+GLWgZS5C4tNtKgcTj
         R7+XKsaXt5IZE3jX+ON0+nMrNozdjYFfqWixuKZONperUFZzoSwB4v3eI02n8a9iyl6d
         clwKBwSDL1EJf9jFrwZM+AUBNcW1GKM98Uleij51X8ZRZRvx9PRTOovTfIWHtMxZHIsI
         ssNA0bcVyUQE9Nr+usc3Gharui1AwC64uf2TGdAVLHQOte88iJkOL+pIQ09CM5oiZJ1D
         e2nBTUhrdkHfhieASi/MxHGdZp6qU2uW8WbDKDwUjJ0mfwYZ/HAdXDMc4D8bUZsBU/6C
         qYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936922; x=1795541722;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kaDKA5hattAHds8mPaKS6kzZBkSpzp9jS+jIHno12Zk=;
        b=URuBeRdFmI21eo49lK9ZesPLHJEwW1sDTC0Oc3caFxqiTrQ6iUaHQtqZQoYrjzlUQI
         LVWCJal7XW+oQ7zxLPuYu/V29HCwb2ltwHhZ96YGtN6kqmedwMDXj6fdpDhOpAOpWK9B
         GzMZVcu4nkZ4jlDDeQI7S9B+CenRE1wGWm0e5OY7hoQ5Qa43ez2HbyDpA4naaSYslesE
         Ig06T2cbTbnzUYU8JtSdnQvI+au272KibhgX3qKEVzkCxYEXBWMA8x3ojqCokyRH4nPF
         AKrkSVy3CNMBdYCZWTRywPICkM48M3OfoCjsWqYunO1zt8E7XzLXT8ikZVRrIPpBd195
         IwsQ==
X-Forwarded-Encrypted: i=1; AL+hErGG6g82hT3T5/mIDWzIgRJBo6opeL4Jkv3Jz2oFhH/F7/4yDyzPwgRBW4ySeEeaVmzleSs1N+C8ZyM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8I/jMqSZQsnrlFDE9UfsgYNNQJ4zhNHI5c0mG/pHbWchtZX/FQ
	HZnGVggOk4bVbuDaltPN/prQayT+atxewDjPKaebEHmIGMnc7nObNMyd
X-Gm-Gg: AYBFou0Po5xqIMaEuC568dfq8RtEK24Y0X6NC6ZqAg1pbRyg2Gbj/Q6z6l/9RMsSGgm
	rdDmX1G2rAPkHDK3mCpnQIkk+zARIgSZJ1kn0KgCv7VdFnw9EfKWJ539pfG2RS8pT91SphBVPmW
	j446FKykufq4Hd3IcTf3x7WIao7JzADWn+BIoJHugwqJz9CCiQzgYooTG8f3yEDqdcJixmOnN4e
	4AyQQ/83a7Dz9CbNm8WQr+F1wJF2mY8dGUuQsCtCfzvQkwIZlzGoljWGZn5VihQFjnK+2Fp8Zri
	oPSNtbHLJj0zbHZ33OS9qSqJ9dcJ1YhBjw8CbnyXR1KWWWLXxly0BSoy48JI0DmZqOOsnFR9Z6K
	tmtGAI85x96Mygkftc/YJux7XUeb/OvVVcB1FG+L24sMdn9I2Xkw0XvN5cLkKLLn7svgobR3Fs1
	bHPyOjmSnTniSEYJJ13SaoaHgpNNVZeFilhIIl0ek2yKsv63Eflt5QyW67FRsoxvs8392p/MOgj
	sG71mUOPJYJpm78uce2GB2rMJW9Yase6XS8HrtDNdjvKoNrbQKd38z/vO8cjBumIadS4VsqXmcV
	g29Ey0AFb0EAtUbiLRKDjTqL4rzfpO8LkNT13tL+JqkFmw==
X-Received: by 2002:a05:6808:1925:b0:55c:888:30ff with SMTP id 5614622812f47-5774240c0a2mr429178b6e.45.1794936922568;
        Tue, 17 Nov 2026 09:35:22 -0800 (PST)
Received: from ?IPV6:2600:8804:5716:d800::d500? ([2600:8804:5716:d800::d500])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b70bfeddffsm190834fac.4.2026.11.17.09.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 09:35:21 -0800 (PST)
Message-ID: <4c64aa52-2b75-427e-8f26-c2ef7fc5b822@gmail.com>
Date: Tue, 17 Nov 2026 11:35:20 -0600
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
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Roman Vivchar <rva333@protonmail.com>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20261025-rbrue-suez-upstreaming-mt6397-auxadc-v5-0-5c3c7a5a1851@gmail.com>
 <89c8cadb-0ccb-4aac-9b95-89f355beb24a@collabora.com>
 <60eeaaf9-57db-4ca7-b4f5-bdec111dcdbb@collabora.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <60eeaaf9-57db-4ca7-b4f5-bdec111dcdbb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Angelo,

On 11/17/26 5:02 AM, AngeloGioacchino Del Regno wrote:
> I reiterate - I couldn't pick the series because, of course, that one 
> depends
> on the binding being merged, otherwise the header won't be there and 
> the build
> fails.
>
> So I can't pick the DTS until the next cycle (granted that this series 
> lands).
>
> Cheers,
> Angelo 

Thanks for the reviews, and for picking the binding and keypad patches.

The AUXADC series has already landed. Jonathan applied it to iio togreg 
on 11-02 (the binding with the header is 8f809aa84698), and it's in 
next-20261116, so it will be in 7.5-rc1 along with your tree.

The board only uses the header once, for MT6397_AUXADC_BAT_TEMP (1). If 
it helps, I can send a v3 of the board patch that uses the plain channel 
number and drops the include - it builds on your v7.4-next/dts64, with 
only the binding warnings you mentioned until the trees meet. I would 
then switch it to the macro after 7.5-rc1.

Just let me know if that sounds reasonable :)

Best Regards,
Ryan Brue
