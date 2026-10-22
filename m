Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792687506;
	b=Pae6l0T3DAYlUJrLrD48UU+hed/YTcQvEUGwsZId3eNJeTi0LJpASl2YCf3vVFX2gRvH
	 FkhQQP+C1Q3+e3FPk616d6Z8YMncpqmKl5/2J9G7y0tFZmnPVSfi7HX3u3qaB/s3/VJ5S
	 Fb3MNX02bqgG8aLNw76HXgIA+avPc5ERv3WOeEItr/779ARe5AIaUdvOm4vxVCqOxLlXO
	 fpESbxFFt21NZcuFxTeAVeAaF2a9TxHW0TBTi+/sVZigNpzI1gwTejqOQCm96DJ3u9g0p
	 QFNJ+LH6+yNIokSoo28zR6l/X3TRnlJccv+k+zkNqgarI1kdZ5a+AvXQ/mkbmMkkvIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hKpXE/OzLKeXgkSwQNasbBOeBOo7rgGr5W/yMloVsdQ=;
	b=bwT0D/2Z2El8Ur9j2bDqXuWpq1/UgskkBcuOd5rSGXLkWibPGZwrNty5GwvLwAEus8ER
	 pkE8wla5ByWplIkL0LUTXSKDs9pKQoi+StuHKHTW+4zTBzcla1Wud5yGK784qPyzpubLN
	 ehogkwBWSQsf3yjX1PVF04kUy88u7PcACvHdyR0GUfOvZ/uTLXQuhxU3JUREa6mnKp6qr
	 7C42dnOUOZgU7UCD9XCSE4J6Z8qqiVgXbZ1Oj6D4VSP8l7W2776euJ5JpqTCXXuKMgiPS
	 Y4rdVU/6cPIBihnLQiKNAZeHP/TdTzSmxNPy6ABBHbXMSy6DdhGjJ62A9SPolSCsAJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RuXUwd+v;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB1606A31B
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 16:45:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DAB1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RuXUwd+v
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15ea896ddc8so3050852c88.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 09:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792687505; x=1793292305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hKpXE/OzLKeXgkSwQNasbBOeBOo7rgGr5W/yMloVsdQ=;
        b=RuXUwd+v+uqXrvYx828C8JPJmu6kb/oKhvDwhTlvsEXvMihC1Z7xpUgpNTsv21llfH
         pkQ3SMl7JEWd3hRk/fEdw8t+sw4hAmvDG0zGaO3KReu2b3pJSB4YS5uZCYT6Nc3edwdk
         QiDvLb1W6POs9THcqrTAsczmOeYwenrYbT73QmZwA9Pz5QM/RZwg0PGrsy+jKUa/+NYa
         eFeNwJjfDfgOV76uFDNb22n2NDOAbPbRBZ+vzOp8jEILMCxR8jNA1wtJnWaIXdndQhc4
         wixIEtzg5JiaihzBPrL+BkeXMYjSv1FD/cbg/pvhwHSUievBqP8Rh17sua8HT2YTy3Ft
         MXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687505; x=1793292305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hKpXE/OzLKeXgkSwQNasbBOeBOo7rgGr5W/yMloVsdQ=;
        b=Rs2WV5o0MH7BCaYLyxwLy7/am5ov6C/ap8lvyPnnv4t2kA3ifJMbi9fr2EqIkdJB5+
         rd94XJnNMiOyaPm/wRK3UPNc7rGbsfvp0wTuFWVfv8P0n0Q1FeRPtJfW4vO6iShi2S+H
         s+Tx3s8W9b7x8oFyqhVKt99KPNuEGvQPZyFCoeUt5l3jZs5H4iF8hW3JsLEiLOrO+ISr
         OJtulbCLiHZIJIQiuyEh0e0Q7EVt7JZCXM+T9qzwYEsL+uwlaCwHKe08fn6SXPVpoaGq
         YuhAkk5+XZzKlo3huV9iQ1fne3NNwkYbDM2TNQrnkmeI2/MQqfOpVpDlBMBGiN5BZsP2
         WpKw==
X-Forwarded-Encrypted: i=1; AKwUvByKGOeikLdx8ey4hdyqwhGnUvleCUAUBahzlrLfFEz4y7hP1CeTafwetK1fA4b83g94HEyvz+BNYsE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLml7N3khokPA5ZDxdiGFNqh/7oiHROdQixgRBKPVc3Tik3pvgx
	7Z6wrvCkDgT5xjOMfc8IDZc8Y5sTZcfVLh1fwyK+inZgmKxijcZH/GEp
X-Gm-Gg: AYBFou2T8o5htzgc7bo7GE8rj67V4OZvWzRH+eEN2tvx0WUmkz5ObNp33laoxMS5xXB
	s//S+Bg5NjsAQqDK1XmvUAsChXsQqdlrk8U08btpRYWfEmxYRLMTZGkgEoQRXIbeMbsBvscD2UH
	UlkBFPeyxVj6L3imv9jC8BMIuBx/5pmsMFidNoervxQt0ca6sKGqqZ3GqxW6s4QraJ8g9Zt+rH8
	8s8du0T3UMf+cHJ/jG9b2wIG05Sdcdg0ZsSJGsn2lqedPJKUgee46L1ljvtHt+Q09v5RxdeFIcf
	N7MqHdjDL8p+s7vKQso/ZCX30XOYvqA+XRp/1BC0GPNzRH88lpbEpCazWqXX9QsggVYFdOLj8YF
	JqKPvgbTDde4IuCu4ri1DKdoee0h094gPx9e8QeLnjpWYjIJuk6KIAobR6YLZmLgg7msRfyTOo5
	QonkMslUkBTmZ1Cddp+wP+7le4HyXIVarGItcpXRows+26a+b2WgYz13J3t2CrYLcNDgY67zjbJ
	C97n1G4P3uzc5B2PlfdxKsbz5cBqtVETS8JRxvnkbE4LpA7zyC0/BAXw2auNMHjbSinXnQRsDNI
	0cpnCW8xMty27BSXXrlsomo17Qkuroo2YjBLtiK29Mik/Nk2LeiFFPm4JSOeMNRclLO/K/p1why
	Su17OnTVPG5c=
X-Received: by 2002:a05:7023:c018:b0:144:fa57:c617 with SMTP id a92af1059eb24-190a756bfcdmr6428996c88.34.1792687505334;
        Thu, 22 Oct 2026 09:45:05 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a180adasm15841782c88.8.2026.10.22.09.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 09:45:04 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marius Cristea <marius.cristea@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp3564: reject devices without match data
Date: Thu, 22 Oct 2026 22:14:51 +0530
Message-ID: <20261022164452.201416-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ato81kWiI4gnI5xK@ashevche-desk.local>
References: <20261021225431.627718-1-kapoorarnav43@gmail.com> <ato81kWiI4gnI5xK@ashevche-desk.local>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Oct 22, 2026 at 07:41:58PM +0300, Andy Shevchenko wrote:
> Fine, but I hope we will have something to land to actually do it differently
> for the drivers that don't want to use driver_override mechanism.

Agreed, a check in every driver is only a stopgap.

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Please, shrink the commit message to the point.

Thanks for the review! I'll send a v2 with a shorter commit message and
your tag.

Arnav
