Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F209F37CD5C
	for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441151; cv=none; b=UhEYDrEkcBwM5mvOkevd7le4GNxoQO6FxsGMqUbgLuA9yN70G8WSCesEqSImWDZ8H8IZU14zjp8nkrJ3pXJX4t7d2yRBokE3Pmf7htUzkUaiqwIDzpPZxX+bTlHCYvZPp9QJgWlbnSn9jfeIdXYlIoGm1wK/OpmwZuQ9349f0LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441151; c=relaxed/simple;
	bh=7y/fmud0L6LJFIjbeO9EwLlNT5k2p42f8i3RLwyzJsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTH9XTIaxUdQFAKqBOU1cRXKZS3bExyN0zhBKpSyi0RrUWRs3t0xEtuuaL+K3Q1yUgqrmemnS4nkvuIity5l+5IVSKb6/5Fq77xhB9iDDT3sb0j6NGODTKpxTGERDGjJ0qrTZsCm6gaJcTZW1P9aWyFyqri7tocO9c1raNI3ftg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hXCuhh/2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hXCuhh/2"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4728c12ba97so68603f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785441146; x=1786045946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vwVWNRy6nalbM0tK/ypHZd0adndrVP+y49fN+aH/CbI=;
        b=hXCuhh/2g07obWSJIgtZw3p0q+6WdrpA0O+n+i3vVlsblpBiWhgAcWdGxstW0P60w1
         0nqIB+kgFeEVJCN9VJ9pvpzyDh35qZUR5U8NfuknPo5WxjsEhI6RmN1ixSVsoarat00e
         5mcNpSRoIe/HM1q93uYftsNiUsSDI2Pf8fhkyN24zVilhK+tB4jZLHj6rzkGBidKT0yj
         RZA5mIK+F94wd2W5fxN484wMHe45f5eMNW/m3DLRXN1VegoI6uFNFz8RPeTuVKMCne7k
         gonLTCCjOMALyGgOVXpqc1x+2HdwYaIm8kxxLYXG/u35uj7GubPMjkSNPP7p/Bqtrckp
         s09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785441146; x=1786045946;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vwVWNRy6nalbM0tK/ypHZd0adndrVP+y49fN+aH/CbI=;
        b=s4r9HFQiCFF30ZUYAnVBdwGcJxgySwHy7sgxBF+enDw2q+DL/HaSuBgss9g6ohp/mg
         dS+r/bE9i2J92A/ZfwIt/Syo0Oojf7pDf7g9CfCYnrid15iTT9H9eIhfgWSmcdVpI34B
         r0oPygb4sBnCFKTApqqIA3huk0HFQqeu7znNmgUtA5Ou7BahKg2hbVpQtJGpUWrJDdzr
         aQzohWRjFrNINdFPyw43a4t1MxZItI8pEweSmnHuYMppUjyutRXtwbMKEKlGG0dgnAvC
         6cBMYVOiemBoj70DlNnCLBqfjVN2OIJYLzrh7+hDqchC3jb/yMRak9MUdFpFJ9q8uFfN
         8+zg==
X-Forwarded-Encrypted: i=1; AHgh+RqKDBHADrkPx48KAfbVgL5jZFpHAKithu51RAi8YBQUvbXWpro47qvrOZF7aRzKpF7AToIBtxISkyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIfTk/9w34cHzszuAZNWJLXSnEGUavvolm6jNrTlJ3tmXMCqc
	TZTCYecMZH2MOqu9HAMK7EBjheELXR16SyxwkdvkBaVdmnbPvhLLb2nN1IX3kY4ppzY=
X-Gm-Gg: AR+sD118B6B5MsnW4UnUQVl1soHseM57GdW1s8s0umc1Ld2LbUnKtuCpWW/e0y1P32G
	Y5GZuIRip+mwfoRt5TnYaX6q6+gEQBhJZyAXX4ZRTWxEoUWupi0BEZHXAzSBJ58v1Nfi5Nw4lAF
	CAT8YyVfJJHrXZVaOb25uA1w+Hgo70fMPJXA3gDDi+wzCPv/iMoUfhiowJb8w8PrGmz62coQw0A
	ZYE/16R5TrroN4Z7yoI2BRJD54zPEIKCV6RS7rM1Uy3KYWBco0ta99Zl6x2PXsbYtUurH/KtES1
	ixXPTr7pY4OO27LDDqJy1mzeV5HI/fP+aERBaRe7nlVx9ss8u/HGiXd18CZYa2Z8XyjvQF8A0cw
	G5uhENe6FJGR5HZMlaAjJjKHFfEt/96z7wuSaQsPkr1ai0yDtxKpcI3cGgCuiB5kNheXpurneXV
	1X0qjJovVUn0xy1mZLv7JxEttTk6pc0U+NbC9FZALZkzsThSxVLncWNdbCxNXNde6J1dMKGp16y
	Whz7g==
X-Received: by 2002:a05:6000:4383:b0:47f:9254:d45c with SMTP id ffacd0b85a97d-47fc82305a5mr6432813f8f.31.1785441146101;
        Thu, 30 Jul 2026 12:52:26 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47fc892cc3asm9575726f8f.23.2026.07.30.12.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 12:52:25 -0700 (PDT)
Date: Thu, 30 Jul 2026 21:52:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Conall O'Griofa <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v3 3/6] iio: adc: xilinx-xadc: Split driver into core and
 platform files
Message-ID: <amuqm5qdzXqKutPS@monoceros>
References: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
 <20260729125455.95893-4-DileepKumar.Nagavarapu@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b5ow5tkqlkhhbeq5"
Content-Disposition: inline
In-Reply-To: <20260729125455.95893-4-DileepKumar.Nagavarapu@amd.com>


--b5ow5tkqlkhhbeq5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 3/6] iio: adc: xilinx-xadc: Split driver into core and
 platform files
MIME-Version: 1.0

Hello,

On Wed, Jul 29, 2026 at 06:24:52PM +0530, Dileep Kumar Nagavarapu wrote:
> @@ -19,21 +19,13 @@
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> -#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>

I wonder why so many people recently add <linux/mod_devicetable.h> in
their patches. Is there some tool that suggests that?

Anyhow: Please don't. <linux/platform_device.h> is already enough to get
of_device_id (which is the only *_device_id this driver is using unless
I missed something).

linux/mod_devicetable.h will hopefully go away soon, so each patch
adding an #include for it is annoying.

Best regards
Uwe

--b5ow5tkqlkhhbeq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmprq3UACgkQj4D7WH0S
/k483wf+OGssOXqZyZNhVlMbxIFkvol7gw7dRZpH+FLGCwaz+YoZOShc6uF/dy0R
toxrO3NuL6fqemrQygPUT7CDqUxs2H+fpREr6fqwxp28MDtOMojPvp98Hz3WkGsy
32ONJaOn6e/cqTNYeRBts9+710rveP80zM5/iO5Hl2srSXemwjlip72uWRymUdme
lJLVrZbJJMTt2zVeJIfx0HrstM+ZeG8BnU0+oTSoUaFkfVRbeyJYqmifZ6Y/jtB2
gaTmouQCp47MEEUcEmXHf3tJ2o4Dt576bsXp3x++/XW3KCYvHgA+HRkgLWjZ1QNz
TfvUbzG14aw7+PZE5PzAT3zdD16KaQ==
=rINs
-----END PGP SIGNATURE-----

--b5ow5tkqlkhhbeq5--
