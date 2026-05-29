Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD923394B
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780059080; cv=pass; b=l/90OGog19vLlwLAkgjCKAEsoL3vek4GuDERUENSTmM/09gLKdMPEniqsRfjRH2DQaFoJ+Vpa6bC+KjuzORFHwIhW1SDoTS28AfGmj/brBARDjWbZ+EJcAiv6HPipdX0BvRUfyzLMrRypBz26t2iOnwqpr0Yfu/oeLOgwHi5ZZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780059080; c=relaxed/simple;
	bh=ODkGxCw5SXtPHcQOjgdJU6FKSQ/m3pZ1pyOImUBC7zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qi94OFkYcZjFmWIJdi1EkAnIxHSwStqeh4lWbgP00P0rtyOcFJODzed+7214wwbAe29820A/MOQZPVfgc6xYXl/qIUgtJiZaNm2eoqFP9gfqcrWtWgUgG/nvYS6F7EXBDE0KRZekgZEAQ5Su0QJvVzVbsIIE2nQL0jv9h4+UGvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vj6DigeZ; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj6DigeZ"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-304cf518c9dso2954456eec.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 05:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780059078; cv=none;
        d=google.com; s=arc-20240605;
        b=HPqeHGCk4+g4sE9fBuhvlSmkHO1BMmtzHXwVt+ihkXTGx2lLPabTsF+Gx3GjLu1SBV
         MS5reY2XTd/PFMUqcUpiWpb+un2CPFealTQnR30OMIgAMt/5KTxo/XGQpv0Q23P4EGpA
         wSaW5RyXBTDInHeBMw1jO9MSNG6V5z+trs+tCKE76YZp3KxuoH0Ldcu8TP8cbmT4WIzv
         B6r5856L4AelZDD6TxAJGXtBS+LeINbWX6XnrOvmhWlTid/55l3yG82azX3X3GseLbFM
         oDPhZ8AheFp+GgF4A9KLaM0nqY9dtAxBx/OdGtxxYesJh9AhEbdSUVaJmwt+7EhVxel/
         FZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ODkGxCw5SXtPHcQOjgdJU6FKSQ/m3pZ1pyOImUBC7zo=;
        fh=UBjF/oaYi4vC6OARkco+8hEEXBrCV+v5SUUTBWTLU8U=;
        b=SCb423yXguivlTMnTpdUDf4tFvCT2gie6fnBWiYl7IttYm1ffQLtKRGfUgXq4pAG+c
         Gw2Q6aJZnM2FkyftNciwlWHDnyt/hZX2i2o4ntahtxYrSn+Z3syRCBA/WyWixuIPWlHD
         LoQ6X+oHKKdOqrx/rjGiFrEyjCZ9F178TePUhJHkFXbFqEIY4UsQyRjaTg1zq8yIXEl6
         yUoSaJfMVfsPb6MaslyNuJ0Cib3hnMf3m95bP+npv2vNBNScUnVWr+7lKX4TIKffKXN/
         f71qIXK6hIsNzcYLxf2U+py3mBigecxP6O9t8tBt/Wr9atkfYq/+CYaWHs6/ud/Iqo2m
         EoDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780059078; x=1780663878; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ODkGxCw5SXtPHcQOjgdJU6FKSQ/m3pZ1pyOImUBC7zo=;
        b=Vj6DigeZ4VYTLHSS0Ct8oI6PY7PEhHkPmSNBVaXxmkgyD0LpvFgbkfevU3di7JhBOR
         bzZwZ+F1btjPbZz0/O3IT+Gv6ge5wL4Wxos1f7U5fwvhK+VeZSLY8HM865KLvkvvki9c
         LIC152QURm7E0lVUcrs7IpVblyxiwg8VfI7PXNqLj8ANRpH2fcyybEARWnQ3gDDimb6f
         7nEEQHWWY3QS+06QCms6pPBgzBHDoRx4BkgWUkMHsG/vHOlUg/9waKL0gNXUPT1aBQ7c
         ccb8exeCXFi+UjFvXpmBb2fuWJQtN5BxLN7TW6Md3zWLoNX39wf1ryCXwpjQlqMCSPMh
         2QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780059078; x=1780663878;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODkGxCw5SXtPHcQOjgdJU6FKSQ/m3pZ1pyOImUBC7zo=;
        b=M8c7eQzBtKpz3jrwNjrN9hHT5WNRq2d8k5N7NrifiwIteYF6A75MB6jmzaevGL7OYK
         813HZ9wJirAr2mhSl+6D8X7wV0deSTk9OBr0XEbptj265+oPVSZNO6KXwKiewzh/fkyU
         8z75CwQBvD2aCfhYe4pV2xWvnqdodzWkemjYalrrnjMbyvcQDxd10gNO2KRSsaaufgsH
         oMk+AlrUmHjc+WUhsjsW/cohk3l+qWlWM2+kORNthFm5JzczThFtLDO2NbJeNKNXZzCw
         LBdgGlcyjE10Z9PnvOcSIy0RQVG2SUqjiYiK9aVFqPhwgmPE790q3vdFRJe6h7/SfPyA
         WEtQ==
X-Gm-Message-State: AOJu0YzkANv/BA4pDHM2FmQRLFHULSG7+WWguk+tsKffoX1uFmwqMoy/
	LinVANcBs99dcdg2Wf21Xcr7CUROB5rlsokA3BcCrgzObO+BmCEFC5DeuWYopG5U2fcqmOe5j3X
	ZLQn3vGPBW9WwiybRaUFCa/s1cKPNm5w=
X-Gm-Gg: Acq92OGoGm4eQTe+kk78Zp6V6bMRgsqUKiniYpEqEyd6i1OlGGjAmD5JEIfd+BlapJn
	7vKtmUHyZkbWXb1bUnJNfzqvCjwmrpq+1ncvoueJ49/iMKloyBI0k+OjUW66V7rviEfjT8ru3FE
	qBxdnPkZNJtM+wWOPsZ1TQy4P7dfjz26/I8IUlURJMrLgDgjjMA2e3HxvHhVc6+3OUMtbY8XF6t
	li2U0lX1ZX6AJBhCetuC20nPf6RbU9YK40OMm8DNMSr/rC4XQxmy3k3RWZX/VvaBBwXhydt/ehH
	v+X2UJHOHjXhXeILMz3H/5cQ/b07o0fbkjTxZt8ivGBRFrP6DgTCtKbEijwGDqavtdUJRtOzM6N
	i8nNJ2w==
X-Received: by 2002:a05:7300:bc0b:b0:2da:2ec2:64e5 with SMTP id
 5a478bee46e88-304eb17d833mr1328199eec.18.1780059078543; Fri, 29 May 2026
 05:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260524085312.15369-1-kimjinseob88@gmail.com>
 <20260524085312.15369-8-kimjinseob88@gmail.com> <20260528153126.7be7c765@jic23-huawei>
In-Reply-To: <20260528153126.7be7c765@jic23-huawei>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Fri, 29 May 2026 21:51:06 +0900
X-Gm-Features: AVHnY4Ln9TX6I_0W0MRyaA3N1oy1elL0wOv-HXney8IDZR5wMdYVBqFAwE78op0
Message-ID: <CALMSewL7RvTSet3DSk7cQ5Lqi+EDduUOSAVK=vZ5TKz65_9qyg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 7/7] MAINTAINERS: add Open Sensor Fusion IIO driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, May 28, 2026 at 11:31:00PM +0100, Jonathan Cameron wrote:

> As noted, no need for lists. The appropriate catch all listings in
> maintainers cover IIO and DT-bindings.

Addressed in RFC v3.

I dropped the explicit linux-iio and devicetree list entries from the new
MAINTAINERS section.

> Bring this in with the first file, then update as you add additional files.

Addressed in RFC v3.

I removed the standalone MAINTAINERS patch and folded the MAINTAINERS updates
into the patches that add the corresponding files.

Thanks

Jinseob
