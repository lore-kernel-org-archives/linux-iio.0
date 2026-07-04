Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E294D25B099
	for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2026 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783186134; cv=none; b=SDEZFAcATsYD84YGM74r2v/nX2jj79ttrtJI8wFOHkQ5GafV7pvHowQV1ZYLGZFIUktu9+lj84gU4D78Etg/DCq3KK/a+ROxhe5VoHFXGraW0cQeZeqKi/omSURyEesZqN8fGZ7/n0e0HmeONeE875qont0EEHtuuIdIJWgHgO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783186134; c=relaxed/simple;
	bh=6afIOjOzhFXJRuonmcwNCIu26PRwJhH0WXw0qgT3Qn4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Y0WHNzT2ybaoqyLULMlkXRzN3p4q6Vm4haosfXizisAmit2uKT3hPV4JzjBN8Bhn1D3ppdXxElBexyt+v14O5kyQkiU0N9ai1LCQlhzxi8z0N1t5g8WW2dQrnZ+eKfgFrRPGTXxYZEM9MuFIeXayOwbGoPl7zco49LaKbs2Z5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hHqw43Du; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hHqw43Du"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-382ef647e20so708611a91.1
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2026 10:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783186132; x=1783790932; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6afIOjOzhFXJRuonmcwNCIu26PRwJhH0WXw0qgT3Qn4=;
        b=hHqw43DuewMBv9lljwA3uuuikuFbvJQETb0G2rvRmfcCexZsVtFzEaVldY70RU1NlJ
         SPPc4Qrxr3C6t6EgvwuH0EgKivFnuWIS7iNsN6KVevVVRIMB79QrpMZCxzwJ+3jkih4i
         C15PX/00aIsxmh004q8ARWxl5NRJ9sAL6O1osD7UJ7FmZxg3cJOlR/OwDcxAs5JzV6aJ
         II7rIEuCQHCjMfCRlJiCzlDqZTx3UqjT9vGP7fHI9LvEtnks6Ee5JA+9rq8AE+fb8MDd
         8Q1/0rQhOOpwomPbWHWK8Ec/Cy7P8HQE77PD86dtIQFhj8hSHnfJ/yiat5K9dtjS5nhn
         cVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783186132; x=1783790932;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6afIOjOzhFXJRuonmcwNCIu26PRwJhH0WXw0qgT3Qn4=;
        b=ce1Jb/QSL5M2RICBLHG/n4autGcBeto+c1lxqGTce+j4UxYI3O87rfn1vYBcsjN9Ll
         VdGd/ZhUYNjHwUYKvTGsU7Vh6QFGUzupVWKil/gDMGp+f75w7/UIVDiETlV4ntbCF4Jh
         w5MAwZPUns304AW37vEphz3DrIa87xsTRi+KBh+XzXTtFWplJXULQIBqiqtEQWxAUqno
         YV8PDvqIrJeO9HCPVqQwocqyX6SDacdPtJaCgazdrpKSy4WuvVZxny8ff8qDZDEkp8wt
         cHdPRAd2LuxktUnHdUNTYRP5+q0v7xP564sSrWPlyIpr7fhq4tAsnmFFGxyXirQu7CVS
         /whw==
X-Forwarded-Encrypted: i=1; AHgh+RqvgU+JFZo1siOcY8GgmcbuqlbHXlQLAgo3J3W3SHWHCzmRfdOdqGuJXRVmEqTJZd6Xq6gz2I4L4No=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66YMPoGe/Y0uPDCGqV12XQ3KcYbTxy1JFBfGyNtC3ATqNwUuz
	7OWe33A70YesiTIJOK52Ba9EDL7TTCRQ+xdYXX70U0rzwIKm97T21ytP
X-Gm-Gg: AfdE7clS7ipmIgVyWnweG9w8Q1YkYeYiOcu7TSf9jzTpP/Fa63wziu/GlrX+WwUeKoz
	zHW4g4s3hfLMq1UlDDDqdlTSK+H/rT9CVc2OFWU1gYXGn4RJma1W7D7R0kbbvhENpKnlxyrZio2
	UJMlzNiJ10sUoCe9u0n6ywi75qlDrqtCYZtQS3AWjlBM24UG4uMzsHaA60CB7egzEBeQTbLYa8f
	n+NJO1WuisyehpwlClsM9LY6P5SEOd62sDpe69OHdxK5+2C/iJ39DEBInxlpWmPm3NE8NBSI1oM
	f0jeTWWfn+VggPlHEPgJugIWVHPrwaTLKhj9OV2/Df6Tf8BnoSo3lyRYh/cw+IIDy99tbzpouvB
	tQdYG+JxI/PtUEgcZRRxj4/0U1L54bLbRV1a6t30w5jjZgdomcNGro4GddBwC3hLv4i33Gd6qAQ
	AZhE0qg1WkyS/2pS+yuwOwF+IOXyZBTBLQKadZ2DZeJc+gK7a8yikk7YE9gm3VThJ01C3bO3xj2
	iFY
X-Received: by 2002:a17:90b:4c0d:b0:384:d509:7274 with SMTP id 98e67ed59e1d1-384d5098a0dmr628774a91.15.1783186132079;
        Sat, 04 Jul 2026 10:28:52 -0700 (PDT)
Received: from localhost ([45.64.226.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f1cbfc285sm24823683eec.5.2026.07.04.10.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2026 10:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Jul 2026 22:58:45 +0530
Message-Id: <DJPYQ4ZG88L4.2LP2ZAMYER2UF@gmail.com>
Subject: Re: [PATCH v2 4/5] iio: adc: ti-adc161s626: log buffer setup
 failure in probe
From: "Prashant Rahul" <prashantrahul23@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Prashant Rahul"
 <prashantrahul23@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
 <20260620174708.111470-5-prashantrahul23@gmail.com>
 <20260623203636.69a7429a@jic23-huawei>
 <DJH77MBX1U37.1JJ1Z6UGLF0LT@gmail.com>
 <aju-_HSz6jNkR_NM@ashevche-desk.local>
 <20260625120952.471ec21a@jic23-huawei>
 <aj01H48IHTyhn4ZR@ashevche-desk.local>
 <20260703013907.57b0f114@jic23-huawei>
 <DJPWN45EI416.1GR6QTDHBU6SC@gmail.com>
 <akk8QD1iQHk1Cvvv@ashevche-desk.local>
In-Reply-To: <akk8QD1iQHk1Cvvv@ashevche-desk.local>

On Sat Jul 4, 2026 at 10:30 PM IST, Andy Shevchenko wrote:
> On Sat, Jul 04, 2026 at 09:20:46PM +0530, Prashant Rahul wrote:
>> On Fri Jul 3, 2026 at 6:09 AM IST, Jonathan Cameron wrote:
>> > For now I've picked up the two straight conversions to dev_err_probe()
>> > because I'm keen to (slowly) stop using dev_err() in probe functions.
>>
>> I can look for places where dev_err() is used and can be replaced with
>> dev_err_probe() in other probe functions, then create a new patch
>> series for it. Without adding new logs or removing any existing ones, of=
 course.
>> Shouldn't take a lot of time, what do you think?
>
> In some cases it would make an additional churn. Each driver may require
> a unique set of the cleanups and refactoring patches. Better to do someth=
ing
> that you have HW to test on.

Makes sense.

> I also removed some people from the Cc list. Why did you add them?

I am a little confused here. I only added people to the CC list who were
already present in the CC list of the original email. Am I missing
something?

regards,
Prashant Rahul
