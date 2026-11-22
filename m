Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795381892;
	b=yDe+wNBKMb58YHqDN8jx++rzc1b8mn4Sk2mqmmqQn6SY1bOWWPH1y7WGtnCCP/GKLZBK
	 eHMcsgkqfbozn1Q4ihPvXv3nIkIEpioYwZ2TS5NC6Yhfp+qWtpLYaxbWD+5twmVtqiej9
	 +Y+EILTQzhlIJvrtVIhyPIHwPHZclzuT91mTbAZg2mUKLx9+5isD48r12XhDqvSQiC7ud
	 muaQA0XmAzdr48FeL9iJaPQ/vmGatBhNe8QHeuaX+6MYWwgHt8p/hHOw7az1qDBvp8AkV
	 uIgGmok06fnLNSi0hivlILRi0ojn5VjzEAUAihjUxKLIyAlBMd3kTS4Qou8tv4HvgGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795381892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ge4eiVUKj3nX4tuUYC5k9dPzCXTKzLAWVgrNn1CnYhg=;
	b=CWt8YPTzUAkjkTLSl/wxdlF6nfNCB63Vc4ywzNh9GU9r84phZYHZnWxlBZnb3GjnZuuM
	 k7AmgTh1DjU51X64mqk5kZ75FhsdCjAdQQQXW6U10WcBzoXWktf0aQy8/7yrud0pPUPKL
	 VFcHEIQKv2vOY9ylpeEOyqkvglav/uHiPoE7SySvXmt6sV459zhpxj7XBSXUk9xqbhDN9
	 4YtgnzbLc1rfDotPxYXnR+YeaMXj4oR/Ig9POvGhtAsXWw/wOUPA3dBuOyCHzCbYAtwgT
	 oH5xp5uCfu7/nnCm1dJve8+Pbn3IbXXK/KKFLUHp+wqNPM2CgYLnImEGEjUU1+PKuww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jFz4jAsb;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCD2606A32A
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 21:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BCD2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jFz4jAsb
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so21418415e9.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 13:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795381891; x=1795986691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ge4eiVUKj3nX4tuUYC5k9dPzCXTKzLAWVgrNn1CnYhg=;
        b=jFz4jAsb0UInSseLDcDVLtsdUjFuIb2lcwvCt85BZQgR1AT6Fx7rZhyuuaVcztw7DI
         SHZ0U/ohb/0XMsoxbT3U+cWFyWwo5LwSY79yKpzQ9cGwZZ1rPtClIS8lccyn0YbSHO8Q
         /MbnqSeiwU3pJZcK2XqSv8Prdfql/n3LX6gHlHRTEsaqIK/O8NKYvVQTS65FbrWrUakf
         ohgh4YXvxQue+l+JfIzOS12pYHL4A5CVRM4zQZQhe1nsW3yo5Wd9BAdBZ/ebu6iITp1O
         cQ5rRqpwGZsqMLYRn8EO25QkPYSN8e64BTQt8kV9VFMArAkZslZyHa2vOjnruEv7VdVw
         yIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795381891; x=1795986691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ge4eiVUKj3nX4tuUYC5k9dPzCXTKzLAWVgrNn1CnYhg=;
        b=NuYK8oF9qlt9scLqPl+8wna7PjoMrDb2Sh6M7/tHaDu5IgMtgv6JJ0ZTfFA2S75Svy
         f5UsgXShoe8Kt80/buyQu3RCFBWhIyZaB9Afmc3YFPEmE6KgxTa1XuQSNC5FXdZyrMZj
         hObCru/NuepzmJRB259vmjMhU2al6LbZFrLno3yLkON2gQSfLlKBnU8ARt9K0iSFluC2
         ItwhRRpWqEQhbzui117HvAndZGfyGg404ghTXPzvotbYzX4H4I0Tw0tAtchvm7Ts3Ksr
         kOHmCbLitMgffJgznDoAlM9WJS7iJrO7LaJPRG5r68YokjRrKQvGxePpw3rDaL7WYWp1
         yWfg==
X-Forwarded-Encrypted: i=1; AL+hErGI7o0fgbpXr6gVn0K9XNZSu8eMU/eLCalVHfXvEq2OuGzagbNMOAq54q80JZxwC3JgPTeE86qfPqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z84Q0By28ayR5+9ANe1k5RlopQ5C6EeYgNlnhmvgqCsbbG6XL4h
	Y8gZXvgtf9OLGWMzFVUi4mnEAi80MnBamicGY+EAxlhjNMZPptp4Q78iJ9q7jSHmOR4=
X-Gm-Gg: AZFdTZd++Zu2n4pSkuHHWHPP0uFt9nYzY5os4OcSQCLCsvW0t+IkoMgfeel2ysO6W/O
	WP434tZ1DO99mY/yk309Hy2474fyhiuYMqfm7osKXZlv53sA0bJQMndxOLaMtZasmXw0Z7DwU6u
	F4mihw6PSsJr/z1+9n/Vz0OULO8cl+lQDShjijer/Jd0bhTv4hcBLhD5i1wBYTNAMd4lETBcv0R
	TCgHSkziOsAo3KB0mWhdUqTWGewZhpZusWa/JQZe3ldrzVdF8CXPFo8C5If223HW7fCNou7dwph
	8+GB2dgVxAW7wK6tDs7elXnBxNzHWTitoMbikeGo216dg7sRr0glZsUareAwDhaQroEl7CzFweH
	aZ742A7LCwd2/V2oybUCmoSDYpjkbv2KCNJUl/AI5ZcUTT2cm53LHyRhWXhIJLliUtIeeNQfe6J
	MBIIjD/4wyPXnhnU6yyPl1O0EFuGWokM0MiQSnhEl5OgoE65ehcU/zvpGFx1ZymigMDHXIS2iHX
	d3KK2qd+grUu7kuF/kjkKluU8uaH6r14M+3HJBGaTux2FVls+zPYrMrPTHmUbDs4xES6fbTuH5C
	rnBTMvqT6VektPc6DVj3OuPtgncgCTZbLa49rQNALWQBID6cfNNKpk78JjaZ0vcHVw2jq+E4/DB
	xv6I90U5M7Hc=
X-Received: by 2002:a05:600c:3b88:b0:4a2:191f:7cbd with SMTP id 5b1f17b1804b1-4bb888078a8mr229132545e9.11.1795381890664;
        Sun, 22 Nov 2026 13:11:30 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906640a2sm123545075e9.0.2026.11.22.13.11.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 13:11:30 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: magnetometer: mmc5633: Enable the VDD supply
Date: Sun, 22 Nov 2026 22:11:28 +0100
Message-ID: <20261122211128.14591-1-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261122205211.6c46f3cc@jic23-hlaptop>
References: <20261122190836.66111-1-gerard@teslabs.com> <20261122190836.66111-3-gerard@teslabs.com> <20261122205211.6c46f3cc@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 22 Nov 2026 20:52:11 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> >  #define MMC5633_WAIT_SET_RESET_US	(1 * USEC_PER_MSEC)
> > +#define MMC5633_POWER_ON_US		(5 * USEC_PER_MSEC)
>
> Obviously the line above isn't great on this, but is there a spec reference
> we can make for this timing?

Both datasheets list it in the "Operating Timing Diagram" table as tOp,
"Time to operate device after VDD valid", 5 ms minimum. I'll add a comment
referencing it in v3, and annotate the set/reset wait with tSR (1 ms
minimum, same table) while at it.

Thanks,
Gerard
