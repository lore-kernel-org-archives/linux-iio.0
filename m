Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3852441D234
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786097784; cv=none; b=snGcL6O1iN1Xw/ywGwoYwh/7iZGBNx10hB65mgy2VZGqbGAbn2EFL1K5h224Lmanki5pTAmRzabvsSHgLbhfMMl25Uv4fvgV3K14XcbdSqiUjCU4cIXbXtkAuSTSVHOGY1d80E6xUrdIvwqhzpTT3RQs4t46J2U7G6mj8kn3ngU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786097784; c=relaxed/simple;
	bh=tjuDIdXcHrXpHN+nqdQgulN8A1MZpSqxeFuirGPKwlw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7PulXYRVOXqEDlnQlA+Bhzg6xZWIZzFdhFi3HohJCRIkq4DOkZQ4nVu5aXlDlAG9CsraUbNgY1gMwzVnj5DZPcc2lmIYQSxEtjHy8RbwPRkpHF018mXw41OJY7Ji6AeaPfTAhwiZomiUoMM4bab4BDpLaBGg7JazmuMZF7UP+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl8Qti3l; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl8Qti3l"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1985156f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 03:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786097781; x=1786702581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WsgVrGgvLQa6QkQgWXXH0NidSFfpFOJBXHIkDvCSO8Q=;
        b=cl8Qti3lkygYrfm7o36VS6AG0os0pF97e6vRLL++DyZ6KvODJubL6WBVTo0kESGhvY
         xTOXbRUp8Oa1KCpN5b0WkxNzH6Qvx8G6jjSUXdgjo37U0hhpI7Ko+aNFQl5cEUf7Z+lm
         i1iosLK3OxHb8xy6/gPqZ8BdfWfLdnxhsCB7J0AOesqhuRvaiG5s0jVnSEkpxvfCc2qY
         SELuoWwSvHbYE0hKWzyDZO+qLgXplf/OQzp7FUp9T7JhowJjO4PLxWTD4XzZdKX5/0i5
         +Nn8fCicJ62kwQ5vPb/Sd0qERryfgtc4JWQNu1AprLrcZPA2xHZxwpTbzg/nKOlzr744
         LlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786097781; x=1786702581;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WsgVrGgvLQa6QkQgWXXH0NidSFfpFOJBXHIkDvCSO8Q=;
        b=e0fS76hqWG0acM+M7jNjsU/mDF9CTtoOUDmhcuLSY5kuHTA9x9c6UNATIkizS4So6Z
         JIC8y2HKiNBXWw7xhz6u5rgeHPnPn7GZNAomAQ/u+/nMGT3NkEbkJgExesfGLvTD+kkV
         VfcSMgXi4Zwvte9AV2Xm1AKA/DBldXqoMQTflDxr71gGpAlQOKw7X8cVMoL3UtyCRHyK
         WWNX6DdteSHc8aYXU5mhDNZ81p2NGLQ1F3Txal+sSe29M8aCQWSvNkqtEbnpwdbvLS86
         +YyYmdexg50mzByE2+bU/Wpw7gJVKEY+bMeHPYnPneHnYlOb4GjuGS1hwtZdbCOD9qB4
         6QGA==
X-Forwarded-Encrypted: i=1; AHgh+RouJnkZo7xwoazPTd5/SPTp7LdueJaAV1sbJTbnO05MUU0GHpl2gMG9xyLBItdiu+1URhn+NmOEmkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgYEeZjaBB5pp+H185CNAdZmcLNI+l47GRjpp7Nt1Wo5ebHnL
	fboZyZbkkAw/M3+9iB8F6oqvnpz9Q5XrR2c+/gu1GVFSssBbAEFqN0GdSEIbP7Iw
X-Gm-Gg: AR+sD10DmTG9ooe4FHf0P6nipKPe+4WpOxeEFMuj+XVPsJQIZtcUv8xl/FV5c8J0oIX
	s4BOs3OkKkANYPneD7qtFPeoz3gjPbJmU2ytM54KjPJdTTG/2cUmmXwVCRjumyt070+l0wUXZpf
	VkI731sTyD4q0ccPaLBASflyiQj5fzDWFNbOc9MiZ8Oap4eJD6yV+l/NAUyUODzqkfq8Rw1WY/G
	Vd9iPB2Xn9nKImq0a9mcB1ZqfLzeKT5eUroRfDI58K1pPrWf2cvcLcqL5MWPlD87mzBVJse6swq
	lFj4jxOgE09lGt7+2vtImYg6StMhNZF0+jCwERFeCUiyNs4JmyZ47A2unwv8rtrLJjqMt2fX7as
	HsgXCCHTUt1/XqP2IHXP6QNEDLuGWnkviM4zxZKAs5epINg3VNPGQn7QkzYZhC/7aJthRUMeqL7
	OZdUvdjZ50oMZG3YYlyVjHkPqsdIIvjFMVeN1nZfFXaIJ0owI0ANAjtgVcd9u3okiZ8gwHTEW2O
	uEnjXsCAf3cL9xC0xSdxpLC9QAwg0ImF14QaZ/ep3oIqiSJ3gWCadwNHrxRWRo/zIFFOklvevM8
	lhb2PLt9H1Ws/Bb8RA3Hgkmr5Ptj0CcNiT21+5v4SsjpvcaqPl6ehP/QqJQQ5xBp4q8t5PUdtG6
	r8RZbHNp+VopZGO8kH8qJngVlAjPGYOepvBrebBwjSDJFN7MapQDEoHIBJxTfdeU+gg05TXvbCC
	ZA33Gf/S1s+mzi6yelvQ==
X-Received: by 2002:a05:6000:1844:b0:47f:9c6f:8844 with SMTP id ffacd0b85a97d-47fec4f8017mr30356720f8f.9.1786097781292;
        Fri, 07 Aug 2026 03:16:21 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8b09sm4852936f8f.23.2026.08.07.03.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:16:21 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:16:19 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Henrik Grimler" <henrik.grimler@axis.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Message-ID: <20260807121619.000078c9@gmail.com>
In-Reply-To: <20260806-b4-inv_icm42370p-v1-1-670837f5842f@axis.com>
References: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
	<20260806-b4-inv_icm42370p-v1-1-670837f5842f@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Aug 2026 14:46:27 +0200
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> +  vdd-supply:
> +    description: Regulator operating range between 1.71V to 3.6V.
> +
> +  vddio-supply:
> +    description: Regulator operating range between 1.71V to 3.6V.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts

vdd-supply and vddio-supply are definitely required.

...

> +INVENSENSE ICM-42370P ACCELEROMETER
> +M:	Kanak Shilledar <kanak.shilledar@axis.com>
> +M:	Henrik Grimler <henrik.grimler@axis.com>
> +L:	linux-iio@vger.kernel.org

No need to add the IIO list as get_maintainer will automatically find
it based on the file path. However I did notice that you have a
company kernel mailing list, perhaps add that here?

-- 
Kind regards,
Joshua Crofts
