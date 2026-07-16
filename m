Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076B361DD0
	for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198617; cv=none; b=gPlNznc2J3gvDJThCx2kl8Hc76badCSBI8L3hWfQ4XrmUQqAT8A4O8csM77MqJZKEIa/lg94efPzIHL25SnQohyp3lK+I42DAZZNByPVoSV/K9VeEKJs+DhsogllBBQ01Uu72MXmXr+YKhJVaLhAFC21pzH2TvzXkiNTChcj8s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198617; c=relaxed/simple;
	bh=GgX8EEBRGYS4gfCyVaz252WqC1yydQhpXdNRshuT8KQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FhSWc3MHL6ICj0wWz7FBFfq+xh+vdItJEmsuaWYyzDnWJ5Oh/dYImDjq9Zgz87HCiABs9YnaR/aTThiGqYvZ4TsyY3iBixID5J3nY/ZtWY3TS1EsKMb74Gim3DpTg3azvt6ikckKnaZi9Bx4VrQE33bC2bJPhLUu1m52yoVg7f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvGRsDbB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvGRsDbB"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceab75934dso62664425ad.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2026 03:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784198615; x=1784803415; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GgX8EEBRGYS4gfCyVaz252WqC1yydQhpXdNRshuT8KQ=;
        b=kvGRsDbBI8S1722aG3K1zLHnOS8fDWj0IQFfuHioK4vHj3cbOw6UViTi4GUgyf9Tso
         SF00yzk908lheNHKP82M/kVNDEL3wK8RyHE3bzqIOZhPnr5bLqGlb/SGO/TjsrZ6Tm2Z
         xChUqhh6NTUoYESVTsCPPChlMHm1U5gu96DZpLiKXtVgE2sfK5vQADY5wyEpYnw+0nF4
         WQ46JlyHS0tUGpsUqGoPv3xCKpZPi7w1HR9cHGkWNlerphCsNTTR42TN5djgpPESxU8T
         ivAg3PZA9DrakObXQkg7nz9lEzyVrTPu6lOVGk9VwDlXxg3RWA0DsX4OHuAkCgoB8tCB
         IuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784198615; x=1784803415;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GgX8EEBRGYS4gfCyVaz252WqC1yydQhpXdNRshuT8KQ=;
        b=SLOn1ewZZZJeiCSNAD/2CDVjhMqzEgbvoNd7K1iXMqrdIiMVREVTFkwIdN12a2oLK7
         Nf9e0qURJEBtxZJR56Bf9dUQTeM13m2woSxyVaoJDw1A5Wp7zxa/NcyKyw7i/dy33F6G
         tlIPiPW94kcWEc20hIV4zugkkfMfRhKP1gQJdqOT4pHLPRk63Z1z6PxzSqoZgPx5P7Ud
         2OohSWb06zciFz7IIVrjC6R1psYdoo61x90ZmL+rq85fPWiPNOswWPoCmikDARrNtgQp
         Sp6FuWpw7Rp+PTUsJH8E6FkTQignFIj7uXnebtdhSR5a8EuQPJGQUGsTclbC/zhsIxyn
         9yNg==
X-Forwarded-Encrypted: i=1; AHgh+RoIRCaQMpy+t0JmzM98AXMaTKUbIrso23ohETaimwT+Nyfk8BX81aOXjQGSfgZjZAmTNY+HFKT37vs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyng/HxMMPbK/PKYspXm8wmv4jie2qbciKhI+Z3+FclDPIlJ87
	l5IBItBp860AR8N5GMP7C9nBN+KtdfLSHf0D+0oM281q5Lu6Ln6C7h6Q
X-Gm-Gg: AfdE7cmCLxbHTa1FVZm2Lz5L3T/Zs6jrR9N/FzUTSiy529GqTQMXuRydiE0GHrBagFH
	6wSLECg9j8nq6lNP45y8qvsmHT/+GipBUwZ9xBfcXZPX4aNu3/pHsjPHRJCIiC7Fsncw+Q8hSIS
	+cajmIrWOAuYrrSGj7lHUnc3MLPeeyJ8xrQBlwVmiwQxDY6IFS8dwJJvL4W1C2m3vMkN356SxzT
	1vUmNY9B+8sUt+qNxKa+56oKA4zfTBbvF6/ljsEGVoE14gV7hzrHujHnCQQ36sEByS770bL88pf
	vyb+FkuXOXmPoWWq2xWrnFpadavCtJF9sT6qDRgu0BvgcUyCIqt1UyogAPQ9TZCpJcKiJ3FwVss
	mzNw10950fcm+1VqvaUNOgQ6axdrRzQLEwyn1FBlFnHpLSgO5XYTzd0nytYubM4uQlkPKjaWlIL
	UqI8WPjTvwpbrjm8NifrFaJCl6UwMWx5X9CtGK5eHzrXaaKANb7oz+Aaq+NTuTAM1jSw==
X-Received: by 2002:a05:6a20:7353:b0:3c0:9c19:65a8 with SMTP id adf61e73a8af0-3c36c44c6ffmr8212336637.64.1784198615552;
        Thu, 16 Jul 2026 03:43:35 -0700 (PDT)
Received: from localhost ([45.64.226.73])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cdc4accf4sm1435934c88.10.2026.07.16.03.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 03:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Jul 2026 16:13:28 +0530
Message-Id: <DJZXMDJWG3QP.278GYQY1X349J@gmail.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Jonathan Cameron"
 <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] iio: adc: ti-adc161s626: log buffer setup
 failure in probe
From: "Prashant Rahul" <prashantrahul23@gmail.com>
To: "Andy Shevchenko" <andy.shevchenko@gmail.com>, "Prashant Rahul"
 <prashantrahul23@gmail.com>
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
 <DJPYQ4ZG88L4.2LP2ZAMYER2UF@gmail.com>
 <CAHp75VcV81NJMmhujABVMcS5FYLCcrL-C4ZnHCZsc+wnF_eJxg@mail.gmail.com>
In-Reply-To: <CAHp75VcV81NJMmhujABVMcS5FYLCcrL-C4ZnHCZsc+wnF_eJxg@mail.gmail.com>

On Sun Jul 5, 2026 at 12:27 AM IST, Andy Shevchenko wrote:
> On Sat, Jul 4, 2026 at 8:28=E2=80=AFPM Prashant Rahul <prashantrahul23@gm=
ail.com> wrote:
>> > I also removed some people from the Cc list. Why did you add them?
>>
>> I am a little confused here. I only added people to the CC list who were
>> already present in the CC list of the original email. Am I missing
>> something?
>
> Which original email? You sent the original patch with unrelated
> people in the Cc list. get_maintainer.pl doesn't mention them in
> relation to the patched driver.

Sorry for the late reply. I did use the get_maintainer.pl script for this
series and only added people from it. Except for Shuah, she is my mentor
for LFX - Linux Summer 2026 and we have been asked to mention our mentor(s)
in the CC list.
