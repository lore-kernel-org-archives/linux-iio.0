Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EB535F19A
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999174; cv=none; b=gvL2f1+QPSKy5DUNWnQwGgDKWJPQmJYKdQGNmV4C1zeOdm15yLDjDMTiFY/kZj9djXaCJcrRa5oVJF4eqKSphgng5C8PKqXGVdWlGs+q0XXZJT1BV1QjHXrI1fmCsQqhDP1QnJSRg830cQAkvyGJTLN5+HTTTg2PK2+50p37EGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999174; c=relaxed/simple;
	bh=tqpllveE1TCdfBkjG5qxZyc+XJkW3yVqJZ0BRe92+ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiz3wBm/r+AL/+y9+lf0eeCmNbr2UYrFfxsy6GqNtQJPt7CXnyuHRyjPgySQve7PyfCqx8M3+CANpUpnJmsLh4KNJ8qfMtXx6WcLs5oiAXFFdITxsKtAwvE1rKygBrVj8vjXY1cemgEfPMpoDHXUm4mn53F3+vNImNEHGUDDi/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjpC2etS; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjpC2etS"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa6c66e6c5so3224522e87.2
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780999171; x=1781603971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CbGlbm349sPXsDxdYe2/wkkzZXDv3DztWFkPZAETkkg=;
        b=qjpC2etScZpehDLlsv33oGEzMGa1zgm+Y0z3yPPRilcEEXbeJumfWLwJL0UcTBmcZ8
         jGnNbiuhoe8HTasvm7d9g5j9bG8RE4zaPhir7R7ZNsLtdMmp+wtv0VOH/uPlolcuhCyv
         8PjwOkt6kt0PGv8cvZwj/P4Arv8UM9VXauccmur1jx0empERfQSJlXpzfwVi5hRRP39b
         9pyaweLRHJQKQVagUwnXdwFiZahcGQXGHyPVQUbTEOa+ghTaH5AUmY9Lkj1COfdor57H
         zX9/r3m/k4PNsORaZvoROP01XSCW69qw9a7F0+UvA9DcsJaTNOE4hEjpkS61/kBLND5x
         V+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780999171; x=1781603971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbGlbm349sPXsDxdYe2/wkkzZXDv3DztWFkPZAETkkg=;
        b=tWqgiSthVslWarJ3RqbmHHuXg01jhXuIiCE2+b5y+X0fWwbm3eIQSC8EFnaHn0xuQZ
         NFpxWLrx23fKH+s+ATdmTVBDrlvDEArXElMdG/jI1PZJ5f8QhZuv+5ikC0gRj83rVl1D
         wrD34yTGWzQo76OaXp171DWhTW2zkvUuBhkmvN+tdMYIrAeaSSNmLIhfarSHDl2ArKTh
         jNB1LLQ/qpHHQiWATKCuvf60b3L0kAYHZFiukfj/QFY78NXPZ1Ar5GKQBcdNcWcwiylE
         KGl//PcguMn7OB5boK5Nor7d1aaWEZavgaKQ+BPAu5kDn5JuHxDrBIskJKZPYyFbyBEU
         nTxA==
X-Forwarded-Encrypted: i=1; AFNElJ/2QHYBxbJ9jijtjRKYXUW3r5Kb123ZaOMkGX2KjKV0eiBJccVPXMxZomZSmPJjzME08K4ct0cuvgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN0sSW1e2tMOFEGMR9N4zV+WbK3BUcPLQ9fpqj5d5FUQ2GgjBy
	hsfb1lpgCHSbHH+gLMHD5y4Q4hOpxAbsz2mq/xBHVshuIIo2prBMgJ5svl4A55pQ
X-Gm-Gg: Acq92OEcvdS6EYzUyPmaJfp7g8z+/U/82wY+mZjRka8AoIO+E0WoVdMHF5myhMCKE8l
	fRgGZlC/X8rJAtbY50G487Gqz1hPiY272ohDhivd1GzAIYofZtXLrzCMgMKTm1leqDmFoD7P/ta
	SHkCVDlRKYgwY77pIsFnVzXpTx9pc3Om/iPqtvLK4NOxXCUmKd+65acHW3uX7isU0L/7YFZqjXJ
	m3EHDscER73kkBI1ZnsC9lZi0FwPJbyZFU2gQdZy/LgVd0dmgCgMoqo027hQIDh4lmfn2l99O4r
	R/h1uQexoZx0ePA0qufGfLGWy6rc+Ag8ZhECWdzurFcmUWNOF1X3RV5Z32q5AyCcy6czWKgj0ZS
	9axnF6nTPtP89JhizzlgGNvzgKzn8p2h/tJbAuI9Rthb0uko9ZY3t733t/BxLywxlb6wyrIDNO6
	zoW3+MLet5j2BkJ/5dQEQRMzL94NkNhNwLGKA1sZ8DuYGFoIBZh0b5vgsTr/b5bQJtxqwPNnIjc
	uZJRKZq3hEvEg5rWew=
X-Received: by 2002:a05:6512:3b9a:b0:5aa:6c7c:65d2 with SMTP id 2adb3069b0e04-5acf6be849amr663307e87.11.1780999170801;
        Tue, 09 Jun 2026 02:59:30 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9079f7sm4466364e87.37.2026.06.09.02.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 02:59:30 -0700 (PDT)
Message-ID: <29343d3a-38db-4f28-aed2-59e36d4354f8@gmail.com>
Date: Tue, 9 Jun 2026 12:59:29 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: bm1390: replace short msleeps with
 usleep_range
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Hungyu Lin <dennylin0707@gmail.com>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260607140018.59586-1-dennylin0707@gmail.com>
 <20260608184154.72a88788@jic23-huawei> <aieu-h2a1qqAzHnX@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <aieu-h2a1qqAzHnX@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/06/2026 09:13, Andy Shevchenko wrote:
> On Mon, Jun 08, 2026 at 06:41:54PM +0100, Jonathan Cameron wrote:
>> On Sun,  7 Jun 2026 14:00:18 +0000
>> Hungyu Lin <dennylin0707@gmail.com> wrote:
>>
>>> Replace msleep(1) with usleep_range(1000, 2000) for the
>>> driver's short delays.
>>>
>>> The BM1390 datasheet specifies a 1 ms reset cancel wait time
>>> (tSC1) during the power-on sequence. Use usleep_range() for
>>> these short delays, as it is more appropriate than msleep()
>>> and avoids unnecessarily long sleeps.
>>
>> Use fsleep() which has the added advantage of standardizing the
>> 'slack' so we don't have to thing about the values chosen
> 
> While true, msleep(1) is kinda idiomatic, we don't need to hunt subtle timing
> issues in case of switching to stricter fsleep(), which will most likely choose
> usleep_range() beneath. TL;DR: I do not see a value in this change.
> 

I don't see the value either, unless there is a real problem the patch 
author has encountered. If there is a real world problem this is solving 
- please state it. My stance on fsleep() Vs. msleep() in ASYNC probes 
can be read from discussion (bikeshedding) between me and Nuno ;)

https://lore.kernel.org/all/14a23df0e1828b72b8b03c358980fe08a12bb216.camel@gmail.com/

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
