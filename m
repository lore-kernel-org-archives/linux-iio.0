Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794308508;
	b=AvEwaDqYBkIBwmAlM1YD4CwQApjNpjg0JU2wHngbbny5H4r22YPcuTAQM6tqg65p/iKQ
	 olSbKTMPPXFTwZAT444L/27Lb9rT9tB1RZVda4aIjl0dHPPQC1+AtVVwBcn7TqM4+2nwe
	 7H1dvFZWF8hxlMS13ayqsxlFNQnazuPUWNxm5q1K8qUgpUDoh07D3FatJokLNy7x807gO
	 v/MoQSB2YcrotPx+eMBW1kosnfjR3A1klBvS4R2ubkzKQJ/HSvWCJVE8BSmoO9cJmfV9l
	 728uyPp817UHWut6+HTck1L+0qdaYyyYOOdQRCjfez5KnpwesZ6i/gYBTOo1tzbBRZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=u+pnAEAogTXmyhvTk/a0K5L/Z3iUQwLe7oBpKWqSXIY=;
	b=i5ExWZY1luwHUNrEkg5M+sPq4DCake1GKEFAXv490CgR1kpFWfj9qvLowv8MG3XUN/kq
	 pzDoxp2fUj9demKwUD/FdGrGQ6atIqp0LxcWfrlc4ezIUOqdjZhDJAYNomvfihOOQlRYx
	 ApevM6DCuf9jwwy+A5pbqxpbUFZu0qwo3QqaVELQc6Y6/f9yJ6obldXB/UhdGtZCIGhlz
	 U3IhM41HNE4sOOWYeov9h7gCQYiAPKONG6W32lzcN5XN1qRuUOcQHo6oEcZDU9voOqxbT
	 2/Q9sQKliT0cq92n89Og/nJ0r6KL0oB+kEeE8Uz/bkKbyvNq52RWjehQfsyg2erxStw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IA3+lFov;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E46606A325
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 11:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7E46606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IA3+lFov
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e8da6ef7ddso11046685ad.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 03:01:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794308507; cv=none;
        d=google.com; s=arc-20260327;
        b=jVuIgZ82A495b9XHDjOXLVQ85MXA7xNmK/emBuAz7cPVBOeY811KFVEzWfcRiBu+oK
         7F1CP3SKvHlM73U2Km6sHUrinjCoVphV3WGG8aUu0unCggXap4mgL93R+VLmA6y66GYe
         GfwYjLg1JwxPdubjIZ/GmTf98FuzNqfVjcNS2LZXDr7C0mW77ZKJNflvmruyIkli+ZX/
         Y/tFz7J2oVTQ6ZDydPyhYymHrIwWBOFlQgwfdzAVMrMUjo2n6/mFkrBFQgGqP6sCgvXg
         9gxgfXrOgTD/rQYanoaLgRIzCkWXVNI5bKfLDm+YR9EGJbidheNexqNN8UH2thOJienO
         rweg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u+pnAEAogTXmyhvTk/a0K5L/Z3iUQwLe7oBpKWqSXIY=;
        fh=YMU+tdXnxAhKXiGYVTrsphodcH1EPZ1he0VSXP+JFMw=;
        b=PDKxknGPzlFTCkrHxG4NSkhcAe7+R2vgniuJnDj4LkXXv7Gke67+kRkDyjjaYcD5I2
         vMQLk82AxrQv6rvBra7tHVTknLgd8i0rlK28JSyKJJKSrjKxwtxZ+eLwObM1+u9Q2xV7
         AwbGNdmUoHZ8vQm0NnEQB45fe48GW9JEXrjyZFojq7HFCTlSN/I7jKnYi5Z05RxP09IA
         wMustkYedDOLYm6tTN39q15++5ciPUzN7UTOyhL5/Se6suBAF3ssOlz5NczeuSAVEeDM
         R9rDwzkkUcZvYaKMadlyQrj+NhlN3sJChDpsQCQI81bP2fUOpoGTfMCacc8ilmbKB8C/
         +jXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794308507; x=1794913307; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u+pnAEAogTXmyhvTk/a0K5L/Z3iUQwLe7oBpKWqSXIY=;
        b=IA3+lFov7wk4cck+PKW1kKOX0dUp+TRgOVphQaAkoiIa+yMhmnVT4jOkjFsD/rijcR
         xm255poTXAXwkNJfRg/dE3eLYJNEsEaEk9odb/iEwMVYDKhgy0HWzhupxOlVeyHWhX+m
         mJ/kWccd5xz09Zz7tnlG91DvNDnIp0F2SvgUOro0T/vbqq65J1yE1oYK3Z37r2scvTUp
         UWPw7CntxLoAXSmvb1hdczhH+XnUxqgKv08bkyHh/31zoX6KRMj7OpKs/ti967FkEWzp
         2MYeeeRWp8Z9rOAzucLj0dwrfgxMkmeGQO/qKUHMzcJ27p7URRoxERVx7lrXEnSg55m6
         UbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794308507; x=1794913307;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u+pnAEAogTXmyhvTk/a0K5L/Z3iUQwLe7oBpKWqSXIY=;
        b=nV4Kl0qS+SnjZkj5k4y+x/L3lBdUi5DmrPhJHxqwh8Ri1ZWmph69tFKEtihkKT6b5Q
         KSBvzFgayj3z5X3+AdgcA/ObLQjO1ztkGwb72RqoUhs34PNBgeSpGQIOvx8KICL9QOx0
         RRyXh1VdXce/vhWw8/PjsccWiNTvqwbiNTIcmvg7gdDYkTRsCLCmQFl4WRkuHORZP3q7
         L50UYEZ31Yl0b8dbO9DU0uDVgaU/A+yJPEFnBbJB/7b+8GMksYylTNC+49S0+TWymuy3
         0Hbz2ubHz1JopTjcO19qyQc713nXhSfOGWI9WbyWy8FKQGN75XgJ+OsomfufTKavmj5B
         3Hxw==
X-Forwarded-Encrypted: i=1; AL+hErFEGu9+RnK77cyTb1zgzmIhIJnK5gQcxgIIIYpZTh+myqPe+yP6tyGsbRegWxOW4Ubwj9mjtw6iFmo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+kwbLHhwSDSsBJmb+XlZDalsbvfHo04cHdB8CD3KI2J3BCNuK7
	aFzTFK3hUTIWuSwWzpng5+zdclMYodXTvDNKVbaOsQVK0MsZwI1Bx9uWtrT0ijdX81RooA0/MrA
	jjqHrbkAA4B2Q5r+RhTVf8Ueggo1GmJk=
X-Gm-Gg: AYBFou3xDGsNm1RACVnnkbcLLpBL8BOoSaemlxI024sF9l1xRTAuZvmZgatLmVtPaLO
	KcKeaP09wCEhRNLqn8+zTESgXfvH0QMNLD+2Cp28bpM3HAvx4UnlnbEoh068DxR4QfVa04Gm+K+
	Dl9HHXEX7eWdkOtUgGrrj0JL9kkfDtr8oZbMQfWVkpT446pSpF4P3CPwj2llboOK296kaP54RG/
	vXpvUb2nDUWtI3r9uIT6j2pjjFmG4d6MkIpc1Taje+D1+oncRNIfPurs6KwV6VQGra7kf36rBX5
	ruq8F/GCLuO87znGpUPHt4y8Y3jngFpIo5Knhx+tAY/qxzjjD1UxB34+sN7o9XCkR/Og9T33E+C
	1GiLXicHT9HeSXQ4T4XJAgBlDCOXNmTuebP2ZOCjUqSvL+mT2YiO2uLsx1vnchhdw/3Wkku30Ko
	6K/seN6VbmPylG6Anq6F6BXH3VTXsQ+HXS1CQCXwVoHJf09hn8/JIVmEfPqT2gmXiCn0Kx5g==
X-Received: by 2002:a17:903:2282:b0:2e9:5714:6079 with SMTP id
 d9443c01a7336-2edb91f238emr22931735ad.31.1794308505437; Tue, 10 Nov 2026
 03:01:45 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109084342.51865-1-phucduc.bui@gmail.com> <20261109084342.51865-2-phucduc.bui@gmail.com>
 <avJV68gHL_jvZ6dZ@ashevche-desk.local>
In-Reply-To: <avJV68gHL_jvZ6dZ@ashevche-desk.local>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 10 Nov 2026 18:01:32 +0700
X-Gm-Features: AclHuK_WH4hOWPrihC_Nnz1Ye8k0FcFOdmrzVk9_s62_8IblVFD_31IpCmsJblg
Message-ID: <CAABR9nHZ2XVLj6a3NG-0_fhDWvqZPNa=AX7gJosc2NEofaXfpg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] counter: ti-eqep: Fix runtime PM leak on probe failure
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: wbg@kernel.org, David Lechner <david@lechnology.com>, andy@kernel.org, 
	dlechner@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, m32285159@gmail.com, nuno.sa@analog.com, 
	sozdayvek@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

> I'm confused. Why the PM runtime is used (and announced) in this driver at all?
> Do we have upper layer (like a bus driver) disable power before handing over to
> the device driver?
>
> TL;DR: what's the point in runtime PM here?
>

This patch does not change the runtime PM design. It only fixes the handling of
the existing runtime PM state and usage reference, ensuring they are properly
released on probe failures and driver removal.

If there are concerns about whether runtime PM is needed at all, that can be
investigated and addressed separately without mixing it with this cleanup fix.

Best regards,
Phuc
