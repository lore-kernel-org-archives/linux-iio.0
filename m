Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793983815;
	b=tqbdXjJzaeIGi1Eq1hc4B5ctqEfa+8Eki2wcBKRR5HwtCGP+aVXj2OwiC0MgyCwoSgL2
	 /u6+gnk/B5C2GgqflihT/xGtjRned+NPDfxo292r1M2NPyaLL7EPgy602ysXM+Kh3mX0x
	 QX9gQByewsKbxtgCoXjR5tIDlIELtg99OYc06ezmRIq8mFy1Ojjk6/1C+0b4h/gVh36z9
	 zpb8Hhqmyws2kofwfbn7Ye+I4tJdW9w4J4+0TBcgFVUeaW1YZtLRLSllGel95wbuzrxgS
	 GgERo4a8d3xHaOEksMoSczRZvd1T92OYsAYVjJwrZ7MtJFHzle5eExTUdN/LGEC7fug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983815;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=R/yFeQr6gmoITHwguMOwp6bUn0uPGF0WL3IvUmQST58=;
	b=EAk1DQ2dxMTpBg/lzJzMRbEAJejl/7CKEx5IlWAJnSVGN1BZ+9HFu+E0r1OJT55zsNMI
	 9kAUNNdw4mkQ6WgoYaqqeA5PyoIMYpNOYGp6gR2pclCTLdU0qTcuqBZxrOil3Txu7VlXn
	 Gigo+zmVn8sJzF6g+NQy72QaMCI6fkzNFLuzS+/5d2xrNYHTQu9neD9FgeZvboyNcWUKT
	 vhxJ+PZdyB4CVPJpttAXDtAnzNb6vSDWnvB7OKCKSDJligkkOOaheKVYB1R8GVXhcb0uR
	 ecIWbRp9AWnxcjNTds5lMp1pqvCvoD2BUBaSrOh/0Hb8QUw7f5ej18UkPYR/m0eBjEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ft2X5jZ1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64659606A33B
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 16:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64659606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ft2X5jZ1
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b7252a32c8so7482505e9.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 08:50:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793983814; cv=none;
        d=google.com; s=arc-20260327;
        b=cHMWc7zZkcVuND2LryWU3S20sMsm6EJSlcIG3sHegj4GL/MMo/JbpTs8atKO2lq1yN
         tDwHFxtxMT7o1g6R65+CxbDwpYS2J3T/X/5t6TBxw1q7hpqXzbI7eXM9yi41JJItmy2I
         AY+SKVfQwuYIYM9P2RRKTigV1/QauCxNffkSPIc3L8Yxkz3cDlKXLV6CWErSJBxE/9Nq
         RftjCIg6W5xuobvKXjPlYskfdjLL8UkSGD5Uja8qzczNkdnyHFUT5smMab7vujuQhXlM
         vT3k0BklrPEmc2B2eaUT13pG3Auo7miM2xGf5ZPlFX6XzLgMPNnwPtHkcajj6lwSmqIM
         YpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R/yFeQr6gmoITHwguMOwp6bUn0uPGF0WL3IvUmQST58=;
        fh=4dabMzlMFkhPeCPlPvIGafIgy6AHdz9PCAbtVwVukSo=;
        b=biJwl7slLNbYg0HL6CqCNLyWweVw5bymsFsbiG/rUh0UVHXxnWdcKcqnjeGS4wu6j+
         TAc18cHOwj3pZ7MIpuDzz8WhS2LZDOa85yMLlryMFop4C9xquPGLkBGXMFgQVtQydSH+
         zbD6GsymDl+vC+Mpp8M+QBSQU6WLZTATgpmgNu+ptxAMBXLgC8UiDyvh+M7E2ZJzKN2g
         +KzKlFc0iblSUKUYlor3d7Vzhab+SSWXvGuUjBq+oQGkbqVzACbADsFnfKI3EFsyxFkV
         7LbAYSgnFaUg/h9VjL8XraJp2xs2VrycjHADLeBrycOp6xGDNF+do6G+kemODVWsRWmG
         tqcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793983814; x=1794588614; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R/yFeQr6gmoITHwguMOwp6bUn0uPGF0WL3IvUmQST58=;
        b=Ft2X5jZ1lI8h7klghApXq0FuNuF0U5uWbI/EGwdkCLouO9jnchDQHVZIPJLXe/1X+b
         Pdd6ZX4+fa8VCMFkFUbXpMkcSueTAschYyWQZTZLoNiIGHSmqwCpdeg7dSmZVJdQuH2T
         sHqrmWUQdLag0Yzn+Gojg8b33uc/EgfvEALAj1RZZdRY+AlhdJ7lj/v5zQvnxY7QRzJT
         jSVgpif5144onxVEAXUAr+hqylI+rQhJgqGT93QLtGpQsSv/tOeNxW4WO6/w3hfDKR+n
         OwPghxTQ2FVLONUeLvDwordzrhmb6ugCL7Q4RUxZmly8URb5/Q8NgjAdK2lR9kCFyfRN
         Njmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793983814; x=1794588614;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R/yFeQr6gmoITHwguMOwp6bUn0uPGF0WL3IvUmQST58=;
        b=Z1DINCyJzNc9CjmufC79/lBZyCX6rUXWLMGM6Wwu1NFmXOzXKwYl/pRcbOaFCrJEbP
         gT7maRqH6vZz/wCRHCiKGZUb6i7YwKg9zKHQTAwc3LMby1vi/Gy1Dkbzdbv/VTasc62M
         RRM0gFI4hj3hR8Ya8izDvIrBBDQJt4ivGpsWz0AcfHnhlDce/MLuk5CEyHcskoyy8uyl
         q61+OE7KaQv9zrLFnebEcYF1/22QVSJVtQQUqRYxX3ZgmjMRmKjtHAwWKNuS6rhemW6m
         piakr50ggKTrqb3KmYOyx44izuHPzfp01Ze2EwodZWCHrzJWufc9KY9hEeTPDALhVxwr
         FzgA==
X-Forwarded-Encrypted: i=1; AKwUvBwUTaAAZJW7i1/gFjSvNkfZDGtRtxE0vdHKMxj9Z7fkZZpIvcIIn43H0+k83W/ZdBCCiL7m66oAFHs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/n+M0yKTn1MBpcTsS6KW+6o4ajwsBWZwPG5MOwTi/N7hNQn7DN
	1yzSvi9h6Y7w+nND6jZ/G4CUZk35k0FQCdGXXOapzOWi2JJvyaQqxSEb72hUhMpYNUtwDKDoSVV
	urP40/+six55FS21fH70LtU6l/uWJ6uo=
X-Gm-Gg: AYBFou1aTA/ngrs1LcnW6mridlG3LAffvEI7JRfAR7i2ipehVUNQOqiKfS/7btI/aCH
	LQfO0MexTLiQ24EohLW+xgUll6ryH5M091Gr2XyDug0/Q4momgfx3KVOQFWc34+7S/eB1T40k4F
	JZTzvVm6ipOZ0sWFxISbLXf3CPCG24oaqWmb9pvFbv494KvDud8y4Mp0upALzwLRHH7JQMqpp95
	s56NGqR1hwKhFg7vla2tks9ic4PqUrq6iNAmjFOPjR4c/DPAE4ZmFdZ7v1rOotjhTKZutOUahYc
	HLSrzGZe5Nf9aUvy6/9HtkOQah66gCDgk5sHoOjlS2x5ctsOdNwEAk0ZSuz6Al0Kret98IJXon3
	JywXXa+nbLUmqzl8lveKGgoYcuIntYkwe+aX+gro3AD/8wvh/9xs9JRZU69WuXPGYR0SVWg==
X-Received: by 2002:a05:600c:608a:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4b6dc6dec3emr54790815e9.4.1793983813665; Fri, 06 Nov 2026
 08:50:13 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-tle493d-v1-0-3246e91e6394@gmail.com> <20261105-tle493d-v1-1-3246e91e6394@gmail.com>
 <20261106023612.344f3b86@jic23-hlaptop>
In-Reply-To: <20261106023612.344f3b86@jic23-hlaptop>
From: Viral Patel <viral8854@gmail.com>
Date: Fri, 6 Nov 2026 22:20:02 +0530
X-Gm-Features: AclHuK94pqY4o9kDaIq0ZXjLoVkpvvbtbW1DPpiIVyi1k-5YacPr6LPcR1PnSQ8
Message-ID: <CAFkCdFz6zLMQPiAuDs4U8_6G8us-YoAJAjiT0WzB02=5RfJLoQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: magnetometer: add Infineon TLE493D-W2B6
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 02:36:00 +0000, Jonathan Cameron <jic23@kernel.org> wrote:

> That doesn't exclude using a shared device tree binding (as it is a many
> to many relationship between bindings and drivers) and it seems like
> nothing stops you combining this with the tle493d-a1b6 binding.

Makes sense, I'll add the compatible to infineon,tlv493d-a1b6.yaml in
v2 and Cc Dixit.

Thanks,
Viral
