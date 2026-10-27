Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089071;
	b=ehC9XQVhFoA1XwVRbVBbopLfctJVGzkelSoBMeb2huCuUq17zdA8P7aNd2yBYbX26qaY
	 QYjsp8gwsPOD4EjShdwyWVmwzdZbxiriCoojaaP6YjBt9zS7ctEqqOqlrzAIT1aikkTIu
	 qvkmCYqbRiXCHEbH6IVQAY6PBZR/ccNh8izSLv+aepO1FaSRj6nAFnha7zEdtuF0dIIWM
	 mxi0EyioKawhcozTNTXxhShp0mOI+GkR8tBAJMuJyZVvXWaONQjXSfuyrPJ380paFHHHi
	 /sC1ABdojb1Ql72KRzEKuchX79+3DlBaTUGjWuTrAUCOjsOSh42VOai16BKYxZb0Qww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6pSRZs9to8QozgPzXBQtkQ5486leq3++5McafqcUDu4=;
	b=ugbfOwKOng87bUR7VE0pD0xjSD8Jc6/SpryXLuEWXcJjTVNbDrfg/K9jEdQf96DQ0fLz
	 0yPyAuGfCkPdtWW7337BbyuTqmjkmq07sUejSo/KN7fbCWYnCKUss+NQquldNaBm41WdV
	 vEy3Zz0uPiJYCMWgG30na5gAnaauJ2flI2stsqJIrceDrgd0vxAoKzkiLvra7aumRUJ+u
	 8vkk4BF8rjkix/JuJ3LYvJFQ3lKxFAOsQy1fZOhXj7TijOrvuW2XEoUvk31U2wB+NMPfd
	 /Fm3QBrQ6FLk6MgCb0G6SFzhZPqt6roUlwFwr5jHxqtP0Ewj6FXgFXL8NQeshNBXtcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W3GY38+c;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A13E606A31E
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 08:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A13E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W3GY38+c
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so24690995e9.0
        for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793089070; x=1793693870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6pSRZs9to8QozgPzXBQtkQ5486leq3++5McafqcUDu4=;
        b=W3GY38+cy5nyGOTXHCSp+3n6w0AYvVRXiUp7A2Cbk8DDVn53KpGA3YH0vEo+qOXf8I
         7FmBu9L5EEOfCdqmeWvs+lTFXCJg3XTuz6XG7PsnsHmOzKk0jXvxilPJYttD4o25udUL
         jA+uWvXmpZ9sjFhO7hdPijqhVKTor05LH5Gigd3IXfDZ5ALOlFLVB4qoYgfGATSEkH1G
         nqXE7YSHSwnADsebID64gYRdcuoYFUHpaaDpeBgu+8RSXk8xlc3Bi4ZwBhyc02nF8cDA
         aOIWnyp7+eBYtLRllxxED0j5E61ih2JASp37+Q1wv9/8wLGtWe4d0Z1fUCPXDnse02mM
         O9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793089070; x=1793693870;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6pSRZs9to8QozgPzXBQtkQ5486leq3++5McafqcUDu4=;
        b=WDH/rh2SVSQcAcdRpJ0lO08HN7UsbCnZ1RSFXw6j2gwRQU8zGVeMMItdAXBPcPWo1p
         GrDBps6QO5ng5GsWZdh2kE/+aSfUPgc7EETwck8aNqxigxNUzXAxgC1QVzUfN3d0MoZ7
         WXnBLqXt9pBM6DGs0N7PwLgqjKqZovuzcKWNFNT0HmJw/zb9beaG9beAspjgU9cPMASm
         o+dqcxBrxvsuHuehucupl7osMqmdt4341kIrUSxaGq4epImAhOPstzrlm2564N/V4GOt
         fsDbIKpTjtZkSixDFGS+JoJQJIC6soOcTRjOHjpensVLdQGPT58KVnpJgGs9yLNV595O
         ib7Q==
X-Forwarded-Encrypted: i=1; AKwUvByvtwXtbnR5K96d4A6r+mvQy2YpgxghIN+JEHX5MeL08tSLIYZgc3/oszes/Aj72pcBjqjIFawdIto=@vger.kernel.org
X-Gm-Message-State: AFq9FYLn3r5PgkmBeiKZ92fkM/oqFq1rcY1721fk81OiXPreAHat7uXc
	H+qOmUtEfQ0YXzxgd6PmPS7z8MsSPxdWEGSxaAT+sdvafI4xSsq9ntFkLTldDA==
X-Gm-Gg: AYBFou2zJt3E7I8H+LXWRnXdJw15l3VW4OCo0NcPr8zdpSv3hsPQDnOQGYTMyoQiLWy
	U1valtWdU1M+WxhxNueWYjU7R9Gl5399Ut/GUlfMcVObNjRViJiYexvbymuO8FRyimHBulN7wkX
	mCyNhMgJxeNtR9wWICYH2UrDKAS0oZuMaaL9qwC5gp4Vt33S+PdQXvBG0eoNArJpKLtJlNsXiNG
	Sd8j9ZJMae2U7IUCykdbE1EZuoOg8Vimp0ZT/vuQpESoWTiMECgQrX4/DYBrSTaPav5c7HfxEHq
	3h5F1a/S6tEdGuRA+9jmrIdlTV4nb/jpQ0KvgzOEHmF9nLsNh/V7MKTdmExUSd3tOtqMAZtMvhP
	GERolabXz1RX2xhqCy0evdMhmpjK4jgw/eNGR91gIoQ0Iam0Qv9VOo9/DDGkLVaEMVBFM/mB5ln
	+gTK5mRSjs61VsLC7vctL+aDwF5PStM1diNqQQ6VMvfQEAqSacI8lE3tsSIfbyTu7/9+c6mgE3y
	cJGJMFZKOCzbQ76eYs4iqwBKUWs/HjDiDSw9+69nVbDDqxK8e2t6wNjeqK3//K4R6etZ3R+QXEb
	M6Fm8lAWiSUrKAiRZwCixBpi3IOdvNuPehXCwQXdC7aBaCOj28axRPwuKN7heuxzg5D3IjT/kmk
	pW0GNkI67NNpMSbwjMIgDmUp9QLyKxqVXJ+GMHdhMaxyTxH4ysKB1K0F/BCEbNz8k30RZ2WBShO
	HCGtBgvUNMbDPD8+pDOMOXpvIfI7OT7Q1iFQ+Vkp5gSbRzcGFmp5LD5Tk7MVlDog==
X-Received: by 2002:a05:600c:37cc:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4a35acaf08fmr170013745e9.24.1793089069570;
        Tue, 27 Oct 2026 01:17:49 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0aa0bcsm311304615e9.4.2026.10.27.01.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 01:17:49 -0700 (PDT)
Date: Tue, 27 Oct 2026 09:17:47 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <20261027091747.000040c9@gmail.com>
In-Reply-To: <SN1PR12MB2528DB8EE8ACEBF9551ED52EA5612@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB252882C0E885BF3368E036E5A5612@SN1PR12MB2528.namprd12.prod.outlook.com>
	<SN1PR12MB2528DB8EE8ACEBF9551ED52EA5612@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 11:51:14 -0500
Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

> +config FDC1004
> +	tristate "Texas Instruments FDC1004 capacitive sensor driver"
> +	depends on I2C

Please add "select REGMAP_I2C" here, otherwise building this module
may cause errors with certain configs (e.g. allnoconfig).

> +	help
> +	  Say yes here to build support for the Texas Instruments FDC1004
> +	  capacitive sensor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called fdc1004.
> +


-- 
Kind regards,
Joshua Crofts
