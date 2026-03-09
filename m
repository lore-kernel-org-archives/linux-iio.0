Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A701F1F7569
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 20:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086611; cv=none; b=YJHhfvmsxOtkKMOVIfoWBDE+Y9NIg6lgqkfqyTQ4CWfnoP+iVCp/Ed+YLqMwqiDqduipkIrEKi1QseR2S9glaT1geBQK4nPzigEJkhrySvJ3k1SJZVY0zrkEeZxfVdwygai0GDUiDRDz6zzjj7sZO7Lj5tiDGD0+iN/gxYpJJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086611; c=relaxed/simple;
	bh=d0fCghyNV8rp+g2+khLk8Cy30JaHTgJeyNBIyZbUMuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWmLo/NRUzAhdUa6JgecTpRvrhM2IJNSZM1IO7gMqdWJ73bk0cAeyEBruQaeQJJDoVzH6s4ZYGdX5/nU3MiVZVPLLgbCS+xbwYVRP1kc/okklXbEjeitz+UyDr+nQqhtJ40C3wwUtC5u57lnt+Xc9YKTqihxWBtUzlzmRcm7Y1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0A+F3otS; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0A+F3otS"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-46704fbf62dso882464b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773086606; x=1773691406; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8W/YTanhg6fGp0i4AO/4BHQaLQr24p5MziO84ANLcx0=;
        b=0A+F3otS13Lk2k02f2cPikA8IakmHE5Yz69/hMYHsFFivowMwgQi4bjeRu4ude7PQD
         wuJwhM9J3SrBRngdgc3HCb2cC3Qf7FeTeJOF+7ftjE8y8VLQsQArPrOtac39QaypgUpL
         FEBExPvSjyYt9KMVUiTsfuXYEWSQPoU6URCD7/Oa0xGp/2Af8HDAkbaqGkSq1O/bXr7I
         lOW5fpj75A5Zy4MMfY77khLxPsR2ulbMoJruWOy2Xw//Y/+pr12J1gZPn+Lb9ysHhqEQ
         Rb9fR07s8Kg8vfuSr/l37+VMruHWmw62ABEzUf4qHAyABvj9dQE90brXqnCWNIia9s9A
         xt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773086606; x=1773691406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8W/YTanhg6fGp0i4AO/4BHQaLQr24p5MziO84ANLcx0=;
        b=M0jMQAJpsDvNcrU1OacTehB/zosuWRF2fncDGF+8VD9zXtj+t+/TgsdmPRHQhoYouA
         XJPd/9lwEX49FtRrPZa8r045hCOdssrpEX0WyKZNi3Fh3hHclA8OCYhZKFDPHL0gN7vN
         NXRKO18KAMGeLS9j7dyJbB0XpS2NG6lCo8lzANKRamKknLSeD0XRx98AnfGec7cQ3dzz
         9t71uAaApaN5kbl5XB22FqaXJn9+5OaRL6DLSJ7wd/SlEi3EsbuRmnAIo8jCxn8wtcrg
         slgHUGnxVSMk236uGrzeX8IRC4iseBRsgGJdfq4OpZHFM8C1jGHvxnw1ty6NDtcm+yLa
         ZusQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDOE3m7KIicZQGM0KxTBOUdQS7Bo+o2ADS4fSamvm+agwaAv6vJb9cyIxRgi7Nv93AeozH72AG1VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPAI6XWWttm/+8mo9QupfwkVoH+Km3/3+9vpD7ubKkPoZrDfbK
	ZqQNIZpqzgBYNcp8xnbCaxBwRe+LJpl6pIuL4uFkBPtBKAABDw2hj1OMYTZix59c9J8=
X-Gm-Gg: ATEYQzwBtZvI6TTWX/fzMqVZ78Zf0hb/LxIzJcxFJR1oXcxGqjVihbt0vbD4EnHHQxo
	OK8yH28Nxp3EnRxJWc4M1DRxlUcRvxkOK45cAcwGWBEORBoS0kcrYaRHqRnUG6CwgZ91CBLvSaZ
	If7iF3501c9Xnbp5ikFG4Y16ITzFh0wGPZxXM2/If7OM+OikjXcq1z6PHJKZyZtqPHg72hXB8jG
	SiSJ6CTMO6ZksWB1exoWE/4Y69Swwur+VqBTXv7Gmt+yShLCUGz4B4hJ0qxHZ3p4fVcUpMzvnCF
	WJuQ5p+NrIGa/6cuZ+T94s4Hv9t8MmwZKHX71hyZvVOcP7lMbdRz+V/7pBTn3onFGLoD3zlfyyO
	iPPA4bmbHutvx6t2QJ+4UYzNCU9uk5KB+QWf/TOyBcmQGb795AxyFuuYEW8ZyLI+xY//S9Bl7f8
	WE1KyVmCsA/wIPQA1mIBGu2sKVoVYP+8j6T6Gusb/fThy6EJOG0e7eZ1hhNIni+Raq5Hv8
X-Received: by 2002:a05:6808:191b:b0:463:d796:ac96 with SMTP id 5614622812f47-466dca6eab1mr6702179b6e.21.1773086606474;
        Mon, 09 Mar 2026 13:03:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:77:c35f:9c1b:c75f? ([2600:8803:e7e4:500:77:c35f:9c1b:c75f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466ebbd7243sm4819487b6e.3.2026.03.09.13.03.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 13:03:25 -0700 (PDT)
Message-ID: <b1aa81e6-ec3f-45cd-84db-e26c465ae267@baylibre.com>
Date: Mon, 9 Mar 2026 15:03:23 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: accel: sca3000: convert to guard(mutex)
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: nuno.sa@analog.com, andy@kernel.org, waqar.hameed@axis.com,
 linusw@kernel.org, sakari.ailus@linux.intel.com,
 harshit.m.mogalapalli@oracle.com, antoniu.miclaus@analog.com,
 andrew.ijano@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
 <20260309153408.71512-5-rajveer.chaudhari.linux@gmail.com>
 <20260309193010.104159cb@jic23-huawei>
 <CANS1UbiJgvbbzOAbi1TM5=N-Gj-LQoOFRyBUf06qkZRY3zw+Sw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CANS1UbiJgvbbzOAbi1TM5=N-Gj-LQoOFRyBUf06qkZRY3zw+Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/26 2:58 PM, Rajveer Chaudhari wrote:
> Hello Jonathan,
> 
> Thanks for the review, I will add all of your suggested return path,
> indentation fixes in v3.
> 
> But I have a question, should I submit the next version of patch right
> now as you reviewed
> the whole patch, or wait for 24 hrs as instructed by Andy Shevchenko
> to let others
> have a chance to comment, review.

Waiting even longer than 24 hours is better. Not everyone has time to
review every day. Ideally, wait 1 week between revisions. If it is something
urgent, it can be sooner. Converting things to guard() is certainly not
urgent.

