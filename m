Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D0738B7D5
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783263851; cv=none; b=PrT6tyK2vdDV1H8qsXa6vXcPsD6Zp8DbpzrHF7QoH8DnGMQWl6bjnxwUcypFv0Y1ha57eJLnMs8kd95TiafNMjFyL2dpbKxny/3KoKDLVAGKWGWg51ptmSH4fZBp/2tzATxJKAWXVoSVTSFd/ZyMJRcHxnfs9CIMm7jssHQOddY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783263851; c=relaxed/simple;
	bh=xDmpCCfiVsMSNDriEdlqzNwOZLcxeATB0tFwGgiZPfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RQg3y5bQwStld4Joy2X1+8RB7rCdylxq8S8rOY8PfrUVbMnrQ+cLXt1Mzxt3MLBwcDEtwk5i5ZsTY120X38VZfpcx7chOEuPPh29bw+1Luc7BI8P2RMX5CJSRSaY3u0iHJIeg7Nq5dRhK+7tpSg2+wIXRL2uS2bgN5mV4h5ZFII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hp11PzHx; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hp11PzHx"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a198cdc4e4so655060eaf.1
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783263849; x=1783868649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVH3mXWR+NE3Ci3wEZjPa2qoxNuA5tsUKMUk1a/4Mig=;
        b=hp11PzHxjo1W/wEIDzICGyjfOEfzfpknFMRartUyANjSTRDyqfGL5mLAnZOPWwI5A+
         C2PaogZf8Xcpswb/5nnhbgvTsvlEymPrxFqCIhJn1kud8mxP9ji2sIQ5NkzCzB9WBjjV
         htjGY1E3NKB+VlneQyVlq1O2qVDY5GHM2UlokIFxlppP9MbF1X6b1ZGlE6s5dCxTwDv+
         Pl1h7U58V2atvlsU6xyDkiqmITXFEqxYxJ1kAKsK7UE3oZZG7c1Pl0w0bO68GLM8retb
         WVv6ZTDyh8hHmQlN0OJn7SBOPIMUD1EoJVYZxnllxt6UzVjSkRooDI3I1iRi7sJQehzZ
         AyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783263849; x=1783868649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVH3mXWR+NE3Ci3wEZjPa2qoxNuA5tsUKMUk1a/4Mig=;
        b=LXiINkiB8prUaqGFj9egVNUc16/8/MGvtffcVfCO43jMgJdo8AmfOY2FcmwnV5aNRX
         2V1iP2RPXQ+345b4HEEKFRuK4StmzM2FwbhyUBgWGWDeyPMmGy4LzyzkmeMTc7xrhM8G
         SHXA/I+jLeARq8Lk3prsr/taJ4SeY2WSfSpjWq2XtSqxJ7cSWOxznkzYYPEQlnH1lWki
         amqBhvL/2m+sViMTR9CGyh+YHg8MRcwxVkH8C93Rw/B6soPKEKyIJknoxn43SPqp7cuB
         g6NTqO1ERYL2Djw/6vEkjm6Hz1scpX8rlKP7rukTLZaeywR2+ajHogL8/KGLB4C9dROK
         FnBA==
X-Forwarded-Encrypted: i=1; AFNElJ/BGL5CAZqITHt/GChVbOk/w/mHuwA6I75qa/gGOqx5NxneM5d3Rm8WF3Kt7G/PyIuTTIJPA5f6aQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznWMzau86rj73fjjHJhKR0owldw0xiyv6zT/xEHEk2OK3OFsAe
	O7NzG+J712y0iRsbrXB+5e91Y2W7NIQYl098bcjRszi1FhzzsJ2n5dx0
X-Gm-Gg: AfdE7cmad/d4X6+NKJlpcKKCtmaXy9qGwxaNa3pI09DW2NGsGyRUa72AeT+Za2Orojn
	3dleAW8f9q04EhtXalLxlVPmfUdd2nFS45UdEYUrbOWg1auVWEunUer55d0n8C03mfYw3RVwKpl
	b6UsQhziWR3MzmzgFMY67T/Vuxb9SraHQCP+Rb5LhgoBKpXAvvdNFY6GrzhxMSv+A86Vg664LkO
	rAK/FtOsM79QygGvqH7e2dno3+zbUuV3kS6ttGsdNO3IN6v1FyKIS53P4UxHvdPodWtr3sB2EEm
	I8nOS9g/OLJ0fCnWV5MeYGOBX2rJ4MJFo6Yu/F67hKF5qM+yFlg8bS9QzzuYvZqyE1rX+Jp93o9
	xJfsfDG3gTFlhUSq+R1RvdjcTCn6Eu3xtzrABHC8Jtt5npn+zWct7D6UNVM9sS9rFFQzvbSxiP6
	2aB71U+RHXUy2oautQn87izDeKLvqbv/si1b3YI0KF2A==
X-Received: by 2002:a05:6820:3096:b0:6a1:7cce:a3a6 with SMTP id 006d021491bc7-6a32f5a9c42mr3716595eaf.54.1783263843948;
        Sun, 05 Jul 2026 08:04:03 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a310375f67sm7263111eaf.9.2026.07.05.08.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 08:04:03 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:04:00 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Avermoal <avermoal@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal
 Simek <michal.simek@amd.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: convert Xilinx XADC bindings to
 YAML
Message-ID: <20260705100400.402a91a2@linuxescape>
In-Reply-To: <20260705085308.8819-2-avermoal@gmail.com>
References: <20260705085308.8819-2-avermoal@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi there,

Firstly, please wait around 24hrs before sending a new version and
additionally mark it with [PATCH vX] (where X is the version of the
patch you're sending, which in this case appears to be 2).

On Sun,  5 Jul 2026 14:53:08 +0600
Avermoal <avermoal@gmail.com> wrote:

> Convert the Xilinx XADC binding documentation from .txt to YAML format.
> This conversion is part of the ongoing effort to migrate all DT bindings
> to a machine-verifiable schema.
> 
> The new xilinx-xadc.yaml file was created from the original .txt and
> includes all necessary properties, descriptions, and examples. The
> conversion also fixes a minor typo in the 'xlnx,channels' property name.
> 
> Signed-off-by: Avermoal <avermoal@gmail.com>

Sign off with your real name (or a known identity) to comply with the
DCO.

> ---
>  .../bindings/iio/adc/xilinx-xadc.txt          | 141 -------------
>  .../bindings/iio/adc/xilinx-xadc.yaml         | 186 ++++++++++++++++++
>  2 files changed, 186 insertions(+), 141 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-xadc.yaml
> 
[snip]
> -- 
>
> Changes in v2:
> - Fix conditional requirement for xlnx,external-mux-channel (add
> if/required block)
> - Correct reg type in child nodes (use maxItems: 1 instead of items)
> - Make #address-cells and #size-cells required under xlnx,channels

Also put this at the top under the ---, it's very difficult to scroll
all the way down here to read it.

-- 
best regards,
max
