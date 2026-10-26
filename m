Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008813;
	b=HkwZZQx2DoHnAUZOkis7eed+ZlGwGjzKJjlfIMqtzrFeBTUPDvQHSQonu2tV+hnzA3JW
	 wXPMJbmZApw19bJnjCu9jSFxDNDXjHkGJPJzmWP21xw/SrUEX+b2qnPVNB8NfXAzKBTCs
	 dBsBQU/tIoycDoN0GraHBJE99QRzDXwvs+2JzgYU3yX50OlQ1zujCgRwjqe4MacT4IU+f
	 iC4tOkbkAA/zZyyydWF+JGtyVWAsUB569KegNMSUBbofytfLgIJHV0Rn3wNASd/8fBld9
	 /5nUUA+V3lj5Y8/VtoSqadp6ndVediJvfE/29R70lijj5FZEBUgusNd8RQc6aTQS4AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008813;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JxMaWVtUV0uwXPkwo9Mu+D6xSwARN7kCHxKOQvkbv58=;
	b=xF28XVN5A4llubXQDUVGHA7fHMBdZ6qVCRhVQtIq2pr8v+v5xB3P/a+qCBNIJSxiYD41
	 kiJcaWcUg6kbHy2vY0i+VK2LrxF9iprYsBV9NW65CFllnlPrjRO+1EggUCB8lceS31q/n
	 SiTDvNqckU6vdCOKJu8KqPrm1IWlU3+4aPrLucESTz+c2JxIUGjLSnqPSaeN93BNWztMi
	 hLeaxvYmcE8I7pfVuXJPORMy64vbgRva74tOPw6aSjfJr5iw1aTcHSXA1MTQ6do7LIEOj
	 MdRxk49KYHZt7hORanph6lO6xC7HafhaeSJet+hCji0G6V1cpLJZ6azZfg4iNL+b4qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="rO9H/JJi";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D6606B45F
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B54D6606B45F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rO9H/JJi
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so10713485e9.2
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 03:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008811; x=1793613611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JxMaWVtUV0uwXPkwo9Mu+D6xSwARN7kCHxKOQvkbv58=;
        b=rO9H/JJiNVMoiSub6cjqmC2tT3lU2Gip1qc+hCn0V192ZnRtIPYPHh6ywTdpoL67dx
         u0E7cWwXQA4Ww74WYuBC0SfnqVTzEJ/B0co6Fl6RmJkg9VK36ePgDIKRuio70j+Kniwj
         9WtODl4KfhStM1ILHf8rjV8fU5A4nVmr3T+itpLquLk/w7elg/qrpM255BdimiA3QwTq
         u7mjNK/St9prrUNO6Z8YLgWR7PUBI5gbq1c+4L6Gv5QI3VPRBcdpc1nd3ENyFsQhtl+G
         I7hSH5iUvaEl3Nl2u1zHrqlSOxmu0mqhcre13RDT2dxEFypZ1EKvE7wbxXIStUPHvWYq
         0mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008811; x=1793613611;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JxMaWVtUV0uwXPkwo9Mu+D6xSwARN7kCHxKOQvkbv58=;
        b=WocQ0jxRBVHBtP2F2SqdPrQAYJc+scOxt2KqY4y3D6+3BSDwWEv+qGXCubWhI0aEWM
         qv//qeivXxzc0Md5xt3Gy/8OfDV7tzfic+STgl+uCbxTp9fBkoxqwYK8Catyu3zSmoKZ
         Ohb8SiupeJI2haH386tXzJb5Cfrp/LdJ4pbPXskkq9qWTZ7HL5SAopp6cWOOXxHY4l5i
         Gs6Gn1wHWENOp1sU2lAuO7GQDZZMm+WVEFAeCMaEYher3AKYER6FdmZ5WJhoCHGD8ceh
         B7ZlWvH2rrf1HxKWX//Art73lqZbfO+1yg4xAU+2i/9tnQQ7vnoia/K0xyQ+TKvVZ74t
         x4pw==
X-Forwarded-Encrypted: i=1; AKwUvBzfrNiPnLARqYM9LFokD2rZr8QyeW1Xy3JO4erUHzyYdQ2uOvgfXsSPJ+KCplEwwZIhL4QtlgGHMdo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjy6Kkdq1Iy4clYkvvLGr16reqbc/weBzYmu1UkcGDUF8GO2+2
	4PNouvSqURf2SSGSHFchfHF0LISi0bETUczk2Y0nIhGJTw+GaIMWQ90l
X-Gm-Gg: AYBFou2L1jL7x/pJT5RNZmhbeWbjuD4HMcWWYasAPwnGlHoYITd5H5pxkv+2lHuB4+O
	6s3S8gVFLarexUohBT6tvzqqRF1Gqdvi7S18pX4VhsJkVhuTleG04Nqpn9tpk7fbmafUMRz+PYl
	42pzzQwcdo479L2MJxZA75A7C3+KThodKULqbOj2yiQ4LxebZAs3LFaqxU9NXLdDyahC0kc15kO
	om6+rsD+giV8FLCfxEp/D1k9EEV41NyeZaYPbJlfYl5VL8d68Ip2F3IcLKXGWoTdJS9TndOzLjh
	Z9JxFaKwWjf/yZeA7Wmexvli70Jem58dg5mHHIh+G0TaaUQAWx6xxLA97lZ3W7+vheeS+6slRFP
	H0pytw5gedpMQgNLKuWiSUVKAN7VcR0la2OeoGQ2MPb4O3mwzcuvPV7Zy2KbQxBaAiDGkCTeOKY
	eXQm+KGtDCkMctLAEKwcNUjdo+fIgowFZXR16RSAS9k0a/9/qgzcKVMeS7FZEwPNBhmceCKnZox
	Zi8+q9mq+5R4Xgal7Tc2pcNFYiqnA8HncpKRs82aZ/tqoGe57JhfAGY8tukY4t+spiKa1h14lzf
	TYUcX1HU/RjauIAOXQcOiHA111Ywe81eYpCPjjwCtPtFcUsD4297Wq8NXJOfMRoPRVEwTMaDUsZ
	h2dc5peA1mgX8T2gTuw9hzrIT/96ZE6U3HT4CsPecTO7+Qvsk40AAl9pIh3z3VFwN21j8GmhFK9
	mKsUV78/NkjcssOVQBHm9jE6hXGy+m+d4vm76+lNDSRsmotWIIdoPNKenmZSeg3g==
X-Received: by 2002:a05:600c:3d8d:b0:4a1:f377:5c75 with SMTP id 5b1f17b1804b1-4a35acc2edbmr93717435e9.33.1793008810377;
        Mon, 26 Oct 2026 03:00:10 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359fbc718sm154241835e9.2.2026.10.26.03.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 03:00:10 -0700 (PDT)
Date: Mon, 26 Oct 2026 11:00:08 +0100
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul
 Cercueil <paul@crapouillou.net>, "H . Nikolaus Schaller"
 <hns@goldelico.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: Add a driver for the Ingenic X1600 ADC
Message-ID: <20261026110008.00005296@gmail.com>
In-Reply-To: <20261026083631.48406-3-olivier@mgcrea.io>
References: <20261026083631.48406-1-olivier@mgcrea.io>
	<20261026083631.48406-3-olivier@mgcrea.io>
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

On Mon, 26 Oct 2026 09:36:31 +0100
Olivier Louvignes <olivier@mgcrea.io> wrote:

> The X1600's SAR ADC has four auxiliary channels, each with its own start
> bit, interrupt flag and 12-bit result, and none of the touchscreen or
> battery engines of the JZ47xx ADCs that ingenic-adc drives. Add a small
> driver that exposes the four channels as voltages against the 3.3 V
> reference.
> 
> The registers are in chapter 19 of the X1600 programming manual. The
> ADC clock divider is even, as the manual has it (an odd value divides
> by one less); the vendor kernel writes the divider minus one, which
> gives a slightly faster clock than it asks for.
> 
> Tested on a HiBy R1, whose play/pause and volume keys sit on channel 0
> behind adc-keys: all three read and report correctly.
> 
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---

The driver looks good to me now!

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
