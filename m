Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794903670;
	b=16q4dkOg483hluWjgf4T+l+EcWeVeKWAI+5kBvk+5UFdUfYNM4Z5OcGZFzhLmPAFjWNz
	 JFImxp2NBXz8ujnZRysqinEdRlj7EIc3MxYgZSuoAL+nejdlhzIYSx7BGLNZ1ot6dw7Or
	 dguOIo/LhiEma04iL6acG0N4nHVxEn6VP1I2sB5/kB73cyUpp0dknTwYSIfjJ2Tg2JnNX
	 ngpbff43mDC3JQFb/lHEgGAzEU2NJEoI7ymBA6y8MBUVuq2+xdOvnQa7VvmOsqwuXFoVj
	 NFTIuX/4hR6itkQtPFW4OgSt9XF9US2TbGAgQzR4RisHwtWswteyZ+CqfeEzLk0ZPsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794903670;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=kgD+tUTOk9garvkXT1JZE8IpV0ytjaEat0WUrpK1KAE=;
	b=pRb+RDTceDhCMl1xdoLonFijd0TcRLREhaMienYJCpxVuBQBEYZrYX1TKhs5gfJzolYc
	 SjhGzGC0BrXeK4Xk6q9wbngC4mrDgON5njaKM2GJyCICmcAi51T2zKeeACLdqzrgMoNtG
	 Htx9q14ul1CkOl8SSLM2MVtoBjdaH9tegpFC0RBqQ3yTXXYNzbKwxn57GyTIjeS+1JDWl
	 6NfVI2x7sdVkefX8L/vOA6PcbEifs15H9/+NksXlgRoVlKREgN4kYiewovfiThzEuiWNW
	 kmSq3C7OIWM5sK2CD3g6l9kDu/sxG5GnOoavw4d24ONlZeP8VuiEu5IKfZf/VHIdw1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C7606A329
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 08:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B85C7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ed06b725fdso5649615ad.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 00:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794903669; x=1795508469;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kgD+tUTOk9garvkXT1JZE8IpV0ytjaEat0WUrpK1KAE=;
        b=Tbj+4nces5svJSzrh4Dvd+1pKEbLBdWRxixqxa0ZI9aK7WwV6GXfOiAvnVWG4cYV0+
         68uYyjYuHwTeXa8PNgMzKVhYmbcNm0k2UyRLve0ygSVrZGfC+x2L4YluWI826YNBGUpk
         1oXZzQ+9fxp1ilQquPUtoqPpwFRIeeUKEOLYjtg1n92SI3vjFAS4hKpULUVVZimEXYJ8
         wKZNwuw08YgOUwNkf313qTNjwnqJUh4IY3Zoar5FOgl2Tdbjr+gvqggagxaRcpAa8O7v
         +sPb/FaV4djcsutDPt2xFrRGooJUmm977eV5DbhY2JSiWz+G2xyP1/O6iRLAO9bE0Ut6
         X18A==
X-Forwarded-Encrypted: i=1; AL+hErFE0xArtg1qUxHnCBfIcm3k2Nu89VXk4FIlhi0YHMxGVevL3rm2cKa8zB8mf+YO98knW44oAa523dc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8xu9fi1a3/3nmkbYWOvCxKc+c8/YZY/bD4zQH/VFbqbk1LuvWQ
	AXKXzrMiBBdpbrsb79liJpt6V7ifM3MYhxIBPJIzDTCByevT2TwdHm1zF8JyKuxV
X-Gm-Gg: AZFdTZeKjYxupjog6WYLxr66vcYaPwlAxNkKYocKAIHQtDM4EcuM54K0T/DJtevhRfb
	kP0FNFnLjopz5C/wpRFWRCt7dR5M4C8K5O4Ii6m3c74bu3hXUqXuHN4HD2/L8vhVRqrefBe6tek
	iCXtndoKdUJKQEorLA5fXq+h/DD6Le3Y/qhecra8GizS++ic9Ed3ngVgRUvXOEymSMxh8zgf/l3
	a7/mhqRv8OYJBVtW/M/k/fsOTeM/9FdB+qeq213592MSoR3iNvGJjeubyegXvGlsoq0e2puQmgI
	zZQiGGaxK65vZUiOINcL3Ggm9/2umbQ9Dl3pFBUYkevgWS8KpIcuMlKrs21KQx9QMtUfx8pMN70
	lET2cDDi0PJV9Po/vbRvm3bQ5m7ohOxJebBmau1999DrRC0JUcDB2f4en+FE/5l2IXKhZ3nmz98
	Vyala6DZFPHUpH2BxNaJo81zwdtpYACiFXjJ/7f2EcKIno1GQwOd7yQ3Gjtsi+EUb8mbKsq1s+J
	TxI93h8WLJbYgZFKi1ZawVqE+oMpEW5jWug1QAgtxjmf14TIwgUwqJ5P2GX0YopvoAnt3urknUJ
	JPKAw2q99NLFLAeodPMGypUOE0/nOWDiEKmduQ+triaBKvZ/TEtv/2PCE8DtJi9FJuMNnj9hob3
	6YgNLj7NKNa44rF38/nAH4NVv7HtIwBhXatzFJUO1CwpY
X-Received: by 2002:a17:903:4b07:b0:2ee:81:1714 with SMTP id d9443c01a7336-2efd9bcd814mr12075705ad.32.1794903669008;
        Tue, 17 Nov 2026 00:21:09 -0800 (PST)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com. [74.125.82.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd76d8f08sm10953375ad.4.2026.11.17.00.21.07
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 00:21:08 -0800 (PST)
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-380c28f9e35so701447eec.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 00:21:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGBKyj9wJWl/X+IBN4Glpr1M54fFlKjMA5AOlxZegfbdgGbHLpdZDE4Hh7EgGaCXcRlCHP7ocE1wAY=@vger.kernel.org
X-Received: by 2002:a05:7301:2ab1:b0:36a:79cd:12df with SMTP id
 5a478bee46e88-3810c843192mr1761148eec.9.1794903667144; Tue, 17 Nov 2026
 00:21:07 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
 <20261116-iio-ad5246-v1-1-ef6b7c06d4b0@telaak.dev> <avwL_iuTyEjaj0hs@ashevche-desk.local>
In-Reply-To: <avwL_iuTyEjaj0hs@ashevche-desk.local>
From: Joseph Telaak <joseph@telaak.dev>
Date: Tue, 17 Nov 2026 03:20:55 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ53YA3AbkFNCw=OXDSXnPM=CF1_WV+TatUjx0Rbwff0KA@mail.gmail.com>
X-Gm-Features: Aa3M54pifUmPegO6YEwH8eX-E140QvER9X4qv2NjEXyp1YoVc6uiJAyqJ3gFezQ
Message-ID: <CAPY4CJ53YA3AbkFNCw=OXDSXnPM=CF1_WV+TatUjx0Rbwff0KA@mail.gmail.com>
Subject: Re: [PATCH 1/5] iio: ABI: Move out_resistance_raw_available to sysfs-bus-iio
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@analog.com, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 17, 2026 at 03:10, Andy Shevchenko wrote:
> > -Date:                October 2016
>
> This is missing in the copied case.

Right, v2 will keep it.

> > -Contact:     Peter Rosin <peda@axentia.se>
>
> This is also, but I think Contact for generic is the IIO as a whole
> (maintainer level).

Agreed, so I'll leave the IIO list as the contact.
