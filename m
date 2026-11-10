Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794320503;
	b=kv/3X5XOYDEwVkqJTaxTD+jJcK8nS8egY6qqHDOPuclw6yddQPgOCOMRpXWUP2naNKcD
	 m6N5cx8d6rid/rwhVOJiW/+twd5BRXubs8L0igTC4IPTqoSZeiEItFxgfQHY2PZa0pFtE
	 ldpnw5HR2CxEYgJ50AcHZQ3Du/8NO/jJkOV0TnbDXb4/nRJg8R62ay/zdvqsKMAjiO1SG
	 MdV33Pjln+rD5p78asx/0dg/DgRczHUVbAyrcHEC1B0uTjY91w+eNa/clq7GiD6xaG6qB
	 ZkJun8b00LDO5V/6xFPwTLpw5a95h+q9c02+W/e+sDoKOjgD99WuA5/CUmNyk0ntyaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320503;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ejm8pe9G15DYxQ7Hb5OdNIp8qY5r8fdDKVN+ZYBfwxM=;
	b=GWBBRixAcyAFFZr66F4XbmNqWem8G2CRo7cKLtHlLFThHssS0v+0+DF1WKSEQMVH/XfT
	 pUHqHBGTtPd+raMCJO5kkBxv1NRJ6rmWdyEmoc2N5Q2XoPnmqGwQUBUOZrzgw5DC2zBvU
	 DWOiwgqaYZp0AVONs/YJF7My6gn4NIV6njO8jtqHwPNF/CbK8mzdO1T1VbtguMn+Jr+vZ
	 95h2oCDaA3JqYgZw0fyYAugD4wvb6MZlgSRiD1sNSyDwIeB10zQIl3vMofi89xWaNk3oS
	 RUI+SuJbqYo8w9RcYxkj7qwaR0iCfeZZ63bE/Gn3e/zpaAp5GgsVQfYMMIMq0EEMWIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uArSYa94;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840D60A3834
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 14:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A840D60A3834
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uArSYa94
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5c15956ce07so458209e87.0
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 06:21:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794320501; cv=none;
        d=google.com; s=arc-20260327;
        b=OIFKEM0lteMKTSmujfQ8GNCPENC+5cTc+zsenq/549qsIYYmBwXb17/xQYJcqOVe3i
         uI1hm3ZxT+8ek5jDrszJaRX1yr34b2JsSxZBjJb4Ts6Vy6APAwjG90wpYSpz8A6exxPl
         oEtkFy4POwVkscOhfi+uN6saLUG1hqGRdy5tWpKzvW3hUjmzG5hc9KZgT2Vcm5gW4I1z
         kPclnCyE4b+2Ag9WDCCC3Ofisr1UtfmMIhKHuSjGhRPSvH++AodZZ0aukoE4GBg+xvwE
         KziLcG4gRNMm77EOb0sWzCr3P3PfC5qTinU43s166vOWXbQh7KF7ieCTm5d6U06qQswK
         EslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ejm8pe9G15DYxQ7Hb5OdNIp8qY5r8fdDKVN+ZYBfwxM=;
        fh=JaNMA6RP8n3ZuXfLCwCnDS+cY7H2oEPJJS56ysrsh0c=;
        b=a8biuIBn/m8TQeQqSZ95oU1esRCyTQhWHyBs30A0dADnjpuIiww0t50TfmjjFuq8uP
         0ugNoY9QMt8rf95fx7auulfJqCnocuj5gN1r3bnBjD7Dj97BQmOb4nG53irtRCSnR4qJ
         0cgTmTICmrZ5X5fM+kaOKDA+Cgzit0KpAjkHd30dllng27Drvjl4tswV2fHLA09LQWb3
         xdq9TFhcPsz6iKBOrzkuQw60GlpTbPG2HAmCCJV1KIKPol4oM81Vx523WdBz8b3z+slY
         mpVUmhg7/Tu4azUWwAROZCrFq0Iv8ByYydO8M/D5OXF2i36pLTe168OZTLfooa7RI1DS
         CbAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794320501; x=1794925301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ejm8pe9G15DYxQ7Hb5OdNIp8qY5r8fdDKVN+ZYBfwxM=;
        b=uArSYa94ATnFMRAypTPoIZopEiWjn7Q5TSFwOXUFzIXVd3gI2H/IZPRINtu6zbzQEm
         pzUccU7eoX0n2I3adAPcdkf5jZ9Hsi4QFTmUHFbgJYiTTbjBmID6AkvnWbg4NOJjd5T8
         Dqm42cOmZI4RPyjuQkR2/mN0ZfR/aSE8uHmmI//8W2Zvq7cgII+cNDJoVB+7s50E58rd
         0RCD6uBKE015IERTcPJqUkP3latdSh5W/Gx+gcFc9sSQfx0sKWWmNmpKUOcxWqiD+OOH
         Y5ObIIgUTlDOcqBZnY6TxngSwu6z90aQzL9512gnSsayMyEa8pzZG+Wie37BxTf4h4Yj
         lkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320501; x=1794925301;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ejm8pe9G15DYxQ7Hb5OdNIp8qY5r8fdDKVN+ZYBfwxM=;
        b=m++d8HEYWtzRVEcO6tkDWL47JqcfJ1pa6MQf/FCSRwZSV1M4B3suCothHqteWtvmBC
         oVNRt/4iRwOBRyx82NAlOLN2QvEcDKJaxI2MJoK0JDdP0Yh1F/c4dFqPPauH+TadGsFm
         Z7AIbP5jtfNKft4/z7Klq9dk67pcfmcEyQhNJhY6kq3BAoH523nibL0T/ZfE3tRTVlOQ
         4nKBAWT8RRwyG5RIf07FGBQfsh/qswByTNifu9SYjsGUxpsNe8hXD3wZkXz4le6wWjD3
         CMTjEZxGXvIQbx3wOToCGp7TTnci98vZf/CSnVKcsm8TIwCgClLSVmXZu7YZLirhPZ1t
         c7yQ==
X-Forwarded-Encrypted: i=1; AL+hErHkz1PX36ij1bF77toHuhBH1W07WDwYLsxByX0pzvZ48iy48cU8FAnAbUXRIxX20HWMbUATEMLGH7A=@vger.kernel.org
X-Gm-Message-State: APuU4Z97js8yUVykSTyVYAy3JAx4OktIs27kdnSfF90G9NANO2PjfUqX
	z8RcD+tZ8BopvAREdh1URzDE8dBWyTIz8IM6v4b/Bn7CJanvqR/ZYl6oEX1y6QxjTFB//OUDze2
	ND5KsFQoYGjWpEZam7MfQNoTC6QE5w4A=
X-Gm-Gg: AYBFou227wsHf210sqWhnrDnnkLNlTUkL3NBQqyBQDTJp53orB7ZHuAd6CEOCBSg2eL
	ItsHAFrN2SHx3K852RXIXJH6UXe4hUMHa2xrA6xRy4tyjVC9SMG9Noy9Ge8DEbxgM+sP05uuVu/
	hfBJwpcaYQGgcyRV34AmIyd9ZhgXkfbgQXIgrXUllVPVqNRaHXGNSd+11C3ttWTE6oDEPUnV6ug
	vKUC8ew/HnMUcqjsyOrtvIR/po5R+JPL/SGIrvqFQN6tCBJ8J+wKqZi2kiUCOVJ14pcjuM78bnQ
	ggafEqWNei4yhY3eM9r/EKRPa8161n1NygGyjL0S3mvRNPnlWK/VTPolDGsw7zP26j5MUNt4/it
	CNZHvLUxNE3H6M4ULv1MaFzwGb/tE4J44m7chFCfRX1DSCcCXAo0dK1iPzIzbO4iYY5tswe8pAM
	Q2VpCMB52e12+Adiq/9YxbUck6gA==
X-Received: by 2002:a05:6512:15a8:b0:5c1:4bb3:afbc with SMTP id
 2adb3069b0e04-5c156de82b9mr828897e87.26.1794320500715; Tue, 10 Nov 2026
 06:21:40 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018022400.599028-1-festevam@gmail.com> <20261104105829.GI792264@google.com>
In-Reply-To: <20261104105829.GI792264@google.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Nov 2026 11:21:25 -0300
X-Gm-Features: AclHuK-TGMXiiM572Q7C7MqR_s9Ybhyu13xf-9p15OjOQAwSBPcq2XTBncA1S4E
Message-ID: <CAOMZO5AjeeNdeysBuoUoejg0yECiNWjX6o=Q+_iPUfF4=uiVOQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: mxs-lradc: Pass mapped IRQs to child devices
To: Lee Jones <lee@kernel.org>
Cc: dmitry.torokhov@gmail.com, jic23@kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-iio@vger.kernel.org, stable@vger.kernel.org, 
	Marc Zyngier <maz@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Wed, Nov 4, 2026 at 7:58=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:

> If this all seems like too much, let me know and I'll spin-up an RFC for
> you to test.

Thanks for your help. I sent a v2 with your suggestions.
