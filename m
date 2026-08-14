Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B9827F4F5
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786675630; cv=none; b=BCanBQx6uDJHkiArOlYgeirLmG8Psa6wXzhRA5VDzvaMspCAOCs3T69unJhJm5LKo51KcyKgMJs6Uv0jvv4C7Y1Gs4tQnnlETDmv/kiGBDE788SIkzOFqpL7fNqGk04dM2Dt47PElUgfaJfDJNrkzgBsAhPBHE3tL5di8GeIMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786675630; c=relaxed/simple;
	bh=WzbkOIrjUiuD/UW5K+UIEXziUCx65tSEGGqVuBtVTpY=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:In-Reply-To:
	 Subject:From:References; b=bHTvd5V0/vInO9LdUkIHgjhPLkTNF+QeCdRb2nyPCJkABn4khGVpde+4tC0UCF9fGkkKJs7/g00FqSaD6/yDicRtEJY7QdJbxfqlKgqqYD+GQC5Q6Yr/4KqMoEhePMePeBQjjHovUkOoO2cAMmQ+HbM5Vs7t2LqQi3lJhuhjVgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc; spf=pass smtp.mailfrom=maxwelld.cc; dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b=p3M+XbWv; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=QsEU9dSI; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxwelld.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxwelld.cc header.i=@maxwelld.cc header.b="p3M+XbWv";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="QsEU9dSI"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=p3M+XbWv5+rGRDAn6S0t7cc6aizW5uAA9Pw6Lgs7To66C+GvmrdTw6An2usZuq/7i3sWgoifcydQ4qfyfWMmO0f97DrPIu8C7xdiKJTnWq4hRZiYUb30fcc54mLMzp4sShrispZFmXFBIgpWM0MYpfUAtygLu0SmYkV8l2bkCZoJAN8Dr0mMwenY8hZjhiJCxl8nSKaS5S8Mn5q+59PhI2uvDv7UGCMwVvabloe/K63NMueaqsyxwITC9++GjhBeMQrIoZtpflwAX0BkE3Z1/yxd86VOMwB4fiag8OdH5W/hnU1ZuVW2n/Jg9traR3HXSQ/eCP3tZF7pV2Cxpl1pYA==; s=purelymail3; d=maxwelld.cc; v=1; bh=WzbkOIrjUiuD/UW5K+UIEXziUCx65tSEGGqVuBtVTpY=; h=Received:Date:To:Subject:From;
DKIM-Signature: a=rsa-sha256; b=QsEU9dSIlhxlCPB5GwObeTFi+nbCRR7NgHjOHJbZP4HCf1J/EumlkWBFTqGzZWL1sBHMsfdRGRCsA2yLAzq2/qUYn4yEddPH5x59pW2VJlnl9DUO4jwxWV623GK7KsIpGg8RPd7b4zD59tIvwNQCazWDgMHFF+4sB+Pz0D97YkqKi93hEH3Ud8WG21m1v0tFX6dI4zoESgyCxXe2pnYi4bFtliF9ADHJVsBge9ZUDlr9Us3eEDGR+XcCBJXiEKcSJWqMTrURxADTtbjLsgV7ZW8jW2m57aFxAFVzz27rovnAkuhhssVnImzh9FzO3xgKUxyhrett5kiv7pvXK29fKw==; s=purelymail3; d=purelymail.com; v=1; bh=WzbkOIrjUiuD/UW5K+UIEXziUCx65tSEGGqVuBtVTpY=; h=Feedback-ID:Received:Date:To:Subject:From;
Feedback-ID: 1013395:40550:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -885924284;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 14 Aug 2026 02:47:01 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 21:47:00 -0500
Message-Id: <DKOBND0GKI21.2843OFKP0KR40@maxwelld.cc>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>, "Maxwell Doose"
 <maxwell@maxwelld.cc>
Cc: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>, "Jonathan
 Cameron" <jic23@kernel.org>, "Sakari Ailus" <sakari.ailus@linux.intel.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Marius
 Cristea" <marius.cristea@microchip.com>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Tomasz Duszynski"
 <tduszyns@gmail.com>, "Jean-Baptiste Maneyrol"
 <jean-baptiste.maneyrol@tdk.com>
In-Reply-To: <CAHp75VdDgBcieBdd9q2u75oFCu+w5tAF_L3YNHV5Ra5biHxcsg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] iio: light: Unshadow error codes in ->store()
From: "Maxwell Doose" <maxwell@maxwelld.cc>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260813071912.2465208-1-andriy.shevchenko@linux.intel.com>
 <20260813071912.2465208-2-andriy.shevchenko@linux.intel.com>
 <DKO09O8T0FGE.2WMX1VNQN5C7J@maxwelld.cc>
 <CAHp75VdDgBcieBdd9q2u75oFCu+w5tAF_L3YNHV5Ra5biHxcsg@mail.gmail.com>

On Thu Aug 13, 2026 at 3:47 PM CDT
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Aug 13, 2026 at 8:52=E2=80=AFPM Maxwell Doose <maxwell@maxwelld.c=
c> wrote:
>> On Thu Aug 13, 2026 at 2:16 AM CDT
>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
> ...
>
>> > -#include <linux/kernel.h>
>> >  #include <linux/i2c.h>
>> >  #include <linux/errno.h>
>> >  #include <linux/delay.h>
>> > +#include <linux/kernel.h>
>>
>> Stray change? The ordering's messed up (seems to be case for many of
>> these drivers) so perhaps we can send a patch to fix the ordering.
>
> Not really. I understand what you mean, but I took a step just for the
> k*.h letter to group them. It's slightly easier to follow with

Fair enough :)

> kernel.h being moved. Note, that kernel.h shouldn't be there at all,
> but that is definitely out of scope here.

Makes sense. I wonder if it may be worth doing a patch series removing
all of the kernel.h inclusions in IIO all at once (or maybe some drivers
have a legitimate use for it, but that seems highly unlikely).

thanks,
max

>
>> > +#include <linux/kstrtox.h>
>> >  #include <linux/string.h>
>> >  #include <linux/mutex.h>
>> >  #include <linux/unistd.h>
>
> Thanks for the review!

