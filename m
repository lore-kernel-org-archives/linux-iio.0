Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794997923;
	b=Pp1x9fO+FZDlHE775feHPfxuue+2/IDPsjavQHCyGEKl/Poj1i8fQjsoifiyT4AwNYK2
	 l/L9lP7w6BzzqHYyvxjKuf256pYuARQ0f911NAriTI5U4IrUixDPaiRgjgMRtU9B7bBKI
	 JJ9S+nGeMycK+twJsm8SC5C0bXpBMoYOduPj1763RXFWvgiG3o+pQsv82ZAv7/AJIu3S5
	 eDaKGcRPQWIEerdfU9SjOJStfoTRd02cTf7QMzyC5z3F9NDVyfhDqX6322HGjTs03vFAn
	 s2/jTLwit0rijum+zsZnpfOwKj8Qtc3yrmDV6UiQzja0nx0e3s73rPJa2NandOfwQBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794997923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=zp8KDvfQnedhc5dWWrFnI8zt16YP/phqo55Fqv1pHj8=;
	b=xAAMDnoH2XdaYzqNiZQKF8MnBInMUNxv7iPIDUf1AXw+fTM0mBBCs5P5tHx9v7eSmx8f
	 8z0pIEOD8S83LIFQ27uIMefGnHPVCQy3aPc8HtxiVlCZtmc/P42G61/w52ww/7dg63u7A
	 ZXT94t3jxN5rFe1t5V/hwPdK+KEbSAvukp0+jiSmM1qoPS0wbcqQi9jix5/Ix8Xa4eaec
	 CgYX+6WCrRdBXkcHpHQKhAsl8LuFPLYdNnppF4Vih3aGx0KiOAChR3whrgraZOyDriU5Z
	 rc2yViR5YqPHQK10UApB62gkn3mXPZTu1JKcGtL+3koCHGHwiDggQkgEYraDcCE60Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sIAmVEWX;
	arc=none smtp.remote-ip=209.85.167.52
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0A60A261B
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 10:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F0A60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sIAmVEWX
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso913652e87.3
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 02:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794997921; x=1795602721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zp8KDvfQnedhc5dWWrFnI8zt16YP/phqo55Fqv1pHj8=;
        b=sIAmVEWXig+xreMoQRKV26QS1AdelvXoSpodOL8/hIhZw3yXevIgOofeE82qc45x9V
         gb0+TeVEbMp5qUfLvsRH91VnVe9lmEnEWia8Jf5bE+3Sicn4ymkTybOBHPsS5EMOMRLB
         yYvDBfz0+ZOe4f0xgAshhx/RIsOCf2LidpM66yiq+ONm8N6l2BgvceOGmmv4WvWH1OJq
         GT0lPQbSZ1Np6B9gCKXgpSpJgaOpDK1I8+iNQrRDCPW/3K73CJ5MVjOV7EWRsVFpMfIZ
         yfRCk4Z4fGUmjx6pVG6/HPRnikQxXMLX6Wd2Z95ArP+LbXVOeIIq5bzA147dEKw/ZlK0
         numA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794997921; x=1795602721;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zp8KDvfQnedhc5dWWrFnI8zt16YP/phqo55Fqv1pHj8=;
        b=FQV5BLr+w3GX7+Qa/0tAZ+RRN3C2fQkJCP0XZMaCqc6R9bXj5tH2cvPckrTbOEXzeW
         Rl2ulWQ+5ps2N6pqZzskZFRjrTI2G/XngWIOOw9MXbe+rwdcWu80ahLMuwGSkGHs/EGS
         KRXJkwKmGRKgrj33Cy03q1WsHhw4tl/XP2xN2b3mpJODyPSSloNtAscQ8zpABcZjwtNP
         +PvHwly4dgFfeq+UhoazR5OpSi2Neqm5xcWYiK6DnfqqYd4nbodn+aI+0Qlngnscmvu5
         9ICnuqJPrB+oJhIEO/Mzpy/S2WCEagAYXvi2dlTDLbWc9PnFlFRNMeKvNHsVC33Y4nmk
         leQA==
X-Forwarded-Encrypted: i=1; AL+hErGnde/nlyPHs3FETcohkWjklLLnrDknavTMa+X3A+5gocltHECStUQdW5/AsbjGiDeJS1IneJlOPJk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Vt04T1q+abc+Ek/FIESzNlHlnJBToW6VwHpej/+UcksvDjgX1
	CaaAdQ+wHBVKOTTqTmUiXnlD1/GsJm140uGvbHYm1tNv1iTF/kYnqM3g
X-Gm-Gg: AYBFou07fofsja2GzTxwHlsGLhpL8xSP6sObkFjXobjG1yxgNI9138pchPD2Tfhx149
	QmYNTFKiirQKGlHGu9gdMa8twMDvcdgfjJ7dhIGWPOGZeB74w8QmyvLiHr0QoONluGEHTE1NIEB
	1PiZUSWkU/Bg6apB2Cjc45gskG8tzKnYaYFiOxC8m6KjLVBhSuRMoeJpmj/o6/av5/1iipRqyZO
	xzjOXsXj7O9m1sUxZ60BdO8ogODZo74mj5wUkSnXzvh4XcR/yMcmUzmoLlwcYWUgz1cIjaSDCxs
	sCkv7qIruf+8SV0whgaP1cHFQHT7i9PNJZTOlItNOJLTsAYHeIPDqVymucHApeIft8DzwtRCggP
	oBJE357+UB2VZBmfh6/5HEncQ1qqLMkteQRisY3NRjautE+yKxK7d/1Uy2t7MVL5sX5E4edymcw
	BGWC1Cn9D1qSiyRYnC6SfSUXXIMq9iVO5nmOUJ5L3maWnb2P19otE8qWTLzZQ80RdBeCuw8j7YV
	OJX3w1Dp0V/yA8k6xzp9dcd9Y1V6eQCV72t5fQBn4ianWsnKDjDm87zTGOXjzqQTbHHIAWy5qaY
	URQOyq1achr3V4g1WSIGxidZdl1IGuYGzETQIoqlHd9+iueJfHRekLNMZNCBhDeR283EQLZ+Tk3
	uNpPcYX9gvg==
X-Received: by 2002:a05:6512:1596:b0:5bf:b144:fcbb with SMTP id 2adb3069b0e04-5c1aa067108mr678419e87.28.1794997921160;
        Wed, 18 Nov 2026 02:32:01 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1aa77e5ebsm420005e87.46.2026.11.18.02.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 02:32:00 -0800 (PST)
Message-ID: <820865f9-2ef5-4316-abbe-5c44c7df55ce@gmail.com>
Date: Wed, 18 Nov 2026 12:31:59 +0200
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
Subject: Re: [PATCH v2] iio: light: bh1745: fix 16-bit register accesses
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
 Mudit Sharma <muditsharma.info@gmail.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261117110327.198084-1-kapoorarnav43@gmail.com>
 <avxi4BBJ_Ztg-aN7@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <avxi4BBJ_Ztg-aN7@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/11/2026 16:21, Andy Shevchenko wrote:
> + Cc: Matti (even he is not listed as maintainer) for possible another pair of
> eyes and/or having an answer why this was missed at the time of the driver
> submission (from my perspective this patch is correct).

Thanks for the heads-up Andy. Unfortunately, I have never worked with 
this IC, and I don't think we have it in the ROHM Finland office (but 
I'll check this just in case. It'd be nice to have this covered in my 
test setup).

What comes to missing this in reviews... Well, I suppose the reviewers 
are just humans, or if they're not, then they might have concentrated on 
other important things, like styling, instead of the real functionality.

On my own behalf, I was away for 1.5 months when the series was applied, 
and I only looked at the GTS-helpers usage when I did my shallow and 
badly belated review. (Furthermore, I am 100% human, so I might have 
just missed this even if I had all the time in the world to do the review).

Yours,
     -- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
