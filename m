Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD04038736D
	for <linux-iio@vger.kernel.org>; Mon,  2 Feb 2026 23:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770073642; cv=none; b=O4d/bnyYr6C7pBhM5z/qXDuSuKPtcwWN67D6ZOpsMjHK5n7Gq6ZxCVE+IRH5Xz7F7h3UmwTYVGt32hU2Rtl8FcwGDWTym1WgAsOMX2KGt8pQ0YuvNvxyAnId8+VyZo0Xf57xl+G07kE8z8fhfpk+b1usvIg5h00Dwa2po0L7Qjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770073642; c=relaxed/simple;
	bh=ku77Xk2obSr5S0hpCScaedfNXchWz+QP1fK0cf1Cpy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONVWAqaF4KlTyhDAMdQVRKtWX63sJ9znVUBAOpyHlvvYGx4R74htM7mGq81IvR0Mru7YGVd1vquhkysH06aM/DPNRpnF1N1SOdI93vKfgRPHaGmo7Ck2bIeCzY4UpDQizRD1dnW499FLKNaTabHk4uqRSCykubF8xUNyVP3GjXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O0rbZ7pE; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O0rbZ7pE"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40946982a78so1672897fac.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Feb 2026 15:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770073638; x=1770678438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDFJ9C0lQGp6d/APJAPHYfTfEZIYLAJJbOb43cDnTbM=;
        b=O0rbZ7pEbsy3hOYc6F5lZWaTwAgSCO6bvFFYIWg9TY/pT0SI7AMZNrcF0iHqLLpis6
         evjNqOKWDtUsnKdBfZCLRaaU6DT6wy+z7PDj1KLWonmq4bMq1m9dND18x2o2hpJyP7ox
         Jh9KWDqGfkiicCPuKmvawIzdm9JLOcLFK6Qb4b9XJxq7Bc5vDFRt6NSGt1ZeTDwseUJ7
         e9ZjNj1S7DDgCzGwJilwS4iW6OfRe8A+WUCT6HilK+dAYk3QAqAq2UNtAoCWxBw2mQRC
         H95NJzAH1e2WaN64yjLjg3TIlsnkf9vbXaQMAlUJuqSRB/PMir9tpbxfMJtzzdEGCRZ6
         tuhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770073638; x=1770678438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDFJ9C0lQGp6d/APJAPHYfTfEZIYLAJJbOb43cDnTbM=;
        b=iqB5CfD28foW2+afYpsrpJ2vC9DSDfIXCDR28WxmP7aQUFeRKnsdUZNo+nzo4kPw3d
         dt/gIVIhoTumeP8exa4nI5bKEgzLx3CUNTC3VtEeYhn7e38/JrqNl8Wfh+19pbCztIMu
         n/r0hkqfxPhImE3VzAtyPjP+IYBhnDgOIVktirDsFnNsCb76C//ViD2tUNeVE9X/8z92
         Ihjd02ERUlmjEXjlcVAiJbJ+KWH3L6aXgwFCdJxJfQ18nFSWqvgvokY6IFxqqlnM7exn
         v5VLw7JaK8FfYFuEhx4aOCBUIDew3yxyW91lkDkUaog0eHuXsclO8hsJYJugF1lHala7
         Ccgg==
X-Forwarded-Encrypted: i=1; AJvYcCV8rTCsjJcw/A7UpDS7pDel9RQwYLLnYct6xBsRGkXscciRAOP4WLi4WccYI8UdYgHRloAcKImsl0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfrq4+zABrXcnR9bfCe7sel8twrn1gruCPK0iokqob9AdD6UTm
	l0Hy2A8sJpQvCXwLhmY3nYh4KN02aDHTCVIe64aoe0z5hElM5/a0Jc4+AAL9KEDh9c8=
X-Gm-Gg: AZuq6aIH5OSiqeuivpGxQfGqQ546btwx++RoEfQvJBpugOAjRBlSu564Q+5B287vkFb
	lPH03Fl3tnCEOUNOivSfmXcT52hIxsc0WBOlchb87WyePPGgIj3XkkWudZ/UheaJVVdbiCtvMey
	GsCJU/mMf95I84HRWLVZd07Ku9TmXZblMYYBuyUMknFx/T4U3KOdwXXWk0gc9TI7Ch7q5ldlITb
	Vl7JdGwywlVBwjZ0NIlgkj5m8kWhFFfQX2ALQCKhXkH0j+Sze77seHpYBb8NLIo0rQWrei7uaEr
	si+qNustSmJv9I1pvuXVEdYbdJyBm0tqBH2Kfb5uHF4VjJPLn5Hn9tQEo/hQmxBez24gGUzT0vY
	Zl/lGQxO7udhrIzudpgqNTRJQIppJJa8DGB1wJXmr3BOK1B2hpukfFqrfFML2PFZAxlcr/w8wuY
	xWyfkpRDd/JICSq1xKsq9XlpXk0X5wdHTKx0ME5EbMvrgCZbIIOoQ70AFEhKKk
X-Received: by 2002:a05:6870:af4c:b0:3f9:b172:33e0 with SMTP id 586e51a60fabf-409a6a2071amr6164787fac.1.1770073638671;
        Mon, 02 Feb 2026 15:07:18 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:3695:6954:27c2:42ef? ([2600:8803:e7e4:500:3695:6954:27c2:42ef])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4095749f332sm12007423fac.11.2026.02.02.15.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 15:07:18 -0800 (PST)
Message-ID: <a5fa2f97-9ba3-4085-bfaf-a255d24a81f0@baylibre.com>
Date: Mon, 2 Feb 2026 17:07:17 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 next 4/5] iio: sca3000: manage device registration with
 devm helper
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
 andriy.shevchenko@intel.com
References: <20260202194033.627967-1-harshit.m.mogalapalli@oracle.com>
 <20260202194033.627967-5-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260202194033.627967-5-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/2/26 1:40 PM, Harshit Mogalapalli wrote:
> Convert the iio registration to use devm_* helpers so the probe no
> longer needs a separate cleanup path and remove callback can also drop
> the unregister. After this there is no need for having a remove
> callback, so remote it.
> 
> No functional change intended.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibe.com>
