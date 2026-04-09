Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6793DD51E
	for <linux-iio@vger.kernel.org>; Thu,  9 Apr 2026 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746916; cv=none; b=ZUEJZaPSPQftFPGFtnyfbYJ7yY1CUWBiYUIeufiK2NrR+/F5a8q4qAHwl4OC3evtFF27U4iEPGuQ4aBHlTpgnpHLgsP/3wMOX+ZpJ65kva2FUeUi1Mbjhr6xXvsIS8msklk7ifGR7hQLRjZDyaNKKZHOm3PfJJkTVBlqmxp7idM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746916; c=relaxed/simple;
	bh=49JPbInX6e9XfodU0RMLb4/oPnMVnWJJAi/4wJnR0qM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gE77IJdrRbh+vqkXsIY928meK1e1ceZaTTD1G0PDmGQTwDZlfgks4ynHq+IBbwmCfZR5c2XvxhPBeRnYXUKampzoSbuViEPjxIbAV3cs6xYUMz8e6DEbHthD0pO9qhWCIHfZEeqc5qmvlZBXQ/RYNX9r/FodvE4DRZK39b3aLU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=OAkyLdYm; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="OAkyLdYm"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7dbb6c072f1so928922a34.2
        for <linux-iio@vger.kernel.org>; Thu, 09 Apr 2026 08:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775746913; x=1776351713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=akLM0X3PLFuI91BU41cd1SoLC/8+P7T/tJbdPoa5nQk=;
        b=OAkyLdYm4ZVcvuaSkTpcYc2SD6pUz8+GtrjyUHqIUaOnTNL2gkI0DMutC/V+KMt3nd
         1CDIMNdBxGD8mnBsjDQDkHg2PwSXkLv8EZgvURA3CFLgOI2IMFZwo/rVYq3KPq2OdNyb
         yx7iomccrNfm9+qMlHBgOnFJuzaw5aRW2htWnNQlKG7m7Ws4CLClMH/XyoC1aLaApEWG
         9c8vvl4G5yvg71t9gesL0iPskxUlJaqbP55hiVkpM+sW6CRZxA6br7b9UJksWpJECsP+
         8hxMwNDQs0xDRo7GdeB+u/QX8vKBIvZrAYOyipw42bnaVmLsy8GyjPFkQIEM/UchZa8x
         knrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746913; x=1776351713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akLM0X3PLFuI91BU41cd1SoLC/8+P7T/tJbdPoa5nQk=;
        b=DVFCqtaMGnqTZniP8rc4138nUOn6TWcCMlEJ/9AD3Fx5NbCWlVfr2fS5mIM9wrmnfM
         JGWr9YTKeVl3nkhR6HALbkaUOMxzTr07PGk3TT1NYGD0Q8NM82FHSfjpZJudAb5SYGCW
         18+6C0SLxdqlXIwbmVjiqVgWmhau4/uX12pSC8OwHKejiAhyArK8l8c/qVOqlZuIJQij
         MLjO073Bd+9hOPDjAjhD+vlceR+tDYOoXzTKIgEhYcCdr9NediJJ6PhcKhZonuyzxgj1
         RstVNQw/iYcthLTm6ML2qGggeyL/vCVmgGRuG3pKShxNwFY8uej+pB7hMWVwtNRXaYdN
         dz4g==
X-Forwarded-Encrypted: i=1; AJvYcCUruOt9h1jXjjsb1imfmM1Q5hrOcmXfcEawAP34RoF1zrSUc3cv2iktwpYjYkh94BW9kYGWhGmcVXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlHeMrJaHfI0weelrCe2j8zZw3DsbR5uYyyMkDD3J4awlJ6H7O
	QWdfbOKx+thUJ+RPdm4W/P72+qXFgvgtcUL5w8CRk/yr4k8U50i5Oxzy6dEHx6jBuWWDSVPeKd8
	ZUXGV
X-Gm-Gg: AeBDietHHXWY9PAuqnb6wggrnhwirdhgV+w6nwVjzodGFPmr1x++qDtWa5lhqgf0gnj
	3RjLgnKm3vRdNfm0JGlhCKHmAmAgHNuiTK00HMM4Vdss7B+i8hLd6VKTvzOgbDhrkEB3wl1yJF6
	XrPz2/724FrvemnRI3ZPbbs52tFq0khrFJLDOSeyRSqBfHJ4BxNDGP3PpR8+xrdfBraJjHSs+wR
	lA4nUQf/p88b9brRJhn9AbaVoi6O1uwddauFan+POEUaa0/Qhv2YmKAh37zNcu2Rx+HY//oRXD2
	MrWI7uj6CeaVITIC4i4DMWDY0Ddbga/GM0ECltJDuOO8erSDHiaabi45HtGeRT0sct05UjuE5wH
	/5MJNAdci6BCw7aDqCZYVxZt98ia+HVhqi+MD0adTXAk4q+LeoCJDGCzQmmlDBltoxe84n+VBJF
	KS8or1ag8eqtxNnK2nO5uSYlcTQnoWnHSQlXJU0dMKm17bqazmtWQ23PNEgI+MX8V0GGsvLAwPG
	s5ucLlyaN7q
X-Received: by 2002:a05:6820:3081:b0:686:d107:2865 with SMTP id 006d021491bc7-686d1073828mr8160295eaf.59.1775746904792;
        Thu, 09 Apr 2026 08:01:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a548:cf0c:d054:fd01? ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-682ba3cbe72sm10674670eaf.11.2026.04.09.08.01.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:01:44 -0700 (PDT)
Message-ID: <84e57bae-358b-43f6-9455-ee6c84b576cb@baylibre.com>
Date: Thu, 9 Apr 2026 10:01:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iio: pressure: bmp280: fix stack leak in bmp580
 trigger handler
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, stable <stable@kernel.org>
References: <2026040947-overhang-fax-02d0@gregkh>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <2026040947-overhang-fax-02d0@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/26 8:40 AM, Greg Kroah-Hartman wrote:
> bmp580_trigger_handler() declares its scan buffer on the stack without
> an initializer and then memcpy()s 3 bytes of 24-bit sensor data into
> each 4-byte __le32 field.  The high byte of comp_temp and comp_press is
> left uninitialized, and the channel storagebits is 32, so two bytes of
> stack are pushed to userspace per scan.
> 
> This is a regression from when the buffer lived in the private data, the
> move to a stack-local struct dropped the implicit zeroing.
> bme280_trigger_handler() was fixed up to handle this bug, but this
> driver was not fixed because there was no padding hole, but rather a
> short-fill issue.
> 
> Fix this all by just zero-initializing the structure on the stack.
> 

Reviewed-by: David Lechner <dlechner@baylibre.com>
