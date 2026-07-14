Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F42D283FCE
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990628; cv=pass; b=Ek1CCASkJjVnlKO3xz06JAQ4TkXF2GPTrg8sCTH1p1K+oS35/EVMvQD2cz3ptC4vE0GaUjkW4+sfBKmdWW7hkyhChOcP3/hlbgcP8pDJL0iK3lsAEId8X8bJLqjRYap/2vS0i0Ib99ho3JwD/ZS0ztj8Pm1YF71mv0nUXPMaI94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990628; c=relaxed/simple;
	bh=zBOuK1fiJIvJEdnKEb0XcGLpoyn5VXPUIs3BDtPFNdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqynhUhHQ75haNWjGKLRrp1Ns3zP3RFLr7f0oImcpXVYHZ+9D+neBd3ZMKzA8TlN5mXQjE7dqWNTPR1/mqFLW8qOy/duJl2NGNVHWo4pBz3FbcMAXenKVhjCt2t8XTgwHVNKYJmS4Okhi9dBfwILM6/SChBXzDKUJvcZSIz6j38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkdczLdr; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkdczLdr"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80a123ef90aso9569677b3.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 17:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783990626; cv=none;
        d=google.com; s=arc-20260327;
        b=L6avNPZigiA2MPih8AAV6KvtoSvfWnLHDdIzFZWIP2xY+qpFAcj2v5oFZIEfysht8w
         MY+L7Pzz3rXTuI1HTwtKHKgrS5YWbjL89ShVVUgcB0eqTMHcCYDdm/GLEkFEEPQ35AKB
         074eRVmCgezlCkwNiiCT6AkKpKrXdeNMi/h4GloaqZGqzaSZzahKRszQJhmeUk1w5NYb
         hiN5fFzo1UDlqu8PMmN+K4vtXYZp+3p4utgKBVN4YzrhOH0Jib3RLypofyu014yX+Eox
         yBLYsTtVDsF8r8Me/t28eB1IYEpzlR5lbmPGNzQvDw/OvwrgeVh2pMeNcNbxh0DOnUAm
         llng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qRTzldVn7TOQ3wVT2lQ87Jq3ZB+fgzKs0gQwg01R4AQ=;
        fh=NutmAdDOg7NyaeReBHA8SZTo9lycWwmtFjKUcEgsfZU=;
        b=dJ09GFOJqL45S7xoYnZtct4dJ0Jat81Yn/6gx45tp8lxRZtLYAGWoJL/n2zee+OloR
         NoSNZQqkiX6VnBfMKPOm/66N7pr925VMyTJ/P7RygQhtNn93wUWREnNv/DGxZWao8/qc
         MKjtO91N8CQo5gm6CUwUbXAp+G6GzR+P6vHVPW2uIPrCbdY+sttyG43dRXRsluwDqHib
         4Q0nrWgpUB0CwUZ8tJ2sKpWdSxxo7ny6qROwmK9dxpuK8vH57SFMvXHzHFI2FvGxs9V+
         eswE1NS6ISAA1g6e75cvW0yMKQQnqwyBTB/l7p15gja/edZVCTP9BP8KvHmCKM1Acpuw
         Gfgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783990626; x=1784595426; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qRTzldVn7TOQ3wVT2lQ87Jq3ZB+fgzKs0gQwg01R4AQ=;
        b=XkdczLdrq70FASbqPH0OLCXS7exHrjfyQqcnjyGmzAcha7/Wd+TcDZ6gJORwnwzEwq
         s1Em1kAw9R6Mgy/Qu8wSGcoesE3itTFU1tnS2+XMG4XnrEC1jkVQqp3JxHl2W/FnWiuI
         m+1FRKZJNvd5vmngTfV6GOP5toFBEmeb3m9ZRnyILnYouQ/TAxv8kykRBdGEPWcOpxcm
         bPNBDz720aVFXPPu2tQo70IhyfKNSCw7irBT4tAU3WAscI9KhEd600Elv0SOPwlzEogf
         B1VFfKS+sMPsTeELOi9efTVh9x9MewbxSFm0Wz72Vou0OL/tsHNEVo51d7BIDMxKsh/l
         OlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783990626; x=1784595426;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRTzldVn7TOQ3wVT2lQ87Jq3ZB+fgzKs0gQwg01R4AQ=;
        b=VDoj+wgkVJURDXy5aC0y1eu5GQebnb5YHW1nwFr30R1FkP0p6g0uBxHEJa4Yi4G96T
         BK7LCTY+aHqz95DJoTVHjFmFFHxGF8zcBU+44tqCYh+7hJ7ifTLB6kurDpZZXxBUQpx2
         B7I9L9ciI+40gZ+Wt8niuTYr+qowhKNa+Os0tF50Njfb2debMNxa6mo9UjgxpOFMGuGp
         G0fZ2XdklXTrVq0p2sPed76SpHyVWqUocxTn7I+U36dUqWV3jkDHKOp1Utrjqm5x4hpN
         acnEnQR7/Ts/JRgyUi48Zg608L0UD1TryyL3F25pGHYxFpOUEVCvNf8zgiIFHaXyyvum
         JH4g==
X-Forwarded-Encrypted: i=1; AHgh+RqcoVNUO1N4zy2uq5PPPdCVc6UWb4HuYdD3DFpKn/zr/C8q8DoiSoYI3DE8ojgnYFzyIUDfGF1v7YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxxvIjpKD5yj8/19HYUc/1004DNkYohPkU9IW8D5sx9uUnt7qJ
	bYQ/yT9KnSYKWEPSQgh5I8qvwkF+aWFTGlrTYlp1/qMb57h6GFtX55cfUjjJJwn7G720LJIZQUF
	CpziRgD/rMg4usG6mHhGbTPx7lgk0N2M=
X-Gm-Gg: AfdE7ck8aaU7KA0r7tyvksTLow7ksZLqI0mNnVHbb78F8At/u4eo2Ny06g2epnJyjCe
	ZIAGvik5XxQ+NtYV+L1MXUTO9yUnmIig1NXEf9Sk64FCAATGwQFo/5W6DpvHF2V+RXuLx0yx0by
	KFLWL+GARyPYze2N9VjHZIS5Ky3IVKj6oLZRceJVBdChoEH2wDcdhdTYpLlTU9N0m7SqCpq0jEx
	snm/3EdNZsorzCIb1TP5XYNVkkGTKflNE4Duin1fHS0T2xsX/I+V5ude0Iivh0ZRpRE9g==
X-Received: by 2002:a05:690c:b0f:b0:81e:7e26:7ece with SMTP id
 00721157ae682-81e9087e4famr82465377b3.30.1783990626355; Mon, 13 Jul 2026
 17:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611132700.671322-1-wafgo01@gmail.com> <20260611132700.671322-5-wafgo01@gmail.com>
 <e01d100b-9809-4af3-8f21-055f687ca6c6@kernel.org> <20260612184729.795e0e84@jic23-huawei>
 <4e4ef1ae-62e7-4639-914c-19f49930be02@kernel.org> <20260614161011.7f7946f1@jic23-huawei>
 <84503093-4bff-4c93-aff8-aa07e1a6a1a1@kernel.org> <20260621145117.70b2d50e@jic23-huawei>
 <20260708065010.89252-1-wafgo01@gmail.com>
In-Reply-To: <20260708065010.89252-1-wafgo01@gmail.com>
From: Maxwell Doose <m32285159@gmail.com>
Date: Mon, 13 Jul 2026 19:56:55 -0500
X-Gm-Features: AUfX_mwA2BgyHnPNIz4R8kEeluKzuMzjL5SHhal5QSS7J-VY8o2-IW29ho7SEEg
Message-ID: <CAKqfh0HwuKt-5=ARirHw_-QjM9TLzE2Ravgz7e-sLdxFC+yDcg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] iio: flow: add Sensirion SLF3S liquid flow sensor driver
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Wadim,

On Wed, Jul 8, 2026 at 1:50=E2=80=AFAM Wadim Mueller <wafgo01@gmail.com> wr=
ote:
>
> On Sun, 21 Jun 2026 14:51:17 +0100, Jonathan Cameron wrote:
> > Ok. We aren't really making progress.  Let me layout the three approach=
es.
> > + advantages and disadvantages as I understand it.
>
> [three approaches snipped]
>
> Hi Krzysztof,
>
> short ping from my side. I have prepared already a v5 with the review
> comments from Andy and Jonathan fixed, but I hold it back for now,
> since I don't want to change the binding two times.

Quick update, I'm going to be updating my email to maxwell@maxwelld.cc
so before you submit the v5 I'm hoping that can be updated in the R:?

--
best regards,
max
