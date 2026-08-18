Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A3A1474CC
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787015204; cv=none; b=aUuFq2g9ajwsEh6t4iFRyPrcWWYj/E/em4S3zA5uRfMdovKtxVATkSkVkHEqdr7caipg+k4Jlmsb2iW179iGWuluepmPSKy3VW9iJmtjv8lphFMu9HSbByjoSxQnCgjdO9/hVABEkOHpG15Z1g71K3tKMheBC6JGplVG0NRTpPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787015204; c=relaxed/simple;
	bh=eSPFm40DT82J9f9OZEaNKoqzMUgt02iaejJx5gfUYWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hceS5GN2uy3e1PGiOdTojP9RIAZU5lDn8JzRrdqznqcpHQoOIXQZKnKhZiEDSpWAxbT7gwwC1f131YDdjNBKweOfIql3d0E+TlLod4OTUz9OFiuvclkviBsr751NKfueeTGaRynNkutSd9EonviTs1+DrQoLnP0PT8gUD2yVNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArWaCT2g; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArWaCT2g"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5bfaa014978so1571466e0c.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 18:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787015202; x=1787620002; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S0NWw8TWJUBoUoRaTT3xU902CIURU9VCpckKgBzcPno=;
        b=ArWaCT2gCpZ1uOzJNI9yxUy2XsfLMBF1WQYCRT25DnT4Kdv+1PF3+pi8oB4v+cqNW0
         9M1s6boW/XotDHrS/cdjACswsZRr3/JMp8nHgeeZT6rZPdsxo+qmUHfX7l13OFaOlZxY
         MYBzxawj/nP07BI8uw6+J8H708ODe89/WGII9TuIq8O0dOzbqVvPuZi74wZGn2kZw0Dv
         NTKRKy6ebcGZ24jfmtXqWKkyOflnLyjbFCB/IKGQ5wZIOdNRfNnQRPMvtn92NUrLO9NX
         uTyMsT7fyadpVl7QVE5PO+Ha8wfcznEekC/KBtHRKe1EF3qjvGIr8qITqSVc5fee4LaS
         MA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787015202; x=1787620002;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S0NWw8TWJUBoUoRaTT3xU902CIURU9VCpckKgBzcPno=;
        b=lkVJ3+hc0FL/2gLhbKUs5EDw3wmgnjb1bet4pomh/o0XdHm285i0uNcX8Z71o/0cIA
         j1qZOwqYti2EZAnmc9yV3pjsFjAUTTb6vN2KSNnOB5Jcuwom0nuNeyHIip19VOTAzCrW
         Rvg6UTTkfjEsQhDNagEa8zobmVvP6tf0evCgPIww7JA7YUUDxcgjqE1LMxOWdyz7EJjd
         EpX2K4Rk1zjB4fbMCIHrTEqj26lt0GtTt4L5MSPFtUUdqb+FoVgBAtLwlPfGMgmXAjQA
         ID/ZMrOSnZxeRb8hCM2ZbmCe02SshZ/HW1oEI7rRhbWDxplKq5IkF/EeR8o/Kt8gt/rP
         Ux6g==
X-Forwarded-Encrypted: i=1; AHgh+RomO9PTUBkCRdqU9+xyh2CDcvW7CTmCLMIe9vJ8g9wMVWRopAkehbNjRuuq+QrV9wxmEQgX/rMI/fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMV7fOqThYRAqiFNayti8Gpkw11X4WjW8MQ93qQZ5s0uqzVu8v
	iI77z+S1rq2oh6/4pbaxWIc1BvXxAFgzkZCgQUbErimpZ+MMTd5ONri9
X-Gm-Gg: AR+sD13Tg08Rac/WOFoOS91slPIyNEHzYTBLnjJ4id/OwcM3N9/kl/rLGn+ON95x3zC
	08TYvtMQab+t6Q2DxyMH8Y5aPGNyV0Q7Qp8UHDicpg9Qpmp46Ng6mIYcxKkXZTaZrxzXhv1dxcP
	EyGWd1WJBGV8Wiu+fe2Gz8vpuvaIpxVghLdw5Bdu13JwVy+fWMT4/lHe+3CZm7wlZgoRV/7VrW6
	TRFkkWQVpy6wRzWH2+aXO9ZA13jofy9bBers/wt3t+7m8QcFXhLJrCSEDT/ukpLXjAT5mBIXHF3
	DgSu+Hoq3ZegCbY9tl4slNI47ZzrRp0BSAItR2Jj03JZJU6g3+zFiUN1rABv4+cIJm3HiHidwkN
	9Kbqeap3oToqytAM0pMIO4GfDFx21+ZzxN6Fuy/OAu+Hv8ttu83vT8igeJwkso7142o4KcgCnih
	3vW6Mt4XgsZlQtqRHntqpS95Vtic2mwBVQZR4GFPdy2zWNlnjIYWonZtgKTlxuY+q77TR3
X-Received: by 2002:a05:6122:50d:b0:573:a779:62cf with SMTP id 71dfb90a1353d-5c5ce7ed595mr1017290e0c.7.1787015201662;
        Mon, 17 Aug 2026 18:06:41 -0700 (PDT)
Received: from localhost ([2804:30c:97d:e800:9454:1179:18df:ab33])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c5c7684cb7sm2331580e0c.8.2026.08.17.18.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 18:06:40 -0700 (PDT)
Date: Mon, 17 Aug 2026 22:07:19 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: =?iso-8859-1?Q?Nicol=E1s?= Antinori <nico.antinori.7@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 2/2] iio: humidity: am2315: add support for am2320
Message-ID: <aoOwR6JMOYPCn4PW@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1786725567.git.nico.antinori.7@gmail.com>
 <83c8a41607ed07285a84dba8ed10a954226076b4.1786725567.git.nico.antinori.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83c8a41607ed07285a84dba8ed10a954226076b4.1786725567.git.nico.antinori.7@gmail.com>

On 08/14, Nicolás Antinori wrote:
> The AM2320 is fully compatible with the AM2315 sensor in terms of I2C
> communication protocol and measurement conversions.
> 
> Add the "am2320" entry to the i2c_device_id table and create
> of_device_id table.
> 
> Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
> ---
Some optional suggestions for the commit message:

The AM2320 design is fully compatible with AM2315 in terms of I2C
communication protocol and measurement conversions.

Add the "am2320" entry to the i2c_device_id table and register a
of_device_id table to match against devices declared in device tree.


I see nothing else to improve besides what Andy already mentioned.
With those sorted out,
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
