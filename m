Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB204156C2
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050811; cv=none; b=cvpDFc00Zp+qbxa1QXsShOuAWyLhhAMdYiVkNfazAPz3fkED3lv9Ig9kpcCkEKDRMx5HhKDFUxEziIGzcReo+A1b33NtuDYe1bsM93Sz9DDRja5JzwMwqemIRNVJklDmzp2/GJzC/B/4vei0xCRk4KWbgc0vVgLoEIWY5Jv2MSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050811; c=relaxed/simple;
	bh=ntE5gUyeHfvczYgBZlJCp5YQfZPMH3wMiXFtAFptok8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g7hOOozjHcb2iVUUNOPxwL8YroKt85qTjyKftzlWn6he35i4A7WQnAcwNrHoQVPae5DqGTIW1DIlyhHgWivT/S22BNwb4Lt0Erc8fl6pOya1ajC1eplRm9UzppHpOV/KADU1/LWX5VXtK4XZwSo3EBB/qM1JExJyl4m3QmSGutA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jJaUarn+; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jJaUarn+"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a31b9a492aso2962722eaf.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784050805; x=1784655605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nJbEasVmJvkTSljHdln3El2Qwe5hfdOfzDuw4LFkn68=;
        b=jJaUarn+1Emy2OVh6Cz9V0eNyxlDKCgyNcjqQ5rZLU1uiQeBokwJ0EhCIGM6/MeRnj
         Quyf6rtUfaCvI09ODZV/sNUZBVqz/UMnfeh/FfJ87C61hWvNwa7A5hGiQoqHZKyQOQmt
         GguC//2BkOpYgYE0uNUtnbtyEQ2yVwHro37PMayp4XLhqFIgzcIpZrD6X9g8gK+VDHhP
         /SivnoxQbqlG/IrC308qZ685FQv73OnpDjSv/gkClJcKKy+0rHl6rvJakFQ4n/+7jdNz
         5w9J7l2xgYGSrl4aq282fve/3/Pn7HMo5OxOGzK7kt7mSB6PzL8Ax8ckSaSCs/A+PXAw
         7dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784050805; x=1784655605;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nJbEasVmJvkTSljHdln3El2Qwe5hfdOfzDuw4LFkn68=;
        b=mD8Jxh9gYB+E1hfxtmgr0RPXKvcFRC5W0UW68u5Ee17JBcRPe4XviJ4Qf3aEATeyLe
         DF4WvAnoTJINLH1QHdx0dDglWVdsKq29L9XhzazyfBuu96n1gI+Hd51M/4H8xxiaRpfe
         yMsJCUykBdonCjcTTXJ96ySnj9iiDV2JzEXZrIbbZcMPJPp5kgdra+l873kIdmbbgplE
         IpBgt23uID2zsuxa8yQHpcXPP71N2HnO+nKapyg6wOH3jod+rhjfJBfiO9vXA4uyWEeu
         hP6gs88R7mO64ufqtKk8qBDh9odJC3JESskexIM18UpEuXq4iWo4JOO3nIl4P0CJWjg0
         GzlA==
X-Forwarded-Encrypted: i=1; AFNElJ9Tz5CPDPTEeybZcFqdQ+M2M1Ep3NcBTDmKoIfjQZcyky0Jfmz/cy/wmvAH9/ngCkH/NZdr0f2RKro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzzhrPtl6QiYOyBT7ULhW8dg45mie+V6dXbTzM53eJ5uMbbaC4
	1oZ478uP+Ln7hVzZruumvMrlk+2GKDyKQNoSRfoHb7f7GymCnurUS+U0tIv38SaDpbg=
X-Gm-Gg: AfdE7cnyBAbWIq/Ydnx+IW6sVS1A/bA2C7lAA/MrQ9qT8ggZaJB8b10NfX2RCl0PjDS
	meLSxmF3k+1FXE5v42anayQLQSMy7JjeftsXcJKwfHfP0sd8JtoT8VJEM4wv1EVI1Bk/5H+4jcY
	bHwdsRgV7lDS+BjJcndot36OMax5eZnVO/iVsPaXdVu+HYaA4LRi0Y/1Dlsu4N2OvC89KMVq+Yk
	baf1pkgIlhW1XoxsICv4HnCFHuPgHT2WxQCLf1sDDJyeuK+YvVAJZtFVA+oEMdusB4RS6jJz+X7
	iyjWO5Rr6KZYgKu8Sv7F0uxav3KfXyYlGv6sXl4ms4IIcFNxpZmK1UqocBGde/gHbgugtx34RBC
	/k0q5coK7M0iGRPnyPKvjQ0FMre3zLGLY1c58yOz1yefKCtf1+AkvUJWZVZ+h7ywPxioIo3dapL
	g7LzoLO8dMS2nySGLS1KHU3uHu0mVQnCd0AbWrCi+sN8wQabeF+lc8rPBSw8xAfLk=
X-Received: by 2002:a05:6820:4c06:b0:6a3:94bc:bdb9 with SMTP id 006d021491bc7-6a3cbae1787mr1784927eaf.25.1784050805328;
        Tue, 14 Jul 2026 10:40:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:280e:69fd:7612:d5a9? ([2600:8803:e7e4:500:280e:69fd:7612:d5a9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a37b58f98csm11584189eaf.13.2026.07.14.10.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 10:40:04 -0700 (PDT)
Message-ID: <ded514f8-63d7-4cc2-9d40-a2f11a6a231d@baylibre.com>
Date: Tue, 14 Jul 2026 12:40:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] iio: adc: make read-only const array config static
To: Colin Ian King <colin.i.king@gmail.com>,
 =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260714165012.184651-1-colin.i.king@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260714165012.184651-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/26 11:50 AM, Colin Ian King wrote:
> Don't populate the read-only const array config on the stack at run
> time, instead make it static.
> 
Subject line should have `88pm886-gpadc` in it. Can leave out
`config` to keep it shorter.

iio: adc: 88pm886-gpadc: make read-only const array static

