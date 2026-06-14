Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C135D2EC0A4
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 20:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470578; cv=none; b=JN+HCtcfouBtysZ705/u5hLvAM+Nm0WwydB1fl7FkP+xHnUAIPF21MYD0zcqUox1HZvSpx9MKiIQI7vOoM7JdbQO39510Q6IRasx9mzhtdXWDZyWSg4jJT1ZyATZqml49AR9HQl8rgP1kpqBc3Jv4d0ufHj9enRBCZdi5xThWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470578; c=relaxed/simple;
	bh=Bb/rWWWutaDXRMzhs4sxlRByPpYceIR+Cvi4m7nRTYo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=nLP55fEgzmCW5chsevz7EV/3fIil9tnKHLzm1nhsymv3MS/0z5bb3lWjkUE1/N3F13kGtEVshOHumxaqloVXZbQRXa6DxGYwW7NDsYlu0+adOkfJe9oDZFMg5SYXs25XWdZoqD6hgfCTu/DyxnWeIqOaycKjOD8d5dZ3WdlT8iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s2c/E+5t; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2c/E+5t"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-59cfbfe64baso897250e0c.2
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 13:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781470576; x=1782075376; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrNIi2oRpWcsa/tsl22AWn5wO93Zua5ZZu5VgAo/93I=;
        b=s2c/E+5tb41K9LC7rerrXvAOaOf9DooYNgxJXPhFKPEx5QgvOdnzVHW3/SwCYEHBbD
         cMeUPmUwJ3mJra1Q7JI+i5vYlBqui/tECiHPnaxvEc7QLw43SIiF+27tgABeG2CfVBQ5
         +Xp5h1jRJhE+fe4E23Y0kF9oA0Q+vvNEEQb+Y0+xQfS//SMYVJNkesPvsOX6dwtEM9ts
         oTRT5oBsIOMUcYxJrWglb4QoHzUMbN6sgqZdIdrJQA8V1fe7v/W0Uc+2HtLp3g9LjTxn
         cH6P+j37CqSuX8Ww62r6CLFMByuKxoCSEXzCo92xH32j7pkVbNg7ftwhj2sHtM4WqbpT
         VnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781470576; x=1782075376;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrNIi2oRpWcsa/tsl22AWn5wO93Zua5ZZu5VgAo/93I=;
        b=dJOGSkIrEYepKHdZqGQMQiFcj4VYOTJIDksr7UeAiUsrorPRdd5IrZtgUYPJCbdsuW
         04Ce5iVulNF7xwJAi6uv99Ay3VYrdCIhd7Hyuem9+j9SIwIULSuXSOkzNVn5YEVpVKce
         3QA7pyfURj9Nk28IFV5bkMBBMnoUIxMR1aFtoNdFr651SlHUmvbMzycicoAUs8Q7GdiE
         jsAugwfsiHnHHGH9Dxoo2G2jfHbjy/5iRQmY857kcN93DvIQhviqcyjxoQHLJh4Sj/Od
         rGFIeYIytWeuBEQtQOywpCFbtH/fzWclJQZNwaUZYj2HUOPl48D197j6MN+h1R145JFA
         505g==
X-Forwarded-Encrypted: i=1; AFNElJ++Bo2g4dPfknduwZzHT0GZi0Z3C6ubXBvG9BsHEXDqSJN18Qr28Q3q0OwzHAwnW+ztu05/pzscsf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCD7nJlaQ/2EXAxm9+eEltixHtF9vGmxdQg9EOjcCci7MClSvW
	cCmp4QgGeMKkYd/qBgwMo4kTeJuQ/O+CPexlnueqQdSkSknFne3W0hSj
X-Gm-Gg: Acq92OGUI/25h3QCG5YttBjcw0XadG3yIGBWbz3RukscOu0LH+A72c2INivZUq4U7Li
	oJ5N51lahyAngEZqp1ZBgwaNOl8kTJFT5WA5YCxar6CCBDGn3v6B9PIPBB3Mk4Qn0k4yuPF5rKv
	jkEOzShEQZw1pgR2MMQj5W6vOj13GesjGrXcR9JuK6O7hbj7w2+7GwegjzIA4LH6ZMuiPQGErHK
	jst4prMr+sVU8VUHELQwT4cjlPnJ3GjVcZRDPl94lmXV4ysnZcim3NmfWDnViW3rHEILZd6iKxd
	7mrz5uNqmuSnLHOw0PlwbBmmzSmjkAVSCKSOS9Lu0KYQZpVkDK+9vdYmSrgs1IOr+JyDk689PMq
	JATseQxB1ygQV5d9rRwn25wkVn1rHYDX+xgIND7dP1moXn/DruW5VhuMa1kA5ooIGl0jR0KBbzY
	ZzKcBICC/MctQ7CA==
X-Received: by 2002:a05:6102:38d1:b0:631:26f6:701a with SMTP id ada2fe7eead31-71f6191d9b1mr4187582137.29.1781470575602;
        Sun, 14 Jun 2026 13:56:15 -0700 (PDT)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-966a03767eesm1751064241.3.2026.06.14.13.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 13:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Jun 2026 15:56:08 -0500
Message-Id: <DJ92M0ZMSI2C.2I39LHFRNQS7W@gmail.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Kurt Borja" <kuurtb@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>, "Bartosz
 Golaszewski" <brgl@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH 2/5] iio: adc: Add ti-ads1262 driver
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
 <20260612-ads126x-v1-2-894c788d03ed@gmail.com>
 <20260613-sparkling-naughty-tuna-3e9bf1@quoll>
In-Reply-To: <20260613-sparkling-naughty-tuna-3e9bf1@quoll>

On Sat Jun 13, 2026 at 1:59 PM -05, Krzysztof Kozlowski wrote:

[...]

> Functions used by probe() should be before probe(), not somewhere in the
> middle of the code. IOW, entire probe is together.

I they all are, it's just that regmap stuff takes a huge chunk. I'll
check how to reorganize.

[...]

>> +static const struct of_device_id ads1262_of_match[] =3D {
>> +	{ .compatible =3D "ti,ads1262" },
>> +	{ .compatible =3D "ti,ads1263" },
>
> So devices are fully compatible? Then it should be expressed in the
> binding and drop one entry here.

Not fully compatible as Jonathan said. One is a subset of the other.

I'll make it more clear in the commit message.

>
> Best regards,
> Krzysztof

Ack to the rest of comments.

--=20
Thanks,
 ~ Kurt
