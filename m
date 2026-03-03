Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044248C8A8
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551983; cv=none; b=mQeXcRb3svDS/3EQRReFx3quAHmbiH6Ts8+Nieky12SyaTEwxF12P72VzQHYD9siiW/LKPu6qGH8yC162HmwlGYymMGGnlvtzkWyzuf2harVsRof0b9OrRfXElzc4ra6HUn2MAK2utoVa0YvvHR98wGrHj0AcPvn8tBoI9dIFvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551983; c=relaxed/simple;
	bh=knwC9kgWxCDIFBJO3vP9PPOshHwAvt3OG83B1MAcs88=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfk+wKSELbk33MUYDnGRYJLa8nT7lHRBy0q/fJQnDbmmpR7n2Z3AP0jG8wOFvVr8fcbN1eWRBsNzfxqiyT+jKJHFiSjbgTNK57YRxRgg5HWpmWIL2i/lpHostXwf9BIU4TZ9QPBuwegRoA/XjRD94sI3MRIl5wSON5o0ovYKdJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Phmrstvm; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phmrstvm"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899fa9610bbso36049226d6.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Mar 2026 07:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772551981; x=1773156781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wPgQdUkfXvNqe1a6vfoPwswDnD6ALDbRdn40tHYbZAE=;
        b=Phmrstvmz+v8S/ut++d3KkKxW7MdTVBqTkAd7t2DhrB3DKpEFTh4o7dLITJqdJtHfZ
         Gc0rh48A+HvBA6/oGinmUFS7dxTH4XV1dENC8kYosVIqS0jcKM3BJ5nUBYvIWRUUH/v0
         9yssB+FilG7N6In2MXgHWqrMwf0ru6+1CjfbyxKXGGj9XpJAZL9KpETTc9xSZRZtvwtv
         DJmFuKqln0OVESlsy1gFeX12JIW2wBNMR9uomm3NE99rCLMTs1E0sDBuZN9zGIvA3w6T
         nBnpeJLCgIl0jffeUXD770QZ+ZsxnZlmVYoBQorzIBM/PdARlzlbTSAr+gy9X7vGfK0c
         L1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772551981; x=1773156781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPgQdUkfXvNqe1a6vfoPwswDnD6ALDbRdn40tHYbZAE=;
        b=WtBoCFFGQNa/yiqsedXgqrdIDSTXY9FtOZ7sxSoluvadj0IKEkx4bb7lpZn8NVoUXr
         p45Q+WcRL8s3q8kO2L1TtBc0RXt9dgis7UkhxsoUf7u8wd7uLNME9tH0Lk2QYeKtVdFI
         wELC6YK/PQmUXwQ7zOsqzKL7N52GBsMAkfqGJwtd8KFxXkB1uyvsgi1zAEX3BD9C9zlc
         Dysaar6+BQbMti1ksGAyeygOF6/OENuQb8EmmWOToTfgcEFP3Dq8zCN9+po356JBFIh3
         2ux/X7DNvSvjUn8eZLtsAZVW//vWTOURUC+PnB/ACtS8IrLcwOLpBWK1OwdMBIJ4p4JY
         2vdg==
X-Forwarded-Encrypted: i=1; AJvYcCW+a5FhAshVmWJDZJi+ClU0Eu8XvZ/2obNfYamMVIMGkIaDBSLOQ6HarfZ2HVHByQIidc0nxiOrNRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt8PIJMMH5AOxYTw3NOdplpG6EiZeqSqp3H6E/SELiTnZYr5UE
	may2mCcLsSFQuzAFB4M8aAgca0Xm+JEFW7unWuXb411OwU1uweZpp2Fd
X-Gm-Gg: ATEYQzxSOy8CK9Ui7nMdyhE23jUi2LuOFoWD/ETVSjjHhJ6cb2G+Avwdin8rIprNCFM
	r1i2OM2zNYmux0nBO4B9tM2zUNl+jJmOgIHnQCTI6aYeYMDQwRmjdzP8MpTeKFvhfkuzfDTdwKX
	aSfgD5c7gmL6Hf8B/y2aeP8p5nhJd2n5C+rKx7BIHSm158/+GsY0qYa3Tg2XA30rQxqgkXYCwIq
	clY6CzxTtGlBMgs2cXQnRnarXsXfES1F33rxOlFvBMGvnuviqKviy+RUuICZKrRfsKsTDaTM77l
	QFzuDj4hePVCUvqibyfgwEKoit3dfZPeQKfiUYkfIoQ2DWoHyPZpjuZs0dPWJqp3fzAT3C1pIFK
	nADmTYTaqIt79GwqCHzGq6TEu810oD5rMMxDNaLQ4oyTysiHtNMd3Jb/HSVOwwtOzIEq1Obpc2g
	0XLRSozmwXhFBu5BXl36BuboFWX2gECVHXDajnmnFwYyKI0NGUFNyMIBWh/98oZCsYyia2MQSAr
	DI4in/QWAM2WstfTi8Ing59CnA2CnX3A3mXW0eaC/80vT505Vk=
X-Received: by 2002:a05:6214:19c2:b0:89a:360:3b72 with SMTP id 6a1803df08f44-89a0360409fmr84242466d6.46.1772551981046;
        Tue, 03 Mar 2026 07:33:01 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a04849cb3sm31946746d6.6.2026.03.03.07.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 07:33:00 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Tue, 3 Mar 2026 15:32:49 +0000
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 6/8] iio: frequency: ad9910: add RAM mode support
Message-ID: <4rzqg6gax4r3symyoimekikz7p4pfwjzhfamjudk64f32675oj@nlrz53u56p55>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <20260220-ad9910-iio-driver-v1-6-3b264aa48a10@analog.com>
 <20260301133153.7f2f8501@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301133153.7f2f8501@jic23-huawei>

On 26/03/01 01:31PM, Jonathan Cameron wrote:
> On Fri, 20 Feb 2026 16:46:10 +0000
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add RAM channel with support for profile-based control. This includes:
> > - RAM data loading via binary sysfs attribute (ram_data);
> 
> I'm not sure that's a long term viable path.  We either need
> to figure out how to do it as firmware file load, or via an output buffer.

Could you develop on this? it is not viable because iio would drop that
support? using sysfs_create_bin_file() directly would be better?

> Firmware load would probably be too static and I'm not sure quite
> how we map these to IIO output buffers.

will investigate this buffer route. At this point, we can have multiple
buffers, right? I have the DMA engine buffer working with the parallel port.

... 

-- 
Kind regards,

Rodrigo Alencar
