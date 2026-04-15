Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616F33DEC8
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 09:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246828; cv=pass; b=m+JFkUpgQncIZZnEeAWSruAP/iHM9YrKs+I0/d7BKck6pGcXnFY2+b3G6PRqEON4hxVhW2Wh7SNy2vkFhs7F+58NNRR8ci2kJ/Uc2CtwwpjzHR2b7c/L4DNPa6puVDYCNdUI0kObL/JOpOY6568DFOXyEVfI1vP2MKHPZ9J+82U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246828; c=relaxed/simple;
	bh=64pWA8gqgt0wzz7YiTG8HCy7q3pqFAxMuGk0ywsSwTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O96ux51lKRU2bd/KAYmpAezDGVV/CB6q4a6WIk3ToY3lYqzAp5NkxBRb1K+v+tsGXrkjqv7ChNQjhI5qN9YDKkYrlN9o49Uj31tdh0WAwqoABG1pKFwDUyWHw7bZOf9jDs+MAjqY7hXC3YXcKQLGkmS2BU07iabQb9YAeP1gvLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gp6LDQyz; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp6LDQyz"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d6fbd0954so2753259f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 02:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776246825; cv=none;
        d=google.com; s=arc-20240605;
        b=dWq53yVS1BqClD13zGSaKcRqg9eUy+yiU5TMsBckNQWKDYPH4HZQZyoNtrsPTMvEb4
         o8rO4tmPpIh3egPaNLDx3g/seTifuYsoZiHVmRxlN99y/eVHIi2mk9nGMKFkuDzm4dFO
         hrhu2DXGXSidBhhRSfmSYDVIW27VZ8LpRU5aTx5TYSBfNKG2zztG73bRzBJbpPH3QL59
         JB84PEt3NhoPK5qPANn3HtJqkXqZb8snG2ZKPwZJZuUUeydZ7GKMQQmMF3JoUwhk+G4g
         CraShg3zCX1V2/yOTY3LUubAg3ci/v71tOi5/AAJrSJ45BYSG1BMK5YC0bYwjRWGHIC0
         /hmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e8FrQl1GORWoRsVAUx4h50KKCzvWu9t45dZie8lyW6s=;
        fh=KljSYrDJwMhbbTt6pqJc5oYiXJXdGUT8QCdj1l18GvM=;
        b=FNjgSBJgftojWKrgvuqWW9/+zJ0G2n5+vHemUz6ZSRR4HG0BvgyrTSgkZUkl4poVWh
         lrYfQDoUsTFLrcCIxB53iey5PU/ygmSJ8bHKZFh3EgYlCD8SnGHUCU84SdHablyy3Ntw
         kfCzR257RN/iQQwCgd8MIsNujTe0keERkl9ijQUr2GMXTHiI8rvLExnY1T969NWzBBHX
         MBvg1lQyh9B0CZUC4njtdNj9P7NgX+U0YvT8WVMfwqKZljv3Vl7kGx8iDbq5QCmXt836
         wFQ1HFjXvrB9CD/+So6eLs7FKjpfITyIKrFEhYxPktCEX2FGU4uDjmMZBHbepqNivjar
         nz8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776246825; x=1776851625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e8FrQl1GORWoRsVAUx4h50KKCzvWu9t45dZie8lyW6s=;
        b=gp6LDQyz39uOi6ZuFMSbNifyK9BIE+35bbM9ZOmk+oXd4cs6pM/rRqIynNgbG4C1E6
         q3qKEn8rk/E4e153NhMu3oyvsf9jL65Snfi3EJNL4akLh5B6Cq0DlCk27EE8Ud5g6oIz
         QxAhBdfQ4LUbW/8MQs6SLry1aVBGv8Mv14ZbRh6O65xxPU7TV9PovVnUjfbHynpkKmdb
         KyccljqRqcsDs53+Ryo0TUO+WF+fEOL+ForytZ1YLMVWnSpDtjraYsWyiqrZGbYViHYH
         ku7PPanUgk9FbfXRWwlABpVdojWIB8nr7FdmKKRF8SfDZ8LXcPigmEXJhJUbTQ3p9d0K
         Hw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246825; x=1776851625;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8FrQl1GORWoRsVAUx4h50KKCzvWu9t45dZie8lyW6s=;
        b=MfJhVzSY6/d1RBTya8j8TznRB6WJcUlUTSIbRHQtGiiZd++uBmSHbXkTR43IQpEcah
         /vfpAGGEbYI3ihILlqu0pbmvp/2U5izK0fo6lxlQE5onHaGZL3bbGSP933kfocSdKxvi
         gfcBPhrEji5Ag0/FANTnfISiiNlFUetZoYHNdq8o1xbPwhVKSQ8PtqQyDYfUpDLapmY2
         sizqazaOAds1ZmAh3D+q7cnVTm/iqo7uQo0ZJ6gweWmp5+BLvUr/acl1qAkAN67X/Y/u
         e7Oyk74YX5o1x0P0WPVjt54S8bhThOGDAPgcHlejcDm5BdWvlDus84ACN9LvIAbSKijj
         Pnew==
X-Forwarded-Encrypted: i=1; AFNElJ+qsjjsKeIywBANrZp83hKH32iNpHx2+ISXTSrQs7vA/AZqYgICrtWYzMjNdo28qG2QUx5bQvpgJMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8PblGzCxgL4iNvIHoiwCRR2WVPGgqT8HCMz+JN8mT+Y/ec/1i
	LeDf5KVPlcNhLWdyYgfnlumYHbOQyETqVRMJ6/5u6tYUF8oYD6xHM8wYT22zmBrS/VPkd4YyS6O
	nF3fA9J+ri1inQaf3ftjRHH8gXtY72HU=
X-Gm-Gg: AeBDieuLvICRUYQbjDw/hpV349jl70l/D8MMuKrY2GeOl9GzQ3Jqc1RD2kQB+W+I32c
	dPyVQfCPmmWCYH5vjuwshufH9kDpu8MZ2PwXuH8CxqOBkR9hF1x3ZZye6kiuyC33DnowXuZOEHy
	NG5slPiVyIJpSwXYjPx2iE/UXjao/L9li+KzCRkdzWqGeP7GsL1Ijh5n6UbzUUOC1G8uxkGJx6H
	vEZ5VRhRPoaR+SfWBzAhgjpvokVVbTy9IYM9WtQVRXom2IwTlHrUXlkIldMDp/OCOrqNe/z8LBN
	yzgo6Zx+ut4cD85L0rtcnQ6Sq/AzRqwZn2v60RI1qsS7VfxoJEfwlj9WMTVgXHRTyCjvPndBw+j
	dxCTMRlC0+CsgB/OLHLW2X+27FrIPIfdvpruVjlk8WVW7bNuYNFjLxRLAkPvb2j7jp7Xstw8mPZ
	V2ye/yrWeUd1JcFD9xevA53m8Rmeg=
X-Received: by 2002:a05:6000:25c8:b0:43d:7dcf:ae26 with SMTP id
 ffacd0b85a97d-43d7dcfb1f9mr14007527f8f.34.1776246825171; Wed, 15 Apr 2026
 02:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415080812.1284-1-joshua.crofts1@gmail.com>
 <20260415080812.1284-2-joshua.crofts1@gmail.com> <ad9SzwJDwRNldv_z@ashevche-desk.local>
In-Reply-To: <ad9SzwJDwRNldv_z@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 15 Apr 2026 11:53:44 +0200
X-Gm-Features: AQROBzCFhXFv_nN56n8S4WhxYSp-dtwkJjw5Ad513tzAZnMniuen8n29OrvXZnM
Message-ID: <CALoEA-xy6WApV+ZUavnEipTKiAezYkXMwiE++TjtHuxkVdR1mw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Apr 2026 at 10:56, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> > Checked with IWYU.
>
> We have a (recently new) tag: Assisted-by or so. Can we use it here?

BTW, I thought that the Assisted-by tag only applied to AI coding assistants,
per the documentation.

-- 
Kind regards

CJD
