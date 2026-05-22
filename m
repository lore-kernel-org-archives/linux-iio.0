Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE53BB67F
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441137; cv=pass; b=GPkjeQUzA+ovyBvKuyzhHokMPCCEcxqVE1EMankn79BSgAl/A18c5c/081t8VjF+XnCT+AjKiavhkbVwhJVfVpRQOysG+VB/k9FWxQslMAyJ6d/RtdMkhmrNK5Bo2Q3TgpXJoHQwXeDAiv9etcNV9oT/Qxi4S3ditUyhkU5hn9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441137; c=relaxed/simple;
	bh=9fWngggRHUt2YHzjxI5dq9V/JcDiDGrp44XsCU9rAHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8zIk75jYnp4uL813eHm0vSugapYy+CerHoB85i07WTgXZjcF8w67x+nzf8/dEb0D+bMRIF6oZJ+IA3YphDq7n2CNJ0Jdb48LiVAdHAOexiwI7iZqKbSuk3t6uCWTKRVky71fG1/gV5S4rSb3KOolh1qod5aGrX388WOZuiajdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6v81xj4; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6v81xj4"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43fe62837baso4186610f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 02:12:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779441131; cv=none;
        d=google.com; s=arc-20240605;
        b=aEELErkbumPcNuzCTk4OUNUwnZ01uSbv9wvIT6qGkpcYBq+PalBvf9yhIxvMDf+bkd
         xJtgaihHRPrYozPnoX2K8BYUqL/Mu9B4UKHy6EebbR2WwCtls2jufDDqeyhgpIkoR4LA
         r1J6Ipn6w0vOAodN6GfS0SL97fjzjv2pKwxyVyFayOkpT4BgW7X6WJ0HAvsAUkvHCXx5
         0XOj6Yzt4CDVHGbSNwpAmooIQRdnacFEkMb65wg71ssE8SmunPMN6E3YqYUnPTnn4uD4
         XyxWsUmKPcEFeFWscNi/gJRe8CWtWFBRiadC93EI7Iac4UH3Ni8H4jnSzCjUHNNkq4U0
         WyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cKkfdRdaKUbeh839fBeoPlWaGdp8dPg/AM/2Vj5ukbc=;
        fh=Ty8uPv9WL6v8oI5X7tbNPyvrO2CWUraCpLtMe3y1sok=;
        b=hOpyfPF570XBsfhcHPpj8ZhMV7oHyXirziFHVBp8wHRPaa2pUok+6zNgzhD+N+BSpD
         knNV5aTSB5YnsBCBmw6kRC/5A3R7vPO1AufQp9USD80+kxqXA4sn9nVyhEoOML0P3PBM
         P9qsHOtm2f2YwhCm6wEivBEePbxcCpcxp50CFvVrDTJO7k/8Bx4JuZ3OxZACVrW7rhGF
         I+KZE0ftze0MZX638q9dx1Wv/lk8vyxjgEm7uFNOumz7JOmt1D5s/em5CmtOSfvR2W2K
         isndhYRk2YiPZHIRlSMRTF/gRmlJY8bG1tgWjWCnatFN3IPv698TwVCZ2WUYjAmb8iUz
         vjmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779441131; x=1780045931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cKkfdRdaKUbeh839fBeoPlWaGdp8dPg/AM/2Vj5ukbc=;
        b=s6v81xj45pYgS3m2ZFofgtQBkdbKjH53mgmbDwIJO9icTPOvQp5vlVqAfblTslV2HM
         H0eptmbDIKpP5Uyp57jSpMrrIeNJ58A9K4EMA0U2LFO+VJ6cizgvy+QJFIcKF16RiCTC
         wtBfYGSy8zirWrVVkt/YyLXhANF01L1v9gvejxOv4lVko19BZrmhVfjrxLqCWUZ8ujNd
         a/ZyOCP/fEH3czPldfHJPun4H61RRZzLDKDO+Hzt0h5ET4BsxLXKR5GLOEdpZSARzNKM
         hYYHynSRNfpPNtQWAgLQYlHv9IQ8jv4GGuu24zl32yA+3ejixwh0isBCoyoWwTkPMb5d
         o51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441131; x=1780045931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKkfdRdaKUbeh839fBeoPlWaGdp8dPg/AM/2Vj5ukbc=;
        b=Omo4xCbPTCqlPoJlo4PC+X8Bt91NIDWaieuhYc5Or8KYDIJPGnqylo3NHNZl67/lSB
         J55DLTpjrnoIkBexD+xDxori4hsAsFagHmJHVSOD/q4WlsOCxFXWCbnJri7pWbg3T7ws
         tAQBwHNwSM4wWGKTf7Y8xxfnITamgGJFokkXku9wGU5UMxwdxrJwCG8HrDeeeTUSJ/Vy
         GGePitzVRqDh0E4O45C9i/lbDAaHe/00JQZjWbmJiMQTTj7y/cqfL4a9Jh813e/p0re5
         LBw10mcyodzDGqWRFxNspZZeQ3yHNor10/RRgC83Ggesdk76e8HOjebjT/84wXP1/drI
         bSTw==
X-Forwarded-Encrypted: i=1; AFNElJ+7T1jA+9gx/r/Oa9Ri7PTF0QQtMR44SZ292FtMnyBtncDW01C/AjygP9N0KIZ/JRdQJCtChSlAyjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMmx4uuzXMxzmoJ8yVcOv0ozyQAGIUe2eR50xhip2Lrr/cChEt
	H9DHlCQ0GACLfbm+86TIhBHJOe5g7STUtrCmt/WQ5KdSeUgDprE46eQnCuevYQoeHET0TBmVnhG
	b0ikjND2U9PuXO9yRQfA+zXf+emvsOyY=
X-Gm-Gg: Acq92OG2/S1mGajI4zZO5w9IbgH1iFAvOb4dREkBujFxwNeLu04YXU180kCfAYHPsPg
	WTrDgHqaugXz/YntAM1VUfkB6FtdUlpEwVuMAFfnix15RBCaav2WLA4xieFyHxvqY7gIwLZtZvZ
	6icsCee0SGf9sk+702gg741W6PpgYDtJO53uolGq2MDU0E5/baTVBHglmQvCgsFGKBtLHPxX8Mp
	uASeuwcTn2VF60H+aVSw3qOVhafvFgF5oAEyTxMw1N1/S9rKHIsCSpUVRYw5LcoFEvJ7cOm6CjU
	0I3ZFOnUvP3wuFf/awDmVqCGTUHxWI1oAMQ1elhfRvlD/5O159swvBorNqho6A8SBEEZYYHB9jw
	OoTSqUR6NDtFSc4MR/yoaOZjmmLDUodNMkQ3743cDRuisAz35mjV5cmIAw57XPQbNwJ+q0T/CFJ
	IWHNlmRg==
X-Received: by 2002:a05:6000:41f6:b0:45e:6518:3299 with SMTP id
 ffacd0b85a97d-45eb38a84c9mr3475115f8f.5.1779441130829; Fri, 22 May 2026
 02:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521164323.770626-1-liviu.stan@analog.com> <20260521164323.770626-2-liviu.stan@analog.com>
In-Reply-To: <20260521164323.770626-2-liviu.stan@analog.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 22 May 2026 11:11:59 +0200
X-Gm-Features: AVHnY4JVZQLZMPg8HkwWJ5xWtqLlMUlA1CXMw-hpC-90Gaz8cVJ0XRdpkGJH-y0
Message-ID: <CALoEA-xwm4bM+qp0jHu6SxcBz98y9v4jvdiJMdWWADSJBUdy=w@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] iio: temperature: ltc2983: Fix macro
 parenthesization and rename
To: Liviu Stan <liviu.stan@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra <flavra@baylibre.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 May 2026 at 19:19, Liviu Stan <liviu.stan@analog.com> wrote:
>
> Wrap the 'chan' parameter in LTC2983_CHAN_START_ADDR() and
> LTC2983_CHAN_RES_ADDR() with parentheses to prevent potential
> macro argument expansion issues. Also rename LTC2983_CHAN_START_ADDR
> to LTC2983_CHAN_ASSIGN_ADDR and LTC2983_CHAN_RES_ADDR to
> LTC2983_RESULT_ADDR, to better reflect the datasheet names and avoid
> them being confused as related.
>
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> ---

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
