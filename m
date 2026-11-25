Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593050;
	b=Gn1IJcNbQnd5b9+2K+OEz7pnfof3ryTzYO3rn+F+jkjJE1D89GFNbVkBD9oIJa176KPR
	 K3YAW6EEiuBOOQSwPpmaTKV5igCNiGLJpDPBjfyKqSDVAJLVzS7y3V4VXW7r1gBtvz9V7
	 WEYvpnaqTiJ2pz3JU8jXod71O0/sfOCjAGVVIj3ldu4z1f18VyYG8QLDj5aNguOEwrtDK
	 glSPCkWu2XQEPucjXhYLNntAWRyJPxbH1KvMSs4lJ0/ggiaczW9yGNIzonNSjSa9FzKUN
	 wkPcPjNLRNWIm5G/MdR6dkoZcpKnevuToey/5hwujTS9Qeoq9aEBCRNn7Badr0SmSrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DXWZe8PdHaNwmG1e0zrjYh/YQYZCr4fIGS30UdSlFbs=;
	b=WvJc9dLawtETuf0o9hZQX27SQ2GXlgazQfkPCKomrpWUj80r8hJ7dJBMyztYkasrKwnm
	 dqmcR8y3Jnei8Ql4FuAhkoEunCAhpkJL0dHcyZSHS4+Z8O3+TBsw82YmVbjdiJTzMxvGe
	 UZXC8YYe7SrYcc3NeMYz03FLQ37yLB04XSdn5hoA9gWRxSUHCKpGKN8ESOGJgxthnIG4G
	 1IRnTB9QrN1OSAkViuLiVMwcsZaM3sY1q10B5bRWRE2ZVGGqNesz+3RBXO7vl4H0HKZkB
	 Oy1+9F2jGEzxwZP/TGMn98BsRJbkx3se6VdPNIvYsg+UXCUBnsdNuhV0KFBbaX7duuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oi6oGJu9;
	arc=none smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19752606A32D
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 07:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19752606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oi6oGJu9
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5c07c7306e1so4995531e87.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 23:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795593048; x=1796197848; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DXWZe8PdHaNwmG1e0zrjYh/YQYZCr4fIGS30UdSlFbs=;
        b=Oi6oGJu90Kw9BlEuQHOAy7wrlo6tE6cgHbPzX5o1/gtAto0wXsq4G8NpB8fI2sMw8H
         xicincIzl4W7JLGLhnS3D3VmZpeQuEvIe/yeOTyUSYbOjNsMf9XiV/TPmCRk1Xg9Mgt2
         Q2iDzixxz2ZvvAn+4SU5KsSzAxODWFCccY/q+LdyeP2HPzobm0zvbQhsaDZIv28+gH8r
         7e/2Nf3M31Ps5wtoduKfyil35o8wTQV1xQlmEjuWAwjhNt+lzJRxD2m1HQOF/onaIeac
         OINZ29mNrJB+UNWWAgWHAkbKUF+7TfnlU8Y8Qx7HQfzKhhWHRQmv/aK8ZgOV9O0nmWZh
         qHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593048; x=1796197848;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DXWZe8PdHaNwmG1e0zrjYh/YQYZCr4fIGS30UdSlFbs=;
        b=S2CytT77Stle7f9xp7Lu8h71VW0MxWMXo2cUZ2qDkTLuXNdXyCoZaBG8juyI/hx2Vw
         HNwctj7BZoh4EPVwEOvUeMNaLtKr0JXCOT+2s+5sG4gLQAhh72bKvGIkU4mG93fi9D2m
         Em4VI7bJ05b231hIFTgUVWyt93OE7P+WGfdf01LeZVr+GLGociyCH4+WhV8vs4N/UwDA
         ZALfUBugyF4c5bS4xbry2fjS9bSLBBm7a5AAAK4GhiqZXmQG+qoBo1N4/tXIL0aEeEkN
         azcEMZkuZZX0sFxG8rfFG9bs1RCHQw24/mD+TSsNWB07rPtUPFgpK55UyMslZs4Zej4A
         lT8w==
X-Forwarded-Encrypted: i=1; AL+hErEyGknQXqfCE6A/pIrhX/4AktCYNsJuSCib877VKSAlEj9oAgpnxGft9ZMxcJym9pYkna8V2vW6KXs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oCibfP/NjvNfOp3XgTR/wlCaZl42iH2zOnbA3xXo1hlbNktWH
	asPOsJ3o5M3gYOmi0b1iy8Pa/6+dOEh1tVHE71bCZoD8ZYgpciC6A8rS
X-Gm-Gg: AZFdTZeKjRkznTrefwH8Y6iBn682+Un+rx09WsqGjpS5g9ITuIjbFw5+uIp3Gq5Y7x6
	Ydmafj/V86pSS3VWQGBv7c3eaqWlNvhA7tEruNBg6+ahvQjY1hmATrJc4/5UX5OUfV2OVVB3MUK
	vQteoc7+Lzu7cPDuiMfkoMtp6KmpqEKd1lupb7Lll3j60j+nCuY4vel+ZIAygsw652ZLNI27RvI
	EqG5r8MUpvldvPI6iqSupHhMu+ZJdF7uvg6zCzvIfHkFMBIrTwiij3LOCcT4QqRfBySq5/J1Ioz
	pb6o7lHutuUfDOX6n93RQkHK4aKPsPkIiOoDMX3Hq2G8sXdE7ofjkqzCRFj6V5hijDH5keTaQin
	4jD0u11bA8DDykQyA8ZT+Rt9mXDY/NAZTidbgqUifFLqruNOu3JZQ0QhqHBw4e9aLxEcoy3S5GD
	iHJy8Ii+AAHSzPCtHePCtkGLgfKAzdaqmJuRe1P6Yn6lh4mttTFWJ07+3v2CsO0FLEI/95tUSV1
	yyQxlqdUdmAkys5eVBeen/d+RWZsMtGLUnrFgRG+nMbeNy3wzvIujsy5Y2jn19cTz9KxCoQpOUX
	4dGSZ5+LPCFPaOtDTz3eD/98OFiBta1mcO1T4X4RQYIA9Cq/UPJ8if2v78KXeOKW6Dy8DZ1JWwc
	DZd3Um8XsSZN6EVLRehklbVR3T665rgk5YtRaOw==
X-Received: by 2002:ac2:4c54:0:b0:5c1:4e18:39ca with SMTP id 2adb3069b0e04-5c1bc7cf9a4mr5041284e87.21.1795593048013;
        Tue, 24 Nov 2026 23:50:48 -0800 (PST)
Received: from yantra.. (nekmmqvppk9cj8danf8-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:f131:5b16:1fac:1214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd0776edsm4536622e87.73.2026.11.24.23.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:50:47 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: u.kleine-koenig@baylibre.com
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iio: pressure: dps310: include what the driver uses
Date: Wed, 25 Nov 2026 09:50:43 +0200
Message-ID: <20261125075043.37440-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <awU0bh5ChdbAsArK@monoceros>
References: <20261123220649.36887-1-zoone.rupert@gmail.com> <20261123220649.36887-8-zoone.rupert@gmail.com> <awU0bh5ChdbAsArK@monoceros>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, Nov 24, 2026 at 08:03:59AM +0100, Uwe Kleine-König wrote:
> > +#include <linux/mod_devicetable.h>
>
> don't add <linux/mod_devicetable.h>. I don't know what made you think
> this is needed, but it is not. i2c_device_id is already provided by
> <linux/i2c.h> without the overhead (and useless dependencies).

It was for the of_device_id and acpi_device_id tables. v2 will include
linux/device-id/of.h and linux/device-id/acpi.h for those instead.

Thanks,
Rupesh
