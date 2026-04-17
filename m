Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C7124A047
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451660; cv=none; b=amNx5Bul516u2zO95tNLbcUNbbQeGUOZLsB7I4vGv6giQ8nkMydp89yXyQFAqi2eIGU+6xWTyFuyMHJUwP3sb1yQLzFRwJ1c2r+9KTDNINEhPhjCpPK0Ua71sFe3ApOhaQ9rbK/2o203JPmxHx6A5CiB6UyPgarrRkMb/+lYaTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451660; c=relaxed/simple;
	bh=eAwbTsi3yJW27zbA5qoCATbN6C8RdyVOyC3hQiBmdKw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Bgiic1TvH+wqTt/MVRBHvhbvWtBJV2SBfCR6rP88zNYKUHHtS7atkUvYZk9XomHfjdufuR02wjzfwNJt+mW4c/DA/ufoKmaPyjNneI2ct7aeqJ8u+0RJX2kHthKckW+bnfqEwA2GGElmfIxLPlZxmvJcVAtejQRLH0oVt8uQ72U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=odrMaPgq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odrMaPgq"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f946efa38so303293b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776451659; x=1777056459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U8W0lHm+RlmxAFJ6KF2xf9r83DuTWNf+YgkpSCF/0MI=;
        b=odrMaPgqNZyqEA76ELyL+RSFHuijuL4oi+t6NCyQFMpYRg8xqt1HIPAnjAIqZOZoRI
         qqSfMNwSag/Ncn/3Lt6lACldwtNg2tf2Z7L46otK1a9kp1wpD7+7W+CW7P+L2Tc7OS6B
         QHMS5AQ7kLSg60MfXQ/T+aNr5GWnXeL8ja06xaEo1DHRkiBmI6xyapxmsx+qNppOcWiS
         eDvo0274nMUfTy+c4XWEQiuZVXNsYO9aKXEF83+uBey0p8KgipufXfnE5T2jL0fY0zPq
         zRSp5p4lNlxTewPVAAyfbRUObZvVxmFWQcycnWzZ56E0Ha1cf8F0RmBK8i/fnohYN2tv
         bVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776451659; x=1777056459;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8W0lHm+RlmxAFJ6KF2xf9r83DuTWNf+YgkpSCF/0MI=;
        b=NE519YrHIPcNpDqyYjrkU7IS9E+nZwrZxWLEO53F0zIgp0+fOD6yHjRPdkQB3FRx4m
         8OOsk/qNDv7PNPdA3HHQoksa3j1ADQmg+hXsvtLu8CInC2mc9BFeAdWthvG8hTc/wyWa
         9IR1iM7ZXnfkKEovP+xER3TpIumiQQjHHD9Xagu30Qq3+qpHkVN1hI0H0fzfMbl8rtkp
         78fPVE/t6lajhurcP2kuS12jhyGUPvbdVWf2Mqy1r5vXl4nvmqmAkypOdYJy2Ce46mDN
         i7CVDLR1JkIoIOqdkIGhqpK8KMpezrD0iwgfLSXwPDJ4LHFBL3nNlKDqgPjyYEwiV50B
         e7QA==
X-Forwarded-Encrypted: i=1; AFNElJ8r2tLyTCvqWVzTSFqIJYttV0sbbRKrC+CTMW6yPeuID0R1X3FqT/97Tdp4kOpDBKUlewMkpyWGso0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVjKdQzLLUNuki1smqbY+7U/ffPVLB+QchMXB/J7Z6LTgUoS0p
	dr4bqHYBYhoTlM6JjC0nPlquvh/e8FQg2HKKSlb2hyj1RKaL1GHVhg7+
X-Gm-Gg: AeBDievJKOndIHDymk2wcwF4UnL+I1T+cxx2+6pguf5dKXGVvD8dF7d861+oFGL7668
	0NV0AaEEh3YHjE9wnqyfbCOdzESq9g9BVcXPFgUNWKG+0GRQWEl61j0DTcjPI25p+Bz3CtSjbmM
	jQYMwpeiXG/wLZBAMzlBr6aNMwfawUs6yL+yWMn7aqcOYSzVwzO3ujBm7gefYABmHuItyFTC7VR
	qiCOJwB49SWnYeFoxFhwJcbzR4jGRobf8ZNZKrXaz8TBdloMHQZDEQEUPJEjwqdFhqxcucwNzKL
	qUZm5Pj0vfoxel4SsTiQT6Ip+yM8dEm8oUkLdajh6vkMpPWitdE40T6RLyx+OWvXFs9y3g0UOC3
	RGfT1IngHhlaZCePjqOvYg1tnOQSVhp7747Hsco0MfrYrKBv9/nrm4u6vuMnWtH/LxW8DyoQX10
	sbz481yvQ+LoLryzL5xt7d37lsxFaBZgcNVvCsIpNXKnhIwQyFJTewU0S+Aw==
X-Received: by 2002:a05:6a00:9291:b0:822:69b2:7ed0 with SMTP id d2e1a72fcca58-82f8b370621mr3571240b3a.6.1776451658773;
        Fri, 17 Apr 2026 11:47:38 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:791a:1e7a:b20d:a410:390e:ad9c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebe40e5sm2400862b3a.42.2026.04.17.11.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 11:47:38 -0700 (PDT)
Date: Sat, 18 Apr 2026 00:17:34 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: lucas.p.stankus@gmail.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 jic23@kernel.org, puranjay@kernel.org, cosmin.tanislav@analog.com,
 marcelo.schmitt@analog.com, antoniu.miclaus@analog.com,
 ramona.gradinariu@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] iio: accel: adxl313: Use dev_err_probe
User-Agent: Thunderbird for Android
In-Reply-To: <aeJ9j6g9J7JUdg8p@ashevche-desk.local>
References: <20260417124924.353189-1-sanjayembedded@gmail.com> <20260417124924.353189-3-sanjayembedded@gmail.com> <aeJ9j6g9J7JUdg8p@ashevche-desk.local>
Message-ID: <459F7B97-4FC2-4418-BCB6-DAACE1B49BC9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 18 April 2026 12:05:59=E2=80=AFam IST, Andy Shevchenko <andriy=2Eshevch=
enko@intel=2Ecom> wrote:
>On Fri, Apr 17, 2026 at 06:19:18PM +0530, Sanjay Chitroda wrote:
>
>> dev_err_probe() makes error code handling simpler and handles
>> deferred probe nicely (avoid spamming logs)=2E
>
>In the Subject also should be "dev_err_probe()"=2E
>
Thank you for your input=2E

I agree, will rectify the same in next series/update=2E
>=2E=2E=2E
>
>> +	return adxl313_core_probe(dev, regmap,
>>  				  chip_data, &adxl313_spi_setup);
>
>Now it may be a single line=2E
>

It was the single line, length is reduced=2E

dev_err() was multi line in few driver; however with your input on dev dev=
_err_probe(dev, =2E=2E=2E) become single line=2E
