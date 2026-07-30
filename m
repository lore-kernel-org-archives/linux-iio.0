Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2DD1B142D
	for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 07:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395966; cv=none; b=TZTZMJcY/sfRnA+HoHRKgiy6GwiDvuwgJUJW7pa98HwUL4BOEPB7RWkX9Es/21d46d7QPxTIxWyU4NE5nNLmZCDnDPlAlfWnl3rCQ6KMzJKxUMNEg+s/9Qgq+qllr5bHORJ3vosUvsEm4AqsUpd8eBe6cXSxM084jPz7Ra6GlmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395966; c=relaxed/simple;
	bh=o92yQvxUqaTH9jym+90EcVtlkrdRh9f0R3gdaJcI2yY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCvr7IhILMAfiTMM8qHvIHuuVsEINhnTWe80A2/npJHvkY4PtNjH6jpjcqQhBVeOCjurSgD0cEM2BiF5N26dbRcktgAATaJ1jTgFLl4gLiq+bMkItOgc3DhxRfp8ALQSw8e7dxIL4mAm3PfEkT+h/dqN8CosP5/hdXj7uQBz6Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDZvIC0b; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDZvIC0b"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4954c0833b4so11703865e9.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 00:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785395963; x=1786000763; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2y5QAVeNEbw4rwpIis7dsdZArac2vQn3qNAs9Ae58oc=;
        b=TDZvIC0bfDa4fCzOf7s2pZOBbLaDjH1d8WTo2EM2K6gTfySeO1XAo3bl8wG+S3aLCK
         +D6oJyzgcXIAG5XuRCIF9t151BQ5OEnnA8/unICrufrKxzRf4/675C/yRahW2IilUwTW
         SJ+RvV1TjEuUsiATomvXsM381YjyAK927SHPvI6zwrcS+ObWeypRcrv3eDT7glKB7xsk
         nzJTjktJ1LQWRtvfOgreT2d8sR8GQ6lo7WcQTvh8hqc8edtX1JQEyYaCGZ61QKRx1/99
         ajHZMP14tW1INTJgOeYjF2ua8wroOZF/iML5o6Pf0LfOXmhfLLcE3Jcwy4HfEILv+yXp
         raKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785395963; x=1786000763;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2y5QAVeNEbw4rwpIis7dsdZArac2vQn3qNAs9Ae58oc=;
        b=hZ+i96gpRprABJlqKLj7m/rug8TaXgLFtXmKpdbWvLKxk8rFmsJky2nvICSX45NJtb
         b0Vd5Ms/zQ5UaWqkpUk+x7wfY4HESPPPNfI48BmF96sPZO/Z0CS6VO/DBT5yuMoE6bXL
         EB7o11xen8BwHBHz3VvmJU6ILAtDGaAn3caDX28t+eUDsP5bdbHvygPL8lOovoXO3lV2
         4XR8Pi1sU4PAjaksQOen+YnIBU+BvgRfcu/fMAKXjXkAfmXy5HWzFmQuMynQelK9l6pO
         lTKSTwjjQSXhCQuyQK9/DAdhsPabTLv6qqHt3K33pTPH4lDTULfXq7ORafF4fPnrCXLx
         L8cw==
X-Forwarded-Encrypted: i=1; AHgh+RrZKBS5bks5Nu3lcv6RJiGTEFMWnWYVbUKGgTbdOr/1wvbS8TWrRywhm9cQqjqqEwRDxsUn7LXaBwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNIUfRONd6iaJW7GPQorXbUMHoPyiaE/7YyjUIhXujh/mkFgkg
	qGrgDHCIdR1KhyYYZeTo7LdGZ7b/tXNxzb17DeWPoOSA+RiSRLD3U7Mz
X-Gm-Gg: AR+sD13eWbMnwmNdly275V2AXjHq2BhoGldE3VvZxANMbGZ2aDV3shKtUL8Lj9N1y8M
	JBJoZLDlHL3V33Q4CNBuzaA+OL3Kby5gxlRlAvE4SbvHEzC0UYQTQg4RR1b6/0F8dD9i80a7AdG
	Y0Pw3FaBaI92GKfh2XwuqbyzngO1WJvI9KqZuIkCdDcL49dnA082rfOIn5IVIWLPgUGoOeOPxNX
	H3SFzHrlKU3a9aMU+9hVtatk4wmY96GNWdaDOst8g7H5U36k25Kg0W7jkVzNtyvgnTHtQ5+35Ld
	IIm/5NyZ6S4T+NCGWUd7OIByRQh3wms54SIq5N1i3M4jkZwoMeYzV+QslTYJ/4bvCMwfaFWroh0
	DImWFJ6LmCUy2w1gH9QO2mftAuK2OwXGjhM50bxzx3ALRY0+pthyeoWxkSHvVzPQUuZ2Jmhz5t1
	qCQJwMzRJGt1nHmms9SeChRsieh7SUmc2hsS76UHIlHD5wlbjMkAPkfFjhPmnm+ecN5gNKpi3s7
	b58xcSZLw9HNKqG3SqbZhnenHmu8asCKVpiBwbvDu4XXW/mN9njP5Aw0SJPNsx3TP1Lm0puS8Ng
	FKefgk/gKYqCUj0cf4UNmTw0a9zjTGlL2u4ersyJ6Cfol/7XJr1hRBDf6E0mkchdiRrBRPhSyOK
	CmODL3j8eMrK6T25TFzHhML262lAkf/eQcKWRbrRnrRnMTorLntL58Fb43c56RkqoHRHFd8qu
X-Received: by 2002:a05:600c:3306:b0:493:b6ee:fcb7 with SMTP id 5b1f17b1804b1-49800e753admr10529425e9.14.1785395962626;
        Thu, 30 Jul 2026 00:19:22 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88d6e68sm3625182f8f.7.2026.07.30.00.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:19:22 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:19:21 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Kaustabh Chakraborty" <kauschluss@disroot.org>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Peter Griffin" <peter.griffin@linaro.org>, "Alim
 Akhtar" <alim.akhtar@samsung.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: proximity: add driver for Sharp GP2AP070S
 proximity sensor
Message-ID: <20260730091921.00002d45@gmail.com>
In-Reply-To: <DKB8WW9AK4KQ.2A9KVJWD5ORFT@disroot.org>
References: <20260723-gp2ap070s-v1-0-b8ca3a4c10dd@disroot.org>
	<20260723-gp2ap070s-v1-2-b8ca3a4c10dd@disroot.org>
	<20260723234439.06411731@systembl0wer>
	<DKB8WW9AK4KQ.2A9KVJWD5ORFT@disroot.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 23:23:45 +0530
"Kaustabh Chakraborty" <kauschluss@disroot.org> wrote:

...

> > Please add iio/* includes after the generic linux/* headers. Ensure
> > that there is a blank line between the two groups.
> >
> > Additionally, you're also missing <asm/byteorder.h>, array_size.h, err.h,
> > types.h and delay.h.  
> 
> By the way, is there any tooling to satisfactorily point out the
> shortfalls with includes? Or is it just intuition and experience?

"Fully satisfactorily" no, but there is a tool called iwyu_tool (IWYU
meaning include-what-you-use). It requires Clang/LLVM on your machine
but it can serve as a pretty good starting point when cleaning up
includes. There is an unofficial mapping file for IIO that makes the
output of the tool less noisy, however it will probably still need
tweaking. Here's the link to that thread:

https://lore.kernel.org/linux-iio/20260512073505.1310-1-joshua.crofts1@gmail.com/

Setting it up may be a bit tedious, but I found Gemini to be pretty
good at this.

> 
> >> +	ret = devm_request_threaded_irq(dev, client->irq, NULL,
> >> +					gp2ap070s_irq_handler, IRQF_ONESHOT,
> >> +					"gp2ap070s-irq", indio_dev);
> >> +	if (ret)
> >> +		return dev_err_probe(dev, ret, "Failed to request IRQ");  
> >
> > Just return ret instead, dev_err_probe() is called automatically on failure.  
> 
> Are you sure about that? I happen to call dev_err_probe() on all other
> places and other drivers (as of late) as well (other than -ENOMEM).

See the comment at the devm_request_threaded_irq definition here:

https://elixir.bootlin.com/linux/v7.2-rc4/source/kernel/irq/devres.c#L94

-- 
Kind regards,
Joshua Crofts
