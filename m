Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793240568;
	b=sfFPVDd7ykzhDrxK5NkPIQ3AUE+PkS0SJunn08uqhj+Cg6wDPJuQvpoWJyCUt+lX6K5B
	 sTKhFPpOfUWmVsBaLRpEWpgco52/d2YS+sY1rVoHODJEo+8qmoeqenljoVCZ/1xFjtFsK
	 Kuc34iAyxxjEvEVg9OmGfxycXACnkILUBDbu0VnjH+QrAhpPQVheJHxisN5wtxeBssXU0
	 L0JIqFcTd5NNyQqI+OGuOKuKUf2u2+Q4Y0oywHx/VgXod09jvxRxJ208iUrErgz4X71x8
	 r+REnMh8eW+SGWc4uJqKSOkTX4ViAOlaGt4Sr7b1gzSBBJKSZwmqbJNkQK6rfFvEikg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793240568;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=j4WfMTamCRXHv/6Y8+jwIR5jjgxstSa69agWQosfIbg=;
	b=EH/8IRSrQ8ZzOwxIca9RjTgemoRfiZ1Sm4ioYJ1KSibkTG4GDveA3kJMf8Du1NLJmTpi
	 iWZv1HHEidQYtJwktq5l8bDwoSM15ZS8pglQ0zCKmzfJAZRyAI7mzWtnJRwlW18rVJUm+
	 cAwmuYQpikPapZZGivd35EaRKe2DlqSMHg89VxT1jCkkjtd116t8PF9Xs2gdpRs+EVmFY
	 dwWteJcpoJegQmNZhWRzP52paPHDq8EFT5Wi+RPnfvbImpUFXT+xBoUvnTOspYlcjLcEL
	 0RMJzQKJzi9pSbQnhduOxOB6HiWEu1ggy8wDzKS+Sj0cc1ziwGPGpHj8dswoFsPCaJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmyf5Jt+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F98D606A31C
	for <linux-iio@vger.kernel.org>; Thu, 29 Oct 2026 02:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F98D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qmyf5Jt+
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-844a8bf7e25so1116580a34.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 19:22:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793240567; cv=none;
        d=google.com; s=arc-20260327;
        b=fnG5VMMreo6VAfAujPsnDuChN7ZshnJA4ODjmgfJd/EfQA3MdtBXMrElmfXeGYHc6b
         3A8D9texfcR5PJpO7hXu1YFFHkG3n0DRYzRT7J4/EldS3hAEAci52Ax3DmPP51NcOGHA
         yASgp6hLmFmQqCoHru9TgVYYEMJyO4omWPB0o8qlF4HZG3Uww+1S4IzR+nj6DClwe+Y8
         FjgCNLeggheOjEhQ+q1SK9jENzvBbdwmmchyd9tPc6CCcwThRee6ZssKRzzBzp8ygDfk
         rByS3Syn6vOQNwgCA8SsPWTUB5wEGfimlovviROu308IPtTnq3jeT576244wMC6xDKjB
         gkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j4WfMTamCRXHv/6Y8+jwIR5jjgxstSa69agWQosfIbg=;
        fh=Vs8O03pAjTsZbdbwN4snQ7/14M+HxfDC+LWnMJWdXsM=;
        b=B/vok7IpZuSosgKc7lBb7KfhsxLDv6h0/407VxUo19Go9Y5eBhmEy9FSKHEHF4OHoX
         LrGowez9bQSOgVfLY1hUmiC1jxpTQOd4vhXVf/0QsC1mUKU5ZhtXtbEJMYcr2jwz4HGR
         f2/QLS36Ur6KFlSETj4MAyiQxYxdd8RE1mW41V0tkbcH4WcsEG9Cqw4inyH9JQ2xeadX
         dOTN9iW9CMkKog71wvWa4J1NB8qMSJ5WUd2X85l2+KlKvP+dy4d69kWsUmvm/IPJfib9
         t9NQvsuL6rEgQXqwPnhJTu9+X9n0admtzcX0dy1yxQS1bY8KWrNwPO9z+7TJQmMABItI
         4uSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793240567; x=1793845367; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j4WfMTamCRXHv/6Y8+jwIR5jjgxstSa69agWQosfIbg=;
        b=qmyf5Jt+Ed+8erZTIMBU8TuCQh3D2NzH5HVjNrR2j/MFpaoN3IGVfoACJiUjUHMjb/
         lFR8+WFwLe0CXdQXa/o0qlcSwCYmOmul2OW7qv5Fyp0d5twPeruOqTJp87ZyLFwWu03V
         aaQxGAM2DUjtppw/xL5P7oISaWVHa+H+oVtjg1Qmu84nz8uY8gAA2Af3Ucve5FKD4PPB
         tfAKUJfn06RuAOZ3E6CWTcIq8tnssyh0C8Em7zGntuVxBb7lLV3NdSlDyI7g0edtr8ra
         AKp7JqKhozgBFOIhF2TTJXF6W59ghl5TVfxLl1XRy0Cid1wYWsLR+hX9LRp1UxkcjO1i
         ZtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793240567; x=1793845367;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j4WfMTamCRXHv/6Y8+jwIR5jjgxstSa69agWQosfIbg=;
        b=OojFv56k6TohUmO25aTrdgMTza/70zIMhU+EAfPgcCESS6+QR8yOxEze+RECfbs9ik
         D467c88ze1I469Ct/Pk/fsAxBqN/G7JfB0VWvqtn9GbbiU+LuKgAnzNiw8aP8+MExgne
         X8HPqvCgCEQ4CjSOnw3oCN6mQkcAntKACdNvuu7thpf/MdyVaTvB097RTm8QFpC5haUl
         SlWESD3Y4/L/uQi07RYCc+EFm0M030hpo3W0L/RhqOTeJHN1tykLEKuZsOaonnCvWpbi
         0zey+pZqUZaEeZC0yxZUh66Lbk0rmNwDT9EWGkAqfg8gDDe7QMJEWhobHDrh1rY/TFhI
         gqLg==
X-Forwarded-Encrypted: i=1; AKwUvBwbTzH8qrahhCn0bv8Rrg3b5gk+GqDu7XXPj2EuOUOfPYNZF8ppH92vziKdZrth1BHHd1XIYl4Y3tk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPSi2cBzxMot0TOZxNmjaYZXnthdxzWQpZEEZiZz8McsPzqyMR
	BCU6pVxsUuEvka8PNlZvgO9PIxYQMEozGhDzageYyrlvagPWknrZTxHYi1NT1QCy+lb9xTPuevm
	z7jzQHURM8fnuBXLV3QknPKf4m4shhcc=
X-Gm-Gg: AYBFou1qjIQMyW1TSh1cvpk4c2Bd2k9t4OHBtp+qvqcUOUCsPbW/M7wIWFngPftfAap
	2sMADdejcE9wCLBE0y9V5MBFTciT53BcL068v4IRqofcYwvfuQIWvVy1IYRvO+bRPiB5qK+ZJCs
	Tex8cvxXnL222eqmoPNaVpwhkig4N/AwR+NevN/xAcDmV2HswowLCj9DkwrZpKfl6UXJkydLYT0
	rT3xJG1WeOhexD44ltogKP3tzglL5tNyoEMS1GqveeW+ylAdUToJ8QfGM+XAPOH2IqFky10UnAj
	qfzCNO+FiqB3fuqX1QIpN3eSlQO+Z+wzKlbqNt5JOlf4oodL/GBiWofK1fBYCPRlRgLAbxJIETC
	BlvkuDVsV4fczIiHZ7LIpUfttm81kkqyb7FsfptGT+xNrULHW128RWGMy31G2qCX01Ka4sQoFaa
	PB1cVSKLpzp7UWQDEqUnmgYTWv2cM=
X-Received: by 2002:a05:6820:c2d3:20b0:703:fee:9506 with SMTP id
 006d021491bc7-713f217c0c9mr1834612eaf.82.1793240566951; Wed, 28 Oct 2026
 19:22:46 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com> <20261020-tf-luna-v1-2-53a88f93db24@gmail.com>
 <20261020-formidable-aardvark-of-biology-cffcc9@quoll>
In-Reply-To: <20261020-formidable-aardvark-of-biology-cffcc9@quoll>
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Thu, 29 Oct 2026 07:52:35 +0530
X-Gm-Features: AclHuK-_y3DzB2l4MCckdRo6yujg-QNDJMup39akDFJc-hodLNFx5tyWp7l8yc4
Message-ID: <CAFqz8LLzi=mY01Lyjzmt71yzae=8C3-O9zMG0739jH2Dac1=2w@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: proximity: Add Benewake TF-Luna
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 20, 2026 at 10:38:00AM +0200, Krzysztof Kozlowski wrote:
> Binding should in general cover both interfaces. You will not get
> different compatible for UART. Incompatible changes won't be accepted,
> either.

Hi Krzysztof,

Thanks, In v2 I'll extend the binding to describe the UART interface
as well. The driver stays I2C-only for now.

Thanks,
Vidhu
