Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598192;
	b=BfAMj4jOj1dVPU23w9tA7qjCJAFgDh8VpN9X4mbZwt4MsmVzXQvhwhFC1bnY0Y1Vj9GT
	 LHmrF7fiiAPhDFyKhJdWTkabr9IXAgxciw25rCBMq6Ldkw/r4opnS0BbVIPepML+zPcUa
	 50imIj/kqedr+eSYEFMra0N9wjhwAHfu9N4qmbXVXtPD3EpH305JfWs54Ku6u8aaP2Cmi
	 q8QDwnv3IlWzyGyT6RLFFinIMGxOIp3jQOO3BkKuCog3lI/sGqWY4F3yb+StSLoJpTOuS
	 GsUJsdvU7qF8549UXO4dDiVR0UumtY1UADtoKmPriM1HJ5W7YEVDBO45b+koFfrsfZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dtSXApRzNRZOAIEEk0PFvzNQj92bqLpekrXOKMNLB6U=;
	b=LnQB12NX8Z8gWNdd+AZJGpUagJWe0jl6qlWIxseddpYZZ/vIQOOsT9mtgL/dMuk6CZLK
	 mpay8wyHl/rBEa6DvFmKiJE80gGcaI8EarpAfVBKh/J2j/tJAzobVh7+Qj6IEO/vzKHAk
	 /E8mJ199HqyVf61vrVcJzC0PaessR1aTpGuoW73hRoK9i+Tm8+Qk2DrmmkAJd6E24pRcY
	 OEqkvYkB2eWbzNRhHcjVP0VQgeA+GZjMtNICMghgS+oemf/qr1hK4UIV6g5zhxhbk6mmr
	 uqi5Kw6NVsQYRasgIUfIlooExt1WrMYONPq4216UT+N8lzI9dg1NWYZDxV5tHVofKkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7mdlKEc;
	arc=none smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B98E606A686
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 09:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B98E606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O7mdlKEc
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3adf87fc0c6so47976901fa.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 01:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795598190; x=1796202990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dtSXApRzNRZOAIEEk0PFvzNQj92bqLpekrXOKMNLB6U=;
        b=O7mdlKEcxUoSuWx0Bx0zYAuwKq1/6Dba4zzP6J1Q4OrO22h/vNkmSvCbcByMeR3eG2
         vHcYl1rPNSIe9Hzz+/xaLEUj++SPl5TWt/8vQrT5JEendwFMwU0uktOF4pDUM0s/033W
         b9Hlyu1xivQnbS967W1aBbar7zJ5O1gfP+XCtd3ulTkYuYhXXqklzyVl+7DOGcHdIu2a
         WQO8K7ihUlkHTYZzJ/QlF+3HZFLOqEPk7qVUalT0NWcS+XXm2yDV/IVN9WfXNtnD45iC
         6nI4lZbwLe04O8oy7K25Y7bkpO813hKh5axeBSCUxVO//5bp/Vglf5Z9AjpbpIll7k36
         qk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598190; x=1796202990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dtSXApRzNRZOAIEEk0PFvzNQj92bqLpekrXOKMNLB6U=;
        b=WB1odHmkwjxwj/bUacKly3SqtnIULbWVmQQ9RRmlK2sf11i4H4A5eiRww9oQZwk+lD
         pMUv7hXqB6j/umJw3Iauqy2VycDRo4pKnAz6O+HvjXdRhPn463ciuN9rh5f07CRO0S81
         AdYlujveq1sMJ0gIC+gx8VlbqEcOm2yKKCrhQoXpp27ZTunrmXvxA8B4hRfpVU3pcrAr
         NAB+h/68XbFyJ2M0bEJFs44yfXGGBWrZbndUvbsQ+9xjAnJPK9665wIZeKcigHbqaN38
         RrKAIWv0azKZs6oq/JN0dI3r7Whh7sPUVcy/oILBjcPfoUXZTKhbEik54VgS4C3fnG2p
         bvTQ==
X-Forwarded-Encrypted: i=1; AL+hErG84BNZ3V/VuasQ7yScvXFHLBHGsnSMPQzdtN10vj2p9p066tRdNXBiVjsVWF6w20/sAaOa/oH2dbI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Vh3qTDJfIVsc4MM7Q76jAyHit7ygbndZQ3oF/G2TtedOoYHLU
	Qtv6tf6cVS5OKg0kYtxWmmoJIx3gzvhq32ztFGchwfUSxITpzgwR7Dwq
X-Gm-Gg: AZFdTZfdJHjggLWIyP4Ul+lbFjoU3Q71bukmScXmm+EFXxWVdq4pwR1AN7eldwt+/Ei
	YWQvIGQofpF7vkW7nFCp8///nXtK/CYDJetIE7RUNtsYMhOwD2urNDvrxoTNoF3QB5g4HVgx5At
	RJFKAa5n5EPhpgnD6YK9+1mNPaoVOV+8ENV/+XZPe5Y00riqWd0wXKfG1lVlL9nIDccUaXzqJ9o
	t8clRo53oqPik1bjHmJSuQE5wtyEV/nWU16ReQfLNKRiyAMFrAmsz9+hu7LOnYCi4zdge1z9iML
	R2pP/x9mu8JDt0Ravq7CEjRe8vl6wkJaN/oTrGbR/PF/kGxoQdA4uAwRXTSTmBqtjXcIugkItRW
	WHmCE9n3d4AnJpRv3VQaWpZYQBjMgQw3fAQXkxyO7U9IQqJBgla94gM24MfEQAjxOezjFgfm9/P
	YG43rtAXEsRmcvyQvRK1OM+GKk62mWaoMtpiSExMs3djJADLHK0nEthYdJiXR23wpWO5NMu4p7+
	VUErxnyWKE8E6AJALpphuP6yjOJ0BH8plGXBWwgbYyj76asEzfvkPG+Qkshwmb5naKRd5snzZx4
	/7Q+KdqNVlE6w78GZ5wYgO/allat5QKOvLAahFAu4JRRai2yrV+MdbvH6Klqd7JWcefFZB1NRGC
	VWCXbdHebeGqOXc5gk6k367f/HxLeJ/H5042/rVpp2T5y06bLI9Z3IBsYvrs=
X-Received: by 2002:ac2:4c4d:0:b0:5c1:4cb1:f5b with SMTP id 2adb3069b0e04-5c1bc66329emr5991855e87.1.1795598190134;
        Wed, 25 Nov 2026 01:16:30 -0800 (PST)
Received: from yantra.. (nekmmqvppk9cj8danf8-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:f131:5b16:1fac:1214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd0195a6sm4528963e87.40.2026.11.25.01.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:16:29 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: crofts@kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] iio: pressure: dps310: include what the driver uses
Date: Wed, 25 Nov 2026 11:16:26 +0200
Message-ID: <20261125091626.55286-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f71cfc2e-9e74-482c-a56b-8b0507eb9a69@kernel.org>
References: <20261123220649.36887-1-zoone.rupert@gmail.com> <20261123220649.36887-8-zoone.rupert@gmail.com> <awU0bh5ChdbAsArK@monoceros> <20261125075043.37440-1-zoone.rupert@gmail.com> <f71cfc2e-9e74-482c-a56b-8b0507eb9a69@kernel.org>
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

On Wed, Nov 25, 2026 at 09:01:14AM +0100, Joshua Crofts wrote:
> > It was for the of_device_id and acpi_device_id tables. v2 will include
> > linux/device-id/of.h and linux/device-id/acpi.h for those instead.
> You don't need to include these (unless you're going for full IWYU).
> They will be pulled by the respective bus headers.

ok, will drop both in v2, so no mod_devicetable.h and nothing in its
place.

Thanks,
Rupesh
