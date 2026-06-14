Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915572E228D
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781470938; cv=none; b=txx8s7QJo+CsdIXzQydnjSjl6B9Y1Cz2g53D0xeWWQ46hqDq3FakPb0pzl7kUakmf2bp0PKCj7WPOSe4SG14S/4v4pkOfhHUVJr2ASW0OjPwx2uAZBWwaL2l1HQf1zUiEXxg6i1rZhwrobBBRnHVNhbC8C2rcvmC3zM63vtrawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781470938; c=relaxed/simple;
	bh=2ArQg4qpmjrrQ4mc9mt0ZHUq5+4VQZKyKQcrnZMbXoM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrkUMxp5XOUQAA6bKS10Un9XSII2K73tpesyPM88Jo80dIyGnpm1o4iMKvyu8Ohy8WEMmyI98x9TrmJJ3Nh3coETuV+zvcOAAQ7flQfBQXJgX+GXoqBgTBor6IPeEbC2mp2kCNR/7MdAqg2G4NKSZB2d7t1zHLzgpp3XVVKQCe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2J/dw/7; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2J/dw/7"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-48670d35a87so2477063b6e.1
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 14:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781470936; x=1782075736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjMi8Y8lFnHLL3o/H7uB9bLrXirUVEIvzNEJJUwIoY0=;
        b=U2J/dw/7+UCDN1i5yaEwC1aWglLde4qMTSzHUR84NDNKm46wRvyBzI8UKuNPcMvazS
         jNesoGOTWWVjgwxWojYTwhzAAW//iNnjIQFAgZ6/vK7yADzQ1vSymf/swDxjuMP9WrQB
         IOe505r4ohZ+oDWH5fh89zyXjs5uS5Xi7opPMweNLa46rAgModHzUjWBOcXdOLKHkHoS
         zPsxKwD0cDvOGzbuC5VZp/oPZopzuN2R+HNSaX+0n0xBtgAO6y7mS37H9XLp550D0Eht
         JIko2viRZnP8qNgtRr99Qi4x+3+0j0aUqtvbpTc3lRjH9Yo2/q0qKfGzUidOMlEWdTfd
         sukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781470936; x=1782075736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjMi8Y8lFnHLL3o/H7uB9bLrXirUVEIvzNEJJUwIoY0=;
        b=YIAgtCAaZW9VbGhaUKowPTGkvNdQddXHLrKgPvAFjjzzh73BCHZSMJOLSqZDlRJwfV
         Td8GoZKCyybwEsNdcgJtLSZ+7JcoU9bvzQxfo5U6ZjIiZOY+OHseJigZFKrYp5iO/qW9
         XNoDy7eOQd7EmBZ8ERSnajWzJ4WYoBcnvbJvR0TQN9Pbmmff5yPI9SQf1paX2SH5/FNQ
         XwmhyP/M5our4pvHVn5u1cHJXldozYfXWELFfbb6l28U7G9bYzUOSa1LSx/AxmTwNgR6
         HtBTm/Vj505oSvO9Ui87lRGp4ypqiw7dyJWbHSMMM2hLc59nPL2lQvEycQILs4eVDh8q
         2YbQ==
X-Forwarded-Encrypted: i=1; AFNElJ8uu+pLvmY2U4/LKUUk1BKF05BQ/sazDuOKlnqO3Q3ou/wCVZ1yKjG8PBj6rf3Zog5MkCJCOhXWfmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTi04rWpHLOQDs6G2vwU/tXmKRURARijL1oKqsBIBXc42NAzR7
	DusZH90lSVhjxVg63yp6exHRbpOlRv9XZKS3LzX6rwKvWypxxLC6Z6AV
X-Gm-Gg: Acq92OEur/2a20ZIBC+FxKpk4uQvYqGCLWY0Ba4mqOhYI7QSjv08AiCGuELxCcTx+62
	a/uwvEcBjwLapsRgkY4d1KBYUuCHw8FSuZ5VHccoAUCbfRl2ygNHEhrjtaqmr6sUf0pKr9a+Kp4
	Z9kdJnNz/XQ8sgSY1niiT+iwRrlQ2gLPSP6JnIrN8UhZY8nO3koQABtaw0Uw80gLaFin6Jz7pmL
	GqL2EQhPAacHvigmZ5RmZpaUva4O6y3QvKsBu3lx70IYSKgQFE3fELVjoIT76q26yQNSvaesPCY
	W8g6G6pMyDxENodh5JljYliyc3h8kjJEY0fpuYP2xyC1KvuA64RovJZsNjtWHNEC497a+LPjZNH
	FpVqrhJG5hA/XbV5uwFGrYhcqvp69ePGsEQ5FML4sUFMJH01/qlyuIYMAtovg30Z9bHvSJjm3Pu
	vDkxEene0h7BbOCzxNDeQ77HX2DuUNIJfaIf+lyfyI4PRW9fC58PBJ
X-Received: by 2002:a05:6808:2221:b0:485:29c3:3269 with SMTP id 5614622812f47-48731451d8cmr5988583b6e.21.1781470936508;
        Sun, 14 Jun 2026 14:02:16 -0700 (PDT)
Received: from linuxescape (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875dda5f7csm1536090b6e.1.2026.06.14.14.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 14:02:15 -0700 (PDT)
Date: Sun, 14 Jun 2026 16:02:13 -0500
From: Maxwell Doose <m32285159@gmail.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: jikos@kernel.org, jic23@kernel.org, srinivas.pandruvada@linux.intel.com,
 bentiss@kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [BUG] KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
 hid-sensor-custom
Message-ID: <20260614160213.085e1efc@linuxescape>
In-Reply-To: <178144969601.60470.12928355382146160896@gmail.com>
References: <178144969601.60470.12928355382146160896@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Shuangpeng,

On Sun, 14 Jun 2026 15:19:21 -0400
Shuangpeng Bai <shuangpeng.kernel@gmail.com> wrote:

> I hit the following report while testing current upstream kernel:
> 
> KASAN: slab-use-after-free in _raw_spin_lock_irqsave from
> hid-sensor-custom
> 
> on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)
> 

Is this correct? It seems to point to changes in HPFS.

>
> The reproducer and .config files are here.
> https://gist.github.com/shuangpengbai/d82ac0d19fda016e81d7fa1ab028d967
> 
> I'm happy to test debug patches or provide additional information.
> 
> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
> 

This bug report also seems to have nothing to do with IIO after
investigating the call trace, seems more like for the HID/input folks
than iio. HID folks, seems like it was caused here:

[   73.163547][ T8356]  hid_sensor_custom_poll (include/linux/poll.h:45 drivers/hid/hid-sensor-custom.c:706)

before _raw_spin_lock_irqsave() gets called and KASAN triggers the slab-use-after-free.

-- 
best regards,
max
