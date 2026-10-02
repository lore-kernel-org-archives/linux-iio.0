Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EB0476CC1
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932559; cv=none; b=ldwm+qBVrrX72c8Lg8Y4ROcSf5Ilp985RQUM36HyysNunTbabzrvIIvb6a1FrZfHLfXOBPeNJz0k1qDo9nr5Soy6yp5MHDgif3b9WHN3nRswwYLRlQ3D8LwXqxrrI80+o8djbgonDrjgb8XCOnkVG9gRCtwIa7ua6hQt3YgAI84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932559; c=relaxed/simple;
	bh=RVJuTH9dQx8sPj2A0T/4W/YMqBB1eS42ftDLNOb4H8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2yOFvZ/Q34O0Gb51AnqmS+YeI/WfgPrYViA9Z3GIVnmNon0utDotThhPUSpBrM1vLhyNy2CcXenGliNoHLnAgeZwDUilRm+nEgufLk2RLf0gQgWb04wV2UYKXpel/q8jrp80HMa1m46TQkbpOtNGEiG+7uJVPe1yweuFpQZpKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+92Yi7h; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+92Yi7h"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b017a3be3so2289900f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 02:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790932556; x=1791537356; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jRPrTGUlYlRMvJF+ftPXWXm2emGl+fkBUfXA6bf3Pvw=;
        b=H+92Yi7hVudwQRM/kXkv8j9Um0hz/nUEC7552OqPS+oUYhSotJdckR3vg+ioBISYZv
         0MQplvrETbFoMPm2yGtfbiha3WQ5CDIeVkUcLjjgCNZjx3ut+FpEwRLJkWx3NY2veS1e
         Ukxdbc7/5lMiUVHcUFTtsTvjeg1Sb+y8KCz6eeAFYfoH3YThHja+Y2mb7aeIefzh2kpj
         eRsoLsoUcZKGSFbALtzCbwDF5dD/Zo+Ac9sUUBC1p5OtyPriHRUHvLpsTOo3u/GeqfR8
         7bS4vjTCYPiGolRwMKFilxIkFE9KxxMau1oDMOquLQGJDGd+0jL83cgv+y2pV5zeGOyX
         Pj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932556; x=1791537356;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jRPrTGUlYlRMvJF+ftPXWXm2emGl+fkBUfXA6bf3Pvw=;
        b=lSwjkTqvGQ60EJ/WMnuCJBSZE0DwKFKJf/rukGqHyFJ5C3bewB4vpaWth4Y8OCziN6
         V2JllGHPRWSjQhH9QR6NVB3ghzfjjzq2pvAeTvbPramkVLzuwEyPEHbYncI83ylxKLv6
         rEfxeGSEI1+ZtgQdsrrwcjVI+W2nU1GOIvsO2dlVZsHtUUMZQkx9QdeN5vUUX/KecvXE
         Rf+27VePo1X7mQlBZYQcfif2YYeMlHXjxe5x2eYJ7bPVCqYVYHOx9FBp/l+j0FvTq0st
         fP0TqJccNpqO/lyMyHL7P88nuV49CdDwfWXVK2YHD9tYqmYt+tJ6ty1wTBWQYQ5V2z6y
         812Q==
X-Forwarded-Encrypted: i=1; AKwUvBzmRTLkdJ7dpOvE0FKk6YVK36G4QoUT4vGQuQxqEldvc4+JgIagywA+Z/qRCdRtkUhDJbzO1psPj4I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvd2lcgkVDkA+AM5jNFkyiRJYLZZfpiwSIH6o3GTpqedTltzkM
	qMsDJoUzu4e9igbvK+O1ue2aN6rTgD4ZvlUbuQn55xlc9cjRErI3Uh4Z
X-Gm-Gg: AYBFou2+9hcKoGQCpvchvzHcUM4529Xu5TGfZmXUWk7eR/f/ikwHfM7EJ+0E+ijruOz
	GDe5GL4LKP9KX/3/5xDbyj5n2Epb7ZQYUjZm9YLcQ9KgZgWXGptflCMbcoTjiwrPb60LXxRyP9t
	PVNlhEVb6iKQwgHL09hSoytdOqyLyNUJEQNiO//pk1nEnpWH9BT5eufh1KbnvaYPUQeeVi/s4pJ
	Sr+/InSlU/nE7kdU8KYaN5MMbpyPSYLs7DX1b+9CV27Ax/ivTJOcRWu3l7zkGZ25sgULfX04Hwa
	dS1uDmlkIy3dIzImLPM4Thnp5M/SYOEQaD4e8RvYdKDY6m1901Q4Tf4AvWeZCvl94Me38H7jyt6
	GY2F3cVy1fcC6qIsfVDlc1uaqduEUY6gF4nSa+b992LIFfN2wYmSCS6X6/mKb8SdAYXr9JIJOYq
	N2EHvLKMYvXxzWJSq72GtIGDGZMh3ZLocSvdXGQ43oXDmHheunYwzlginzIr7kfgtDvuiKLnZsM
	zqBW44Dwm34o4NQ5aaaP5IMVPdHGxKBqQ2Xn7RrXeFYiUwRwshc2UGgpB+YDi/QwAn7Aqkre5S6
	vGrQ6HQtOFiVqIepWGluYOS7Ik05oWRIyetebXY3lE9LpiMhVoLbaVspxoPNxriciqIxmIo4ZG+
	OwoBRjJeaNZsZ4t/LIjJHaMzAaMOnk2C6Z7P6Vd6FR6qR8o/iwMwrSdJ7nJoX0vMM7Cru4gMgIe
	txVlTc
X-Received: by 2002:a05:6000:4809:b0:48a:fcec:2a29 with SMTP id ffacd0b85a97d-48b1273b029mr4027458f8f.20.1790932555893;
        Fri, 02 Oct 2026 02:15:55 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f89c3sm3966667f8f.34.2026.10.02.02.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:15:55 -0700 (PDT)
Date: Fri, 2 Oct 2026 11:15:52 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen
 <ryan_chen@aspeedtech.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: Add syscon property for
 multi-SCU SoCs
Message-ID: <20261002111552.000049d3@gmail.com>
In-Reply-To: <20261002-succinct-voracious-orangutan-fdac5e@quoll>
References: <20261001-ast27xx-adc-upstream-v2-0-2f9c15cc0064@aspeedtech.com>
	<20261001-ast27xx-adc-upstream-v2-1-2f9c15cc0064@aspeedtech.com>
	<20261002-succinct-voracious-orangutan-fdac5e@quoll>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Oct 2026 11:03:33 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Thu, Oct 01, 2026 at 05:50:36PM +0800, Billy Tsai wrote:
> > The ADC's reference-voltage trimming data lives in a System Control
> > Unit (SCU) register. SoCs with a single SCU instance let the driver
> > locate it without any additional information, but SoCs such as AST2700
> > that expose more than one SCU node need an explicit phandle to
> > disambiguate which one holds the trimming data.
> > 
> > Add an "aspeed,trim-syscon" phandle property, and require it for the
> > AST2700 compatibles since they are the first multi-SCU SoCs supported
> > by this driver.
> > 
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > Assisted-by: Claude:claude-sonnet-5  
> 
> Your SoB is the last one.
> 

And the Assisted-by should have just "LLM" instead of "Claude:claude-sonnet-5".

-- 
Kind regards,
Joshua Crofts
