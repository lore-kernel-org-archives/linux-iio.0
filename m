Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509716;
	b=ohO6bEHXg0NpVH/bXh+RkxC//WgnlhFDnJv95NIwpGJE+1gGdFcP5ynqFJgEtjhzOJWK
	 x/h47p+mw0tJbTQqhg0Y9BqlAdqCCG4piRRbvLXd8v80BfsVnwoid53/ET3D948p2l5Ba
	 wNFV/kjt3DULLkuPiigvtLoHYVHOe+eG8VHcrYiX5g0opbg0Ae6eLznIDHA5tqmcxzzNm
	 QtO+SXM7vJZEDuxGabr8xiE/46T03JFm7xIe1dc1qDhKyQndiA0efXoc29hD7lF+d3xbv
	 hYppfgEFYzHNt1TQjhCgtj4b45vui+cHPEEC8PML52e4S+SkFACjqgesMPslJGY4ctg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509716;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=miq8lHAk9j+ldEOiiht4iRcOG6aLFpZt8I9oVYIzhag=;
	b=36DnAVperJAnWXsOjDm1/nGvWi6Mf0CXwTRL2tU8pLxqPJE71g/Xwn7ulKo5/TcU4JQk
	 rPvrPHLeWXb03IG3G0iOcDC4QREoW5niFXFDmgI9Ik1CuBaicwc3dgklp9Z6n0hwhkSN2
	 RxL72ymCKMg3A3NZE0XNcXM3Iqh2goVTMmF+2HEYX9usgB9CadoKRpemtz6C8udyftvoq
	 gkhbaUMshksPKGdPTBEkYHXeUcvoIuzZCvDzPWim/D237oZR6TAt43IFHw1yuC1GTSWCD
	 hR73140xA3tX22WZdr8p0dFMieBdYiFaUq9DkkbvwC8Xs0WscPOgPg/i37srD7JDo0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EpuxjjND;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B616606A32A
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 08:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B616606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EpuxjjND
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b3fb193c03so1804927a91.2
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 00:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795509715; x=1796114515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miq8lHAk9j+ldEOiiht4iRcOG6aLFpZt8I9oVYIzhag=;
        b=EpuxjjNDpv8P/TaKIGvDrghu6h29YD9v/Ow2khz3TFEhVVUlhELGmYhcihYvRqSTOB
         ucOI6LuN+ktO6hQJa82SHMUX9PK3Rw97/65XpXoHq615v6hnbDp3EHh4difyb5PpWlMZ
         sc5dH/3DeTkKDzXWTfEp156NQwATS3O5P2lchbyPU7ZO4wMLz+1X4Ky/QnfGpNdiCdrh
         Ui9OR+4YellgZy878gCtG+p2x7RyZwrBbQgrbLoX5EgzNJoAuVvSOTqDSXObriVLf5dB
         lS1RUgpH273WxkYJ9LOxbmhzL8BPmYapKqA6W8kd5Y8JsBoGfAHq4cIZyQ8ru04hgMQ4
         BYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795509715; x=1796114515;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miq8lHAk9j+ldEOiiht4iRcOG6aLFpZt8I9oVYIzhag=;
        b=pt8LbAH7SdrkJ8vlvnHold6o35M/ZCPbPiglJFA9IXMGWNPDycoC9H0z7bUJzwV2S7
         5eXCRwAF23DnLk+kwbKqg0reA+H6zf+vWQStnbKV7caHtznv90fuB6264i6Mxq15fvl+
         yEu1Gev4CPGHfn2u8Ld/q8qfJw3vCrwD2rUF/Zp6ayfj2QhpZ9nYXQkjpYPZQfxve7WS
         Py1HgoRKTTPFz4mrSdR9rBCibFDzmPrtOL1cITeMbl3YmeKXXc+RfCgtAO6T09xl+Uwq
         73WFxMjHZPTo58m+NUqNYR5CGR2L+z681OdNohfnB8/VWBAP1wFlNOu7mM94aAl+v/K4
         RuUg==
X-Forwarded-Encrypted: i=1; AL+hErGrUkOb7WsSNaPo5LnseG7L87rged0AfKRSKr+2SO+p1J8XiZzl89GBcm1xB3YORD8hY/8UIzgmGhE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WH8nAf4iPV3JD2FbttNKvCaYhRCvvDamuTSrjC5rig4NzqFvK
	LP5DWIdj9VGWLff3ul6LyeCJlpjgyzTmEKM33QG078iDJx1rTpEBXPyB
X-Gm-Gg: AZFdTZfCj5CDIFnQqAhZ0jFtszF1+QcLeFG/TLJGzmjpM+YwHa/PXXeJ0BlW7S45AfJ
	I14vGTgpY0LR183AgkVRD0AVYuV7ZsL0bY/nkqNJydeH+Xu+zOgWTusFF24DxsikGk1mx/6zDkT
	SzrZ3Z62VUVzNH7qkBAXiOUKGz2/Nxbo8yj16hBZrOO1sw0W7PBLdBjp6NRvlSLzoOl7ZBm5gE4
	Is9i6SVYxj//dkdH+UI09rpZy8GSkTDVWzlRZOdenD+wvhUfNf99uXqbz+Hu9qcCEo1g88nIr2V
	PXs2HP5SotF9tw92WwEoTmd7Hfojvc+3wDPo2EazWMFRf8J0N1VoTj2OEstW+4SMV/wwsLg4FPk
	fnsTE4VgePykD37PQho+bYKJ4uuJsfHYZHrjP7MsdcyFNOIxWiYWuYWxVdRaTc8/FhLc71upcG2
	9BKWBChorRruKKNIBDH/SLP6+1QplfhnURFNxR+mDbGVWF90ULL5DZgeWXjnRE1ahvtS4QVlRfx
	AbSif+qCaB/EhybhSyAmle0wbf3N2F8qAdd3UJvJd8EeOVafVtcrX4mnfVkXI6czpKycZDEmsIM
	g65Rwb0DcXVF+JqKrXvpcCD9ipUZrtVeIhvvQrFER/iR/tMZHQ9/LPX2Doh09jLZ4Yh/D1MPkvJ
	uIyBrTQ==
X-Received: by 2002:a17:90b:1644:b0:3ac:c98e:345e with SMTP id 98e67ed59e1d1-3b41caef685mr10503851a91.45.1795509715146;
        Tue, 24 Nov 2026 00:41:55 -0800 (PST)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d135e9sm24432973a91.4.2026.11.24.00.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 00:41:54 -0800 (PST)
Message-ID: <c88fd429-025a-406d-ad80-ec464db7d1cd@gmail.com>
Date: Tue, 24 Nov 2026 16:41:51 +0800
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
Subject: Re: [PATCH v5 3/3] iio: adc: Add Nuvoton MA35D1 EADC driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 chernyakin.victor.j@outlook.com, cwweng@nuvoton.com
References: <20261117082832.1551574-1-cwweng.linux@gmail.com>
 <20261117082832.1551574-4-cwweng.linux@gmail.com>
 <20261122030647.70b41b61@jic23-hlaptop>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <20261122030647.70b41b61@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On Sun, Nov 22, 2026 at 03:06:47AM +0000, Jonathan Cameron wrote:
 > > +	/*
 > > +	 * pollfunc->irq is not initialized until the pollfunc is first
 > > +	 * attached to a trigger, so only suspend and resume triggering
 > > +	 * while the buffer is enabled.
 > > +	 */
 >
 > True enough but isn't it also guarded by if indio_dev->pollfunc
 > inside the iio_device_suspend_triggering()?
 >
 > I think in the case you are avoiding it is a noop anyway.
 >
 > disable_irq() nests fine so it shouldn't even matter if anyone turned
 > it on yet.

I checked this again on v7.4-rc4 (b6a9fa34ce41).

iio_alloc_pollfunc() uses kmalloc_obj() without initializing pf->irq, 
while iio_triggered_buffer_setup_ext() allocates the pollfunc before the 
buffer is enabled.

The PM helpers check whether pollfunc is non-NULL and pf->irq > 0. If 
the uninitialized IRQ value happens to be positive, disable_irq() could 
be called with an invalid or unrelated IRQ number.

This is why I added the iio_buffer_enabled() check for the 
inactive-buffer case.

 > > +	if (!iio_buffer_enabled(indio_dev))
 > > +		return 0;
 >
 > As above, I'm missing why we need to protect the call
 > to resume_triggering. The pollfunc can't change between
 > suspend and resume so there is either one there or not
 > in both cases and the guards inside that call should take care
 > of the rest. If I'm missing something we should look to
 > fix it in those calls!

Agreed. The same uninitialized IRQ concern applies to the resume helper.

I also noticed that iio_trigger_attach_poll_func() does not clear 
pf->irq on its error paths. If request_threaded_irq() or 
set_trigger_state() fails, pf->irq can retain a stale positive IRQ 
number after the resources have been released. The normal detach path 
explicitly resets it to 0.

The error propagation from iio_trigger_get_irq() was fixed by 
dff701806ab6, but these two IRQ state issues remain in v7.4-rc4.

Would it make sense to initialize pf->irq to 0 in iio_alloc_pollfunc() 
and clear it on the attach error paths?

I agree that fixing this in the IIO core would be preferable to relying 
on driver-specific checks. I haven't reproduced an IRQ failure at 
runtime; these findings are based on source inspection.

Thanks,
Chi-Wen
