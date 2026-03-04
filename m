Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2B634D907
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 10:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772619421; cv=none; b=nCyIW8ukUCiL1d3ZxqD1rS7hIJQMe2SVhw0Ukr+dWdn20O3mGA6FXUT8fQbvq+JtCp8UvCj5iWlcPTwwOMpscIPDIA33KmXdwe9HG/fpNZmdQSfsvTuwofiM0DZpmiWYG5MSXnFrE/0EPBztVC1gXNwr5uhJMMaYHZGRc/wFapE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772619421; c=relaxed/simple;
	bh=e78qIDzHbDTqXVogJF+UVOVMy75B++Q+8NZ/1KY9TUY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPvUXH6n8RjLGd0MSiiyQIcDObenIjFG1PLEZGo6FqRd9jD38rkGP56l3yUihvBnWNvqzLJ5rfpAujJ2Ip0AJF0TyT+Pdf3xQccChTJkkExINIf0mxm8+dLPCX8DU6+0buRrf6fp+A0eUvWSAvSh5ThzV69mS/Jhv6o87s9qTcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+FSwpMX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+FSwpMX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483bd7354efso89379645e9.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 02:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772619418; x=1773224218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYB3YNu9CO7wLt2ZT8Xt9m7azMQTOfSk/ijLWaYuruI=;
        b=F+FSwpMXpboj5Xote2ENRoHs8jokK6NZkRGnHXH4Qy3cV3lBdhiex5fHH9wNHAjdhK
         yqGvfBGwjpHrGAR+l6wgHNZa77l96PQY1fJWo2xhuCVwQp6WrSo/kVUGJtLRM+lpwMlz
         tP+31aj1JPS+X4nRNiTwhltna0Em727kkN2S2Iw7DmoBsbn1CDPDOHgMd18NfKRPRqk8
         0TvYXo1BoWGnRr73ONsX444mo+GUDtdoixmN6R+5aBXYazoDMqyRZ9QHPbl3AT1nnCk1
         +/K1DTBEv0BP29zEOeRkYIjutxE2ZIuX7lhUCht8CRZhQInAqHabKMqS5C73FREKZnDG
         otzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772619418; x=1773224218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hYB3YNu9CO7wLt2ZT8Xt9m7azMQTOfSk/ijLWaYuruI=;
        b=xVUT6WIGMwH2dZX3qE6FvDuzIWE1QNyhEcQ/G9/NN5YvwWJhEvSxy4tKB+UOTEHC5e
         99R41mDesMAu51Tawui7Oy1ktFeI++PYR0N2DNjdkClnafslz7Xo9ZcOy8AE/AoPYbLV
         ygYYwgXV776msO+K1O0RHtjDb/3dVJrdS0Hm+NU+Cv4qJZ5c3/XDa3+1cUdEyT99L86P
         E+XeEg+/bL8xjsyYMGaEkVdXByWqzAeLF50TnjSmGoraME1H/338VdLc9VAbPkzZZSZ2
         UromoVIj6xBV4ovZoC8l7mR3EDaJXfB7kUsMn71z2uEixo5avzrpVQ/dSfQ08UjEAzW4
         Ng3w==
X-Forwarded-Encrypted: i=1; AJvYcCXSau8WZE214iAC3E4bjIfdY7wxFXnJ8BT0iZiDqEcjp7nYoV5xFt+yiHvuTmo94o5ag6zcYKwfdTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySCtpgCfcnN+o4za7IHoGSJtmeGRSDK5dFbZFV/TTweD2D3Kkb
	cVToqX0yB+uMaoWJ5s7oaj1djlevIqujKtx20kBRRnM8ZM9ERy9Rzc7A
X-Gm-Gg: ATEYQzwXO4knNOhhsh4xKMmZYW4GP7MSDTw5T8vsEwCO1tVbM5GSsWrh5IJK6s7jrmL
	qZ20kwKFIl/JGYLhL9OK9Ti8K49RXIfEBKLdEtRbWN3qxRADcmcQJlzB6zB5ioe43Pn1gOrMqH9
	tYL5h3cHZ0CenZF2pkvWiPEuCmA698MF1PWELqRxLSxtEljeBCEzKiSjsR8zgfqx8haybNeQhK7
	DUxePS2Roj9KuU43lEW1KjCQVBF/fhtIfVaB9AGzhqDgB1owSUxHP4iSM2MCx0EJT9tzKC3Czf4
	qqyHBjTTDP2d2+aEvMuBRLIcYeiWUL7WJp/+1S8pXmGd5pIAmabb+SgBEh6sxY50XuB8gbXHnpW
	l/Q+t4E+MXVmf7NdYgSPqdAqC1/n1zvP8dpSE4OFRs4Zp2pOtS0beR8PS669yw8E5hOZTgpxyck
	uZMJPujRUsONbneUrp6QaG1dfIbtlPPf/WCuufyV3Hov1DL8Qos19GVwcHV2CUZ12m
X-Received: by 2002:a05:600c:a51:b0:47d:3ffa:5f03 with SMTP id 5b1f17b1804b1-48519886ca3mr23059915e9.21.1772619417522;
        Wed, 04 Mar 2026 02:16:57 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48518839ae7sm36391845e9.1.2026.03.04.02.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 02:16:57 -0800 (PST)
Date: Wed, 4 Mar 2026 10:16:55 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v8 02/10] lib: kstrtox: add kstrntoull() helper
Message-ID: <20260304101655.620df7ee@pumpkin>
In-Reply-To: <20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
References: <20260303-adf41513-iio-driver-v8-0-8dd2417cc465@analog.com>
	<20260303-adf41513-iio-driver-v8-2-8dd2417cc465@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 03 Mar 2026 13:27:07 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add kstrntoull() function, which converts a string to an ULL with a max
> character limit. The function is an alternative integer parsing function
> that does not require a null-terminated string. It becomes a better option
> over simple_strtoull() or kstrtoull() when parsing integers from a buffer
> with custom delimiters without having to create temporary copies.
> The function is consumed inside the implementation _kstrtoull(),
> promoting reuse.

If you've got custom delimiters use a function that returns a pointer
to the character that terminated the conversion.
They save you having to find the delimiter as well as taking a copy.

	David

