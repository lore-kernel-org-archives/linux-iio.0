Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1E1217704
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 00:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546729; cv=pass; b=Qonh7ZerbWFvKVse9bwfvFyRpjl7aqgw4y55rnxO+0TdgtIUTAEpxCzdYg2ADSbh5LZB7OuZgJhi7WgSmp+FLseKT4zVTOwsRFG5nI3MuW51o3Q1D0x4z9WwkbYMjaXMUXJCQQfIpxf54ZRsYY6+3fMSGmTlzA4ASHAfZO/CRqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546729; c=relaxed/simple;
	bh=p+Lp/ChaLbnpWalt5P82X5ZMCegH8dNP0eCZPOq4EyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSbpTGJWa2tCx44XPsvtwiDcocDPRf3/Q03duiavPdOe48XRwi3ddpDsxhpGNdo5unDJu5ME+EQsWczur0JxIpht7SNRUQmITRJDF8kuvRNiX/4zdaCxTZuek5c23oH9JcVQ2U35vnGiKBPb/VZvvck4nGRrSp6uuljc76Mp7OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QV5CDFzW; arc=pass smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QV5CDFzW"
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-5a8c6fc5fd3so1814235e87.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 17:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778546725; cv=none;
        d=google.com; s=arc-20240605;
        b=eShD/+rO7BEz3Um58RrWl+9jB3VDDL5kTgDnni67uVS08govEdgOtZ67mOzpfnvJIB
         Lv+3JH6mQgHqBbjaLJXM/Ge78yGjIiXbtEHKfR6vFsMXJgqYAe9ytQx5GtI2cmhU24g5
         ehbRKUtl3ktaMA84HAxnCnNSB4PazXpBTN8pHh0333C6zNEhC5SLiQBa/ZjPWk87weda
         T7crllaKZ6EEoOhwVmP1ZQ3wc0PcrkEK8GiLijdPnH1PNaJjQl9LbOczwVLdb0xLh4M4
         yidymGyTl8xIRD73bXM9EDJKFFzOiNKJbX0aCMoMfoVp6fYz5EikAR7B6HYP/7i7zW2Z
         0xLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DjE2es2FiXMGiS6FgHC41XxcRzptayRAkd8ODfpJ5+Y=;
        fh=DvOm/QmRZ2PxW7kvKpXc570SDBKdYBqJ2ohmrx7rAhU=;
        b=aNA3PpMoztHR1CDMEMei0/6fbsuJGxuSAzutoPGnuCoXc4qkMvFvCGhbcDcuWMbdi8
         rQsQOF0iJQEsg+nzDTWxH+Y3Keu1DF8CGlu+/kBmZFhmwNfuTysNTh1Fs0tdrsVQYcEw
         2hY4hfau0e160jU0Im/ogg6MrLjz2ASYKyXEiIW2tvldsVBdWciu/GTeXy0Uno+VOhEY
         u7Xs17qsEij6w60K1Sx6WR7mA/N9KU5S/npo9bDNFO+/2Fqe9rqazX1tjcM5qymULZ+i
         YTIt9tDZrh819g7qL4oNm8GL2Qyz4Xac14/5rRnCvoEKux5ea9RpGg8gcj+PrXz4hxvS
         86zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778546725; x=1779151525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjE2es2FiXMGiS6FgHC41XxcRzptayRAkd8ODfpJ5+Y=;
        b=QV5CDFzWF2ApBp/KRscSXUxiILU618mEl8Cl/eNTe/J8lMWK31kct/N6XP3WEshjk0
         RThhXQMF1PlJhON4bVZ5nCuar7ix2mqwMSmB0c2JBe+oCqwtz48uEYkbLQdRgz8V1kYk
         UOyAraEmIH4JMAne5jpG7/lOsRDT6sQuq+tsOr4y+Vgkv8TgfLMXeG4RgFH8279sy8Yi
         H/C3RAu1McdzJiUwZSDp6AWYBIQquhtcGjo9u5N1MJOkeHYT+nHeyQBhBGXIbx5nVP4c
         6Kva0c/l8lDWYZHGtUOoRaMxZD97HXjT7MAeDzB2888AoSxkBTAFiI9aqzNiwkdMobOu
         BFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546725; x=1779151525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DjE2es2FiXMGiS6FgHC41XxcRzptayRAkd8ODfpJ5+Y=;
        b=LrU3rwnTGEM5/Q9K/yWyXDXodjFYUcPPVvN1EXkN/xDChZg0SzZzzdK/OA5+r1x0D4
         s28hJLzwTzBlCjhqpwOeTHcQ16P0v+I3EN9+DQLiGvDC74r4u5iemKFVs0XetQE/hkWU
         rxBJfG26vHFvabyF4wUO0F0H3L0ROMWh5taG6W9MFTQ3pTDn54Lk24ypgfVTpGC4aIdv
         4t2IlAH7MEd+2uesTOOk06gUVu7NS6syTR61NBE4VC42aMN6z9hJ45ZXg4lBzeeT68K9
         rvPXNb6m8xGk7jIel7EZgENLSkWSr+GzadA6rwzgG7mZJJH51c64m8WhOIDp9zEhIsOk
         xJ9A==
X-Forwarded-Encrypted: i=1; AFNElJ+mGHFjLkUrFoHgCpBMtsXbvSobBOy8Fv7/iHQv/+BDn0cxDanMwTlNGWaPdZeC7bfdPqCuxqjQg6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG2WA8XFnEXIVXDik9KWhs0L+taDLtlzLtwnA+wOWK6eaGvTYZ
	Mu3zPSX93eDjSvGuniDOSZcqU75O0fTECuWZ/w2LoGS4r+dW31Aw2se7LqgTvGBCCounkBkYMl/
	kRHU1UVU1ak+SKf11sw6R4xE8seJ2Qcs=
X-Gm-Gg: Acq92OEVFnoVBfoDuduswcGQVR06emtd86hgxjXUzS8SXbYsnNosun1q13cWs5qIHoN
	dpFUpe/TBLjrcoOuSaGUfcTYkMySRcOxP2Wl3Wh8hllm+QQLqfI7AuwLR/e7fXkt4J94mEdVgDY
	qDuSuEiXH0mIRQaW3aoKnkVJCUfYHSgGkd+XtZOJFyEN033j3k9OX4r62DAMprx0MEI8j6S2/wt
	AumjT0PjUwkeEo9zbjJ5i9kp+GagCt4oThn9PJO3Tf7+LJSd3sN5HHo0PXm0PKdq+gMn7pwJamq
	nyl3W/IuqDGf8SqjNv+tSFPPmcCo3dhQjUzA4yF0Lg==
X-Received: by 2002:a05:6512:108a:b0:5a8:8d78:9fe3 with SMTP id
 2adb3069b0e04-5a8e0f375e7mr409702e87.25.1778546725141; Mon, 11 May 2026
 17:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509013745.80478-1-dennylin0707@gmail.com>
 <20260509013745.80478-2-dennylin0707@gmail.com> <20260511180056.07986443@jic23-huawei>
In-Reply-To: <20260511180056.07986443@jic23-huawei>
From: Denny Lin <dennylin0707@gmail.com>
Date: Mon, 11 May 2026 17:45:13 -0700
X-Gm-Features: AVHnY4KvcuTmWM3AIWx03nf5ddMfttDMncgC8jnUZQBfgJtpcBhUEHe_wSVgTTM
Message-ID: <CAGEkeHeTOkGkPYwTh54EHUfQ2wi2rmgEmMk793L_XqJN5NvHrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] dt-bindings: iio: dds: Add AD9832/AD9835 binding
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:01=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> As per v1 discussion that is ongoing - we haven't in the past put
> dt-bindings in place until we are ready to move the driver in question
> out of staging.  IIRC these are a fair way from reaching that stage.
>

Thanks for the clarification.

I understand that DT bindings are typically added when the driver is
ready to move out of staging. I'm fine with deferring this until the
driver is closer to that stage.

I'll take your comments into account when revisiting this.

Thanks,
Hungyu
