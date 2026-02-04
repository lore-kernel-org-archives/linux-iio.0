Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2D387369
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770187847; cv=none; b=NC3gkJF8l8HPYR3o2uebYbFjB9bca6QplgP6E8TefGKWGqEJjERjk9BhkBgzUkyfBO2d7VPnLYstg4RIyr7FWB5z8RB7pLT4uZwiqQSzVhUOwsiHAPjPHMV5WSgIAbFR3731CopH0OsiHtwIlDXr8IB+yFeovQ3npunYMQcZ27M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770187847; c=relaxed/simple;
	bh=xituSWbsEZ4BZweKSQvvFmEBU4zfBKmTq3kEYnOPHE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gncii5OpPOAcNqIv2UVs21gV4NYBUXCcwIJtgErXs5ijGO6BHtb0A07bIfgTDJNsIIy4lyJBRlF3/7ztJk6Och7cQL51yXEoJxLQkNklyXm7kOAfT7C0rG7+QZFdOVFGmt4/XqqhESLUE/xT9wyfxUmFh5SAAYIpFp+b15JXrbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUkbtl23; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUkbtl23"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1248d27f293so2159108c88.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 22:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770187846; x=1770792646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNOk3gWmx5xUW3I0EzgX1jSF7wnHgmCaeb7qz++DoEA=;
        b=PUkbtl237DtBoXesI+IxyLcy5RFRCEPJkD76rse2GOwD5AnRXN32npxTKImRl3awnL
         Dc8+cyU7n7uGDh4HowwPL2P/zDZQoXyf0KyWQ6GHsHUF12QevOY9nDlqDvHgrklwG8UY
         hgL98eAJv9gk24GucFOKp9g813YHo3f6zOoI4uFsRfGsxqga1tm3h24YTpTpk1TBb59g
         PB9Cubl5pxoYB6SdrsmxrRw5YgZ1S1m8VgEc1W7Tz/QrUXL/FvhDLiMumz+hgjdyV4Va
         mBRYI7EfzGXbsCpk0VG1zsjnvKx25FpGKJlz/j6ZFws4KhbKiSrGrw91MqxF5u/M6fuN
         9Tbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770187846; x=1770792646;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNOk3gWmx5xUW3I0EzgX1jSF7wnHgmCaeb7qz++DoEA=;
        b=JnhBYHAxl8t5GpgKAD/7ueE5EIOKVdVtfpyF01KC5RLWlRsfJjt4XgjPTNvPZiS+Bw
         2+Mh0ht0XJKeTuDwG2bIqyS6IF5iqnBan8R2SoJIxdyBodHbiW02YecP+4bzsvldNiB+
         NpyOzrITzCTw4I18KxREENvGX+3HZCkcrzoDsR9/Vww+DzMUmQc73l1XnOtO3dwUxu3f
         Rtjz74Te0sjM2S2i8UbgNYyXeKpU0RPvpKbOn9LlDfjSa9f4t8g7iNLn1O8L9qsDGy02
         MYM0yP1SxlBTuIUi/vYt5wm+Gpe75tvLVt9yPu3dBb0m5sLkOMImtT6xQg5q5F9xMXbW
         3wKg==
X-Forwarded-Encrypted: i=1; AJvYcCW4/Uvs/JlFZBkQLiOcoC8gmgSLN6DaZ4Ko8PWqcGRNsqj4AE0xlUjzMm9dSNNLrHi+g6EZ2XmIQyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5bOHLlHhFKlb4ijmLdI+VazX1LNvTh5Klm6uk54E9+X1OLY/0
	mXapZvRQIvz9kcMwSeDwBkisHMwo6wBKMmZBQW7LqBay2VQBkNC5VKA6
X-Gm-Gg: AZuq6aIuUk6im932RbHUuWFm7LxJMoD4J/XNJ/7BAt1v47LosIS6pDdsoCerqSiifHl
	AfCm2wOL91tyU3s9xtNfHaZHacPB5kAN2V/CF9pIi2a8mLWLTApbiyL3s1IR+GGxEJKfob3H7f5
	I0n1tfg5agko82EzDWLsqXyGMs+ivtymYp6vQ4/p1k/MKLRQCVNPs3H972A+VXOZOEs90WInQAX
	RYb65xSy28IV9kpn2WnA5Onb73/zTD00Y2UnNtDwI0DuRcoxJXb9pIcDWyhFRrJfujjij/Hu9Km
	F2+4e3RnKMHxQwxThtCIIyeHQLFcAb0Mzz4bDqQ9VF/JPjoHp/RY6lOSVWpDS4fcqWnCw4VMtnV
	rmSlNN5WQ1pfztKB7xBvuPCixyWNi2ATJqPmrZfwFHtg4pdvgFEZQ50NBEoL6hRMMsQZ1HyncKf
	3UC8EyIY2YcLadjo1FGBdGDFPv8A==
X-Received: by 2002:a05:7022:61b:b0:119:e56b:c745 with SMTP id a92af1059eb24-126f4770fc5mr967588c88.10.1770187845996;
        Tue, 03 Feb 2026 22:50:45 -0800 (PST)
Received: from [192.168.0.61] ([76.174.137.141])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e111efsm1223877c88.8.2026.02.03.22.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 22:50:45 -0800 (PST)
Message-ID: <2f6c6070-96d5-4fe7-a237-f3278e372036@gmail.com>
Date: Tue, 3 Feb 2026 22:50:44 -0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] staging: iio: adt7316: convert magic numbers to BIT()
 and GENMASK()
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260130-adt7316-correct-macros-v1-0-8a71df1e42f1@gmail.com>
 <20260130-adt7316-correct-macros-v1-2-8a71df1e42f1@gmail.com>
 <20260131162140.5abb833b@jic23-huawei>
Content-Language: en-US
From: Michael Harris <michaelharriscode@gmail.com>
In-Reply-To: <20260131162140.5abb833b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/31/26 8:21 AM, Jonathan Cameron wrote:
> I've asked for a couple of different types of change in here. It is likely
> that some of them should be in separate patches.
> 
> Thanks,
> 
> Jonathan
Thank you for the detailed review. I am working on a v2 series to
address your feedback and will send it when ready.

Thanks,
Michael
