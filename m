Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70093E9296
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180314; cv=none; b=o2sm8mabrucywX6OC3sFnYtuPAdVkubX93GgBhVSqFvVryplRzAiTTJ/O0uqqKVsUqqqsLuO9l3xSzzxxMjhBg0/eEHCyX06cT/7r5cWc+GtTj2PZzobNBAK4iPCiBoL/dRIcKDHbCmy7uf7fYuEgydIsgwtAJIRUEZVXOeiAfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180314; c=relaxed/simple;
	bh=IiXYQQExsUnj2sC9snKxGX3zEcL82UZD+aOztfBb12w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=VcTZ+eV00ku5S+2GFdno6xbgfwVFHOsvZpDOn+MxARDB8gEW/ycUjVVOrwRuBwi0YjtY8Rd80oJTDKozX4vb6UPwP/izvF8YSx+pR10cAMqbIrhXj/X7KkRUqXIwc1RRMhRRmulI0RTljh2itI6mVSL0QKUGxxf6sOnJ2rl5tJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/ZI6UmL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/ZI6UmL"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b4650d5f5cso8472415ad.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776180311; x=1776785111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zrnw2LUyNaW2ANHpqLyYF8hEjA5tKqE1HoISMvx1f9M=;
        b=A/ZI6UmLHbKdbf9Hgwt8Ov60tLsHNeuat+F0FwThnXxsRGEu1P7iEEfdpLh+mEFUN+
         viASkFBTQXSNiYbEo7kMZKB21zUb0GQ2UAGWjwjchJhgFPhlnHGRme6MMbqaG20mDqRz
         MiktX/dcXsQqwZDIEQZ4n8HisK64O0xIMpSqhQ4u6TU6QAA/BEteNfq7NcAl+ZgxLvBN
         x4MvsdL1iqLuUWmz1bgKPJmM/kpWfmh+us8jMEnqixrOP3gXiROx/sOnRQ+9TzJVwBsy
         nKWpvgNNHF9MfyezQU97/2mUDCYaLQ9JuFGKRctyC6ztlAJF6VNPJEbfZ9ldcGqfwhcS
         4YKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776180311; x=1776785111;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zrnw2LUyNaW2ANHpqLyYF8hEjA5tKqE1HoISMvx1f9M=;
        b=EskNNYGGtW3R591aRMVLbdlBFpFHtlkPN6SE8jzT8v0R26PNnuePeIvnONKBiDgrTW
         deeK5lhHuLLatye7pRiLCsYJFyvgudQvEy3VcWYVRa7AMwD7RZfOWYVF963ch2Vr8jMJ
         KW9w7MrvVHQY2skagMitxbkk4Y0WanGgTHTE4+HxPJGXlFZDuK6X/kywHmPhhDSwgRCB
         AAg5e81Q1TZ4kCU5yteFNtXYhxGMauzj7FA9zWOIC2wHcgp9uKqSbb9o/+W5OGi58D1X
         seRqPohE4z9PiZSLpj8jRzmNXRzNiXpWbZi9OXfiI4aODy1WsnQKIDvJtTZmI2YqVUkZ
         Hq9A==
X-Forwarded-Encrypted: i=1; AFNElJ/2FUjIZUWgRnRrlwiW/WasfSMZfyyPeyPv4shwdpYdvbgf5M111TFYaEr/sBJL7yMtq63USuiGH4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrl+3DyQeT5rlshFx5wNM5+b1mUqFgWMkhgp6u6jbOO9slM8GG
	JBermvUKWP4YQKePacEQ8sRnsaNYhuhScPZDLMr5B3AAalNGFjkGhFeY
X-Gm-Gg: AeBDievK+6svO7LuM0rnZRe9Zh8Vtun8Ye1AcfsynJfCu4DiUozY17kcwQ3NdAuuMqZ
	vHN1OJkijPfn2zYWEr8O4WqZuEfK2G5gPHcU/iBFHy93NnkCRd8jOEqNbXdC4o5NR5UXo7dO2rg
	iIRzjIXN29mdoqxZJyq1+5P6h/37RNU6kUQ1m82AF5hzgGXKQwduOKQRP5zEllZyveR2VK8h4PG
	+6abgeEN7hoA4TlW1JNbXb1yBTlrB3AB8E8Og98eqK3/ntHs855xke08QsrFLjEkugb63AMmmDU
	mqQh067BkqUchqG1iHVIrxLWOrhs+FQ3zAJTrJzL8hX8sDLaM+mTZQ5AFBugC1usBUdxmE48Wg8
	iv1hMJA0LaKc4/TUM0flcNT1MdJoAhOHbWH4M1/fAGUCCI1Ej6Ea1Mk4q8VOb/d9962HHvhdggj
	ULUZAP17QCVXIfuRos+pgmnTI2FAf1jsubPh+06yi6ovbBstPIG+nDPYBYgw==
X-Received: by 2002:a17:903:fa7:b0:2b2:680c:2193 with SMTP id d9443c01a7336-2b2d5a52b4bmr175610315ad.31.1776180310731;
        Tue, 14 Apr 2026 08:25:10 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2401:4900:ac12:a4a1:b77e:33f7:8c2a:3842])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b461d599a1sm58714765ad.0.2026.04.14.08.25.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 08:25:10 -0700 (PDT)
Date: Sun, 12 Apr 2026 22:15:42 +0530
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
To: David Lechner <dlechner@baylibre.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org
CC: kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_4/5=5D_iio=3A_ssp=5Fsensors=3A_us?=
 =?US-ASCII?Q?e_devm_APIs_for_mutex_and_IRQ_resources?=
User-Agent: Thunderbird for Android
In-Reply-To: <6479ec7b-a8b5-4154-8857-9e7c9af7ecc4@baylibre.com>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com> <20260406080852.2727453-5-sanjayembedded@gmail.com> <e7ac60dc-fcf6-4ed8-847a-dc29ecfca142@baylibre.com> <438F2B61-7F4D-4488-82D0-E1EE23FBF766@gmail.com> <6479ec7b-a8b5-4154-8857-9e7c9af7ecc4@baylibre.com>
Message-ID: <9E69501A-C05A-4B76-A766-5C55CD0478CA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12 April 2026 12:01:24=E2=80=AFam IST, David Lechner <dlechner@baylibre=
=2Ecom> wrote:
>On 4/11/26 6:35 AM, Sanjay Chitroda wrote:
>>=20
>>=20
>> Also, I observed that in remove() path, there is duplicate of following=
 with ssp_disable_wdt_timer():
>>=20
>> static void ssp_remove(struct spi_device *spi)
>> {
>>         =2E=2E=2E
>>         ssp_disable_wdt_timer(data);
>>=20
>>         =2E=2E=2E=2E
>>=20
>>         timer_delete_sync(&data->wdt_timer);
>>         cancel_work_sync(&data->work_wdt);
>>=20
>>         =2E=2E=2E
>> }
>>=20
>> static void ssp_disable_wdt_timer(data)(struct spi_device *spi)
>> {
>>         timer_delete_sync(&data->wdt_timer);
>>         cancel_work_sync(&data->work_wdt);
>> }
>>=20
>> At first glance looks redundant, do we require both ?
>
>No, this sounds like a double-free bug=2E
>

Hi David,

Thank you for your input=2E

I have created a change to drop duplicated wdt timer and work cleanup=2E W=
ill send changes in next series in few days=2E

