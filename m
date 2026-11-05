Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876747;
	b=VPKDHLqKV7DVZ9uSDZRjtGJCqH9aoz1H1KKz/mvJRausuaOikdQSXcVpwblu6mvy4o3u
	 GlDFLEBaj6Ci2K3QDj97t4SXBuKQyRHXBUs/qZnH5tb+GNAyfOug+J3rVJn6KvYcwYhhZ
	 UbmqYSXIDRLYhTjep51axxRh1NJ6uGQ+H7unaYWmFhfWSRGen4Ha6tVs0iQsnYVNP0bvN
	 WdsqJotumorUaTQ78yTTn2NkbGdl+LJE5WFHZdNJFu6254yb9d10LUg7oZb/gOr/W4fW2
	 5mXLI/ffq151mYkvO81V9sO0rMBhGetYubd6HvW3DjZ6CX96p25noukH2LYa5muFdhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JN0h7SeXPERjAEMznolQ48k3OWsfixBRlrh/PkvU79k=;
	b=cRxgMdVnmoGBPOSUre+FXA7UoMxG27drdU9GhxUjJRqtWofJPZTjZhgFJE7uNQsXcA9p
	 WKdxUHVS0guFGxTAUt7p3lLVkQxDz7vhAROuTosaD2nVD47iKN4gtlU9AfGED+SfQGkKC
	 FW9pAoH0Vvkc6UkLodpDkWqjGL+BPy8s5/F4D71pqDO7Vtb1R/JMuK1V4Wl3c5QfK4LWF
	 v2cbL4M9YOWmAuXqun4C7aJAZ1OWZUdBgTqRRJSfwS1EEbEBBnMEsA/7f2WKJsn/2OwDD
	 KqDanpnFg6TofaavAy1YPJ5IBJ8ydSYC3SF6uNm3VJ0Q9lpCxeigxElFuMdJXkP9znw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kws39dw7;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B9606A329
	for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2026 11:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A6B9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Kws39dw7
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cdb681de50eso7788a12.2
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 03:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793876746; x=1794481546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JN0h7SeXPERjAEMznolQ48k3OWsfixBRlrh/PkvU79k=;
        b=Kws39dw7eQ3kZp132JgUegkj1UJMNcWAmDavCayW7p+4EzXtSjiMjpOu14eGanq0CA
         FR2oKytqK+Aye8O50js3m9AxPehTyjqRRKgWnuHrQdz8LFTrRiY/kHXDlq8EoJ8+mQ7Z
         kxWNltVLsO4JK8VTxMsjnwVZadW5ycNasCHvd9uM6IWwvEOwhI+hTAFyk6CtQU43/vaW
         U0DQp9Ab9voItrQzj4OqdCzXBBHjr0tkIPhOO3pxXnngVr8CfUiNL96tyCmEipjnRNff
         /UdJyJODefVYVMQv6YAY1rRwh4Zy7O5Ook2uh+ekNZaAI6x2uIiqJsZD0nF0Qyyi+MkQ
         N3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876746; x=1794481546;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JN0h7SeXPERjAEMznolQ48k3OWsfixBRlrh/PkvU79k=;
        b=ZZjSM+whj4Zp4x1k+rp4zrq80zhqWjrIeT86E1UZhodP4U1Q88+NWDJFFulvQ+uOSY
         p5LVK1kH1Tyv37rUwjYk+6ApyTSeOWfrgzfMEuyevdoKnRTj2OBVdG1Gc7TSuuKTaUrc
         DHNID/xJpcUQrD+7TZNYcAB/+4w0gogILW4SYq6nonOroXz6Kilz4/6DqFS6Pu5+WTNV
         9nlfOqVZ0C7rZ3iuebF6oeQmVEgScGSmXQ49B+s8s1iQr7r05fYfdxjLbjB3Q3kknDK9
         BecLcQ6r5B0SsbTNYCGSvrtXfyqT+z4ncdQX7GPVUvdHaojRvLIZ1yW94Sj+M7mfsnKu
         BwzA==
X-Forwarded-Encrypted: i=1; AKwUvBy7+4sqLXLqX3usxXytCsnB+Q2RKVantIHaKdp9Uy7KW++V3motay5K6bZWf1sR8dDawDiaJU23+5Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TuCtr0xa5Qf2DvPdjzFQ4feQ6JzjBm1MLjLSifWq4ccnteQ76
	Al4InZrgKPUoqLgr7SOT/luSQXXwHgmeErwwvefuMNiV7t6F+XEOfRgT
X-Gm-Gg: AYBFou0jTqEEwkALqojC7UFpGZXz/7rrXfoYFTi7V+IJaGgLn4mmWKHJcyWOzKzNdcY
	WDbt/zO5SzQkdTZuaRJAE0V/WyyouaWo7JtzBlBTppvIUK0t7yF70eNN+kLHaICgK5R2eHd9iix
	geyxkdM/umv4W1rJEULyBHOyyH9u8nmS93fMdlGFTV10X0sgKawsqP6gl1aebL6khLJsXvNKVh4
	e122z40vvUW+311Id+g976K/9A5oSWlHBJ4OVmlng19fi3qLViAqvEX7o0V9kQig/skqd0+TYdY
	yat/1XljGVcAHz3m4pXYIJxLRrqATccj8TItMgcvtDVHEm0pTJO0oEktj3maWs7f17rEDcyrEm5
	MWe5l6pO0s8hA8j5cOuMrDJ7qTjFxwghrUWIkRKV3KcscRN3AnnwcDHBZ0phm++/L8scQD/xTsc
	sa7EjP/IRT0H1dohhrHTi3J+Tmg5bqilXvacdGzzBBPJBEttzSqvBVQ8AIpfLL5jqineGozff4E
	TYd9Eiid93mXpDCq+yIWngdufnvpPZ+/lSZdDtmHQtSkWC9FQay6LZhJ+P9DIxErDxpxV3PDtZL
	V1V+SIjH7zljfQtNIIz9P3nT9wo8ijcmO7AVvkpCFsdN4lxz7BDuDpYwULx6L+j2SyG8kvGk5fM
	zEe4=
X-Received: by 2002:a17:90b:4a84:b0:3b0:97bc:62d with SMTP id 98e67ed59e1d1-3b097bc076emr4500305a91.32.1793876746390;
        Thu, 05 Nov 2026 03:05:46 -0800 (PST)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31aa128sm3474817a91.11.2026.11.05.03.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 03:05:45 -0800 (PST)
Message-ID: <67823831-cb47-42e4-8af0-1331a3f73ef5@gmail.com>
Date: Thu, 5 Nov 2026 19:05:42 +0800
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
Subject: Re: [PATCH v4 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20261104091136.151269-1-cwweng.linux@gmail.com>
 <20261104091136.151269-3-cwweng.linux@gmail.com>
 <ausb-YqIJM0mI65Y@ashevche-desk.local>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <ausb-YqIJM0mI65Y@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


 > Repeats what __clk_is_enabled() provides.

I would prefer to keep the local flag here. It tracks this driver's
clk_prepare_enable()/clk_disable_unprepare() balance, while
__clk_is_enabled() reports the clock core/hardware state. For a shared
clock, it may still return true after this driver has disabled its own
clock reference.

The flag is also used to avoid EADC MMIO accesses after this driver has
disabled the clock during suspend.

Thanks,
Chi-Wen


